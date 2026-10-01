# Data and Measurement Plan

## Data provenance and access

The data are the U.S. Bureau of Labor Statistics Occupational Employment and Wage Statistics (OEWS) national industry-specific estimates for May 2021, 2022, 2023, 2024, and 2025 (files `nat5d_6d_M2021_dl.xlsx` through `nat5d_6d_M2025_dl.xlsx`). They were downloaded by the author from bls.gov and copied into `data/raw/` at project initialization. They are public tables of estimates. Each row is an industry × occupation cell with employment, mean and percentile wages, and relative standard errors. No individual or establishment records are included. The safety scan flagged false positives (date-of-birth and account-number regexes), and the author resolved them as OVERRIDE (public aggregate data). No IRB review is required because the project involves no human subjects. The data can be shared freely, and the replication package can include them. Wages are deflated to May 2025 dollars with CPI-U May values (series CUUR0000SA0), retrieved from the BLS Public API on 2026-09-30 and stored in `analysis/reference/cpi_u_may.csv`.

## Dataset design review

OEWS is an establishment survey with semiannual panels. Each May estimate combines the six most recent panels (three years), and ECI-based aging factors update the wages of older panels. Published cells are model-weighted estimates. Survey weights, strata, and establishment identifiers are *not* released in these tables, and none are needed: the published cell estimates already incorporate the sampling weights. The analysis therefore treats cell estimates as data. Cell employment serves as an analytic weight to describe the average worker, and the published mean-wage PRSE is used as a precision diagnostic and alternative weight. Panel structure matters for inference over time. Adjacent May estimates share four or five of their six panels. May 2021 (Nov 2018–May 2021) shares no panels with May 2024 (Nov 2021–May 2024) or May 2025 (Nov 2022–May 2025), and these non-overlapping contrasts carry the trend test. The sampling frame is private-ownership establishments (all rows have ownership code 5) in NAICS 2211 generation industries, so public utilities and contractors in other industries are out of scope. There is no collection mode choice relevant to the analysis. The denominator is published employment in detailed-occupation cells. The accepted limitation is that these tables do not permit worker- or establishment-level adjustment.

## Dataset fit

- **Unit:** industry (8 NAICS) × detailed occupation × estimate year cell.
- **Scope:** private U.S. electric power generation, national.
- **Time:** May 2021–May 2025 estimates (panels Nov 2018–May 2025).
- **Key variables:** mean annual wage, employment, detailed SOC, and NAICS are available in every year.
- **Sample size:** 2,096 detailed cells in total, and 2,006 cells with usable wage and employment across all eight industries (see the coverage table). There are 59–77 identifying occupations per year, and 28–58 solar and wind cells per year have a fossil-fuel counterpart in the same occupation-year.
- **Timeline:** immediate, since all files are on disk.
- **Verdict:** PASS for the descriptive design. It is feasibility-limited for biomass and geothermal, and for precise trend contrasts.

## Sample restrictions

1. Detailed occupations only (O_GROUP = "detailed"). The files also contain major, minor, broad, and total rows (458, 1,061, 1,898, and 40 rows across 2021–2025); including them would double-count workers.
2. Drop cells with suppressed mean wage ("*": 19 detailed cells) or suppressed employment ("**": 71 detailed cells).
3. The main sample excludes NAICS 221118 (other generation). Sensitivity analyses include it.
4. No restriction on PRSE in the main sample. A sensitivity analysis restricts to PRSE ≤ 10.

## Coverage (from `data/audit/phase4-data-audit.txt`)

Published, usable detailed-cell employment as a share of each industry's total employment ranges as follows:
- fossil and nuclear: 0.95–0.98
- hydroelectric: 0.82–0.86
- solar: 0.71–0.92
- wind: 0.78–0.89
- biomass: 0.70–0.78
- geothermal: 0.45–0.72

Coverage of renewable industries improved over time. Suppression is therefore concentrated in small renewable cells, and it declines over the window. The paper reports this, and the balanced-cell and continuing-occupation analyses (R1, D2) bound its influence.

## Codebook validation

Checked against each file's Field Descriptions sheet:
- **Value codes:** "*" = wage not available; "**" = employment not available; "#" = wage at or above the top code; "~" = establishments reporting < 0.5%.
- **Top codes:** $100.00/hour or $208,000/year in May 2021, and $115.00/hour or $239,200/year in May 2022–2025, read programmatically.
- **Top-coded counts:** mean wages 2 detailed cells in total. P90 is top-coded in 0–13 cells per industry-year, mostly nuclear and fossil management and engineering.
- **Units:** annual wages in current dollars; employment rounded to the nearest 10.
- **Annual- and hourly-only flags:** empty for all detailed cells in these industries.
- **NAICS:** codes and titles are identical across all five files. OWN_CODE = 5 (private) for all rows.
- **Skip logic:** none, since these are published tables.

## Measurement validity

The outcome is the establishment-reported mean wage for the occupation. For most occupations, OEWS computes annual wages as hourly × 2,080, so the hourly mean is used as a robustness outcome. Because the unit is a cell, the log of the cell mean is modeled. This differs from the mean of individual log wages, and the paper says so. Detailed SOC codes are the finest occupational classification available, but they still group heterogeneous jobs. The gap is therefore interpreted as pay for a classified job, not for identical work. The occupational-class mapping from SOC major groups is coarse, so major-group results are reported alongside it.

## Missing data and special codes

True missingness comes from BLS suppression for reliability or confidentiality. It is not an item-nonresponse process. There are no structural skips or inapplicable items. Top-coded values are right-censored: the mean-wage cases (2) are set to the threshold and dropped in a sensitivity analysis, and P90 censoring is counted and reported. No imputation is used. Denominator-changing restrictions (detailed-only; dropping 221118) are documented in the sample-flow table.

## Outcome family screen

The outcome is continuous, strictly positive, and right-skewed in levels. It is modeled in logs. The only censoring is at the top code (2 mean-wage cells; P90 more often). The outcome is not bounded, zero-inflated, a count, a duration, or a time-use measure. A Gaussian linear model on log wages is appropriate. Percentile outcomes are secondary and flagged as censored.

## Post-treatment review

The only adjustment variables are detailed occupation and estimate year (fixed effects). These are job classifications that precede, and are not affected by, the establishment's generation technology in the sense relevant here. Establishment size, union coverage, and ownership are mechanisms, not controls; they are not in the data and are deliberately not adjusted for. No unresolved post-treatment risk remains.

## Security and sharing

The data are public, and no restricted data are held. Project files stay on the author's machine. Data and code can be deposited openly.

## Feasibility for the journal and timeline

The data path is feasible now. It meets ERSS expectations for a transparent descriptive analysis, provided scope conditions (private, generation-only, in-house employment) and OEWS time-series caveats are stated.
