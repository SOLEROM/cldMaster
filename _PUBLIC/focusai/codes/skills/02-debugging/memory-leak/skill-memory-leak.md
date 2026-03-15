---
name: memory-leak
description: Memory leak detection and prevention. Auto-load when working with event listeners, subscriptions, React components, WebSockets, or long-running Node.js processes.
---

# Memory Leak Patterns

Reference for identifying and preventing common memory leaks. A memory leak occurs when memory is allocated but never released, causing the process to grow until it crashes or slows down.

---

## Common Leak Patterns

### 1. Event Listeners Not Removed

```javascript
// BAD — listener accumulates every time component mounts
function Component() {
  useEffect(() => {
    window.addEventListener('resize', handleResize);
    // Missing cleanup!
  }, []);
}

// GOOD
function Component() {
  useEffect(() => {
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize); // cleanup
  }, []);
}

// GOOD (Node.js EventEmitter)
const handler = (data) => process(data);
emitter.on('data', handler);
// Later:
emitter.off('data', handler); // or emitter.removeListener('data', handler)
```

### 2. Subscriptions Not Cancelled

```javascript
// BAD — Observable/subscription held forever
class MyComponent {
  ngOnInit() {
    this.userSubscription = this.userService.getUser().subscribe(/* ... */);
  }
  // Missing ngOnDestroy!
}

// GOOD (Angular)
class MyComponent implements OnDestroy {
  private destroy$ = new Subject<void>();

  ngOnInit() {
    this.userService.getUser()
      .pipe(takeUntil(this.destroy$))
      .subscribe(/* ... */);
  }

  ngOnDestroy() {
    this.destroy$.next();
    this.destroy$.complete();
  }
}
```

### 3. Timers Not Cleared

```javascript
// BAD — interval runs forever even if component is unmounted
function Component() {
  useEffect(() => {
    const interval = setInterval(pollData, 5000);
    // No cleanup
  }, []);
}

// GOOD
function Component() {
  useEffect(() => {
    const interval = setInterval(pollData, 5000);
    return () => clearInterval(interval); // cleanup
  }, []);
}
```

### 4. Closures Holding References

```javascript
// BAD — the closure keeps a reference to the entire element
function attachHandler(element) {
  const data = element.getData(); // holds reference via closure
  element.addEventListener('click', function() {
    console.log(data); // even if element is removed from DOM, data stays in memory
  });
}

// GOOD — extract only what the handler needs
function attachHandler(element) {
  const neededData = element.getData().id; // only the primitive value
  element.addEventListener('click', function() {
    console.log(neededData);
  });
}
```

### 5. Cache Without Eviction

```javascript
// BAD — cache grows unbounded
const cache = new Map();
function getCachedData(key) {
  if (!cache.has(key)) {
    cache.set(key, fetchExpensiveData(key));
  }
  return cache.get(key);
}

// GOOD — use WeakMap for object keys (GC can collect)
const cache = new WeakMap(); // keys are garbage collected when no other reference exists

// GOOD — LRU cache with max size
import LRU from 'lru-cache';
const cache = new LRU({ max: 500 });
```

### 6. Global State Accumulation

```javascript
// BAD — logs array in module scope grows forever
const logs = [];
function logEvent(event) {
  logs.push(event); // never cleared
}

// GOOD
const MAX_LOGS = 1000;
function logEvent(event) {
  logs.push(event);
  if (logs.length > MAX_LOGS) logs.shift(); // remove oldest
}
```

### 7. Circular References (older engines)

Modern V8 handles most circular references, but watch for:
- Objects holding references to their parent AND parent holds reference to child
- DOM elements with data stored as JS properties (jQuery `.data()`)
- Node.js EventEmitters stored on objects that are stored on the emitter

---

## WeakMap vs Map for Caches

| | `Map` | `WeakMap` |
|--|-------|-----------|
| Keys | Any value | Objects only |
| Memory | Prevents GC of keys | Keys GC'd when no other reference |
| Iterable | Yes | No |
| Use for | General cache | Caching per-object metadata |

Use `WeakMap` when the cache lifetime should follow an object's lifetime.

---

## Detection Tools

### Browser (Chrome DevTools)
1. Open DevTools → Memory tab
2. Take Heap Snapshot (baseline)
3. Perform the suspected leaking action several times
4. Take another Heap Snapshot
5. Compare: look for objects that grew significantly
6. Filter by "Objects allocated between Snapshot 1 and 2"

### Node.js
```bash
# Generate heap snapshot
node --inspect your-app.js
# Then use Chrome DevTools: chrome://inspect
# Or use heapdump package:
const heapdump = require('heapdump');
heapdump.writeSnapshot('/tmp/leak-' + Date.now() + '.heapsnapshot');
```

Or watch memory usage:
```javascript
setInterval(() => {
  const used = process.memoryUsage();
  console.log(`Heap: ${Math.round(used.heapUsed / 1024 / 1024)}MB`);
}, 5000);
```

---

## Prevention Checklist

- [ ] Every `addEventListener` has a corresponding `removeEventListener`
- [ ] Every subscription has a cleanup/unsubscribe
- [ ] Every `setInterval`/`setTimeout` is cleared in component unmount
- [ ] Caches have size limits or use `WeakMap`
- [ ] Global state arrays have maximum size enforcement
- [ ] React `useEffect` always returns cleanup when attaching anything
