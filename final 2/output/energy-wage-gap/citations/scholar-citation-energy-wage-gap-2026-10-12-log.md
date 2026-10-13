# Citation Audit Log: energy-wage-gap (2026-10-12)

Review-only run. No existing file was modified. ASA rendering used a corrected bib copy and the ASA CSL, both kept in the session scratchpad outside the project.

## Summary
- In-text citation instances: 83 (51 unique keys); bib entries: 72
- Orphan citations: 0 · Duplicate keys: 0 · Uncited bib entries: 21 (not rendered)
- Metadata mismatches: 3 (MacKinnon year; Lehmann first name; Lehmann year to confirm)
- Style errors: 11 (see report §3)
- SOURCE NEEDED (unresolved): 8
- Claims checked against source text or abstract: 14 (9 verified, 4 imprecise, 1 partially supported); others not checkable without full text
- Corrections applied to project files: **0** (review only)

## Local library
- No Zotero database found at `~/Zotero/zotero.sqlite`. The tier-1 local check was skipped; `literature/local-library/proposal-library.bib` was not used as an authority.

## CrossRef queries (DOI lookups, 38 cited entries with DOIs)
- MATCH on authors, year, volume, issue, pages, and title: 31
- DIFF, resolved as benign: `cohen2003individuals` and `krueger1988efficiency` (CrossRef stores the first page only; the bib ranges are correct). `bradley2025empirical` (CrossRef has given and family names swapped; the bib order is correct, and the given names Peter/Damian/Emma/Ian/Richard are not confirmed by CrossRef, which holds initials only). `colmer2025nice` and `kuai2025estimating` (SSRN records carry no series number; numbers confirmed by web search). `lakens2017equivalence` (CrossRef splits the subtitle; real issue: HTML in the bib title).
- DIFF, real: `mackinnon2017wild`: bib 2016 → print 2017 (32(2):233–54).
- Extra: `raimi2022mapping` article number 15748 is missing from the bib.
- Holm (1979) title query: no CrossRef record returned, so it was left as SOURCE NEEDED.

## WebSearch / document checks (no DOI)
- colmer2025nice: CEP Discussion Paper dp2127 (RePEc) → VERIFIED-WEB
- kuai2025estimating: IZA DP 17878 (docs.iza.org/dp17878.pdf) → VERIFIED-WEB
- godoy2025green: GRI Working Paper 432, Nov 2025 (lse.ac.uk) → VERIFIED-WEB
- lehmann2020wages: EFI/NASEO/BW Research PDF; lead author "Sarah Lehmann"; year likely 2021 → CORRECTED (name), year UNCONFIRMED
- ilo2014just: IJLR 6(2), Editorial pp. 173–85, "First published 2014" → VERIFIED-WEB
- doe2024useer: USEER 2024 PDF downloaded; figures checked → VERIFIED-WEB
- vona2019measures, curtis2023green, curtis2024workers: abstracts confirm the quoted figures
- Books (Hess 2012; Kalleberg 2011; Vachon 2023; Tilly 1998; Tomaskovic-Devey and Avent-Holt 2019; Rosenfeld 2014) and Winner (1980): standard, well-known publications; metadata consistent. No DOI lookup was run.
- BLS technical notes and FAQ: URLs not fetched in this run (official BLS pages, low fabrication risk). The title year (May 2024) does not match the content used (May 2025).

## Verification status of the 51 cited references
- VERIFIED-CROSSREF: 37 (incl. Colmer and Kuai SSRN records, series numbers confirmed on the web) · VERIFIED-WEB: 5 (Godøy, ILO, USEER, BLS ×2) · CORRECTION NEEDED: 2 (mackinnon2017wild, lehmann2020wages) · Not independently looked up (books/classic): 7 · UNVERIFIED (fabrication suspected): **0**

## SOURCE NEEDED items
See report §4 (8 items: IRA ×3, plant staffing premise, contractor share, rural siting, Holm 1979, dataset citations).

## Disambiguation
- U.S. Bureau of Labor Statistics 2025 ×2 → citeproc assigns 2025a/2025b automatically. No action needed.

## Style corrections applied
- None (review only). The proposed fixes are listed in the report §3.
