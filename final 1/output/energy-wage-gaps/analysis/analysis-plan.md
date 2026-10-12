# Analysis Plan (analysis_plan_compiler, Phase 5)

No analysis has been executed in this phase (no execution boundary: no data were modeled, no tables or figures produced). All scripts and tests listed in `analysis/scripts-inventory.json` are planned. Execution belongs to Phase 8, after the pre-execution review (Phase 6) and the analysis premortem (Phase 7).

## Methods brief: weighted fixed-effects regression on occupation-by-industry wage cells

**Source data and expected size.** Each of the five OEWS national industry-specific files has roughly 16,500 to 17,300 rows covering all published industries and occupation levels. Restricting to the eight electric power generation industries (NAICS 221111–221118) and to detailed occupations leaves about 2,100 occupation-industry-year cells, of which about 2,075 report a mean hourly wage.

**Analytic sample and denominators.** The main sample keeps cells in the seven analytic industries (other generation, 221118, is excluded) that have both a published mean wage and employment. We expect about 1,850 cells. The script reports exclusions at each step (aggregation rows, other generation, `*`, `**`, and `#`) by industry and year. The within-occupation models identify the renewable coefficient only from occupation-year groups observed in both a renewable and a non-renewable industry. We report the number of such groups and the number of singleton cells absorbed by the fixed effects.

**Method and fit.** The outcome is a continuous log wage, and the data are repeated cross-sections of aggregate cells. The question is descriptive: how much less or more a renewable generation industry pays for the same occupation. Linear models in logs with fixed effects fit this structure. Employment weights make the estimates represent workers rather than cells. Coefficients are converted to percent gaps, (exp(b) − 1) × 100.

**Estimating equations.** For cell *o* (detailed occupation), *i* (generation industry), *t* (survey year):

- Headline model (M3, spec S03): ln *w*_oit = β·Renewable_i + α_ot + ε_oit, weighted by employment_oit, where α_ot are occupation-by-year fixed effects.
- Raw and partial ladders: M1 replaces α_ot with year fixed effects α_t, and M2 uses α_o + α_t.
- Source model (M4, S04): ln *w*_oit = Σ_s γ_s·Source_is + α_ot + ε_oit, with fossil fuel as the omitted source and γ_s for nuclear, hydroelectric, solar, wind, geothermal, and biomass.
- Occupational heterogeneity (M5, S05): ln *w*_oit = Σ_g β_g·(Renewable_i × Group_g(o)) + α_ot + ε_oit, across five broad occupation categories, with a joint Wald test that all β_g are equal.
- Trend (M6, S06–S07): ln *w*_oit = Σ_t β_t·(Renewable_i × Year_t) + α_ot + ε_oit, with a joint Wald test that the β_t are equal, plus a linear version β_0·Renewable_i + β_1·Renewable_i × (t − 2021).
- Decomposition (M7, S08): for each year, the gap in employment-weighted mean log wages between renewable and non-renewable industries, D = Σ_o (s_o^R − s_o^N)·w̄_o + Σ_o s̄_o·(w_o^R − w_o^N), using a Kitagawa split. The first term is occupational composition and the second is the within-occupation wage difference. Shares and wages are averaged across groups, and occupations present in only one group contribute through composition at their observed wage.
- Distributional (M8–M9, S09–S10): the headline equation with log P10 and log P90 wages.

**Inference.** Standard errors are clustered by detailed occupation, because the same occupation appears across industries and years and its errors are likely correlated. Interaction blocks are tested jointly (Wald). The decomposition uses a bootstrap that resamples occupations (500 draws). We do not adjust for multiple comparisons in the descriptive heterogeneity tables. Instead, we pre-specify the five occupational groups and report joint tests.

**Robustness and interpretation.** S11–S20 implement every item in the design's robustness plan:
- unweighted and inverse-variance weighting;
- a median-wage outcome;
- a balanced occupation set (for the gap and the trend);
- three alternative categorizations (nuclear excluded, hydro excluded, other generation counted as renewable);
- a minimum cell size of 50;
- leave-one-source-out.

If the sign of the headline gap survives all checks, the manuscript describes the within-occupation renewable gap as robust to these choices. If it disappears without nuclear, the headline is reframed as a nuclear premium. If the trend differs on the balanced set, raw trend changes are attributed to occupation coverage.

## Hypothesis-to-spec map

| Hypothesis | Specs |
|---|---|
| H1 within-occupation renewable gap negative | S02, S03, S09, S10, S11–S19 |
| H2 composition explains part of raw gap | S01, S02, S03, S08 |
| H3 source ordering (nuclear > fossil ≈ hydro > solar, wind) | S04 |
| H4 larger gap in plant-based occupations | S05, S09, S10 |
| H5 gap narrows 2021–2025 | S06, S07, S14, S20 |

## Dataset-design plan
OEWS cells are design-weighted aggregate estimates. We use cell employment as the analytic weight and cluster by occupation. We do not use survey strata or establishment identifiers, which are not public. Consecutive releases share four of six panels, so the plan treats year-specific estimates as smoothed and describes trends cautiously, as an accepted limitation inherited from Phase 4.

## Missing data and restrictions
The plan follows Phase 4. Suppressed wage (`*`) and employment (`**`) cells and top-coded (`#`) cells are excluded, and their counts are reported by industry and year. These are publication-suppression rules, not structural skips. Before any model runs, the script writes the post-restriction denominators and the share of excluded cells by renewable status. For the P90 outcome, values at or above $100 nominal are treated as censored in every year. The balanced-set and minimum-cell-size specifications serve as sensitivity checks on the denominator.

## Outcome model ladder
The log-wage outcome is approximately continuous. The ladder varies the comparison rather than the outcome family: raw → occupation FE → occupation-by-year FE, with median, P10, and P90 outcomes as distributional diagnostics and a top-code sensitivity at P90.

## Scripts and tests
Seven R scripts run in a fixed order (see `analysis/scripts-inventory.json`). Script 01 builds the cell panel, and scripts 02–05 depend only on it. Script 06 depends on 03, and script 07 depends on 03–05. The tests cover data loading, the analytic sample, variable construction, missingness, model specifications (S01–S20), and the output registry. They are built into the scripts as `stopifnot` assertions.

## Phase 6 pre-execution review handoff
Pre-execution review should audit all seven planned scripts, the six tests, all 20 specs, the script DAG, and the coverage fields in `analysis/analysis-plan-manifest.json` against the design and data artifacts.
