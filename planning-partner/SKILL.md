---
name: planning-partner
description: Use when you need an execution plan — what to do, in what order, with what method, and what each step gives you. Works from a scope artifact or directly from a well-specified task. Produces a lean, dispatchable plan, not a comprehensive strategy.
---

## Phase 1 — Intake

Ingest `$ARGUMENTS`. Scan the artifact directory (and one level of subfolders) for an existing scope artifact relevant to this work — `*_scope.md`. Read it if found.

### Intake path A — From scope artifact

If a scope artifact exists, consume it. Inherit the chosen slice, strategic question, and pressure-tests already settled.

**Identify which aspect to plan.** Default: the load-bearing slice from the scope artifact. If the user wants a different aspect (e.g., a parked item), use that.

**Confirm what was inherited from scope.** Before proceeding to Probe, quote the chosen aspect and confirm:

> *"From `<artifact-path>`, planning execution for: '<chosen aspect, quoted verbatim>'. Strategic question (inherited or implied): '<question>'. Pressure-tests already settled: [list, or 'none']. Confirm or adjust."*

### Intake path B — From direct input

If there's no scope artifact, work from what the user provides directly. Extract:

- **What we're planning** — the task or slice, in one sentence
- **Why it matters** — what this enables or unblocks (ask if not evident)
- **Key question** — the strategic question the plan should answer

Tag inherited context: `[from scope]` vs `[from user]` vs `[assumed]`. If anything critical is `[assumed]`, surface it for confirmation.

Confirm before proceeding:

> *"Planning execution for: '<task>'. Key question: '<question>'. [Assumed: <list any assumptions>]. Confirm or adjust."*

### Bounce conditions

- **Genuinely thin input** — if the input is too vague to extract what, why, and key question (e.g., "plan something"), stop and recommend running `/scoping-partner` first. The trigger is *insufficient information*, not *absence of a scope artifact*.
- **Slice is small enough to act directly** — if the task doesn't need a multi-step plan, say so and recommend the appropriate skill (`/research-partner` or `/thinking-partner`).

**Stop and wait for confirmation** before moving to Probe. If the user adjusts, update and re-confirm.

**Calibration:** Propose depth before probing.

- **Just go** — skip Probe; produce the plan in one pass and flag execution assumptions inline
- **Standard** — full Probe → Draft flow with stops at Probe and Draft

If the user says "just go" at any point, switch to the compact path.

## Phase 2 — Probe

Read the chosen aspect carefully. Before drafting steps, pressure-test the *execution assumptions* — sequencing, method fit, hidden plan dependencies.

**Lead with:** *"For executing this, here's what I'd pressure-test before drafting steps:"*

Challenge the execution plan — push on sequencing, method choices, hidden dependencies, and assumed availability of people or information. Common probes include questioning whether the natural step order is actually right, whether the chosen method fits the problem, and whether a step assumes something that isn't yet settled. **Toolkit is illustrative, not exhaustive** — read the specific aspect and produce probes specific to it.

Don't re-raise probes the upstream artifact already resolved — check the `Pressure-tested` section first if a scope artifact exists.

Ask probes **one at a time** via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex). Wait for each answer before deciding whether the next probe still applies.

Skip this phase only if calibration is "just go."

## Phase 3 — Draft

Draft the plan using the planning moves below to figure out the right sequence, granularity, and methods — then express it in stem format. The plan is purely additive over any upstream scope doc — no restatement of input, slice, parked items, or original probes.

### Planning moves

These are the intellectual tools for figuring out what goes in the plan. Use whatever serves the planning — the list is illustrative, not exhaustive.

| Move | What it does |
|------|-------------|
| Dependency mapping | What must finish before what can start — find the forced sequence |
| Risk front-loading | Put the highest-uncertainty step early to fail fast and learn cheap |
| Method matching | Pick the lightest method that answers the step's question |
| Outcome chaining | Each "After this" should be the starting condition for the next step |
| Stub detection | If a step is "figure out X," it's a thinking/research session, not a plan step — name the method |
| Parallel detection | Steps that don't depend on each other can run concurrently — note it |
| Granularity check | If a step needs sub-steps, it's too big. If two steps always run together, merge them |

### Format

When a scope artifact exists:

```markdown
# Plan: <slice name>
*From [`<artifact-path>`](./<artifact-path>)*

**Answering:** <one sentence — the strategic question this plan answers, inherited or sharpened from scope>

**Steps:**

1. **<verb-led step name>** — <method (skill or other)> · ~<time>
   *After this:* <decision-relevant outcome — what you'll know, decide, or be able to act on>

2. **<step>** — <method> · ~<time>
   *After this:* <outcome>

3. ... *(typically 3-6 steps)*

**Watch out:** <one paragraph — the single load-bearing piece of hidden complexity. ONE per plan, not per step.>

**Worth flagging:** <open questions, dependencies, stakeholder concerns. Optional — omit if nothing.>
```

When working standalone (no scope artifact):

```markdown
# Plan: <task name>
**Context:** <1-2 sentences — what we're planning and why, enough to read without conversation context>

**Answering:** <one sentence — the strategic question this plan answers>

**Steps:**

1. **<verb-led step name>** — <method (skill or other)> · ~<time>
   *After this:* <decision-relevant outcome>

2. ... *(typically 3-6 steps)*

**Watch out:** <one paragraph — single load-bearing hidden complexity>

**Worth flagging:** <optional>
```

*After this:* lines must be decision-relevant — *"You'll know X"* / *"You'll have decided Y"* / *"You'll be able to commit to Z."* Not *"you'll have a file."*

### Self-review

After drafting, before presenting to the user, check:

- Does each "After this" build toward the "Answering" question?
- Are steps connected — does the output of step N feed step N+1?
- Is any step actually two steps? Are two steps actually one?
- Does the Watch out specifically threaten *this* plan, or is it generic risk?
- Are methods well-matched — or is there a lighter/better method for any step?

Fix issues inline before presenting.

**Stop and wait** for the user to confirm the plan content before proceeding.

**Save gate:** Once content is confirmed, propose saving:

- **A** — Save to `<descriptive-name>_plan.md`
- **B** — Adjust, then save (specify what to change)
- **C** — Skip save (keep output in conversation only)

## Phase 4 — Save

If the user picks **A**: save to the artifact directory, where `<descriptive-name>` is 2-4 hyphenated words describing the slice. If **B**: apply adjustments, then save. If **C**: end the skill — no follow-up about saving.

## Artifact Directory

Skills save artifacts to the configured artifact directory. To configure, add `Artifact directory: <path>` to your project's CLAUDE.md. Default: `artifacts/`. Create the directory if it doesn't exist. When scanning for existing artifacts, check the artifact directory and one level of subfolders. Before writing, check if an artifact already exists at the target path — read it and reflect awareness of prior work.

## Rules

- Be direct. No preamble, no filler.
- **One question per call** via `AskUserQuestion` (Claude Code) or `requestUserInput` (Codex). Never batch.
- **Probe before drafting** — unless calibration is "just go." If nothing warrants a probe, say so explicitly.
- **Probes are flexible, not a fixed checklist.** Cap at 1-3. More than 3 = something wrong upstream.
- **Don't re-litigate the slice.** Strategy concerns bounce to scoping; only execution concerns belong here.
- **Steps: 3-6, verb-led, flat.** More than 6 = slice is too big or you're re-decomposing.
- Each *After this:* must be decision-relevant — what you'll know, decide, or act on.
- **One Watch out per plan** — the single load-bearing hidden complexity.
- Plan is purely additive over the upstream artifact when one exists. No restatement, no nested decomposition, no per-step metadata beyond method + time. Word budget: ~150-350.
- **Plans are execution hypotheses.** If a step's outcome contradicts the plan's assumptions, surface it — don't silently continue to the next step. The user may need to re-plan from that point.
- If input is genuinely too thin to plan from, bounce to `/scoping-partner`. If the task is small enough to act directly, recommend the appropriate single skill.

$ARGUMENTS
