---
name: design-patterns
description: Design pattern reference and application guide. Auto-load when designing a solution, when code is becoming complex, or when asked which pattern to apply.
---

# Design Patterns Reference

Use patterns to solve recognized problems. Don't use them to demonstrate knowledge.

## Pattern Selection Guide

| Problem | Consider |
|---------|---------|
| Need to create objects of different types | Factory, Builder |
| Need multiple objects but only one instance | Singleton (careful) |
| Need to add behavior without changing class | Decorator |
| Need to simplify a complex subsystem | Facade |
| Need objects to react to state changes | Observer |
| Need to swap algorithms at runtime | Strategy |
| Need to undo operations | Command |
| Need to traverse a collection | Iterator |
| Need to define a skeleton with interchangeable steps | Template Method |

---

## Creational Patterns

### Factory Function / Factory Method
Creates objects without specifying the exact class. Prefer over raw `new` for objects that require setup.

```ts
// Factory function (functional style)
function createUser(data: UserData): User {
  return {
    id: generateId(),
    role: data.isAdmin ? 'admin' : 'user',
    ...data,
    createdAt: new Date(),
  };
}

// Factory method (OOP style)
abstract class Transport {
  abstract createVehicle(): Vehicle;  // subclasses decide what to create
}
```

**Use when:** Object creation is complex, or the type to create varies by context.
**Avoid when:** Object creation is trivial — just use `new`.

### Builder
Constructs complex objects step by step.

```ts
class QueryBuilder {
  private query = { table: '', conditions: [], limit: 100 };

  from(table: string) { this.query.table = table; return this; }
  where(condition: string) { this.query.conditions.push(condition); return this; }
  limit(n: number) { this.query.limit = n; return this; }
  build() { return buildSQL(this.query); }
}

const sql = new QueryBuilder()
  .from('users')
  .where('active = true')
  .limit(50)
  .build();
```

**Use when:** An object has many optional parameters, or construction has meaningful steps.
**Avoid when:** The object has only 2-3 required fields — just use a constructor.

### Singleton
Ensures only one instance exists. **Use with extreme caution — creates hidden global state.**

```ts
// Acceptable use: application config (read-only, set once at startup)
class Config {
  private static instance: Config;
  private constructor(private data: Record<string, string>) {}

  static getInstance(data?: Record<string, string>): Config {
    if (!Config.instance) Config.instance = new Config(data ?? {});
    return Config.instance;
  }
}
```

**Use when:** Exactly one instance needed, and it's read-only or thread-safe.
**Avoid:** Database connections (use connection pool), any mutable shared state.

---

## Structural Patterns

### Decorator
Adds behavior to an object without modifying its class.

```ts
interface Logger { log(message: string): void; }

class ConsoleLogger implements Logger {
  log(message: string) { console.log(message); }
}

class TimestampLogger implements Logger {
  constructor(private logger: Logger) {}
  log(message: string) {
    this.logger.log(`[${new Date().toISOString()}] ${message}`);
  }
}

class PrefixLogger implements Logger {
  constructor(private logger: Logger, private prefix: string) {}
  log(message: string) { this.logger.log(`[${this.prefix}] ${message}`); }
}

// Compose decorators
const logger = new PrefixLogger(new TimestampLogger(new ConsoleLogger()), 'AUTH');
logger.log('User logged in');
// → [AUTH] [2024-01-15T10:30:00Z] User logged in
```

**Use when:** Adding optional behaviors that can be combined in multiple ways.

### Facade
Simplifies a complex subsystem with a single interface.

```ts
// Without facade — caller must know about 4 subsystems
const encoder = new VideoEncoder();
const thumbnailer = new ThumbnailGenerator();
const cdn = new CDNUploader();
const db = new MediaDatabase();

// With facade — one simple interface
class VideoUploadService {
  async upload(file: File): Promise<VideoRecord> {
    const encoded = await encoder.encode(file);
    const thumbnail = await thumbnailer.generate(encoded);
    const urls = await cdn.upload(encoded, thumbnail);
    return db.save({ urls, status: 'published' });
  }
}
```

**Use when:** A subsystem is complex but callers only need a simple interface.

### Proxy
Controls access to an object (lazy loading, caching, access control).

```ts
class CachedUserService implements UserService {
  private cache = new Map<string, User>();

  constructor(private real: UserService) {}

  async findById(id: string): Promise<User> {
    if (this.cache.has(id)) return this.cache.get(id)!;
    const user = await this.real.findById(id);
    this.cache.set(id, user);
    return user;
  }
}
```

---

## Behavioral Patterns

### Observer (Event Emitter / Pub-Sub)
Objects subscribe to events from a subject.

```ts
class EventEmitter<T> {
  private handlers: ((event: T) => void)[] = [];
  on(handler: (event: T) => void) { this.handlers.push(handler); }
  emit(event: T) { this.handlers.forEach(h => h(event)); }
}

const orderEvents = new EventEmitter<Order>();
orderEvents.on(order => sendConfirmationEmail(order));
orderEvents.on(order => updateInventory(order));
orderEvents.on(order => notifyWarehouse(order));

// Later
orderEvents.emit(completedOrder);  // all subscribers run
```

**Use when:** Multiple components react to the same event, and you want to decouple them.
**Avoid when:** The chain is simple enough to just call functions directly.

### Strategy
Swap algorithms at runtime without changing the client.

```ts
interface SortStrategy { sort<T>(arr: T[]): T[]; }

class QuickSort implements SortStrategy {
  sort<T>(arr: T[]): T[] { /* quicksort impl */ return arr; }
}

class BubbleSort implements SortStrategy {
  sort<T>(arr: T[]): T[] { /* bubblesort impl */ return arr; }
}

class Sorter {
  constructor(private strategy: SortStrategy) {}
  sort<T>(arr: T[]): T[] { return this.strategy.sort(arr); }
  setStrategy(s: SortStrategy) { this.strategy = s; }
}
```

**Use when:** Multiple variations of an algorithm exist and the choice might change.

### Command
Encapsulates an action as an object. Enables undo, queue, log.

```ts
interface Command { execute(): void; undo(): void; }

class MoveCommand implements Command {
  constructor(private piece: ChessPiece, private from: Position, private to: Position) {}
  execute() { this.piece.moveTo(this.to); }
  undo() { this.piece.moveTo(this.from); }
}

const history: Command[] = [];
const cmd = new MoveCommand(bishop, 'c1', 'f4');
cmd.execute();
history.push(cmd);

// Undo
history.pop()?.undo();
```

**Use when:** You need undo/redo, operation queuing, or audit logs of actions.

---

## When NOT to Use Patterns

- When a simple function solves the problem
- When the pattern introduces more indirection than the benefit it provides
- When the team doesn't know the pattern (unrecognizable code is unmaintainable)
- When you're adding a pattern "for the future" — patterns for hypothetical requirements add complexity with zero benefit today
