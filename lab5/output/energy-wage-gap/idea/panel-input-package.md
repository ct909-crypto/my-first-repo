# Phase 1 Panel Input Package — Energy-sector wage gaps (OEWS 2021–2025)

TARGET JOURNAL: Energy Research & Social Science (ERSS). Research article, 6,000–10,000 words incl. references; user wants ~10–12 single-spaced pages.

## Data facts (verified from the files)
- BLS OEWS May 2021, 2022, 2023, 2024, 2025 national industry-by-occupation files (nat5d_6d). Public aggregate cells; no microdata.
- Industry: 8 six-digit NAICS within 2211 Electric Power Generation, identical codes every year: hydro 221111, fossil fuel 221112, nuclear 221113, solar 221114, wind 221115, geothermal 221116, biomass 221117, other 221118. No transmission/distribution codes in this file.
- Unit: industry × detailed SOC occupation × year cell with employment (TOT_EMP), mean annual wage (A_MEAN), percentiles (P10–P90), mean-wage PRSE.
- Detailed-occupation cells with usable wage and employment, excl. "other": 2021: 345; 2025: 406. Solar cells 31→65; wind 31→52; geothermal 3–7 cells; biomass 11–14.
- Employment (detailed cells, excl. other): renewable 17,990 (2021) → 36,370 (2025); nonrenewable ~109,800 → 107,220.
- Raw employment-weighted mean annual wage: renewable/nonrenewable ratio 0.873 (2021), 0.872 (2025) — i.e., raw gap flat while renewable employment doubled.
- Detailed occupations present in BOTH renewable and nonrenewable sectors: 59 (2021) → 77 (2025).
- Suppression: 19 wage cells "*", 71 employment cells "**", 2 top-coded "#".
- Important OEWS caveat: each May estimate pools 3 years (6 semiannual panels) with wage aging; BLS cautions against time-series use; cell estimates overlap across adjacent years.

## Author's proposal (2025 cross-section) — preliminary results
- WLS on log mean wage weighted by employment; M1 renewable dummy −0.21; M2 + 2-digit SOC FE −0.22; M3 subtypes (vs fossil): solar −0.23, wind −0.24, biomass −0.25, geothermal −0.19, hydro −0.03 ns, nuclear +0.09.
- Detailed-occupation overlap sample (309 cells, 80 occs): renewable −0.139; solar −0.18, wind −0.10, biomass −0.26, geothermal −0.24, hydro −0.04, nuclear +0.05.
- Descriptive R/NR ratio by major group 2025: construction/extraction 0.61, production 0.75, installation/maintenance/repair 0.76, office 0.85, business/financial 0.87, management 0.97, architecture/engineering 0.98.
- Theory: ecological modernization/IRA subsidy (premium) vs durable inequality/institutional (union density, firm size, internal labor markets) (penalty); Winner "artifacts have politics"; just transition.
- Weaknesses observed: N=797 at "2-digit" level likely mixes SOC aggregation levels (major/minor/broad/detailed rows) → double counting; no clustered SEs; single year; "other" sector undecided; no inflation adjustment; mechanism (unions, firm size) not measured.

## Candidate RQs
RQ1 (trend, net-of-occupation): Among workers in U.S. electric power generation, 2021–2025, how large is the wage gap between renewable (hydro, solar, wind, geothermal, biomass) and nonrenewable (fossil, nuclear) generation within the same detailed occupation, and did it narrow, widen, or persist as renewable employment doubled and the IRA took effect?
RQ2 (decomposition): How much of the raw renewable–nonrenewable wage gap each year is due to occupational composition vs within-occupation pay differences (Oaxaca-type/shift-share), and how did each component change 2021–2025?
RQ3 (heterogeneity): How do within-occupation gaps vary across energy subtypes (solar, wind, hydro, geothermal, biomass, nuclear vs fossil) and across occupational groups (blue-collar production/installation/construction vs professional/managerial), and do these patterns converge over time?
RQ4 (distributional): Is the renewable penalty larger at the bottom (P10/P25) than the top (P75/P90) of within-cell wage distributions?

Claim strength: descriptive/associational (no causal identification of sector effect; worker selection unobserved).

## Literature scan (Tier 1 local library: NONE configured — no Zotero/BibTeX/EndNote; Tier 1b scholar-rag: NOT RUN (no index); Tier 2 OpenAlex+CrossRef; Tier 3 WebSearch)
- Curtis & Marinescu 2023 (EEPE): solar/wind job postings concentrated in higher-earning occupations; uses occupational median wage, not sector-specific pay.
- Colmer, Lyubich & Voorheis 2025 (CEP DP): LEHD; clean-energy workers' earnings; limited transitions from fossil firms.
- Curtis, O'Kane & Park 2024 (EEPE): 300M job transitions; dirty-to-green transitions rare.
- Vona, Marin & Consoli 2019 (JEG): ~4% green-task premium in comparable occupations.
- Kuai, Elliott & Okubo 2025 (SSRN/IZA): green wage premium Japan, task-driven.
- Godøy & Isaksen 2025 (Grantham WP): green-firm premium Norway but below high-carbon industries.
- Lehmann 2020 (USEER wage supplement): natural gas highest median wage, solar lowest.
- Silva, Volozhenin & Sousa 2025 (SSRN): green wage premium mostly selection on unobservables.
- Hanna, Heptonstall & Gross 2024 (Sustainability Science): review of job creation in low-carbon transition.
Novelty rating: GAP — no study uses sector-specific OEWS cells to hold detailed occupation constant across generation technologies over 2021–2025. Coverage: Tier 2 + Tier 3; Tier 1 not configured; Tier 1b not run.
