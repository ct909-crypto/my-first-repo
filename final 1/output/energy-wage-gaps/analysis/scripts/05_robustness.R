# 05_robustness.R
# Robustness specs S11-S20 for the headline within-occupation gap (S03) and the
# year-specific gaps (S06). Writes tables/tableA1-robustness.csv, a modelsummary
# appendix regression table, and fit statistics. Run from the project root.

suppressPackageStartupMessages({
  library(data.table)
  library(fixest)
  library(modelsummary)
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
cl <- ~occ_code
fe_fit <- function(d, w = ~emp, y = "log_real_hmean") {
  feols(as.formula(paste(y, "~ renewable | occ_code^year")), d, weights = w, cluster = cl)
}

# Balanced occupation set: occupations observed in both groups in all five years
bal_occ <- a[, .(mixed = uniqueN(renewable) == 2L), by = .(occ_code, year)][
  mixed == TRUE, .N, by = occ_code][N == 5L, occ_code]
bal <- a[occ_code %in% bal_occ]

# Other generation (221118) coded renewable
other <- cells[naics == "221118" & !is.na(h_mean) & !is.na(emp) & emp > 0]
other[, renewable := 1L]
with_other <- rbind(a, other)

a[, ivw := 1 / (mean_prse / 100)^2]

m <- list()
m$S11 <- fe_fit(a, w = NULL)
m$S12 <- fe_fit(a[!is.na(ivw) & is.finite(ivw)], w = ~ivw)
m$S13 <- fe_fit(a, y = "log_real_hmedian")
m$S14 <- fe_fit(bal)
m$S15 <- fe_fit(a[generation_source != "Nuclear"])
m$S16 <- fe_fit(a[generation_source != "Hydroelectric"])
m$S17 <- fe_fit(with_other)
m$S18 <- fe_fit(a[emp >= 50])
loo_sources <- c("Hydroelectric", "Solar", "Wind", "Geothermal", "Biomass")
loo <- setNames(lapply(loo_sources, function(s) fe_fit(a[generation_source != s])),
                paste0("S19_drop_", loo_sources))
s20 <- feols(log_real_hmean ~ i(year, renewable) | occ_code^year, bal, weights = ~emp, cluster = cl)

tidy_focal <- function(spec, fit, label, term = "renewable") {
  ct <- coeftable(fit)
  ci <- confint(fit)
  rows <- grepl(term, rownames(ct), fixed = TRUE)
  data.table(spec_id = spec, variant = label, term = rownames(ct)[rows],
             estimate = ct[rows, 1], std_error = ct[rows, 2], p_value = ct[rows, 4],
             conf_low = ci[rows, 1], conf_high = ci[rows, 2],
             pct_gap = 100 * (exp(ct[rows, 1]) - 1), n = nobs(fit),
             n_clusters = unname(fitstat(fit, "g")[[1]]))
}
labels <- c(S11 = "Unweighted (equal cell weights)",
            S12 = "Inverse sampling-variance weights",
            S13 = "Outcome: log real median hourly wage",
            S14 = "Balanced occupation set",
            S15 = "Nuclear excluded (renewable vs. fossil fuel)",
            S16 = "Hydroelectric excluded",
            S17 = "Other generation coded renewable",
            S18 = "Cells with employment of 50 or more")
rob <- rbindlist(c(
  Map(function(s, f) tidy_focal(s, f, labels[[s]]), names(m), m),
  Map(function(nm, f) tidy_focal("S19", f, paste("Leave out", sub("S19_drop_", "", nm))), names(loo), loo),
  list(tidy_focal("S20", s20, "Balanced set, year-specific gaps", term = "year::"))
))
fwrite(rob, file.path("tables", "tableA1-robustness.csv"))
fwrite(data.table(balanced_occupations = length(bal_occ), balanced_cells = nrow(bal)),
       file.path("analysis", "outputs", "balanced-set.csv"))

fits <- rbindlist(lapply(c(names(m), "S20"), function(s) {
  f <- if (s == "S20") s20 else m[[s]]
  data.table(spec_id = s, status = "robustness", n = nobs(f),
             r_squared = unname(fitstat(f, "r2")[[1]]),
             adj_r_squared = unname(fitstat(f, "ar2")[[1]]),
             within_r_squared = unname(fitstat(f, "wr2")[[1]]),
             aic = AIC(f), bic = BIC(f))
}))
loo_fit <- rbindlist(lapply(loo, function(f) data.table(
  r_squared = unname(fitstat(f, "r2")[[1]]), adj_r_squared = unname(fitstat(f, "ar2")[[1]]),
  within_r_squared = unname(fitstat(f, "wr2")[[1]]), aic = AIC(f), bic = BIC(f), n = nobs(f))))
fits <- rbind(fits, data.table(spec_id = "S19", status = "robustness",
                               loo_fit[, lapply(.SD, mean)]), fill = TRUE)
fwrite(fits, file.path("analysis", "outputs", "fit-stats-robustness.csv"))
saveRDS(c(m, loo, list(S20 = s20)), file.path("analysis", "outputs", "robustness-models.rds"))

gm <- list(list(raw = "nobs", clean = "Cells (N)", fmt = 0),
           list(raw = "r2.within", clean = "Within R-squared", fmt = 3))
modelsummary(
  setNames(m, paste("Model", sprintf("A%d", seq_along(m)))),
  coef_map = c(renewable = "Renewable generation industry"),
  gof_map = gm, stars = c("*" = 0.05, "**" = 0.01, "***" = 0.001), fmt = 3,
  statistic = "({std.error})",
  title = "Table A1. Robustness of the within-occupation renewable wage gap",
  notes = c(paste0("Model A", seq_along(m), ": ", labels[names(m)], collapse = "; "),
            "All models include occupation-by-year fixed effects; SE clustered by detailed occupation. Outcome is log real mean hourly wage except Model A3."),
  output = file.path("tables", "tableA1-robustness-regression.html"))
normalize_html_ids(file.path("tables", "tableA1-robustness-regression.html"))

stopifnot(nrow(rob[spec_id == "S19"]) == 5L, nrow(rob[spec_id == "S20"]) == 5L)
print(rob[, .(spec_id, variant, term, estimate, std_error, pct_gap, n)])
