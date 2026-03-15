---
name: explain-code
description: Explain how code works in clear language. Auto-load when asked to explain code, understand unfamiliar patterns, or onboard to a new codebase.
argument-hint: [file-or-function]
---

# Explain Code

Explain code at the right level for the person asking. Target: `$ARGUMENTS`

## The Three Levels

Calibrate depth to the audience. When in doubt, give Level 1 first and offer to go deeper.

### Level 1: Executive Summary (1–2 sentences)
What does this code *accomplish*? Ignore implementation.

```
This module handles authentication. It validates credentials, creates sessions,
and manages token refresh so users stay logged in without re-entering passwords.
```

### Level 2: High-Level Flow (1 paragraph)
The journey of a request/event/data through this code.

```
When a login request arrives, the handler validates input shape, checks the user
exists in the database, then compares the hashed password using bcrypt. On success,
it creates a session record, generates a signed JWT containing the session ID,
and returns both the JWT and a long-lived refresh token. Failed attempts are
rate-limited by IP to prevent brute-force attacks.
```

### Level 3: Detailed Walkthrough
Line-by-line or block-by-block. Only when explicitly needed or code is genuinely complex. For each block:
1. What it does (one line)
2. Why it does it (design intent)
3. What breaks if this block is wrong

---

## Always Cover

**What problem does this solve?**
Never assume the reader knows why this code exists.

**Inputs and outputs:**
Types, constraints, edge cases.

**Key decisions and trade-offs:**
Why this approach and not the obvious alternative?

```
// The cache uses 60s TTL instead of invalidation-on-write because
// this data is read ~1000x/s but 60s eventual consistency is acceptable.
```

**What can go wrong?**
Every code path has failure modes. Name them.

---

## Analogy-First for Complex Patterns

Lead with a concrete analogy before the technical explanation.

**Without analogy:**
> This implements a semaphore using Redis SETNX with TTL for distributed mutual exclusion.

**With analogy:**
> Think of this as a bathroom key in a restaurant — only one party can have it at a time. Redis is the hook; `SETNX` is "put key on hook only if empty"; the TTL ensures the key auto-returns after 30 seconds so a crashed process can't hold it forever.

---

## Name the Dangerous Parts

Every codebase has places where bugs cluster. Call them out:

- **Mutation of shared state** — especially in async code
- **Silent failures** — catch blocks swallowing errors
- **Ordering assumptions** — events must arrive in sequence
- **Type coercion** — JS falsy checks, `+value`, `== null`
- **Race conditions** — two async operations with unguaranteed order
- **Missing validation** — trusting user-controlled data

Format: "The dangerous part is X. If Y happens, Z breaks in a way that's hard to debug because..."

---

## Name Patterns When You See Them

| Pattern | How to introduce it |
|---------|---------------------|
| Factory function | "This is a factory — it creates objects without using `new`..." |
| Observer | "This is the observer pattern — subscribers get notified of events..." |
| Repository | "This isolates data access from business logic..." |
| Decorator | "This wraps the function to add logging without modifying the original..." |
| Circuit breaker | "After N failures, it stops calling the service to let it recover..." |

---

## Output Format

1. One-sentence summary
2. Context / why this exists
3. How it works (depth calibrated to audience)
4. Key gotchas or dangerous parts
5. What to look at next (related files, callers, consumers)
