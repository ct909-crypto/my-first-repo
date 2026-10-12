# Phase 6 pre-execution review: Style and AI-pattern (style_ai_patterns)

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
| STY-001 | MINOR | `analysis/scripts/06_figures.R:27,58` | geom_errorbarh() is deprecated in ggplot2 4.0.3, and its `height` argument should become `width` in geom_errorbar(orientation = 'y'). | Replace it. |
| STY-002 | INFO | `03_main_models.R, 05_robustness.R` | Checked the API calls against the installed versions: fixest 0.14.2 wald(keep=, print=), fitstat types 'g'/'r2'/'ar2'/'wr2', coeftable, confint; modelsummary 2.6.0 coef_map, list-form gof_map, stars, notes, output. No invented arguments found. | None. |
| STY-003 | INFO | `02_descriptives.R; 03_main_models.R` | Table and figure labels use reader-facing terms consistent with the dictionary's display labels. The registry keeps machine term names, which is acceptable for provenance. | None. |
| STY-004 | MINOR | `03_main_models.R; 05_robustness.R` | The fit-statistic extraction code is duplicated across the two scripts. | Acceptable at this size. Optionally move it into a shared helper. |

Blocking findings (BLOCKER/CRITICAL/MAJOR): 0.

VERDICT: PASS
