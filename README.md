# STA302 Research Project

## Latest revision — 2 November 2026

The three project repositories now contain the revised English proposals (Markdown, HTML, PDF and Word), English analysis supplements and rerun evidence. Start with the [English portfolio and current submission checklist](reports/english-2026-11-02/README.md).

The September selection criteria and status below are historical. In particular, the test sets are not completely untouched: early descriptive inspection and, for IPEDS, earlier probe overlap are disclosed in the updated individual supplements. Small residual ICC or fixed effects do not establish independent observations. The remaining team and submission prerequisites are listed in the current checklist.


Final project for **STA302H1 (Methods of Data Analysis I), University of Toronto, Fall 2026**.

This umbrella repository tracks how the topic was chosen, which candidates were tested and rejected, and three fully built candidate projects. Each candidate is its own repository and appears here as a git submodule under `projects/`. The group will choose one of the three for the final submission.

> 中文说明见 [README_zh.md](README_zh.md)。完整的中文方案汇总见 [docs/overview_zh.md](docs/overview_zh.md)。

## The three candidate projects

| | Project | Data | Unit / n | Response | Focal interaction | Part 1 R² | Final (Part 2) R² | Key finding |
|---|---|---|---|---|---|---|---|---|
| 1 | [`soc-new-home-prices`](projects/soc-new-home-prices) | U.S. Census Survey of Construction 2025 | new single-family home / 6,185 | sale price | floor area × Census division | 0.713 | 0.756 (log–log) | Extra floor area earns a smaller price premium in the Midwest (elasticity ≈ 0.53) than in the South and on the coasts (≈ 0.70–0.73); replicated on an independent 2024 sample |
| 2 | [`ntd-transit-ridership`](projects/ntd-transit-ridership) | FTA National Transit Database 2024 | transit agency / 2,135 | log annual ridership | log vehicle revenue hours × service type (fixed-route vs demand-response only) | 0.930 (log–log) | 0.935 | Ridership elasticity to service is 1.21 for fixed-route agencies (increasing returns, consistent with the Mohring effect) but 0.90 for demand-response-only agencies |
| 3 | [`ipeds-faculty-salary`](projects/ipeds-faculty-salary) | NCES IPEDS 2023 | four-year college / 1,070 | average faculty salary | log endowment per student × public/private nonprofit | 0.849 | 0.847 (log Y) | A 10× larger endowment per student goes with about 18.6% higher faculty pay at private nonprofits, but only about 2.4% (not significant) at public institutions |

Each project repository contains:

| Path | Contents |
|---|---|
| `Part1_Code.Rmd` | Required Part 1 submission code: cleaning from original data, variable summaries, the preliminary model, and the full residual analysis |
| `Part2_Analysis.Rmd` | Part 2 working analysis on the training set only: transformations, VIF, influence diagnostics, variable selection, final model, robust and clustered SEs, confounding checks |
| `proposal/` | English Part 1 proposal (md/html/pdf) and a paragraph-by-paragraph Chinese translation |
| `design/` | Full research design, in Chinese |
| `data/` | Original and cleaned data, plus the fixed train/test split |
| `verification/` | R-vs-Python numerical cross-check |
| `probe/` | The original exploratory Python probe, kept for provenance |
| `docs/` | TODO, decisions and changelog |

## How the topic was chosen

The group's selection criteria were:

- **Course requirements (Part 0 and Part 1).**
  - Open data with at least 1,000 rows.
  - At least 9 predictors, including at least one categorical and one numerical predictor.
  - An interaction between a categorical predictor and another predictor.
  - Documented data collection.
  - Three peer-reviewed sources.
- **Strictly i.i.d. cross-sectional data.**
  - No time series or panel data; one independent unit per row.
  - Residual intraclass correlation (ICC) below 0.05 within natural clusters.
  - The interaction stays significant with cluster-robust standard errors.
  - Moran's I checked for geographic units.
- **A meaningful fit.**
  - Training R² of at least 0.50.
  - The focal predictors add ΔR² of at least 0.02.
  - Moving the focal X from its 10th to its 90th percentile changes Y by at least 0.25 SD.
  - Interaction p < 0.01, and still significant with HC3 standard errors.
  - The interaction survives the most plausible alternative interactions.
  - No mechanical or identity relationships between Y and X.
- **Test-set discipline.**
  - The 70/30 split (seed 302) was fixed before any modelling.
  - All probing used only the training set.

About 29 candidates were tested by three parallel search groups; 3 qualified. See [`docs/search/`](docs/search) for the candidate registry, each group's report and the failure log.

## Repository map

```
.
├── README.md / README_zh.md
├── docs/
│   ├── overview_zh.md                 full Chinese write-up of all three projects
│   ├── course_requirements_summary.md our own summary of the Part 0/1 requirements
│   ├── decisions.md                   cross-project decisions (made and pending)
│   ├── todo.md                        what is left before submission
│   ├── changelog.md
│   └── search/                        candidate registry, group reports, failure logs
├── projects/                          three submodules (one repo per candidate)
│   ├── soc-new-home-prices/
│   ├── ntd-transit-ridership/
│   └── ipeds-faculty-salary/
└── scripts/publish_to_github.sh       creates the GitHub repos and wires the submodules
```

## Getting started

```bash
git clone --recurse-submodules https://github.com/heaven999b/sta302-research-project.git
```

To reproduce a project, open its folder in RStudio (R ≥ 4.3, with the packages `car`, `sandwich` and `lmtest`). Knit `Part1_Code.Rmd` first, then `Part2_Analysis.Rmd`. Each project README gives the details.

## Status

- All three projects are built.
  - Both R Markdown files knit.
  - R results match the exploratory Python probe.
  - Proposal drafts are within the word limits.
- **Pending:** choose one project, add group information, adapt the ethics section to the Module 3 terminology, and check the literature summaries against the original papers. See [docs/todo.md](docs/todo.md) and [docs/decisions.md](docs/decisions.md).

## Data and integrity notes

- All datasets are U.S. federal government data in the public domain. No personal information is included.
- Course handouts are **not** included in this repository.
- The test sets have never been used for modelling. Each project keeps its final test-set validation in a chunk with `eval = FALSE`, to be run once at the end of Part 2.
