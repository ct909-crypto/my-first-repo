# 04_decomposition.R — D1 Kitagawa decomposition of the raw renewable minus
# nonrenewable gap (log real mean wage) into occupational composition and
# within-occupation pay, by year; D2 split of the 2021->2025 change in the
# within term into continuing and entering/exiting occupations.
# Inputs : analysis/output/cells.rds
# Outputs: tables/table3-decomposition.csv, analysis/output/d1-bootstrap.csv,
#          analysis/output/d2-change.csv
source("analysis/scripts/00_functions.R")
B_BOOT <- 999
cells <- readRDS("analysis/output/cells.rds")
d <- cells %>% filter(!is.na(renewable)) %>% transmute(year, occ, renewable, emp, ln_y = ln_real_wage)

decomp_all <- function(dd, strict = FALSE) {
  support <- NULL
  if (strict) {
    both <- dd %>% group_by(year, occ) %>% summarise(ok = any(renewable == 1) & any(renewable == 0), .groups = "drop") %>%
      group_by(occ) %>% summarise(all5 = sum(ok) == length(YEARS), .groups = "drop") %>% filter(all5)
    support <- both$occ
  }
  bind_rows(lapply(YEARS, function(y) cbind(year = y, kitagawa_year(dd[dd$year == y, ], support))))
}

d1 <- decomp_all(d)
d1s <- decomp_all(d, strict = TRUE)

# T06: identity already asserted inside kitagawa_year; check totals here too
stopifnot(all(abs(d1$raw - (d1$within + d1$composition + d1$off_support)) < 1e-8))

# D2: change in the within term between 2021 and 2025
d2_fun <- function(dd) {
  comp <- function(y) {
    x <- dd[dd$year == y, ] %>% group_by(occ, renewable) %>%
      summarise(ln_y = weighted.mean(ln_y, emp), emp = sum(emp), .groups = "drop")
    R <- x %>% filter(renewable == 1); N <- x %>% filter(renewable == 0)
    common <- intersect(R$occ, N$occ)
    j <- inner_join(R %>% filter(occ %in% common) %>% mutate(s = emp / sum(emp)),
                    N %>% filter(occ %in% common) %>% mutate(s = emp / sum(emp)), by = "occ", suffix = c("_r", "_n"))
    j %>% transmute(occ, m = (s_r + s_n) / 2, gap = ln_y_r - ln_y_n)
  }
  a <- comp(2021); b <- comp(2025)
  k <- intersect(a$occ, b$occ)
  ak <- a %>% filter(occ %in% k); bk <- b %>% filter(occ %in% k) %>% arrange(match(occ, ak$occ))
  data.frame(
    W2021 = sum(a$m * a$gap), W2025 = sum(b$m * b$gap),
    change = sum(b$m * b$gap) - sum(a$m * a$gap),
    continuing_pay_change = sum((ak$m + bk$m) / 2 * (bk$gap - ak$gap)),
    continuing_reweighting = sum((bk$m - ak$m) * (ak$gap + bk$gap) / 2),
    entering_minus_exiting = sum(b$m[!b$occ %in% k] * b$gap[!b$occ %in% k]) - sum(a$m[!a$occ %in% k] * a$gap[!a$occ %in% k]),
    n_continuing = length(k), n_entering = sum(!b$occ %in% k), n_exiting = sum(!a$occ %in% k))
}
d2 <- d2_fun(d)
stopifnot(abs(d2$change - (d2$continuing_pay_change + d2$continuing_reweighting + d2$entering_minus_exiting)) < 1e-8)

# Occupation-cluster bootstrap (support rule re-applied within each resample)
boots <- occ_bootstrap(d, function(db) {
  x <- decomp_all(db)
  x$within_change <- x$within[x$year == 2025] - x$within[x$year == 2021]
  x
}, B = B_BOOT)
bt <- bind_rows(lapply(seq_along(boots), function(b) cbind(draw = b, boots[[b]])))
ci <- bt %>% group_by(year) %>%
  summarise(raw_lo = quantile(raw, .025), raw_hi = quantile(raw, .975),
            within_lo = quantile(within, .025), within_hi = quantile(within, .975),
            within90_lo = quantile(within, .05), within90_hi = quantile(within, .95),
            comp_lo = quantile(composition, .025), comp_hi = quantile(composition, .975), .groups = "drop")
chg <- bt %>% filter(year == 2021) %>% summarise(lo = quantile(within_change, .025), hi = quantile(within_change, .975),
                                                 lo90 = quantile(within_change, .05), hi90 = quantile(within_change, .95))
tab3 <- d1 %>% left_join(ci, by = "year") %>% mutate(support = "occupations in both sectors that year")
tab3s <- d1s %>% mutate(support = "occupations in both sectors all five years")
write.csv(bind_rows(tab3, tab3s), "tables/table3-decomposition.csv", row.names = FALSE)
write.csv(bt, "analysis/output/d1-bootstrap.csv", row.names = FALSE)
write.csv(cbind(d2, within_change_ci_low = chg$lo, within_change_ci_high = chg$hi,
                within_change_ci90_low = chg$lo90, within_change_ci90_high = chg$hi90),
          "analysis/output/d2-change.csv", row.names = FALSE)
print(tab3, digits = 3); print(d1s, digits = 3); print(d2, digits = 3); print(chg)
