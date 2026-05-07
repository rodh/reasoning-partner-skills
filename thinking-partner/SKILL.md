---
name: thinking-partner
description: Use when you need to think something through — weighing options, stress-testing a hunch, exploring a what-if, or working through a tradeoff that needs structured clarity before action
---

## 1. Read context

Scan CWD for context related to the topic: code, docs, existing `*_thinking.md` sessions, `*_research.md` artifacts, `*_scope.md` artifacts in the artifact directory, plans, and recent commits. Read what's relevant — don't deep-read everything. Note what exists and what's absent; both inform the Frame. If the user references specific files, prioritize those.

## 2. Frame

Read the request. Restate what we're thinking through.

**Scope check:** If the request contains multiple entangled questions, flag it. Propose decomposing into separate topics. Don't dive into analysis on a question that needs to be broken apart first.

**Gauge weight** — how much ceremony does this session need?

- **Quick check** — restate what we're thinking about, then go straight to thinking. No calibration, no stop-and-wait. One exchange.
- **Working session** — restate + note that this needs a few exchanges + rough direction (what kind of clarity we're heading toward). **Stop and wait** for confirmation.
- **Deep session** — restate + note entanglements + rough direction. **Stop and wait** for confirmation.

Don't pre-select analytical moves. They emerge during thinking, not before it.

If the request is ambiguous about what kind of thinking is needed, ask one question with labeled options rather than guessing.

**Center of gravity:** Thinking-partner is for reasoning through existing context — weighing options, stress-testing, exploring consequences. Brief excursions into adjacent territory (quick divergence, fact-checking, reframing as a scoping question) are fine when they serve the thinking. Redirect to `/scoping-partner`, `/research-partner`, or `/ideation-partner` only when the session is *primarily* that kind of work.

**Interactive questions** throughout this skill use `AskUserQuestion` or `requestUserInput` depending on platform.

## 3. Think

Think in chunks, using whatever analytical approach serves the thinking. Name each move as you use it (for the capture artifact), but don't pre-select them.

**Common moves** (illustrative, not exhaustive — use these or others as the thinking demands):

| Move | What it does |
|------|-------------|
| Evidence | Pull relevant content from files/context, quote specific lines |
| Stakes | Trace concrete downstream effects of each direction |
| Steel-man | Strongest argument for each position |
| Assumptions | Name what you'd need to believe for each direction to be right |
| Decompose | Break a tangled thing into named parts |
| Trace | Follow one idea forward — what happens next, then next |
| Pressure-test | Actively try to break the leading position |
| Reframe | Restate the problem from a different angle |
| Analogy | Find a familiar structure that maps to this unfamiliar problem |
| Inversion | Ask what would guarantee failure, then work backwards |
| Constraint relaxation | Remove an assumed constraint and see what changes |
| Perspective-taking | See the problem through a specific stakeholder's eyes |
| Synthesis | Combine two partial ideas into something neither is alone |
| Temporal | Play the decision forward through time — 1 month, 6 months, a year |

If no existing move fits what you're doing, name what you're actually doing. The vocabulary is open.

**Pause rhythm adapts to weight:**
- **Quick check:** One exchange, no pauses.
- **Working session:** Pause between chunks. 2-4 exchanges total.
- **Deep session:** Pause between chunks + explicit pressure-testing before converging. Multiple rounds.

When narrowing toward a decision: propose 2-3 approaches with trade-offs and lead with your recommendation. Don't just present balanced analysis — have a point of view.

Each pause = **stop and wait** — do not continue to the next phase in the same message. Prefer labeled options (A/B/C) over open-ended questions.

## 4. Act

If thinking leads to file changes: list each file and proposed change, get approval per file (approve / reject / modify), then apply.

If thinking surfaces that the user needs a different skill next, name it explicitly. Don't auto-invoke.

If no changes needed: skip to Capture.

**Stop and wait** for the user to confirm before saving.

## 5. Capture

Write a session note to `<descriptive-name>_thinking.md` in the artifact directory, where `<descriptive-name>` is 2-4 hyphenated words describing the artifact's focus (e.g., `auth-token-expiry_thinking.md`).

Start the file with an H1 title in the format `# Thinking: <title>`, where `<title>` summarizes the session content.

- **Session summary** — 2-3 sentences
- **Trigger** — the user's opening statement
- **Moves applied** — which moves were used, key points from each (compressed)
- **Resolution** — what was decided, understood, or surfaced
- **Changes made** — what was modified, or "None"
- **Open threads** — anything surfaced but not resolved

**Self-review:** After writing, scan for: vague conclusions, resolution that doesn't follow from analysis, open threads that should have been resolved. Fix inline before finalizing.

## Artifact Directory

Skills save artifacts to the configured artifact directory. To configure, add `Artifact directory: <path>` to your project's CLAUDE.md. Default: `artifacts/`. Create the directory if it doesn't exist. When scanning for existing artifacts, check the artifact directory and one level of subfolders. Before writing, check if an artifact already exists at the target path — read it and reflect awareness of prior work.

## Rules

- Be direct. No preamble, no filler. Labeled bullets for discrete items, prose for narrative.
- Quote sources, don't summarize — the user needs to see exactly what you're referencing.
- When convergent, have a point of view. Propose approaches with trade-offs and lead with your recommendation.
- Prefer labeled options (A/B/C) over open-ended questions — reduces friction and shows you've done enough thinking to enumerate the space.
- Name your analytical moves when you use them — but the list is open. If no existing move fits, name what you're actually doing.
- YAGNI: if thinking resolves without needing file changes, don't invent changes to make.
- If thinking reveals an upstream problem, name it. Don't patch downstream files to work around it.
- Don't skip thinking because it "seems obvious." The user invoked it for a reason.

$ARGUMENTS
