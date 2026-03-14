---
name: performance-review
description: Analyze code for performance issues and bottlenecks. Use when code feels slow, before deploying to production, or when optimizing critical paths.
argument-hint: [file-or-module]
---

# Performance Review

Analyze the specified code for performance issues. Always profile before optimizing — identify the actual bottleneck before touching code.

## The Golden Rule

> "Premature optimization is the root of all evil." — Knuth
> But: "Measure first, then optimize the hot path."

Before any optimization: identify WHERE the slowness is, not WHERE you THINK it is.

---

## Review Categories

### 1. Algorithmic Complexity
- Identify the Big-O of each significant operation
- Flag O(n²) or worse where O(n log n) or O(n) is achievable
- Nested loops over the same data = likely O(n²) smell
- Sorts inside loops (sort is O(n log n), inside loop = O(n² log n))
- Linear search on large datasets → consider index or Map/Set

### 2. Database / I/O Patterns
**N+1 Query Pattern** (most common performance killer):
```
// BAD — N+1: one query for list, one per item
const posts = await getPosts();
for (const post of posts) {
  post.author = await getUser(post.authorId); // N queries!
}

// GOOD — batch fetch
const posts = await getPosts();
const authorIds = posts.map(p => p.authorId);
const authors = await getUsersByIds(authorIds); // 1 query
```
- Eager loading vs lazy loading: load related data upfront when always needed
- Avoid SELECT * — fetch only needed columns
- Pagination: never load unbounded datasets into memory
- Indexes: queries filtering/sorting on un-indexed columns

### 3. Memory & Allocation
- Large arrays/objects created inside tight loops (allocate once, reuse)
- Unnecessary data copying (spread `...` inside loops)
- String concatenation in loops → use array.join() or template literals
- Memory leaks: event listeners, subscriptions, timers not cleaned up
- Large objects in closure scope that prevent GC

### 4. Frontend / React
- Unnecessary re-renders: components re-rendering on every parent update
- Missing `useMemo` / `useCallback` on expensive computations passed as props
- Large lists without virtualization (react-window, react-virtual)
- Images not optimized or lazy-loaded
- Bundle size: heavy libraries imported in full (`import _ from 'lodash'` vs `import pick from 'lodash/pick'`)
- Blocking the main thread: heavy computation without Web Workers

### 5. Async & Concurrency
- Sequential async calls that could run in parallel:
```
// BAD — sequential (slow)
const user = await getUser(id);
const posts = await getPosts(id);

// GOOD — parallel (fast)
const [user, posts] = await Promise.all([getUser(id), getPosts(id)]);
```
- Missing caching for repeated identical async calls
- Retry storms: no exponential backoff

### 6. Caching Opportunities
- Results of expensive pure functions (memoization)
- API responses with stable data (HTTP cache headers, in-memory cache)
- Computed values that don't change between renders
- Database query results for read-heavy, write-rarely data

---

## Output Format

**Profiling First:**
Suggest which profiling tool to use before optimizing:
- Node.js: `--prof` flag, clinic.js, 0x
- Browser: Chrome DevTools Performance tab, Lighthouse
- React: React DevTools Profiler

**For each issue found:**
```
[HIGH/MEDIUM/LOW] Category — Location
Current: [What the code does and why it's slow]
Impact: [Estimated impact: latency / memory / CPU]
Fix: [Concrete optimization with before/after code]
Tradeoff: [Any readability/maintainability cost of the optimization]
```

End with: Top 3 highest-impact changes, ordered by impact/effort ratio.
