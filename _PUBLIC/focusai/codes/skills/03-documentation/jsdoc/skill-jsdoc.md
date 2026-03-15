---
name: jsdoc
description: Add JSDoc/TSDoc comments to JavaScript and TypeScript code. Auto-load when asked to add comments, document functions, or improve code documentation in JS/TS files.
argument-hint: [function-or-file]
---

# JSDoc / TSDoc Reference

Add comments that tell the reader something they cannot immediately see from the code. Target: `$ARGUMENTS`

## The Quality Test

Before adding any JSDoc, ask: **Does this comment tell the reader something they cannot immediately see from the function name and TypeScript types?**

If no — don't add the comment.

```ts
// BAD — adds zero information
/** Gets the user by their ID. */
async function getUserById(id: string): Promise<User> { ... }

// GOOD — tells you what the signature doesn't
/**
 * Fetches user from cache, falling back to database. Returns null (not throws)
 * when user does not exist. Throws DatabaseError on connection failure.
 * Result is cached for 60s; use getUserByIdFresh() to bypass cache.
 */
async function getUserById(id: string): Promise<User | null> { ... }
```

---

## Core Tag Reference

### `@param` — Document parameters with constraints

```js
/**
 * @param {string} userId - Database ID (UUID v4)
 * @param {{ ttl?: number; role: 'admin' | 'user' }} options
 * @param {number} [options.ttl=3600] - Session lifetime in seconds
 */
```

Rules:
- Type in `{}`; optional params in square brackets: `[paramName]`
- With default: `[paramName=defaultValue]`
- Document shape of objects, not just `options: object`

### `@returns` — What comes back and when

```js
/**
 * @returns {Promise<Session | null>} The created session, or null if the
 *   user has exceeded their active session limit.
 */
```

Omit `@returns` for void functions.

### `@throws` — Errors callers must handle

```js
/**
 * @throws {ValidationError} When required fields are missing or malformed
 * @throws {NetworkError} When the upstream service is unreachable
 */
```

Only document errors the *caller* should handle, not programming errors.

### `@example` — Realistic usage, not toy examples

```js
/**
 * @example
 * // Minimal usage
 * const token = await generateToken(user.id);
 *
 * @example
 * // With custom expiry
 * const token = await generateToken(user.id, { ttl: 86400, scope: 'api' });
 */
```

### `@deprecated` — Signal obsolete code

```js
/**
 * @deprecated Since 2.0.0. Use createSession() instead.
 * Will be removed in 3.0.0.
 */
```

### `@template` — Generic type parameters (JS without TS)

```js
/**
 * @template T
 * @param {T[]} items
 * @param {(item: T) => boolean} predicate
 * @returns {T[]}
 */
function filter(items, predicate) { ... }
```

### `@typedef` — Define complex types once

```js
/**
 * @typedef {Object} UserRecord
 * @property {string} id - UUID v4
 * @property {string} email - Validated email
 * @property {'active' | 'suspended' | 'deleted'} status
 * @property {Date} createdAt
 */
```

---

## TypeScript-Specific Tags

In TypeScript, the type system handles what `@param` types used to do. These TSDoc tags add value:

### `@remarks` — Extended prose that doesn't fit the summary

```ts
/**
 * Validates and normalizes a phone number.
 *
 * @remarks
 * Accepts E.164 format, local formats with/without country code,
 * and formats with spaces, dashes, or parentheses. Always returns
 * E.164 format on success. Does NOT validate that the number
 * is currently active or assigned.
 */
```

### `@internal` — Exported but not public API

```ts
/** @internal */
export function _buildQueryString(params: Record<string, string>): string { ... }
```

### `@alpha` / `@beta` — Mark unstable APIs

```ts
/**
 * @beta
 * This API may change in minor versions while in beta.
 */
```

---

## Anti-Patterns to Avoid

| Anti-pattern | Why it's bad |
|---|---|
| Restating the function name | `/** Validates email. */ function validateEmail()` — says nothing |
| `@param {any}` | Use a real type or explain why it's any |
| `@returns The result` | Tells the reader nothing |
| Documenting every private method | Noise; private methods are self-explanatory or private for a reason |
| Stale `@param` names after refactor | Worse than no docs — actively misleading |
| Comment-out of code | Delete it; git preserves it |
