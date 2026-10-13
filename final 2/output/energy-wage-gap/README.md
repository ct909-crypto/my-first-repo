# energy-wage-gap

Research project managed with [open-scholar-skill](https://github.com/joshzyj/open-scholar-skill).
Initialized by `scholar-init` on 2026-09-30.

This README was auto-generated. Feel free to edit the top (project-specific
content), but **keep the "How this project works" section intact** — it is
the operating manual for anyone (including future-you and co-authors) who
opens this directory and wonders what the conventions are.

---

## What this project is about

_Write 2–3 sentences here about your research question, the data, and the
target journal. This is the place future-you will look when you come back
to this project in three months._

- **Research question:** _fill in_
- **Data source(s):** _fill in_
- **Target journal:** _fill in_
- **Unit of analysis:** _fill in_
- **Analytic strategy:** _fill in_

---

## How this project works

### Directory layout

```
energy-wage-gap/
├── README.md                ← this file
├── .gitignore               ← excludes data/, output/, .claude/safety-status.json
├── .claude/
│   └── safety-status.json   ← per-file SAFETY_STATUS decisions (see below)
├── data/
│   ├── raw/                 ← original files, IMMUTABLE after init
│   ├── interim/             ← cleaned/subsetted (scripts write here)
│   └── processed/           ← analytic datasets used by models
├── materials/               ← codebooks, questionnaires, protocols
├── output/
│   └── energy-wage-gap/            ← analysis/writing skills populate this
│       ├── tables/          ← regression tables (HTML / TeX / docx)
│       ├── figures/         ← plots (PDF / PNG)
│       ├── eda/             ← scholar-eda outputs
│       ├── drafts/          ← manuscript drafts per section
│       ├── scripts/         ← numbered analysis scripts + coding log
│       ├── replication/     ← replication package build log
│       └── logs/            ← process logs per skill
└── logs/
    └── init-report.md       ← permanent ingest record + OVERRIDE rationales
```

**Golden rule:** `data/raw/` is append-only. Never edit a file in `data/raw/`
after init. Cleaned / subsetted versions go in `data/interim/`; the final
analytic dataset goes in `data/processed/`. This keeps provenance traceable.

### The data safety model (important — please read)

Open Scholar Skill ships with a **PreToolUse hook** registered globally in
`~/.claude/settings.json`. Every time Claude tries to `Read` a file in this
project (or any project), the hook runs `scripts/gates/safety-scan.sh` and
checks `.claude/safety-status.json` before the file is allowed to enter
Claude's context.

The decision flow:

```
Claude calls Read("data/raw/foo.csv")
    │
    ▼
PreToolUse hook fires
    │
    ├─ Is the extension a data extension? ──── no ──► allow
    │
    ├─ Is there an entry in .claude/safety-status.json for this file?
    │     │
    │     ├─ CLEARED / ANONYMIZED / OVERRIDE ──► allow
    │     ├─ LOCAL_MODE / HALTED           ──► block with Bash-loader hint
    │     ├─ NEEDS_REVIEW:*                ──► block, ask you to review
    │     └─ no entry                      ──► run safety-scan.sh now
    │                                            │
    │                                            ├─ GREEN  ──► allow
    │                                            ├─ YELLOW ──► block + ask
    │                                            └─ RED    ──► block hard
    │
    └─ (Image files are routed to path-based classification instead
        of content scanning — see _shared/data-handling-policy.md §3)
```

When `scholar-init` created this project, it scanned every file you ingested
and populated `.claude/safety-status.json`:

- **GREEN** files (no PII patterns detected) were auto-marked **CLEARED**.
- **YELLOW** and **RED** files were marked **NEEDS_REVIEW:** until you
  explicitly decide how to handle each one.

**Any file with NEEDS_REVIEW status cannot be read by Claude yet.** The hook
will block the Read call and tell you to review it. Run:

```
/scholar-init review
```

to walk through each unresolved file interactively. For each one you
choose:

| Choice        | Effect                                                                                                   |
|---------------|----------------------------------------------------------------------------------------------------------|
| `CLEARED`     | Read is allowed. Use for GREEN files (auto-applied by scholar-init) or YELLOW files you have confirmed are safe (e.g., a codebook with one author email). **Never use CLEARED for RED files** — they must use OVERRIDE with a typed rationale per policy §2 / §6. |
| `LOCAL_MODE`  | Read is **forbidden**. All analysis must go through `Rscript -e` / `python3 -c` Bash calls with summary-only output. Use for sensitive microdata you want to analyze locally but never transmit. |
| `ANONYMIZED`  | Run `scholar-qual`'s Presidio anonymizer first, then treat the ANON_ output as CLEARED.                  |
| `OVERRIDE`    | Read is allowed, BUT you must log a typed rationale to `logs/init-report.md`. Use when you are certain the scan is a false positive and want an audit record. |
| `HALTED`      | Block this file permanently. Use when you decide the analysis cannot proceed on this data.              |

### Adding new files after init

Option A — use the script directly:

```bash
bash /path/to/open-scholar-skill/scripts/init-project.sh \
    --dest $(dirname $(pwd)) --force energy-wage-gap \
    data/raw/* path/to/new_file.csv
```

(`--force` is safe here because the script copies the existing `data/raw/`
contents back in along with the new files, then rewrites
`.claude/safety-status.json` — but you lose your prior OVERRIDE decisions.
Not recommended.)

Option B — incrementally:

```bash
cp path/to/new_file.csv data/raw/
bash /path/to/open-scholar-skill/scripts/gates/safety-scan.sh data/raw/new_file.csv
# Then edit .claude/safety-status.json and add an entry for the new file.
```

Option C — interactive:

```
/scholar-init add data/raw/new_file.csv
```

(walks through the same scan + decision flow for just the new file.)

### What to invoke next

Depending on what you ingested:

| You have              | Try                                                          |
|-----------------------|--------------------------------------------------------------|
| A codebook / questionnaire (no data yet) | `/scholar-brainstorm materials <path to codebook>` |
| A dataset you want to explore | `/scholar-eda <path to data>`                       |
| A causal research question | `/scholar-causal <treatment> -> <outcome>`         |
| A research idea to develop | `/scholar-idea <topic description>`             |
| Interview transcripts | `/scholar-qual <path to transcripts>`               |
| A text corpus / NLP task | `/scholar-compute text <corpus path>`            |
| Sociolinguistic variation / acoustic data | `/scholar-ling <module> <path>`          |

All of these will honor the `SAFETY_STATUS` for each file — LOCAL_MODE files
will be analyzed via Bash-only scripts; NEEDS_REVIEW files will be blocked
until you run `/scholar-init review`.

### Git hygiene

The auto-generated `.gitignore` excludes:

- `data/raw/`, `data/interim/`, `data/processed/` — never commit raw data
- `.claude/safety-status.json` — contains your OVERRIDE rationales, which
  reference sensitive files by path
- `output/` — large, regenerable artifacts (commit manually if you want)
- `logs/` — timestamps + decisions, per-user state

If you want to share this project with a co-author, send them:
- Everything NOT in `.gitignore` (scripts, drafts, README)
- A separate pointer to where the raw data lives (ICPSR study ID, Dataverse
  handle, OSF project, etc.) — never the data itself.

### If the safety guard is getting in your way

The guard is a hard block. If it's blocking a file you know is safe, the
two intended escape hatches are:

1. Edit `.claude/safety-status.json` directly and set the entry to
   `"CLEARED"` or `"OVERRIDE"`. Record your rationale in
   `logs/init-report.md`.
2. Run `/scholar-init review` to make the decision interactively — it will
   update the JSON and the log for you.

If you need to disable the guard temporarily (e.g., debugging), remove the
`PreToolUse` entry from `~/.claude/settings.json`. Re-add it after you're
done. Do not leave it off.

---

## Project log

_Running notes on decisions, dead ends, and surprising findings. Append to
this section as the project evolves — it's where future-you will look when
you come back and wonder "why did I drop the 2008 wave?"_

- 2026-09-30: Project initialized by scholar-init. See `logs/init-report.md`
  for ingest details.
