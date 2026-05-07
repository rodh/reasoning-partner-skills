---
name: scoping-partner
description: Use when you have raw project context — PRDs, tickets, Slack threads, docs, screenshots, or verbal dumps — and need to understand the problem before starting work
---

# Scoping Partner

## Overview

Turns raw context into structured understanding, then converges on the load-bearing slice. Core principle: **probe the framing before decomposing, then propose what to work on first — don't map the whole space and leave the user to pick.**

## When to Use

- User drops raw context (ticket, PRD, Slack thread, screenshot, verbal dump) and needs to understand the problem
- User asks "what should I work on first?" or "break this down"
- Kicking off work where problem, users, and surface aren't yet aligned
- Need to figure out where complexity hides and what level of effort each part warrants

**When NOT to use:**
- Single focused question — use thinking-partner
- Already have a slice and need execution steps — use planning-partner
- Investigating a specific unknown — use research-partner

Create one task per phase; complete in order:

### Phase 1 — Parse & Gate

Extract what's stated. No interpretation yet. Assess whether you have enough to proceed — if not, ask one question per turn targeting the biggest gap. Include an escape hatch ("or just say go and I'll proceed with assumptions flagged").

Accept any format. Don't ask for reformatting.

**Calibration:** Propose depth before probing.

- **Just go** — skip Probe, produce sections and slice in one pass, flag assumptions inline
- **Standard** — full Probe → Sections → Slice flow with stops at Probe and Slice

### Phase 2 — Probe

Before decomposing, challenge the framing. **This is the deepest user-engagement moment — make it count.**

Lead with: *"Here's what I'm reading this as, and what I'd pressure-test:"*

Challenge the framing — push on scope boundaries, hidden assumptions, whether the ticket matches the real problem. Common probes include reframing what the ticket is really asking, questioning whether adjacent concerns are in or out of scope, surfacing unstated assumptions, and checking if the problem statement is too narrow or too wide. **Toolkit is illustrative, not exhaustive** — use these or others as the input demands.

**No cap on probes.** Raise every one that would meaningfully change the decomposition or slice. If nothing warrants pushback, say so explicitly and proceed.

Ask probes **one at a time** via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex). Wait for each answer before deciding if the next probe still applies.

Skip only if calibration is "just go."

### Phase 3 — Produce Sections

Produce the scoping artifact using the template below. Tag every inference `[assumed]` / `[inferred]` / `[implied]`. Default toward fewer items — 2-3 work surfaces, not 5-6.

**Above the divider** (always-read): Problem & Why Now, Work Surfaces, Strategic Questions, Slice, Next, Pressure-tested.

**Below the divider** (on-demand depth): Users & Jobs, Gaps & Clarifications, Effort Shape, Business Outcome & Metrics.

### Phase 4 — Propose Slice

**Do not ask the user what to focus on. Propose it.**

Pick the **load-bearing** part from the work surfaces — the one whose answer most changes what the rest become. Present:

- **The slice** — named clearly, one sentence
- **Why this one** — what it unblocks, what it teaches, what it defers
- **Parked** — other parts, each with a one-line note on why they wait

Then ask via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex) with labeled options:

- **A** — accept the slice, proceed
- **B** — different slice (pick from parked)
- **C** — adjust size (too big / too small)
- **D** — need the comprehensive version, not a slice

### Phase 5 — Next & Save

Recommend **one** next move — not a menu:

- `/planning-partner` — if slice warrants a multi-step execution plan
- `/thinking-partner` — if there's a decision or tradeoff inside the slice
- `/research-partner` — if there's a specific unknown to investigate

If the slice is small enough to just go, say so.

**Stop and wait** for user confirmation before saving.

Read `scope-template.md` for the artifact format and word budget. Save to `<descriptive-name>_scope.md` in the artifact directory.

## Artifact Directory

Skills save artifacts to the configured artifact directory. To configure, add `Artifact directory: <path>` to your project's CLAUDE.md. Default: `artifacts/`. Create the directory if it doesn't exist. When scanning for existing artifacts, check the artifact directory and one level of subfolders. Before writing, check if an artifact already exists at the target path — read it and reflect awareness of prior work.

## Rules

- Be direct. No preamble, no filler.
- **One question per call** via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex). Never batch.
- **Never narrate your assessment** — just ask the question.
- Quote sources, don't summarize. Steel-man all positions.
- Labeled options (A/B/C/D) at convergence. Probes can be open-ended.
- No scope inflation — surfaces must be necessary, not aspirational.
- Length ≠ clarity — check sufficiency regardless of input size.
- Don't produce sections without probing (unless calibration is "just go").
- Propose the slice. Don't map the whole space and let the user pick.
- If decomposition reveals research is needed first, say so.

$ARGUMENTS
