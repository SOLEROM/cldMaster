---
name: sprint-plan
description: Sprint planning assistant. Auto-load when planning a sprint, prioritizing a backlog, or estimating work for the next iteration.
disable-model-invocation: true
argument-hint: "[backlog items, team size, sprint length in days]"
---

# Sprint Planning

Given the backlog items and team context, produce a prioritized sprint plan.

## What to Produce

1. **Sprint Goal** — one sentence that describes what this sprint delivers
2. **Recommended sprint backlog** — prioritized list with estimates
3. **Capacity check** — total estimated days vs. available capacity
4. **Risk flags** — items with unclear scope, external dependencies, or large estimates
5. **Explicitly excluded** — what's NOT in this sprint and why

## Prioritization Framework

Evaluate each item on:

```
Value:    What business/user value does this deliver? (1-5)
Urgency:  How time-sensitive is this? (1-5)
Effort:   How much work is required? (1=small, 5=large)
Risk:     Unknown or external dependency? (1=low, 5=high)

Priority Score = (Value + Urgency) / (Effort × Risk)
Higher score = higher priority
```

## Capacity Rules

```
Available capacity = team_size × sprint_days × 0.7
(30% buffer for meetings, reviews, unexpected work, context switching)

Example: 3 devs × 10 days × 0.7 = 21 developer-days

Never plan to 100% — teams that plan to 100% miss every sprint.
```

## Item Sizing Reference

```
XS  = 0.25 dev-days  (tiny: config, copy change, 1-line fix)
S   = 0.5-1 dev-days (small: clear spec, no unknowns)
M   = 2-3 dev-days   (moderate: some uncertainty)
L   = 4-5 dev-days   (large: significant work — consider splitting)
XL  = 5+ dev-days    → split before sprint planning (too risky to commit)
```

## Sprint Backlog Format

```
Sprint Goal: [one sentence]

Sprint Backlog:
Priority | Item                              | Size  | Owner | Notes
---------|-----------------------------------|-------|-------|------
1        | JWT authentication                | M (3) | -     | Blocks items 3, 4
2        | User profile page                 | S (1) | -     |
3        | Protected route middleware         | XS    | -     | Requires item 1
...

Estimated total: X dev-days
Available capacity: Y dev-days
Buffer: Z dev-days (ok / tight / at risk)

Deferred to next sprint:
- [Item]: [reason — too large / low priority / blocked on external]

Risks:
- [Item 1] has external dependency on [team/vendor] — may slip
- [Item 2] has unclear requirements — needs design decision before work starts

Open questions for sprint kickoff:
- [Question 1]?
```

## Common Sprint Planning Mistakes

```
❌ Planning to 100% capacity → always misses
❌ Including items with unclear requirements → stops midway
❌ No sprint goal → team optimizes locally, not for shared outcome
❌ XL items not split → unfinishable work in progress at sprint end
❌ Ignoring tech debt → slows every future sprint
❌ No buffer for urgent bugs → unplanned work derails everything

✅ Reserve 20-30% for unplanned work
✅ Spike unknown items before committing
✅ One sprint goal that everything contributes to
✅ All items S or M before sprint starts
```

## Tech Debt Allocation

A healthy sprint includes 10-20% tech debt / engineering improvement:
- Reduces future sprint velocity loss
- Prevents morale erosion
- Keeps codebase healthy for new features

Label these clearly so stakeholders understand the tradeoff.
