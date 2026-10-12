# Causal Audit of a Descriptive Fixed-Effects Design (scholar-causal)

*Project: energy-wage-gaps · Phase 3 · 2026-10-10 · mode: fixed_effects_descriptive_audit*

## 1. Question being estimated (and the question not being estimated)

**Estimated (descriptive):** For workers in the same detailed occupation and survey year, how does the employment-weighted mean hourly wage differ between renewable and non-renewable U.S. electric power generation industries?

**Not estimated (causal):** We do not estimate how much a given worker's wage would change if that worker moved from a fossil or nuclear plant to a solar or wind farm. That quantity is E[Y¹ − Y⁰ | occupation] for movers. It would require worker-level panel data with mobility (as in AKM designs).

## 2. Variable inventory

- **X (exposure):** renewable generation industry (industry-level attribute of the cell).
- **Y (outcome):** log real mean hourly wage of the occupation-industry-year cell.
- **Adjusted:** detailed occupation × year (absorbs occupation-specific national wage levels and their year-to-year changes, including inflation shocks common to an occupation).
- **Unobserved confounders/composition (U):** worker skill and experience within occupation (U1); plant region and local cost of living (U2); firm size and ownership (U3); union coverage (U4).
- **Mechanism variables (not to be controlled even if observed):** establishment rents, bargaining coverage, internal job ladders. These lie on the theorized path from generation source to wages, so conditioning on them would remove the quantity of interest.
- **Collider risk:** OEWS publication/suppression depends on cell size and reliability, which are related to both industry size and wage dispersion. Analyzing only published cells is a selection on a possible collider. We assess this by reporting the share of suppressed cells by industry and by checking robustness to a balanced occupation set.

## 3. DAG (text notation)

```
Occupation x Year -> X (industry occupational mix)      [blocked by occ x year FE]
Occupation x Year -> Y                                    [blocked by occ x year FE]
X -> Rents/Bargaining/JobLadders (M) -> Y                 [mechanism; left open]
U1 (worker skill) -> X ; U1 -> Y                          [open: sorting]
U2 (region) -> X ; U2 -> Y                                [open: geography]
U3 (firm size/ownership) -> M -> Y ; X -> U3              [partly mechanism, partly confounding]
X -> Published (cell suppression) <- Y                    [collider; conditioning by data availability]
```

Backdoor paths left open: X ← U1 → Y and X ← U2 → Y. Because no worker or regional data are available in national cells, these cannot be closed. The design is therefore **not identified for a causal effect**, which is why the claim strength is descriptive.

## 4. What occupation × year fixed effects do and do not remove

**They remove** all differences in average pay between occupations, and changes in those differences over time, that are common to every generation industry. This includes national occupational wage growth and inflation. The remaining comparison is between industries within an occupation-year cell.

**They do not remove** (a) sorting of more or less skilled workers within an occupation across industries; (b) regional cost-of-living and labor-market differences tied to where plants are located; (c) differences in job content under one occupation title; or (d) sampling error and survey pooling in OEWS. Fixed effects also cannot separate the establishment wage premium (the theorized mechanism) from these confounders.

## 5. Strategy selection

Of the strategies in the decision tree, only **panel FE (Strategy 5) used descriptively** fits the data structure, and it lacks within-worker variation. DiD around the Inflation Reduction Act is not credible: OEWS pools six panels over three years (so post-2023 releases mix pre- and post-policy responses), there is no clean untreated comparison group, and the policy applies mainly to construction labor. We do not run IV or RD because no instrument or threshold exists. We therefore treat the IRA period descriptively: we report year-specific gaps and a linear trend, without an event-study interpretation.

## 6. Diagnostics and sensitivity plan

See `design/diagnostic_plan.json`. The plan includes:
- (i) the share of cells suppressed or top-coded, by industry and year (collider/selection check);
- (ii) a balanced occupation set;
- (iii) unweighted and inverse-variance weights;
- (iv) median and percentile outcomes;
- (v) alternative classifications;
- (vi) a joint Wald test for interaction blocks;
- (vii) leave-one-source-out.

E-values and Oster deltas are not reported, because the estimand is descriptive and the observed-controls benchmark (occupation × year) is a set of fixed effects rather than covariates.

## 7. Identification paragraph for the manuscript (language template)

> "Our estimates are descriptive. Occupation-by-year fixed effects compare wages for the same occupation in the same year across generation industries, removing differences in occupational mix and national occupational wage trends. They do not account for differences in worker skill within occupations, regional cost of living, or job content under a common occupation title, so the gaps should be read as differences in average pay that workers in a given occupation receive in each industry, not as the pay change a worker would experience on switching industries."

Banned in the manuscript: "effect of renewable employment on wages," "renewables cause/lead to lower pay," "the IRA raised/narrowed." Allowed: "is associated with," "pays X percent less for the same occupation," "the gap was smaller/larger in year t."

## 8. Limitations and scope

Inference is limited to national wage cells in NAICS 2211 generation industries, 2021–2025. Results speak to the industry where workers are employed, not to green tasks. Petroleum-fired generation is not separable from fossil fuel generation, and grid occupations are outside scope.
