---
name: task-breakdown
description: Break down large features and user stories into implementable tasks. Auto-load when given a vague requirement, epic, or feature request that needs to be decomposed into actionable work items.
disable-model-invocation: true
argument-hint: "[feature description or user story]"
---

# Task Breakdown

Take the provided feature/requirement and decompose it into concrete, implementable tasks.

## Output Format

For each task:
```
[ ] Task title (verb + noun — e.g., "Add rate limiting to login endpoint")
    Why: [one sentence — what value this delivers]
    Acceptance criteria:
      - [Specific, testable condition 1]
      - [Specific, testable condition 2]
    Estimated size: XS / S / M / L / XL
    Dependencies: [task IDs this blocks on, or "none"]
    Risk: [known uncertainty or technical risk]
```

## Size Reference

```
XS  — < 2 hours  (single function, config change, simple bug fix)
S   — half day    (small feature, clear spec, no unknowns)
M   — 1-2 days   (moderate feature, some uncertainty)
L   — 3-5 days   (significant work, multiple components)
XL  — > 5 days   → MUST be broken down further (too large to estimate safely)
```

## Breakdown Approach

1. **Identify layers**: UI → API → Business Logic → Data → Infrastructure
2. **Find the walking skeleton**: What's the minimum end-to-end slice that could ship?
3. **Separate spikes**: Technical uncertainty? Create a time-boxed investigation task first
4. **Order by dependency**: What must be done before what?
5. **Tag cross-cutting concerns**: Auth, logging, error handling, tests, migrations

## What Makes a Good Task

- **Independently deployable** (or close to it)
- **Testable** — has clear pass/fail criteria
- **Assigned to one person** — not "the team"
- **Completable in ≤ 2 days** — longer = break it down
- **Not dependent on "it depends"** — if uncertain, spike first

## Output Structure

Always end with:
1. **Recommended order** — which tasks to do first and why
2. **Critical path** — which tasks block the most other work
3. **MVP slice** — minimum tasks needed to have something usable
4. **Open questions** — things you need product/design/stakeholder input on before starting

## Example

Input: "Add user authentication to the app"

Output:
```
[ ] T1: Design auth data model (users, sessions tables)
    Why: All other tasks depend on this schema
    Criteria: Schema reviewed, migration written
    Size: S | Deps: none | Risk: Low

[ ] T2: Implement password hashing with bcrypt
    Why: Core security primitive needed before any auth flow
    Criteria: Unit tests pass, timing-safe comparison verified
    Size: XS | Deps: T1 | Risk: Low

[ ] T3: Build POST /auth/register endpoint
    ...

[ ] T4: Build POST /auth/login endpoint (returns JWT)
    ...

[ ] T5: Build JWT verification middleware
    ...

[ ] T6: Implement refresh token rotation
    ...

[ ] T7: Build POST /auth/logout endpoint
    ...

[ ] T8: Add rate limiting to auth endpoints
    ...

[ ] T9: Write integration tests for full auth flow
    ...

Recommended order: T1 → T2 → T3 → T4 → T5 → T7 → T6 → T8 → T9
Critical path: T1 (blocks everything)
MVP slice: T1, T2, T3, T4, T5 — basic login/register
Open questions: Session length? MFA required? Social login?
```
