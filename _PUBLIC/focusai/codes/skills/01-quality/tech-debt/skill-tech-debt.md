---
name: tech-debt
description: Identify and prioritize technical debt. Use when planning a sprint, before a major feature, or when the codebase feels increasingly hard to change.
argument-hint: [module-or-area]
---

# Technical Debt Audit

Identify, classify, and prioritize technical debt in the specified area. The goal is not to eliminate all debt — it's to make informed decisions about which debt is worth paying now.

---

## What is Technical Debt?

**Intentional debt:** Deliberate shortcuts taken for speed. Acceptable if documented and planned to repay.
**Accidental debt:** Code that degraded unintentionally over time (rot, outdated patterns, forgotten workarounds).
**Bit rot:** Code that was fine when written but the world around it changed (deprecated APIs, newer patterns available).

---

## How to Find It

### 1. Complexity Metrics
- **Cyclomatic complexity > 10** per function = high-risk, hard to test
- **File length > 500 lines** = likely doing too much
- **Function length > 50 lines** = likely multiple responsibilities
- **Nesting depth > 3** = cognitive load danger zone

### 2. Duplication Detection
- Same logic in 3+ places (copy-paste programming)
- Similar functions that diverged from a common origin
- Repeated error handling patterns that could be centralized

### 3. Outdated Dependencies
- Packages with known CVEs
- Packages no longer maintained (last release > 2 years, issues piling up)
- APIs deprecated in newer versions of a dependency
- Native browser/Node APIs now available that replace a library

### 4. Missing Tests
- Business-critical code without tests
- Code that changed recently without corresponding test changes
- 0% coverage on error paths

### 5. Undocumented Decisions
- Code with "why did we do it this way?" comments missing
- Workarounds for bugs with no bug tracker reference
- Configuration values with no explanation

### 6. Deprecated Internal Patterns
- Old patterns still in use that the team already migrated away from elsewhere
- Multiple competing patterns for the same thing (2 different ways to do auth, 3 ways to handle errors)

---

## Prioritization Matrix

Score each debt item:

```
Priority = (Business Impact × Change Frequency) ÷ Effort to Fix

Business Impact:  High=3, Medium=2, Low=1
Change Frequency: Often=3, Sometimes=2, Rarely=1
Effort to Fix:    Small=1, Medium=2, Large=3
```

| Priority | Score | Action |
|----------|-------|--------|
| Critical | > 4   | Fix this sprint |
| High     | 3–4   | Schedule in next sprint |
| Medium   | 2–3   | Add to backlog |
| Low      | < 2   | Accept, document, revisit in 6 months |

---

## Output Format

```
[CRITICAL/HIGH/MEDIUM/LOW] Type of Debt — Location

What: [Description of the debt]
How it got here: [Root cause — rushed feature, outdated pattern, etc.]
Risk of NOT fixing: [What happens if left alone]
Effort to fix: S/M/L + rough estimate
Priority score: [Impact × Frequency ÷ Effort]
Suggested fix: [High-level approach]
```

End with:
1. Total debt items by priority
2. Top 3 to address immediately with suggested approach
3. Estimated "debt interest rate" — how much is this debt slowing down the team per week
