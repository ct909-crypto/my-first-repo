# Design Blueprint: Same job, different technology? Renewable–nonrenewable wage gaps within occupations in U.S. power generation establishments, 2021–2025

Working manuscript title (scope in title, per R4-2): *Same Job, Different Technology? Renewable–Nonrenewable Wage Gaps Within Occupations in U.S. Power Generation Establishments, 2021–2025*. The abstract must name the scope: in-house employees of private generation establishments (NAICS 2211), excluding construction and installation contractors.

outcome_mechanism_alignment: prevalence-stock

## 1. Design overview

- **Claim type:** descriptive (associational). The paper estimates how much less, or more, renewable-generation establishments pay workers classified in the same detailed occupation, how this differs by technology and occupational class, and whether it changed over 2021–2025. It does not claim that technology *causes* lower pay: workers and establishments are not randomly assigned, and worker-level skills, tenure, region, establishment size, and union status are unobserved.
- **Design:** repeated national cross-sections of aggregate industry × detailed-occupation cells, analyzed with employment-weighted least squares, occupation and occupation-by-year fixed effects used for *compositional standardization* (not causal identification), Kitagawa decomposition, and contrasts between OEWS estimates built from non-overlapping survey panels.
- **Data:** BLS Occupational Employment and Wage Statistics (OEWS), May 2021, 2022, 2023, 2024, 2025 national industry-specific files (nat5d_6d). Ownership code 5 (private establishments only). Eight six-digit NAICS industries in 2211 Electric Power Generation: hydroelectric 221111, fossil fuel 221112, nuclear 221113, solar 221114, wind 221115, geothermal 221116, biomass 221117, other 221118.
- **Unit of analysis:** industry *j* × detailed SOC occupation *o* × estimate year *t* cell (≈ 2,000 cells before exclusions).
- **Journal target:** Energy Research & Social Science.
- **outcome_mechanism_alignment: prevalence-stock** — the outcome is the level of pay in a stock of jobs at each reference date, not an entry or exit process.


## 1b. Theory-to-test mapping [REV round 2: R4-1, R-theory-4]

The full argument is developed in `literature/lit-theory.md`. The design turns it into competing observable predictions:

| Hypothesis | Institutional / durable-inequality prediction (primary) | Ecological-modernization / labor-demand rival | Compositional / selection alternative | Discriminating evidence in this design |
|---|---|---|---|---|
| H1 | Within-occupation renewable gap < 0 | Gap ≈ 0 or > 0 (green upgrading, subsidies) | Gap < 0 only because renewable workers are newer or sited in low-wage regions | Sign and size of W and M3. Selection cannot be excluded, so this is interpretive |
| H2 | Gap concentrated in new technologies (solar, wind); hydro ≈ fossil; nuclear ≥ fossil | Gaps similar across renewables, or smallest in the fastest-growing, most subsidized technologies (solar, wind) | Gaps track plant vintage and siting rather than organizational form | Technology ordering. The hydro null is informative because hydro is renewable yet legacy-organized. D3 sets gaps beside union/PLA coverage |
| H3 | Gap larger for blue-collar trades than for professional/managerial jobs | Scarce skilled trades should command *equal or higher* renewable pay (tight labor demand), so the blue-collar gap is ≤ the professional gap | Contract and project-based labor markets also predict larger blue-collar gaps (an institutional variant) | Sign of the blue-collar minus professional contrast. A reversal would support the rival |
| H4 | No narrowing 2021→2025 | Narrowing as renewable employment roughly doubled and subsidies with prevailing-wage and apprenticeship standards began (a narrowing of ≥0.07–0.10 log points is detectable) | Apparent narrowing driven by changes in which cells are published | Δ(2025−2021) with its CI and equivalence test; D2 (continuing vs entering occupations) |
| H5 | Composition term ≥ 0 (renewable jobs are not concentrated in low-paid occupations) | Not applicable | Raw gap entirely compositional | Kitagawa composition term |

Just-transition implication: a persistent within-occupation gap concentrated in blue-collar trades would mean that the jobs displaced fossil workers are most likely to enter pay less in renewable plants. This is the pay dimension of a just transition.

## 1c. External coverage benchmark [REV round 2: R4-2]

OEWS NAICS 2211 counts only in-house employees of private generation establishments: about 142,000 (2021) to 159,000 (2025) workers across the eight industries. The 2024 U.S. Energy and Employment Report counts about 919,000 electric power generation workers in 2023, because it includes construction, installation, professional services, and utility-scale developers. Our sample therefore covers the permanent operations workforce of generation plants, not the renewable construction workforce. The manuscript reports this comparison in the Data section.

## 2. Estimands [REV: R1 CRITICAL 1/3, R-theory CRITICAL 2, R5 CRITICAL 2]

- **E1 (H1, headline):** the *within-occupation* renewable–nonrenewable gap in each year. It is defined as the Kitagawa within term on common-support occupations: W_t = Σ_o m_ot (ln w^R_ot − ln w^N_ot), where m_ot = (s^R_ot + s^N_ot)/2 and the shares are renormalized to sum to one on common support. This is an average-worker quantity with explicit weights. The pooled regression coefficient from M3 (occupation × year FE, employment weights) is reported as the model-based counterpart. The two need not coincide, because the regression weights occupations by within-occupation variance in the renewable indicator.
- **E2 (H2):** technology-specific within-occupation-year gaps relative to fossil-fuel generation (M4). The pre-specified primary contrasts are solar vs fossil and wind vs fossil.
- **E3 (H3):** E1 by occupational class. The pre-specified primary contrast is blue-collar trades minus professional/managerial (M5).
- **E4 (H4):** change in the within-occupation gap between OEWS estimates built from **non-overlapping survey panels**. A May-*t* estimate pools the six semiannual panels from November *t*−3 to May *t*: May 2021 = Nov 2018–May 2021, May 2024 = Nov 2021–May 2024, May 2025 = Nov 2022–May 2025. **Primary contrast: 2025 minus 2021** (longest span, no shared panels). Secondary: 2024 minus 2021. May 2022 and May 2023 overlap May 2021, and May 2025 overlaps May 2024, so the full 2021–2025 profile is descriptive.
- **E5 (H5):** each year's raw gap in employment-weighted mean log wages = composition term + within term (E1) + off-support residual. H5 pre-specifies that the composition term is ≥ 0, meaning renewable employment is not concentrated in lower-paid occupations, so the within gap is at least as negative as the raw gap.

## 3. Sample construction

1. Keep rows with O_GROUP = "detailed" (the most detailed occupation level), so each worker is counted once. This corrects the proposal draft, which pooled SOC major, minor, broad, and detailed rows.
2. Keep cells with numeric mean annual wage and employment. Suppressed cells (wage "*", employment "**") are dropped. **Coverage table:** published detailed-occupation employment as a share of each industry-year total (occupation code 00-0000), plus counts of dropped cells, by technology and year. [REV: R3-1, R1-5, R5-6]
3. Top-coded mean wages ("#") are set to that year's published top-code threshold (read programmatically from each file's Field Descriptions sheet) and flagged. They are treated as a lower bound, and sensitivity analyses drop them.
4. The main analytic sample excludes "Other electric power generation" (221118), which mixes technologies. Sensitivity analyses include it as renewable and, separately, as nonrenewable.
5. Real wages are expressed in May-2025 dollars using the CPI-U (NSA, May values, series CUUR0000SA0, stored at analysis/reference, retrieved 2026-09-30). Occupation × year FE absorb the deflator, so deflation affects only descriptive tables and M1/M2.
6. NAICS 221111–221118 codes and titles are identical in all five files (verified in Phase 4).
7. **Scope:** private-ownership establishments (own_code 5) and in-house employees of generation establishments. Contractors classified in construction or services NAICS (for example, solar installers) fall outside the scope. [REV: R4-2/3, R1-6]

## 4. Variables

| Role | Name | Construct | Operationalization | Type |
|---|---|---|---|---|
| Y | ln_real_wage | Pay level of a job cell | ln(A_MEAN × CPI_May2025 / CPI_May_t) | continuous |
| Y (robust) | ln_real_hourly | Hourly pay | ln(H_MEAN × CPI ratio) | continuous |
| Y (robust) | ln_real_median, ln_real_p10, ln_real_p90 | Reported within-cell percentiles | ln of CPI-deflated A_MEDIAN, A_PCT10, A_PCT90; censored share reported | continuous |
| X | renewable | Renewable generation sector | 1 = NAICS 221111, 221114–221117; 0 = 221112, 221113 | binary |
| X (alt) | technology | Generation technology | fossil (ref), nuclear, hydro, solar, wind, biomass/geothermal (pooled) | categorical |
| W | occ_class | Occupational class | professional/managerial (SOC 11,13,15,17,19); blue-collar trades (47,49,51,53); office/administrative (43); other (all remaining) [REV: R3-2] | categorical |
| W | soc_major | SOC major group | first two digits of SOC | categorical |
| W | year | OEWS estimate year | 2021–2025 | categorical |
| FE | occ | Detailed occupation | 6-digit SOC code | categorical |
| weight | emp | Cell employment | TOT_EMP | continuous |
| diagnostic | mean_prse | Precision of cell mean | MEAN_PRSE | continuous |

OEWS cells contain no worker-level controls. Occupation and occupation-by-year fixed effects capture pre-exposure job attributes; they are not post-treatment variables. The log of a cell mean differs from the mean of log wages, and the manuscript states this.

## 5. Analytic strategy

All regressions use `fixest::feols` with cell employment as weights and standard errors clustered by detailed occupation. For every model we report the number of *identifying* occupations (occupations observed in both sectors in the same year) and N after singleton removal. **Inference [REV round 2: R5-1, R4-7, R5-5]:** Only 60–80 occupations identify the renewable contrast in any year, so the primary p-values for every pre-specified test come from a restricted wild cluster bootstrap (WCR): the null imposed, Webb six-point weights, 9,999 draws, clusters = detailed occupations, seed 20260930. It is implemented directly in R via Frisch–Waugh–Lovell residualization, because `fwildclusterboot` is not available on CRAN. The CR1 cluster-robust SE and 95% CI are reported alongside. The pre-specified contrasts that receive WCR p-values are:
- M3 renewable coefficient (H1)
- M4 solar, wind, hydro, nuclear, and biomass/geothermal vs fossil (H2; Holm applied to the WCR p-values)
- M5 blue-collar minus professional/managerial (H3)
- M6 β_2025 − β_2021 and β_2024 − β_2021 (H4)

For M5 we report the number of identifying occupations per class. The decomposition (D1, D2) uses an occupation-cluster pairs bootstrap (999 resamples), re-applying the common-support rule within each resample. As a sensitivity check (R16), SEs are also clustered by industry × occupation cell.

- **M1 (raw):** ln w = α + β R + δ_t. Raw year-adjusted gap.
- **M2:** + γ_o (occupation FE).
- **M3 (headline model):** γ_ot (occupation × year FE) replaces γ_o + δ_t. Pooled within-occupation-year gap (H1).
- **M4 (technology):** technology dummies (ref = fossil) + γ_ot (H2). Holm-adjusted p-values across five contrasts. Hydro equivalence tested by TOST (90% CI within ±0.05 log points). Pairwise contrasts: solar − hydro and wind − hydro.
- **M5 (class):** R × occ_class + γ_ot (H3). Primary contrast: blue-collar trades minus professional/managerial (the four-class scheme matches the H3 wording). Joint Wald test on the interactions. Secondary [REV round 2: R3-2]: a five-class version separating managers (SOC 11) from professional/technical occupations (SOC 13, 15, 17, 19), plus major-group gaps (R × soc_major), both reported descriptively.
- **M6 (trend):** R × year + γ_ot (H4). Primary Δ = β_2025 − β_2021. Secondary Δ = β_2024 − β_2021. Also a joint Wald test of equal gaps across years and a linear-trend version.
- **M7 (technology × year, descriptive figure):** solar, wind, hydro, nuclear × year + γ_ot. Biomass/geothermal are pooled and not plotted by year.
- **D1 (decomposition):** Kitagawa decomposition by year, with shares renormalized on common support. Report off-support employment share by year and sector. Alternative support rule: occupations present in both sectors in *all five* years. CIs from an occupation-cluster bootstrap, with the support rule re-applied inside each resample.
- **D2 (trend decomposition of W):** split ΔW (2025 − 2021) into continuing occupations (on support in both years) and entering or exiting occupations. [REV: R1-5]
- **D3 (descriptive juxtaposition, interpretive only):** technology-specific gaps from M4 listed next to published union/PLA coverage by technology (USEER 2024). No inference; used in the Discussion.

### Decision rules (pre-specified) [REV: R1-2, R-theory-2, R4-6]

- **H1:** supported if W (pooled) and the M3 coefficient are both negative with 95% CIs excluding 0.
- **H2:** supported if solar and wind are negative (Holm p < .05), hydro is equivalent to fossil within ±0.05 (TOST), and nuclear ≥ fossil (point estimate ≥ 0 or CI including 0). Partial support is reported clause by clause rather than as a single all-or-nothing verdict.
- **H3:** supported if the blue-collar minus professional/managerial contrast is < 0 with p < .05.
- **H4 (persistence):** outcomes are coded as follows.
  - "Narrowed": Δ > 0 with a 95% CI excluding 0.
  - "Widened": Δ < 0 with a 95% CI excluding 0.
  - "Stable (equivalent)": the 90% CI lies within ±0.05 log points.
  - Otherwise: "no detectable change, inconclusive".
  - Only "stable" counts as support for H4. An inconclusive result is reported as inconclusive, never as persistence.
- **H5:** supported if the composition term is ≥ 0 (CI) in the primary years, i.e. the within gap is at least as negative as the raw gap.

### Multi-comparison policy

```yaml
multi_comparison_families:
  - family_id: H2-technology
    description: "Five technology contrasts vs fossil (nuclear, hydro, solar, wind, biomass/geothermal)"
    K: 5
    correction: holm
    alpha_familywise: 0.05
    primary: true
    decision_rule: "Clause-by-clause as specified above; solar and wind must survive Holm; hydro evaluated by TOST, not by rejection"
  - family_id: H3-class
    description: "Renewable gap by four occupational classes"
    K: 4
    correction: none-with-justification
    alpha_familywise: 0.05
    primary: true
    decision_rule: "Single pre-specified contrast (blue-collar trades minus professional/managerial); joint Wald reported as secondary"
  - family_id: H4-trend
    description: "Year-specific gaps 2021-2025"
    K: 5
    correction: none-with-justification
    alpha_familywise: 0.05
    primary: true
    decision_rule: "Single pre-specified primary contrast (2025 minus 2021) with equivalence margin +/-0.05; 2024 minus 2021 secondary"
```

Why no correction for H3/H4: each hypothesis is adjudicated by one pre-specified contrast. The other contrasts are reported descriptively, so no family of tests is being searched.

`analytic_strategy.interaction_inference_policy: joint_wald_test`

## 6. Feasibility / power [REV: R5 CRITICAL 1-2, R1-7]

The data are secondary with a fixed N. Identifying occupations (present in both sectors within a year) number 59 in 2021 and 77 in 2025. M3–M6 therefore rest on about 60–80 identifying clusters per year; occupation clustering absorbs the repetition of occupations across years. Adjacent-year estimates share panels, so we base power on single non-overlapping years:

- **Single-year within-occupation gap:** expected SE 0.015–0.025, MDES ≈ 0.04–0.07 log points.
- **2025 − 2021 change:** expected SE 0.025–0.035, MDES ≈ 0.07–0.10 log points.

Changes in the gap smaller than about 7–10 percent may therefore go undetected, and the ±0.05 equivalence margin may be unattainable. In that case H4 will be reported as inconclusive. Realized SEs are reported. Biomass and geothermal are pooled and flagged as feasibility-limited; balanced-cell robustness is expected to keep few of their cells, and this is disclosed.

## 7. Threats and robustness

| Threat | Response |
|---|---|
| Overlapping OEWS panels; ECI wage aging smooths change | Primary trend contrasts use non-overlapping estimates; E4 described as change between three-year pooled windows |
| Non-overlapping panels may re-sample the same establishments | Caveat; cluster bootstrap by occupation; cell-level interpretation |
| Within-occupation composition (tenure, region, size) | Cannot be removed; gap interpreted as pay for a classified job; scope statement |
| Publication/suppression changes (renewable cells roughly doubled) | Coverage table; balanced cells (R1); continuing vs entering decomposition (D2) |
| Small, imprecise cells | Precision-weighted (R2), unweighted (R3), PRSE ≤ 10 (R9) |
| Classification of other/hydro/nuclear | Other as renewable (R6) or nonrenewable (R7); hydro as nonrenewable, i.e. new renewables vs legacy (R12); nuclear excluded (R13) |
| Top-coding / censored percentiles | Drop "#" (R8); censored share of P90 reported; percentiles labeled "reported within-cell percentiles" |
| Hours assumption in annual wages | Hourly mean outcome (R14) |
| Influential occupations | Drop the five largest-employment identifying occupations (R15) |
| Private ownership only; contractors outside NAICS 2211 | Stated as scope conditions |

Robustness checks apply to the headline M3 renewable coefficient and to the primary Δ:

- R1 balanced cells
- R2 precision weights (emp/PRSE²)
- R3 unweighted
- R4 median
- R5 P10 and P90 (descriptive; censoring noted)
- R6 other as renewable
- R7 other as nonrenewable
- R8 drop top-coded
- R9 PRSE ≤ 10
- R10 nominal wages
- R11 two-period sample (2021 and 2025 only)
- R12 new renewables (solar, wind, biomass, geothermal) vs legacy (fossil, nuclear, hydro)
- R13 exclude nuclear
- R14 hourly mean
- R15 drop the five largest identifying occupations
- R16 standard errors clustered by industry × occupation cell

Results appear in one robustness forest figure plus an appendix table.

### Display plan [REV: R4-4]

- **Table 1:** sample coverage and descriptives by sector and year (cells, employment, published-employment coverage, mean real wage).
- **Table 2:** main regression table (columns M1, M2, M3, M5-class, M6-trend).
- **Table 3:** decomposition by year (raw, composition, within, off-support share).
- **Figure 1:** raw vs within-occupation gap by year, with CIs.
- **Figure 2:** technology gaps (M4) and technology × year (M7).
- **Figure 3:** gaps by occupational class and major group.
- **Appendix:** sample-flow table, robustness forest and table, coverage/suppression table, D2.

### Reporting and open science

The data are public (BLS OEWS). All code (R, `fixest`, `modelsummary`, `ggplot2`) runs in a fixed order with seed 20260930, and package versions are logged. The analysis was **not preregistered**; the hypotheses were formed after the author's 2025 cross-section had been seen, and the manuscript discloses this. The 2021–2025 trend analyses and all robustness checks are specified here, before any pooled models are estimated.

## 8. Data and methods draft (condensed, for Phase 13)

We use the May 2021–2025 OEWS national industry-specific estimates for the eight private-sector electric power generation industries. The unit of analysis is an industry-by-detailed-occupation-by-year cell, for which OEWS publishes employment and the mean annual wage. We deflate wages to May 2025 dollars with the CPI-U and model their logarithm by weighted least squares, weighting each cell by its employment and clustering standard errors by occupation. Occupation-by-year fixed effects restrict comparisons to workers in the same detailed occupation in the same estimate year. Because each OEWS May estimate combines six semiannual panels collected over three years, adjacent estimates share most of their underlying sample; we therefore test change by comparing the May 2021 estimate with the May 2025 (and May 2024) estimates, which share no panels with it.
