# Phase 6 pre-execution review (attempt epoch re-run): Robustness (robustness)

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
| ROB-001 | MINOR | `analysis/scripts/01_build_panel.R:44-50` | read_topcode() returns NA if the codebook wording changes. stopifnot checks only that a matching line exists, not that a number was parsed. | Add `stopifnot(!is.na(topcode), topcode >= 50)` after parsing. |
| ROB-002 | MINOR | `analysis/scripts/06_figures.R:27,58` | geom_errorbarh() is deprecated in the installed ggplot2 (4.0.3). It still renders but emits warnings, and it could break in a future release. | Use geom_errorbar(orientation = "y") with xmin/xmax and `width`. |
| ROB-003 | INFO | `analysis/scripts/03_main_models.R:31` | Geothermal (4-8 cells per year) and biomass (12-14) are thin. Their source coefficients in S04 rest on few occupation-year comparisons. | Report identifying cell counts by source next to S04 (interpretation constraint, no code change required). |
| ROB-004 | INFO | `analysis/scripts/04_decomposition.R:53-60` | The bootstrap subsets the table once per drawn occupation (about 200 x 500 subsets). It is slow but bounded, and the seed is set. | None. |

Blocking findings (BLOCKER/CRITICAL/MAJOR): 0.


## Attempt-epoch re-run note

The state machine advanced the Phase 6 attempt epoch after Phase 5 was re-completed. This role was re-reviewed against the current (post-fix) inputs. The findings table above is the first-round record from session s-77c9c0e2f5d64da4ff599c25. Re-checking the current scripts and inventory found that each blocking item for this role is now fixed (see review/pre-execution-fix-log.json), and no new findings arose.

VERDICT: PASS (current state); first-round findings recorded above
