## 4. Results

### 4.1 Growth without convergence in average pay

Table 1 describes the sample. Renewable generation employment in published cells doubled from 17,990 in May 2021 to 36,400 in May 2025, driven by solar (4,350 to 16,170) and wind (5,860 to 11,420), while fossil-fuel and nuclear employment was flat. The employment-weighted mean real wage in renewable establishments was $104,800 in 2021 and $102,500 in 2025, against $120,100 and $117,400 in nonrenewable establishments. The ratio of renewable to nonrenewable mean pay was 0.873 at both ends of the period. Behind this stable ratio, mean real pay fell in nuclear, solar, and wind generation and rose in hydroelectric and biomass and geothermal generation. These raw averages mix pay for the same job with occupational mix, which the following analyses separate.

**Table 1.** Sample cells, employment, and employment-weighted mean real annual wage by generation technology, May 2021 and May 2025.

TABLE1_PLACEHOLDER

*Note:* OEWS national industry-specific estimates, private ownership, detailed occupations with published mean wage and employment. Wages in May 2025 dollars (CPI-U), rounded to the nearest $100.

### 4.2 The within-occupation gap

Table 2 reports the pre-specified contrasts. Without occupational standardization (M1), renewable cells paid 15.2% less than nonrenewable cells. Comparing the same occupation within the same survey round (M3) gives 11.5% (−0.122 log points; 95% CI −0.164 to −0.080; wild bootstrap *p* < 0.001). Most of the raw gap thus remains within occupations, supporting H1.

**Table 2.** Renewable and technology wage gaps within detailed occupation and survey round, OEWS 2021–2025.

TABLE2_PLACEHOLDER

*Note:* Weighted least squares on log real mean annual wage; weights = cell employment; M1 includes round fixed effects and M3–M6 occupation-by-round fixed effects. Standard errors clustered by detailed occupation (122 clusters in M3–M6). Percent = 100 × (exp(b) − 1). *p*: Holm-adjusted wild cluster bootstrap for technology-versus-fossil contrasts; wild cluster bootstrap (Webb weights, 9,999 draws) for other pre-specified contrasts; cluster-robust *t* for M1 and the round-specific gaps. N = 1,877 cells (M1) and 1,578 (M3–M6) after singleton removal. Full regression models, including M2, are in Appendix Table A2.

The decomposition in Table 3 gives the same answer with explicit worker weights. Among occupations found in both sectors, the composition term was small and, in four of five years, slightly positive (0.014 to 0.027 log points; bootstrap intervals include zero). Renewable employment is thus not concentrated in lower-paid shared occupations, consistent with job-posting evidence [@curtis2023green]. The within-occupation term ranged from −0.109 to −0.163 log points. The remainder of the raw gap comes from occupations observed in only one sector, which account for 6–23% of renewable employment. H5 is supported in its core claim that composition does not explain the renewable disadvantage. The stronger prediction, that the within gap would be at least as large as the raw gap, holds only in 2023 and nearly in 2022, because occupations unique to one sector add a further renewable disadvantage in the other years.

**Table 3.** Kitagawa decomposition of the renewable minus nonrenewable gap in employment-weighted mean log real wages, by survey round.

TABLE3_PLACEHOLDER

*Note:* Raw = composition + within occupation + occupations off support. Composition and within terms use midpoint employment shares renormalized on occupations observed in both sectors in that round. 95% confidence intervals from 999 bootstrap resamples of occupations.

### 4.3 Technologies: the renewable label hides the variation

Fig. 1a shows that the pay gap differs sharply by technology. Relative to fossil-fuel generation in the same occupation and round, solar establishments paid 12.1% less (Holm-adjusted *p* < 0.001), wind 7.3% less (*p* = 0.008), and biomass and geothermal 24.4% less (*p* = 0.008). Hydroelectric pay was 2.0% lower but not distinguishable from fossil-fuel pay (*p* = 0.739; 95% CI −6.9% to +3.2%). Its 90% interval (−0.063 to 0.023 log points) extends just beyond the equivalence margin, so equivalence is not established either. Nuclear establishments paid 11.6% more than fossil-fuel establishments (*p* < 0.001). Solar and wind both paid significantly less than hydroelectric generation (by 10.3% and 5.5%), so the dividing line runs between mature and new technologies, not between renewable and nonrenewable energy. Grouping hydroelectric with the legacy technologies enlarges the gap between new renewables and legacy plants to 15.1% (−0.164; Appendix Table A1). H2 is supported for solar, wind, and nuclear. For hydroelectric generation the data show no significant difference but cannot rule out a gap of about six percent.

![Fig. 1. Wage gaps by generation technology relative to fossil-fuel generation, same detailed occupation and survey round. (a) Pooled 2021–2025 estimates (model M4). (b) Estimates by survey round (model M7; biomass and geothermal omitted for sparsity). Points are percent differences; bars are 95% confidence intervals clustered by occupation. Adjacent rounds share survey panels and are not independent.](../figures/fig2-technology.png){width=95%}

Fig. 1b traces the technology gaps across rounds. Two patterns stand out, though adjacent rounds share most of their survey panels. First, the nuclear premium over fossil-fuel generation narrowed steadily, from 15.9% in May 2021 to 5.0% in May 2025, as nuclear real pay fell (Table 1). Second, solar and wind did not converge on fossil-fuel pay. The solar gap was −12.4% in 2021 and −16.5% in 2025, and wind moved from parity in 2021 (+0.7%) to −9.0% in 2025.

### 4.4 Occupations: penalties concentrated in blue-collar trades

The renewable penalty differed across occupational classes (joint Wald test of equal gaps, *p* = 0.004; Fig. 2a). It was 16.4% for blue-collar trades (95% CI −20.5% to −12.0%), 12.6% for office and administrative support, and 5.5% for professional and managerial occupations (−9.5% to −1.4%). The pre-specified contrast between blue-collar and professional/managerial gaps was −0.122 log points (wild bootstrap *p* = 0.008), so blue-collar workers face a gap three times as large, which supports H3. Separating managers from other professional and technical occupations gives gaps of 3.5% and 6.6% for these groups.

![Fig. 2. Renewable minus nonrenewable wage gaps within detailed occupation and survey round, by (a) occupational class (model M5) and (b) SOC major group (major groups identified by at least three occupations observed in both sectors; number of such occupations in parentheses). Bars are 95% confidence intervals clustered by occupation; intervals for groups with few occupations are approximate.](../figures/fig3-occupation.png){width=90%}

The major-group detail in Fig. 2b makes the gradient concrete. In architecture and engineering occupations, renewable and nonrenewable plants paid essentially the same (−0.8%), and the management gap was small (−3.5%). Gaps were large in construction and extraction (−28.3%), transportation and material moving (−35.5%), and production (−17.6%), where power-plant operators and related jobs are classified, and moderate in installation, maintenance, and repair (−8.1%). Engineers at renewable plants are paid close to their fossil-fuel counterparts; operators, technicians, and laborers are not.

Distributional checks point the same way: the gap was 19.8% at the 10th percentile of within-cell wages, 14.1% at the median, and 5.9% at the 90th percentile (Appendix Table A1). These are reported within-cell percentiles, not worker-level quantiles, and top-coding compresses the upper tail, but the pattern is consistent with stronger wage floors in nonrenewable plants.

### 4.5 Change over time: persistence, not convergence

Fig. 3 plots the gaps by round. The regression-based within-occupation gap (M6) was −0.121 log points in May 2021 and −0.139 in May 2025. The pre-specified change between these rounds, which share no survey panels, was −0.019 log points (95% CI −0.055 to 0.018; wild bootstrap *p* = 0.330). Its 90% interval (−0.049 to 0.012) lies within the ±0.05 equivalence margin, so by the pre-specified rule the gap was stable: any narrowing larger than about five percent can be ruled out. The secondary contrast between May 2021 and May 2024 gives the same conclusion (+0.008; 90% CI −0.029 to 0.044). Year-specific gaps were not identical across all five rounds (joint Wald *p* = 0.040), mainly because the gap was smaller in May 2022 (−0.105) and larger in May 2025 (−0.139); the May 2022 round shares four of its six panels with May 2021. H4 is supported: rapid growth and new subsidies did not close the within-occupation pay gap.

![Fig. 3. Renewable minus nonrenewable wage gap by survey round: raw gap in employment-weighted mean log wages, within-occupation gap from the Kitagawa decomposition, and within-occupation gap from the regression model with occupation-by-round fixed effects (M6). Bars are 95% bootstrap (decomposition) or cluster-robust (regression) confidence intervals. May 2021 and May 2025 estimates share no survey panels; adjacent rounds do.](../figures/fig1-gap-trend.png){width=90%}

The worker-weighted decomposition suggests that, if anything, the gap widened. The within-occupation term moved from −0.109 in 2021 to −0.163 in 2025, a change of −0.053 log points (bootstrap 95% CI −0.112 to −0.001). Splitting this change shows where it comes from. Pay changes within the 54 occupations observed in both sectors in both rounds contributed only −0.020, and shifting employment among them contributed +0.018. The rest (−0.051) reflects the 23 occupations that entered common support by 2025, net of 5 that left, as the growing solar and wind workforces became large enough for BLS to publish more occupation cells; on average these entering occupations carry larger renewable penalties. The widening thus reflects renewable employment broadening into occupations with large penalties more than deteriorating pay within continuing occupations. Measured against fossil fuel alone (excluding nuclear, whose premium shrank), the regression change was −0.040 (95% CI −0.080 to 0.000), again pointing toward persistence or modest widening rather than convergence.

### 4.6 Robustness

The within-occupation gap is negative and statistically significant in all sixteen alternative specifications (Appendix Table A1), from −0.060 (90th percentile) to −0.220 (10th percentile) log points, including −0.106 in cells present in all five rounds, −0.123 without weights, and −0.118 after dropping the five largest identifying occupations. No specification shows a significant narrowing between 2021 and 2025; the estimated change ranges from −0.049 to +0.015 log points, and every 95% interval includes zero.

