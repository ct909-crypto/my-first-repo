# Pipeline status: energy-wage-gap (2026-09-30)

## Completed and verified through the scholar-auto-research gates
- Phases 0–5 (safety; research question; literature and theory; design; data and measurement; analysis plan). Each passed `auto-research-verify.sh` and was recorded in `.auto-research/state.json`.

## Not completed through the gates (author-approved deviation)
- **Phase 6 (independent pre-execution code review):** every reviewer dispatch (specialized and general-purpose agents, two models) was blocked by an API safety filter. No reviewer reports exist. Reviewer session `s-a4b62f92aa254065f1ae06ac` is reserved but not completed.
- **What happened instead:** at the author's direction, the analysis scripts were reviewed by the main assistant session, run, and debugged. Fixes made during execution:
  - weight-vector length in the wild bootstrap;
  - dplyr summarise ordering in the decomposition;
  - PDF device;
  - figure filtering for major groups with fewer than three identifying occupations;
  - usable-cell count corrected from 1,962 to 2,006 in the build assertion and the Phase 4–5 documents.
- **Phases 7–20** (premortem, execution review, results lock, verification panels, citation audit, ethics, replication package, quality gate, submission hygiene) were **not run**. The manuscript has therefore not had the pipeline's independent verification, citation-faithfulness audit, or simulated peer review.

## Outputs
- Manuscript: `final/manuscript-final.{md,docx,tex,pdf}`. The body runs about 12 single-spaced pages, followed by declarations, references, and an appendix.
- Analysis code: `analysis/scripts/00–08` (run in order from the project root).
- Results:
  - `tables/` (results registry, main tables);
  - `figures/` (PNG and PDF; figure registry);
  - `analysis/output/` (contrasts, decomposition, bootstrap draws, logs).

## Other notes
- **Local reference library:** none was configured, so the author's proposal reference list was converted into a CrossRef-checked BibTeX library (`literature/local-library/`).
- **Safety sidecar:** `.claude/safety-status.json` values were normalized to bare `OVERRIDE` for guard-schema compatibility. The rationale is kept in `logs/init-report.md` and `safety/safety-status.json`.
- **Books and reports:** these bibliography entries (Beck, Hess, Kalleberg, Vachon, Tilly, Tomaskovic-Devey & Avent-Holt, Rosenfeld, Winner, ILO, Godøy & Isaksen, Lehmann, DOE, BLS) were entered from the proposal or from publisher/agency information and have not been checked against an authoritative catalog. Verify them before submission.
