---
name: standup
description: Daily standup preparation. Auto-load when asked to prepare standup notes, summarize yesterday's work, or plan today's tasks.
disable-model-invocation: true
argument-hint: "[optional: paste recent git log or ticket list]"
---

# Daily Standup Prep

Based on the provided context (git log, ticket list, or description), prepare concise standup notes.

## Format

```
Yesterday:
- [What was actually completed — specific, not vague]
- [Merged/committed/deployed — concrete outcomes]

Today:
- [Specific task or ticket you're working on]
- [Expected output by end of day]

Blockers:
- [None / Specific blocker with who can unblock it]
```

## Rules for Good Standups

**Yesterday** — report outcomes, not activity:
- ❌ "Worked on the auth feature" (activity)
- ✅ "Implemented JWT refresh token rotation, PR #42 up for review" (outcome)

**Today** — be specific enough to detect drift:
- ❌ "Continuing on the backend" (too vague)
- ✅ "Adding rate limiting to /auth/login, targeting PR by EOD" (specific)

**Blockers** — name the dependency:
- ❌ "Blocked on some config stuff" (vague)
- ✅ "Blocked on DB credentials for staging — need @devops to share" (actionable)

## If Git Log Is Provided

Summarize commits into human-readable outcomes. Group related commits.
Filter out noise: merge commits, typo fixes, minor chores.
Translate technical commit messages to what was accomplished.

## Keep It Under 3 Minutes

The standup is a sync, not a status report. Surface blockers, not details.
Details go in the PR, ticket comment, or 1:1.
