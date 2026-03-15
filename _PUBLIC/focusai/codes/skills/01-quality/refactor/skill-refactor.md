---
name: refactor
description: Refactor code while preserving existing behavior. Use when cleaning up messy code, reducing complexity, or improving maintainability of a specific file or function.
disable-model-invocation: true
argument-hint: [file-or-function]
---

# Refactor

Refactor the specified code to improve structure, readability, and maintainability — without changing behavior.

## Safety Rules (Non-Negotiable)

1. **Understand behavior first** — read the tests before touching anything
2. **One refactor at a time** — extract method, then rename, then restructure (not all at once)
3. **Tests must pass after every step** — each intermediate state should be working
4. **Never change behavior** — if tests don't exist, write them first, then refactor
5. **Commit after each meaningful step** — enables easy rollback

---

## Step 1: Identify Code Smells

### Long Method
Function does too much. Signs: scrolling required, multiple levels of abstraction mixed, multiple "and" in the description.
→ Extract method: pull out cohesive sub-logic into named functions

### Deep Nesting
More than 2-3 levels of if/for nesting. Increases cognitive load exponentially.
→ Early returns: invert conditions and return early
→ Extract nested loop body into function

### Magic Numbers / Strings
```javascript
// BAD
if (status === 3) { ... }
setTimeout(fn, 86400000);

// GOOD
const STATUS_ACTIVE = 3;
const ONE_DAY_MS = 24 * 60 * 60 * 1000;
```

### Duplicate Logic (Rule of Three)
Same logic in 3+ places → extract to shared function
Two places → tolerate for now, monitor

### Long Parameter List (> 3 params)
```javascript
// BAD
function createUser(name, email, role, age, department, startDate) {}

// GOOD
function createUser({ name, email, role, age, department, startDate }) {}
```

### God Object / God Function
One class/function that knows and does everything.
→ Single Responsibility: each unit has one reason to change

### Feature Envy
Function uses another object's data more than its own.
→ Move the method to the object it's envious of

### Comments Explaining "What" (not "Why")
Code that needs comments to explain what it does should be rewritten to be self-explanatory.
```javascript
// BAD: comment explains what
// increment counter
i++;

// GOOD: comment explains why
// Offset by 1 because the API uses 1-based indexing
return index + 1;
```

---

## Step 2: Apply Refactoring Patterns

| Smell | Refactoring |
|-------|-------------|
| Long method | Extract Method |
| Deep nesting | Replace Nested Conditionals with Guard Clauses |
| Magic values | Replace Magic Number with Constant |
| Duplicate logic | Extract Function / DRY |
| Long param list | Introduce Parameter Object |
| Type checking (if type === 'x') | Replace Conditional with Polymorphism |
| Primitive obsession | Introduce Value Object |
| Temporary field | Extract Class |

---

## Step 3: Verify

After each refactoring step:
- [ ] Run tests — all must pass
- [ ] Behavior is identical (same inputs → same outputs)
- [ ] Code is more readable than before
- [ ] No new abstractions introduced "for the future"

---

## Output

1. List of identified smells with locations
2. Proposed refactoring steps in order
3. Refactored code with before/after comparison
4. Confirmation that behavior is preserved
