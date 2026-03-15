---
name: pr-description
description: Generate a pull request description from branch changes. Use when opening a PR and wanting a professional, reviewer-friendly description.
disable-model-invocation: true
allowed-tools: Bash(git *)
---

# PR Description

Generate a PR description written for the reviewer's benefit, not the author's.

## Branch Context

**Commits in this branch:**
`!git log main..HEAD --oneline 2>/dev/null || git log origin/main..HEAD --oneline 2>/dev/null || git log HEAD~5..HEAD --oneline`

**Files changed:**
`!git diff main...HEAD --stat 2>/dev/null || git diff HEAD~5...HEAD --stat`

**Full diff (for context):**
`!git diff main...HEAD 2>/dev/null || git diff HEAD~5...HEAD`

---

## PR Template

```markdown
## Summary

[2-3 bullet points: what changed and WHY — not HOW]
- Added Redis session storage to reduce DB load on auth endpoints
- Replaced 3 duplicate auth middleware functions with a single configurable one

## Motivation

[The problem this PR solves. Why was this change needed?]
Auth endpoint database calls were causing 40% of our DB load at peak hours.
Redis session lookup is ~5ms vs ~80ms for DB, with the same correctness guarantees.

## Changes

**Feature:**
- `src/auth/session.ts` — new Redis-backed session store
- `src/middleware/auth.ts` — unified auth middleware

**Removed:**
- `src/middleware/authAdmin.ts`, `authUser.ts`, `authReadonly.ts` — consolidated

**Configuration:**
- `.env.example` updated with `REDIS_URL` requirement

## Testing

- [ ] Unit tests added for `RedisSessionStore` (7 new tests, all passing)
- [ ] Integration test: verified session persists across server restarts
- [ ] Load tested: 1000 req/s with no session errors
- [ ] Tested degraded mode: falls back gracefully when Redis is unavailable

## Screenshots

[For UI changes — before and after. Delete this section if not applicable.]

## Breaking Changes

⚠️ **BREAKING:** Requires `REDIS_URL` environment variable. Add it before deploying.

[If no breaking changes, delete this section.]

## Checklist

- [ ] Tests pass locally (`npm test`)
- [ ] No secrets or credentials in the diff
- [ ] `CHANGELOG.md` updated (if user-facing change)
- [ ] Documentation updated (if API or config changed)
- [ ] Works in staging environment
```

---

## Writing Principles

**For the reviewer, not the author:**
The reviewer doesn't know your thought process. Explain the "why" — they can read the code for the "what."

**Context makes reviews faster:**
A 2-minute read of a good PR description saves 20 minutes of reviewer confusion and back-and-forth questions.

**Honest testing section:**
Don't just say "tested." Say specifically what you tested and how. This builds confidence in the change.

**Flag breaking changes prominently:**
If the PR requires action from others (env var, config change, DB migration), put it at the top where it won't be missed.
