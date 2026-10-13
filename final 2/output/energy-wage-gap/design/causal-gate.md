# Causal-Gate Review (scholar-causal): renewable–nonrenewable wage gaps, OEWS 2021–2025

## 1. Question and claim status

The descriptive question is: *among private-sector U.S. power-generation jobs in the same detailed occupation and OEWS estimate year, how much lower (or higher) is the mean wage in renewable-technology establishments than in fossil/nuclear establishments?*

A causal version would ask: *what would a given worker, in a given occupation, earn if their plant used a renewable rather than a nonrenewable technology?* The data cannot identify that effect. This review documents why and fixes the claim at **descriptive**.

## 2. Variables

- X: technology of the establishment (renewable vs nonrenewable; six-level technology).
- Y: log real mean annual wage of the industry × occupation × year cell.
- Standardizing variables (pre-exposure job attributes): detailed occupation and estimate year (occupation × year FE).
- Hypothesized mechanisms (not measured; must not be controlled): organizational form, including ownership (utility vs independent producer), plant scale, internal labor markets, union or project-labor coverage, and regulated cost recovery.
- Confounders (unobserved in OEWS national industry cells): plant location and regional wage levels (R); establishment size (S), which is partly mechanism and partly confounder; worker selection on unobserved skill, experience, and tenure (Q); within-occupation task mix (T).
- Measurement features: OEWS three-year panel pooling with ECI wage aging (P); cell suppression and publication thresholds (K).

## 3. DAG (text notation)

```
Tech -> OrgForm -> Pay                      (hypothesized institutional path; mediator, do not adjust)
Tech -> Pay                                 (residual technology-specific differences, e.g. task content)
Occ -> Pay ; Occ <- Tech (occupational mix differs by technology)   (composition path; adjusted by Occ FE)
Region -> Tech ; Region -> Pay              (backdoor: wind/solar sited in lower-wage rural regions; UNOBSERVED)
Q (worker skill/tenure) -> Pay ; Tech -> Q  (new plants employ newer, less-tenured workers; partly mediator)
S (establishment size) -> Pay ; Tech -> S   (mediator/confounder ambiguity)
Year -> Tech ; Year -> Pay                  (adjusted by year / occupation-year FE)
K: Pay (small cells) -> Published?          (selection on publication; collider if conditioned)
```

Backdoor paths from Tech to Pay that stay open after occupation × year FE: **Tech ← Region → Pay**, and any common cause of plant siting and local wage levels. Worker tenure (Q) is both a consequence of technology age and a determinant of pay. Adjusting for it, even if it were observed, would remove part of the "new-industry" gap that the theory treats as substantive.

## 4. Why no causal claim is identified

1. **No exogenous variation in technology.** Technology is a plant attribute fixed at construction and correlated with location, owner, vintage, and scale.
2. **Occupation FE standardize composition. They do not remove confounding.** The within-occupation contrast compares workers who share a SOC code, but region, tenure, and establishment size still differ.
3. **Aggregate cells.** OEWS reports cell means; worker-level selection cannot be modeled, and ecological inference to individuals is limited.
4. **No pre/post variation in treatment.** Plants do not switch technology within the window, so there is no DiD design. Change over time in the gap is a descriptive trend, not the effect of a policy. The Inflation Reduction Act (August 2022) coincides with the window, but the design has no untreated comparison for it.
5. **Measurement overlap.** Adjacent OEWS May estimates share panels, so year-to-year changes are smoothed.

Selected strategy: **OLS (WLS) with fixed effects as descriptive standardization.** This is Strategy 1 (OLS/selection on observables) used explicitly *without* the conditional-independence assumption. No sensitivity analysis of the Oster or E-value type is reported, because no causal parameter is claimed. Robustness targets measurement and sample choices instead (see blueprint §7).

## 5. Diagnostic plan (Tier 1)

```json
{
  "strategy": "OLS",
  "claim": "descriptive",
  "required_diagnostics": [
    {"id": "common_support_occupations", "purpose": "share of employment in occupations observed in both sectors each year", "tool": "tabulation", "pass_criterion": "reported; >= 50% of renewable employment on support", "execute_at": "analysis_execution", "blocks_publication_if_failed": false},
    {"id": "balanced_cell_robustness", "purpose": "separate publication changes from pay change", "tool": "feols on balanced cells", "pass_criterion": "sign and approximate magnitude preserved", "execute_at": "analysis_execution", "blocks_publication_if_failed": false},
    {"id": "nonoverlapping_trend_contrast", "purpose": "trend test not driven by shared panels", "tool": "WCR wild cluster bootstrap test of beta_2025 - beta_2021 (primary) and beta_2024 - beta_2021 (secondary)", "pass_criterion": "reported with CI", "execute_at": "analysis_execution", "blocks_publication_if_failed": true}
  ],
  "pre_design_diagnostics": []
}
```

Tier 2 (panelview) is skipped: this is not a treatment-timing design, and the panel structure (cells × year) is documented through Table 1 and the balanced-cell check.

## 6. Language constraints for the manuscript

- Use "renewable establishments pay X% less", "is associated with", "within-occupation gap", and "differential". Do not use "renewable employment causes/reduces wages", "effect of technology", or "impact of the IRA".
- Institutional mechanisms (unions, ownership, internal labor markets) are **interpretations consistent with** the patterns. They are not estimated.
- Trend language: "persisted", "narrowed/widened between the May 2021 and May 2025 estimates" (and May 2024 as a secondary check), or "no detectable change". Do not use "after the IRA" as a causal contrast.
- State explicitly that regional wage levels and worker tenure are unobserved and could account for part of the gap.

## 7. Identification paragraph (Methods-ready)

> Our estimates are descriptive. Occupation-by-year fixed effects restrict comparisons to workers classified in the same detailed occupation in the same OEWS estimate, which removes differences in occupational mix between technologies. They do not make technology as good as randomly assigned. Wind and solar plants are sited in different regions, are newer, and employ workers with shorter tenure than most fossil-fuel and nuclear plants, and OEWS national cells do not record these attributes. The within-occupation gap should therefore be read as a difference in what establishments of each technology pay for a given classified job, a quantity directly relevant to job quality in the transition, not as the causal effect of technology on an individual worker's pay.
