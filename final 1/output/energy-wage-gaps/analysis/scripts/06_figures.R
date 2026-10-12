# 06_figures.R
# Coefficient figures from the main models:
#   Figure 2: source-specific gaps vs. fossil fuel (S04)
#   Figure 3: renewable gap by year, within occupation (S06) and raw (S08)
#   Figure 4: renewable gap by broad occupation category (S05)
# Gaps are shown as percent differences, 100 * (exp(b) - 1), with 95% CIs.
# Run from the project root (after 03 and 04).

suppressPackageStartupMessages({
  library(data.table)
  library(ggplot2)
})
source(file.path("analysis", "scripts", "viz_setting.R"))

# PDF device without creation timestamps (byte-reproducible figures)
pdf_device <- function(filename, ...) grDevices::pdf(file = filename, ..., timestamp = FALSE)

est <- fread(file.path("analysis", "outputs", "main-model-estimates.csv"))
pct <- function(b) 100 * (exp(b) - 1)
est[, `:=`(pct_low = pct(conf_low), pct_high = pct(conf_high))]
dir.create("figures", showWarnings = FALSE)
save_both <- function(p, stem, w = 7, h = 4.5) {
  ggsave(file.path("figures", paste0(stem, ".pdf")), p, width = w, height = h, device = pdf_device)
  ggsave(file.path("figures", paste0(stem, ".png")), p, width = w, height = h, dpi = 300)
  stopifnot(file.exists(file.path("figures", paste0(stem, c(".pdf", ".png")))))
}

# Figure 2: generation sources relative to fossil fuel
f2 <- est[spec_id == "S04"]
f2[, source := sub("generation_source::", "", term)]
f2[, source := factor(source, levels = rev(c("Nuclear", "Hydroelectric", "Solar", "Wind", "Geothermal", "Biomass")))]
p2 <- ggplot(f2, aes(x = pct_gap, y = source)) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_errorbar(aes(xmin = pct_low, xmax = pct_high), width = 0.2, orientation = "y") +
  geom_point(size = 2.5) +
  labs(x = "Wage difference vs. fossil fuel, same occupation and year (%)", y = NULL) +
  theme_Publication(base_family = "sans")
save_both(p2, "fig2-source-gaps")

# Figure 3: gap by year, within occupation (S06) and raw (decomposition)
f3w <- est[spec_id == "S06"]
f3w[, year := as.integer(sub("year::([0-9]{4}):renewable", "\\1", term))]
f3w <- f3w[, .(year, gap = pct_gap, low = pct_low, high = pct_high,
               series = "Within occupation and year")]
dec <- fread(file.path("tables", "table4-decomposition.csv"))
dec <- dec[grepl("^[0-9]{4}$", year)]
f3r <- dec[, .(year = as.integer(year), gap = pct(raw_gap),
               low = pct(raw_gap - 1.96 * raw_gap_se), high = pct(raw_gap + 1.96 * raw_gap_se),
               series = "Raw (all occupations)")]
f3 <- rbind(f3w, f3r)
p3 <- ggplot(f3, aes(x = year, y = gap, colour = series, shape = series)) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_pointrange(aes(ymin = low, ymax = high), position = position_dodge(width = 0.3)) +
  geom_line(position = position_dodge(width = 0.3)) +
  scale_colour_Publication(name = NULL) + scale_shape_discrete(name = NULL) +
  labs(x = "Survey year (May)", y = "Renewable vs. non-renewable wage gap (%)") +
  theme_Publication(base_family = "sans")
save_both(p3, "fig3-gap-by-year")

# Figure 4: gap by broad occupation category
f4 <- est[spec_id == "S05"]
f4[, group := sub("occupational_group::(.*):renewable", "\\1", term)]
p4 <- ggplot(f4, aes(x = pct_gap, y = reorder(group, pct_gap))) +
  geom_vline(xintercept = 0, linetype = "dashed") +
  geom_errorbar(aes(xmin = pct_low, xmax = pct_high), width = 0.2, orientation = "y") +
  geom_point(size = 2.5) +
  labs(x = "Renewable vs. non-renewable wage gap within occupation and year (%)", y = NULL) +
  theme_Publication(base_family = "sans")
save_both(p4, "fig4-gap-by-occupation-group", w = 8)

stopifnot(nrow(f2) == 6L, nrow(f3w) == 5L, nrow(f4) == 5L)
cat("figures written\n")
