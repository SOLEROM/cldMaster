---
name: generate-docs
description: Generate comprehensive documentation for code. Use when documenting a module, class, API, or when asked to write docs for existing code.
disable-model-invocation: true
argument-hint: [file-or-module]
---

# Generate Docs

Generate professional documentation for the specified code. Target: `$ARGUMENTS`

## Step 1: Read and Understand First

Before writing a single word, read the entire file or module. Understand:
- What problem does this code solve?
- What are the entry points (public API surface)?
- What assumptions does it make about inputs?
- What state does it mutate?
- What can go wrong?

## Step 2: Identify Public API Surface

Only document what callers interact with. Internal helpers get minimal or no documentation.

**Document:**
- All exported functions, classes, methods, types
- Constructor signatures and required options
- Events emitted (EventEmitter, DOM events)
- Side effects on external systems

**Skip (or one-liner only):**
- Private helpers (`_`, `#`, unexported)
- Obvious getters/setters
- Auto-generated boilerplate

## Step 3: Document Purpose — What, Not How

The code already shows *how*. Documentation explains *what* and *why*.

```js
// BAD — explains what (obvious from code)
/**
 * Loops through items and calls processItem on each one,
 * then pushes the result into the output array.
 */

// GOOD — explains what the caller needs to know
/**
 * Transforms a batch of raw API items into normalized records
 * ready for database insertion. Skips items with missing required
 * fields and logs a warning for each skipped item.
 *
 * @throws {ValidationError} If the batch itself is malformed (not individual items)
 * @returns Items that passed validation; failed items are in the logs
 */
```

## Step 4: Document Parameters with Constraints

For every parameter:
- **Type** — specific (`{ id: string; limit?: number }`, not `object`)
- **Required vs optional** — and the default value if optional
- **Constraints** — valid ranges, allowed values, format requirements
- **Failure behavior** — what happens with invalid input

## Step 5: Document Return Values and Exceptions

- What it returns on success (type + meaning)
- What it returns in "empty" states (`null` vs `[]` vs `undefined` — these differ)
- Which error types can be thrown and when
- Whether errors are expected (validation) or unexpected (bugs)

## Step 6: Add Examples for Non-Obvious Cases

Add examples when:
- The function has non-obvious argument ordering
- A flag changes behavior significantly
- The function is commonly misused
- Multiple valid calling patterns exist

Skip examples that merely restate the signature.

## Step 7: Document Side Effects Explicitly

State clearly when a function:
- Writes to a file, database, or cache
- Modifies shared state
- Emits events
- Makes network requests
- Starts or stops timers
- Is not idempotent

---

## Output Format by Language

| Language | Format |
|----------|--------|
| JavaScript | JSDoc (`/** */`) |
| TypeScript | TSDoc (`@remarks`, `@internal`) |
| Python | Google-style or NumPy docstrings |
| Go | godoc (plain comment above declaration) |
| Rust | `///` rustdoc |
| Separate doc file | Markdown with headers per symbol |

---

## What NOT to Document

```js
/** Sets the name. */          // Obvious from setter — skip
set name(v) { this._name = v; }

/** The user's id. */          // Obvious from property name — skip
public id: string;

/** Returns true if active. */ // Type signature already says boolean — skip
get isActive(): boolean { return this._status === 'active'; }
```

Documentation that restates the code is worse than no documentation — it adds noise and can become wrong when the code changes.
