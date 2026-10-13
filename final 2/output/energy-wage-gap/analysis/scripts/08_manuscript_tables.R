# 08_manuscript_tables.R — reader-facing Markdown tables for the manuscript.
# Inputs : tables/table1-descriptives.csv, tables/tableA2-coverage.csv,
#          analysis/output/main-contrasts.csv, tables/table3-decomposition.csv,
#          analysis/output/d2-change.csv, tables/tableA3-robustness.csv,
#          analysis/output/raw-ratio-by-year.csv
# Outputs: manuscript/tables/*.md
source("analysis/scripts/00_functions.R")
dir.create("manuscript/tables", showWarnings = FALSE, recursive = TRUE)
pct <- function(x) 100 * (exp(x) - 1)
f1 <- function(x) formatC(x, format = "f", digits = 1)
f3 <- function(x) formatC(x, format = "f", digits = 3)
fp <- function(p) ifelse(is.na(p), "", ifelse(p < 0.001, "<0.001", formatC(p, format = "f", digits = 3)))
md <- function(df) {
  w <- sapply(seq_along(df), function(j) max(nchar(c(names(df)[j], as.character(df[[j]])))))
  c(paste0("| ", paste(names(df), collapse = " | "), " |"),
    paste0("|", paste(strrep("-", pmax(3, w)), collapse = "|"), "|"),
    apply(df, 1, function(r) paste0("| ", paste(r, collapse = " | "), " |")))
}

# Table 1: descriptives
t1 <- read.csv("tables/table1-descriptives.csv")
ratio <- read.csv("analysis/output/raw-ratio-by-year.csv")
sel <- t1 %>% filter(year %in% c(2021, 2025)) %>%
  mutate(txt = sprintf("%d | %s | %s", cells, format(employment, big.mark = ","),
                       format(round(mean_real_wage, -2), big.mark = ","))) %>%
  select(group, year, txt) %>% tidyr::pivot_wider(names_from = year, values_from = txt)
t1md <- c("| Sector | Cells 2021 | Employment 2021 | Mean wage 2021 ($) | Cells 2025 | Employment 2025 | Mean wage 2025 ($) |",
          "|----------------------------------------|------|--------|---------|------|--------|---------|",
          sprintf("| %s | %s | %s |", trimws(sel$group), sel$`2021`, sel$`2025`),
          sprintf("| Renewable/nonrenewable mean-wage ratio | | | %s | | | %s |",
                  formatC(ratio$raw_ratio[ratio$year == 2021], format = "f", digits = 3),
                  formatC(ratio$raw_ratio[ratio$year == 2025], format = "f", digits = 3)))
writeLines(t1md, "manuscript/tables/table1.md")

# Table 2: within-occupation gaps (pre-specified contrasts)
r <- read.csv("analysis/output/main-contrasts.csv")
keep <- c("Renewable (raw, year FE)", "Renewable (pooled, occupation x year FE)",
          "Nuclear vs fossil fuel", "Hydroelectric vs fossil fuel", "Solar vs fossil fuel", "Wind vs fossil fuel",
          "Biomass/geothermal vs fossil fuel", "Solar minus hydroelectric", "Wind minus hydroelectric",
          "Renewable gap: Professional and managerial", "Renewable gap: Blue-collar trades",
          "Renewable gap: Office and administrative support", "Renewable gap: Other occupations",
          "Blue-collar minus professional/managerial",
          "Renewable gap 2021", "Renewable gap 2025",
          "Change 2025 minus 2021 (primary)", "Change 2024 minus 2021 (secondary)")
lab <- c("Renewable, raw (M1)", "Renewable, occupation × year FE (M3)",
         "Nuclear vs fossil fuel (M4)", "Hydroelectric vs fossil fuel (M4)", "Solar vs fossil fuel (M4)", "Wind vs fossil fuel (M4)",
         "Biomass/geothermal vs fossil fuel (M4)", "Solar minus hydroelectric (M4)", "Wind minus hydroelectric (M4)",
         "Professional and managerial (M5)", "Blue-collar trades (M5)", "Office and administrative support (M5)",
         "Other occupations (M5)", "Blue-collar minus professional/managerial (M5)",
         "Renewable gap, May 2021 (M6)", "Renewable gap, May 2025 (M6)",
         "Change, May 2025 minus May 2021 (M6)", "Change, May 2024 minus May 2021 (M6)")
t2 <- r[match(keep, r$contrast), ]
p_show <- ifelse(!is.na(t2$p_holm), t2$p_holm, ifelse(!is.na(t2$p_wcr), t2$p_wcr, t2$p_cr1))
t2df <- data.frame(Contrast = lab, `Log points` = f3(t2$estimate), SE = f3(t2$se),
                   `95% CI` = paste0("[", f3(t2$ci_low), ", ", f3(t2$ci_high), "]"),
                   `Percent` = f1(pct(t2$estimate)), p = fp(p_show), check.names = FALSE)
writeLines(md(t2df), "manuscript/tables/table2.md")

# Table 3: decomposition
t3 <- read.csv("tables/table3-decomposition.csv") %>% filter(grepl("that year", support))
d2 <- read.csv("analysis/output/d2-change.csv")
t3df <- data.frame(Year = paste("May", t3$year), Raw = f3(t3$raw), Composition = f3(t3$composition),
                   `Within occupation [95% CI]` = paste0(f3(t3$within), " [", f3(t3$within_lo), ", ", f3(t3$within_hi), "]"),
                   `Occupations off support` = f3(t3$off_support), `Shared occupations` = t3$n_common,
                   `Renewable employment off support` = paste0(round(100 * t3$offsup_share_r), "%"), check.names = FALSE)
writeLines(md(t3df), "manuscript/tables/table3.md")
d2df <- data.frame(Component = c("Change in within-occupation gap, 2021 to 2025", "  Pay change in continuing occupations",
                                 "  Reweighting of continuing occupations", "  Entering minus exiting occupations"),
                   `Log points` = f3(c(d2$change, d2$continuing_pay_change, d2$continuing_reweighting, d2$entering_minus_exiting)),
                   check.names = FALSE)
writeLines(c(md(d2df), "", sprintf("Bootstrap 95%% CI for the change: [%s, %s]; continuing occupations = %d, entering = %d, exiting = %d.",
                                   f3(d2$within_change_ci_low), f3(d2$within_change_ci_high), d2$n_continuing, d2$n_entering, d2$n_exiting)),
           "manuscript/tables/table3b.md")

# Table A1: robustness
rob <- read.csv("tables/tableA3-robustness.csv")
tadf <- data.frame(Specification = rob$check, Cells = rob$nobs,
                   `Gap (log points) [95% CI]` = paste0(f3(rob$estimate), " [", f3(rob$ci_low), ", ", f3(rob$ci_high), "]"),
                   `Change 2025–2021 [95% CI]` = ifelse(is.na(rob$change_2025_2021), "—",
                       paste0(f3(rob$change_2025_2021), " [", f3(rob$change_ci_low), ", ", f3(rob$change_ci_high), "]")),
                   check.names = FALSE)
writeLines(md(tadf), "manuscript/tables/tableA1.md")
cat("tables written\n")
