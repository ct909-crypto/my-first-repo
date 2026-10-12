# Design Blueprint

outcome_mechanism_alignment: prevalence-stock

## Question and claim strength
The design describes how hourly wages differ between renewable and non-renewable electric power generation industries in the United States for workers in the same detailed occupation, how those gaps vary by generation source and occupational group, and how they changed from May 2021 to May 2025. The claim strength is descriptive. Estimates are interpreted as establishment-side wage differences for the same occupation, not as causal effects of moving a worker into renewable generation.

## Data and unit of analysis
The data are the BLS Occupational Employment and Wage Statistics (OEWS) national industry-specific estimates for May 2021-May 2025. The analytic unit is a detailed 2018 SOC occupation within a six-digit NAICS generation industry in a survey year. Seven industries enter the main contrast: hydroelectric (221111), fossil fuel (221112), nuclear (221113), solar (221114), wind (221115), geothermal (221116), and biomass (221117). Other electric power generation (221118) mixes heterogeneous technologies and is used only in sensitivity checks. Petroleum-fired generation is part of the fossil fuel industry and cannot be separated. Transmission and distribution (22112) are not published at this level and fall outside scope.

## Measures
The outcome is the natural log of the cell's mean hourly wage converted to May 2025 dollars with the CPI-U. The focal predictor is an indicator for a renewable generation industry. Moderators are the generation source, five occupational groups derived from SOC major codes, and survey year. Cells are weighted by estimated employment.

## Model ladder
M1 estimates the raw gap within year. M2 adds occupation fixed effects. M3, the headline model, uses occupation-by-year fixed effects so that each comparison is between industries for the same occupation in the same year. M4 replaces the binary indicator with source indicators relative to fossil fuel. M5 interacts the renewable indicator with occupational group. M6 interacts it with year and adds a linear-trend version. M7 decomposes the raw gap each year into occupational composition and within-occupation components. M8 repeats M3 for the 10th and 90th percentile wages. Standard errors are clustered by detailed occupation, and interaction blocks are evaluated with joint Wald tests.

## Threats and responses
Sorting on unmeasured skill and regional cost differences cannot be removed with national cells and are treated as scope limits. Small cells, sampling error, top-coding, and categorization choices are addressed with the robustness plan (unweighted and inverse-variance weights, medians, balanced occupation set, alternative categorizations, minimum cell size, and leave-one-source-out). Because each OEWS release pools six semiannual panels collected over three years, adjacent years share data; trend results are described as smoothed changes, and no single-year shift is interpreted as a sharp break.
