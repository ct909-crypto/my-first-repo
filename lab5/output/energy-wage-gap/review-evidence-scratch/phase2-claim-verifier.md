# Phase 2 Claim Verifier

**Access caveat.** evidence/claim-anchors.ndjson could not be read. The data-guard hook failed closed because .claude/safety-status.json has non-schema OVERRIDE strings (the status values carry free-text rationales). I did not bypass it. No anchor-based checks were done. Verdicts rest on OpenAlex abstracts (curtis2023, curtis2024, vona2019 verified) and on my own knowledge. Fix the sidecar and rerun to anchor-check the rest.

| Sentence excerpt | Key | Verdict | Fix |
|---|---|---|---|
| Green-intensive employment ... ~4% wage premium | vona2019measures | OK (verified, abstract "4% wage premium") | Optional: say "task-based green occupations". |
| Solar and wind jobs created in occupations ~21% higher paying | curtis2023green | OK (verified) | The draft's critique of the measure is the authors' own inference, not the paper's. Keep it framed as ours. |
| Fewer than 1% of workers leaving carbon-intensive jobs move to green | curtis2024workers | OK (verified) | Add "rate rose tenfold 2005-2021" to avoid a one-sided reading. |
| Green jobs in Japan earn more largely because of task content | kuai2025estimating | OK-with-note (unverified) | Check the SSRN abstract before finalizing. |
| Conditional on education, no more pay in clean than legacy firms; moves rare | colmer2025nice | OK-with-note (OpenAlex has no abstract) | Confirm against the PDF. "Clean" vs "legacy" definitions and the US-only scope need stating. |
| Norwegian green-firm premium smaller than in high-carbon industries | godoy2025green | OK-with-note (unverified) | Confirm direction and that the comparison is firm-level. |
| Median wages differ by technology, solar at low end | lehmann2020wages | OK-with-note | Confirm the year and that the statistic is a median. |
| Reviews conclude research relies on inconsistent definitions ... seldom asks how rewards are distributed | bradley2025empirical; pearse2022labour; hanna2024job | [CLAIM-MISCHARACTERIZED] (partial) | pearse2022labour is a value-theoretical essay, not a review. Hanna et al. review job counts. Cite only bradley and hanna for the review claim, and cite pearse separately for the theory point. |
| Clean-energy employment grew more than twice as fast as the rest of the energy sector and U.S. economy; union coverage 16-19% vs 11-14% vs 13% | doe2024useer | OK-with-note | Verify the exact percentages and the "union or project-labor" wording against USEER 2024. |
| Renewable generation employment "roughly doubled in the early 2020s" | (none) | [CLAIM-UNSUPPORTED] | Add a source (USEER or OEWS) or delete. |
| Energy workers judge the transition largely by pay, skills, bargaining power | sicotte2022necessary; mayer2018just; cha2020just | [CLAIM-MISCHARACTERIZED] | Sicotte is unionized workers with mixed views. Mayer studies local policy actors. Cha studies identity and politics. Soften "largely", and drop or reassign mayer and cha. |
| Reviews call for attention to distributive consequences for workers | beckfield2023social; carley2020justice; sovacool2019decarbonization | OK-with-note | Sovacool is four case studies, not a review. Say "reviews and case studies". |
| Fossil-fuel communities highly exposed | raimi2022mapping | OK | none |
| Industries pay persistently different wages ... workers share in rents | krueger1988efficiency | OK-with-note | Rent-sharing is one interpretation. Their own framing is efficiency wages. |
| Employer effects account for a substantial part of wage variation | abowd1999high | OK | none |
| Rising between-workplace dispersion has driven much of earnings inequality growth | card2013workplace; barth2016where; song2019firming; tomaskovicdevey2020rising | OK-with-note | Card et al. attribute about one-third of West German inequality growth to workplaces. Use "a large share" and note the country-specific magnitudes. |
| Much of gender and racial wage gap operates through jobs and establishments, not unequal pay within the same job | petersen1995separate; cohen2003individuals; huffman2004racial | OK-with-note | Petersen and Morgan find small within-job gaps, which supports the claim. Cohen and Huffman concern devaluation via occupational composition. Change "same way" to "through sorting". |
| Closure devices (unions, licensing) raise pay | weeden2002why; western2011unions; rosenfeld2014unions | OK-with-note | Western and Rosenfeld stress unions compressing inequality via norms. Keep the verb "raise" scoped to union-covered workers. |
| Winner: energy technologies come with distinct forms of organization | winner1980artifacts | OK-with-note | Winner's argument is general (technologies embody politics, nuclear vs solar as an example). It does not cover wind or solar operations staffing. |
| Managerial/professional pay benchmarked against external markets | diprete2010compensation | [CLAIM-MISCHARACTERIZED] (stretch) | DiPrete et al. concern CEO pay benchmarking and leapfrogging. Restrict to "executive pay" or cite elsewhere. |
| Union debates turn on fear that manual jobs won't carry protections | sicotte2025labor; vachon2023clean | OK-with-note | Vachon is broad on labor and climate. Add a chapter or pages. |
| Critics stress institutional arrangements adjust slowly; growth need not transform pay structures | york2003key; tilly1998durable; knuth2019whatever; burke2018political | [CLAIM-MISCHARACTERIZED] | York and Rosa is about eco-efficiency and institutional efficacy, not pay. Burke and Stephens is about political power. Say "critics question EM's claims" and attach the pay prediction to Tilly only as our extension. |
| Worker-level studies ... terms of renewable employment set by coalitions and bargaining capacity, not growth alone | hess2012good; sicotte2025labor | [CLAIM-MISCHARACTERIZED] | Hess is about industrial policy and Sicotte is a labor-politics analysis. Neither is a worker-level study, and neither estimates pay. Replace with "political-economy studies". |
| Ecological modernization treats reform as source of economic upgrading | spaargaren1992sociology | OK | none |
| OEWS estimates pool three years of panels, not designed as time series | bls2025oews; bls2025oewsfaq | OK (known BLS guidance) | Note the OEWS 3-year panel and the May/Nov reference points. |

## Overall
No [CLAIM-REVERSED] or [CLAIM-OVERCAUSAL] found. Causal language in the draft is appropriately conditional ("suggests", "we expect"). The main risk is mismatched citation clusters (mayer, cha, york, hess, pearse, diprete) that are bundled in support of claims they do not make. One uncited empirical claim needs a source (the "roughly doubled" statement).
