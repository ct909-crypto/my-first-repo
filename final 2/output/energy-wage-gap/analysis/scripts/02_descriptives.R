# 02_descriptives.R — Table 1: cells, employment, coverage and mean real wages by
# technology/sector and year; distributional diagnostics for the outcome.
# Inputs : analysis/output/cells.rds, tables/tableA2-coverage.csv
# Outputs: tables/table1-descriptives.csv, tables/table1-descriptives.md,
#          analysis/output/outcome-diagnostics.csv
source("analysis/scripts/00_functions.R")
cells <- readRDS("analysis/output/cells.rds")
coverage <- read.csv("tables/tableA2-coverage.csv", colClasses = c(naics = "character"))

grp <- function(d, label) {
  d %>% group_by(year) %>%
    summarise(group = label, cells = n(), employment = sum(emp),
              mean_real_wage = weighted.mean(exp(ln_real_wage), emp), .groups = "drop")
}
main <- cells %>% filter(!is.na(renewable))
tab <- bind_rows(
  grp(main %>% filter(renewable == 0), "Nonrenewable (fossil fuel and nuclear)"),
  grp(main %>% filter(technology == "Fossil fuel"), "  Fossil fuel"),
  grp(main %>% filter(technology == "Nuclear"), "  Nuclear"),
  grp(main %>% filter(renewable == 1), "Renewable"),
  grp(main %>% filter(technology == "Hydroelectric"), "  Hydroelectric"),
  grp(main %>% filter(technology == "Solar"), "  Solar"),
  grp(main %>% filter(technology == "Wind"), "  Wind"),
  grp(main %>% filter(technology == "Biomass/geothermal"), "  Biomass and geothermal"))

cov_grp <- coverage %>% mutate(technology = tech_label(naics)) %>%
  mutate(group = case_when(technology %in% c("Fossil fuel", "Nuclear") ~ "Nonrenewable (fossil fuel and nuclear)",
                           technology == "Other" ~ "Other", TRUE ~ "Renewable")) %>%
  bind_rows(mutate(., group = case_when(technology == "Biomass/geothermal" ~ "  Biomass and geothermal",
                                        TRUE ~ paste0("  ", technology)))) %>%
  group_by(year, group) %>% summarise(coverage = sum(usable_emp) / sum(industry_emp), .groups = "drop")
tab <- tab %>% left_join(cov_grp, by = c("year", "group"))

ratio <- tab %>% filter(group %in% c("Renewable", "Nonrenewable (fossil fuel and nuclear)")) %>%
  select(year, group, mean_real_wage) %>% pivot_wider(names_from = group, values_from = mean_real_wage) %>%
  transmute(year, raw_ratio = Renewable / `Nonrenewable (fossil fuel and nuclear)`)

write.csv(tab, "tables/table1-descriptives.csv", row.names = FALSE)
write.csv(ratio, "analysis/output/raw-ratio-by-year.csv", row.names = FALSE)

# Reader-facing markdown version (2021, 2024, 2025)
fmt <- tab %>% filter(year %in% c(2021, 2024, 2025)) %>%
  mutate(cell = sprintf("%d / %s / $%s", cells, format(employment, big.mark = ","),
                        format(round(mean_real_wage, -2), big.mark = ","))) %>%
  select(group, year, cell) %>% pivot_wider(names_from = year, values_from = cell)
lines <- c("| Sector | May 2021 | May 2024 | May 2025 |", "|---|---|---|---|",
           sprintf("| %s | %s | %s | %s |", fmt$group, fmt$`2021`, fmt$`2024`, fmt$`2025`))
writeLines(lines, "tables/table1-descriptives.md")

# Outcome diagnostics: skewness of levels vs logs, top-coded shares
skew <- function(x) mean((x - mean(x))^3) / sd(x)^3
diag <- main %>% group_by(renewable) %>%
  summarise(n = n(), skew_level = skew(exp(ln_real_wage)), skew_log = skew(ln_real_wage),
            share_topcoded_mean = mean(topcoded_mean), share_topcoded_p90 = mean(topcoded_p90, na.rm = TRUE),
            .groups = "drop")
write.csv(diag, "analysis/output/outcome-diagnostics.csv", row.names = FALSE)
print(tab, n = 50); print(ratio); print(diag)
