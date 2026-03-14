---
name: write-tests
description: Write comprehensive unit tests. Auto-load when asked to add tests, increase coverage, or test a specific function or module.
argument-hint: [function-or-file]
---

# Write Tests

Write tests that catch real bugs. Target: `$ARGUMENTS`

## Anatomy: Arrange-Act-Assert

```js
it('returns null when user does not exist', async () => {
  // ARRANGE
  const repo = new UserRepository(createTestDb());

  // ACT
  const result = await repo.findById('nonexistent-id');

  // ASSERT
  expect(result).toBeNull();
});
```

Never combine multiple acts. If you write "and then" in the description, split into two tests.

## Naming

```
// given_when_then
given_an_expired_session_when_refreshed_it_returns_new_token

// should_do_X_when_Y
should_return_null_when_user_does_not_exist
should_throw_ValidationError_when_email_is_invalid
```

## What to Test vs Not

**Test:**
- Return values for all significant input variations
- Error/exception cases with specific types callers depend on
- State changes and emitted events
- Edge cases in business logic
- Behavior difference between option combinations

**Don't test:**
- Third-party library internals
- Private implementation details
- Framework boilerplate
- TypeScript type correctness (compiler handles this)

**Test selection rule:** If this behavior changed, would a user or caller notice? Yes → test it.

## Test Pyramid

```
    /‾‾‾‾‾‾‾‾\
   /  E2E (few) \
  /‾‾‾‾‾‾‾‾‾‾‾‾‾\
 / Integration(some)\
/‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
/   Unit (most)       \
```

Default to unit tests. Add integration when component interaction is where bugs live.

## Mocking Strategy

**Mock at the architectural boundary — not inside your code.**

```
Your code → [boundary] → External system
               ↑
          Mock here
```

```ts
// CORRECT — mock the HTTP boundary
jest.mock('../lib/httpClient');
(httpClient.get as jest.Mock).mockResolvedValue({ data: user });

// WRONG — mocking internal helpers you own
jest.mock('../utils/parseResponse');  // test that function directly instead
```

## Test Isolation

Each test must be fully independent:
- Create its own state (never depend on test order)
- Clean up after itself (reset mocks, rollback transactions)
- Not share mutable objects between tests

```ts
let db: TestDatabase;
beforeEach(() => { db = createTestDatabase(); });
afterEach(() => { db.destroy(); });
```

## Framework Patterns

**Jest/Vitest:**
```ts
describe('UserRepository', () => {
  describe('findById', () => {
    it('returns null when not found', async () => { ... });
    it('returns user when found', async () => { ... });
  });
});
```

**pytest:**
```python
class TestUserRepository:
    def test_returns_none_when_user_not_found(self, db_session):
        repo = UserRepository(db_session)
        assert repo.find_by_id("nonexistent") is None
```

## Anti-Patterns

| Anti-pattern | Fix |
|---|---|
| Testing private methods | Test through the public API |
| Multiple unrelated assertions per test | One logical concept per test |
| Over-mocking | Mock only external boundaries |
| `expect(fn).not.toThrow()` | Test the return value instead |
| Shared mutable fixtures | Create fresh data per test |
