---
name: debug-smart
description: Systematic debugging workflow. Use when facing a bug you cannot immediately identify, when a fix didn't work, or when an error message is unclear.
argument-hint: [error-or-symptom]
---

# Debug Smart

Apply a scientific, systematic approach to debugging. The goal: find the root cause, not just suppress the symptom.

---

## The Scientific Method for Bugs

```
Observe → Hypothesize → Predict → Test → Conclude → Repeat
```

Never: change random things until it works. That's cargo cult debugging.

---

## Step 1: Reproduce Consistently

A bug you can't reproduce reliably is almost impossible to fix.

- What exact steps trigger it?
- Does it happen 100% of the time or intermittently?
- Is it environment-specific? (local only, prod only, specific browser, specific OS)
- Is it data-specific? (only with certain inputs)
- Is it timing-related? (race condition, slow network)

**If intermittent:** Add logging around the suspected area and wait for it to happen again. Do NOT guess — intermittent bugs without reproduction are 10x harder to fix.

---

## Step 2: Isolate

Binary search the codebase to find where the problem starts.

```
Is the bug in the frontend or backend?
  → Backend: is it in the controller or the service?
    → Service: is it in method A or method B?
      → Method B: is it in the first half or second half?
```

**Tools for isolation:**
- Comment out code sections (temporarily)
- Add `console.log` / `print` at boundaries
- Use a debugger to step through
- Write a failing unit test that reproduces the bug in isolation

---

## Step 3: Form a Hypothesis (Before Testing)

**Write down** what you think is causing the bug before you test it.

This prevents confirmation bias — our brains interpret ambiguous evidence as confirming our existing theory.

```
Hypothesis: The user's session expires before the timeout value suggests
because the token expiry is set in UTC but compared against local time.

Prediction: If I log both values, they will differ by the timezone offset.

Test: Add logging → compare UTC token expiry vs server's local time
```

---

## Step 4: Test One Thing at a Time

Change exactly ONE thing per test. If you change three things at once and the bug disappears, you don't know what fixed it — and you might have introduced a new bug.

**Bad:**
```diff
- const timeout = config.timeout;
+ const timeout = config.timeout ?? 30000;
+ const expiry = Date.now() + timeout;
+ await refreshToken();
```

**Good:** Change one line, observe result, then change the next.

---

## Step 5: Fix the Root Cause, Not the Symptom

```
Symptom: User gets logged out randomly
Symptom fix: Catch the logout error and re-login automatically
Root cause: Token refresh fails silently because fetch throws on network error
Root cause fix: Handle network errors in token refresh with proper retry logic
```

Ask: "Why did this happen?" at least 5 times (Five Whys).

---

## Debugging Tools by Context

| Context | Tool |
|---------|------|
| JavaScript | Browser DevTools → Sources tab → breakpoints |
| Node.js | `node --inspect` + Chrome DevTools, or VS Code debugger |
| Network | Browser DevTools → Network tab; check request/response bodies |
| SQL | Log the actual query with parameters; run it manually in DB client |
| React | React DevTools → Profiler; check props/state at the point of failure |
| CSS | Browser DevTools → Computed tab; check specificity, inheritance |
| Race condition | Add timestamps to all async operations; look for ordering assumptions |

---

## The Rubber Duck Checklist

Before asking for help, explain the problem to yourself (or an actual rubber duck):

1. What should the code do?
2. What does it actually do?
3. What did you expect to happen at each step?
4. Where does the actual behavior first diverge from expected?
5. What is the most recent change to this code?

Often, articulating the problem reveals the answer.

---

## Time-Boxing

If no progress after 25 minutes:
1. Step away (fresh eyes find bugs immediately)
2. Explain the problem to someone else
3. Search for the exact error message — someone else probably hit this
4. Check git blame — when was this code last changed and what changed?
5. Try reverting recent changes (git bisect for complex regressions)

---

## When You Find It

Document what you found:
- What was the root cause?
- What hid it from you initially?
- Is this pattern likely to appear elsewhere? → Write a test to prevent regression
