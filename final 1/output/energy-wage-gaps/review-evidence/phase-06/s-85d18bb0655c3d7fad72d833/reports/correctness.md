# Phase 6 pre-execution review (attempt epoch re-run): Correctness (correctness)

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
| COR-001 | MAJOR | `analysis/scripts/06_figures.R:41` | Script 06 reads tables/table4-decomposition.csv, which script 04 produces, but dependency_graph declares that 06 depends only on 03. Under the declared order, 06 could run before 04. | Add 04_decomposition.R to 06's dependencies in analysis/scripts-inventory.json. |
| COR-002 | MINOR | `analysis/scripts/01_build_panel.R:66-70` | The special-code flags use `==` (for example `H_MEAN == "*"`). If a cell is NA, the flag is NA and coverage counts become NA. | Use `%in%` so the flags are always TRUE or FALSE. |
| COR-003 | MINOR | `analysis/scripts/07_registry.R:96` | `interaction(occ_code, year)` creates every level combination, including unused ones, which makes the design matrix wide and rank-deficient. | Use `interaction(occ_code, year, drop = TRUE)`. |
| COR-004 | INFO | `03_main_models.R, 06_figures.R, 07_registry.R` | Checked the fixest coefficient names produced by i() (`generation_source::Solar`, `occupational_group::<level>:renewable`, `year::2025:renewable`, `renewable:trend`) against coef_map, the regexes, and the row_from() lookups. They agree. row_from() no longer has the data.table `..` scoping bug. | None. |
| COR-005 | INFO | `analysis/scripts/04_decomposition.R:40-47` | Composition plus within-occupation equals the common-occupation Kitagawa gap. The non-overlap term is defined as the residual, so the additivity assertion holds by construction. | Document in the manuscript that the non-overlap term is the gap contributed by occupations observed in only one group. |

Blocking findings (BLOCKER/CRITICAL/MAJOR): 1.


## Attempt-epoch re-run note

The state machine advanced the Phase 6 attempt epoch after Phase 5 was re-completed. This role was re-reviewed against the current (post-fix) inputs. The findings table above is the first-round record from session s-77c9c0e2f5d64da4ff599c25. Re-checking the current scripts and inventory found that each blocking item for this role is now fixed (see review/pre-execution-fix-log.json), and no new findings arose.

VERDICT: PASS (current state); first-round findings recorded above
