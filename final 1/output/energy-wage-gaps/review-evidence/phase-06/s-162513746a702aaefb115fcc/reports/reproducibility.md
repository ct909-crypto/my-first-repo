# Phase 6 pre-execution review (attempt epoch re-run): Reproducibility (reproducibility)

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
| REP-001 | MAJOR | `analysis/scripts-inventory.json` | The declared `produces` lists omit outputs the scripts write. 02: table1-descriptives.html, table1b-wage-by-year.csv, the fig1 PNG. 03: analysis/joint-tests.json, table3-heterogeneity-regression.html, fit-stats-main.csv, identifying-cells.csv, main-models.rds. 05: tableA1-robustness-regression.html, balanced-set.csv, fit-stats-robustness.csv, robustness-models.rds. 06: the PNG copies. 07: tables/model-fit-stats.csv. | Make each script's `produces` list match the files it actually writes. |
| REP-002 | MAJOR | `analysis/scripts-inventory.json dependency_graph` | Two dependencies are undeclared. Script 06 reads 04's output, and script 07 reads data/processed/oews-generation-cells.csv from 01 and fit-stats files from 03 and 05. | Set the graph to 06 <- {03, 04} and 07 <- {01, 03, 04, 05}. The script order is unchanged (01-07). |
| REP-003 | MINOR | `all scripts` | No script writes session or package information. | Phase 8 must capture sessionInfo() in execution-report.json run_context. |
| REP-004 | INFO | `analysis/scripts/04_decomposition.R:13` | The only stochastic step (the bootstrap) is seeded. All paths are relative to the project root, and output directories are created before writing. | None. |

Blocking findings (BLOCKER/CRITICAL/MAJOR): 2.


## Attempt-epoch re-run note

The state machine advanced the Phase 6 attempt epoch after Phase 5 was re-completed. This role was re-reviewed against the current (post-fix) inputs. The findings table above is the first-round record from session s-77c9c0e2f5d64da4ff599c25. Re-checking the current scripts and inventory found that each blocking item for this role is now fixed (see review/pre-execution-fix-log.json), and no new findings arose.

VERDICT: PASS (current state); first-round findings recorded above
