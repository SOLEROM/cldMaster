---
name: code-review
description: Perform a thorough code review. Use when asked to review code, check a PR, or audit a file for quality issues.
argument-hint: [file-or-description]
---

# Code Review

Perform a systematic, thorough code review of the specified code. For each issue found, provide: location, what's wrong, why it matters, and a concrete suggested fix.

## Review Checklist

### 1. Readability & Naming
- Variable and function names are meaningful and pronounceable
- No single-letter variables outside of loop counters or math
- Functions do what their name says — no surprising side effects
- Constants are named (no magic numbers or strings)
- Abbreviations are avoided or explained

### 2. Function Design
- Each function has a single, clear responsibility
- Functions are short enough to understand at a glance (aim for < 30 lines)
- Arguments: prefer ≤ 3; if more, consider an options object
- No boolean flag parameters that change function behavior — split into two functions
- Pure functions preferred; side effects are explicit and documented

### 3. DRY & Code Reuse
- Logic is not duplicated across 3+ locations (rule of three)
- Abstractions exist when they reduce duplication, not preemptively
- Shared logic is in a utility that is actually reusable, not just extracted

### 4. Error Handling
- All error paths are handled — no silent failures
- Errors include enough context to debug (what failed, with what input)
- Errors are not swallowed in catch blocks without logging
- User-facing errors are friendly; developer-facing errors are detailed
- Async errors are caught (no unhandled promise rejections)

### 5. Edge Cases
- null / undefined inputs are handled
- Empty arrays, empty strings, zero values are tested
- Boundary conditions are correct (off-by-one errors)
- Concurrent execution is safe where relevant

### 6. Performance Red Flags
- No N+1 query patterns (loop + DB call)
- No synchronous I/O in async contexts
- No unnecessary re-computation inside tight loops
- Large data structures are not copied when mutation is fine
- Expensive operations are memoized or cached where appropriate

### 7. Security Basics
- User input is never directly interpolated into queries, commands, or HTML
- Secrets are not hardcoded or logged
- Authorization checks happen on the server, not just the client
- File paths constructed from user input are sanitized

### 8. Test Coverage
- New code has corresponding tests
- Tests cover the happy path AND error paths
- Tests are not testing implementation details (they test behavior)

---

## Output Format

For each issue found:

```
[SEVERITY] Category — Location
Problem: [What is wrong]
Why: [Why this matters / what could go wrong]
Fix: [Concrete suggestion or code snippet]
```

**Severity levels:**
- `[CRITICAL]` — Will cause bugs, security issues, or data loss
- `[HIGH]` — Likely to cause bugs under real conditions
- `[MEDIUM]` — Degrades maintainability or has edge-case risk
- `[LOW]` — Style, naming, or minor improvement

End with a summary:
- Total issues by severity
- One overall assessment sentence
- The single most important change to make first
