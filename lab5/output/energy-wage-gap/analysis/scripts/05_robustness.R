# 05_robustness.R — R1-R16: the headline within-occupation gap (M3) and the primary
# 2025-minus-2021 change (M6) under alternative samples, weights, outcomes,
# classifications, and clustering.
# Inputs : analysis/output/cells.rds, analysis/output/models.rds
# Outputs: tables/tableA3-robustness.csv
source("analysis/scripts/00_functions.R")
cells <- readRDS("analysis/output/cells.rds")
setFixest_estimation(fixef.rm = "singleton")
base <- cells %>% mutate(year_f = factor(year))
main <- base %>% filter(!is.na(renewable))

fit_pair <- function(dat, y = "ln_real_wage", w = "emp", cl = ~occ, label, spec_id) {
  dat <- dat[is.finite(dat[[y]]), ]
  f3 <- as.formula(paste(y, "~ renewable | occ^year_f"))
  f6 <- as.formula(paste(y, "~ i(year_f, renewable) | occ^year_f"))
  wf <- if (is.null(w)) NULL else as.formula(paste0("~", w))
  m3 <- feols(f3, data = dat, weights = wf, cluster = cl)
  out <- cbind(data.frame(spec_id = spec_id, check = label, nobs = nobs(m3)), lincom(m3, c(renewable = 1)))
  k <- names(coef(feols(f6, data = dat, weights = wf, cluster = cl)))
  if (all(c("year_f::2021:renewable", "year_f::2025:renewable") %in% k)) {
    m6 <- feols(f6, data = dat, weights = wf, cluster = cl)
    ch <- lincom(m6, setNames(c(1, -1), c("year_f::2025:renewable", "year_f::2021:renewable")))
    out$change_2025_2021 <- ch$estimate; out$change_se <- ch$se
    out$change_ci_low <- ch$ci_low; out$change_ci_high <- ch$ci_high
  } else {
    out$change_2025_2021 <- NA; out$change_se <- NA; out$change_ci_low <- NA; out$change_ci_high <- NA
  }
  out
}

# Balanced cells: industry-occupation pairs present in all five years
bal_keys <- main %>% count(naics, occ) %>% filter(n == length(YEARS))
balanced <- main %>% semi_join(bal_keys, by = c("naics", "occ"))
# Precision weights
prec <- main %>% filter(!is.na(mean_prse), mean_prse > 0) %>% mutate(w_prec = emp / mean_prse^2)
# Largest identifying occupations (by pooled employment among identifying occupations)
ident <- main %>% group_by(year, occ) %>% filter(any(renewable == 1) & any(renewable == 0)) %>% ungroup()
top5 <- ident %>% group_by(occ) %>% summarise(e = sum(emp), .groups = "drop") %>% arrange(desc(e)) %>% slice(1:5)

rows <- list(
  fit_pair(main, label = "Headline specification (M3 / M6)", spec_id = "S03"),
  fit_pair(balanced, label = "R1 Balanced industry-occupation cells", spec_id = "R01"),
  fit_pair(prec, w = "w_prec", label = "R2 Precision weights (employment / PRSE squared)", spec_id = "R02"),
  fit_pair(main, w = NULL, label = "R3 Unweighted", spec_id = "R03"),
  fit_pair(main, y = "ln_real_median", label = "R4 Median wage", spec_id = "R04"),
  fit_pair(main, y = "ln_real_p10", label = "R5 10th-percentile wage", spec_id = "R05a"),
  fit_pair(main, y = "ln_real_p90", label = "R5 90th-percentile wage (top-coded)", spec_id = "R05b"),
  fit_pair(base %>% mutate(renewable = ifelse(naics == OTHER_NAICS, 1L, renewable)), label = "R6 Other generation as renewable", spec_id = "R06"),
  fit_pair(base %>% mutate(renewable = ifelse(naics == OTHER_NAICS, 0L, renewable)), label = "R7 Other generation as nonrenewable", spec_id = "R07"),
  fit_pair(main %>% filter(!topcoded_mean), label = "R8 Drop top-coded cells", spec_id = "R08"),
  fit_pair(main %>% filter(!is.na(mean_prse), mean_prse <= 10), label = "R9 Mean-wage PRSE at most 10", spec_id = "R09"),
  fit_pair(main, y = "ln_nominal_wage", label = "R10 Nominal wages", spec_id = "R10"),
  fit_pair(main %>% filter(year %in% c(2021, 2025)), label = "R11 2021 and 2025 only", spec_id = "R11"),
  fit_pair(main %>% mutate(renewable = ifelse(technology %in% c("Solar", "Wind", "Biomass/geothermal"), 1L, 0L)),
           label = "R12 New renewables vs legacy (hydro grouped with fossil and nuclear)", spec_id = "R12"),
  fit_pair(main %>% filter(technology != "Nuclear"), label = "R13 Exclude nuclear", spec_id = "R13"),
  fit_pair(main, y = "ln_real_hourly", label = "R14 Hourly mean wage", spec_id = "R14"),
  fit_pair(main %>% filter(!occ %in% top5$occ), label = "R15 Drop five largest identifying occupations", spec_id = "R15"),
  fit_pair(main %>% mutate(cell_id = paste(naics, occ)), cl = ~cell_id, label = "R16 SE clustered by industry-occupation cell", spec_id = "R16"))
rob <- bind_rows(rows)
# T07: each row must have a finite estimate and positive N
stopifnot(all(is.finite(rob$estimate)), all(rob$nobs > 0))
rob$pct_gap <- 100 * (exp(rob$estimate) - 1)
rob$n_balanced_cells <- ifelse(rob$spec_id == "R01", nrow(balanced), NA)
write.csv(rob, "tables/tableA3-robustness.csv", row.names = FALSE)
cat("Top-5 identifying occupations dropped in R15:", paste(top5$occ, collapse = ", "), "\n")
print(rob[, c("check", "nobs", "estimate", "se", "change_2025_2021", "change_se")], digits = 3)
