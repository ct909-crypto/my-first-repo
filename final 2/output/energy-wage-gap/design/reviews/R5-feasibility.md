# R5 Feasibility / Power Review

**CRITICAL**
1. **Cluster count overstated.** "~160 clusters" counts all occupations, but M3 identifies only from occupation-years with both sectors (59 in 2021, 77 in 2025, ~80 in the pooled overlap). Singletons are absorbed by occ x year FE (fixest drops them). Employment weights concentrate influence in a few occupations, so effective clusters are lower still. Fix: report identifying clusters and N after singleton removal per model. Use wild cluster bootstrap (Webb weights, fwildclusterboot/boottest) as the primary inference for M3-M6, with CR1 as secondary.
2. **MDES is optimistic.** The SE of 0.013 comes from one 2025 cross-section with 2-digit FE, not detailed occ x year FE. Five OEWS years share panels, so pooling adds little independent information; 0.010 is unsupported. 2021 has only 59 overlap occupations and ~18k renewable jobs, so its SE exceeds 2025's. A 2024-vs-2021 SE of 0.02 is likely 0.025-0.035 (MDES ~0.07-0.10). The observed raw ratio is flat (0.873 vs 0.872), so a true change is probably below MDES. Fix: compute SEs from a dry run on the public cell structure (simulation using the actual overlap design), and report MDES as 2.8 x SE. Frame H4 "no narrowing" as inconclusive unless the CI excludes meaningful change (equivalence bounds, e.g. +/-0.05).

**MAJOR**
3. **M4/M7 sparsity.** Geothermal has 3-7 cells and biomass 11-14; few overlap with fossil occupations in the same year. M4 per-technology estimates may rest on under 10 occupations. The blueprint pools biomass+geothermal, but the proposal estimated them separately with different signs/magnitudes. Fix: report the overlap occupation count per technology-year, pool consistently, and drop M7 for this group.
4. **Hydro equivalence rule.** "CI within +/-0.05 of zero" needs SE <= ~0.025, and hydro overlap counts are unreported. Fix: use TOST or state the bound and verify feasibility.
5. **M5 subgroups.** Professional/managerial has few overlapping occupations; the joint Wald test with few clusters per class is unreliable. Fix: wild bootstrap and report clusters per class.
6. **Selection through suppression.** 71 "**" employment cells are probably concentrated in small renewable cells, so dropping them biases the sample. Fix: tabulate suppression by sector-year and bound the effect.
7. **R1 balanced-cell check** likely leaves almost no biomass/geothermal cells; state this up front.

**MINOR**
8. **Bootstrap (D1).** 999 cluster draws are computationally trivial. Resampling occupations changes the off-support share each draw, so fix the common-support rule inside the loop and report percentile CIs, with seed.
9. **Replication readiness.** Missing: set.seed, a pinned R/fixest version (renv lockfile), CPI series file with retrieval date, top-code thresholds read programmatically, a script order/Makefile, and a log of the drop counts. Specify weights handling (`weights=~emp`), `cluster=~occ`, and `fixef.rm` singleton behavior.
10. The "~2,000 cells" is consistent with 345-406 cells x 5 years (~1,900). Add the actual post-exclusion N table.

Overall: feasible as descriptive work, but power claims and cluster count need recomputation before pre-registration.
