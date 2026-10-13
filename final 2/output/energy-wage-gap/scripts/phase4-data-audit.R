# Phase 4 data audit: codebook validation and coverage counts (aggregates only; no wage-gap estimation)
suppressMessages({library(readxl); library(dplyr); library(tidyr)})
yrs <- 2021:2025
topcodes <- sapply(yrs, function(y) {
  fd <- read_excel(sprintf("data/raw/nat5d_6d_M%d_dl.xlsx", y), sheet = "Field Descriptions", col_names = FALSE)
  txt <- paste(unlist(fd), collapse = " ")
  m <- regmatches(txt, regexpr("#[^$]*\\$[0-9,.]+ per hour or \\$[0-9,]+ per year", txt))
  if (length(m) == 0) NA_character_ else m
})
d <- bind_rows(lapply(yrs, function(y) read_excel(sprintf("data/raw/nat5d_6d_M%d_dl.xlsx", y), sheet = 1, col_types = "text") %>%
  filter(grepl("^2211", NAICS)) %>% mutate(year = y)))
titles <- d %>% distinct(year, NAICS, NAICS_TITLE) %>% group_by(NAICS) %>% summarise(n_titles = n_distinct(NAICS_TITLE), n_years = n_distinct(year), .groups = "drop")
own <- d %>% count(OWN_CODE, name = "rows")
det <- d %>% filter(O_GROUP == "detailed")
tot <- d %>% filter(OCC_CODE == "00-0000") %>% transmute(year, NAICS, total_emp = as.numeric(TOT_EMP))
cov <- det %>% mutate(emp = suppressWarnings(as.numeric(TOT_EMP)), wage_ok = grepl("^[0-9.]+$", A_MEAN) | A_MEAN == "#",
                      emp_ok = !is.na(emp)) %>%
  group_by(year, NAICS) %>%
  summarise(detailed_cells = n(), usable_cells = sum(wage_ok & emp_ok), wage_suppressed = sum(A_MEAN == "*"),
            emp_suppressed = sum(!emp_ok), topcoded_mean = sum(A_MEAN == "#"),
            p90_topcoded = sum(A_PCT90 == "#", na.rm = TRUE), p90_suppressed = sum(A_PCT90 == "*", na.rm = TRUE),
            usable_emp = sum(emp[wage_ok & emp_ok], na.rm = TRUE), .groups = "drop") %>%
  left_join(tot, by = c("year", "NAICS")) %>% mutate(coverage = round(usable_emp / total_emp, 3))
occs <- det %>% filter(NAICS != "221118", grepl("^[0-9.]+$", A_MEAN) | A_MEAN == "#", !is.na(suppressWarnings(as.numeric(TOT_EMP)))) %>%
  mutate(ren = NAICS %in% c("221111","221114","221115","221116","221117")) %>%
  group_by(year, OCC_CODE) %>% summarise(r = any(ren), n = any(!ren), .groups = "drop") %>%
  group_by(year) %>% summarise(occupations = n(), identifying_occupations = sum(r & n), .groups = "drop")
tech_overlap <- det %>% filter(NAICS != "221118", grepl("^[0-9.]+$", A_MEAN) | A_MEAN == "#", !is.na(suppressWarnings(as.numeric(TOT_EMP)))) %>%
  group_by(year, OCC_CODE) %>% mutate(has_fossil = any(NAICS == "221112")) %>% ungroup() %>%
  filter(NAICS != "221112") %>% group_by(year, NAICS) %>% summarise(cells_with_fossil_counterpart = sum(has_fossil), .groups = "drop") %>%
  pivot_wider(names_from = year, values_from = cells_with_fossil_counterpart)
prse <- summary(suppressWarnings(as.numeric(det$MEAN_PRSE)))
sink("data/audit/phase4-data-audit.txt")
cat("TOP-CODE NOTES BY YEAR\n"); print(setNames(topcodes, yrs))
cat("\nNAICS TITLE STABILITY\n"); print(titles)
cat("\nOWNERSHIP CODES (rows)\n"); print(own)
cat("\nDISTINCT O_GROUP LEVELS\n"); print(table(d$O_GROUP))
cat("\nCOVERAGE / SUPPRESSION BY INDUSTRY-YEAR\n"); print(as.data.frame(cov))
cat("\nIDENTIFYING OCCUPATIONS BY YEAR (excl. 221118)\n"); print(occs)
cat("\nCELLS WITH A FOSSIL COUNTERPART IN SAME OCC-YEAR\n"); print(as.data.frame(tech_overlap))
cat("\nMEAN PRSE SUMMARY (detailed cells)\n"); print(prse)
cat("\nHOURLY/ANNUAL-ONLY FLAGS\n"); print(table(det$ANNUAL, useNA = "always")); print(table(det$HOURLY, useNA = "always"))
sink()
write.csv(cov, "data/audit/coverage-by-industry-year.csv", row.names = FALSE)
cat("done\n")
