# Phase 7 analysis premortem: model_robustness

Provenance: independent subagent dispatch was unavailable in this session (API safeguard errors on every attempt). This premortem role was carried out as a separate inline pass by the orchestrating agent and is not independent of the analysis author.

Scope: design/identification-strategy.json, design/model-specs.json, data/measurement-plan.md, data/variable-dictionary.csv, analysis/analysis-plan.md, analysis/spec-registry.csv, analysis/scripts-inventory.json, review/pre-execution-review.json, review/pre-execution-fix-log.json, review/pre-execution-rereview.json; all 7 scripts; specs S01-S20; tests T1-T6.

Premortem question: if this analysis produced a misleading paper, what failed?

| Risk | Domain | Severity | Description | Mitigation | Status |
|---|---|---|---|---|---|
| PM-06 | model_fragility | major | Geothermal and biomass contribute few cells. Their source estimates may be driven by a handful of occupations, and the leave-one-out check could flip the sign. | Decision rule DR-03: report identifying-cell counts by source (identifying-cells-by-source.csv) next to S04, and do not interpret source coefficients that rest on fewer than 30 identifying cells beyond their sign and uncertainty. | mitigated |
| PM-07 | model_fragility | moderate | Fossil fuel cells are large, so employment weights let fossil-heavy occupations dominate. | Compare S11 (unweighted) with S03 and report both in Table A1. | mitigated |
| PM-08 | robustness | major | Clustering by occupation alone may understate uncertainty for an industry-level contrast (Phase 6 STA-001). | Decision rule DR-04: report industry-year and two-way clustered SEs for S03 and S04 in the appendix. If the headline loses significance at the 5% level under two-way clustering, the main text reports the conservative SE. | mitigated |
| PM-12 | execution_readiness | minor | The decomposition bootstrap (500 draws) is slow but deterministic under its seed. | Accept; record runtime. | accepted_limitation |

Every major risk in this role has a pre-committed mitigation or decision rule; no major risk is carried forward as an accepted limitation.

VERDICT: PASS (GO with decision rules)
