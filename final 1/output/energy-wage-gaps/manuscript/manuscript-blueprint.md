# Manuscript Blueprint

**Target:** Energy Policy (full-length research article (descriptive empirical)). **Lock:** lock-20261010T134805Z. **Discussion mode:** split (Discussion + Conclusion and Policy Implications).

**Title:** Same Job, Lower Pay? Wage Gaps between Renewable and Non-Renewable Electric Power Generation in the United States, 2021-2025

## Final paper claim

Between May 2021 and May 2025, U.S. renewable electricity generation industries paid about 11.5 percent less per hour than fossil fuel and nuclear generation for workers in the same detailed occupation; the gap was concentrated in solar, wind, geothermal and biomass (not hydroelectric) generation and in plant-operations and maintenance occupations, and it did not narrow while renewable generation employment doubled.

## Ranked contributions

1. (empirical) Same-occupation renewable wage gap of about 11.5% inside U.S. power generation, 2021-2025. Scope: descriptive, national cells.
2. (heterogeneity) The gap is technology- and occupation-specific: hydro at parity, nuclear premium, largest gaps for plant-operations workers. Scope: geothermal imprecise.
3. (dynamic/null) No narrowing during a period of rapid renewable expansion and new labor standards. Scope: OEWS three-year pooling smooths trends.
4. (theoretical) Reconciles green-premium and legacy-premium literatures by locating the energy-transition wage penalty in establishment wage-setting rather than occupational composition. Scope: mechanism interpreted, not measured.

## Result hierarchy

- supporting: tables/table1-descriptives.html: Table 1: analytic sample, wages, employment shares and occupational mix by generation technology
- headline: tables/table2-main-regression.html: Table 2: raw to within-occupation gap ladder and distributional gaps (Models 1-5)
- headline: tables/table3-heterogeneity-regression.html: Table 3: gaps by generation technology, occupation category and year (Models 6-9)
- supporting: tables/table4-decomposition.csv: Table 4: decomposition of the raw gap into composition, within-occupation and non-overlap components
- sensitivity: tables/tableA1-robustness-regression.html: Table A1: robustness of the headline gap
- supporting: figures/fig1-wage-by-source-year.pdf: Figure 1: wage levels by technology and year
- headline: figures/fig2-source-gaps.pdf: Figure 2: within-occupation gaps by technology vs fossil fuel
- headline: figures/fig3-gap-by-year.pdf: Figure 3: raw and within-occupation gap by year
- headline: figures/fig4-gap-by-occupation-group.pdf: Figure 4: gap by broad occupation category

## Hypothesis resolution

- H1 (supported): Headline: renewable industries pay about 11.5% less for the same occupation and year; robust to weighting, outcome, sample, classification and clustering.
- H2 (null_compatible): Occupational composition does not explain the raw gap; renewable occupational mix slightly favors higher pay. Report as a substantive finding: the gap is a within-occupation pay difference plus occupations unique to one group.
- H3 (supported): Nuclear pays about 12% more than fossil; hydro is statistically indistinguishable from fossil; solar, wind, geothermal and biomass pay less. Geothermal rests on 26 identifying cells and is described as imprecise.
- H4 (supported): Gap largest in production/transportation (about -18%) and construction/installation/maintenance/repair (about -14%), smallest in professional/technical (about -2%, n.s.); joint test rejects equal gaps. Lower-tail (P10) gap larger than upper-tail (P90) gap.
- H5 (null_compatible): No narrowing: within-occupation gap -11% in 2021 and -13% in 2025; trend near zero and not significant. Framed under OEWS panel smoothing; no policy attribution.

## Section obligations

- **abstract**: moves: purpose and policy relevance; data (OEWS May 2021-2025, NAICS 2211 cells); method (employment-weighted occupation-by-year fixed effects; decomposition); headline gap and source/occupation heterogeneity; trend result (no narrowing); implication for just transition. Forbidden: Table/Figure callouts; causal verbs.
- **introduction**: moves: puzzle: green-premium claims vs legacy pay; gap in literature naming closest prior work (Curtis and Marinescu 2023; Colmer et al. 2025; Godoy and Isaksen 2025); contribution; data and method preview; headline findings preview; roadmap. Forbidden: overstated causal framing; claiming IRA effects.
- **literature_review_and_theory**: moves: evaluate prior studies' strengths and weaknesses; rent-sharing framework; rival accounts; H1-H5 with derivation sentences (pre-results wording from Phase 2). Forbidden: referring to results, tables, or estimates; rewriting hypotheses after results.
- **data_and_methods**: moves: data source and OEWS design (six panels over three years, MB3); sample construction with counts (2,096 cells -> 1,876 analytic); variables: outcome, focal predictor, moderators, fixed effects, weights; estimating equations; inference (occupation clustering, two-way sensitivity); decomposition; robustness plan. Forbidden: internal spec IDs in prose.
- **results**: moves: descriptive patterns (Table 1, Figure 1); headline ladder (Table 2); decomposition (Table 4); sources (Table 3, Figure 2); occupational heterogeneity (Figure 4); trend (Figure 3); distribution (P10/P90); robustness (Table A1). Forbidden: causal verbs; ranking occupation groups by individual p-values.
- **discussion**: moves: answer RQ; adjudicate rent-sharing vs skills-scarcity vs compensating differentials; reconcile with prior literature; limitations; scope. Forbidden: policy effect claims; restating coefficients without interpretation.
- **conclusion**: moves: synthesis of contribution; policy implications for just-transition and labor standards; future research. Forbidden: new results; table/model reporting.

## Required disclosures

- descriptive design: sorting and regional composition not controlled
- OEWS three-year pooled panels smooth trends
- OEWS wages exclude overtime and shift differentials
- P90 censoring
- small geothermal and biomass samples
- reviews carried out inline because independent subagents were unavailable (workflow disclosure, trace only)
- descriptive design; estimates are not causal effects of working in renewables
- worker sorting and regional composition not controlled
- OEWS pools six semiannual panels over three years (trend smoothing)
- OEWS wages exclude overtime and shift differentials
- suppressed and top-coded cells excluded; P90 harmonized censoring
- geothermal and biomass thin; geothermal imprecise
- petroleum generation not separable from fossil fuel; transmission and distribution outside scope

## Forbidden argumentative moves

- causal language about renewable employment lowering wages
- attributing trends to the Inflation Reduction Act
- presenting H2 or H5 as supported
- ranking occupation groups on individual p-values
- using internal spec IDs (S01...) in prose or table headers
- elevating registry or diagnostics to main displays
