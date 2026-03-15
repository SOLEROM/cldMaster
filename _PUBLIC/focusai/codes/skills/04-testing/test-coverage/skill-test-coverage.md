---
name: test-coverage
description: Improve test coverage meaningfully. Auto-load when coverage reports are below threshold or when asked to improve test coverage.
---

# Test Coverage

Coverage numbers are a proxy metric. The goal is confidence, not a percentage.

## Coverage Types — Which One Actually Matters

| Type | What it measures | Value |
|------|-----------------|-------|
| **Branch** | Both sides of every if/else/ternary | **Most useful** |
| **Function** | Was this function called? | Easy to game |
| **Line/Statement** | Were these lines executed? | Weakest signal |

**Branch coverage is what matters.** 100% line coverage can miss entire execution paths:

```js
function getDiscount(user) {
  return user.isPremium ? 0.2 : 0;  // 100% line coverage if called once
  // But you may never test the premium=false branch
}
```

## Why 100% Is Wrong

Chasing 100% produces: trivial tests, tests of framework boilerplate, slow suites with no additional confidence.

**Right targets by code type:**

| Code | Target branch coverage |
|------|------------------------|
| Business logic / domain | 90–95% |
| API route handlers | 80–90% |
| UI components | 60–70% |
| Configuration / constants | 0% |
| Generated code (Prisma, GraphQL) | 0% |
| Error handling paths | 100% |

## Coverage-Driven Testing Workflow

```bash
# Run coverage
npx jest --coverage --coverageReporters=lcov,text
npx vitest run --coverage
pytest --cov=src --cov-report=html
```

**For each uncovered branch, ask:**
1. *Why would this branch trigger in production?*
2. If "a real scenario users can reach" → write the test
3. If "defensive code that's theoretically impossible" → decide based on risk

## Write Scenarios, Not Lines

**Bad:** "Line 47 is uncovered. I will write a test that reaches line 47."

**Good:** "Line 47 is the catch block for DB connection errors. When DB is unreachable, the service should return 503. I'll simulate DB failure and assert the 503."

## Verify Tests Catch Regressions

Before accepting a new test:
1. Write the test
2. Deliberately break the code it covers
3. Confirm the test fails
4. Restore the code
5. Confirm the test passes

If you can't make a test fail by breaking the code, it's not testing anything real.

## Legitimate Exclusions

```js
/* c8 ignore next 3 */
// Development-only: tested manually
if (process.env.NODE_ENV === 'development') {
  enableDebugPanel();
}
```

**OK to exclude:** Generated files, development-only tooling, truly defensive impossible-state checks.

**Never exclude:** Error handling paths, auth checks, business logic, data validation.

## CI Coverage Thresholds

```json
// jest.config.js
{
  "coverageThreshold": {
    "global": { "branches": 75 },
    "./src/domain/": { "branches": 90 },
    "./src/generated/": { "branches": 0 }
  }
}
```

Never set a global 100% threshold — you'll spend engineering time gaming the metric.
