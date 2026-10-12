# Same Job, Lower Pay? Wage Gaps between Renewable and Non-Renewable Electric Power Generation in the United States, 2021–2025

## Abstract

Policy makers often promise that the clean-energy transition will create well-paid jobs, but most evidence compares green jobs with the economy as a whole rather than with the fossil and nuclear jobs they replace. This study asks whether renewable electricity generation pays the same occupations less or more than non-renewable generation in the United States, how the gap differs across energy sources and occupations, and whether it changed between 2021 and 2025. Using national data from five releases of the Occupational Employment and Wage Statistics industry estimates, we analyze 1,876 occupation-by-industry wage cells in seven generation industries. We estimate employment-weighted regressions with occupation-by-year fixed effects and decompose the raw gap. Workers in the same occupation and year earn about 11.5 percent less per hour in renewable than in fossil fuel and nuclear generation. Differences in occupational mix do not explain this gap. Nuclear plants pay a premium, hydroelectric plants pay about the same as fossil fuel plants, and solar, wind, geothermal and biomass generation pay less. The gap is largest for production, installation and maintenance occupations, and it did not narrow while renewable generation employment doubled. The study contributes evidence that, inside power generation, energy-transition wage gaps arise mainly from how renewable establishments set pay, with implications for just-transition and labor-standards policy.

**Keywords:** renewable energy; wage gap; green jobs; electric power generation; just transition; occupational wages

## Introduction

Electricity generation is at the center of the U.S. energy transition. Between 2021 and 2025, solar and wind generation added capacity at record pace, and the Inflation Reduction Act tied clean-energy tax credits to prevailing-wage and apprenticeship standards [@ira2022; @doe2024useer]. Political support for the transition rests partly on a labor-market promise: that the jobs created in renewable energy will be at least as good as the fossil-fuel jobs that decline. Whether that promise holds is ultimately an empirical question about wages, and it matters most for the workers who might move from a coal or gas plant to a solar or wind farm.

The existing evidence answers a related but different question. Occupation-level studies show that clean-energy occupations pay more than the average U.S. job [@muro2019advancing], and job-posting data show that solar and wind openings cluster in occupations that pay about a fifth more than average [@curtis2023green]. Worker-level studies outside the United States also find green premia of roughly 4 to 12 percent [@kuai2025estimating; @imf2024green; @whittard2024working]. However, studies that compare clean jobs directly with legacy energy jobs reach a different conclusion. U.S. linked employer-employee data show no clean-firm premium once education is held constant [@colmer2025nice], and Norwegian register data show that the wage premium in high-carbon firms is roughly twice the green premium [@godoy2025green]. These literatures disagree because they compare different things: green jobs against the average job, or clean firms against legacy firms across all occupations. None compares the same occupation across renewable and non-renewable generation within a single industry, and none tracks such gaps through the period in which renewable generation expanded fastest.

This paper fills that gap with a simple design. We use the five most recent releases (May 2021 to May 2025) of the Bureau of Labor Statistics Occupational Employment and Wage Statistics (OEWS) program, which reports mean and percentile wages for each detailed occupation in each six-digit generation industry: fossil fuel, nuclear, hydroelectric, solar, wind, geothermal and biomass. Because the same occupations, such as power plant operators, electricians, engineers and maintenance technicians, appear across these industries, we can compare wages for the same job in the same year across energy sources. We draw on theories of employer wage premia and rent-sharing, which predict that legacy plants with mature institutions pay more for the same work. A rival account based on scarce green skills predicts that renewable employers pay more.

Methodologically, we estimate employment-weighted regressions of log real hourly wages on renewable-industry status with occupation-by-year fixed effects. We split the raw gap into occupational composition and within-occupation pay differences, and we estimate how the gap varies by energy source, occupation and year. The estimates are descriptive. They tell us how much less or more each industry pays for the same occupation, not what would happen to an individual worker who switched industries.

Four findings stand out. First, renewable generation pays about 11.5 percent less per hour than fossil fuel and nuclear generation for the same occupation and year, and this result holds across weighting schemes, outcomes, samples, industry classifications and clustering choices. Second, the gap is not an artifact of renewable plants employing lower-paid occupations; if anything, their occupational mix favors higher pay. Third, the gap depends on the energy source and the occupation. Hydroelectric plants pay about the same as fossil fuel plants, nuclear plants pay more, and solar, wind, geothermal and biomass pay less, with the largest gaps among production, installation and maintenance workers. Fourth, the gap did not narrow between 2021 and 2025, even though renewable generation employment roughly doubled.

The paper contributes to research on the labor consequences of the energy transition in three ways. It reconciles conflicting green-premium and legacy-premium findings by showing that, inside power generation, the relevant contrast is between establishments rather than occupations. It documents which sources and occupations carry the gap. And it shows that rapid expansion did not erode the gap during the early years of new federal labor standards. The next section reviews the literature and develops hypotheses. We then describe the data and methods, present the results, discuss their meaning and limits, and conclude with policy implications.

## Literature Review and Theory

### Do clean energy jobs pay more? Evidence from broad comparisons

A large body of research asks whether the jobs created by the shift to low-carbon energy pay well. Most studies answer yes, but they answer a broad question. Occupation-level studies find that the occupations most involved in clean energy pay above-average wages. Using federal occupational data, @muro2019advancing report that mean hourly wages in clean energy occupations exceed national averages by 8 to 19 percent. <!--ev: muro2019advancing-efc7a6fa--> @curtis2023green identify solar and wind jobs in the near-universe of U.S. online postings and assign each posting the national median wage of its occupation. Green postings fall in occupations that pay about 21 percent more than average, with a larger premium for jobs requiring little formal education. <!--ev: curtis2023green-05263fb4--> Worker-level studies outside the United States also report positive premia. These include 7.3 percent for Japanese workers performing green tasks [@kuai2025estimating], about 7 percent for men and 12 percent for women across a set of advanced and emerging economies [@imf2024green], and 4 percent for workers in green occupations in England and Wales once individual and employer characteristics are held constant [@whittard2024working]. <!--ev: kuai2025estimating-d746bdca, imf2024green-8fd7a081, whittard2024working-a74205f2--> Earlier work on green skills reaches a related conclusion: green occupations demand more technical and engineering skill than comparable non-green occupations, which is one reason they pay more [@consoli2016green; @vona2018environmental; @vona2019measures; @bowen2018characterising].

These studies have clear strengths, including large samples, worker-level controls in several cases, and careful measurement of green tasks. Two features, however, limit what they can say about the energy transition inside the power sector. First, the comparison group is usually the whole economy or all non-green jobs, not the fossil and nuclear jobs that renewable generation displaces. A premium relative to the average worker says little about whether a technician who moves from a gas-fired plant to a wind farm earns more or less. Second, measurement differs across studies. Some classify occupations, some classify job postings and some classify firms, so estimates are hard to compare [@godoy2025green; @saussay2022whos]. In postings-based designs the wage is often the occupation's economy-wide wage, so a "premium" reflects which occupations green employers hire, not what those employers pay [@curtis2023green].

### Legacy energy premia and the rival evidence

Studies that compare clean jobs directly with fossil-fuel jobs reach different conclusions. Using linked U.S. employer-employee records for 2005 to 2019, @colmer2025nice find that, conditional on education, workers do not earn more in clean firms than in legacy firms, and that raw earnings gaps between clean and legacy establishments are almost entirely explained by educational attainment. <!--ev: colmer2025nice-f3df4852, colmer2025nice-454300da--> With Norwegian register data and worker and firm fixed effects, @godoy2025green estimate a firm wage premium of 6.6 percent in green jobs and just over 14 percent in brown jobs, both measured relative to generic jobs; the brown premium is roughly twice the green one. <!--ev: godoy2025green-5a21d849, godoy2025green-ca7a7edb--> Job-ad evidence from the United States likewise suggests that the wage advantage of low-carbon jobs declined over the 2010s [@saussay2022whos]. <!--ev: saussay2022whos-92d6d5f5--> These results align with research showing that environmental regulation imposes earnings losses on workers in affected polluting industries, which are relatively high-paying [@walker2013transitional; @curtis2018loses; @hafstead2018unemployment; @gray2023environmental]. They also align with evidence that few workers move from fossil to green jobs, with less than one percent of workers leaving a carbon-intensive job entering a green one [@curtis2024workers], and that geography limits such moves [@lim2023location]. <!--ev: curtis2024workers-94ad6f44--> The linked-data studies are strong on worker controls and mobility but rely on firm classifications that pool many activities, and they end before the post-2021 buildout.

The literature therefore leaves a contested finding unresolved. Economy-wide comparisons suggest green energy jobs pay a premium, while direct comparisons with legacy energy suggest parity or a legacy advantage. No study we know of compares wages for the same occupation across renewable and non-renewable generation sources within a single industry, and none tracks such gaps through the period after 2021, when solar and wind generation expanded quickly [@doe2024useer] and the Inflation Reduction Act tied clean-energy tax credits to prevailing-wage and apprenticeship standards [@ira2022]. <!--ev: doe2024useer-54facebf, ira2022-43046650--> Electricity generation is a natural setting for this test. Its six-digit industries separate fossil fuel, nuclear, hydroelectric, solar, wind, geothermal and biomass generation, and many of the same occupations (power plant operators, electricians, line workers, engineers and maintenance technicians) appear in all of them. Earlier sector studies documented shifting employment across generation sources [@haerer2015employment; @wei2010putting] but did not compare pay. <!--ev: haerer2015employment-98bb7196-->

### Theoretical framework: establishment wage-setting across generation sources

We define the renewable wage gap as the difference in average hourly pay between renewable and non-renewable generation industries for workers in the same detailed occupation and year. This concept distinguishes the pay an industry attaches to a given job from the mix of jobs it offers. We interpret such within-occupation gaps through theories of employer and industry wage premia. A long tradition shows that observably similar workers earn different wages in different industries and firms [@krueger1988efficiency; @gibbons1992does] and that a substantial share of wage dispersion reflects firm-specific premia [@abowd1999high; @card2013workplace; @song2019firming]. <!--ev: krueger1988efficiency-1e79b136--> In rent-sharing models, employers with greater product-market rents, capital intensity or monopsony power pay above-market wages, and part of those rents reaches workers [@card2018firms]. <!--ev: card2018firms-6ac538eb--> Labor-market institutions shape how much is shared. Collective bargaining raises and compresses wages and sustains pay norms [@freeman1980unionism; @western2011unions], while internal labor markets with long job ladders reward tenure and firm-specific skill. <!--ev: western2011unions-d23f88c3--> @godoy2025green show that firm characteristics such as size, revenue and innovation absorb most of both the green and the brown premium, which is consistent with rent-sharing rather than with anything intrinsic to green work. <!--ev: godoy2025green-4cccda1a, godoy2025green-1653a46a-->

Generation sources differ on exactly these dimensions. Fossil, nuclear and hydroelectric generation is dominated by long-lived, capital-intensive plants, many owned by regulated utilities or large independent producers with mature, often unionized workforces and formal job ladders. Nuclear plants add strict safety regulation, licensing and security requirements that raise the value of experienced operators. Utility-scale solar and wind are younger segments built largely by developers and independent producers. Their sites run with small permanent crews, and their workforces have historically had lower union coverage, although the U.S. Department of Energy reports that union representation in clean energy rose quickly in 2023 [@doe2024useer]. <!--ev: doe2024useer-8379e885--> Rival theories predict a different sign. A skills-scarcity account predicts that renewable employers must pay more to attract workers with emerging green skills [@consoli2016green; @saussay2022whos]. A compensating-differentials account predicts that workers may accept lower pay for work they see as environmentally valuable [@rosen1986theory], an argument @godoy2025green note as a possible source of a negative green wage gap. <!--ev: rosen1986theory-1ddc8ee6, godoy2025green-4f76ff95-->

The mechanism we propose runs in three links. Generation source shapes the establishment's wage-setting environment (plant age, ownership, rents, regulation and bargaining coverage); that environment shapes the premium the establishment pays over the market wage for an occupation; and the premium appears as a within-occupation wage difference between industries. The mechanism should be strongest where establishment wage policy matters most, and it may weaken as renewable segments mature and as public policy attaches labor standards to clean-energy subsidies [@mayfield2021influence; @pollin2019economics]. <!--ev: mayfield2021influence-f4fcf906--> Because our data are national occupation-by-industry cells, not worker records, we cannot measure these establishment traits directly. We treat them as the theoretical interpretation of the gaps we estimate, not as a demonstrated causal pathway.

### From mechanism to testable expectations

If generation source matters mainly through establishment wage-setting, then occupation alone should not erase the gap between renewable and non-renewable generation. The legacy-rent account predicts that renewable industries pay less for the same occupation, while the skills-scarcity account predicts that they pay more.

> **H1.** Within detailed occupations and years, mean hourly wages in renewable generation industries are lower than in non-renewable (fossil fuel and nuclear) generation industries.

Renewable and non-renewable plants also employ different mixes of workers. Solar employment, for example, includes many sales and construction-adjacent roles [@curtis2023green], and earlier studies attribute much of the clean-legacy earnings gap to workforce composition [@colmer2025nice; @kuai2025estimating]. <!--ev: curtis2023green-ee091fb9, colmer2025nice-454300da, kuai2025estimating-1b56169b--> Because sorting on unmeasured skill also contributes to industry wage gaps [@gibbons1992does], we expect the raw gap to mix composition and pay-setting. <!--ev: gibbons1992does-277786ee-->

> **H2.** Differences in occupational composition account for part, but not all, of the raw renewable/non-renewable gap in mean hourly wages.

The rent-sharing account implies that gaps should follow the institutional character of each source, not a simple renewable/non-renewable divide. Hydroelectric generation is renewable but institutionally resembles legacy generation: its plants are old, largely utility- or federally-operated, and capital-intensive. Nuclear generation carries the highest regulatory and skill demands.

> **H3.** Relative to fossil fuel generation and within occupations, nuclear generation pays more, hydroelectric generation pays about the same, and solar and wind generation pay less.

Establishment wage premia should matter most for occupations whose pay is set inside the plant's bargaining and job-ladder structure. These include power plant operators and installation, maintenance and repair workers. Management, business and professional occupations are hired in national labor markets, which limits how far their pay can depart from market rates [@card2018firms; @western2011unions].

> **H4.** The within-occupation renewable wage penalty is larger in production, installation, maintenance, and repair occupations than in management, business, and professional occupations.

Finally, the period from 2021 to 2025 saw rapid renewable expansion, rising union representation in clean energy [@doe2024useer] and new prevailing-wage and apprenticeship conditions on clean-energy tax credits [@ira2022; @mayfield2021influence]. If renewable segments are maturing toward legacy wage-setting norms, the gap should shrink.

> **H5.** The within-occupation renewable/non-renewable wage gap narrows between 2021 and 2025.

Three alternatives could produce similar patterns. Workers may sort across industries on unmeasured skill or experience [@gibbons1992does], so a within-occupation gap may partly reflect who is hired rather than how much the establishment pays. Plants are located in different regions with different costs of living. And small renewable industries yield noisy estimates from a survey that pools three years of responses [@bls2025oewstech]. The design below addresses the third concern directly and treats the first two as limits on interpretation.

## Data and Methods

### Data and Sample

The data are the national industry-specific estimates of the OEWS program for May 2021, 2022, 2023, 2024 and 2025 [@bls2025oewsdata]. OEWS is an establishment survey of about 1.1 million employers. Each annual release combines six semiannual panels collected over three years and is estimated with a model-based method that has been used since the May 2021 release [@bls2025oewstech]. For every published occupation in every industry, the files report estimated employment, the mean hourly wage, the 10th, 50th and 90th percentile hourly wages, and the relative standard error of the mean wage. The original source files contain between 16,510 and 17,323 records each, covering all industries and occupation levels.

We kept rows for the eight six-digit industries of electric power generation (NAICS 221111–221118) and for detailed occupations defined by the 2018 federal Standard Occupational (SOC) coding system, which yielded 2,096 occupation-by-industry-by-year observations (N = 2,096 cells in the raw extract). We then made two restrictions. First, we dropped the 144 cells of "other electric power generation" (NAICS 221118), which pools tidal and miscellaneous technologies and cannot be classified as renewable or non-renewable; this industry enters only a sensitivity check. This left 1,952 cells in the seven analytic industries. Second, we dropped 76 cells whose mean wage was suppressed (16 cells), top-coded (1 cell) or reported without an employment estimate (59 cells); because cell employment serves as the analytic weight, every retained cell needed a positive employment estimate. These restrictions left a final analytic sample of 1,876 observations (N = 1,876 cells): 1,154 in fossil fuel and nuclear generation and 722 in hydroelectric, solar, wind, geothermal and biomass generation. The cells represent about 136,000 wage and salary workers per year. Because suppression is a publication rule rather than a skip pattern, we report the excluded cells by industry and year and test whether results depend on small or intermittently published cells.

Within-occupation comparisons draw only on occupation-years observed in both groups. Of 780 occupation-years in the analytic sample, 335 contain at least one renewable and one non-renewable cell, and these mixed groups contain 1,285 cells. The fixed-effects models therefore use 1,577 cells after dropping singleton occupation-years. The sample is well suited to the research question. It covers every published generation industry, uses stable occupational and industry codes over all five years, and measures wages for the same occupations across energy sources. Two limits apply. Petroleum-fired generation cannot be separated from the fossil fuel industry, and transmission and distribution industries are not published at the six-digit level, so they fall outside the scope of the analysis.

### Variables and Measures

**Dependent variables.** The main outcome is the log real mean hourly wage of a cell: the natural logarithm of the OEWS mean hourly wage, converted to May 2025 dollars with the Consumer Price Index for All Urban Consumers for May of each year [@bls2025cpi]. It is a continuous measure of straight-time pay that excludes overtime and shift differentials. In distributional and robustness models we also use the log real 10th percentile wage, the log real median hourly wage and the log real 90th percentile wage, constructed the same way. The OEWS top-code for hourly wages rose from $100 to $115 during the period, so we treat any 90th-percentile wage at or above $100 in nominal terms as censored in every year. That rule removes 257 analytic cells (13.7 percent) from the 90th-percentile models.

**Independent variables.** The focal predictor is a binary indicator for a renewable generation industry, coded 1 for hydroelectric (221111), solar (221114), wind (221115), geothermal (221116) and biomass (221117) generation and 0 for fossil fuel (221112) and nuclear (221113) generation. To compare individual energy sources we replace it with the electricity generation technology of the industry, a seven-category variable with fossil fuel as the reference. To study occupational heterogeneity we group detailed occupations into five broad occupation categories by SOC major group: management, business and financial (SOC 11–13); professional and technical (15–29); office, sales and service (31–43); construction, installation, maintenance and repair (45–49); and production and transportation (51–53, which include power plant operators). Survey year (May 2021 to May 2025) enters as a moderator in the trend models.

**Controls and fixed effects.** The models contain no individual covariates because the data are cell averages. Instead, detailed occupation and occupation-by-year fixed effects absorb national differences in pay between occupations and the year-to-year movement of each occupation's wage. Cell employment serves as the analytic weight, and the relative standard error of the mean wage defines inverse-variance weights in a robustness check.

### Analytic Strategy

We estimate linear regressions of the log real mean hourly wage on renewable generation industry status, because a linear model in logs fits a continuous, right-skewed wage outcome and yields coefficients that translate directly into percent gaps. A cell refers to detailed occupation $o$ in generation industry $i$ and year $t$. The main specification is

$$lnWage_t = \beta \, Renewable_i + \alpha_{ot} + \varepsilon_{oit},$$

where $lnWage_t$ is the log real mean hourly wage of occupation $o$ in industry $i$ in year $t$, $Renewable_i$ is the renewable generation industry indicator and $\alpha_{ot}$ are occupation-by-year fixed effects that adjust for each occupation's national pay level in each year. Observations are weighted by cell employment. Because $\alpha_{ot}$ absorbs everything common to an occupation in a given year, $\beta$ compares the same occupation in the same year across industries, and $100(e^{\beta}-1)$ is the approximate percent wage gap. We build up to this specification from a raw comparison with year fixed effects only (Model 1) and a version with separate occupation and year fixed effects (Model 2). Models 4 and 5 repeat the main specification for the 10th and 90th percentile wages.

Three extensions address heterogeneity. Model 6 replaces the renewable indicator with indicators for nuclear, hydroelectric, solar, wind, geothermal and biomass generation, each relative to fossil fuel. Model 7 interacts the renewable indicator with the five broad occupation categories, $\sum_g \beta_g (Renewable_i \times Group_{g})$. Model 8 interacts it with survey year, $\sum_t \beta_t (Renewable_i \times Period_t)$, and Model 9 replaces the year interactions with a linear term, $\beta_0 Renewable_i + \beta_1 Renewable_i \times (t-2021)$. Joint Wald tests evaluate whether the interacted gaps are equal across groups and years.

To assess how much of the raw gap reflects occupational composition, we decompose the difference in employment-weighted mean log wages between renewable and non-renewable industries in each year, following the decomposition logic of @kitagawa1955components, @oaxaca1973male, @blinder1973wage and @fortin2011decomposition. Among occupations present in both groups, the gap splits into a composition term, $\sum_o (s^R_o - s^N_o)\bar w_o$, and a within-occupation term, $\sum_o \bar s_o (w^R_o - w^N_o)$, where $s$ denotes employment shares and bars denote averages of the two groups. A third term captures occupations observed in only one group. The three terms sum exactly to the raw gap, and we obtain standard errors from 500 bootstrap draws that resample occupations.

All regressions are estimated by employment-weighted least squares, and standard errors are clustered by detailed occupation (122 occupations in the main specification), because the same occupation appears across industries and years. Clustering by industry is not feasible with seven industries. We therefore also report standard errors clustered by industry-year and two-way clustered by occupation and industry-year. Robustness models re-estimate the main specification without weights; with inverse-variance weights; with the median wage; on a balanced set of 42 occupations observed in both groups in all five years; without nuclear; without hydroelectric; with other generation coded as renewable; on cells with at least 50 workers; and leaving out one renewable source at a time. The denominator differs across models: the raw comparison uses all 1,876 analytic cells, the fixed-effects models use the 1,577 cells in non-singleton occupation-years, and the 90th-percentile model excludes censored cells, so each table reports its own N. All estimates are descriptive comparisons of average pay for the same occupation, not causal effects of moving a worker into renewable generation.

## Results

**Wage levels and occupational mix by energy source.**

Table 1 summarizes the analytic sample. Averaged over the five years and weighted by employment, fossil fuel generation paid $54.03 per hour and nuclear generation $60.84 (2025 dollars). Hydroelectric generation paid $53.17, solar $50.16, wind $48.28, geothermal $42.78 and biomass $42.98. Non-renewable industries accounted for about 80 percent of generation employment in the sample. The renewable share rose quickly: employment in the renewable cells grew from 17,990 in 2021 to 36,370 in 2025, almost entirely because solar grew from 4,350 to 16,170 workers and wind from 5,860 to 11,420. The two groups also employ different occupations. Management, business and financial occupations make up 26.5 percent of renewable employment but only 16.7 percent of non-renewable employment, whereas production and transportation occupations, which include power plant operators, are less common in renewable generation (16.5 versus 23.9 percent).

<!-- LOCKED_ARTIFACT: tables/table1-descriptives.html ; LOCKED_PATH: results-locked/lock-20261010T134805Z/tables/table1-descriptives.html -->
<!-- DISPLAY_TABLE: tables/table1-descriptives.html -->

**Table 1.** Descriptive statistics by electricity generation technology, analytic sample, May 2021–May 2025 (pooled).

| Variable | Fossil fuel | Nuclear | Hydro | Solar | Wind | Geothermal | Biomass | Non-renewable | Renewable |
|---|---|---|---|---|---|---|---|---|---|
| Real mean hourly wage (2025 $) | 54.03 | 60.84 | 53.17 | 50.16 | 48.28 | 42.78 | 42.98 | 56.32 | 49.70 |
| Log real mean hourly wage | 3.96 | 4.07 | 3.95 | 3.82 | 3.80 | 3.73 | 3.71 | 4.00 | 3.84 |
| Log real 10th percentile wage | 3.61 | 3.75 | 3.49 | 3.30 | 3.46 | 3.46 | 3.34 | 3.66 | 3.40 |
| Log real median hourly wage | 3.97 | 4.06 | 3.94 | 3.72 | 3.75 | 3.72 | 3.67 | 4.00 | 3.78 |
| Log real 90th percentile wage (uncensored cells) | 4.19 | 4.25 | 4.25 | 4.01 | 3.97 | 3.94 | 3.95 | 4.21 | 4.05 |
| Share of cells with censored 90th percentile | 0.09 | 0.15 | 0.09 | 0.25 | 0.21 | 0.08 | 0.08 | 0.12 | 0.17 |
| Share of generation employment | 0.53 | 0.27 | 0.05 | 0.08 | 0.06 | 0.01 | 0.01 | 0.80 | 0.20 |
| Management, business and financial (share) | 0.16 | 0.18 | 0.15 | 0.36 | 0.28 | 0.08 | 0.17 | 0.17 | 0.27 |
| Professional and technical (share) | 0.16 | 0.33 | 0.12 | 0.10 | 0.08 | 0.00 | 0.01 | 0.22 | 0.09 |
| Office, sales and service (share) | 0.09 | 0.16 | 0.06 | 0.14 | 0.05 | 0.00 | 0.01 | 0.12 | 0.08 |
| Construction, installation, maintenance and repair (share) | 0.32 | 0.14 | 0.33 | 0.36 | 0.54 | 0.20 | 0.19 | 0.26 | 0.39 |
| Production and transportation (share) | 0.26 | 0.19 | 0.34 | 0.04 | 0.06 | 0.73 | 0.62 | 0.24 | 0.17 |
| Detailed occupations | 166 | 123 | 62 | 74 | 61 | 10 | 21 | 185 | 105 |
| Cells | 674 | 480 | 208 | 226 | 201 | 26 | 61 | 1154 | 722 |
| Mean annual employment | 72166 | 36536 | 6402 | 10532 | 8184 | 626 | 1664 | 108702 | 27408 |
| Relative standard error of mean wage (%) | 1.58 | 0.78 | 3.58 | 6.08 | 3.04 | 2.96 | 4.00 | 1.31 | 4.39 |

*Note:* Statistics are weighted by cell employment over occupation-by-industry-by-year cells. Wages are in May 2025 dollars (CPI-U). Occupation-category rows report shares of employment. Source: BLS OEWS national industry-specific estimates, May 2021–May 2025.

Figure 1 plots these wage levels by year. Nuclear generation pays the most in every year and solar, wind, geothermal and biomass pay the least. Real mean wages in solar generation declined steadily as the industry expanded, from about $54 in 2021 to about $48 in 2025, while hydroelectric wages rose to the fossil fuel level.

<!-- LOCKED_ARTIFACT: figures/fig1-wage-by-source-year.pdf ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig1-wage-by-source-year.pdf -->
<!-- LOCKED_ARTIFACT: figures/fig1-wage-by-source-year.png ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig1-wage-by-source-year.png -->
<!-- DISPLAY_FIGURE: figures/fig1-wage-by-source-year.pdf -->
<!-- DISPLAY_FIGURE: figures/fig1-wage-by-source-year.png -->

![Figure 1. Employment-weighted mean real hourly wage by electricity generation technology and year (May 2025 dollars).](results-locked/lock-20261010T134805Z/figures/fig1-wage-by-source-year.png)

**The renewable wage gap within occupations.**

Table 2 presents the main estimates. Across all cells in the raw comparison, renewable industries pay lower hourly wages, with an estimate of -0.165 (standard error of 0.071, p = 0.021, n = 1,876), or about 15 percent less. Holding each occupation's national pay level constant, the separate occupation and year controls leave a lower renewable wage, with an estimate of -0.124 (standard error of 0.021, p < .001, n = 1,855). The headline comparison of the same occupation in the same year shows a lower renewable wage with an estimate of -0.122 (standard error of 0.021, p < .001, n = 1,577), which corresponds to 11.5 percent less pay for the same job. Occupation explains most of the variance in cell wages (R-squared of 0.915), but adding occupation controls shrinks the renewable gap only modestly, from about 15 to about 12 percent. This pattern supports H1.

<!-- LOCKED_ARTIFACT: tables/table2-main-regression.html ; LOCKED_PATH: results-locked/lock-20261010T134805Z/tables/table2-main-regression.html -->
<!-- DISPLAY_TABLE: tables/table2-main-regression.html -->

**Table 2.** Renewable versus non-renewable hourly wage gaps in electric power generation, May 2021–May 2025.

| Term | Model 1 | Model 2 | Model 3 | Model 4 (P10) | Model 5 (P90) |
|---|---|---|---|---|---|
| Renewable generation industry, estimate (SE) | -0.165 (0.071) | -0.124 (0.021) | -0.122 (0.021) | -0.220 (0.038) | -0.068 (0.014) |
| p-value | 0.021 | p < .001 | p < .001 | p < .001 | p < .001 |
| Cells (N) | 1,876 | 1,855 | 1,577 | 1,577 | 1,307 |
| R-squared | 0.057 | 0.907 | 0.915 | 0.843 | 0.882 |
| Within R-squared | 0.054 | 0.182 | 0.205 | 0.281 | 0.068 |
| Year fixed effects | Yes | Yes | No | No | No |
| Occupation fixed effects | No | Yes | No | No | No |
| Occupation-by-year fixed effects | No | No | Yes | Yes | Yes |

*Note:* Outcome is the log real mean hourly wage (May 2025 dollars) in Models 1–3 and the log real 10th (Model 4) and 90th (Model 5) percentile hourly wage. Unit is the detailed occupation by six-digit generation industry by year cell, weighted by cell employment. Standard errors clustered by detailed occupation are in parentheses. Renewable industries are hydroelectric, solar, wind, geothermal and biomass generation; the reference group is fossil fuel and nuclear generation. Model 5 excludes cells with 90th-percentile wages at or above $100 in nominal terms. Models 3–5 drop singleton occupation-years.

The gap is wider at the bottom of the wage distribution than at the top. For the lower tail of each occupation's pay, the 10th percentile wage is lower in renewable industries, with an estimate of -0.220 (standard error of 0.038, p < .001, n = 1,577), about 20 percent less. For the upper tail of each occupation's pay among uncensored cells, the 90th percentile wage is lower by a smaller margin, with an estimate of -0.068 (standard error of 0.014, p < .001, n = 1,307), about 7 percent less. Because the 90th-percentile model excludes the highest-paid cells, which are concentrated in fossil fuel and nuclear generation, it likely understates the gap at the top. The pattern means that the lowest-paid workers in each renewable occupation are furthest behind their non-renewable counterparts.

Table 4 shows why occupational composition does not account for the gap. Averaged over the five years, the decomposition attributes the gap mainly to the within-occupation term: in the decomposition of the gap among shared occupations, the within-occupation pay difference is lower in renewable industries, with an estimate of -0.141 (standard error of 0.028, p < .001, n = 1,876). The composition term is small and positive (0.018 log points), meaning that the renewable occupational mix, if paid non-renewable wages, would slightly raise renewable pay. Occupations observed in only one group add -0.041 log points. The within-occupation term dominates in every year, ranging from -0.109 in 2021 to -0.163 in 2025, while the composition term never exceeds 0.027 in absolute value. H2 is therefore not supported: the raw gap reflects how renewable industries pay given occupations, not which occupations they employ.

<!-- LOCKED_ARTIFACT: tables/table4-decomposition.csv ; LOCKED_PATH: results-locked/lock-20261010T134805Z/tables/table4-decomposition.csv -->
<!-- DISPLAY_TABLE: tables/table4-decomposition.csv -->

**Table 4.** Decomposition of the renewable/non-renewable gap in mean log real hourly wages, 2021–2025 average.

| Component | Decomposition |
|---|---|
| Within-occupation pay difference, estimate (SE) | -0.141 (0.028) |
| p-value of within-occupation term | p < .001 |
| Raw gap (SE) | -0.164 (0.076) |
| Occupational composition (SE) | 0.018 (0.035) |
| Occupations observed in one group only (SE) | -0.041 (0.051) |
| Analytic cells (N) | 1,876 |

*Note:* Annual Kitagawa decompositions averaged over May 2021–May 2025. Composition and within-occupation terms are computed over occupations observed in both groups, using average shares and wages of the two groups as weights. The three components sum to the raw gap. Bootstrap standard errors (500 draws resampling occupations) are in parentheses.

**Gaps by energy source, occupation and year.**

Table 3 and Figure 2 show that the renewable gap is not uniform across energy sources. Compared with fossil fuel generation in the same occupation and year, the solar comparison is lower, with an estimate of -0.129 (standard error of 0.030, p < .001, n = 1,577), or about 12 percent. Wind generation pays about 7 percent less, geothermal about 20 percent less and biomass about 26 percent less than fossil fuel generation. Two results stand out against a simple renewable/non-renewable divide. Nuclear generation pays about 12 percent more than fossil fuel generation for the same occupation, and hydroelectric generation pays about the same (a difference of -2.0 percent with a confidence interval spanning zero). This ordering matches H3 and is consistent with the establishment wage-setting mechanism: the old, utility-run hydroelectric fleet pays like fossil fuel plants, while the newer solar and wind segments do not. Geothermal estimates rest on only 26 cells that share an occupation-year with fossil fuel generation, which limits their precision even though their confidence interval excludes zero.

<!-- LOCKED_ARTIFACT: tables/table3-heterogeneity-regression.html ; LOCKED_PATH: results-locked/lock-20261010T134805Z/tables/table3-heterogeneity-regression.html -->
<!-- DISPLAY_TABLE: tables/table3-heterogeneity-regression.html -->

**Table 3.** Wage gaps by generation technology, broad occupation category and year (occupation-by-year fixed effects).

| Term | Model 6: technologies | Model 7: occupation categories | Model 8: years | Model 9: trend |
|---|---|---|---|---|
| Focal contrast | Solar (ref. fossil fuel) | Renewable × production and transportation | Renewable × 2025 | Renewable × years since 2021 |
| Focal contrast, estimate (SE) | -0.129 (0.030) | -0.202 (0.008) | -0.139 (0.023) | -0.005 (0.005) |
| Focal contrast, p-value | p < .001 | p < .001 | p < .001 | 0.277 |
| Nuclear (ref. fossil fuel) | 0.110 (0.013) | | | |
| Hydroelectric (ref. fossil fuel) | -0.020 (0.026) | | | |
| Wind (ref. fossil fuel) | -0.076 (0.024) | | | |
| Geothermal (ref. fossil fuel) | -0.228 (0.021) | | | |
| Biomass (ref. fossil fuel) | -0.299 (0.042) | | | |
| Renewable × management, business and financial | | -0.072 (0.026) | | |
| Renewable × professional and technical | | -0.017 (0.016) | | |
| Renewable × office, sales and service | | -0.139 (0.032) | | |
| Renewable × construction, installation, maintenance and repair | | -0.155 (0.046) | | |
| Renewable × 2021 | | | -0.121 (0.026) | |
| Renewable × 2022 | | | -0.105 (0.015) | |
| Renewable × 2023 | | | -0.128 (0.025) | |
| Renewable × 2024 | | | -0.113 (0.028) | |
| Renewable generation industry (2021 level) | | | | -0.111 (0.021) |
| Joint test of equal gaps | | F = 29.02, p < .001 | F = 2.57, p = 0.041 | |
| Cells (N) | 1,577 | 1,577 | 1,577 | 1,577 |
| Within R-squared | 0.469 | 0.259 | 0.207 | 0.205 |

*Note:* Outcome is the log real mean hourly wage (May 2025 dollars). All models include occupation-by-year fixed effects and cell-employment weights; standard errors clustered by detailed occupation are in parentheses. The first three rows report the focal contrast of each model; the remaining rows report the other coefficients of the same models.

<!-- LOCKED_ARTIFACT: figures/fig2-source-gaps.pdf ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig2-source-gaps.pdf -->
<!-- LOCKED_ARTIFACT: figures/fig2-source-gaps.png ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig2-source-gaps.png -->
<!-- DISPLAY_FIGURE: figures/fig2-source-gaps.pdf -->
<!-- DISPLAY_FIGURE: figures/fig2-source-gaps.png -->

![Figure 2. Percent difference in mean hourly wage relative to fossil fuel generation for workers in the same occupation and year, with 95% confidence intervals.](results-locked/lock-20261010T134805Z/figures/fig2-source-gaps.png)

Figure 4 displays the gap by broad occupation category. For production and transportation occupations, a group that includes power plant operators, the renewable wage is lower, with an estimate of -0.202 (standard error of 0.008, p < .001, n = 1,577), about 18 percent less. The gap is about 14 percent in construction, installation, maintenance and repair occupations and 13 percent in office, sales and service occupations, but only 7 percent for management, business and financial occupations and a statistically insignificant 2 percent for professional and technical occupations. A joint test rejects equal gaps across the five categories (F = 29.02, p < .001). The gap is thus largest for the plant-based occupations whose pay is set inside the establishment, as H4 predicts. Engineers and other professionals, who are hired in national labor markets, are paid almost the same in both groups.

<!-- LOCKED_ARTIFACT: figures/fig4-gap-by-occupation-group.pdf ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig4-gap-by-occupation-group.pdf -->
<!-- LOCKED_ARTIFACT: figures/fig4-gap-by-occupation-group.png ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig4-gap-by-occupation-group.png -->
<!-- DISPLAY_FIGURE: figures/fig4-gap-by-occupation-group.pdf -->
<!-- DISPLAY_FIGURE: figures/fig4-gap-by-occupation-group.png -->

![Figure 4. Renewable versus non-renewable wage gap within occupation and year, by broad occupation category, with 95% confidence intervals.](results-locked/lock-20261010T134805Z/figures/fig4-gap-by-occupation-group.png)

Figure 3 shows how the gap evolved. In the final survey year the within-occupation renewable wage stays lower, with an estimate of -0.139 (standard error of 0.023, p < .001, n = 1,577), about 13 percent, compared with 11.4 percent in 2021. Year-specific gaps range between 10 and 13 percent, and a joint test finds modest year-to-year variation (F = 2.57, p = 0.041) but no movement toward zero. Summarizing the five years with a linear trend, the annual change in the gap is slightly negative, with an estimate of -0.005 (standard error of 0.005, p = 0.277, n = 1,577), which is indistinguishable from no change. The raw gap, shown for comparison in Figure 3, was also stable at 14 to 17 percent. H5 is therefore not supported. The gap did not narrow during a period in which renewable generation employment doubled and new federal labor standards took effect, although OEWS releases pool three years of survey responses and so smooth year-to-year change.

<!-- LOCKED_ARTIFACT: figures/fig3-gap-by-year.pdf ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig3-gap-by-year.pdf -->
<!-- LOCKED_ARTIFACT: figures/fig3-gap-by-year.png ; LOCKED_PATH: results-locked/lock-20261010T134805Z/figures/fig3-gap-by-year.png -->
<!-- DISPLAY_FIGURE: figures/fig3-gap-by-year.pdf -->
<!-- DISPLAY_FIGURE: figures/fig3-gap-by-year.png -->

![Figure 3. Renewable versus non-renewable wage gap by survey year: within occupation and year (Model 8) and raw (all occupations), with 95% confidence intervals.](results-locked/lock-20261010T134805Z/figures/fig3-gap-by-year.png)

**Robustness.**

Table 5 shows that the main result does not depend on analytic choices. Without employment weights, the within-occupation renewable wage remains lower, with an estimate of -0.123 (standard error of 0.016, p < .001, n = 1,577). Weighting cells by the inverse of their sampling variance leaves a lower renewable wage with an estimate of -0.126 (standard error of 0.026, p < .001, n = 1,577). Using the median instead of the mean, the renewable median wage is lower with an estimate of -0.153 (standard error of 0.024, p < .001, n = 1,570). Restricting to the balanced set of 42 occupations present in both groups every year, the gap stays lower with an estimate of -0.119 (standard error of 0.024, p < .001, n = 915). Dropping nuclear plants so that renewables are compared with fossil fuel alone yields a lower renewable wage with an estimate of -0.101 (standard error of 0.024, p < .001, n = 1,030), about 10 percent, so the gap is not simply a nuclear premium. Excluding hydroelectric plants widens the gap, with a lower estimate of -0.168 (standard error of 0.028, p < .001, n = 1,362). Adding other generation to the renewable group gives a lower wage with an estimate of -0.115 (standard error of 0.024, p < .001, n = 1,707). Keeping only cells with at least 50 workers returns a lower renewable wage with an estimate of -0.122 (standard error of 0.022, p < .001, n = 1,292).

<!-- LOCKED_ARTIFACT: tables/tableA1-robustness-regression.html ; LOCKED_PATH: results-locked/lock-20261010T134805Z/tables/tableA1-robustness-regression.html -->
<!-- DISPLAY_TABLE: tables/tableA1-robustness-regression.html -->

**Table 5.** Robustness of the within-occupation renewable wage gap.

| Specification | Model A1 | Model A2 | Model A3 | Model A4 | Model A5 | Model A6 | Model A7 | Model A8 |
|---|---|---|---|---|---|---|---|---|
| Variant | Unweighted | Inverse-variance weights | Median wage outcome | Balanced occupations | Nuclear excluded | Hydro excluded | Other generation added | Cells with 50+ workers |
| Renewable generation industry, estimate (SE) | -0.123 (0.016) | -0.126 (0.026) | -0.153 (0.024) | -0.119 (0.024) | -0.101 (0.024) | -0.168 (0.028) | -0.115 (0.024) | -0.122 (0.022) |
| p-value | p < .001 | p < .001 | p < .001 | p < .001 | p < .001 | p < .001 | p < .001 | p < .001 |
| Cells (N) | 1,577 | 1,577 | 1,570 | 915 | 1,030 | 1,362 | 1,707 | 1,292 |
| Within R-squared | 0.154 | 0.149 | 0.248 | 0.223 | 0.203 | 0.287 | 0.181 | 0.210 |

*Note:* All models include occupation-by-year fixed effects; standard errors clustered by detailed occupation are in parentheses. The outcome is the log real mean hourly wage except in Model A3 (log real median hourly wage).

The remaining checks point the same way. Leaving out one renewable source at a time produces gaps between -0.102 log points (without biomass) and -0.168 (without hydroelectric), all statistically significant. Repeating the year-by-year comparison on the balanced occupation set gives a 2025 gap of -0.131, close to the full-sample value, so the absence of narrowing does not reflect changes in which occupations are published. Standard errors for the headline comparison increase from 0.021 to 0.024 when clustered by industry-year and to 0.028 under two-way clustering by occupation and industry-year, but the gap remains clearly different from zero (two-way p < .001). Across all of these checks, the headline gap lies between about 10 and 16 percent, and no specification changes its sign.

## Discussion

The results answer the study's questions clearly. Within U.S. electric power generation, renewable industries paid workers in the same occupation about 11.5 percent less per hour than fossil fuel and nuclear industries between 2021 and 2025. This gap persisted after controlling for occupation, and differences in occupational mix did not explain it. It differed sharply by energy source and occupation: hydroelectric pay matched fossil fuel pay, nuclear paid a premium, and solar, wind, geothermal and biomass paid less. It was concentrated among production, installation and maintenance workers rather than engineers and managers. And it did not narrow over a period of rapid renewable growth.

These patterns help adjudicate between the theoretical accounts. A green skills-scarcity account predicts that renewable employers pay more for the same occupation, which is the opposite of what we observe; within generation, renewable employers do not appear to compete for scarce workers through higher pay. The rent-sharing and institutional account fits several features of the evidence. Hydroelectric plants, which are renewable but old, capital-intensive and largely utility- or government-operated, show no gap, while nuclear plants, with the strictest regulation and highest operator skill requirements, pay the most. The gap is also largest in occupations whose pay is set inside the plant's job ladder and smallest for professionals hired in national markets. A compensating-differentials account, in which workers accept lower pay for environmentally valued work, is consistent with the negative sign. However, it does not explain why hydro workers show no discount or why the discount is concentrated among operators and technicians rather than spread evenly. We therefore read the evidence as most consistent with establishment wage-setting, while recognizing that our data do not measure rents, union coverage or worker preferences directly.

The findings also make a contribution to the literature by reconciling the conflicting studies reviewed above. Economy-wide studies that find a green premium compare green occupations with the average job [@curtis2023green; @muro2019advancing]. Our results suggest that the same occupations command lower pay in renewable generation than in legacy generation, which agrees with linked-data evidence that legacy and brown employers pay as much or more [@colmer2025nice; @godoy2025green]. Both findings can be true at once: renewable generation creates jobs in occupations that pay well relative to the economy, yet pays those occupations less than fossil and nuclear plants do. Our decomposition adds that the legacy advantage in power generation is not mainly a matter of workforce composition, unlike the education-driven gap that @colmer2025nice report across broader clean and legacy sectors. The persistence of the gap through 2025 is also consistent with job-posting evidence that the low-carbon wage advantage was eroding before the period we study [@saussay2022whos].

<!-- REQUIRED_DISCLOSURES (trace): descriptive design: sorting and regional composition not controlled | OEWS three-year pooled panels smooth trends | OEWS wages exclude overtime and shift differentials | P90 censoring | small geothermal and biomass samples | reviews carried out inline because independent subagents were unavailable (workflow disclosure, trace only) -->
Several limitations bound these conclusions. The estimates describe differences in average pay for the same occupation across industries. They are not causal effects of working in renewable generation, because workers may sort across industries on unmeasured skill and experience, and national cells cannot account for the regional location of plants or local costs of living. OEWS wages exclude overtime and shift differentials, which are common among fossil and nuclear plant operators, so gaps in total compensation may be larger. Each OEWS release pools six semiannual panels over three years, so year-specific estimates overlap and changes after the Inflation Reduction Act may not yet be visible; our trend result means only that no narrowing was detectable over this smoothed window. Suppressed cells, top-coding of high wages and small geothermal and biomass samples limit precision for some comparisons. Finally, petroleum-fired plants cannot be separated from other fossil fuel generation, and transmission and distribution occupations are outside the scope of the analysis. State-level OEWS files, establishment-level union data and matched employer-employee records that follow workers across energy sources would allow sharper tests of the mechanism.

## Conclusion

This study began with a question at the center of the transition debate: do renewable generation jobs pay as well as the fossil and nuclear jobs they replace? The findings show that the U.S. clean-energy transition, as it unfolded in electricity generation between 2021 and 2025, involved a persistent wage penalty for the same jobs. Renewable generation paid about 11.5 percent less than fossil fuel and nuclear generation for the same occupation, the gap arose from pay-setting rather than occupational mix, and it fell most heavily on plant operators and maintenance workers. Hydroelectric generation, which pays like fossil fuel generation, shows that a renewable source does not necessarily mean lower pay. Wages appear to follow the institutional character of employers more than the technology they use, which supports an establishment wage-setting framework over accounts that attribute green pay premia to scarce green skills. The main contribution is to move the comparison from green versus average jobs to the same job across energy sources, which changes the implication for workers leaving fossil plants.

The policy implications follow from where the gap is located. Programs that help displaced fossil-fuel workers move into renewable generation should expect that many will face lower hourly pay for similar work, especially in operations and maintenance roles, and wage-insurance or bridge payments may be needed to make such moves attractive [@pollin2019economics]. Labor standards attached to clean-energy subsidies currently focus on construction labor. Extending prevailing-wage, apprenticeship and collective-bargaining support to the permanent operating workforce of solar and wind plants would target the occupations where the gap is largest [@mayfield2021influence]. Finally, monitoring should compare like with like: claims that clean-energy jobs pay well should be checked against the fossil and nuclear jobs they replace, occupation by occupation, rather than against the average job. Future research should test whether the gap narrows once construction completed under the new standards enters the OEWS panels, and whether worker-level data confirm that establishment wage policy, rather than sorting, explains it.
