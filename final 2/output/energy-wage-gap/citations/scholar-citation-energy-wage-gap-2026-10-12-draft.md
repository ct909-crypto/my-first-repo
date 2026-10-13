# Citation Audit Report: energy-wage-gap (2026-10-12)

**Mode:** AUDIT (review only, with no edits to the manuscript or `references.bib`)
**Style audited against:** ASA author-date (ASA Style Guide, 7th ed.; rendered with the official `american-sociological-association.csl`, updated 2025-06-30)
**Manuscript:** `output/energy-wage-gap/final/manuscript-final.md` (Pandoc + citeproc; `bibliography: ../literature/references.bib`)
**Bibliography:** `output/energy-wage-gap/literature/references.bib` (72 entries)

---

## 0. Headline finding: the manuscript is not set up for ASA

The YAML header specifies `csl: elsevier-with-titles.csl`, a **numeric** style (`citation-format="numeric"`). Every rendered output (`.tex`, `.pdf`, `.docx`) therefore shows `[4]`-style numbered citations and a numbered reference list in order of first appearance. Other features of the manuscript point to an Elsevier journal such as *Energy Research & Social Science*: Highlights, a "Declaration of generative AI use", a CRediT statement, and "Fig." labels.

- **If the target is an Elsevier journal,** the numeric CSL is correct. Sections 2–4 below still apply, because they concern the bib metadata and the claims. Section 1, item S-1 (narrative citations) is a defect in **both** styles.
- **If the target is ASA-style** (ASR, AJS, Social Forces, Demography, and similar), replace the CSL with `american-sociological-association.csl`. Section 5 shows what the reference list would look like after the metadata fixes. That preview was rendered from a corrected copy of the bib kept outside the project; no project file was changed.

---

## CITATION AUDIT REPORT

```
Style: ASA author-date (manuscript currently configured: Elsevier numeric)
Total in-text citation instances: 83 (51 unique keys)
Total bib entries: 72 (51 cited, 21 uncited)

ORPHAN IN-TEXT CITATIONS (0)
GHOST REFERENCES (0 rendered; 21 unused bib entries, which citeproc omits)
YEAR/AUTHOR MISMATCHES (3)
DISAMBIGUATION NEEDED (0)  (BLS 2025a/2025b handled automatically by citeproc)
STYLE ERRORS (11)
SOURCE NEEDED: uncited claims (8)
CLAIM CHECKS: 9 verified against source text/abstract, 4 imprecise, rest not full-text checkable
```

### 1. Orphans and ghosts

- **Orphans:** none. All 51 `@keys` resolve to bib entries, and there are no duplicate keys.
- **Uncited bib entries (21):** alderson2002globalization, autor2006polarization, beck1992risk, beckfield2006european, blinder1973wage, cha2020just, fortin1997institutional, fortin2011decomposition, fragkos2018employment, hirsch2003union, huffman2004racial, kristal2013capitalist, lin2013financialization, mayer2018just, mcclure2017green, morris1999inequality, oaxaca1973male, pratomo2024analyzing, ross2022intersections, sovacool2019decarbonization, yu2022time. Citeproc leaves these out of the rendered list, so there are no ghost references in the output. If the bib is submitted as part of a replication package, consider pruning them.

### 2. Year/author mismatches (metadata)

| # | Key | Problem | Evidence | Fix |
|---|-----|---------|----------|-----|
| M-1 | `mackinnon2017wild` | The bib says `year={2016}`, so the text renders "MacKinnon and Webb 2016". The key says 2017. | CrossRef: *J. Applied Econometrics* 32(2):233–54, issue year **2017** (online first 2016) | year = 2017 |
| M-2 | `lehmann2020wages` | The author's first name is **Sarah**, not "Sara". | Report PDF, project-team page: "LEAD AUTHOR Sarah Lehmann" | Correct the given name |
| M-3 | `lehmann2020wages` | The year is likely **2021**. The report is a "Supplement to the 2020 USEER", discusses June–December 2020 data, and is hosted under a `/2021/03/` upload path. | efifoundation.org PDF | **[VERIFY YEAR: author to confirm the 2020 vs. 2021 release]** |

### 3. Style errors (ASA)

| # | Location | Problem | Fix |
|---|----------|---------|-----|
| S-1 | md lines 49, 55, 57, 89 | **Narrative citations break under the numeric CSL.** `@curtis2023green estimate`, `@krueger1988efficiency interpret`, `@winner1980artifacts argued`, and `following @kitagawa1955components` render as "[4] estimate…", "[6] interpret…", "[37] argued…", "following [51]". | Under ASA these render correctly ("Curtis and Marinescu (2023) estimate"). Under Elsevier numeric, write the names: "Curtis and Marinescu [@curtis2023green] estimate". |
| S-2 | `lakens2017equivalence` | The title contains literal HTML (`<i>t</i>`), which renders as "\textless i\textgreater t…" in the PDF. | Use `{\textit{t}}` or plain "t". |
| S-3 | `card2013workplace`, `song2019firming`, `kitagawa1955components` | Titles end in a CrossRef footnote asterisk ("…Inequality*", "…Two Rates*"), which shows in the rendered references. | Remove the `*`. |
| S-4 | `sicotte2025labor`, `vachon2023clean`, `western2011unions`, `lehmann2020wages` | "U.S." is lowercased to "u.s." under both CSLs. Elsevier sentence-casing also lowercases "United States", "West German", and "Green New Deal". | Protect proper nouns with braces: `{U.S.}`, `{United States}`, `{West German}`, `{Green New Deal}`. |
| S-5 | `godoy2025green`, `lehmann2020wages` | An institution field containing "and" is parsed as a name list: "Climate Change; the Environment" and "Officials,; Energy Futures Initiative". | Wrap the whole institution in double braces. |
| S-6 | `bls2025oews`, `bls2025oewsfaq` | `@misc` entries with `howpublished` render with **no URL and no retrieval date**. ASA requires "Retrieved Month Day, Year (URL)" for web documents. | Use `@online`/`@webpage` with `url` and `urldate`. |
| S-7 | `bls2025oews` | The title says "Technical Notes for **May 2024** OEWS Estimates", but the text (line 87) describes the May 2025 panel structure (November 2022–May 2025). The URL `/oes/current/` now serves different notes than the ones titled. | Cite the May 2025 technical notes, with a retrieval date. |
| S-8 | `colmer2025nice`, `kuai2025estimating` | `publisher={Elsevier BV}` is an SSRN-DOI artifact on working papers. ASA renders "CEP Discussion Paper. 2127." | Drop the publisher. Render as "CEP Discussion Paper No. 2127" / "IZA Discussion Paper No. 17878" by putting "No." in `type` or using `number` styling. |
| S-9 | `raimi2022mapping` | The article number is missing. | CrossRef: article 15748. Add `pages={15748}`. |
| S-10 | `ilo2014just` | The issue's own masthead credits the editorial to the **Editorial Committee**, not "International Labour Office". The issue says "First published 2014" with © ILO 2015. | Acceptable as a corporate author. Optionally use "ILO Bureau for Workers' Activities". Pages 173–85 are confirmed. |
| S-11 | In-text ordering | Multi-citation brackets in the source are ordered inconsistently (8 chronological, 6 alphabetical, 3 neither). | **No action needed under ASA**, because the ASA CSL sorts them alphabetically on render (verified). This matters only if citations are hand-typed. |

The rendered ASA output has no direct quotations without page numbers and no "et al." in the reference list.

### 4. SOURCE NEEDED: uncited empirical or legal claims

1. **Line 30:** "new federal tax credits for clean electricity under the 2022 Inflation Reduction Act". **[SOURCE NEEDED: statute citation, Inflation Reduction Act of 2022, Pub. L. 117-169]**
2. **Line 63:** "subsidies tied to prevailing-wage and apprenticeship standards". **[SOURCE NEEDED: IRA §13101 / 26 U.S.C. §45 prevailing-wage and apprenticeship provisions, or Treasury/IRS guidance]**
3. **Line 209:** "labor standards attached to the new clean-electricity tax credits apply mainly to construction, alteration, and repair work". This is the same source need as item 2 and is load-bearing for the Discussion. **[SOURCE NEEDED]**
4. **Line 57:** fossil and nuclear plants are "many built under the regulated-utility model with internal labor markets and formal job ladders; wind and solar … small permanent operations workforces". This is an empirical premise of the theory. **[SOURCE NEEDED: e.g., staffing-per-MW or O&M workforce evidence]**
5. **Line 69:** "construction contractors who build most solar and wind capacity". **[SOURCE NEEDED]** (USEER 2024 construction-share tables could support this.)
6. **Line 213:** "Wind and solar plants are likely to be sited in more rural areas with lower prevailing wages". Either cite it (e.g., EIA plant locations) or mark it explicitly as conjecture. **[SOURCE NEEDED]**
7. **Line 85:** the Holm procedure is used without citing the original. **[SOURCE NEEDED: Holm (1979), *Scandinavian Journal of Statistics*.]** CrossRef did not return the record, so it is not inserted here. Verify the metadata before adding it.
8. **Lines 69–75 and Declarations:** the primary datasets (BLS OEWS national industry-specific estimates, May 2021–2025; CPI-U series CUUR0000SA0) are described but **not cited as data**. ASA and most journals expect dataset citations with a retrieval date and URL. **[SOURCE NEEDED: dataset reference entries]**

### 5. Claim-faithfulness spot checks (V-3.5, targeted)

The existing `evidence/claim-anchors.ndjson` holds 30 anchors, all `metadata_only` / `T4_none`, so no prior full-text check exists. I checked the specific factual and numeric claims against source text or abstracts:

| Claim (line) | Citation | Verdict | Evidence |
|---|---|---|---|
| Green employment carries a wage premium of about 4% (49) | vona2019measures | **VERIFIED** | Published abstract: "commands a 4% wage premium" |
| Solar and wind postings sit in occupations whose average pay is about a fifth above the mean (49) | curtis2023green | **VERIFIED** | "occupations about 21% higher paying than average" |
| Clean firms pay no more than legacy firms conditional on education; few legacy-to-clean moves (32, 49, 203) | colmer2025nice | **VERIFIED** (NBER conference draft, Nov. 2023) | Draft findings match. CEP DP 2127 confirmed via RePEc. The 2025 version may differ, so re-check against the final DP. |
| Under 1% of workers leaving carbon-intensive jobs move into green jobs (49, 207) | curtis2024workers | **VERIFIED** | Abstract: "fewer than 1 percent" |
| Norwegian green-firm premium is below the high-carbon premium (49) | godoy2025green | **VERIFIED** (minor) | The brown-firm premium is about double the green premium. The source compares **firms**; the manuscript says "industries". |
| Solar is near the bottom of median wages across energy technologies (49) | lehmann2020wages | **VERIFIED** | Lists "energy storage, energy efficiency, solar, and wind" as the sectors with the lowest wage premiums |
| Clean energy grew more than twice as fast as the rest of energy and the economy in 2023 (45) | doe2024useer | **VERIFIED** | 4.9% vs. 2.0% |
| About 919,000 EPG workers (69) | doe2024useer | **VERIFIED** | 918,850 in 2023 |
| Union coverage of 16–19% in coal, gas, and nuclear; 11–14% in solar and wind; 13% in water (57, 205) | doe2024useer | **VERIFIED, with a caveat** | Tables: coal 16%, natural gas 17%, nuclear 19%, water 13%, wind 12%, solar 11%. USEER is **internally inconsistent** for solar: a bullet says 14% and the table says 11%. Consider noting this, or cite the table value. |
| Green jobs in Japan pay more "mainly because of their task content" (49) | kuai2025estimating | **CLAIM-IMPRECISE** | The explained part is attributed to tasks, gender gaps, and occupation, and a large unexplained part sits in high-paying green jobs. Suggest "partly because of task content". |
| Gender gap reflects sorting "rather than unequal pay within the same job" (55) | cohen2003individuals | **CLAIM-IMPRECISE** | Petersen and Morgan (1995) fits exactly. Cohen and Huffman (2003) argue for the *devaluation* of female-typed work, which is a different mechanism. Consider dropping it or rephrasing. |
| Rising between-workplace inequality explains earnings inequality in "the United States" (55) | tomaskovicdevey2020rising | **CLAIM-IMPRECISE (scope)** | This is a cross-national study of high-income countries. The author should confirm U.S. coverage or move the citation to a cross-national clause. |
| Reviews note a focus on job numbers rather than pay (49) | pearse2022labour | **CLAIM-IMPRECISE** | Pearse and Bryant is a value-theoretical argument, not a review. Bradley et al. (2025) and Hanna et al. (2024) fit. |
| Just transition originated in the labor movement (45) | ilo2014just + stevis2015global | Supported by **Stevis and Felli**. The ILO editorial frames just transition through the 2013 ILC Conclusions and does not make the origin claim, so it supports only the "workers should not bear the costs" framing. | |

Classic theory citations (Krueger and Summers; Abowd et al.; Card et al.; Weeden; Western and Rosenfeld; DiPrete et al.; Tilly; Winner; Spaargaren and Mol; York and Rosa) are characterized consistently with their published abstracts and standard readings. Claims attributed to Sicotte (2022, 2025), Vachon (2023), Hess (2012), Knuth (2019), Burke and Stephens (2018), Kalleberg (2011), and Rosenfeld (2014) were **[CLAIM-NOT-CHECKABLE]** without full text, so the author should confirm them.

### RECOMMENDED ACTIONS (priority order)

1. Decide on the style. Keep the Elsevier numeric CSL for an Elsevier journal, or switch to `american-sociological-association.csl` for an ASA journal.
2. Fix the four narrative citations (S-1) if staying numeric.
3. Fix the metadata in M-1 and M-2, and confirm M-3.
4. Fix the rendering issues S-2 through S-9 in the bib.
5. Add citations for the eight SOURCE NEEDED items, especially the IRA labor-standards claims (items 2–3) and the dataset citations (item 8).
6. Soften or re-attribute the four CLAIM-IMPRECISE sentences.

---

## Proposed ASA Reference List (preview)

Rendered with `pandoc --citeproc` and the official ASA CSL from a **scratch copy** of the bib with M-1, M-2, S-2, S-3, S-8 (partial), and S-9 applied. Remaining known defects are marked ⚠: S-4 lowercased "u.s.", S-5 institution parsing, S-6 BLS entries without URL or retrieval date, and M-3 the Lehmann year.

Abowd, John M., Francis Kramarz, and David N. Margolis. 1999. “High Wage Workers and High Wage Firms.” Econometrica 67(2):251–333. doi:10.1111/1468-0262.00020.

Barth, Erling, Alex Bryson, James C. Davis, and Richard Freeman. 2016. “It’s Where You Work: Increases in the Dispersion of Earnings Across Establishments and Individuals in the United States.” Journal of Labor Economics 34(S2):S67–97. doi:10.1086/684045.

Beckfield, Jason, and Daniel Alain Evrard. 2023. “The Social Impacts of Supply-Side Decarbonization.” Annual Review of Sociology 49(1):155–75. doi:10.1146/annurev-soc-031021-012201.

Bradley, Peter, Damian Whittard, Emma Green, Ian Brooks, and Richard Hanna. 2025. “Empirical Research on Green Jobs: A Review and Reflection with Practitioners.” Sustainable Futures 9:100527. doi:10.1016/j.sftr.2025.100527.

Burke, Matthew J., and Jennie C. Stephens. 2018. “Political Power and Renewable Energy Futures: A Critical Review.” Energy Research & Social Science 35:78–93. doi:10.1016/j.erss.2017.10.018.

Cameron, A. Colin, Jonah B. Gelbach, and Douglas L. Miller. 2008. “Bootstrap-Based Improvements for Inference with Clustered Errors.” Review of Economics and Statistics 90(3):414–27. doi:10.1162/rest.90.3.414.

Card, David, Jörg Heining, and Patrick Kline. 2013. “Workplace Heterogeneity and the Rise of West German Wage Inequality.” The Quarterly Journal of Economics 128(3):967–1015. doi:10.1093/qje/qjt006.

Carley, Sanya, and David M. Konisky. 2020. “The Justice and Equity Implications of the Clean Energy Transition.” Nature Energy 5(8):569–77. doi:10.1038/s41560-020-0641-6.

Cohen, Philip N., and Matt L. Huffman. 2003. “Individuals, Jobs, and Labor Markets: The Devaluation of Women’s Work.” American Sociological Review 68(3):443–63. doi:10.2307/1519732.

Colmer, Jonathan, Eva Lyubich, and John L. Voorheis. 2025. Nice Work If You Can Get It? The Distribution of Employment and Earnings During the Early Years of the Clean Energy Transition. CEP Discussion Paper. 2127. Centre for Economic Performance, London School of Economics. doi:10.2139/ssrn.5582530.

Curtis, E. Mark, and Ioana Marinescu. 2023. “Green Energy Jobs in the United States: What Are They, and Where Are They?” Environmental and Energy Policy and the Economy 4:202–37. doi:10.1086/722677.

Curtis, E. Mark, Layla O’Kane, and R. Jisung Park. 2024. “Workers and the Green-Energy Transition: Evidence from 300 Million Job Transitions.” Environmental and Energy Policy and the Economy 5:127–61. doi:10.1086/727880.

DiPrete, Thomas A., Gregory M. Eirich, and Matthew Pittinsky. 2010. “Compensation Benchmarking, Leapfrogs, and the Surge in Executive Pay.” American Journal of Sociology 115(6):1671–1712. doi:10.1086/652297.

Godøy, Anna, and Elisabeth T. Isaksen. 2025. A Green Wage Premium? Working Paper. 432. Grantham Research Institute on Climate Change; the Environment ⚠. https://www.lse.ac.uk/granthaminstitute/publication/a-green-wage-premium/.

Hanna, Richard, Philip Heptonstall, and Robert Gross. 2024. “Job Creation in a Low Carbon Transition to Renewables and Energy Efficiency: A Review of International Evidence.” Sustainability Science 19(1):125–50. doi:10.1007/s11625-023-01440-y.

Healy, Noel, and John Barry. 2017. “Politicizing Energy Justice and Energy System Transitions: Fossil Fuel Divestment and a ‘Just Transition’.” Energy Policy 108:451–59. doi:10.1016/j.enpol.2017.06.014.

Hess, David J. 2012. Good Green Jobs in a Global Economy: Making and Keeping New Industries in the United States. Cambridge, MA: MIT Press.

International Labour Office. 2014. “Editorial: A Just Transition for All: Can the Past Inform the Future?” International Journal of Labour Research 6(2):173–85.

Kalleberg, Arne L. 2011. Good Jobs, Bad Jobs: The Rise of Polarized and Precarious Employment Systems in the United States, 1970s–2000s. New York: Russell Sage Foundation.

Kitagawa, Evelyn M. 1955. “Components of a Difference Between Two Rates.” Journal of the American Statistical Association 50(272):1168–94. doi:10.1080/01621459.1955.10501299.

Knuth, Sarah. 2019. “Whatever Happened to Green Collar Jobs? Populism and Clean Energy Transition.” Annals of the American Association of Geographers 109(2):634–43. doi:10.1080/24694452.2018.1523001.

Krueger, Alan B., and Lawrence H. Summers. 1988. “Efficiency Wages and the Inter-Industry Wage Structure.” Econometrica 56(2):259–93. doi:10.2307/1911072.

Kuai, Wenjing, Robert J. R. Elliott, Toshihiro Okubo, and Ceren Ozgen. 2025. Estimating the Green Wage Premium. IZA Discussion Paper. 17878. IZA Institute of Labor Economics. doi:10.2139/ssrn.5240989.

Lakens, Daniël. 2017. “Equivalence Tests: A Practical Primer for t Tests, Correlations, and Meta-Analyses.” Social Psychological and Personality Science 8(4):355–62. doi:10.1177/1948550617697177.

⚠ Lehmann, Sarah. 2020. Wages, Benefits, and Change: A Supplemental Report to the Annual u.s. ⚠ Energy and Employment Report. BW Research Partnership, National Association of State Energy Officials,; Energy ⚠ Futures Initiative.

MacKinnon, James G., and Matthew D. Webb. 2017. “Wild Bootstrap Inference for Wildly Different Cluster Sizes.” Journal of Applied Econometrics 32(2):233–54. doi:10.1002/jae.2508.

McCauley, Darren, and Raphael Heffron. 2018. “Just Transition: Integrating Climate, Energy and Environmental Justice.” Energy Policy 119:1–7. doi:10.1016/j.enpol.2018.04.014.

Newell, Peter, and Dustin Mulvaney. 2013. “The Political Economy of the ‘Just Transition’.” The Geographical Journal 179(2):132–40. doi:10.1111/geoj.12008.

Pearse, Rebecca, and Gareth Bryant. 2022. “Labour in Transition: A Value-Theoretical Approach to Renewable Energy Labour.” Environment and Planning E: Nature and Space 5(4):1872–94. doi:10.1177/25148486211055542.

Petersen, Trond, and Laurie A. Morgan. 1995. “Separate and Unequal: Occupation-Establishment Sex Segregation and the Gender Wage Gap.” American Journal of Sociology 101(2):329–65. doi:10.1086/230727.

Raimi, Daniel, Sanya Carley, and David Konisky. 2022. “Mapping County-Level Vulnerability to the Energy Transition in US Fossil Fuel Communities.” Scientific Reports 12(1):15748. doi:10.1038/s41598-022-19927-6.

Rosenfeld, Jake. 2014. What Unions No Longer Do. Cambridge, MA: Harvard University Press.

Sicotte, Diane M. 2025. “U.s. ⚠ Labor and Renewable Energy: Green Growth Versus the Green New Deal.” Environmental Sociology 11(2):228–38. doi:10.1080/23251042.2024.2422033.

Sicotte, Diane M., Kelly A. Joyce, and Arielle Hesse. 2022. “Necessary, Welcome or Dreaded? Insights on Low-Carbon Transitions from Unionized Energy Workers in the United States.” Energy Research & Social Science 88:102511. doi:10.1016/j.erss.2022.102511.

Song, Jae, David J. Price, Fatih Guvenen, Nicholas Bloom, and Till von Wachter. 2019. “Firming up Inequality.” The Quarterly Journal of Economics 134(1):1–50. doi:10.1093/qje/qjy025.

Spaargaren, Gert, and Arthur P. J. Mol. 1992. “Sociology, Environment, and Modernity: Ecological Modernization as a Theory of Social Change.” Society & Natural Resources 5(4):323–44. doi:10.1080/08941929209380797.

Stevis, Dimitris, and Romain Felli. 2015. “Global Labour Unions and Just Transition to a Green Economy.” International Environmental Agreements: Politics, Law and Economics 15(1):29–43. doi:10.1007/s10784-014-9266-1.

Tilly, Charles. 1998. Durable Inequality. Berkeley: University of California Press.

Tomaskovic-Devey, Donald, and Dustin Avent-Holt. 2019. Relational Inequalities: An Organizational Approach. New York: Oxford University Press.

Tomaskovic-Devey, Donald, Anthony Rainey, Dustin Avent-Holt, Nina Bandelj, István Boza, David Cort, Olivier Godechot, Gergely Hajdu, Martin Hällsten, Lasse Folke Henriksen, Are Skeie Hermansen, Feng Hou, Jiwook Jung, Aleksandra Kanjuo-Mrčela, Joe King, Naomi Kodama, Tali Kristal, Alena Křížková, Zoltán Lippényi, Silvia Maja Melzer, Eunmi Mun, Andrew Penner, Trond Petersen, Andreja Poje, Mirna Safi, Max Thaning, and Zaibu Tufail. 2020. “Rising Between-Workplace Inequalities in High-Income Countries.” Proceedings of the National Academy of Sciences 117(17):9277–83. doi:10.1073/pnas.1918249117.

U.S. Bureau of Labor Statistics. 2025a. “Occupational Employment and Wage Statistics: Frequently Asked Questions.” ⚠

U.S. Bureau of Labor Statistics. 2025b. “Occupational Employment and Wage Statistics: Technical Notes for May 2024 OEWS Estimates.” ⚠

U.S. Department of Energy. 2024. United States Energy and Employment Report 2024. Washington, DC: U.S. Department of Energy. https://www.energy.gov/sites/default/files/2024-10/USEER%202024_COMPLETE_1002.pdf.

Vachon, Todd E. 2023. Clean Air and Good Jobs: U.s. ⚠ Labor and the Struggle for Climate Justice. Philadelphia: Temple University Press.

Vona, Francesco, Giovanni Marin, and Davide Consoli. 2019. “Measures, Drivers and Effects of Green Employment: Evidence from US Local Labor Markets, 2006–2014.” Journal of Economic Geography 19(5):1021–48. doi:10.1093/jeg/lby038.

Webb, Matthew D. 2023. “Reworking Wild Bootstrap‐based Inference for Clustered Errors.” Canadian Journal of Economics/Revue Canadienne d’économique 56(3):839–58. doi:10.1111/caje.12661.

Weeden, Kim A. 2002. “Why Do Some Occupations Pay More Than Others? Social Closure and Earnings Inequality in the United States.” American Journal of Sociology 108(1):55–101. doi:10.1086/344121.

Western, Bruce, and Jake Rosenfeld. 2011. “Unions, Norms, and the Rise in u.s. ⚠ Wage Inequality.” American Sociological Review 76(4):513–37. doi:10.1177/0003122411414817.

Wilmers, Nathan, and Clem Aeppli. 2021. “Consolidated Advantage: New Organizational Dynamics of Wage Inequality.” American Sociological Review 86(6):1100–1130. doi:10.1177/00031224211049205.

Winner, Langdon. 1980. “Do Artifacts Have Politics?” Daedalus 109(1):121–36.

York, Richard, and Eugene A. Rosa. 2003. “Key Challenges to Ecological Modernization Theory: Institutional Efficacy, Case Study Evidence, Units of Analysis, and the Pace of Eco-Efficiency.” Organization & Environment 16(3):273–88. doi:10.1177/1086026603256299.

