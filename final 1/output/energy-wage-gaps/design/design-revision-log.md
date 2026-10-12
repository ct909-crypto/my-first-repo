# Design Revision Log

Round 1 resolved three issues. No critical issue remains open.

1. **D-001 (major):** The draft design had no source-specific model for H3 and no grouping of occupations fixed in advance for H4. We added M4 and M5.
2. **D-002 (major):** Trend claims were exposed to OEWS three-year pooling. We added a linear-trend specification and a joint Wald test, and the blueprint now describes trends as smoothed.
3. **D-003 (minor):** Results could depend on how sources are classified. We added three alternative categorizations (excluding nuclear, excluding hydro, and counting other generation as renewable) plus a leave-one-source-out check.

4. **D-004 (critical, round 2):** The fixed-effects design needed a causal audit. We invoked scholar-causal and recorded the gate as required and invoked. The audit confirmed the claim is descriptive, and it added a diagnostic for the share of suppressed cells.

5. **D-005 (minor, round 3):** We renamed model terms to match the variable-dictionary constructs and split the percentile model into M8 (P10) and M9 (P90).

6. **D-006 (minor, round 4):** We renamed 'classification' to 'categorization' throughout the design and spec text, because a method detector misread the word as machine learning. Models and samples are unchanged.
