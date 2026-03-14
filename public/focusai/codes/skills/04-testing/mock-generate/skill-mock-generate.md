---
name: mock-generate
description: Generate mocks, stubs, and test fixtures. Auto-load when setting up tests that require external dependencies, APIs, or databases.
argument-hint: [interface-or-function-to-mock]
---

# Mock Generate

Generate the right test double for the situation. Target: `$ARGUMENTS`

## Test Double Taxonomy

| Type | Definition | Use when |
|------|-----------|----------|
| **Mock** | Records calls; assert on *how* it was called | Verifying a side effect occurred (email sent) |
| **Stub** | Returns preset responses; no call verification | Controlling what a dependency returns |
| **Fake** | Working lightweight implementation (in-memory DB) | Realistic behavior without real infrastructure |
| **Spy** | Wraps real implementation; also records calls | Real behavior + verify it was called |

## HTTP: MSW (Preferred)

```ts
// test/setup/server.ts
import { setupServer } from 'msw/node';
import { http, HttpResponse } from 'msw';

export const server = setupServer(
  http.get('/api/users/:id', ({ params }) =>
    HttpResponse.json({ id: params.id, name: 'Test User' })
  ),
  http.post('/api/sessions', async ({ request }) => {
    const body = await request.json();
    if (body.password === 'wrong') {
      return HttpResponse.json({ error: 'WRONG_PASSWORD' }, { status: 401 });
    }
    return HttpResponse.json({ accessToken: 'test-token' }, { status: 201 });
  }),
);

beforeAll(() => server.listen({ onUnhandledRequest: 'error' }));
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

// Override for one test
server.use(http.get('/api/users/:id', () => HttpResponse.json({}, { status: 500 })));
```

## Database: In-Memory Fake (for complex queries)

```ts
class InMemoryUserRepository implements UserRepository {
  private users = new Map<string, User>();

  async findById(id: string): Promise<User | null> {
    return this.users.get(id) ?? null;
  }

  async save(user: User): Promise<void> {
    this.users.set(user.id, user);
  }
}
```

## Database: Stub (for unit tests)

```ts
const mockRepo: jest.Mocked<UserRepository> = {
  findById: jest.fn().mockResolvedValue(null),
  save: jest.fn().mockResolvedValue(undefined),
};
mockRepo.findById.mockResolvedValueOnce({ id: '123', email: 'test@example.com' });
```

## System Clock

```ts
beforeEach(() => {
  jest.useFakeTimers();
  jest.setSystemTime(new Date('2024-01-15T10:00:00Z'));
});
afterEach(() => jest.useRealTimers());

// Now Date.now() is deterministic — no flaky time-dependent tests
```

## File System

```ts
import { vol } from 'memfs';
jest.mock('fs', () => require('memfs').fs);
jest.mock('fs/promises', () => require('memfs').fs.promises);

beforeEach(() => {
  vol.fromJSON({
    '/data/config.json': JSON.stringify({ env: 'test' }),
    '/data/users.csv': 'id,name\n1,Alice',
  });
});
afterEach(() => vol.reset());
```

## Factory Functions for Test Data

```ts
import { faker } from '@faker-js/faker';

export function buildUser(overrides: Partial<User> = {}): User {
  return {
    id: faker.string.uuid(),
    email: faker.internet.email(),
    name: faker.person.fullName(),
    role: 'user',
    createdAt: faker.date.past(),
    ...overrides,
  };
}

// In tests — only specify what matters
const admin = buildUser({ role: 'admin' });
const suspended = buildUser({ status: 'suspended' });
```

**Deterministic seed for reproducibility:**
```ts
faker.seed(12345);  // same data every run
```

## The Golden Rule

**Mock at the architectural boundary, not inside your code.**

```
✅ Your service → mock UserRepository
✅ UserRepository → mock Postgres driver (or use test DB)
❌ Inside UserService → mock UserRepository.findById
❌ Inside UserRepository → mock private parseRow method
```

If you need to mock an internal function to write a test, the code needs to be split at a real architectural boundary.
