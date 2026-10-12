# 02_descriptives.R
# Table 1: descriptive statistics for every modeled variable, by generation
# source and by renewable status (analytic sample, May 2021-May 2025 pooled).
# Figure 1: employment-weighted mean real hourly wage by source and year.
# Run from the project root.

suppressPackageStartupMessages({
  library(data.table)
  library(ggplot2)
  library(modelsummary)
})
source(file.path("analysis", "scripts", "viz_setting.R"))

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

# PDF device without creation timestamps (byte-reproducible figures)
pdf_device <- function(filename, ...) grDevices::pdf(file = filename, ..., timestamp = FALSE)

cells <- fread(file.path("data", "processed", "oews-generation-cells.csv"),
               colClasses = list(character = c("naics", "occ_code")))
a <- cells[analytic == TRUE]
stopifnot(nrow(a) > 0)

source_order <- c("Fossil fuel", "Nuclear", "Hydroelectric", "Solar", "Wind",
                  "Geothermal", "Biomass")
a[, generation_source := factor(generation_source, levels = source_order)]
a[, group_col := as.character(generation_source)]
both <- rbind(
  copy(a),
  copy(a)[, group_col := ifelse(renewable == 1L, "All renewable", "All non-renewable")]
)
col_order <- c(source_order, "All non-renewable", "All renewable")

wmean <- function(x, w) { ok <- !is.na(x) & !is.na(w); sum(x[ok] * w[ok]) / sum(w[ok]) }
wsd <- function(x, w) {
  ok <- !is.na(x) & !is.na(w); m <- wmean(x, w)
  sqrt(sum(w[ok] * (x[ok] - m)^2) / sum(w[ok]))
}

stat_rows <- list()
add_row <- function(variable, statistic, fun) {
  vals <- sapply(col_order, function(g) fun(both[group_col == g]))
  stat_rows[[length(stat_rows) + 1L]] <<- data.table(
    variable = variable, statistic = statistic, t(round(vals, 3)))
}

# Outcomes (labels from data/variable-dictionary.csv display_label)
add_row("Log real mean hourly wage", "weighted mean", function(d) wmean(d$log_real_hmean, d$emp))
add_row("Log real mean hourly wage", "weighted SD", function(d) wsd(d$log_real_hmean, d$emp))
add_row("Real mean hourly wage (2025 $)", "weighted mean", function(d) wmean(d$real_hmean, d$emp))
add_row("Log real median hourly wage", "weighted mean", function(d) wmean(d$log_real_hmedian, d$emp))
add_row("Log real 10th percentile wage", "weighted mean", function(d) wmean(d$log_real_p10, d$emp))
add_row("Log real 90th percentile wage", "weighted mean (uncensored cells)", function(d) wmean(d$log_real_p90, d$emp))
add_row("Log real 90th percentile wage", "share of cells censored", function(d) mean(d$p90_censored))
# Focal predictor and source
add_row("Renewable generation", "share of employment", function(d) wmean(d$renewable, d$emp))
add_row("Electricity generation technology", "share of all generation employment",
        function(d) sum(d$emp) / sum(a$emp))
# Broad occupation categories (employment shares)
for (g in sort(unique(a$occupational_group))) {
  add_row(paste0("Broad occupation category: ", g), "share of employment",
          function(d) sum(d$emp[d$occupational_group == g]) / sum(d$emp))
}
# Occupation, year, employment, sampling error
add_row("Detailed occupation", "distinct occupations", function(d) uniqueN(d$occ_code))
add_row("Occupation-by-year", "distinct occupation-years", function(d) uniqueN(d[, .(occ_code, year)]))
add_row("Survey year", "cells (occupation-industry-years)", function(d) nrow(d))
add_row("Employment", "mean annual employment (analytic sample)", function(d) sum(d$emp) / uniqueN(d$year))
add_row("Relative standard error of mean wage", "weighted mean (%)", function(d) wmean(d$mean_prse, d$emp))

table1 <- rbindlist(stat_rows)
fwrite(table1, file.path("tables", "table1-descriptives.csv"))

# Reader-facing HTML rendering of the same table
datasummary_df(as.data.frame(table1),
               title = "Table 1. Descriptive statistics by generation source, May 2021-May 2025 (pooled)",
               notes = "Employment-weighted statistics over occupation-industry-year cells in the analytic sample. Wages in May 2025 dollars (CPI-U).",
               output = file.path("tables", "table1-descriptives.html"))
normalize_html_ids(file.path("tables", "table1-descriptives.html"))

# Year-by-renewable summary used for trend description
by_year <- a[, .(cells = .N, employment = sum(emp),
                 mean_real_hourly_wage = wmean(real_hmean, emp)),
             by = .(year, renewable)][order(year, renewable)]
fwrite(by_year, file.path("tables", "table1b-wage-by-year.csv"))

# Figure 1: employment-weighted mean real wage by source and year
fig_dat <- a[, .(wage = wmean(real_hmean, emp)), by = .(year, generation_source)]
p1 <- ggplot(fig_dat, aes(x = year, y = wage, colour = generation_source,
                          group = generation_source)) +
  geom_line() + geom_point() +
  scale_colour_Publication(name = "Generation technology") +
  labs(x = "Survey year (May)", y = "Mean hourly wage (2025 $)") +
  theme_Publication(base_family = "sans")
dir.create("figures", showWarnings = FALSE)
ggsave(file.path("figures", "fig1-wage-by-source-year.pdf"), p1, width = 7, height = 4.5, device = pdf_device)
ggsave(file.path("figures", "fig1-wage-by-source-year.png"), p1, width = 7, height = 4.5, dpi = 300)
stopifnot(file.exists(file.path("figures", c("fig1-wage-by-source-year.pdf", "fig1-wage-by-source-year.png"))))
cat("table1 rows:", nrow(table1), "\n")
