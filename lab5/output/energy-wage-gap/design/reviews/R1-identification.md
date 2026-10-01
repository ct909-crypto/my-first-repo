# R1 Identification Review (ERSS)

**Ratings.** Claim-design match: Adequate. Estimand clarity: Weak. Threats to validity: Adequate. Decomposition: Adequate. Trend-test logic: Weak.

## Issues

1. **CRITICAL: panel-overlap claim for 2025 is wrong.** A May-t estimate pools Nov(t-3) to May(t). May 2021 uses Nov 2018 to May 2021. May 2024 uses Nov 2021 to May 2024. May 2025 uses Nov 2022 to May 2025. So 2021 vs 2025 shares no panels, not "one of six" (Sec. 5, M6). The 2021 vs 2024 contrast is non-overlapping but only just (adjacent panels). Fix: state both 2021-2024 and 2021-2025 as non-overlapping, and make 2021 vs 2025 (longer span, more power) co-primary or primary. Declare that 2022 and 2023 overlap 2021 and that 2025 overlaps 2024. Caveat: non-overlapping panels do not mean independent establishments, because small NAICS 2211 cells may resample the same certainty or large units. Clustering by occupation does not cover this. Add an establishment-overlap caveat, and cluster by industry-occupation or use a cell-level bootstrap.

2. **CRITICAL: H4 test logic.** "Retained unless narrowing with p<.05" treats non-rejection as support, and MDES is about 0.06. Absence of narrowing is not evidence of "durable inequality". Fix: report the 2021-2024 and 2021-2025 differences with CIs, and pre-specify an equivalence margin (TOST) or drop the "supported" language. Also reword H4 to "no detectable narrowing".

3. **MAJOR: E1 weighting mismatch.** WLS with cell employment and occupation×year FE weights each occupation by the within-occupation variance of R times its employment. That is not the "average worker" gap, and it differs from the D1 within term. This breaks the M1-vs-M3 comparison for H5. Fix: define E1 as the Kitagawa within term on common support, or use explicit common-support weights. Report the M3 weights' effective employment shares.

4. **MAJOR: H5 sign and normalization.** The composition term needs within-support shares renormalized to sum to 1 in both groups. Otherwise it absorbs a level shift. State the sign: composition > 0 means renewables' mix favors pay. Solar and wind occupations (PV installers, wind technicians) may be off-support, so report the off-support share by year and bound the result with alternative support rules (e.g., SOC broad group).

5. **MAJOR: cell publication and suppression.** Suppression is correlated with size and wage, and renewable cells roughly doubled. A balanced-cell subset selects large cells and does not address entry. Fix: decompose the 2021-to-2024 change in the gap into continuing cells and entering cells. Add bounds or IPW for publication. Report employment coverage by industry-year.

6. **MAJOR: selection and outsourcing.** Much renewable labor (installers, construction) sits in contractor NAICS outside 2211, and the extent of outsourcing differs by technology. The "same occupation" comparison is therefore conditional on in-house employment. State this as a scope condition and as a threat in the Discussion.

7. **MAJOR: power and pooling.** The pooled five-year SE (0.010-0.015) is optimistic because the years share panels. Use an effective-N argument, or base power on non-overlapping years only.

8. **MINOR: outcome measure.** A_MEAN assumes 2080 hours. Add H_MEAN as a robustness outcome. Deflation is absorbed by occupation×year FE, so drop it from the identification story. OEWS ECI aging of older panels smooths change, so interpret E4 as change in a 3-year pooled window.

9. **MINOR: H2 decision rules.** "Largest for solar/wind" has no ordering test, and "nuclear not significantly negative" is weak. Add pairwise tests (solar vs hydro) and an equivalence test for hydro.

10. **MINOR: H1 mechanism.** Institutional pay-setting is untested. Phrase the mechanism as interpretive.
