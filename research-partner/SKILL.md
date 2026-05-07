---
name: research-partner
description: Use when you need to research a topic — look into competitor patterns, technical approaches, how something works, or answer focused factual questions
---

## 1. Scope

Ingest the research question from `$ARGUMENTS`. Scan CWD for context related to the topic: code, docs, existing `*_research.md` artifacts in the artifact directory, plans, and recent commits. Read what's relevant — don't deep-read everything. If a prior artifact already answers the question, surface it instead of re-researching.

Classify depth:

- **Quick lookup** — factual question with a clear answer. Skip straight to Investigate (no stop).
- **Landscape survey** — mapping approaches, competitors, or patterns across a space.
- **Deep dive** — thorough investigation of a specific technique, tool, or domain.

For **landscape** or **deep dive**: present the scope (what's in, what's out, breadth of investigation) and **stop — wait for user confirmation** before proceeding.

For **quick lookup**: proceed directly to Investigate with no stop.

## 2. Investigate

Conduct research using available tools — web search, web fetch, codebase scan, whatever fits the question. Work iteratively: follow leads, cross-reference sources, and fill gaps.

**Visual detection:** If the topic has a visual dimension (products, UIs, competitor interfaces), ask once early:

> "This research has a visual component — want me to try capturing screenshots/images as I investigate?"

If yes: best-effort capture as you hit relevant sources. Track what succeeded and what was blocked (auth walls, bot protection). Capture failures don't block text research. One consent gate, not per-source.

Organize findings by **theme or approach**, not by source. Group related information together even if it came from different places.

If findings shift the question, pause and restate the adjusted scope before continuing. Don't let the investigation silently drift.

Know when to stop: if the last 2-3 sources are confirming what you already found without adding new dimensions, move to Synthesize.

## 3. Synthesize

Structure findings into a summary:

- **Question** — the research question as scoped
- **Findings** — organized by theme, with specifics (names, numbers, patterns — not vague summaries)
- **Key takeaways** — 2-5 bullets distilling what matters most
- **Implications for this project** — if project context exists, connect findings to the current work
- **Sources** — where applicable

**Visual results** (only if visual capture was enabled during Investigate):
- Which sources had screenshots/images captured successfully
- Which were blocked and why (auth wall, bot protection, etc.)
- For blocked sources, note alternative paths if obvious (e.g., "marketing page accessible, dashboard behind login")

**Drill-down suggestions:** After presenting findings, identify 3 interesting threads that emerged and present as labeled options. Example from a run researching agentic marketing platforms:

> Angles worth digging deeper on:
> - **A)** The production-observability gap — why reasoning traces disappear after launch across all five platforms
> - **B)** Mutiny's $5k/day autonomous-spend threshold — how it was chosen and whether it's configurable per account
> - **C)** The Clay $12k overage incident and what spend-capping primitives Clay has shipped since
> - **D) Save and move on** — findings are sufficient as-is

Options must name specific things from the findings — a company, a feature, a number, a surprising pattern, a gap. If you'd write "dig deeper into X" where X is a generic category ("pricing", "features", "architecture"), you're not drilling down — stop and find the specific thing worth exploring instead. Visual follow-ups (retrying blocked captures, finding alternative image sources) belong in the Visual results section, not as drill-down options — drill-downs are for content threads.

If the user picks A/B/C: loop back to Investigate with the narrowed scope. Visual consent carries forward — don't re-ask. On the next Synthesize, integrate drill-down findings into the original themes and offer a fresh set of drill-down options.

If the user picks D: proceed to Save.

## 4. Save

Save to `<descriptive-name>_research.md` in the artifact directory, with:

- H1 title: `# Research: <title>` summarizing the research question
- Date
- Full structured findings from Synthesize

When drill-down loops occurred, the saved artifact reflects all accumulated research. Integrate drill-down findings into the appropriate theme sections — don't append as separate "Round 2" sections. The artifact should read as a single coherent research document.

The artifact must be **self-contained** — readable without conversation context.

**Anti-pattern: "I'll just start searching."** The temptation to skip scoping is strongest when the question feels obvious. But unscoped research sprawls — you end up with a pile of links organized by when you found them, not by what they mean. Even a one-line scope ("Quick lookup: what's the max payload size for X?") keeps the investigation focused.

## Artifact Directory

Skills save artifacts to the configured artifact directory. To configure, add `Artifact directory: <path>` to your project's CLAUDE.md. Default: `artifacts/`. Create the directory if it doesn't exist. When scanning for existing artifacts, check the artifact directory and one level of subfolders. Before writing, check if an artifact already exists at the target path — read it and reflect awareness of prior work.

## Rules

- Be direct. No preamble, no filler. Labeled bullets for discrete items, prose for narrative.
- Quote sources, don't summarize — the user needs to see exactly what you're referencing.
- Organize by theme, not by source. The user cares about the landscape, not which URL said what.
- Quick lookups should be fast — don't over-structure a factual answer.
- Landscape surveys and deep dives earn their depth. Don't pad with shallow findings to look thorough.
- If research turns up nothing useful, say so. Don't dress up thin results.
- Artifacts must be self-contained. Someone reading the file with no conversation context should understand the findings.
- If research reveals a decision point, note it — the user may want to reason through it next. If findings open up a solution space, note that too — exploring directions may be a natural next step.

$ARGUMENTS
