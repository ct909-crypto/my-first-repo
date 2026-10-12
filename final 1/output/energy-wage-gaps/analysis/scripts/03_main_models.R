# 03_main_models.R
# Estimate planned specs S01-S07, S09, S10 (employment-weighted least squares
# with fixed effects; SE clustered by detailed occupation), export the main
# regression tables with modelsummary, and record estimates, fit statistics,
# and joint Wald tests. Run from the project root.

suppressPackageStartupMessages({
  library(data.table)
  library(fixest)
  library(modelsummary)
  library(jsonlite)
})

# Make HTML table output byte-reproducible: tinytable assigns random element IDs,
# so replace them with sequential IDs after writing (content is unchanged).
normalize_html_ids <- function(path) {
  x <- readLines(path, warn = FALSE)
  ids <- unique(unlist(regmatches(x, gregexpr("(tinytable(_css)?|tableFns)_[a-z0-9]{20}", x))))
  for (k in seq_along(ids)) {
    x <- gsub(ids[k], sprintf("%s_id%03d", sub("_[a-z0-9]{20}$", "", ids[k]), k), x, fixed = TRUE)
  }
  writeLines(x, path)
}

cells <- fread(file.path("data", "processed", "oews-generation-cells.csv"),
               colClasses = list(character = c("naics", "occ_code")))
a <- cells[analytic == TRUE]
source_order <- c("Fossil fuel", "Nuclear", "Hydroelectric", "Solar", "Wind",
                  "Geothermal", "Biomass")
group_order <- c("Management, business, and financial", "Professional and technical",
                 "Office, sales, and service",
                 "Construction, installation, maintenance, and repair",
                 "Production and transportation")
a[, generation_source := factor(generation_source, levels = source_order)]
a[, occupational_group := factor(occupational_group, levels = group_order)]
a[, trend := year - 2021L]
dir.create(file.path("analysis", "outputs"), showWarnings = FALSE, recursive = TRUE)

cl <- ~occ_code
m <- list()
m$S01 <- feols(log_real_hmean ~ renewable | year, a, weights = ~emp, cluster = cl)
m$S02 <- feols(log_real_hmean ~ renewable | occ_code + year, a, weights = ~emp, cluster = cl)
m$S03 <- feols(log_real_hmean ~ renewable | occ_code^year, a, weights = ~emp, cluster = cl)
m$S04 <- feols(log_real_hmean ~ i(generation_source, ref = "Fossil fuel") | occ_code^year,
               a, weights = ~emp, cluster = cl)
m$S05 <- feols(log_real_hmean ~ i(occupational_group, renewable) | occ_code^year,
               a, weights = ~emp, cluster = cl)
m$S06 <- feols(log_real_hmean ~ i(year, renewable) | occ_code^year,
               a, weights = ~emp, cluster = cl)
m$S07 <- feols(log_real_hmean ~ renewable + renewable:trend | occ_code^year,
               a, weights = ~emp, cluster = cl)
m$S09 <- feols(log_real_p10 ~ renewable | occ_code^year, a, weights = ~emp, cluster = cl)
m$S10 <- feols(log_real_p90 ~ renewable | occ_code^year, a, weights = ~emp, cluster = cl)

# Equality (joint Wald) tests for the interaction blocks: re-parameterize with a
# reference category so the interaction terms measure departures from it.
m_eq_group <- feols(log_real_hmean ~ renewable +
                      i(occupational_group, renewable, ref = group_order[1]) | occ_code^year,
                    a, weights = ~emp, cluster = cl)
m_eq_year <- feols(log_real_hmean ~ renewable + i(year, renewable, ref = 2021) | occ_code^year,
                   a, weights = ~emp, cluster = cl)
w_group <- wald(m_eq_group, keep = "occupational_group::", print = FALSE)
w_year <- wald(m_eq_year, keep = "year::", print = FALSE)
joint <- list(joint_tests = list(
  list(spec_id = "S05", interaction_terms = names(coef(m_eq_group))[grepl("occupational_group::", names(coef(m_eq_group)))],
       method = "joint_wald_test", test_statistic = unname(w_group$stat), df = unname(w_group$df1),
       p_value = unname(w_group$p),
       hypothesis = "renewable gap equal across the five broad occupation categories",
       interpretation = ifelse(w_group$p < 0.05, "joint reject", "joint fail to reject")),
  list(spec_id = "S06", interaction_terms = names(coef(m_eq_year))[grepl("year::", names(coef(m_eq_year)))],
       method = "joint_wald_test", test_statistic = unname(w_year$stat), df = unname(w_year$df1),
       p_value = unname(w_year$p),
       hypothesis = "renewable gap equal in all five survey years",
       interpretation = ifelse(w_year$p < 0.05, "joint reject", "joint fail to reject"))
))
write_json(joint, file.path("analysis", "joint-tests.json"), auto_unbox = TRUE, pretty = TRUE, digits = NA)

# Tidy estimates for every model term
tidy_one <- function(spec, fit) {
  ct <- coeftable(fit)
  ci <- confint(fit)
  data.table(spec_id = spec, term = rownames(ct), estimate = ct[, 1], std_error = ct[, 2],
             t_value = ct[, 3], p_value = ct[, 4], conf_low = ci[, 1], conf_high = ci[, 2],
             pct_gap = 100 * (exp(ct[, 1]) - 1), n = nobs(fit),
             n_clusters = unname(fitstat(fit, "g")[[1]]))
}
est <- rbindlist(Map(tidy_one, names(m), m))
fwrite(est, file.path("analysis", "outputs", "main-model-estimates.csv"))

# Identifying cells: occupation-years with both renewable and non-renewable cells
ident <- a[, .(mixed = uniqueN(renewable) == 2L), by = .(occ_code, year)]
ident_summary <- data.table(
  occupation_years = nrow(ident), mixed_occupation_years = sum(ident$mixed),
  cells_in_mixed_groups = nrow(a[ident[mixed == TRUE], on = .(occ_code, year), nomatch = 0L]),
  analytic_cells = nrow(a))
fwrite(ident_summary, file.path("analysis", "outputs", "identifying-cells.csv"))

# Standard-error sensitivity for the headline (S03) and source (S04) models:
# cluster by industry-year (35 clusters) and two-way by occupation and industry-year.
a[, industry_year := paste(naics, year, sep = "_")]
se_rows <- rbindlist(lapply(c("S03", "S04"), function(s) {
  fit <- m[[s]]
  alt <- list(occupation = ~occ_code, industry_year = ~industry_year,
              twoway = ~occ_code + industry_year)
  rbindlist(lapply(names(alt), function(k) {
    ct <- coeftable(summary(fit, cluster = alt[[k]]))
    data.table(spec_id = s, clustering = k, term = rownames(ct),
               estimate = ct[, 1], std_error = ct[, 2], p_value = ct[, 4])
  }))
}))
fwrite(se_rows, file.path("analysis", "outputs", "se-sensitivity.csv"))

# Identifying comparisons by source: cells in occupation-years that also contain fossil fuel
fossil_oy <- unique(a[generation_source == "Fossil fuel", .(occ_code, year)])
ident_source <- a[fossil_oy, on = .(occ_code, year), nomatch = 0L][
  , .(cells_sharing_occupation_year_with_fossil = .N), by = generation_source]
fwrite(ident_source, file.path("analysis", "outputs", "identifying-cells-by-source.csv"))

# Fit statistics (one row per estimated spec)
fit_row <- function(spec, fit, status) {
  data.table(spec_id = spec, status = status, n = nobs(fit),
             r_squared = unname(fitstat(fit, "r2")[[1]]),
             adj_r_squared = unname(fitstat(fit, "ar2")[[1]]),
             within_r_squared = if (length(fit$fixef_vars)) unname(fitstat(fit, "wr2")[[1]]) else NA_real_,
             aic = AIC(fit), bic = BIC(fit))
}
status_of <- c(S01 = "focal", S02 = "focal", S03 = "focal", S04 = "focal", S05 = "focal",
               S06 = "focal", S07 = "focal", S09 = "sensitivity", S10 = "sensitivity")
fits <- rbindlist(Map(fit_row, names(m), m, status_of[names(m)]))
fwrite(fits, file.path("analysis", "outputs", "fit-stats-main.csv"))
saveRDS(m, file.path("analysis", "outputs", "main-models.rds"))

# Publication tables (reader-facing labels from data/variable-dictionary.csv)
gm <- list(
  list(raw = "nobs", clean = "Cells (N)", fmt = 0),
  list(raw = "r.squared", clean = "R-squared", fmt = 3),
  list(raw = "r2.within", clean = "Within R-squared", fmt = 3),
  list(raw = "FE: year", clean = "Year fixed effects", fmt = 0),
  list(raw = "FE: occ_code", clean = "Occupation fixed effects", fmt = 0),
  list(raw = "FE: occ_code^year", clean = "Occupation-by-year fixed effects", fmt = 0)
)
table2_models <- list(
  "Model 1" = m$S01, "Model 2" = m$S02, "Model 3" = m$S03,
  "Model 4 (P10)" = m$S09, "Model 5 (P90)" = m$S10)
modelsummary(
  table2_models,
  coef_map = c(renewable = "Renewable generation industry"),
  gof_map = gm, stars = c("*" = 0.05, "**" = 0.01, "***" = 0.001),
  fmt = 3, statistic = "({std.error})",
  title = "Table 2. Renewable versus non-renewable hourly wage gaps in electric power generation, May 2021-May 2025",
  notes = c("Outcome: log real mean hourly wage (May 2025 dollars) for Models 1-3; log real 10th (Model 4) and 90th (Model 5) percentile hourly wages.",
            "Unit: detailed occupation x six-digit generation industry x year cell; weights: cell employment. Standard errors clustered by detailed occupation in parentheses.",
            "Renewable = hydroelectric, solar, wind, geothermal, biomass; reference = fossil fuel and nuclear. Model 5 excludes cells with 90th-percentile wages at or above $100 nominal."),
  output = file.path("tables", "table2-main-regression.html"))
normalize_html_ids(file.path("tables", "table2-main-regression.html"))

source_labels <- setNames(paste0(source_order[-1], " (vs. fossil fuel)"),
                          paste0("generation_source::", source_order[-1]))
group_labels <- setNames(paste0("Renewable x ", group_order),
                         paste0("occupational_group::", group_order, ":renewable"))
year_labels <- setNames(paste0("Renewable x ", 2021:2025), paste0("year::", 2021:2025, ":renewable"))
modelsummary(
  list("Model 6 (sources)" = m$S04, "Model 7 (occupation groups)" = m$S05,
       "Model 8 (years)" = m$S06, "Model 9 (trend)" = m$S07),
  coef_map = c(source_labels, group_labels, year_labels,
               renewable = "Renewable generation industry",
               "renewable:trend" = "Renewable x years since 2021"),
  gof_map = gm, stars = c("*" = 0.05, "**" = 0.01, "***" = 0.001),
  fmt = 3, statistic = "({std.error})",
  title = "Table 3. Wage gaps by generation source, broad occupation category, and year (occupation-by-year fixed effects)",
  notes = c("Outcome: log real mean hourly wage (May 2025 dollars). All models include occupation-by-year fixed effects and cell-employment weights; SE clustered by detailed occupation.",
            sprintf("Joint Wald tests of equal renewable gaps: across occupation categories F = %.2f (p = %.3f); across years F = %.2f (p = %.3f).",
                    w_group$stat, w_group$p, w_year$stat, w_year$p)),
  output = file.path("tables", "table3-heterogeneity-regression.html"))
normalize_html_ids(file.path("tables", "table3-heterogeneity-regression.html"))

# T5 model_spec: every planned main spec estimated with clustering recorded
stopifnot(all(c("S01", "S02", "S03", "S04", "S05", "S06", "S07", "S09", "S10") %in% est$spec_id))
stopifnot(all(est$n_clusters > 30))
print(est[term == "renewable", .(spec_id, estimate, std_error, pct_gap, n, n_clusters)])
print(ident_summary)
