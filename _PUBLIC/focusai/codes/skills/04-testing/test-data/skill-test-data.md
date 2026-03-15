---
name: test-data
description: Generate realistic test data and fixtures. Auto-load when setting up test scenarios, creating seed data, or building factories for tests.
argument-hint: [data-type-or-schema]
---

# Test Data

Generate test data that makes tests readable, realistic, and isolated. Target: `$ARGUMENTS`

## Four Principles

### 1. Realistic (Not "test123")

Unrealistic data masks bugs that only appear with real-world values:

```ts
// BAD — "test" data hides format bugs
{ email: 'test', name: 'a', phone: '123' }

// GOOD — realistic data catches format bugs
{ email: 'alice.johnson@example.com', name: 'Alice Johnson', phone: '+1-555-0142' }
```

### 2. Minimal (Only What the Test Cares About)

```ts
// BAD — test drowns in irrelevant data
const user = { id: 'usr_123', email: '...', name: '...', role: 'admin', createdAt: ..., profileId: ..., timezone: '...', language: '...' };

// GOOD — factory provides defaults, test specifies only what matters
const user = buildUser({ role: 'admin' });
```

### 3. Isolated (No Shared Mutable State)

```ts
// BAD — mutation in one test breaks another
const sharedUser = { id: '123' };
test('A', () => { sharedUser.name = 'Updated'; });
test('B', () => { /* sees mutated sharedUser */ });

// GOOD — fresh object per test
test('A', () => { const user = buildUser(); ... });
test('B', () => { const user = buildUser(); ... });
```

### 4. Factory Pattern

```ts
import { faker } from '@faker-js/faker';

export function buildUser(overrides: Partial<User> = {}): User {
  return {
    id: faker.string.uuid(),
    email: faker.internet.email(),
    name: faker.person.fullName(),
    role: 'user',
    status: 'active',
    createdAt: faker.date.past({ years: 1 }),
    ...overrides,
  };
}

export function buildOrder(overrides: Partial<Order> = {}): Order {
  return {
    id: faker.string.uuid(),
    userId: faker.string.uuid(),
    status: 'pending',
    total: faker.number.float({ min: 10, max: 1000, fractionDigits: 2 }),
    items: [buildOrderItem()],
    createdAt: new Date(),
    ...overrides,
  };
}
```

## Faker.js Reference

```ts
// Identity
faker.string.uuid()                    // 'a4f9e2b0-...'
faker.person.fullName()                // 'Alice Johnson'
faker.internet.email()                 // 'alice.j92@example.com'
faker.phone.number('+1-###-###-####')

// Dates
faker.date.past({ years: 1 })
faker.date.between({ from: '2023-01-01', to: '2023-12-31' })
faker.date.recent({ days: 7 })

// Numbers
faker.number.int({ min: 1, max: 100 })
faker.number.float({ min: 0.01, max: 999.99, fractionDigits: 2 })

// Selections
faker.helpers.arrayElement(['admin', 'user', 'moderator'])
faker.helpers.shuffle(['a', 'b', 'c'])
```

**Deterministic seed for reproducibility:**
```ts
faker.seed(12345);  // same data every run
// Log seed on failure so you can reproduce locally
```

## JSON Fixtures vs Factory Functions

| Use | When |
|-----|------|
| JSON fixtures | Data is static; exact values matter for the test |
| Factory functions | Tests need variations on the same shape |
| Factory + composition | Relationship graphs (user with orders with items) |

## Database Seeding: Transactional Isolation

```ts
let tx: Prisma.TransactionClient;

beforeEach(async () => { tx = await prisma.$begin(); });
afterEach(async () => { await tx.$rollback(); });

test('creates a user', async () => {
  const repo = new UserRepository(tx);
  const user = await repo.create(buildUser());
  expect(user.id).toBeDefined();
  // Rollback in afterEach — DB is clean for next test
});
```

## Builder Pattern for Complex Scenarios

```ts
class OrderBuilder {
  private user = buildUser();
  private items: OrderItem[] = [];
  private status: Order['status'] = 'pending';

  withUser(overrides = {}) { this.user = buildUser(overrides); return this; }
  withItem(overrides = {}) { this.items.push(buildOrderItem(overrides)); return this; }
  withStatus(s: Order['status']) { this.status = s; return this; }

  build() {
    return { user: this.user, order: buildOrder({ userId: this.user.id, items: this.items, status: this.status }) };
  }
}

// Reads like a story
const { user, order } = new OrderBuilder()
  .withUser({ role: 'premium' })
  .withItem({ quantity: 5 })
  .withStatus('processing')
  .build();
```
