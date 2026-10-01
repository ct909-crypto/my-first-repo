# 06_figures.R — Figures 1-3 and robustness forest.
# Inputs : analysis/output/main-contrasts.csv, tables/table3-decomposition.csv,
#          analysis/output/tech-by-year.csv, analysis/output/major-group-gaps.csv,
#          tables/tableA3-robustness.csv
# Outputs: figures/fig1-gap-trend.{pdf,png}, figures/fig2-technology.{pdf,png},
#          figures/fig3-occupation.{pdf,png}, figures/figA1-robustness.{pdf,png}
source("analysis/scripts/00_functions.R")
source("analysis/scripts/viz_setting.R")
dir.create("figures", showWarnings = FALSE)
# cairo is unavailable on this machine (no XQuartz); write PDFs with the base pdf device.
save_fig <- function(p, name, width = 6.5, height = 4.5, dpi = 300) {
  ggsave(file.path("figures", paste0(name, ".pdf")), plot = p, device = grDevices::pdf, width = width, height = height)
  ggsave(file.path("figures", paste0(name, ".png")), plot = p, device = "png", width = width, height = height, dpi = dpi)
}
Sys.setenv(OUTPUT_ROOT = ".")
BASE_FAMILY <- "Helvetica"
th <- theme_Publication(base_size = 11, base_family = BASE_FAMILY)
pct <- function(x) 100 * (exp(x) - 1)
res <- read.csv("analysis/output/main-contrasts.csv")
t3 <- read.csv("tables/table3-decomposition.csv")

# Figure 1: raw gap vs within-occupation gap (decomposition) and M6 regression gap, by year
f1 <- bind_rows(
  t3 %>% filter(grepl("that year", support)) %>% transmute(year, series = "Raw gap (all occupations)", est = raw, lo = raw_lo, hi = raw_hi),
  t3 %>% filter(grepl("that year", support)) %>% transmute(year, series = "Within-occupation gap (decomposition)", est = within, lo = within_lo, hi = within_hi),
  res %>% filter(grepl("^Renewable gap 20", contrast)) %>% transmute(year = as.integer(sub(".* ", "", contrast)), series = "Within-occupation gap (regression, M6)", est = estimate, lo = ci_low, hi = ci_high))
p1 <- ggplot(f1, aes(x = year, y = pct(est), colour = series, shape = series)) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_pointrange(aes(ymin = pct(lo), ymax = pct(hi)), position = position_dodge(width = 0.45)) +
  geom_line(aes(group = series), position = position_dodge(width = 0.45), alpha = 0.6) +
  scale_colour_Publication() + scale_x_continuous(breaks = YEARS, labels = paste("May", YEARS)) +
  labs(x = NULL, y = "Renewable minus nonrenewable wage (%)", colour = NULL, shape = NULL) + th +
  theme(legend.position = "right", legend.text = element_text(size = 8))
save_fig(p1, "fig1-gap-trend", width = 7, height = 4)

# Figure 2: technology gaps vs fossil fuel (pooled), and by year
f2a <- res %>% filter(family == "H2", grepl("vs fossil", contrast)) %>%
  mutate(tech = sub(" vs fossil fuel", "", contrast), tech = factor(tech, levels = rev(c("Nuclear", "Hydroelectric", "Wind", "Solar", "Biomass/geothermal"))))
p2a <- ggplot(f2a, aes(x = pct(estimate), y = tech)) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_pointrange(aes(xmin = pct(ci_low), xmax = pct(ci_high))) +
  labs(x = "Relative to fossil fuel (%)", y = NULL, title = "Pooled 2021-2025") + th
ty <- read.csv("analysis/output/tech-by-year.csv") %>%
  mutate(tech = sub("tech_year::(.*):(20[0-9]{2})", "\\1", term), year = as.integer(sub(".*:(20[0-9]{2})$", "\\1", term)))
p2b <- ggplot(ty, aes(x = year, y = pct(Estimate), colour = tech, shape = tech)) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_pointrange(aes(ymin = pct(Estimate - 1.96 * `Std..Error`), ymax = pct(Estimate + 1.96 * `Std..Error`)),
                  position = position_dodge(width = 0.5)) +
  geom_line(position = position_dodge(width = 0.5), alpha = 0.6) +
  scale_colour_Publication() + scale_x_continuous(breaks = YEARS) +
  labs(x = NULL, y = "Wage relative to fossil fuel (%)", colour = NULL, shape = NULL, title = "By estimate year") + th +
  theme(legend.position = "bottom")
save_fig(assemble_panels(p2a, p2b, ncol = 2), "fig2-technology", width = 10, height = 4.2)

# Figure 3: renewable gap by occupational class and by major group
f3a <- res %>% filter(family == "H3", grepl("^Renewable gap:", contrast)) %>%
  mutate(cls = sub("Renewable gap: ", "", contrast))
p3a <- ggplot(f3a, aes(x = pct(estimate), y = reorder(cls, estimate))) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_pointrange(aes(xmin = pct(ci_low), xmax = pct(ci_high))) +
  labs(x = "Renewable minus nonrenewable wage (%)", y = NULL, title = "Occupational class") + th
# Major groups shown only if identified by at least three distinct occupations
# observed in both sectors in the same year (fewer clusters give degenerate CIs).
cells <- readRDS("analysis/output/cells.rds") %>% filter(!is.na(renewable))
mg_n <- cells %>% group_by(year, occ, soc_major) %>%
  summarise(ok = any(renewable == 1) & any(renewable == 0), .groups = "drop") %>%
  filter(ok) %>% group_by(soc_major) %>% summarise(n_occ = n_distinct(occ), .groups = "drop")
mg <- read.csv("analysis/output/major-group-gaps.csv") %>%
  mutate(grp = sub("soc_major::(.*):renewable", "\\1", term)) %>%
  left_join(mg_n, by = c("grp" = "soc_major")) %>%
  filter(is.finite(`Std..Error`), n_occ >= 3) %>%
  mutate(grp = paste0(grp, " (", n_occ, ")"))
write.csv(mg, "analysis/output/major-group-gaps-shown.csv", row.names = FALSE)
p3b <- ggplot(mg, aes(x = pct(Estimate), y = reorder(grp, Estimate))) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_pointrange(aes(xmin = pct(Estimate - 1.96 * `Std..Error`), xmax = pct(Estimate + 1.96 * `Std..Error`))) +
  labs(x = "Renewable minus nonrenewable wage (%)", y = NULL, title = "Major occupational group") + th
save_fig(assemble_panels(p3a, p3b, ncol = 2), "fig3-occupation", width = 11, height = 4.6)

# Figure A1: robustness forest for headline gap
rob <- read.csv("tables/tableA3-robustness.csv")
pA <- ggplot(rob, aes(x = pct(estimate), y = factor(check, levels = rev(check)))) +
  geom_vline(xintercept = 0, linetype = "dashed", colour = "grey50") +
  geom_pointrange(aes(xmin = pct(ci_low), xmax = pct(ci_high))) +
  labs(x = "Within-occupation renewable wage gap (%)", y = NULL) + th
save_fig(pA, "figA1-robustness", width = 6.5, height = 6)
