# Analysis Premortem (Phase 7)

**Decision: GO.** Routed engine: scholar-analyze (premortem mode). Iteration 1.

Disclosure: the four premortem roles (identification, measurement and missingness, model robustness, interpretation and claims) were reviewed in separate inline passes by the orchestrating agent, because subagent dispatch was unavailable.

## Risk summary
We identified twelve risks: six major, four moderate, and two minor. Every major risk has a pre-committed mitigation or decision rule (DR-01 to DR-06) and is marked mitigated. Two lower-severity risks are accepted limitations: wages exclude overtime, and the decomposition bootstrap has a long runtime.

## Traffic lights

- identification: YELLOW (Descriptive design; region is an open alternative (PM-01); nuclear handled by DR-02)
- variable_construction: GREEN (Dictionary-aligned construction; Phase 6 data-handling fixes applied)
- sample_restrictions: GREEN (Analytic flag consistent across scripts; suppression counts reported)
- model_specification: GREEN (Fixed-effects ladder matches design M1-M9)
- standard_errors: YELLOW (Occupation clustering plus industry-year and two-way sensitivity (PM-08, DR-04))
- missing_data: GREEN (Publication suppression handled; bounded by S14 and S18)
- robustness: GREEN (S11-S20 cover the full robustness plan)
- power_effect_size: YELLOW (Thin geothermal and biomass cells (PM-06, DR-03))
- heterogeneity_multi_comparison: YELLOW (Joint Wald test as the inferential basis for H4 (PM-11))
- mechanism_evidence: YELLOW (No direct establishment measures; mechanism framed as interpretation (PM-10))
- table_figure_plan: GREEN (Tables 1-4, A1 and Figures 1-4 mapped to hypotheses)
- preregistration_deviation: GREEN (Plan fixed before execution; SE sensitivity added as a diagnostic, not a new spec)
- interpretive_reach: YELLOW (Descriptive language rules DR-05; H5 null wording rule DR-01)

## Pre-committed null patterns

- H1: S03 renewable coefficient >= 0, or its 95% CI includes 0, with the S15 fossil-only contrast also including 0
- H2: S03 gap equal to or larger than S01 raw gap, and the S08 composition component near 0 or opposite-signed
- H3: S04: nuclear not above fossil fuel, hydroelectric clearly below fossil fuel, or solar and wind not below fossil fuel
- H4: S05 joint Wald test fails to reject equal gaps, or production and maintenance gaps not more negative than management and professional gaps
- H5: S07 trend coefficient <= 0 (gap not shrinking) or S06 joint test fails to reject equal gaps across years

## Decision rules

- DR-01: if S07 trend <= 0 or S06 joint test p >= 0.05, then Report H5 as not supported (no detectable narrowing in smoothed OEWS data); no policy attribution
- DR-02: if S15 renewable-vs-fossil estimate's 95% CI includes 0, then Reframe the headline as a nuclear premium plus renewable-fossil parity
- DR-03: if a source has fewer than 30 identifying cells sharing occupation-years with fossil fuel, then Describe that source estimate as imprecise; no substantive ranking
- DR-04: if S03 p >= 0.05 under two-way clustering, then Main text reports the two-way SE and softens the H1 claim
- DR-05: if always, then Associational and descriptive language only; no causal verbs; mechanisms framed as interpretation
- DR-06: if any robustness spec reverses the sign of S03, then Report the reversal in the main text and narrow the H1 claim to the specifications where it holds
