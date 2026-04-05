# /insights

The `/insights` command displays a summary of feedback Claude has collected during your sessions — things it noticed about your preferences, corrections you made, and patterns in how you work.

## What it shows

- **Feedback Claude remembered** — corrections or confirmations you gave during past sessions that were saved as memory
- **Behavioral patterns** — recurring preferences Claude has inferred from your interactions
- **Memory-backed insights** — entries sourced from the persistent memory system (`~/.claude/projects/.../memory/`)

## How it works

Claude Code passively observes your interactions: when you correct it, accept an unusual approach, or explicitly tell it to remember something, those signals are stored as memory files. `/insights` surfaces those records in a readable summary.

## When to use it

- To audit what Claude thinks it knows about you
- Before starting a new project — verify that remembered preferences still apply
- After a long session — confirm that important feedback was captured
- If Claude keeps behaving unexpectedly — check whether a stale insight is influencing it

## Relationship to memory

`/insights` reads from the same memory system that auto-memory writes to. If an insight is wrong or outdated, you can ask Claude to forget it or directly edit/delete the relevant file in the memory directory.

> Tip: pair `/insights` with `/memory` to get a full picture of what Claude is carrying into each session.
