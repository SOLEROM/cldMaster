---
name: branch-strategy
description: Git branching strategy, conventions, and workflow. Background knowledge for branch naming, PR sizing, and workflow decisions.
user-invocable: false
---

# Branch Strategy Reference

Background knowledge applied automatically when making branching decisions.

## Naming Conventions

```
feat/TICKET-short-description      # new feature
fix/TICKET-short-description       # bug fix
hotfix/short-description           # critical production fix
release/v1.2.0                     # release preparation
chore/update-dependencies          # maintenance, no user-facing change
refactor/auth-module               # code restructure
```

Rules:
- Lowercase, hyphens only (no underscores, no slashes in the slug)
- Ticket number first when available (enables PR → ticket linking)
- Description is a noun phrase, not a verb ("user-auth" not "add-user-auth")
- Max 50 characters total

## Gitflow vs Trunk-Based

### Gitflow (feature branches + develop + main)
```
main ←─── release ←─── develop ←─── feature/X
                                  └── feature/Y
```
✅ When: multiple versions in production simultaneously, large teams, infrequent releases
❌ When: you release daily, small team, continuous deployment

### Trunk-Based Development (short-lived branches → main)
```
main ←─── feature/X (< 2 days)
     ←─── fix/Y     (< 1 day)
```
✅ When: continuous deployment, feature flags available, small-to-medium teams
❌ When: you need to maintain multiple release versions

**Recommendation for most teams:** Trunk-based development. Feature flags handle the "not ready for users" problem better than long-lived branches.

## PR Size Guidelines

| Size | Lines changed | Review time | Recommendation |
|------|--------------|-------------|----------------|
| XS | < 50 | < 5 min | Ideal |
| S | 50–200 | 10–20 min | Good |
| M | 200–500 | 30–60 min | Acceptable |
| L | 500–1000 | 1–2 hours | Split it |
| XL | > 1000 | Day+ | Always split |

**Why small PRs:** Reviewers give better feedback on small changes. Large PRs get "LGTM" to end the suffering.

**How to split large PRs:**
- Data layer first, then API, then UI
- Refactor first (no behavior change), then feature (behavior change)
- One concern per PR — don't mix unrelated fixes

## Merge Strategy

| Strategy | When to use |
|----------|------------|
| **Merge commit** | Preserving full context of a feature branch (clear when it landed) |
| **Squash and merge** | Cleaning up "WIP"/"fix typo" commits into one clean commit |
| **Rebase and merge** | Linear history preference, no merge commits |

**Rule of thumb:** Use squash for feature branches (clean main history), merge commit for release branches (preserve when each release landed).

## Branch Lifetime

| Branch type | Expected lifetime |
|-------------|------------------|
| Feature branch | < 2 days (trunk-based) or ≤ 1 sprint (gitflow) |
| Bug fix | < 1 day |
| Hotfix | Hours |
| Release branch | 1–3 days of stabilization |
| Long-lived | develop, main, staging — permanent |

Branches older than their expected lifetime accumulate merge conflicts. Set a calendar reminder at creation.

## Rebase vs Merge

```bash
# Rebase: "pretend my feature was written on top of current main"
git rebase main                # clean linear history
git rebase -i main             # interactive: squash, reorder, edit commits

# Merge: "bring main's changes into my branch, preserving both histories"
git merge main                 # merge commit created
```

**Rule:** Rebase private branches (not yet pushed). Merge public branches (already pushed — rebasing rewrites history and breaks collaborators).

## Feature Flags

Use feature flags instead of long-lived feature branches:
- Merge incomplete code to main behind a `FEATURE_X_ENABLED=false` flag
- Turn on for testing, turn off for rollback
- Delete the flag code when the feature is stable

This eliminates merge conflicts from long-lived branches entirely.
