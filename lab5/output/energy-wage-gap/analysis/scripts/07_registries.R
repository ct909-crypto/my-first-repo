# 07_registries.R — results registry (one row per planned spec) and figure registry.
# Inputs : analysis/spec-registry.csv, analysis/output/main-contrasts.csv,
#          tables/table3-decomposition.csv, analysis/output/d2-change.csv,
#          tables/tableA3-robustness.csv, analysis/output/tech-by-year.csv,
#          analysis/output/major-group-gaps.csv, figures/*
# Outputs: tables/results-registry.csv, figures/figure-registry.csv
source("analysis/scripts/00_functions.R")
spec <- read.csv("analysis/spec-registry.csv", stringsAsFactors = FALSE)
res <- read.csv("analysis/output/main-contrasts.csv")
t3 <- read.csv("tables/table3-decomposition.csv")
d2 <- read.csv("analysis/output/d2-change.csv")
rob <- read.csv("tables/tableA3-robustness.csv")
ty <- read.csv("analysis/output/tech-by-year.csv")
mg <- read.csv("analysis/output/major-group-gaps.csv")

pick <- function(sid, contrast_pattern) {
  r <- res[res$spec_id == sid & grepl(contrast_pattern, res$contrast), ][1, ]
  data.frame(estimate = r$estimate, std_error = r$se, ci_low = r$ci_low, ci_high = r$ci_high,
             p_value = ifelse(is.na(r$p_wcr), r$p_cr1, r$p_wcr), n = r$nobs,
             focal_term = r$contrast, source_artifact = "analysis/output/main-contrasts.csv")
}
rows <- lapply(spec$spec_id, function(sid) {
  out <- switch(sid,
    S01 = pick("S01", "raw"), S02 = pick("S02", "occupation FE"), S03 = pick("S03", "pooled"),
    S04 = pick("S04", "Solar vs fossil"), S05 = pick("S05", "Blue-collar minus"),
    S06 = { r <- mg[which.min(mg$Estimate), ]; data.frame(estimate = r$Estimate, std_error = r$Std..Error, ci_low = r$Estimate - 1.96 * r$Std..Error, ci_high = r$Estimate + 1.96 * r$Std..Error, p_value = r$Pr...t.., n = NA, focal_term = paste("largest major-group gap:", r$term), source_artifact = "analysis/output/major-group-gaps.csv") },
    S07 = pick("S07", "2025 minus 2021"),
    S08 = { r <- ty[grepl("Solar:2025", ty$term), ][1, ]; data.frame(estimate = r$Estimate, std_error = r$Std..Error, ci_low = r$Estimate - 1.96 * r$Std..Error, ci_high = r$Estimate + 1.96 * r$Std..Error, p_value = r$Pr...t.., n = NA, focal_term = r$term, source_artifact = "analysis/output/tech-by-year.csv") },
    S09 = { r <- t3[grepl("that year", t3$support) & t3$year == 2025, ]; data.frame(estimate = r$within, std_error = NA, ci_low = r$within_lo, ci_high = r$within_hi, p_value = NA, n = r$n_common, focal_term = "within-occupation gap 2025 (Kitagawa)", source_artifact = "tables/table3-decomposition.csv") },
    S10 = { r <- t3[grepl("all five", t3$support) & t3$year == 2025, ]; data.frame(estimate = r$within, std_error = NA, ci_low = NA, ci_high = NA, p_value = NA, n = r$n_common, focal_term = "within gap 2025, strict support", source_artifact = "tables/table3-decomposition.csv") },
    S11 = data.frame(estimate = d2$change, std_error = NA, ci_low = d2$within_change_ci_low, ci_high = d2$within_change_ci_high, p_value = NA, n = d2$n_continuing, focal_term = "change in within gap 2025 minus 2021", source_artifact = "analysis/output/d2-change.csv"),
    { r <- rob[rob$spec_id == sid, ][1, ]; data.frame(estimate = r$estimate, std_error = r$se, ci_low = r$ci_low, ci_high = r$ci_high, p_value = r$p_cr1, n = r$nobs, focal_term = r$check, source_artifact = "tables/tableA3-robustness.csv") })
  cbind(spec_id = sid, model_id = spec$model_id[spec$spec_id == sid], hypothesis_ids = spec$hypothesis_ids[spec$spec_id == sid], out, status = "executed")
})
reg <- do.call(rbind, rows)
# T08 output_registry
stopifnot(setequal(reg$spec_id, spec$spec_id), all(is.finite(reg$estimate)))
write.csv(reg, "tables/results-registry.csv", row.names = FALSE)

figs <- data.frame(
  figure_id = c("fig1", "fig2", "fig3", "figA1"),
  path_pdf = c("figures/fig1-gap-trend.pdf", "figures/fig2-technology.pdf", "figures/fig3-occupation.pdf", "figures/figA1-robustness.pdf"),
  path_png = c("figures/fig1-gap-trend.png", "figures/fig2-technology.png", "figures/fig3-occupation.png", "figures/figA1-robustness.png"),
  spec_ids = c("S07;S09;S03", "S04;S08", "S05;S06", paste(grep("^R", spec$spec_id, value = TRUE), collapse = ";")),
  producer = "analysis/scripts/06_figures.R", placement = c("main", "main", "main", "appendix"))
stopifnot(all(file.exists(figs$path_pdf)), all(file.exists(figs$path_png)))
write.csv(figs, "figures/figure-registry.csv", row.names = FALSE)
cat("results registry rows:", nrow(reg), "\n")
