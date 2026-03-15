---
name: clean-code
description: Clean code principles and best practices. Auto-load when writing new functions, naming variables, structuring modules, or when asked to improve code quality.
---

# Clean Code Reference

These principles apply automatically when writing or reviewing any code. They are guidelines, not rules — judgment is always required.

---

## Naming

**The most important skill in programming is naming things.**

### Variables
```javascript
// BAD — what is d? what is he?
const d = 86400;
const he = users.filter(u => u.active);

// GOOD
const SECONDS_PER_DAY = 86400;
const activeUsers = users.filter(user => user.isActive);
```

Rules:
- Pronounceable: `customermgmtcntlr` → `customerManagementController`
- Searchable: avoid single letters except loop counters
- No type suffixes: `userList` → `users`, `nameString` → `name`
- Booleans: use `is`, `has`, `can`, `should` prefix → `isValid`, `hasPermission`
- Functions: verb + noun → `getUser`, `calculateTotal`, `sendEmail`
- Classes: noun → `User`, `OrderProcessor`, `EmailSender`

### Constants
```javascript
// BAD — magic number
if (user.age >= 18) { ... }

// GOOD
const LEGAL_AGE = 18;
if (user.age >= LEGAL_AGE) { ... }
```

---

## Functions

### Single Responsibility
One function does one thing. If you need "and" to describe it, split it.
```javascript
// BAD — does two things
function validateAndSaveUser(user) { ... }

// GOOD — each does one thing
function validateUser(user) { ... }
function saveUser(user) { ... }
```

### One Level of Abstraction
Don't mix high-level orchestration with low-level detail in the same function.
```javascript
// BAD — mixes high-level and low-level
function processOrder(order) {
  const total = order.items.reduce((sum, item) => sum + item.price * item.qty, 0);
  const tax = total * 0.17;
  sendEmail(order.user.email, `Your total is ${total + tax}`);
}

// GOOD — consistent abstraction level
function processOrder(order) {
  const total = calculateOrderTotal(order);
  notifyUser(order.user, total);
}
```

### Avoid Flag Parameters
```javascript
// BAD — boolean flag that changes function behavior
render(true);         // what does true mean?
createUser(data, false); // is false: isAdmin? sendEmail? dryRun?

// GOOD — separate functions
renderWithHeader();
createAdminUser(data);
```

### Limit Arguments (≤ 3)
```javascript
// BAD
function createEvent(title, date, location, maxAttendees, isPublic, organizerId) {}

// GOOD
function createEvent({ title, date, location, maxAttendees, isPublic, organizerId }) {}
```

---

## Comments

**Good code is self-documenting. Comments explain WHY, not WHAT.**

```javascript
// BAD — explains what (obvious from code)
// Loop through users
for (const user of users) { ... }

// GOOD — explains why (not obvious from code)
// Users are processed in reverse order because the audit log
// expects events in chronological order and we're prepending
for (const user of [...users].reverse()) { ... }
```

**When comments ARE appropriate:**
- Business rules that seem arbitrary but have a reason
- Workarounds for bugs in external libraries
- Legal/license headers
- Warnings about non-obvious consequences
- TODO with ticket number: `// TODO(JIRA-123): remove after migration`

**Never:**
- Comment out code — delete it (git history preserves it)
- Write comments that will become lies as code evolves
- Explain what is already clear from reading the code

---

## Error Handling

```javascript
// BAD — swallowed error, no context
try {
  await saveUser(user);
} catch (e) {
  console.log('error');
}

// GOOD — context + propagation
try {
  await saveUser(user);
} catch (error) {
  throw new Error(`Failed to save user ${user.id}: ${error.message}`);
}
```

Rules:
- Don't return null for errors — throw or return a Result type
- Provide context: what operation failed, with what input
- Don't catch what you can't handle — let it propagate
- Distinguish expected errors (validation) from unexpected errors (bugs)

---

## Formatting

- Consistency beats personal preference — use a linter/formatter
- Related code close together, unrelated code separated by whitespace
- Newspaper structure: important things first, details below
- File size: if you need to scroll a lot, it's probably too long
