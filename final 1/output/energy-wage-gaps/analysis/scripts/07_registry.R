# 07_registry.R
# Write tables/results-registry.csv (exactly one row per planned spec S01-S20),
# tables/model-fit-stats.csv, and figures/figure-registry.csv.
# Multi-term specs report one focal term chosen by a fixed rule (see `focal_rule`);
# all terms remain in the linked output file. Run from the project root.

suppressPackageStartupMessages(library(data.table))

spec <- fread(file.path("analysis", "spec-registry.csv"))
est <- fread(file.path("analysis", "outputs", "main-model-estimates.csv"))
rob <- fread(file.path("tables", "tableA1-robustness.csv"))
dec <- fread(file.path("tables", "table4-decomposition.csv"))

row_from <- function(sid, d, tm, rule, file) {
  r <- d[spec_id == sid & term == tm]
  stopifnot(nrow(r) == 1L)
  data.table(spec_id = sid, predictor = tm, estimate = r$estimate,
             std_error = r$std_error, p_value = r$p_value, n = r$n,
             pct_gap = 100 * (exp(r$estimate) - 1), focal_rule = rule, output_file = file)
}
main_file <- "analysis/outputs/main-model-estimates.csv"
rob_file <- "tables/tableA1-robustness.csv"
reg <- rbindlist(list(
  row_from("S01", est, "renewable", "single focal term", main_file),
  row_from("S02", est, "renewable", "single focal term", main_file),
  row_from("S03", est, "renewable", "single focal term", main_file),
  row_from("S04", est, "generation_source::Solar", "largest renewable source by employment (solar); all sources in output file", main_file),
  row_from("S05", est, "occupational_group::Production and transportation:renewable", "plant-operations category named in H4; all categories in output file", main_file),
  row_from("S06", est, "year::2025:renewable", "final survey year; all years in output file", main_file),
  row_from("S07", est, "renewable:trend", "trend term tests H5", main_file),
  row_from("S09", est, "renewable", "single focal term", main_file),
  row_from("S10", est, "renewable", "single focal term", main_file)
))

# S08: pooled within-occupation component with bootstrap SE (normal p-value)
pooled <- dec[year == "2021-2025 average"]
stopifnot(nrow(pooled) == 1L)
z <- pooled$within_occupation / pooled$within_occupation_se
cells <- fread(file.path("data", "processed", "oews-generation-cells.csv"))
reg <- rbind(reg, data.table(
  spec_id = "S08", predictor = "within-occupation component (2021-2025 average)",
  estimate = pooled$within_occupation, std_error = pooled$within_occupation_se,
  p_value = 2 * pnorm(-abs(z)), n = sum(cells$analytic),
  pct_gap = 100 * (exp(pooled$within_occupation) - 1),
  focal_rule = "within-occupation component of raw gap; composition and non-overlap terms in output file",
  output_file = "tables/table4-decomposition.csv"))

# Robustness: S11-S18 single term; S19 the variant closest to zero; S20 year 2025
for (s in sprintf("S%02d", 11:18)) {
  r <- rob[spec_id == s]
  stopifnot(nrow(r) == 1L)
  reg <- rbind(reg, data.table(spec_id = s, predictor = "renewable", estimate = r$estimate,
                               std_error = r$std_error, p_value = r$p_value, n = r$n,
                               pct_gap = r$pct_gap, focal_rule = "single focal term",
                               output_file = rob_file))
}
r19 <- rob[spec_id == "S19"][which.min(abs(estimate))]
reg <- rbind(reg, data.table(spec_id = "S19", predictor = paste0("renewable (", r19$variant, ")"),
                             estimate = r19$estimate, std_error = r19$std_error,
                             p_value = r19$p_value, n = r19$n, pct_gap = r19$pct_gap,
                             focal_rule = "leave-one-out variant closest to zero (most conservative); all five in output file",
                             output_file = rob_file))
r20 <- rob[spec_id == "S20" & term == "year::2025:renewable"]
reg <- rbind(reg, data.table(spec_id = "S20", predictor = "year::2025:renewable (balanced set)",
                             estimate = r20$estimate, std_error = r20$std_error,
                             p_value = r20$p_value, n = r20$n, pct_gap = r20$pct_gap,
                             focal_rule = "final survey year on balanced set; all years in output file",
                             output_file = rob_file))

reg <- merge(spec[, .(spec_id, model_id, outcome)], reg, by = "spec_id")
reg[, status := "completed"]
setcolorder(reg, c("spec_id", "model_id", "outcome", "predictor", "estimate", "std_error",
                   "p_value", "n", "status", "output_file", "pct_gap", "focal_rule"))
# T6 output_registry: exactly one row per planned spec
stopifnot(nrow(reg) == nrow(spec), setequal(reg$spec_id, spec$spec_id), !anyDuplicated(reg$spec_id))
stopifnot(all(reg$std_error >= 0), all(reg$p_value >= 0 & reg$p_value <= 1), all(reg$n > 0))
fwrite(reg[order(spec_id)], file.path("tables", "results-registry.csv"), scipen = 999)

# Model fit statistics (one row per spec)
fits <- rbind(fread(file.path("analysis", "outputs", "fit-stats-main.csv")),
              fread(file.path("analysis", "outputs", "fit-stats-robustness.csv")), fill = TRUE)
# S08 is a decomposition, not a regression; report the share of cell-level log-wage
# variance explained by detailed occupation x year (composition benchmark).
a <- cells[analytic == TRUE]
occ_r2 <- summary(lm(log_real_hmean ~ interaction(occ_code, year, drop = TRUE), data = a, weights = emp))$r.squared
fits <- rbind(fits, data.table(spec_id = "S08", status = "focal", n = sum(cells$analytic),
                               r_squared = occ_r2,
                               note = "R-squared of log wage on occupation x year (composition benchmark); decomposition has no model fit"),
              fill = TRUE)
stopifnot(setequal(fits$spec_id, spec$spec_id))
fwrite(fits[order(spec_id)], file.path("tables", "model-fit-stats.csv"))

figs <- data.table(
  figure_id = c("F1", "F2", "F3", "F4"),
  path = c("figures/fig1-wage-by-source-year.pdf", "figures/fig2-source-gaps.pdf",
           "figures/fig3-gap-by-year.pdf", "figures/fig4-gap-by-occupation-group.pdf"),
  source_script = c("analysis/scripts/02_descriptives.R", rep("analysis/scripts/06_figures.R", 3)),
  status = "completed",
  description = c("Employment-weighted mean real hourly wage by generation technology and year",
                  "Within-occupation wage differences of each generation technology relative to fossil fuel (S04)",
                  "Renewable vs. non-renewable wage gap by year: within occupation (S06) and raw (S08)",
                  "Within-occupation renewable wage gap by broad occupation category (S05)"))
figs_png <- copy(figs)[, `:=`(figure_id = paste0(figure_id, "-png"),
                               path = sub("\\.pdf$", ".png", path),
                               description = paste(description, "(PNG copy)"))]
figs <- rbind(figs, figs_png)
stopifnot(all(file.exists(figs$path)))
fwrite(figs, file.path("figures", "figure-registry.csv"))
print(reg[, .(spec_id, predictor, estimate, std_error, pct_gap, n)])
