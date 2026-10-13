# Consolidated Verification Report — scholar-verify (full)

- **Manuscript:** `final/manuscript-final.md` (modified 2026-09-30 20:51)
- **Artifacts dir:** project root (`tables/`, `figures/`, `scripts/`, plus `analysis/scripts/`, `analysis/output/`, `manuscript/tables/`)
- **Date:** 2026-10-12
- **Mode:** review only. No project file was modified, re-run, or deleted. New files exist only under `review-output/`.

## ⚠ Process status: panel did NOT run

All four verification agents (verify-numerics, verify-figures, verify-logic, verify-completeness) were dispatched in parallel. Every one was terminated by an API safety filter before it wrote anything. A retry of verify-numerics on a second model was blocked the same way. This matches the failure recorded in `PIPELINE-STATUS.md` for Phase 6.

Under the skill contract, the per-agent report-on-disk gate therefore **fails closed**. The findings below come from a **single inline verification by the orchestrator** across all four dimensions. The work included cell-by-cell comparison of every table, recomputation of every percent and CI conversion, visual inspection of all four figures against their source CSVs, and an inventory of the statistical claims in the prose. Because there was no independent second reviewer, **no ★★ cross-agent markers are possible**. Treat this as a strong single-reviewer check, not the full 4-agent panel.

Fabricated per-agent reports would misrepresent provenance, so none were written. This consolidated report and the fix checklist are the only report files.

---

## Verification Scorecard

**STAGE 1: Raw outputs → manuscript tables/figures**

| Dimension | Agent role (performed inline) | Issues | Critical | Warnings | Score |
|---|---|---|---|---|---|
| Numeric consistency | verify-numerics | 1 (INFO) | 0 | 0 | PASS |
| Figure consistency | verify-figures | 4 | 0 | 2 | PASS (with warnings) |

**STAGE 2: Manuscript tables/figures → prose**

| Dimension | Agent role (performed inline) | Issues | Critical | Warnings | Score |
|---|---|---|---|---|---|
| Statistical logic | verify-logic | 7 | 1 | 3 | FAIL |
| Artifact completeness | verify-completeness | 4 | 0 | 2 | PASS (with warnings) |

**OVERALL**

| Total issues | Critical | Warnings | ★★ cross-agent | Score |
|---|---|---|---|---|
| 16 (incl. 8 INFO) | 1 | 7 | n/a (single reviewer) | FAIL |

**VERDICT: REVISIONS NEEDED.** There is 1 CRITICAL issue and more than 3 WARNINGS. All issues are interpretive or documentary; no numeric transcription errors were found.

---

## Fix Checklist

See `fix-checklist-2026-10-12.md`. Its contents are reproduced in condensed form here:

- **CRIT-TXT-001:** The Conclusion (line 217) and Discussion (line 205) call the hydroelectric gap "absent". The pre-specified equivalence test failed (90% CI [−0.063, 0.023] extends beyond ±0.05), and §4.3 itself says a ~6% gap cannot be ruled out.
- **WARN-TXT-001:** The Discussion (line 207) says engineers and managers are paid "about the same". The professional/managerial gap is −5.5% (p = 0.014).
- **WARN-TXT-002:** §3.1 (line 71) cites "(Table 1)" for coverage shares that Table 1 does not show. The "63–92%" range holds only for pooled biomass and geothermal; geothermal alone is 45–72%.
- **WARN-TXT-003:** The Discussion (line 207) uses predictive mover language ("should expect to earn") in a descriptive design.
- **WARN-FIG-001:** The Fig. 1 caption uses M7, which is undefined in Methods.
- **WARN-FIG-002:** The text says "sixteen" robustness specifications, but 17 alternative rows are shown in Table A1 and Fig. A1.
- **WARN-REF-001:** File and registry numbering do not match manuscript numbering for Figs 1–3 and Tables A1–A2.
- **WARN-REF-002:** The pre-specified S10 stricter-support decomposition was computed but not reported.

---

## Stage 1 Detail: Numerics (raw → manuscript tables)

**Mapping established**

| Manuscript | Raw source | Producer |
|---|---|---|
| Table 1 | `tables/table1-descriptives.csv` (2021 and 2025 rows) | `02_descriptives.R` → `08_manuscript_tables.R` → `manuscript/tables/table1.md` |
| Table 2 | `analysis/output/main-contrasts.csv` (est, se, CI, p_cr1 / p_wcr / p_holm, pct_gap) | `03_main_models.R` → `08` → `table2.md` |
| Table 3 | `tables/table3-decomposition.csv` rows 1–5 | `04_decomposition.R` → `08` → `table3.md` |
| Table 3 change panel | `analysis/output/d2-change.csv` | `04` → `08` → `table3b.md` |
| Table A1 | `tables/tableA3-robustness.csv` | `05_robustness.R` → `08` → `tableA1.md` |
| Table A2 | `tables/table2-main-regressions.csv` (also .html/.md) | `03_main_models.R` |

**Results**

- Every line of `manuscript/tables/{table1,table2,table3,table3b,tableA1}.md` appears verbatim in the manuscript (65/65 lines). Table A2 matches `table2-main-regressions.csv` exactly, including all coefficients, SEs, stars, N (1877, 1856, 1578 ×4) and R².
- **Table 1:** all 16 wage cells round correctly to $100. For example, nuclear 2021 is 133,337.18 → 133,300 and wind 2025 is 100,663.64 → 100,700. Cells and employment match exactly. Ratio: 104,831.75 / 120,055.57 = 0.8732 and 102,513.16 / 117,436.51 = 0.8729, which agree with `raw-ratio-by-year.csv`. **PASS.**
- **Table 2:** for all 18 rows the log points, SE, CI and percent (100·(e^b − 1)) were recomputed. The p-value types follow the note:
  - M1 and the round-specific gaps use CR1 (0.0216 → 0.022).
  - Technology contrasts use the Holm-adjusted wild bootstrap (wind 0.0075 → 0.008; biomass 0.0075 → 0.008; hydro 0.739).
  - Other contrasts use the wild bootstrap (solar − hydro 0.0155 → 0.016; office 0.0055 → 0.006; other 0.301; change 0.330 and 0.737).
  - Clusters = 122.

  **PASS.**
- **Table 3:** raw, composition, within, off-support, shared-occupation counts, off-support shares and within CIs all match. The identity Raw = comp + within + off holds within rounding (2021: 0.026 − 0.109 − 0.082 = −0.165 against −0.166). For the change panel, −0.0198 + 0.0177 − 0.0514 = −0.0535, with CI [−0.112, −0.001] and counts 54/23/5. **PASS.**
- **Table A1:** all 17 rows match `tableA3-robustness.csv` (gap, CI, change, change CI, N). The note's claims hold: R10 and R14 equal the headline estimate to 3 dp, and R11 reproduces the headline change. **PASS.**
- **INFO:** Table A2 stars use CR1, while Table 2 uses the wild bootstrap. "Other occupations" therefore shows * in A2 (p = 0.049) but p = 0.301 in Table 2. Both notes disclose the method, but a cross-reference would help readers.

## Stage 1 Detail: Figures (raw → manuscript figures)

All figure files (20:45) postdate their inputs (models 20:37, decomposition and robustness 20:38). No staleness was found, and there are no orphaned or missing figure files.

| Manuscript | File | Data check | Caption check |
|---|---|---|---|
| Fig. 1a | `fig2-technology.png` A | Matches `main-contrasts.csv` S04 (nuclear +11.6, hydro −2.0, wind −7.3, solar −12.1, biomass/geothermal −24.4). | OK |
| Fig. 1b | `fig2-technology.png` B | Matches `tech-by-year.csv` (S08). Nuclear 15.9 → 14.8 → 12.9 → 10.3 → 5.0; solar −12.4 … −16.5; wind +0.7 … −9.0; hydro −4.3 … −3.7. The prose values at line 176 all reproduce. | "model M7" is undefined in Methods → **WARN-FIG-001** |
| Fig. 2a | `fig3-occupation.png` A | Matches S05 (−5.5, −11.0, −12.6, −16.4) with CIs. | OK |
| Fig. 2b | `fig3-occupation.png` B | Matches `major-group-gaps-shown.csv`, 10 groups. Arts/design, Legal and Sales are correctly omitted under the ≥3-occupation rule. The prose values −0.8, −3.5, −28.3, −35.5, −17.6 and −8.1 all reproduce. | INFO: Production CI implausibly narrow (SE 0.0069) |
| Fig. 3 | `fig1-gap-trend.png` | Raw gap = decomposition raw. The decomposition within term (−10.3 … −15.0) and M6 (−11.4, −10.0, −12.0, −10.7, −13.0) match. | OK. Raw-gap bars are decomposition bootstrap CIs, which the caption implies. |
| Fig. A1 | `figA1-robustness.png` | Matches `tableA3-robustness.csv`; 18 rows (headline + 17). | "sixteen robustness specifications" → **WARN-FIG-002**. INFO: x-axis title clipped, unit missing. |

## Stage 2 Detail: Logic (manuscript tables/figures → prose)

**Claims verified (PASS):**
- Abstract and highlights: 11.5%, −12.1, −7.3, −24.4, +11.6, −16.4, −5.5, "three times" (2.98× in percent, 3.15× in log points), and 1,877 cells.
- Highlights: −20% and −6% (R5a −19.8, R5b −5.9).
- Introduction: 18,000 → 36,000 (17,990 → 36,400, ×2.02) and 107,000–110,000.
- §3.1: 142,000 and 159,000, from `tableA2-coverage.csv` industry_emp sums of 141,530 and 159,080. The suppression counts 2,096 / 19 / 71 / 2,006 / 1,877 match `tableA1-sample-flow.csv` and the coverage sums. "95–98%" matches fossil and nuclear (0.947–0.980). One cell was top-coded.
- §3.3: 59/77 identifying occupations, 1,578 cells, 122 clusters.
- §4.1: all Table 1 numbers; mean pay fell in nuclear, solar and wind and rose in hydro and biomass/geothermal (verified).
- §4.2: −0.122, CI [−0.164, −0.080], p < 0.001 (bootstrap 0/9,999). "Composition 0.014–0.027 in four of five years, CIs include zero" (verified, including 2024 = −0.002). "Within −0.109 to −0.163" and "6–23%".
- §4.2, directional claim "at least as large only in 2023 and nearly in 2022", checked on unrounded values: 2023 |−0.1458| > |−0.1452| ✓; 2022 −0.150 against −0.157 ✓.
- §4.3: hydro 95% CI in percent (−6.92, +3.20) and 90% CI (−0.063, 0.023); solar/wind − hydro 10.3 and 5.5; R12 −0.164 / 15.1%.
- §4.4: joint Wald p = 0.004; CIs in percent (−20.5/−12.0 and −9.5/−1.4); managers 3.5 and professional/technical 6.6 (`class5-gaps.csv`); distributional 19.8 / 14.1 / 5.9.
- §4.5: change −0.019, CI and 90% CI (−0.049, 0.012) within ±0.05 → stable, per the rule; 2024 contrast +0.008, 90% CI (−0.029, 0.044); joint p = 0.040; 2022 = −0.105; decomposition change components; R13 −0.040 [−0.080, 0.000].
- §4.6: range −0.060 to −0.220; −0.106, −0.123, −0.118; change range −0.049 to +0.015; every 95% CI includes zero (R13's upper bound is +0.0003).
- Discussion: "less than two percentage points" (−1.8%).

**Issues:** CRIT-TXT-001, WARN-TXT-001/002/003 and INFOs, as listed in the fix checklist.

**Period labels:** consistent. "May YYYY" is used throughout, and the panel-overlap statements in §3.3, §4.3, §4.5 and the Fig. 1 and Fig. 3 captions agree. No `period-definitions.csv` exists. **PASS.**

**Hypothesis adjudication**

| H | Pre-specified test (analysis-plan.md) | Evidence | Manuscript verdict | Assessment |
|---|---|---|---|---|
| H1 | Within-occ gap < 0 | −0.122, p < 0.001 | Supported | ✓ |
| H2 | Solar and wind < 0 (Holm); hydro ≡ fossil (TOST ±0.05); nuclear ≥ fossil | Solar, wind and biomass/geothermal < 0; nuclear > 0; hydro **not equivalent** (90% CI −0.063 to 0.023) | §4.3: "supported for solar, wind, and nuclear; hydro inconclusive" | ✓ in §4.3, though biomass/geothermal is omitted from the sentence. ✗ in Conclusion and Discussion ("absent", "It does not") → CRIT-TXT-001 |
| H3 | Blue-collar gap > professional/managerial gap | −0.122, p = 0.008 | Supported | ✓ |
| H4 | No narrowing (90% CI within ±0.05) | Change −0.019, 90% CI (−0.049, 0.012) | Supported (stable) | ✓ |
| H5 | Composition does not explain the gap; within ≥ raw | Composition ≈ 0; within ≥ raw only in 2023 | Partially supported | ✓, appropriately nuanced |

**External numbers (cannot be checked against analysis outputs; need a citation-faithfulness check):** USEER 919,000; DOE union and project-labor coverage of 11–19% (lines 57 and 205, which are internally consistent with each other); Vona ~4%; Curtis "a fifth"; Curtis 2024 "<1%"; DOE "more than twice as fast".

## Stage 2 Detail: Completeness (full-chain map)

| Raw artifact | Manuscript item | In-text references |
|---|---|---|
| `table1-descriptives.csv` | Table 1 | lines 71 (wrong content, WARN-TXT-002), 98, 176 |
| `main-contrasts.csv` | Table 2 | lines 118, 143 |
| `table3-decomposition.csv` (S09) + `d2-change.csv` (S11) | Table 3 | line 145 |
| `fig2-technology.png` (S04, S08) | Fig. 1 | lines 172, 176 |
| `fig3-occupation.png` (S05, S06) | Fig. 2 | lines 180, 184 |
| `fig1-gap-trend.png` (S07, S09, S03) | Fig. 3 | line 190 |
| `tableA3-robustness.csv` (R01–R16) | Table A1 | lines 91, 172, 186, 198 |
| `table2-main-regressions.csv` | Table A2 | line 143 |
| `figA1-robustness.png` | Fig. A1 | **not referenced in text** (INFO: cite it in §4.6) |
| `tableA1-sample-flow.csv` | none (numbers in prose, line 71) | the file name collides with manuscript "Table A1" |
| `tableA2-coverage.csv` | none (numbers in prose, lines 69 and 71) | the file name collides with manuscript "Table A2" |
| `class5-gaps.csv`, `tech-by-year.csv`, `major-group-gaps(-shown).csv`, `joint-tests.json`, `identifying-occupations.csv` | Figs 1b, 2 and prose | traceable |
| S10 (stricter-support decomposition) | **not reported** | WARN-REF-002 |

- Numbering is sequential: Tables 1→2→3→A1→A2 and Figs 1→2→3→A1, each first cited in order.
- Naming inconsistencies (INFO): "Biomass/geothermal" (Table 2, Fig. 1a) and "Biomass and geothermal" (Table 1, Table A2, prose). Choose one form.
- `results-registry.csv` (28 rows) covers S01–S11 and R01–R16 and points to existing source files.

---

## Quality self-audit

- [x] Every CRITICAL has a manuscript line and source file/cell.
- [x] False-positive check: all directional and rounding claims were checked on unrounded values.
- [x] Deduplicated.
- [ ] ★★ markers: not possible, because the independent agents did not run.
- [x] Stage 1 and Stage 2 are separated.
- [x] Fix items name what to change, where, and to what.
- [x] Verdict follows the Step 3d rules (1 critical, 7 warnings → REVISIONS NEEDED).
- [ ] 4-agent report-on-disk gate: **FAILED** (safety-filter termination). This is disclosed above.
