---
name: e2e-tests
description: Write end-to-end tests with Playwright or Cypress. Use when adding E2E tests, testing critical user flows, or when asked to write browser automation tests.
disable-model-invocation: true
argument-hint: [user-flow-description]
---

# E2E Tests

Write tests from the user's perspective. User flow: `$ARGUMENTS`

## Core Principles

- Test behavior, not implementation — refactoring should not break E2E tests
- Use semantic selectors — users see text and roles, not CSS classes
- Reserve E2E for critical flows only: auth, payments, core data operations

## Selector Priority

```ts
// 1. Role + accessible name (most resilient)
page.getByRole('button', { name: 'Submit' })
page.getByRole('textbox', { name: 'Email address' })

// 2. Label text (forms)
page.getByLabel('Password')

// 3. Visible text
page.getByText('Welcome back')

// 4. data-testid (last resort)
page.getByTestId('product-card-123')
```

Never use: CSS classes, IDs tied to styling, component names.

## Playwright: Page Object Model

```ts
// pages/LoginPage.ts
export class LoginPage {
  constructor(private page: Page) {}

  async goto() { await this.page.goto('/login'); }

  async login(email: string, password: string) {
    await this.page.getByLabel('Email').fill(email);
    await this.page.getByLabel('Password').fill(password);
    await this.page.getByRole('button', { name: 'Sign in' }).click();
  }

  async getError() {
    return this.page.getByRole('alert').textContent();
  }
}

// tests/auth.spec.ts
test('shows error on wrong password', async ({ page }) => {
  const login = new LoginPage(page);
  await login.goto();
  await login.login('user@example.com', 'wrong');
  expect(await login.getError()).toContain('Invalid credentials');
});
```

## Playwright: Auto-Waiting

Playwright waits automatically — almost never add explicit waits:

```ts
// WRONG — manual sleep is flaky and slow
await page.waitForTimeout(2000);

// RIGHT — Playwright waits for the element automatically
await page.getByRole('button', { name: 'Submit' }).click();

// Only explicit wait when waiting for navigation or specific API call
await Promise.all([
  page.waitForURL('/dashboard'),
  page.getByRole('button', { name: 'Sign in' }).click(),
]);
```

## Network Interception

```ts
test('shows error when card is declined', async ({ page }) => {
  await page.route('/api/payments', route =>
    route.fulfill({ status: 402, body: JSON.stringify({ error: 'CARD_DECLINED' }) })
  );

  await page.goto('/checkout');
  await page.getByRole('button', { name: 'Pay now' }).click();
  await expect(page.getByText('Your card was declined')).toBeVisible();
});
```

## Cypress: Core Patterns

```js
// cy.intercept for API control
cy.intercept('POST', '/api/sessions', {
  statusCode: 200,
  body: { accessToken: 'test-token', user: { id: '123' } },
}).as('login');

cy.getByLabel('Email').type('user@example.com');
cy.getByRole('button', { name: 'Sign in' }).click();
cy.wait('@login').its('request.body').should('include', { email: 'user@example.com' });
cy.url().should('include', '/dashboard');

// Custom commands for reuse
Cypress.Commands.add('login', (email, password) => {
  cy.session([email, password], () => {
    cy.visit('/login');
    cy.getByLabel('Email').type(email);
    cy.getByLabel('Password').type(password);
    cy.getByRole('button', { name: 'Sign in' }).click();
    cy.url().should('include', '/dashboard');
  });
});
```

## Preventing Flakiness

| Cause | Fix |
|-------|-----|
| Race conditions | `waitForResponse` / `cy.wait('@alias')` |
| Animation interference | Wait for animation or use `{ force: true }` |
| Shared test state | Reset DB/auth in `beforeEach` |
| Time-dependent assertions | Mock system clock in E2E too |

Never add `sleep` / `waitForTimeout` to fix flakiness — find the real cause.
