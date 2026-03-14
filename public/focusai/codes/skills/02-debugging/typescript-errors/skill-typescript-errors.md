---
name: typescript-errors
description: TypeScript error resolution guide. Auto-load when working in TypeScript files or when TS compiler errors appear.
---

# TypeScript Error Reference

Decode the most common TypeScript errors. The compiler is almost always right — work with it, not around it.

---

## Core Rule

> `as` is a lie. Use it as a last resort. When you add `as SomeType`, you're telling TypeScript "trust me, I know better." If you're wrong, you get a runtime error with no type safety to catch it.

---

## Most Common Errors Decoded

### TS2345 — Argument of type 'X' is not assignable to parameter of type 'Y'

**What it means:** You're passing the wrong type to a function.

```ts
// Error: Argument of type 'string' is not assignable to parameter of type 'number'
function add(a: number, b: number) { return a + b; }
add("5", 10);

// Fix: convert the type
add(Number("5"), 10);
add(parseInt("5", 10), 10);
```

**Common cause: `string | undefined`**
```ts
// Error: string | undefined not assignable to string
function greet(name: string) { return `Hello ${name}`; }
const name = user?.name;  // string | undefined
greet(name);  // TS error

// Fix 1: assert non-null (only if you KNOW it's defined)
greet(name!);  // runtime crash if undefined

// Fix 2: provide a default (safer)
greet(name ?? 'Guest');

// Fix 3: guard
if (name) greet(name);
```

### TS2322 — Type 'X' is not assignable to type 'Y'

Assignment version of TS2345. Same causes, same fixes.

```ts
// Error: Type 'null' is not assignable to type 'User'
let user: User = null;  // TS error in strict mode

// Fix: make the type nullable
let user: User | null = null;
```

### TS2339 — Property 'X' does not exist on type 'Y'

**What it means:** Accessing a property that TypeScript doesn't know exists on this type.

```ts
// Error: Property 'name' does not exist on type '{}'
const obj = {};
console.log(obj.name);

// Common case: API response typed as 'any' or wrong type
const response = await fetch('/api/user');
const data = await response.json();  // data is 'any'
console.log(data.nama);  // typo — but no error because 'any'!
```

**Fix: type the API response:**
```ts
interface UserResponse {
  name: string;
  email: string;
}
const data: UserResponse = await response.json();
console.log(data.nama);  // TS catches the typo now
```

### TS2304 — Cannot find name 'X'

**What it means:** Variable or type used but never declared or imported.

```ts
// Error: Cannot find name 'useState'
const [count, setCount] = useState(0);  // forgot to import

// Fix:
import { useState } from 'react';
```

**For global browser types:**
```json
// tsconfig.json
{
  "lib": ["ES2020", "DOM"]  // add DOM for window, document, etc.
}
```

### TS7006 — Parameter 'X' implicitly has an 'any' type

**What it means:** You have `strict: true` (good) and a parameter without a type annotation.

```ts
// Error: Parameter 'user' implicitly has an 'any' type
function greet(user) {
  return `Hello ${user.name}`;
}

// Fix: add the type
function greet(user: User) {
  return `Hello ${user.name}`;
}
```

### TS18048 — 'X' is possibly 'undefined'

This is TypeScript's strictNullChecks catching a real potential bug.

```ts
const user = users.find(u => u.id === id);  // User | undefined
console.log(user.name);  // Error: 'user' is possibly 'undefined'
```

**Fix options (in order of preference):**

```ts
// 1. Handle undefined explicitly (safest)
if (!user) throw new Error(`User ${id} not found`);
console.log(user.name);  // now User, not User | undefined

// 2. Optional chaining (when undefined is OK)
console.log(user?.name);  // undefined if user is undefined

// 3. Nullish coalescing (provide default)
console.log(user?.name ?? 'Unknown User');

// 4. Non-null assertion (only if you are certain it exists)
console.log(user!.name);  // RUNTIME CRASH if user is actually undefined
```

---

## Generic Patterns

### Conditional Types

```ts
// "If T is a string, return string, else return number"
type Result<T> = T extends string ? string : number;

type A = Result<string>;  // string
type B = Result<boolean>; // number
```

### Type Guards

Narrow a union type to a specific type:

```ts
// Type guard function
function isUser(value: unknown): value is User {
  return typeof value === 'object' && value !== null && 'id' in value && 'email' in value;
}

function process(value: unknown) {
  if (isUser(value)) {
    console.log(value.email);  // TypeScript knows it's User here
  }
}
```

### Discriminated Unions

The cleanest way to handle "one of several shapes":

```ts
type Result =
  | { status: 'success'; data: User }
  | { status: 'error'; code: number; message: string }
  | { status: 'loading' };

function handle(result: Result) {
  switch (result.status) {
    case 'success':
      return result.data.email;  // TS knows data exists here
    case 'error':
      return result.message;     // TS knows message exists here
    case 'loading':
      return null;
  }
}
```

---

## When `as` Is Acceptable

| Situation | Acceptable? |
|-----------|-------------|
| You know the API returns a specific type and `response.json()` returns `unknown` | Yes, with a runtime validator (zod/valibot) first |
| You need `document.getElementById()` to be a specific element type | Yes: `as HTMLInputElement` (you know the HTML) |
| Suppressing a union type in test code that doesn't reach production | Sometimes acceptable |
| Working around a type error you don't understand | **No** — understand the error first |
| Casting `any` to remove errors | **No** — fix the root type |

**Before using `as`, ask:** "Why does TypeScript think this is the wrong type?" If you can't answer, don't use `as`.

---

## TypeScript Configuration Quick Reference

```json
{
  "strict": true,           // enables strictNullChecks, noImplicitAny, etc.
  "noUncheckedIndexedAccess": true,  // arr[0] is T | undefined, not T
  "exactOptionalPropertyTypes": true, // optional !== undefined explicitly
  "noImplicitReturns": true,  // all code paths must return
  "noFallthroughCasesInSwitch": true
}
```

Enable `strict: true` from the beginning. Enabling it on an existing codebase requires fixing all errors first.
