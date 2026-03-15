---
name: snapshot-tests
description: Set up and maintain snapshot tests. Auto-load when working with component tests, serialization tests, or when asked about snapshot testing.
argument-hint: [component-or-serializable]
---

# Snapshot Tests

Use snapshots where they add value. The most common misuse: treating `--updateSnapshot` as "fix the test." Target: `$ARGUMENTS`

## When Snapshots Are Good

✅ **Component rendering** — verify UI renders correctly for given props
✅ **Serialization formats** — API response shape, CSV export, XML generation
✅ **Code generation** — AST transforms, template output, generated SQL
✅ **CLI output** — verifying command output format

✗ **Avoid for:** Business logic with simple values (use `toBe`), large page-level renders, outputs with random/time-dependent data.

## Inline vs File Snapshots

**Inline** (preferred for small outputs — reviewers see expected output in the test):
```ts
it('renders user card', () => {
  const { container } = render(<UserCard name="Alice" role="Admin" />);
  expect(container).toMatchInlineSnapshot(`
    <div>
      <div class="user-card">
        <span class="name">Alice</span>
        <span class="role">Admin</span>
      </div>
    </div>
  `);
});
```

**File snapshots** (for larger outputs stored in `__snapshots__/`):
```ts
it('generates correct CSV export', () => {
  const csv = exportToCSV(orders);
  expect(csv).toMatchSnapshot();
});
```

Rule of thumb: > 15 lines → file snapshot. ≤ 15 lines → inline.

## The Correct Snapshot Review Workflow

When CI reports a snapshot failure:

1. **Read the diff** — do not immediately run `--updateSnapshot`
2. **Is this change expected?** Did you intentionally change the component?
3. **If expected:** Review the diff, confirm it matches your intent, then update
4. **If unexpected:** This is a caught regression — fix the code, do not update the snapshot

```bash
# Review before accepting
git diff __snapshots__/

# Update only after confirming diff is correct
npx jest --updateSnapshot
npx vitest --update-snapshots
```

## Custom Serializers

Reduce noise in component snapshots:

```ts
// jest.config.ts
snapshotSerializers: ['./test/serializers/money.ts']

// test/serializers/money.ts
export const print = (val: Money) => `${val.currency} ${val.amount.toFixed(2)}`;
export const test = (val: unknown): val is Money =>
  typeof val === 'object' && val !== null && 'amount' in val && 'currency' in val;

// Now: expect(price).toMatchInlineSnapshot(`USD 29.99`)
// Instead of: the full object representation
```

## Anti-Patterns

### 1. Snapshot the entire page
```ts
// BAD — any change anywhere breaks this
expect(document.body).toMatchSnapshot();

// GOOD — specific component
expect(screen.getByRole('dialog')).toMatchSnapshot();
```

### 2. Snapshots with random data
```ts
// BAD — always fails
const user = buildUser();  // random email
expect(renderUserCard(user)).toMatchSnapshot();

// GOOD — deterministic data
const user = buildUser({ name: 'Alice Johnson', email: 'alice@example.com' });
expect(renderUserCard(user)).toMatchSnapshot();
```

### 3. Never reviewing snapshot diffs
Establish code review rules: snapshot changes in a PR must be explained. Reviewers must look at the diff, not just approve because CI passed.

### 4. Snapshots for simple values
```ts
// BAD — snapshot when assertion is better
expect(user.role).toMatchSnapshot();

// GOOD
expect(user.role).toBe('admin');
```

## Maintenance Rule

If a snapshot hasn't changed in 6 months and is longer than 50 lines, ask:
- Is it actually catching any regressions?
- Could it be replaced with targeted assertions?
- Is the component too large to snapshot meaningfully?

Stale snapshots that are only ever updated without review provide false confidence while masking real regressions.
