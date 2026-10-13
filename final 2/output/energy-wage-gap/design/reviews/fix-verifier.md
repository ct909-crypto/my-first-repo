# Fix-verifier, round 2 (re-check of previously unresolved items)

| Item | Status | Evidence |
|---|---|---|
| R5-1 wild bootstrap | RESOLVED | Blueprint Sec. 5: restricted WCR, Webb weights, 9,999 draws, occupation clusters, seed. Applied to M3-M6 and Holm is applied on WCR p-values. model-specs.json M3-M6 match. CR1 reported alongside. |
| R4-1 theory-to-test | RESOLVED | Sec. 1b maps each H to an institutional prediction, an EM/labor-demand rival, a selection alternative and discriminating evidence. It adds an EM-predicted narrowing magnitude and a just-transition implication. The theory text itself lives in literature/lit-theory.md (not reviewed here). |
| R4-2 scope/title/external coverage | RESOLVED, one caveat | Title now carries "Power Generation Establishments". The abstract must name the scope. Sec. 1c gives an external USEER benchmark. The figures (142k-159k OEWS; 919k USEER 2023) are unverified by me and must be checked at execution. |
| R3-2 class mapping | ACCEPTED_LIMITATION | M5 keeps the four-class primary so it matches the H3 wording. A five-class secondary separates managers (SOC 11). Reasonable. |
| Theory-4 H3 competing prediction | RESOLVED | Sec. 1b gives a labor-demand rival (blue-collar gap <= professional gap). A reversal supports the rival. The decision rule (contrast < 0) stays consistent. The contractor-market variant is noted as an institutional variant, not a separate test. |
| R4-7 / R5-5 | RESOLVED | WCR covers M5. Identifying occupations per class are reported. R15 is the leave-out check. R16 is the industry x occupation clustering sensitivity. |
| New 1, stale causal-gate | RESOLVED | The diagnostic now tests 2025-2021 (primary) and 2024-2021 (secondary). Trend language updated. |
| New 2, bootstrap scope | RESOLVED | The contrasts receiving WCR are enumerated. The D1/D2 pairs bootstrap re-applies the support rule. |
| New 4, M2/D1 mapping and independence | PARTIAL, minor | WCR now covers the M3 H1 test and R16 covers dependence. model-specs still lists M2 and D1 under H1, and M2 and M7 keep pairs-bootstrap SEs. This is cosmetic. |

Residual minor notes (not blocking)
- H4 "stable" (90% CI within +/-0.05) remains nearly unreachable given the projected SE 0.025-0.035. It is disclosed, and H4 is expected to be reported inconclusive.
- The TOST and equivalence intervals should be stated as WCR-based or CR1-based at execution.
- Webb weights with 60-80 clusters are conservative but valid.
- The OEWS panel arithmetic remains correct.

## Verdicts
| Role | Verdict |
|---|---|
| identification | PASS |
| measurement | PASS |
| theory_mechanism | PASS |
| feasibility_data | PASS |
| journal_skeptic | PASS (verify the USEER/OEWS figures at execution) |

Unresolved CRITICAL issues: 0. Unresolved MAJOR: 0.
