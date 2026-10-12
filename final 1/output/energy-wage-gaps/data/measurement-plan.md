# Measurement Plan (scholar-data, Phase 4)

## Data provenance and dataset fit
The analysis uses five public files from the BLS Occupational Employment and Wage Statistics (OEWS) program: the national industry-specific estimates for May 2021, 2022, 2023, 2024, and 2025 (`nat5d_6d_M{year}_dl.xlsx`). Each file lists, for every published occupation in every 5- and 6-digit NAICS industry, estimated employment, the mean wage, wage percentiles, and relative standard errors. The user supplied the files. They were copied unchanged into `data/raw/` and scanned in Phase 0. The scanner flagged them only because occupation titles (for example, "Accountants") and date-like fields matched its patterns, and the user recorded an override with a rationale. Constant-dollar conversion uses the CPI-U for all urban consumers (series CUUR0000SA0, not seasonally adjusted) for May of each year: 269.195 (2021), 292.296 (2022), 304.127 (2023), 314.069 (2024), and 321.465 (2025). These values were retrieved from the BLS public API.

The data fit the research question. Electric power generation (NAICS 2211) is published as eight six-digit industries in every year. The same detailed occupations recur across those industries, so within-occupation comparisons are feasible. The analytic population is wage and salary workers in establishments classified to hydroelectric (221111), fossil fuel (221112), nuclear (221113), solar (221114), wind (221115), geothermal (221116), and biomass (221117) generation. Other electric power generation (221118) mixes tidal and miscellaneous technologies and enters only a sensitivity check. Petroleum-fired plants belong to the fossil fuel industry and cannot be analyzed separately. Transmission and distribution are not published at the six-digit level in these files.

## Key-variable coverage
Every model variable in `design/model-specs.json` maps to a row of `data/variable-dictionary.csv`. The outcome is the log of the cell's mean hourly wage in May 2025 dollars. The focal predictor is the renewable-industry indicator. The source contrast uses a seven-category generation-source variable with fossil fuel as the reference. The heterogeneity analysis groups occupations into five categories by SOC major group:
- management, business, and financial (11–13);
- professional and technical (15–29);
- office, sales, and service (31–43);
- construction, installation, maintenance, and repair (45–49, including the few farming and forestry codes in group 45);
- production and transportation (51–53).

We fixed this grouping before estimation. Detailed occupation and occupation-by-year identifiers define the fixed effects. Cell employment is the analytic weight. The relative standard error of the mean wage supplies inverse-variance weights for robustness. Median, 10th-percentile, and 90th-percentile wages serve as robustness and distributional outcomes.

## Measurement validity
OEWS mean wages are employer-reported straight-time gross pay. They exclude overtime, shift differentials, and most bonuses, which can be substantial for plant operators. Hourly wages for occupations reported only on an annual basis are not published; none of the generation occupations in our sample is annual-only. Within a detailed occupation, job content may differ across industries. For example, sales representatives in solar are not identical to those in nuclear. We treat this as a scope limitation, not a measurement error we can correct. Because the 2018 SOC and 2022 NAICS definitions apply throughout 2021–2025, the classifications are stable across years. Since May 2021, OEWS has produced estimates with the MB3 model-based method, so the estimation method is also constant across our window.

## Missing values, special codes, and top-coding
We distinguish four non-standard values:
- **Suppressed wage cells (`*`).** A wage estimate is not available. These cells are true missing values and are excluded.
- **Suppressed employment cells (`**`).** These cells cannot be weighted. They are excluded from weighted models and appear only in the unweighted robustness check if a wage is present.
- **Top-coded wages (`#`).** The wage equals or exceeds the published ceiling. That ceiling was $100.00 per hour ($208,000 per year) in the 2021 file and $115.00 per hour ($239,200 per year) in the 2025 file. The analysis script reads the threshold for each year from the file's field descriptions. Only two detailed cells have top-coded mean wages, and they are excluded. Top-coding is common for 90th-percentile wages. Under the $100 ceiling, 26 to 40 detailed generation cells per year are censored (2021 to 2024), compared with one cell in 2025 after the ceiling rose. To keep the P90 comparison consistent across years, the P90 outcome treats any value at or above $100 nominal per hour as censored in every year, and those cells are excluded. The P90 model is therefore a comparison among cells below a common ceiling. Suppressed mean wages affect 0 to 8 cells per year, and suppressed employment affects 8 to 20 cells per year.
- **Aggregation rows.** Rows for major, minor, broad, or total occupation groups (O_GROUP ≠ "detailed") are not missing data. They are excluded to avoid double counting.

There are no structural skips or inapplicable items, since these are establishment-reported aggregates. The denominator changes when cells are suppressed. We therefore report cell counts by industry and year, plus the share of suppressed cells, before modeling.

## Sample restrictions
The main sample comprises detailed-occupation cells in the seven analytic industries with a published mean hourly wage and employment. Within-occupation models identify gaps only from occupation-year cells that appear in at least one renewable and one non-renewable industry. Singleton occupation-year cells contribute nothing to those estimates, and we report how many there are. A balanced robustness sample keeps occupations observed in both groups in all five years.

## Outcome family
The outcome is a continuous, approximately normal log wage. It is not bounded, zero-inflated, count-like, or duration-like. We therefore use linear models in logs, and the model ladder varies fixed effects and weights rather than the outcome family. We report coefficients as approximate percent gaps, (exp(b) − 1) × 100.

## Post-treatment risks
No control variable is post-treatment. The only adjustments are occupation and year identifiers, which are defined before industry assignment. Establishment traits that may carry the mechanism (rents, union coverage, plant size) are not available and would not be controlled even if they were, because they lie on the theorized pathway.

## Access, IRB, security, and sharing
The data are public, aggregate, and contain no individual records. The project therefore does not involve human subjects, and no IRB review is required. No security restrictions apply. The raw files and all derived datasets can be shared in a replication package, subject only to BLS public-domain terms. Data access is immediate, so the data path is feasible for an Energy Policy submission timeline.
