# Reasoning Partner Skills

AI agent skills for structured reasoning — think through decisions, research topics, scope problems, and plan execution.

## Skills

**`/thinking-partner`** — Think something through: a decision, a hunch, a tradeoff,
a strategy question, or anything that needs structured clarity before action.

**`/research-partner`** — Look into a topic: competitor patterns, technical approaches,
how something works, or focused factual questions. Produces self-contained research artifacts.

**`/scoping-partner`** — Build structured understanding from raw project context (tickets,
PRDs, Slack threads, docs, verbal dumps). Probes framing assumptions, decomposes
into work surfaces, and converges on the load-bearing slice to work on first.

**`/planning-partner`** — Take a chosen aspect from a scoping artifact and produce a
focused execution plan: sequenced steps, each with a method and a decision-relevant outcome.

### How they fit together

```
Scope — Plan
     |
Research · Thinking
```

## Install

```bash
DEST=~/.local/share/reasoning-partner-skills
[ -d "$DEST" ] && git -C "$DEST" pull --ff-only || git clone https://github.com/rodh/reasoning-partner-skills.git "$DEST"
"$DEST/install.sh"
```

### Other commands

```bash
./install.sh status      # Show what's linked where
./install.sh update      # git pull + re-install + prune stale links
./install.sh uninstall   # Remove all symlinks (leaves the clone intact)
```

## Usage

Invoke any skill by name — e.g., `/thinking-partner [describe what you're working through]`

Skills scan the working directory for existing artifacts and build on prior work automatically.
Artifacts are saved to `artifacts/` by default. To use a different directory, add
`Artifact directory: <path>` to your project's CLAUDE.md.
