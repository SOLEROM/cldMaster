---
name: solid-principles
description: SOLID design principles reference. Auto-load when designing classes, reviewing object-oriented code, evaluating architecture, or when asked about design principles.
---

# SOLID Principles

Reference for the five SOLID design principles. Apply these when the benefit is clear — don't over-engineer simple code to satisfy them.

---

## S — Single Responsibility Principle

**"A class should have only one reason to change."**

Each class/module is responsible for one actor (one stakeholder who might request changes).

```typescript
// BAD — UserService does too many things
class UserService {
  saveUser(user: User) { /* DB logic */ }
  sendWelcomeEmail(user: User) { /* Email logic */ }
  generateReport(users: User[]) { /* Report logic */ }
}

// GOOD — each class has one responsibility
class UserRepository { saveUser(user: User) { } }
class EmailService { sendWelcomeEmail(user: User) { } }
class UserReportGenerator { generate(users: User[]) { } }
```

**Violation smell:** "I need to change this class when X changes OR when Y changes OR when Z changes."

---

## O — Open/Closed Principle

**"Software should be open for extension, closed for modification."**

Add new behavior by adding new code, not changing existing code.

```typescript
// BAD — must modify existing function to add new shape
function calculateArea(shape: Shape): number {
  if (shape.type === 'circle') return Math.PI * shape.radius ** 2;
  if (shape.type === 'square') return shape.side ** 2;
  // Adding triangle requires modifying this function
}

// GOOD — extend without modifying
interface Shape {
  area(): number;
}
class Circle implements Shape {
  area() { return Math.PI * this.radius ** 2; }
}
class Triangle implements Shape {
  area() { return (this.base * this.height) / 2; }
}
// Adding new shape = new class, no changes to existing code
```

**Violation smell:** Adding a new feature requires modifying 5 different switch statements.

---

## L — Liskov Substitution Principle

**"Subtypes must be substitutable for their base types."**

If you use a base class somewhere, swapping it with a subclass should not break the program.

```typescript
// BAD — Square violates LSP
class Rectangle {
  setWidth(w: number) { this.width = w; }
  setHeight(h: number) { this.height = h; }
  area() { return this.width * this.height; }
}
class Square extends Rectangle {
  setWidth(w: number) { this.width = w; this.height = w; } // ← breaks Rectangle contract
}

// If code assumes: rect.setWidth(5); rect.setHeight(3); → area = 15
// With Square: area = 9 (broken!)

// GOOD — don't inherit, use composition or separate hierarchy
interface Shape { area(): number; }
class Rectangle implements Shape { ... }
class Square implements Shape { ... }
```

**Violation smell:** Subclass overrides a method to throw an error or do nothing (breaks parent contract).

---

## I — Interface Segregation Principle

**"Clients should not be forced to depend on interfaces they don't use."**

Many specific interfaces are better than one general-purpose interface.

```typescript
// BAD — fat interface forces implementing everything
interface Worker {
  work(): void;
  eat(): void;
  sleep(): void;
}
// Robot has to implement eat() and sleep() even though it doesn't need them

// GOOD — segregated interfaces
interface Workable { work(): void; }
interface Feedable { eat(): void; }
interface Restable { sleep(): void; }

class Human implements Workable, Feedable, Restable { ... }
class Robot implements Workable { ... }
```

**Violation smell:** Classes implementing an interface and leaving methods empty or throwing "NotImplemented".

---

## D — Dependency Inversion Principle

**"High-level modules should not depend on low-level modules. Both should depend on abstractions."**

```typescript
// BAD — high-level UserService depends on low-level MySQLDatabase
class UserService {
  private db = new MySQLDatabase(); // ← hardcoded dependency

  getUser(id: string) {
    return this.db.query(`SELECT * FROM users WHERE id = ${id}`);
  }
}

// GOOD — depend on abstraction, inject the implementation
interface UserRepository {
  findById(id: string): Promise<User>;
}

class UserService {
  constructor(private repo: UserRepository) {} // ← injected

  async getUser(id: string) {
    return this.repo.findById(id);
  }
}

// Can now inject MySQLUserRepo, PostgresUserRepo, InMemoryUserRepo (for tests)
```

**Violation smell:** `new ConcreteClass()` inside business logic — hard to test, hard to swap.

---

## When NOT to Apply SOLID

- Simple scripts or one-off utilities
- Code that will never change
- Over-engineering: creating interfaces for things with only one implementation
- Small functions or pure utilities (SOLID is for classes/modules, not every function)

**The goal is maintainable code, not SOLID compliance.**
