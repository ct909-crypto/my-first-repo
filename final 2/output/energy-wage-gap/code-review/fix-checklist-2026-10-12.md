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

