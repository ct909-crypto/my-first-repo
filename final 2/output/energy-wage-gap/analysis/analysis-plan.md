# Analysis Plan (Phase 5 — planned, no execution)

This plan compiles the Phase 3 design (`design/design-blueprint.md`, `design/model-specs.json`) and the Phase 4 measurement plan (`data/measurement-plan.md`, `data/variable-dictionary.csv`) into executable specifications, scripts, and tests. **No execution has taken place.** No data have been modeled, and no result, table, or figure registry exists. Every spec in `analysis/spec-registry.csv` and every script in `analysis/scripts-inventory.json` has status `planned`. The next step is the Phase 6 pre-execution review of the planned scripts, specs, and tests, followed by the Phase 7 premortem.

## Manuscript-facing methods brief

**Source data and sample size.** The five OEWS May national industry-specific files (2021–2025) contain 2,096 detailed-occupation cells in the eight private electric power generation industries (NAICS 221111–221118). Of these, 2,006 have a published mean wage and employment. The analytic sample for the main models keeps detailed-occupation cells in the seven technology-specific industries (221111–221117). "Other electric power generation" (221118) enters only in sensitivity analyses. We drop cells whose wage or employment BLS suppressed. The final denominator is the set of published cells, and a sample-flow table and an industry-year coverage table report it (published employment as a share of each industry's total: 45–98 percent).

**Method family and fit.** The outcome is the log of the cell's mean annual wage in May-2025 dollars. It is continuous and right-skewed in levels, so it is modeled in logs. The data are repeated national cross-sections of job cells, not microdata, and the question is descriptive: what do renewable and nonrenewable establishments pay for the same classified job? We therefore use weighted least squares. Each cell is weighted by its employment so that estimates describe the average worker, and occupation-by-year fixed effects restrict every comparison to the same detailed occupation within the same estimate.

**Estimating equations.**
- **Headline model (M3):** ln w_jot = β·Renewable_j + γ_ot + ε_jot, where *j* is the industry, *o* the detailed occupation, and *t* the estimate year.
- **Technology (M4):** replaces Renewable_j with technology indicators (reference = fossil fuel).
- **Occupational class (M5):** interacts Renewable_j with occupational class.
- **Trend (M6):** interacts Renewable_j with year.
- **Decomposition (D1):** a Kitagawa decomposition splits each year's raw gap into occupational composition and a within-occupation term, W_t = Σ_o m_ot(ln w^R_ot − ln w^N_ot), with midpoint employment shares renormalized on common-support occupations. W_t is the headline average-worker estimand, and M3 is its regression counterpart.

**Inference.**
- Standard errors are clustered by detailed occupation, since the same occupation appears across industries and years.
- Only 59–77 occupations identify the renewable contrast in any year, so every pre-specified test also gets a restricted wild cluster bootstrap p-value: Webb weights, 9,999 draws, seed 20260930.
- Technology contrasts are Holm-adjusted.
- Equivalence for hydro and for H4 persistence uses two one-sided tests with a ±0.05 log-point margin.
- The trend test compares the May 2021 estimate with the May 2025 estimate (primary) and the May 2024 estimate (secondary). Neither shares survey panels with May 2021; adjacent years do share panels, so they are described rather than tested.

**Robustness and interpretation.** We run sixteen pre-specified checks (R1–R16):
- balanced cells;
- precision and unweighted estimation;
- median, 10th-percentile, and 90th-percentile outcomes;
- reclassifying "other", hydroelectric, and nuclear generation;
- dropping top-coded and imprecise cells;
- nominal wages;
- a two-period sample;
- hourly wages;
- dropping influential occupations;
- clustering by industry × occupation cell.

If the headline gap keeps its sign and roughly its size across these checks, H1 is reported as robust. If a check flips the sign or halves the gap, the manuscript names that choice as consequential.

## Model plan and hypothesis/spec mapping

| Hypothesis | Specs | Decision rule |
|---|---|---|
| H1 within-occupation gap < 0 | S02, S03, S09, R01–R16 | W and M3 negative, 95% CI excludes 0 |
| H2 technology ordering | S04, S08 | solar and wind < 0 (Holm); hydro equivalent to fossil (TOST ±0.05); nuclear ≥ fossil |
| H3 larger blue-collar gap | S05, S06 | blue-collar minus professional/managerial < 0, p < .05 (WCR) |
| H4 no narrowing | S07, S11, R11 | narrowed / widened / stable (90% CI within ±0.05) / inconclusive |
| H5 composition not explaining gap | S01, S03, S09, S10 | composition term ≥ 0 |

## Variable-construction plan

Variables are built exactly as defined in `data/variable-dictionary.csv`:
- ln_real_wage, ln_real_hourly, and the percentile outcomes are deflated with CPI-U May values (`analysis/reference/cpi_u_may.csv`);
- renewable and technology come from NAICS;
- occ_class and soc_major come from the SOC code;
- year comes from the file;
- occ is the 6-digit SOC code;
- emp is TOT_EMP.

Top-coded "#" values are set to that year's threshold ($208,000 in 2021; $239,200 in 2022–2025) and flagged.

## Dataset-design decision

Published OEWS cells already incorporate the survey's sampling weights. No design variables (strata, PSUs, establishment IDs) are released, and none are needed for cell-level analysis. We use cell employment as an analytic weight, cluster inference on detailed occupation, and handle the panel structure of the OEWS sample (six semiannual panels pooled per estimate) by testing change only between non-overlapping estimates. Denominators are published cells, and coverage is reported.

## Missing-data plan and post-restriction diagnostics

Missingness is BLS suppression (wage "*", employment "**"), not item nonresponse. It has no skip logic and no inapplicable codes. The plan:
- drop suppressed cells;
- impute nothing;
- report post-restriction coverage by industry and year;
- check denominators against industry totals;
- run the balanced-cell sensitivity analysis (R01) and the continuing-occupation decomposition (S11), which bound how much changing publication affects the trend.

Complete-case analysis at the cell level is therefore paired with explicit sensitivity specifications.

## Outcome-family ladder

The headline model is WLS on log mean wages. The ladder adds:
- median (R04), P10 (R05a), and P90 (R05b) outcomes, with top-code censoring reported for P90;
- a check that drops top-coded cells (R08);
- hourly wages (R14).

Distributional diagnostics (the log-wage distribution by sector and the share of top-coded values) are produced in 02_descriptives.R.

## Script inventory

The scripts are planned but not yet written to disk. They are listed in `analysis/scripts-inventory.json`, in this order:
1. `00_functions.R`
2. `01_build_analytic_data.R`
3. `02_descriptives.R`
4. `03_main_models.R`
5. `04_decomposition.R`
6. `05_robustness.R`
7. `06_figures.R`
8. `07_registries.R`

Each script depends only on earlier ones. The environment is R with readxl, dplyr, tidyr, fixest, modelsummary, and ggplot2, using seed 20260930. Figures use the canonical `viz_setting.R`, copied at Phase 8.

## Test plan

Eight planned tests cover data loading, the analytic sample, variable construction, missingness, model specification for every spec ID, and the output registries. See `test_inventory`.

## Controls

The design has no individual-level covariates. Comparisons adjust only for detailed occupation and estimate year, entered as fixed effects and listed as covariates in the spec registry. Mechanism variables (establishment size, ownership, union coverage) are deliberately not controlled, both because they are on the hypothesized pathway and because OEWS does not publish them.

## Pre-execution review handoff

Phase 6 must review every planned script, test, and spec against the design and data artifacts before any script runs. Particular attention goes to:
- the wild bootstrap implementation;
- the decomposition identity;
- the renewable coding;
- the non-overlapping-year contrast.
