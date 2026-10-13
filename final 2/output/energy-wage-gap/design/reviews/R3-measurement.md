# R3 Measurement Review (ERSS)

**Ratings:** Outcome construction Adequate. Renewable/technology coding Adequate. Occupational class mapping Weak. Employment weighting Adequate. Suppressed cells Weak. Percentile outcomes Weak.

## Issues

1. **MAJOR - Suppression is non-ignorable.** Dropping "*"/"**" cells removes small solar, wind and biomass cells disproportionately, changing the occupation mix that M3 and D1 compare; only counts by industry-year are reported. Fix: report dropped employment share (against industry totals) by technology and year; add a reweighting or bounds check.

2. **MAJOR - Class mapping is coarse.** Managers (11) are lumped with professionals (13-19); group 17 includes engineering technicians; "support/other" mixes healthcare, security, sales and office work. Fix: use 4-5 classes (managers, professional/technical, skilled trades, admin support, other) and report major-group results as primary.

3. **MAJOR - Percentile outcomes are censored.** P90 (and sometimes the median) hits the "#" top code in management and engineering cells, biasing the P90 gap toward zero. Cell percentiles are also not a worker distribution. Fix: treat as censored (Tobit or bounds), report the censored share, and label them "within-cell reported percentiles".

4. **MAJOR - No robustness for hydro or nuclear.** Only "other" gets R6/R7, yet hydro and nuclear drive H2. Fix: add hydro-as-nonrenewable, nuclear-as-clean or excluded, and a new-renewable (solar, wind, geothermal) versus fossil contrast.

5. **MAJOR - Weight claim is imprecise.** With occupation-by-year FE, employment-weighted WLS yields a variance-weighted estimand, not the "average worker"; TOT_EMP is noisy. Fix: describe it accurately and show unweighted and alternative-weight versions.

6. **MINOR - Top-coding.** Setting "#" to the threshold gives a lower bound, and the nominal threshold varies by year. Dropping "#" (R8) selects out high-wage cells. Fix: add a censored-regression sensitivity check. Note that occupation-by-year FE absorb the CPI deflator, so it matters only for M1, M2 and descriptive tables.

7. **MINOR - Annual wage is hourly x 2,080 hours** for most occupations, ignoring hours. Fix: add H_MEAN as a robustness outcome. The log of a cell mean is not the mean of log wages; say so.

8. **MINOR - NAICS vintage** (2017 in 2021, 2022 later). Fix: confirm 221111-221118 are unchanged.
