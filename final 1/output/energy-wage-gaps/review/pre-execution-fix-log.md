# Pre-Execution Fix Log (Phase 6)

The first-round review found four blocking (MAJOR) findings: COR-001, REP-001, REP-002, and STA-001. All four were fixed inside Phase 6, and six minor findings were fixed as well. Every fix touches only scripts or the script inventory; none changes the research design, data plan, or set of planned specs.

- **COR-001** (MAJOR, correctness): Declared 04_decomposition.R as a dependency of 06_figures.R in the dependency graph. Files: analysis/scripts-inventory.json.
- **REP-001** (MAJOR, reproducibility): Rewrote every script's produces list to match the files it writes (HTML tables, PNG copies, joint-tests.json, fit statistics, identifying-cell counts, SE sensitivity, RDS model objects, model-fit-stats.csv). Files: analysis/scripts-inventory.json, analysis/analysis-plan-manifest.json.
- **REP-002** (MAJOR, reproducibility): Dependency graph now has 06 <- {03, 04} and 07 <- {01, 03, 04, 05}; uses lists updated; script order unchanged. Files: analysis/scripts-inventory.json, analysis/analysis-plan-manifest.json.
- **STA-001** (MAJOR, statistical): 03_main_models.R now re-estimates the S03 and S04 standard errors clustered by industry-year and two-way (occupation + industry-year) and writes analysis/outputs/se-sensitivity.csv. It also writes identifying-cell counts by source (analysis/outputs/identifying-cells-by-source.csv), addressing ROB-003. Files: analysis/scripts/03_main_models.R, analysis/scripts-inventory.json.
- **COR-002** (MINOR, correctness): Special-code flags use %in% and so are never NA. Files: analysis/scripts/01_build_panel.R.
- **ROB-001** (MINOR, robustness): Added stopifnot(!is.na(topcode), topcode >= 50) after parsing the top code. Files: analysis/scripts/01_build_panel.R.
- **DAT-001** (MINOR, data_handling): Added p10_topcoded and median_topcoded flags and coverage counts. Files: analysis/scripts/01_build_panel.R.
- **ROB-002/STY-001** (MINOR, robustness; style_ai_patterns): Replaced the deprecated geom_errorbarh() with geom_errorbar(orientation = 'y', width = 0.2). Files: analysis/scripts/06_figures.R.
- **COR-003** (MINOR, correctness): interaction(..., drop = TRUE) in the S08 composition benchmark. Files: analysis/scripts/07_registry.R.
- **DAT-004** (MINOR, data_handling): Table 1 employment row labeled 'analytic sample'. Files: analysis/scripts/02_descriptives.R.

Minor findings handled as interpretation or reporting constraints rather than code changes:

- STA-002: interpretation constraint carried to Phase 7 and the manuscript: P90 gap is conditional on uncensored cells.
- STA-003: R-squared/within R-squared are the primary fit statistics; AIC/BIC are not compared across samples.
- STA-006: normal-approximation p-value retained for the decomposition component; bootstrap SE reported.
- REP-003: sessionInfo captured in Phase 8 execution-report run_context.
- STY-004: duplication accepted at this script size.

Unfixed blocking findings: 0.
