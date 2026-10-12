# Phase 6 pre-execution review: Statistical implementation (statistical)

Engine: scholar-code-review, mode pre_execution_planned.

## Scope reviewed

- Scripts (all planned, all read in full): analysis/scripts/01_build_panel.R, 02_descriptives.R, 03_main_models.R, 04_decomposition.R, 05_robustness.R, 06_figures.R, 07_registry.R (viz_setting.R: vendored style file, skimmed)
- Tests: T1 data_loading, T2 analytic_sample, T3 variable_construction, T4 missingness, T5 model_spec, T6 output_registry
- Specs: S01, S02, S03, S04, S05, S06, S07, S08, S09, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20
- Script DAG: analysis/scripts-inventory.json script_order and dependency_graph
- Plan coverage: analysis/analysis-plan.md, analysis/analysis-plan-manifest.json (model, hypothesis, variable, robustness, missing-data coverage)
- Upstream artifacts: design/model-specs.json, design/identification-strategy.json, data/variable-dictionary.csv, data/data-measurement-manifest.json, data/measurement-plan.md
- No-execution boundary: confirmed no tables/results-registry.csv, figures/figure-registry.csv, analysis/execution-report.json, or data/processed outputs exist.

**Reviewer provenance.** Thirteen attempts to dispatch independent subagent reviewers (review-code-* agent types and a general-purpose agent, on two models) failed before they started, each with an API safeguard error. This review was therefore carried out inline by the orchestrating agent as a separate, role-scoped pass. It is not an independent reviewer, and this limitation is disclosed in review/pre-execution-review.md.

## Findings

| ID | Severity | Location | Problem | Fix |
|---|---|---|---|---|
| STA-001 | MAJOR | `analysis/scripts/03_main_models.R:29` | Standard errors are clustered only by detailed occupation. Cells in the same industry-year share industry-level shocks and overlapping survey panels, so occupation clustering alone may understate uncertainty for an industry-level contrast. With only seven industries, industry clustering is not feasible. | For S03 and S04, add standard-error sensitivity estimates clustered by industry-year (35 clusters) and two-way clustered by occupation and industry-year. Write them to analysis/outputs/se-sensitivity.csv and report them in the appendix. |
| STA-002 | MINOR | `analysis/scripts/03_main_models.R:38` | S10 drops cells with P90 at or above $100 nominal. The estimate is therefore conditional on cells below the ceiling and likely attenuated for high-wage occupations. | State this interpretation constraint in the table notes and the manuscript (already partly noted in the Table 2 notes). |
| STA-003 | MINOR | `analysis/scripts/03_main_models.R:84-91` | AIC and BIC from weighted fixest models are not comparable across specs estimated on different samples (S09, S10, and the robustness subsets). | Treat R-squared and within R-squared as the primary fit statistics, and do not compare AIC across samples. |
| STA-004 | INFO | `analysis/scripts/05_robustness.R:31` | The inverse-variance weight 1/(PRSE/100)^2 is the correct delta-method approximation to the variance of a log mean, given a relative standard error. | None. |
| STA-005 | INFO | `analysis/scripts/03_main_models.R:41-47` | The equality Wald tests are correctly parameterized (main renewable term plus interactions against a reference category), so H0 is that the gaps are equal. | None. |
| STA-006 | MINOR | `analysis/scripts/07_registry.R:38` | The S08 p-value uses a normal approximation to the bootstrap SE. This is acceptable, but the percentile interval should also be reported. | Optionally add percentile intervals; normal-approximation inference is acceptable for a descriptive component. |

Blocking findings (BLOCKER/CRITICAL/MAJOR): 1.

VERDICT: FAIL
