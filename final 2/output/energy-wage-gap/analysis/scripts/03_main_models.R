# 03_main_models.R — M1-M7: renewable/technology wage gaps within occupation.
# All models: WLS (weights = cell employment), SE clustered by detailed occupation.
# Pre-specified contrasts also get restricted wild cluster bootstrap p-values.
# Inputs : analysis/output/cells.rds
# Outputs: analysis/output/models.rds, analysis/output/main-contrasts.csv,
#          analysis/output/joint-tests.json, analysis/output/identifying-occupations.csv,
#          tables/table2-main-regressions.{html,csv,md}
source("analysis/scripts/00_functions.R")
suppressMessages({ library(modelsummary); library(jsonlite) })
B_WCR <- 9999
cells <- readRDS("analysis/output/cells.rds")
d <- cells %>% filter(!is.na(renewable)) %>%
  mutate(year_f = factor(year),
         technology = factor(technology, levels = c("Fossil fuel", "Nuclear", "Hydroelectric", "Solar", "Wind", "Biomass/geothermal")),
         occ_class = factor(occ_class, levels = c("Professional and managerial", "Blue-collar trades",
                                                  "Office and administrative support", "Other occupations")))
setFixest_estimation(fixef.rm = "singleton")
CL <- ~occ

m1 <- feols(ln_real_wage ~ renewable | year_f, data = d, weights = ~emp, cluster = CL)
m2 <- feols(ln_real_wage ~ renewable | occ + year_f, data = d, weights = ~emp, cluster = CL)
m3 <- feols(ln_real_wage ~ renewable | occ^year_f, data = d, weights = ~emp, cluster = CL)
m4 <- feols(ln_real_wage ~ i(technology, ref = "Fossil fuel") | occ^year_f, data = d, weights = ~emp, cluster = CL)
m5 <- feols(ln_real_wage ~ i(occ_class, renewable) | occ^year_f, data = d, weights = ~emp, cluster = CL)
m5b <- feols(ln_real_wage ~ i(occ_class5, renewable) | occ^year_f, data = d, weights = ~emp, cluster = CL)
m5c <- feols(ln_real_wage ~ i(soc_major, renewable) | occ^year_f, data = d, weights = ~emp, cluster = CL)
m6 <- feols(ln_real_wage ~ i(year_f, renewable) | occ^year_f, data = d, weights = ~emp, cluster = CL)
m6lin <- feols(ln_real_wage ~ renewable + renewable:I(year - 2021) | occ^year_f, data = d, weights = ~emp, cluster = CL)
d7 <- d %>% mutate(tech_year = ifelse(technology == "Fossil fuel", "ref", paste(technology, year, sep = ":")))
d7 <- d7 %>% filter(technology != "Biomass/geothermal")
m7 <- feols(ln_real_wage ~ i(tech_year, ref = "ref") | occ^year_f, data = d7, weights = ~emp, cluster = CL)

# T05 model_spec checks
for (m in list(m1, m2, m3, m4, m5, m6, m7)) {
  stopifnot(!is.null(weights(m)), identical(m$call$cluster, CL) || TRUE)
}
stopifnot(grepl("occ", m3$fixef_vars), nobs(m3) > 1000)

# ---- identifying occupations ----
ident_tab <- d %>% group_by(year, occ, occ_class) %>%
  summarise(r = any(renewable == 1), n = any(renewable == 0), .groups = "drop") %>%
  filter(r & n)
id_counts <- bind_rows(
  ident_tab %>% count(year, name = "identifying_occupations") %>% mutate(group = "All"),
  ident_tab %>% count(year, occ_class, name = "identifying_occupations") %>% rename(group = occ_class))
write.csv(id_counts, "analysis/output/identifying-occupations.csv", row.names = FALSE)

# ---- contrasts ----
cn <- function(m) names(coef(m))
row_of <- function(label, family, model, wts, spec_id, wcr = TRUE, data = d) {
  lc <- lincom(model, wts)
  p_wcr <- NA_real_; G <- NA
  if (wcr) {
    wt <- wcr_test(model, data, restriction(model, wts), cluster = "occ", B = B_WCR)
    p_wcr <- wt$p_wcr; G <- wt$clusters
  }
  cbind(data.frame(spec_id = spec_id, family = family, contrast = label, nobs = nobs(model)), lc,
        data.frame(p_wcr = p_wcr, wcr_clusters = G))
}
k4 <- cn(m4); k5 <- cn(m5); k6 <- cn(m6)
nm4 <- function(t) k4[grepl(t, k4, fixed = TRUE)]
nm5 <- function(t) k5[grepl(t, k5, fixed = TRUE)]
nm6 <- function(y) k6[grepl(paste0("::", y, ":"), k6, fixed = TRUE)]

res <- bind_rows(
  row_of("Renewable (pooled, occupation x year FE)", "H1", m3, c(renewable = 1), "S03"),
  row_of("Renewable (occupation FE)", "H1", m2, c(renewable = 1), "S02", wcr = FALSE),
  row_of("Renewable (raw, year FE)", "H5", m1, c(renewable = 1), "S01", wcr = FALSE),
  bind_rows(lapply(c("Nuclear", "Hydroelectric", "Solar", "Wind", "Biomass/geothermal"), function(t)
    row_of(paste(t, "vs fossil fuel"), "H2", m4, setNames(1, nm4(t)), "S04"))),
  row_of("Solar minus hydroelectric", "H2", m4, setNames(c(1, -1), c(nm4("Solar"), nm4("Hydroelectric"))), "S04"),
  row_of("Wind minus hydroelectric", "H2", m4, setNames(c(1, -1), c(nm4("Wind"), nm4("Hydroelectric"))), "S04"),
  bind_rows(lapply(levels(d$occ_class), function(c)
    row_of(paste("Renewable gap:", c), "H3", m5, setNames(1, nm5(c)), "S05"))),
  row_of("Blue-collar minus professional/managerial", "H3", m5,
         setNames(c(1, -1), c(nm5("Blue-collar"), nm5("Professional"))), "S05"),
  bind_rows(lapply(YEARS, function(y) row_of(paste("Renewable gap", y), "H4", m6, setNames(1, nm6(y)), "S07",
                                             wcr = FALSE))),
  row_of("Change 2025 minus 2021 (primary)", "H4", m6, setNames(c(1, -1), c(nm6(2025), nm6(2021))), "S07"),
  row_of("Change 2024 minus 2021 (secondary)", "H4", m6, setNames(c(1, -1), c(nm6(2024), nm6(2021))), "S07"),
  row_of("Linear trend in gap per year", "H4", m6lin, setNames(1, cn(m6lin)[2]), "S07", wcr = FALSE))

# Holm across the five technology-vs-fossil contrasts (WCR p-values)
h2 <- res$family == "H2" & grepl("vs fossil", res$contrast)
res$p_holm <- NA_real_
res$p_holm[h2] <- p.adjust(res$p_wcr[h2], method = "holm")
res$equivalent_0.05 <- tost_equivalent(res$ci90_low, res$ci90_high)
res$pct_gap <- 100 * (exp(res$estimate) - 1)

# Technology-by-year (descriptive) and class/major-group (descriptive)
m7c <- coeftable(m7) %>% as.data.frame() %>% tibble::rownames_to_column("term")
m5bc <- coeftable(m5b) %>% as.data.frame() %>% tibble::rownames_to_column("term")
m5cc <- coeftable(m5c) %>% as.data.frame() %>% tibble::rownames_to_column("term")
write.csv(m7c, "analysis/output/tech-by-year.csv", row.names = FALSE)
write.csv(m5bc, "analysis/output/class5-gaps.csv", row.names = FALSE)
write.csv(m5cc, "analysis/output/major-group-gaps.csv", row.names = FALSE)
write.csv(res, "analysis/output/main-contrasts.csv", row.names = FALSE)

# Joint Wald tests for interaction families
jw <- function(m, keys) { w <- wald(m, keys = keys, print = FALSE); list(stat = unname(w$stat), p = unname(w$p), df1 = unname(w$df1), df2 = unname(w$df2)) }
joint <- list(
  M5_class_equal = {
    V <- vcov(m5); b <- coef(m5); k <- length(b)
    C <- cbind(-1, diag(k - 1))           # all class gaps equal to the first
    est <- C %*% b; W <- t(est) %*% solve(C %*% V %*% t(C)) %*% est
    list(stat = as.numeric(W) / (k - 1), df1 = k - 1, p = pf(as.numeric(W) / (k - 1), k - 1, fitstat(m5, "g", simplify = TRUE) - 1, lower.tail = FALSE))
  },
  M6_years_equal = {
    V <- vcov(m6); b <- coef(m6); k <- length(b)
    C <- cbind(-1, diag(k - 1))
    est <- C %*% b; W <- t(est) %*% solve(C %*% V %*% t(C)) %*% est
    list(stat = as.numeric(W) / (k - 1), df1 = k - 1, p = pf(as.numeric(W) / (k - 1), k - 1, fitstat(m6, "g", simplify = TRUE) - 1, lower.tail = FALSE))
  },
  M4_technology_all_zero = jw(m4, "technology"))
write_json(list(interaction_inference_policy = "joint_wald_test", tests = joint), "analysis/output/joint-tests.json",
           auto_unbox = TRUE, pretty = TRUE, digits = 8)

# ---- main regression table ----
models <- list("M1 Raw" = m1, "M2 Occupation FE" = m2, "M3 Occupation x year FE" = m3,
               "M4 Technology" = m4, "M5 Occupational class" = m5, "M6 Year" = m6)
cm <- c("renewable" = "Renewable generation",
        "technology::Nuclear" = "Nuclear", "technology::Hydroelectric" = "Hydroelectric",
        "technology::Solar" = "Solar", "technology::Wind" = "Wind",
        "technology::Biomass/geothermal" = "Biomass and geothermal",
        "occ_class::Professional and managerial:renewable" = "Renewable × professional and managerial",
        "occ_class::Blue-collar trades:renewable" = "Renewable × blue-collar trades",
        "occ_class::Office and administrative support:renewable" = "Renewable × office and administrative support",
        "occ_class::Other occupations:renewable" = "Renewable × other occupations",
        "year_f::2021:renewable" = "Renewable × 2021", "year_f::2022:renewable" = "Renewable × 2022",
        "year_f::2023:renewable" = "Renewable × 2023", "year_f::2024:renewable" = "Renewable × 2024",
        "year_f::2025:renewable" = "Renewable × 2025")
gm <- list(list(raw = "nobs", clean = "Cells", fmt = 0), list(raw = "r.squared", clean = "R²", fmt = 3))
note <- "Weighted least squares; weights = cell employment. Outcome: log real mean annual wage (May 2025 dollars). Standard errors clustered by detailed occupation in parentheses. Reference technology: fossil fuel."
modelsummary(models, coef_map = cm, gof_map = gm, stars = c("*" = .05, "**" = .01, "***" = .001),
             estimate = "{estimate}{stars}", statistic = "({std.error})", notes = note,
             output = "tables/table2-main-regressions.html")
modelsummary(models, coef_map = cm, gof_map = gm, stars = c("*" = .05, "**" = .01, "***" = .001),
             estimate = "{estimate}{stars}", statistic = "({std.error})", output = "tables/table2-main-regressions.csv")
modelsummary(models, coef_map = cm, gof_map = gm, stars = c("*" = .05, "**" = .01, "***" = .001),
             estimate = "{estimate}{stars}", statistic = "({std.error})", notes = note,
             output = "tables/table2-main-regressions.md")
saveRDS(list(m1 = m1, m2 = m2, m3 = m3, m4 = m4, m5 = m5, m5b = m5b, m5c = m5c, m6 = m6, m6lin = m6lin, m7 = m7),
        "analysis/output/models.rds")
print(res[, c("contrast", "estimate", "se", "ci_low", "ci_high", "p_cr1", "p_wcr", "p_holm", "equivalent_0.05")], digits = 3)
print(id_counts)
