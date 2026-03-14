---
name: async-debug
description: Async/await and Promise debugging patterns. Auto-load when working with async code, handling race conditions, or debugging unexpected async behavior.
---

# Async Debug Reference

Async bugs are harder to debug because stack traces lose context and execution order is non-deterministic. These patterns will find the problem.

---

## Reading Async Stack Traces

Node.js 12+ and modern browsers include async stack traces. Enable them:

```js
// Node.js — enable in development
Error.stackTraceLimit = 50;  // default is 10, too few for async chains

// Chrome DevTools: Settings → "Async stack traces" (on by default)
```

Async stack traces show the full call chain, including across `await` points. Without them, you see only the frame where the error was thrown, not where the async operation was initiated.

---

## Debugging Promise Chains

### Finding Unhandled Rejections

```js
// Globally catch unhandled rejections (add to app startup)
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
  // Don't suppress — let the process crash in development
});

// Browser
window.addEventListener('unhandledrejection', (event) => {
  console.error('Unhandled rejection:', event.reason);
});
```

### Silent Promise Failures (Most Common Async Bug)

```js
// BAD — rejection is swallowed silently
async function saveUser(user) {
  try {
    await db.save(user);
  } catch (e) {
    // swallowed — caller never knows it failed
  }
}

// BAD — floating promise (no await, no catch)
async function handler(req, res) {
  sendWelcomeEmail(user);  // ← fire and forget, but errors vanish
  res.json({ success: true });
}

// GOOD — always propagate or handle explicitly
async function saveUser(user) {
  await db.save(user);  // let it throw — caller handles it
}

async function handler(req, res) {
  await sendWelcomeEmail(user);  // or: sendWelcomeEmail(user).catch(logger.error)
  res.json({ success: true });
}
```

---

## Race Conditions

### Identifying Race Conditions

Signs: bug only appears under load or with fast clicking; bug disappears when you add logging; behavior is inconsistent between runs.

### Common Race Condition Patterns

**Check-then-act:**
```js
// BAD — another request can change state between check and act
async function withdraw(accountId, amount) {
  const account = await getAccount(accountId);
  if (account.balance < amount) throw new Error('Insufficient funds');
  await updateBalance(accountId, account.balance - amount);
  // Two simultaneous withdrawals both see enough balance, both succeed
}

// GOOD — use database-level atomic operation
async function withdraw(accountId, amount) {
  const result = await db.query(
    'UPDATE accounts SET balance = balance - $1 WHERE id = $2 AND balance >= $1 RETURNING *',
    [amount, accountId]
  );
  if (result.rowCount === 0) throw new Error('Insufficient funds');
}
```

**Token refresh race:**
```js
// BAD — 10 concurrent requests all try to refresh simultaneously
async function getAccessToken() {
  if (isExpired(token)) {
    token = await refreshToken();  // 10 refreshes fire at once
  }
  return token;
}

// GOOD — deduplicate in-flight refresh
let refreshPromise: Promise<Token> | null = null;

async function getAccessToken() {
  if (isExpired(token)) {
    if (!refreshPromise) {
      refreshPromise = refreshToken().finally(() => {
        refreshPromise = null;
      });
    }
    token = await refreshPromise;
  }
  return token;
}
```

---

## Sequential vs Parallel (Performance + Correctness)

```js
// SEQUENTIAL — slow: 3 seconds total
const user = await getUser(id);           // 1s
const orders = await getOrders(id);       // 1s
const preferences = await getPrefs(id);  // 1s

// PARALLEL — fast: 1 second total (independent operations)
const [user, orders, preferences] = await Promise.all([
  getUser(id),
  getOrders(id),
  getPrefs(id),
]);

// CAUTION: Promise.all fails fast — if ANY rejects, all fail
// Use Promise.allSettled when you want all results even if some fail:
const results = await Promise.allSettled([getUser(id), getOrders(id)]);
results.forEach(result => {
  if (result.status === 'fulfilled') process(result.value);
  else logger.error(result.reason);
});
```

---

## Async Error Boundaries

```js
// Wrap async routes to catch all errors (Express)
const asyncHandler = (fn) => (req, res, next) =>
  Promise.resolve(fn(req, res, next)).catch(next);

app.get('/users/:id', asyncHandler(async (req, res) => {
  const user = await getUser(req.params.id);
  res.json(user);
  // Any thrown error goes to next() → error middleware
}));
```

---

## AbortController: Cancellation

```js
async function fetchWithTimeout(url, timeoutMs = 5000) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeoutMs);

  try {
    const response = await fetch(url, { signal: controller.signal });
    return await response.json();
  } catch (error) {
    if (error.name === 'AbortError') {
      throw new Error(`Request to ${url} timed out after ${timeoutMs}ms`);
    }
    throw error;
  } finally {
    clearTimeout(timeoutId);
  }
}
```

---

## Debugging Checklist

- [ ] Is there an `await` missing somewhere? (Function called but not awaited)
- [ ] Is a `catch` block swallowing an error silently?
- [ ] Are there floating promises? (async functions called without await or .catch)
- [ ] Are operations that look sequential actually running in parallel? (or vice versa)
- [ ] Is a race condition possible? (Two paths modifying the same resource)
- [ ] Are `Promise.all` errors being handled?
- [ ] Is the async function actually returning a promise? (Missing `async` keyword)
