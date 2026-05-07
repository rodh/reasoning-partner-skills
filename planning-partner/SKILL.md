---
name: planning-partner
description: Use when you have a scope artifact with a chosen aspect (slice or parked item) and need an execution plan — what to do, in what order, with what method, and what each step gives you. Produces a lean, dispatchable plan, not a comprehensive strategy.
---

## Phase 1 — Intake

Ingest `$ARGUMENTS`. Scan the artifact directory (and one level of subfolders) for an existing scope artifact relevant to this work — `*_scope.md`. Read it.

**Planning-partner consumes a scope artifact and a chosen aspect — it does not re-derive them.**

**Bounce conditions:**

- **No scope artifact + thin input** — if there's no scoping artifact and the input is too thin to plan from, stop and recommend running `/scoping-partner` first.
- **Slice is small enough to act directly** — if the slice doesn't need a multi-step plan, say so and recommend the appropriate skill (`/research-partner`, `/thinking-partner`, or `/ideation-partner`).

**Identify which aspect to plan.** Default: the load-bearing slice from the scope artifact. If the user wants a different aspect (e.g., a parked item), use that.

**Confirm what was inherited from scope.** Before proceeding to Probe, quote the chosen aspect and confirm:

> *"From `<artifact-path>`, planning execution for: '<chosen aspect, quoted verbatim>'. Strategic question (inherited or implied): '<question>'. Pressure-tests already settled: [list, or 'none']. Confirm or adjust."*

**Stop and wait for confirmation** before moving to Probe. If the user adjusts, update and re-confirm.

**Calibration:** Propose depth before probing.

- **Just go** — skip Probe; produce the plan in one pass and flag execution assumptions inline
- **Standard** — full Probe → Draft flow with stops at Probe and Draft

If the user says "just go" at any point, switch to the compact path.

## Phase 2 — Probe

Read the chosen aspect from the scope artifact carefully. Before drafting steps, pressure-test the *execution assumptions* — sequencing, method fit, hidden plan dependencies.

**Lead with:** *"For executing this aspect, here's what I'd pressure-test before drafting steps:"*

Challenge the execution plan — push on sequencing, method choices, hidden dependencies, and assumed availability of people or information. Common probes include questioning whether the natural step order is actually right, whether the chosen method fits the problem, and whether a step assumes something that isn't yet settled. **Toolkit is illustrative, not exhaustive** — read the specific aspect and produce probes specific to it.

Don't re-raise probes the upstream artifact already resolved — check the `Pressure-tested` section first.

Ask probes **one at a time** via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex). Wait for each answer before deciding whether the next probe still applies.

Skip this phase only if calibration is "just go."

## Phase 3 — Draft

Draft the plan in **stem format**. The plan is purely additive over the scope doc — no restatement of input, slice, parked items, or original probes.

### Format

```markdown
# Plan: <slice name>
*From [`<artifact-path>`](./<artifact-path>)*

**Answering:** <one sentence — the strategic question this plan answers, inherited or sharpened from scope>

**Steps:**

1. **<verb-led step name>** — <method (skill or other)> · ~<time>
   *After this:* <decision-relevant outcome — what you'll know, decide, or be able to act on>

2. **<step>** — <method> · ~<time>
   *After this:* <outcome>

3. ... *(typically 3–6 steps)*

**Watch out:** <one paragraph — the single load-bearing piece of hidden complexity. ONE per plan, not per step.>

**Worth flagging:** <open questions, dependencies, stakeholder concerns. Optional — omit if nothing.>
```

*After this:* lines must be decision-relevant — *"You'll know X"* / *"You'll have decided Y"* / *"You'll be able to commit to Z."* Not *"you'll have a file."*

**Stop and wait** for the user to confirm before saving.

## Phase 4 — Save

Save to `<descriptive-name>_plan.md` in the artifact directory, where `<descriptive-name>` is 2–4 hyphenated words describing the slice.

## Artifact Directory

Skills save artifacts to the configured artifact directory. To configure, add `Artifact directory: <path>` to your project's CLAUDE.md. Default: `artifacts/`. Create the directory if it doesn't exist. When scanning for existing artifacts, check the artifact directory and one level of subfolders. Before writing, check if an artifact already exists at the target path — read it and reflect awareness of prior work.

## Rules

- Be direct. No preamble, no filler.
- **One question per call** via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex). Never batch.
- **Probe before drafting** — unless calibration is "just go." If nothing warrants a probe, say so explicitly.
- **Probes are flexible, not a fixed checklist.** Cap at 1–3. More than 3 = something wrong upstream.
- **Don't re-litigate the slice.** Strategy concerns bounce to scoping; only execution concerns belong here.
- **Steps: 3–6, verb-led, flat.** More than 6 = slice is too big or you're re-decomposing.
- Each *After this:* must be decision-relevant — what you'll know, decide, or act on.
- **One Watch out per plan** — the single load-bearing hidden complexity.
- Plan is purely additive over the upstream artifact. No restatement, no nested decomposition, no per-step metadata beyond method + time. Word budget: ~150–350.
- If no upstream artifact and input is thin, bounce to `/scoping-partner`. If slice is small enough to act directly, recommend the appropriate single skill.

$ARGUMENTS
