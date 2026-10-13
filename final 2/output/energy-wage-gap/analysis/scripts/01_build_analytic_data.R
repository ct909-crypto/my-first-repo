# 01_build_analytic_data.R — build industry x detailed-occupation x year cells
# from the five OEWS May national industry-specific files.
# Inputs : data/raw/nat5d_6d_M{2021..2025}_dl.xlsx, analysis/reference/cpi_u_may.csv
# Outputs: analysis/output/cells.rds, tables/tableA1-sample-flow.csv,
#          tables/tableA2-coverage.csv
source("analysis/scripts/00_functions.R")
suppressMessages(library(readxl))
dir.create("analysis/output", showWarnings = FALSE, recursive = TRUE)
dir.create("tables", showWarnings = FALSE)

cpi <- read_cpi()
raw <- bind_rows(lapply(YEARS, function(y) {
  read_excel(sprintf("data/raw/nat5d_6d_M%d_dl.xlsx", y), sheet = 1, col_types = "text") %>%
    filter(grepl("^2211", NAICS)) %>% mutate(year = y)
}))

# T01 data_loading
stopifnot(setequal(unique(raw$year), YEARS))
stopifnot(all(table(raw$year[!duplicated(paste(raw$year, raw$NAICS))]) == 8))
stopifnot(all(raw$OWN_CODE == "5"))

totals <- raw %>% filter(OCC_CODE == "00-0000") %>%
  transmute(year, naics = NAICS, industry_emp = as.numeric(TOT_EMP))

det <- raw %>% filter(O_GROUP == "detailed")
flow <- data.frame(step = "All rows in NAICS 2211xx files", cells = nrow(raw))
flow <- rbind(flow, data.frame(step = "Detailed-occupation rows", cells = nrow(det)))

cells <- det %>%
  transmute(year, naics = NAICS, occ = OCC_CODE, occ_title = OCC_TITLE,
            emp = suppressWarnings(as.numeric(TOT_EMP)),
            a_mean_raw = A_MEAN,
            topcoded_mean = A_MEAN == "#",
            a_mean = parse_wage(A_MEAN, year),
            h_mean = parse_wage(H_MEAN, year, hourly = TRUE),
            a_median = parse_wage(A_MEDIAN, year),
            a_p10 = parse_wage(A_PCT10, year),
            a_p90 = parse_wage(A_PCT90, year),
            topcoded_p90 = A_PCT90 == "#",
            mean_prse = suppressWarnings(as.numeric(MEAN_PRSE)))

# T04 missingness: counts of suppressed cells (must match Phase 4 audit)
n_wage_supp <- sum(cells$a_mean_raw == "*", na.rm = TRUE)
n_emp_supp <- sum(is.na(cells$emp))
stopifnot(n_wage_supp == 19, n_emp_supp == 71)

usable <- cells %>% filter(!is.na(a_mean), !is.na(emp))
flow <- rbind(flow, data.frame(step = "Published mean wage and employment (all 8 industries)", cells = nrow(usable)))
# T02 analytic_sample
stopifnot(nrow(usable) == 2006)
stopifnot(!any(duplicated(usable[, c("year", "naics", "occ")])))

usable <- usable %>%
  mutate(technology = tech_label(naics),
         renewable = case_when(naics %in% RENEWABLE_NAICS ~ 1L,
                               naics %in% NONRENEWABLE_NAICS ~ 0L,
                               TRUE ~ NA_integer_),
         code2 = substr(occ, 1, 2),
         soc_major = soc_major_label(code2),
         occ_class = occ_class_of(code2),
         occ_class5 = occ_class5_of(code2),
         deflator = cpi[["2025"]] / cpi[as.character(year)],
         ln_real_wage = log(a_mean * deflator),
         ln_nominal_wage = log(a_mean),
         ln_real_hourly = log(h_mean * deflator),
         ln_real_median = log(a_median * deflator),
         ln_real_p10 = log(a_p10 * deflator),
         ln_real_p90 = log(a_p90 * deflator))

# T03 variable_construction
stopifnot(all(usable$renewable[usable$naics %in% RENEWABLE_NAICS] == 1))
stopifnot(all(usable$renewable[usable$naics %in% NONRENEWABLE_NAICS] == 0))
stopifnot(all(is.na(usable$renewable[usable$naics == OTHER_NAICS])))
stopifnot(all(is.finite(usable$ln_real_wage)))
stopifnot(abs(usable$deflator[usable$year == 2025][1] - 1) < 1e-12)
stopifnot(!any(is.na(usable$soc_major)))

main_n <- sum(!is.na(usable$renewable))
flow <- rbind(flow, data.frame(step = "Main analytic sample (excluding other generation, 221118)", cells = main_n))
flow <- rbind(flow, data.frame(step = "  of which top-coded mean wage", cells = sum(usable$topcoded_mean & !is.na(usable$renewable))))

coverage <- cells %>% group_by(year, naics) %>%
  summarise(detailed_cells = n(), wage_suppressed = sum(a_mean_raw == "*", na.rm = TRUE),
            emp_suppressed = sum(is.na(emp)),
            usable_cells = sum(!is.na(a_mean) & !is.na(emp)),
            usable_emp = sum(emp[!is.na(a_mean) & !is.na(emp)]), .groups = "drop") %>%
  left_join(totals, by = c("year", "naics")) %>%
  mutate(technology = tech_label(naics), coverage_share = usable_emp / industry_emp)

saveRDS(usable, "analysis/output/cells.rds")
write.csv(flow, "tables/tableA1-sample-flow.csv", row.names = FALSE)
write.csv(coverage, "tables/tableA2-coverage.csv", row.names = FALSE)
cat("cells:", nrow(usable), " main sample:", main_n, "\n")
