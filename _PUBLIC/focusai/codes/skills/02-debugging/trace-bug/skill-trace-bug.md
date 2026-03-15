---
name: trace-bug
description: Trace a bug to its root cause using structured investigation. Use for persistent bugs, regressions, or when the same bug keeps reappearing.
argument-hint: [bug-description]
---

# Trace Bug to Root Cause

Apply a structured investigation to find and permanently fix the root cause.

---

## Five Whys

Keep asking "why" until you reach a cause that is actionable and preventable.

**Example:**
```
Bug: Users are getting logged out randomly.
Why? → The session is expiring unexpectedly.
Why? → The session token refresh is failing silently.
Why? → The refresh endpoint returns 401 when called concurrently.
Why? → Two requests fire simultaneously and both try to refresh the same token.
Why? → There's no mutex/lock preventing concurrent refreshes.

Root cause: Race condition in token refresh with no concurrency guard.
Fix: Implement a refresh lock (store in-flight promise, reuse it for concurrent calls).
Prevention: Add a test that fires two concurrent requests and verifies only one refresh occurs.
```

Don't stop at the first "why" — the first answer is usually a symptom, not a cause.

---

## Regression Investigation: git bisect

When a bug appears that wasn't there before, use `git bisect` to find the commit that introduced it.

```bash
# Start bisect
git bisect start

# Mark current state as bad
git bisect bad

# Mark a commit you know was good
git bisect good v1.2.0   # or a specific commit hash

# Git checks out a middle commit — test it
# If bad:
git bisect bad

# If good:
git bisect good

# Repeat until git identifies the culprit commit
# End bisect
git bisect reset
```

Once you find the culprit commit:
```bash
git show <commit-hash>   # See exactly what changed
git log <commit-hash>    # See the commit message
```

---

## git blame: Who Changed This and When

```bash
git blame src/auth/session.ts

# Output: each line with commit hash, author, date
# 3a1b2c4 (Alice 2024-11-15) const REFRESH_INTERVAL = 30000;
```

Click the commit hash to see the full change context.

```bash
# See the full commit that last touched a line
git show $(git blame -L 47,47 file.ts | awk '{print $1}')
```

---

## Hypothesis Log

Write hypotheses down BEFORE testing them. This prevents confirmation bias.

```markdown
## Bug: [description]

### Hypotheses
1. [ ] Race condition in token refresh (HIGH confidence)
   Test: Add mutex, observe if random logouts stop

2. [ ] Session storage being cleared by another tab (MEDIUM)
   Test: Test in single tab; test in private window

3. [ ] Token clock skew between client and server (LOW)
   Test: Log both timestamps; compare

### Testing Results
- Hypothesis 1: Added mutex → logouts stopped ✓ ROOT CAUSE
```

---

## Time-Boxing

If no progress in 25 minutes:
- [ ] Take a break (5-10 min)
- [ ] Explain it to someone else
- [ ] Google the exact error message in quotes
- [ ] Search internal Slack/issues for similar past reports
- [ ] Try reverting recent changes
- [ ] Add more logging and wait for it to happen again (for intermittent bugs)

---

## "Fix It Twice" Rule

Once you find the root cause:

1. **Fix the immediate bug**
2. **Fix the class of bug** — is this pattern present elsewhere?
3. **Write a regression test** — ensure it never comes back

```
Bug: userId was passed as string, compared with ===  to a number → always false
Fix 1: Coerce to number before comparison
Fix 2: Add TypeScript strict types to prevent string/number confusion
Fix 3: Write test: expect(getUserById('42')).toBe(getUserById(42))
```

---

## Output

1. Five Whys chain (minimum 3 levels deep)
2. Identified root cause
3. Proposed fix
4. Regression test to add
5. Are there similar patterns elsewhere? → Where to check
