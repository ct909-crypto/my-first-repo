# Phase 7 analysis premortem: measurement_missingness

Provenance: independent subagent dispatch was unavailable in this session (API safeguard errors on every attempt). This premortem role was carried out as a separate inline pass by the orchestrating agent and is not independent of the analysis author.

Scope: design/identification-strategy.json, design/model-specs.json, data/measurement-plan.md, data/variable-dictionary.csv, analysis/analysis-plan.md, analysis/spec-registry.csv, analysis/scripts-inventory.json, review/pre-execution-review.json, review/pre-execution-fix-log.json, review/pre-execution-rereview.json; all 7 scripts; specs S01-S20; tests T1-T6.

Premortem question: if this analysis produced a misleading paper, what failed?

| Risk | Domain | Severity | Description | Mitigation | Status |
|---|---|---|---|---|---|
| PM-03 | measurement | moderate | OEWS wages exclude overtime and shift differentials, which are common for fossil and nuclear plant operators. Gaps in total pay may therefore be larger than gaps in straight-time wages. | Accepted limitation, stated in the Data section and the Discussion. | accepted_limitation |
| PM-04 | missing_data | moderate | Suppressed and top-coded cells are excluded. Suppression is more common in small renewable industries, so the identifying sample over-represents large occupations. | Report suppression counts by renewable status (Table A2 / coverage). The balanced-set (S14) and minimum-cell-size (S18) specifications bound the sensitivity. | mitigated |
| PM-05 | measurement | moderate | P90 censoring at $100 nominal removes high-wage cells, which are disproportionately fossil and nuclear engineering and management. The P90 gap therefore conditions on lower-paid occupations. | The Table 2 note and Results text state that the P90 estimate covers uncensored cells only and is a conservative description of the upper tail. | mitigated |

Every major risk in this role has a pre-committed mitigation or decision rule; no major risk is carried forward as an accepted limitation.

VERDICT: PASS (GO with decision rules)
