# Runtime Sanity (Phase 10)

**Decision: PROCEED_TO_RESULTS_LOCK.** This is a deterministic gate run by scholar-auto-research.

- **Plausibility:** all five domains pass. Estimates are finite, p-values are valid, n is between 915 and 1876 cells, and magnitudes are plausible.
- **Clean room:** a full rerun in an isolated copy reproduced all 20 registry rows within a numeric tolerance of 1e-08. 31 of 31 artifacts are byte-identical. The rest differ only in serialization metadata.
- **Invariants:** all seven checks pass.
- **PAP drift:** none. The 20 planned specs equal the 20 executed specs.
- **Lock candidates:** 23 artifacts reconciled against the Phase 8 manifest, with no missing or extra paths.
- **Phase 9 constraints carried forward:** the S07 null trend, the S08 conflicting composition result, and the weak geothermal and hydro components keep their interpretation constraints.
