# 04_decomposition.R
# Spec S08: decompose the raw renewable/non-renewable gap in employment-weighted
# mean log real hourly wages, year by year, into
#   (1) occupational composition among occupations present in both groups,
#   (2) within-occupation wage differences among those occupations, and
#   (3) occupations present in only one group (non-overlap term).
# (1) + (2) is a Kitagawa (1955) split of the common-occupation gap; the three
# terms sum exactly to the raw gap. Uncertainty: occupation-cluster bootstrap.
# Run from the project root.

suppressPackageStartupMessages(library(data.table))
set.seed(20261010)

cells <- fread(file.path("data", "processed", "oews-generation-cells.csv"),
               colClasses = list(character = c("naics", "occ_code")))
a <- cells[analytic == TRUE, .(year, occ_code, renewable, emp, log_real_hmean)]

decompose_year <- function(d) {
  # occupation-level employment and employment-weighted mean log wage by group
  og <- d[, .(emp = sum(emp), w = sum(emp * log_real_hmean) / sum(emp)),
          by = .(occ_id, renewable)]
  tot <- og[, .(tot = sum(emp)), by = renewable]
  og <- merge(og, tot, by = "renewable")
  og[, share := emp / tot]
  mean_R <- og[renewable == 1L, sum(share * w)]
  mean_N <- og[renewable == 0L, sum(share * w)]
  raw <- mean_R - mean_N
  common <- intersect(og[renewable == 1L, occ_id], og[renewable == 0L, occ_id])
  wide <- dcast(og[occ_id %in% common], occ_id ~ renewable, value.var = c("emp", "w"))
  setnames(wide, c("emp_0", "emp_1", "w_0", "w_1"), c("emp_N", "emp_R", "w_N", "w_R"))
  wide[, `:=`(s_R = emp_R / sum(emp_R), s_N = emp_N / sum(emp_N))]
  comp <- wide[, sum((s_R - s_N) * (w_R + w_N) / 2)]
  within <- wide[, sum((s_R + s_N) / 2 * (w_R - w_N))]
  data.table(raw_gap = raw, composition = comp, within_occupation = within,
             non_overlap = raw - comp - within,
             common_occupations = length(common),
             renewable_emp_share_common = og[renewable == 1L & occ_id %in% common, sum(share)],
             nonrenewable_emp_share_common = og[renewable == 0L & occ_id %in% common, sum(share)])
}

run_all <- function(d) d[, decompose_year(.SD), by = year]

a[, occ_id := occ_code]
point <- run_all(a)

occs <- unique(a$occ_code)
B <- 500L
boot <- rbindlist(lapply(seq_len(B), function(b) {
  draw <- sample(occs, length(occs), replace = TRUE)
  bd <- rbindlist(lapply(seq_along(draw), function(k)
    a[occ_code == draw[k]][, occ_id := paste0(draw[k], "#", k)]))
  out <- run_all(bd)
  out[, draw := b]
  out
}))

comp_cols <- c("raw_gap", "composition", "within_occupation", "non_overlap")
se <- boot[, lapply(.SD, sd), by = year, .SDcols = comp_cols]
setnames(se, comp_cols, paste0(comp_cols, "_se"))
res <- merge(point, se, by = "year")

# Pooled (average over years) summary with bootstrap SE
pooled_point <- point[, lapply(.SD, mean), .SDcols = comp_cols]
pooled_boot <- boot[, lapply(.SD, mean), by = draw, .SDcols = comp_cols]
pooled_se <- pooled_boot[, lapply(.SD, sd), .SDcols = comp_cols]
pooled <- cbind(data.table(year = "2021-2025 average"), pooled_point,
                setnames(copy(pooled_se), paste0(comp_cols, "_se")))
res[, year := as.character(year)]
out <- rbind(res, pooled, fill = TRUE)

# Additivity check: components sum to the raw gap
stopifnot(all(abs(point$raw_gap - point$composition - point$within_occupation - point$non_overlap) < 1e-10))
fwrite(out, file.path("tables", "table4-decomposition.csv"))
print(out[, .(year, raw_gap, composition, within_occupation, non_overlap, within_occupation_se)])
