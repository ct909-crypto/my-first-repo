# 01_build_panel.R
# Build the occupation x generation-industry x year wage-cell panel from the
# five OEWS national industry-specific files (May 2021-May 2025).
# Run from the project root:  Rscript analysis/scripts/01_build_panel.R
# Outputs: data/processed/oews-generation-cells.csv, tables/cell-coverage.csv

suppressPackageStartupMessages({
  library(readxl)
  library(data.table)
})

years <- 2021:2025
raw_files <- file.path("data", "raw", sprintf("nat5d_6d_M%d_dl.xlsx", years))
stopifnot(all(file.exists(raw_files)))
dir.create(file.path("data", "processed"), showWarnings = FALSE, recursive = TRUE)
dir.create("tables", showWarnings = FALSE)

# CPI-U, U.S. city average, all items, NSA (CUUR0000SA0), May of each year.
# Retrieved from the BLS public API on 2026-10-10.
cpi_may <- c(`2021` = 269.195, `2022` = 292.296, `2023` = 304.127,
             `2024` = 314.069, `2025` = 321.465)
cpi_base <- cpi_may[["2025"]]

source_map <- data.table(
  naics = c("221111", "221112", "221113", "221114",
            "221115", "221116", "221117", "221118"),
  generation_source = c("Hydroelectric", "Fossil fuel", "Nuclear", "Solar",
                        "Wind", "Geothermal", "Biomass", "Other"),
  renewable = c(1L, 0L, 0L, 1L, 1L, 1L, 1L, NA_integer_)
)

required_cols <- c("NAICS", "NAICS_TITLE", "I_GROUP", "OCC_CODE", "OCC_TITLE",
                   "O_GROUP", "TOT_EMP", "MEAN_PRSE", "H_MEAN", "H_PCT10",
                   "H_MEDIAN", "H_PCT90")

# Read the top-code threshold ("#") for hourly wages from each file's
# Field Descriptions sheet so the rule follows the source documentation.
read_topcode <- function(path) {
  fd <- suppressMessages(read_excel(path, sheet = "Field Descriptions",
                                    col_names = FALSE))
  txt <- apply(fd, 1, function(r) paste(na.omit(as.character(r)), collapse = " "))
  line <- txt[grepl("^#", trimws(txt))]
  stopifnot(length(line) >= 1)
  topcode <- as.numeric(sub(".*\\$([0-9.]+) per hour.*", "\\1", line[1]))
  stopifnot(!is.na(topcode), topcode >= 50)
  topcode
}

to_num <- function(x) suppressWarnings(as.numeric(x))

cells <- rbindlist(lapply(seq_along(years), function(k) {
  y <- years[k]
  d <- as.data.table(read_excel(raw_files[k], sheet = 1, col_types = "text"))
  # T1 data_loading: required columns present
  stopifnot(all(required_cols %in% names(d)))
  topcode <- read_topcode(raw_files[k])
  d <- d[NAICS %in% source_map$naics]
  # T1: all eight generation industries present every year
  stopifnot(length(unique(d$NAICS)) == 8L)
  d <- d[O_GROUP == "detailed"]
  d[, `:=`(
    year = y,
    hourly_topcode = topcode,
    wage_suppressed = H_MEAN %in% "*",
    wage_topcoded = H_MEAN %in% "#",
    emp_suppressed = TOT_EMP %in% "**",
    emp = to_num(TOT_EMP),
    h_mean = to_num(H_MEAN),
    h_median = to_num(H_MEDIAN),
    h_p10 = to_num(H_PCT10),
    h_p90 = to_num(H_PCT90),
    p90_topcoded = H_PCT90 %in% "#",
    p10_topcoded = H_PCT10 %in% "#",
    median_topcoded = H_MEDIAN %in% "#",
    mean_prse = to_num(MEAN_PRSE)
  )]
  d[, .(year, naics = NAICS, naics_title = NAICS_TITLE, occ_code = OCC_CODE,
        occ_title = OCC_TITLE, emp, h_mean, h_median, h_p10, h_p90, mean_prse,
        wage_suppressed, wage_topcoded, emp_suppressed, p90_topcoded,
        p10_topcoded, median_topcoded,
        hourly_topcode)]
}))

# T2 analytic_sample: one row per occupation-industry-year, detailed only
stopifnot(!anyDuplicated(cells[, .(year, naics, occ_code)]))
stopifnot(all(grepl("^[0-9]{2}-[0-9]{4}$", cells$occ_code)))

cells <- merge(cells, source_map, by = "naics", all.x = TRUE)

# Broad occupation categories from SOC major groups (fixed before estimation)
major <- as.integer(substr(cells$occ_code, 1, 2))
cells[, occ_major := major]
cells[, occupational_group := fcase(
  occ_major %in% c(11L, 13L), "Management, business, and financial",
  occ_major %in% 15:29, "Professional and technical",
  occ_major %in% 31:43, "Office, sales, and service",
  occ_major %in% 45:49, "Construction, installation, maintenance, and repair",
  occ_major %in% 51:53, "Production and transportation",
  default = NA_character_
)]
# T3 variable_construction: every cell has an occupational group
stopifnot(!anyNA(cells$occupational_group))

# Deflate to May 2025 dollars
cells[, cpi_factor := cpi_base / cpi_may[as.character(year)]]
cells[, `:=`(
  real_hmean = h_mean * cpi_factor,
  real_hmedian = h_median * cpi_factor,
  real_p10 = h_p10 * cpi_factor,
  real_p90 = h_p90 * cpi_factor
)]
# Harmonized P90 censoring: treat values at or above $100 nominal as censored
# in every year (the published ceiling was $100 through 2024 and $115 in 2025).
cells[, p90_censored := p90_topcoded | (!is.na(h_p90) & h_p90 >= 100)]
cells[p90_censored == TRUE, real_p90 := NA_real_]

cells[, `:=`(
  log_real_hmean = log(real_hmean),
  log_real_hmedian = log(real_hmedian),
  log_real_p10 = log(real_p10),
  log_real_p90 = log(real_p90)
)]
# T3: deflation check
chk <- cells[!is.na(h_mean)]
stopifnot(isTRUE(all.equal(chk$real_hmean, chk$h_mean * cpi_base / cpi_may[as.character(chk$year)],
                           check.attributes = FALSE)))
stopifnot(all(cells[naics %in% c("221112", "221113"), renewable] == 0L))
stopifnot(all(cells[naics %in% c("221111", "221114", "221115", "221116", "221117"), renewable] == 1L))

# Analytic flag: seven analytic industries, published wage and employment
cells[, analytic := naics != "221118" & !is.na(h_mean) & !is.na(emp) & emp > 0]

# T4 missingness: special-code counts consistent with codebook checks
stopifnot(all(is.na(cells[wage_suppressed | wage_topcoded, h_mean])))
stopifnot(all(is.na(cells[emp_suppressed == TRUE, emp])))

coverage <- cells[, .(
  detailed_cells = .N,
  wage_suppressed = sum(wage_suppressed),
  wage_topcoded = sum(wage_topcoded),
  employment_suppressed = sum(emp_suppressed),
  p10_topcoded = sum(p10_topcoded),
  median_topcoded = sum(median_topcoded),
  p90_censored = sum(p90_censored, na.rm = TRUE),
  analytic_cells = sum(analytic),
  analytic_employment = sum(emp[analytic], na.rm = TRUE)
), by = .(year, naics, generation_source, renewable)][order(year, naics)]

fwrite(cells[order(year, naics, occ_code)],
       file.path("data", "processed", "oews-generation-cells.csv"))
fwrite(coverage, file.path("tables", "cell-coverage.csv"))

cat("cells:", nrow(cells), " analytic:", sum(cells$analytic),
    " top-codes:", paste(unique(cells$hourly_topcode), collapse = "/"), "\n")
