# Code Review Report — energy-wage-gap analysis scripts

- **Review ID:** cr-20261012-energy-wage-gap
- **Date:** 2026-10-12
- **Scope:** `analysis/scripts/` (10 R scripts, 1,130 lines) against `design/design-blueprint.md`
- **Mode requested:** full (6 independent reviewer agents)
- **Mode actually delivered:** SINGLE-REVIEWER fallback (see "Review limitations")
- **Constraints honored:** read-only; no script modified or re-run; no data or results file opened (`*.xlsx`, `*.rds`, output `*.csv`, `data/variable-dictionary.csv`). Only new files were written, all in `code-review/`.

## Review limitations — read first

All 12 reviewer-agent dispatches stopped on API errors before producing output: 6 on Opus 5.5 and 6 retries on Sonnet 5.5, all reporting "safeguards flagged this message". No agent reports exist. This report is one reviewer (the orchestrating session) covering all six dimensions. Consequences:

- **No ★★ markers.** No finding was confirmed independently by a second reviewer.
- The skill's verdict thresholds were designed for six-reviewer coverage. A single reviewer is more likely to miss issues, so "0 CRITICAL" here is weaker evidence than it would be from a full review.
- **Codebook check not done.** `data/variable-dictionary.csv` was blocked by the project's data guard. Recodes were checked against the design blueprint §3–§4 only.
- **UNCERTAIN items.** Where a check depends on package internals that cannot be confirmed by reading (for example `fixest::model.matrix` subsetting or the `obs()` row indices), it is marked UNCERTAIN rather than flagged.

## 1. Script inventory

| # | Script | Lines | Packages | Produces |
|---|---|---|---|---|
| 1 | 00_functions.R | 204 | dplyr, tidyr, fixest | helpers: parse_wage, wcr_test, lincom, tost_equivalent, kitagawa_year, occ_bootstrap |
| 2 | 01_build_analytic_data.R | 93 | readxl | analysis/output/cells.rds, tables/tableA1-sample-flow.csv, tables/tableA2-coverage.csv |
| 3 | 02_descriptives.R | 57 | — | tables/table1-descriptives.{csv,md}, raw-ratio-by-year.csv, outcome-diagnostics.csv |
| 4 | 03_main_models.R | 145 | modelsummary, jsonlite | models.rds, main-contrasts.csv, joint-tests.json, identifying-occupations.csv, tech-by-year.csv, class5-gaps.csv, major-group-gaps.csv, tables/table2-main-regressions.{html,csv,md} |
| 5 | 04_decomposition.R | 75 | — | tables/table3-decomposition.csv, d1-bootstrap.csv, d2-change.csv |
| 6 | 05_robustness.R | 67 | — | tables/tableA3-robustness.csv |
| 7 | 06_figures.R | 86 | ggplot2 (via viz_setting) | figures/fig1–3, figA1 (.pdf/.png), major-group-gaps-shown.csv |
| 8 | 07_registries.R | 48 | — | tables/results-registry.csv, figures/figure-registry.csv |
| 9 | 08_manuscript_tables.R | 83 | — | manuscript/tables/table1/2/3/3b/A1.md |
| 10 | viz_setting.R | 272 | grid, ggplot2, scales | theme and scale helpers |

## 2. Overall scorecard

| Dimension | Critical | Warnings | Info | Result |
|---|---|---|---|---|
| Correctness & logic | 0 | 1 (W9) | 2 | PASS with warnings |
| Robustness | 0 | 3 (W1, W2, W8) | 2 | PASS with warnings |
| Statistical fidelity | 0 | 5 (W3, W4, W5, W6, W7) | 2 | PASS with warnings |
| Reproducibility | 0 | 2 (W10, W11) | 3 | PASS with warnings |
| Style & AI patterns | 0 | 0 | 5 | PASS |
| Data handling | 0 | 0 (W2 is shared with Robustness) | 2 | PASS; codebook check not done |
| **Total (deduplicated)** | **0** | **11** | **16** | |

**Overall grade: B.** **Verdict: FIXES NEEDED** (more than 5 warnings).

No finding is expected to change any coefficient estimate. The warnings concern:
- which p-value or CI is reported in tables and the results registry;
- one mislabelled manuscript-table column;
- a missing pooled estimand for the H1 decision rule;
- an always-true assertion;
- reproducibility gaps.

## 3. Fix checklist

### CRITICAL
None confirmed (single reviewer; see limitations).

### WARNINGS

- [ ] **[W1] 03_main_models.R:34–36 — the model-spec assertion can never fail**
  `stopifnot(!is.null(weights(m)), identical(m$call$cluster, CL) || TRUE)`
  `|| TRUE` makes the cluster check always pass. The loop also skips `m5b`, `m5c` and `m6lin`.
  Fix: remove `|| TRUE` and compare the clustering actually used, e.g. `identical(m$call$cluster, CL)` or check `attr(vcov(m), "type")`. Loop over all fitted models.

- [ ] **[W2] 00_functions.R:15–16 — top-code thresholds are typed in, not read from the files**
  `TOPCODE <- c(\`2021\` = 208000, ...)`, `TOPCODE_HOURLY <- ...`
  Design §3.3 says the thresholds are "read programmatically from each file's Field Descriptions sheet". If a value is wrong, every `#` cell gets the wrong wage. That affects R8, R5-P90, and the top-coded share of the outcome. The values themselves are UNVERIFIABLE without opening the data.
  Fix: parse the thresholds from the Field Descriptions sheet in 01, or at least `stopifnot()` that the typed values match it. Otherwise, amend design §3.3.

- [ ] **[W3] 07_registries.R:19, 25 — registry records the raw bootstrap p-value for H2, not Holm**
  `p_value = ifelse(is.na(r$p_wcr), r$p_cr1, r$p_wcr)` with `S04 = pick("S04", "Solar vs fossil")`
  Design §5 and the multi-comparison policy say "solar and wind must survive Holm". The registry stores the unadjusted WCR p-value even though `p_holm` exists in main-contrasts.csv. Manuscript Table 2 (08:53) uses Holm, so the two artifacts disagree.
  Fix: in `pick()`, prefer `p_holm` when it is not NA, and add a `p_type` column.

- [ ] **[W4] 07_registries.R:26 — the S06 "largest major-group gap" is taken from all major groups, including ones 06_figures.R filters out**
  `r <- mg[which.min(mg$Estimate), ]`
  `mg` is the unfiltered major-group-gaps.csv. 06_figures.R:71 drops groups with non-finite SE or fewer than 3 identifying occupations as degenerate. The registry can therefore record a degenerate or one-occupation estimate as the headline. It also reports that extreme pick's own p-value with no correction for having been selected.
  Fix: apply the same `n_occ >= 3` and finite-SE filter (or read `major-group-gaps-shown.csv`). Label the row descriptive and drop or flag its p-value.

- [ ] **[W5] 08_manuscript_tables.R:53–56 — Table 2's single "p" column mixes three kinds of p-value without saying so**
  `p_show <- ifelse(!is.na(t2$p_holm), t2$p_holm, ifelse(!is.na(t2$p_wcr), t2$p_wcr, t2$p_cr1))`
  - Rows 3–7 show Holm-adjusted WCR p-values.
  - The M3, M5 and M6 change rows show raw WCR p-values.
  - The yearly M6 gaps and the raw M1 row show CR1 p-values.

  The column header is just `p`, and the script writes no table note.
  Fix: add a `p type` column or footnote markers, plus a note stating which rows are Holm, WCR (9,999 Webb draws) or CR1.

- [ ] **[W6] 06_figures.R:47, 76 and 07_registries.R:26, 28 — some CIs use ±1.96 instead of t(G−1)**
  `Estimate - 1.96 * \`Std..Error\``
  `lincom()` (00:148–150) uses `qt(., G−1)`, but the M7 technology-by-year CIs (Fig 2b), the major-group CIs (Fig 3b), and registry rows S06/S08 use the normal 1.96. Major-group estimates rest on as few as 3 occupations, so these intervals are too narrow and inconsistent with the other panels.
  Fix: compute the CIs with `confint(m, level = .95)` from the saved models (fixest uses the same t(G−1) df), or export the df with the coefficient tables.

- [ ] **[W7] 04_decomposition.R (whole file) — the pooled W needed for the H1 decision rule is never computed**
  Design §5 says: "H1: supported if W (pooled) and the M3 coefficient are both negative with 95% CIs excluding 0." The script computes W for each year (`decomp_all`) but no pooled W or pooled CI. The registry's S09 uses the 2025 W instead (07:29).
  Fix: add a pooled W (for example, average the yearly W_t with stated weights) with an occupation-bootstrap CI, or amend the decision rule in the design.

- [ ] **[W8] 00_functions.R:88 — `wcr_test` always uses `emp` as the weight, whatever the model was fitted with**
  `w <- if (is.null(weights(model))) rep(1, nrow(d)) else d$emp`
  This is correct for every current call (all M3–M6 models are weighted by emp). If it is ever called on a precision-weighted model (R2 uses `w_prec`), the bootstrap would silently use the wrong weights.
  Fix: `w <- if (is.null(weights(model))) rep(1, nobs(model)) else weights(model)`.

- [ ] **[W9] 08_manuscript_tables.R:64 — a Table 3 column is mislabelled**
  `` `Occupations off support` = f3(t3$off_support) ``
  `off_support` is a log-point residual (raw − raw_common, 00:186), not a count of occupations. Readers will take it as a count.
  Fix: rename the column to "Off-support residual (log points)".

- [ ] **[W10] Pipeline-wide — package versions are not recorded**
  Design §7 says "package versions are logged". No script calls `sessionInfo()` or `writeLines(capture.output(sessionInfo()))`, and there is no renv.lock, DESCRIPTION, or similar in the project root. fixest small-sample defaults and the modelsummary output format vary across versions.
  Fix: add `renv::snapshot()`, or write `sessionInfo()` to `analysis/output/session-info.txt` at the end of each script or in a runner.

- [ ] **[W11] Pipeline-wide — there is no runner script**
  The 8 scripts depend on each other's outputs (01 → 02 … 08), and 02 reads `tables/tableA2-coverage.csv` written by 01. Execution order exists only in the file-name prefixes. No `run_all.R` or Makefile was found in the project root or `analysis/scripts/`, so a replicator may run against stale outputs.
  Fix: add `analysis/run_all.R` that sources 01–08 in order from the project root, after the session-info capture from W10.

## 4. INFO items (may fix)

| ID | Location | Note |
|---|---|---|
| I1 | 00:84–85 | `wcr_test` calls `set.seed(seed)` on every call, so every contrast uses the same Webb draw matrix (when G matches). Valid, but the p-values of different contrasts are not independent Monte Carlo draws; worth a sentence in the methods. |
| I2 | 05:19–21 | `fit_pair` fits the M6 model twice: once to get the names, once to use it. Fit it once and reuse. |
| I3 | 01:45, 50 | Hard-coded audit counts (`n_wage_supp == 19`, `n_emp_supp == 71`, `nrow(usable) == 2006`). Good as a tie to the Phase 4 audit, but any BLS file revision halts the pipeline. Keep them, with a comment naming the file vintage. |
| I4 | 02:29 | `bind_rows(mutate(., ...))` works only because magrittr passes the left-hand side as the first argument when `.` is nested. It is correct but easy to break. Write `bind_rows(x, mutate(x, ...))` explicitly. |
| I5 | 08:65 | Table 3 shows only the renewable off-support employment share. Design §5 D1 asks for the share "by year and sector" (the nonrenewable share `offsup_share_n` is computed but not shown). |
| I6 | 02:42–48, 08:23–33 | The markdown Table 1 omits the coverage column the display plan (§7) lists. It is computed in table1-descriptives.csv but not shown. |
| I7 | 00:20 | `dplyr::recode()` is superseded. `case_match()` or a named lookup vector is preferred. |
| I8 | 00:86, 02:52 | Local variables `obs` and `diag` shadow `fixest::obs` and `base::diag`. Harmless here; rename to avoid confusion. |
| I9 | 03:102–113 | The M5 and M6 joint-Wald blocks are copy-pasted. Factor them into a helper. Note they assume the coefficient vector contains only the interaction terms (true for the current formulas). |
| I10 | 03:134–141 | The same `modelsummary()` call is repeated 3× for 3 output formats. Loop over the formats. |
| I11 | 06:11–15 | `save_fig` re-defines the one in viz_setting.R (which uses `cairo_pdf`). `Sys.setenv(OUTPUT_ROOT = ".")` changes global session state. Both are fine standalone but confusing if scripts are sourced together. |
| I12 | viz_setting.R | Several helpers are unused by 06 (`save_fig_cmyk`, `preview_grayscale`, the diverging/continuous scales). The file defaults to `cairo_pdf` and "Helvetica Neue", which the 06 comment says is unavailable on this machine. |
| I13 | all scripts | All paths are relative to the project root, so the scripts must run with working directory = `output/energy-wage-gap`. Document this, or use `here::here()`. |
| I14 | 00:59 | `analysis/reference/cpi_u_may.csv` is hand-placed. Design §3.5 documents the series and retrieval date, but no script fetches or checksums it. |
| I15 | 03:28 | `m6lin` coefficient is picked positionally (`cn(m6lin)[2]`). Use the explicit name. |
| I16 | 01:33, 39 | Top-code flags exist only for the mean and P90. Medians and P10 set to the top code (via `parse_wage`) are not flagged, which matters only if any such cells exist (UNVERIFIABLE without data). |

## 5. Items checked and cleared

- **NAICS coding:** renewable = 221111, 221114–221117; nonrenewable = 221112–221113; 221118 is NA, excluded from the main sample, and handled by R6/R7. Matches design §4. Assertions at 01:71–73 enforce it.
- **SOC class mappings:** `occ_class` (00:42–48) and `occ_class5` (00:50–57) match the design table.
- **Real wages:** the deflator converts to May-2025 dollars (`cpi[2025]/cpi[t]`), with a 2025 = 1 assertion (01:75).
- **Special codes:** `*` and `**` become NA, and `#` becomes the year's top code (`parse_wage`); this was checked by reading the code. Detailed-occupation-only rows (01:25) and the OWN_CODE 5 assertion (01:20) match design §3.1 and §3.7.
- **Wild cluster bootstrap (`wcr_test`):** the restricted estimate `b_r = b − A⁻¹R(R'b−r)/(R'A⁻¹R)` is correct. The weighted fixed effects are partialled out (FWL), and the weighted scores are clustered by occupation. Webb six-point weights are used, with a symmetric two-sided p-value, matching design §5. Row alignment is guarded by `stopifnot` (00:91). UNCERTAIN: exact `model.matrix(type=)` subsetting is fixest-internal, but the assertion would catch a mismatch.
- **`lincom`:** uses df = G−1 via `fitstat(m, "g")`, consistent with fixest's clustered t-test. TOST uses the 90% CI (±0.05), as the design specifies.
- **Pre-specified contrasts:** WCR is applied to M3, the 5 technology-vs-fossil contrasts (with Holm across those 5), blue-collar minus professional (M5), and 2025−2021 and 2024−2021 (M6), as the design lists.
- **Coefficient-name lookups:** `nm4`, `nm5` and `nm6` use fixed-string `grepl` on fixest `i()` names; each pattern matches exactly one term under the current factor levels.
- **Kitagawa decomposition:** the identity is asserted (00:185, 04:27) and the D2 identity too (04:52). The occupation-cluster bootstrap relabels duplicated occupations and re-applies the common-support rule in each resample, as the design specifies.
- **Robustness R1–R16:** all present with spec_ids matching analysis/spec-registry.csv (R05a/R05b included). R12 groups hydro with the legacy technologies, as specified.
- **M7:** excludes biomass/geothermal, as specified.

## 6. Per-script scorecard

| Script | Lines | Critical | Warning | Info | Grade |
|---|---|---|---|---|---|
| 00_functions.R | 204 | 0 | 2 (W2, W8) | 4 | B |
| 01_build_analytic_data.R | 93 | 0 | 0 | 2 | A |
| 02_descriptives.R | 57 | 0 | 0 | 3 | A |
| 03_main_models.R | 145 | 0 | 1 (W1) | 3 | A |
| 04_decomposition.R | 75 | 0 | 1 (W7) | 0 | A |
| 05_robustness.R | 67 | 0 | 0 | 1 | A |
| 06_figures.R | 86 | 0 | 1 (W6) | 1 | A |
| 07_registries.R | 48 | 0 | 3 (W3, W4, W6) | 0 | B |
| 08_manuscript_tables.R | 83 | 0 | 2 (W5, W9) | 2 | B |
| viz_setting.R | 272 | 0 | 0 | 1 | A |
| Pipeline-wide | — | 0 | 2 (W10, W11) | 2 | — |

Grades follow the skill rules: A = 0 critical and ≤1 warning; B = 0 critical and 2–3 warnings. W6 is counted under both 06 and 07.

## 7. Top 3 most impactful issues

1. **W3 + W5: H2 inference is reported inconsistently.** The registry (raw WCR p-value) and manuscript Table 2 (Holm) disagree for the solar and wind contrasts, and Table 2 does not say which p-value each row shows. Under the pre-specified rule, H2 support depends on Holm, so a reader or the auto-research pipeline can adjudicate H2 from the wrong number.
2. **W7: the H1 decision rule cannot be evaluated as written.** No pooled W is computed, so the headline H1 verdict implicitly uses the 2025 W or only M3.
3. **W4 + W6: descriptive major-group results are overstated.** The registry can record a degenerate one- or two-occupation gap as "largest", with normal-approximation CIs that are too narrow for so few clusters.

## 8. Re-review requirement

Any fix to the scripts above must be re-reviewed (skill Step 6) before results are trusted. Because no independent reviewer agent completed in this session, an independent review is still outstanding even with no fixes. Re-run `/scholar-code-review full` later, or use `/scholar-openai`, for a second opinion.
