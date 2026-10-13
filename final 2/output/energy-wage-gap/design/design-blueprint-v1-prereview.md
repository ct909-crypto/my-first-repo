# Design Blueprint: Renewable–nonrenewable wage gaps within occupations in U.S. power generation, 2021–2025

outcome_mechanism_alignment: prevalence-stock

## 1. Design overview

- **Claim type:** descriptive (associational). The paper estimates how much less, or more, renewable-generation establishments pay workers classified in the same detailed occupation, how this differs by technology and occupational class, and whether it changed over 2021–2025. It does not claim that technology *causes* lower pay: workers and establishments are not randomly assigned, and worker-level skills, tenure, region, establishment size, and union status are unobserved.
- **Design:** repeated national cross-sections of aggregate industry × detailed-occupation cells (a pseudo-panel of cells), analyzed with employment-weighted least squares, occupation and occupation-by-year fixed effects used for *compositional standardization* (not causal identification), Kitagawa decomposition, and contrasts between OEWS estimates built from non-overlapping survey panels.
- **Data:** BLS Occupational Employment and Wage Statistics (OEWS), May 2021, 2022, 2023, 2024, 2025 national industry-specific files (nat5d_6d). Ownership code 5 (private establishments only). Eight six-digit NAICS industries in 2211 Electric Power Generation: hydroelectric 221111, fossil fuel 221112, nuclear 221113, solar 221114, wind 221115, geothermal 221116, biomass 221117, other 221118.
- **Unit of analysis:** industry *j* × detailed SOC occupation *o* × estimate year *t* cell (≈ 2,000 cells before exclusions).
- **Journal target:** Energy Research & Social Science.
- **outcome_mechanism_alignment: prevalence-stock** — the outcome is the level of pay in a stock of jobs at each reference date, not an entry or exit process.

## 2. Estimands

- **E1 (H1):** the employment-weighted average log-point difference in mean annual wage between renewable (hydro, solar, wind, geothermal, biomass) and nonrenewable (fossil, nuclear) cells *within the same detailed occupation and year*, pooled over 2021–2025.
- **E2 (H2):** technology-specific within-occupation-year differences relative to fossil-fuel generation.
- **E3 (H3):** E1 separately for blue-collar, professional/managerial, and support/other occupational classes, and their differences.
- **E4 (H4):** the change in E1 between the May 2021 and May 2024 estimates (no shared survey panels), plus the full year-by-year profile 2021–2025.
- **E5 (H5):** decomposition of the raw renewable–nonrenewable gap in employment-weighted mean log wages into an occupational-composition component and a within-occupation pay component, each year.

## 3. Sample construction

1. Keep rows with O_GROUP = "detailed" (the most detailed occupation level), so each worker is counted once; this corrects the proposal draft's pooling of SOC major, minor, broad, and detailed rows.
2. Keep cells with numeric mean annual wage and employment; wage "*" and employment "**" suppressed cells are dropped and counted by industry-year.
3. Top-coded mean wages ("#") are set to the year's published top-code threshold (read from each file's Field Descriptions sheet) and flagged; sensitivity drops them.
4. Main analytic sample excludes "Other electric power generation" (221118), whose technology mix (tidal, fuel cells, other) cannot be assigned to either side; sensitivity includes it as renewable and as nonrenewable.
5. Real wages: nominal mean annual wage deflated to May-2025 dollars with CPI-U (not seasonally adjusted, May values; BLS series CUUR0000SA0).

## 4. Variables

| Role | Name | Construct | Operationalization | Type |
|---|---|---|---|---|
| Y | ln_real_wage | Pay level of a job cell | ln(A_MEAN × CPI_May2025 / CPI_May_t) | continuous |
| Y (alt) | ln_real_median, ln_real_p10, ln_real_p90 | Pay distribution in a cell | ln of CPI-deflated A_MEDIAN, A_PCT10, A_PCT90 | continuous |
| X | renewable | Renewable generation sector | 1 = NAICS 221111, 221114–221117; 0 = 221112, 221113 | binary |
| X (alt) | technology | Generation technology | fossil (ref), nuclear, hydro, solar, wind, biomass/geothermal (pooled for period-specific models) | categorical |
| W | occ_class | Occupational class | SOC major 11,13,15,17,19 = professional/managerial; 47,49,51,53 = blue-collar; all others = support/other | categorical |
| W | year | OEWS estimate year | 2021–2025 | categorical |
| FE | occ | Detailed occupation | 6-digit SOC code | categorical |
| weight | emp | Cell employment | TOT_EMP | continuous |
| diagnostic | mean_prse | Precision of cell mean | MEAN_PRSE | continuous |

There are no worker-level controls: OEWS cells carry no demographics. Occupation and occupation-by-year fixed effects are the only adjustment, and they are pre-exposure characteristics of the job, not post-treatment variables.

## 5. Analytic strategy

All models: weighted least squares with cell employment as weights (so estimates describe the average worker), `fixest::feols`, standard errors clustered by detailed occupation (≈ 160 clusters; cells of the same occupation are correlated across industries and overlapping years).

- **M1 (raw gap):** ln w_jot = α + β R_j + δ_t + ε. β = raw renewable gap (year-adjusted).
- **M2 (within occupation):** + γ_o (detailed-occupation FE). β = within-occupation gap pooled over years (H1).
- **M3 (within occupation-year):** replace γ_o + δ_t with γ_ot (occupation × year FE). Headline estimand E1 (H1, H5 contrast with M1).
- **M4 (technology):** technology dummies (ref = fossil) + γ_ot (H2). Holm-adjusted p-values across the five technology contrasts.
- **M5 (occupational class):** R × occ_class + γ_ot (H3). Joint Wald test that the interaction terms are zero; primary contrast blue-collar minus professional/managerial.
- **M6 (trend):** R × year + γ_ot (H4). Pre-specified primary test: β_2024 − β_2021 (non-overlapping estimate panels). Secondary: β_2025 − β_2021 (one of six panels shared), joint Wald test of equality across years, and a linear-trend version (R × (year − 2021)).
- **M7 (technology × period, descriptive):** solar, wind, hydro, nuclear, biomass/geothermal × year + γ_ot. Reported as a figure; no convergence claims for biomass/geothermal.
- **D1 (decomposition, H5):** for each year, raw gap = Σ_o s_o^R ln w_o^R − Σ_o s_o^N ln w_o^N. On occupations observed in both groups ("common support"), split into composition Σ_o (s_o^R − s_o^N)·(ln w_o^R + ln w_o^N)/2 and within Σ_o (s_o^R + s_o^N)/2·(ln w_o^R − ln w_o^N) (Kitagawa midpoint weights), with a residual for off-support occupations; report the employment share off support. Occupation-cluster bootstrap (999 draws) for intervals.
- **Descriptive displays:** Table 1 (cells, employment, mean real wages by sector and year); Figure 1 (raw vs within-occupation gap by year); Figure 2 (technology gaps); Table 3/Figure 3 (occupational class and major-group gaps).

### Multi-comparison policy

```yaml
multi_comparison_families:
  - family_id: H2-technology
    description: "Five technology contrasts vs fossil (nuclear, hydro, solar, wind, biomass/geothermal)"
    K: 5
    correction: holm
    alpha_familywise: 0.05
    primary: true
    decision_rule: "H2 supported iff solar and wind are negative with Holm p < .05, hydro CI includes values within +/-0.05 of zero, and nuclear point estimate >= 0 or not significantly negative"
  - family_id: H3-class
    description: "Renewable gap by three occupational classes"
    K: 3
    correction: none-with-justification
    alpha_familywise: 0.05
    primary: true
    decision_rule: "Single pre-specified contrast (blue-collar minus professional/managerial) plus joint Wald test; supported iff contrast < 0 with p < .05"
  - family_id: H4-trend
    description: "Year-specific gaps 2021-2025"
    K: 5
    correction: none-with-justification
    alpha_familywise: 0.05
    primary: true
    decision_rule: "Single pre-specified primary contrast beta_2024 - beta_2021; H4 (no narrowing) retained unless the gap shrinks in absolute value with p < .05; joint Wald reported as secondary"
```

Justification for H3/H4: each is adjudicated by one pre-specified contrast, so no family of independent tests is being searched; the other contrasts are reported descriptively.

`analytic_strategy.interaction_inference_policy: joint_wald_test`

## 6. Feasibility / power

Secondary data with fixed N. The proposal's 2025 cross-section gave a within-detailed-occupation SE of ≈ 0.013 for the renewable coefficient; with five pooled years and occupation-clustered SEs we expect SE ≈ 0.010–0.015, so the minimum detectable gap at 80% power is ≈ 0.03–0.04 log points (3–4%). For the 2024-vs-2021 change, SE ≈ 0.02, giving MDES ≈ 0.06 log points: the design can detect a narrowing of about six percent or more. Smaller changes would not be distinguishable from persistence, and the manuscript must say so. Biomass and geothermal (3–14 cells per year) are feasibility-limited and pooled.

## 7. Threats and robustness

| Threat | Response |
|---|---|
| OEWS pools six semiannual panels and ages older wages with the ECI, so adjacent years overlap | Primary trend contrast 2021 vs 2024 (no shared panels); year-to-year changes described, not tested as independent |
| Within-occupation composition (tenure, region, firm size) differs by sector | Cannot be removed; interpret as a pay-for-classified-job gap; median/percentile outcomes; discuss regional wage levels |
| Changing set of published cells (solar/wind cells roughly doubled) | Balanced-cell robustness: industry × occupation cells present in all five years |
| Imprecise small cells | Precision-weighted (emp / PRSE²) and unweighted models; drop cells with PRSE > 10 |
| Classification of "other" generation | Include 221118 as renewable / as nonrenewable |
| Top-coding | Drop "#" cells |
| Private ownership only | Stated as a scope condition; no public-utility comparison |
| Detailed occupation still heterogeneous | Report within-major-group results; discuss |

Robustness list: R1 balanced cells; R2 precision weights; R3 unweighted; R4 median outcome; R5 P10 and P90 outcomes; R6 other as renewable; R7 other as nonrenewable; R8 drop top-coded; R9 drop PRSE > 10; R10 nominal wages (sanity, year FE); R11 two-period collapse (2021 vs 2024 only).

## 8. Data and methods draft (condensed, for Phase 13)

We use the May 2021–2025 OEWS national industry-specific estimates for the eight private-sector electric power generation industries. The unit of analysis is an industry-by-detailed-occupation-by-year cell, for which OEWS publishes employment and the mean annual wage. We deflate wages to May 2025 dollars with the CPI-U and model their logarithm by weighted least squares, weighting each cell by its employment and clustering standard errors by occupation. Occupation-by-year fixed effects restrict comparisons to workers in the same detailed occupation in the same estimate year. Because each OEWS May estimate combines six semiannual panels collected over three years, adjacent estimates share most of their underlying sample; we therefore test change by comparing the May 2021 and May 2024 estimates, which share no panels.
