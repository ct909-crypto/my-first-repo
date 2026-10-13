# R4 Journal Skeptic (ERSS associate editor)

**Verdict: would not survive desk review as written; fixable with theory and framing work. Methods are mostly sound.**

## CRITICAL

1. **Reads as a data note.** The blueprint is all estimands and robustness; no theory, no literature, no conceptual contribution. The mechanism (rent sharing, unions, merchant vs utility organization) is asserted in the RQ but nothing measures it (no union, ownership, or firm-type variable). ERSS's own desk-reject risk list names this. Fix: add a theory section and derive H1-H5 from competing predictions (durable inequality vs ecological modernization/IRA). State what each result would mean for just-transition debates. Label mechanisms "interpretive, untested", or add a proxy (state union density, regional wage level).
2. **Scope: generation-only NAICS is not "renewable jobs".** NAICS 2211 excludes most solar and wind employment: installation and construction (2379, 2382), manufacturing, and developers/O&M contractors. Renewable generation-plant operators are a small, atypical slice, and the higher-paying utility-owned wind/solar plants fall under the same codes. The title, abstract, and "renewable jobs roughly doubled" framing will be attacked as overgeneralized. Fix: retitle to "electric power generation establishments", put the coverage limit in the abstract and first paragraph, and give an employment-coverage comparison against USEER or another external count.

## MAJOR

3. **Private-only (ownership 5) drops the public sector.** Municipal, cooperative, and federal (TVA, hydro) generation is where union and rent-sharing effects are strongest, so the main mechanism lives outside the sample. Verify how national industry files report ownership. Fix: state this as a selection limit on the mechanism, not merely "a scope condition", and discuss the likely direction of bias, especially for hydro and nuclear.
4. **Display plan is thin.** Only 3 figures and 3 tables are named (Table 2 is unspecified). There is no coefficient plot of M3-M6 or composition-decomposition figure (D1/E5), no sample-coverage or suppression table, and no cell-count map by technology-year. Fix: fix the display list now, and put R1-R11 in a single robustness-forest figure plus an appendix table.
5. **Reporting standards.** There is no STROBE-style or transparency checklist, no suppression/top-code flow diagram, and no data/code availability plan or replication archive. Fix: add a sample-flow table (rows dropped by rule, by industry-year), a DAS, and a pre-specification statement. State plainly that this is not preregistered, because the hypotheses were formed after the 2025 cross-section was seen.
6. **Claim calibration and MDES.** The headline contrast is 2021 vs 2024 with an assumed SE of 0.02 and MDES 0.06. The expected result is "persistence", so a null would be reported as no narrowing, which is underpowered by the blueprint's own admission. The H4 decision rule retains "no narrowing" unless p<.05, which is a burden-of-proof inversion. Fix: frame H4 with equivalence bounds or intervals, say "cannot distinguish", and cite MDES in the abstract.
7. **Cluster count and inference.** About 160 occupation clusters across 7 technology cells is fine, but cells are sparse for M4 and M7, and the gap may be driven by a few large occupations. Fix: add wild-cluster bootstrap and leave-one-occupation-out checks.

## MINOR

8. Holm is applied to H2 but not to the 11 robustness checks or the class/group subtests. State which results are confirmatory.
9. The H2 decision rule is a compound conjunction that invites "hypothesis fails" on any one clause. Simplify.
10. Report wages as a percent gap (exp(b)-1), not log points, in the abstract.
11. Pseudo-panel language may confuse readers; call the design "repeated cross-sections of cells".
12. "Roughly doubled" employment needs a cited source and confirmation that it is reproduced in OEWS.
