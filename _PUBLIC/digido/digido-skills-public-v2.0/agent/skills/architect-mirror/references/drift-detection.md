# Drift Detection

## What Is Drift?

Drift = the gap between what the plan said would happen and what actually happened.

## Drift Levels

| Level | Description | Action |
|-------|-------------|--------|
| **None** | On plan, on time, no surprises | Continue as planned |
| **Minor** | Slightly behind or one task took longer | Note it, continue |
| **Moderate** | Multiple tasks behind or approach changed | Flag to user, suggest plan adjustment |
| **Significant** | Project is going in a different direction than planned | STOP — discuss with user before continuing |

## Common Drift Causes

| Cause | Detection Signal | Response |
|-------|-----------------|----------|
| Underestimated complexity | Task took 3x longer than expected | Re-estimate remaining tasks |
| Missing requirements discovered | New tasks keep appearing mid-build | Add to plan, re-sequence |
| Technical blockers | Debug cycles eating time | Assess: fix or work around? |
| Scope creep | User keeps adding "one more thing" | Flag it — "this is new scope" |
| Wrong approach | Architecture doesn't fit the problem | Stop early, pivot — don't force it |

## How to Detect Drift

Every mirror report, ask these questions:

```
1. Is the current task taking longer than expected?
   → If yes: why? Is this a one-time thing or a pattern?

2. Have new tasks appeared that weren't in the plan?
   → If yes: how many? Are they essential or nice-to-have?

3. Has the approach changed from the original plan?
   → If yes: was it a conscious decision or did it just happen?

4. Are we building what the user asked for?
   → If no: stop immediately and realign

5. Are blocked items growing?
   → If yes: what's the root cause of the blockage?
```
