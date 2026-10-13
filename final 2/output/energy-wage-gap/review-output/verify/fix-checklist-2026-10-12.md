# Fix Checklist — scholar-verify (full), 2026-10-12

Manuscript: `final/manuscript-final.md`. Review only: no project file was modified.
**Caveat:** the 4-agent panel could not run because every agent dispatch was blocked by an API safety filter. These items come from a single inline verification by the orchestrator, so there are no ★★ cross-agent confirmations.

## STAGE 1: Raw output → manuscript tables/figures

No transcription errors. Every line of the script-generated `manuscript/tables/{table1,table2,table3,table3b,tableA1}.md` appears verbatim in the manuscript. Every Table 1, 2, 3, A1 and A2 cell matches its source CSV.

- [ ] **[WARN-FIG-001]** Fig. 1 caption (line 174) cites "model M7", but Methods §3.3 (line 83) defines only M1–M6. Add one sentence to §3.3: "M7 interacts the technology indicators with survey round" (spec S08). (verify-figures / completeness)
- [ ] **[WARN-FIG-002]** Fig. A1 caption (line 306), §3.3 (line 91) and §4.6 (line 198) say "sixteen" robustness specifications. Table A1 and Fig. A1 show **17** alternative rows, because R5 has separate 10th- and 90th-percentile rows. Change the text to "seventeen alternative specifications (sixteen checks; R5 has two outcomes)" or similar.
- [ ] **[WARN-REF-001]** File names and manuscript numbering disagree: `fig1-gap-trend.png` → Fig. 3, `fig2-technology.png` → Fig. 1, `fig3-occupation.png` → Fig. 2, `tableA3-robustness.csv` → Table A1, `table2-main-regressions.csv` → Table A2. `figure-registry.csv` uses the file numbering. Rename the files or add a mapping to the replication README.
- [ ] **[WARN-REF-002]** Pre-specified spec **S10** (stricter-support decomposition, 42 occupations present in all five years; `tables/table3-decomposition.csv` rows 7–11) was computed but is never reported. Under S10 the within term moves from −0.112 (2021) to −0.127 (2025), a change of −0.015, against −0.053 on the year-specific support. Report S10 in the appendix. This also supports the §4.5 point that the widening comes from occupations entering common support.

## STAGE 2: Manuscript tables/figures → prose

- [ ] **[CRIT-TXT-001] Hydroelectric gap described as "absent."** Conclusion, line 217: "absent in long-established hydroelectric plants". Discussion, line 205: "hydroelectric generation should share it. It does not." These contradict §4.3 (line 172): "equivalence is not established … cannot rule out a gap of about six percent". They also contradict the pre-specified H2 test (analysis-plan.md line 44: hydro equivalent to fossil by TOST ±0.05). In the source data (`main-contrasts.csv`, Hydroelectric row), the 90% CI is [−0.063, 0.023] and `equivalent_0.05` is FALSE. Fix: change both passages to "not statistically distinguishable from fossil-fuel pay (although a gap of up to about 6% cannot be ruled out)".
- [ ] **[WARN-TXT-001]** Discussion, line 207: "Engineers and managers carry their market value across technologies: renewable and fossil-fuel plants pay them about the same." The pooled professional/managerial gap is −5.5% (95% CI −9.5% to −1.4%, wild bootstrap p = 0.014; Table 2 line 133), which is a significant gap. Architecture/engineering (−0.8%) and management (−3.5%, p = 0.13) are non-significant, but no equivalence test was run on them. Rephrase to "show small and statistically insignificant gaps", and acknowledge the significant 5.5% class-level gap.
- [ ] **[WARN-TXT-002]** §3.1, line 71: "…only 63–92% in renewable industries … (Table 1)". Manuscript Table 1 has no coverage column; the values come from `tables/tableA2-coverage.csv` and the `coverage` column of `table1-descriptives.csv`, neither of which is displayed. The 63–92% range also holds only with biomass and geothermal pooled. Geothermal alone (NAICS 221116) covers 45–72%, with 2023 at 0.448 and 2025 at 0.470. Add the coverage column to Table 1 or display coverage in an appendix table, and say "renewable technology groups" or widen the range to 45–92%.
- [ ] **[WARN-TXT-003]** Discussion, line 207: "A fossil-fuel power-plant operator … who moves to a solar or wind plant … should expect to earn substantially less". This makes a predictive, individual-level claim from a descriptive cell-level design that does not observe movers. §3.3 (line 91) says "All estimates are descriptive." Rephrase descriptively, for example: "operators … in solar and wind plants are paid substantially less, on average, than their counterparts in fossil-fuel plants".

## INFO (optional)
- Table A2 marks "Renewable × other occupations" −0.117 with * (CR1 p = 0.049), while Table 2 reports p = 0.301 (wild bootstrap). Both notes explain this, but add one clause to the Table A2 note pointing to Table 2 for the inferential p-values.
- §3.3, line 83: "the fixed-effects models use 1,578 cells". M2, also a fixed-effects model, uses 1,856. Change to "the occupation-by-round models (M3–M7)".
- §3.2, line 75: "4–15 cells per year" counts detailed cells before suppression; the range of usable cells is 3–14 (geothermal 2023 = 3).
- Highlights, line 23: "hydro is close to fossil" is acceptable, but align it with the CRIT-TXT-001 wording.
- Fig. A1: the x-axis title is clipped and the "(%)" unit is missing.
- Fig. 2b: the Production CI is very narrow (SE 0.0069 from 9 occupations). The caption already says such intervals are approximate; consider adding a note.
- No `period-definitions.csv` exists. Period labels ("May 2021"…"May 2025", panel overlap) are used consistently, so this is PASS.
- These external figures cannot be checked against analysis outputs: the USEER 919,000 workers, the DOE union-coverage rates of 11–19%, Vona "about four percent", Curtis "roughly a fifth", Curtis 2024 "under one percent", and the claim that clean-energy jobs grew "more than twice as fast". Route them to `/scholar-citation` VERIFY or claim-faithfulness, which PIPELINE-STATUS.md says has not been run.
