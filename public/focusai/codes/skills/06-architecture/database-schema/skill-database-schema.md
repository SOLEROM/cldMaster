---
name: database-schema
description: Database schema design and optimization. Auto-load when designing tables, writing migrations, or optimizing queries.
---

# Database Schema Reference

Design schemas that are correct, performant, and easy to evolve.

## Naming Conventions

```sql
-- Tables: plural snake_case nouns
users, orders, order_items, payment_methods

-- Columns: singular snake_case
user_id, first_name, created_at, is_active

-- Primary keys: `id` (UUID or bigserial)
-- Foreign keys: referenced_table_id (e.g., user_id, order_id)
-- Booleans: is_X, has_X, can_X (e.g., is_active, has_verified_email)
-- Timestamps: always include created_at and updated_at
```

## Data Types — Choose Smallest That Fits

```sql
-- Text
VARCHAR(n)    -- when max length is known and enforced
TEXT          -- when length is variable and unbounded
CHAR(n)       -- only for fixed-length codes (country codes, status flags)

-- Numbers
SMALLINT      -- -32K to 32K (status codes, small counts)
INTEGER       -- -2B to 2B (most IDs, counts)
BIGINT        -- large counts, timestamps in microseconds
NUMERIC(p,s)  -- financial values (exact decimal, not float!)
FLOAT         -- scientific data where approximation is acceptable
-- Never use FLOAT for money — rounding errors accumulate

-- UUIDs vs Sequential IDs
UUID          -- globally unique, safe to expose, no information leak
BIGSERIAL     -- sequential, faster joins and indexes, leaks record count

-- Booleans
BOOLEAN       -- NOT TINYINT(1)

-- Dates and Times
TIMESTAMPTZ   -- always store with timezone (PostgreSQL)
DATE          -- date only, no time
INTERVAL      -- durations (not VARCHAR '7 days')
```

## Constraints — Enforce at Database Level

```sql
-- NOT NULL: prefer over nullable columns
CREATE TABLE orders (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id     UUID NOT NULL REFERENCES users(id),
  status      VARCHAR(20) NOT NULL DEFAULT 'pending',
  total       NUMERIC(10,2) NOT NULL CHECK (total >= 0),
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- UNIQUE constraints
ALTER TABLE users ADD CONSTRAINT users_email_unique UNIQUE (email);

-- CHECK constraints
ALTER TABLE products ADD CONSTRAINT products_price_positive CHECK (price > 0);
ALTER TABLE users ADD CONSTRAINT users_age_valid CHECK (age BETWEEN 0 AND 150);

-- ENUM (or lookup table for larger sets)
CREATE TYPE order_status AS ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled');
```

**Rule:** If you validate in the application layer, also validate in the database. The database is the last line of defense against bad data.

## Normalization (and When to Denormalize)

**1NF:** Each column holds atomic values; no repeating groups
**2NF:** No partial dependency on composite primary key
**3NF:** No transitive dependency (non-key column depending on another non-key column)

```sql
-- Violation of 3NF: order_total depends on order_id, but city depends on zip_code
orders (order_id, customer_name, zip_code, city, order_total)

-- Normalized:
orders (order_id, customer_id, order_total)
customers (customer_id, name, zip_code)
zip_codes (zip_code, city)  -- or just store city on customer
```

**When to denormalize intentionally:**
- Read-heavy tables where joins are the bottleneck
- Reporting/analytics tables (pre-compute aggregates)
- When the normalized join chain is > 3 tables deep for a common query

Always normalize first, denormalize only when profiling reveals a specific bottleneck.

## Indexes

```sql
-- Create indexes for:
-- 1. WHERE clauses on large tables
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status) WHERE status != 'delivered';  -- partial index

-- 2. JOIN columns (usually foreign keys — often already indexed)
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- 3. ORDER BY columns
CREATE INDEX idx_orders_created_at ON orders(created_at DESC);

-- 4. Composite index: column order matters
CREATE INDEX idx_orders_user_status ON orders(user_id, status);
-- This serves: WHERE user_id = ? AND status = ?
-- And: WHERE user_id = ?
-- But NOT: WHERE status = ? (alone — first column must be present)

-- Check for unused indexes
SELECT schemaname, tablename, indexname, idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0 AND indexrelname NOT LIKE '%pkey';
```

**Index anti-patterns:**
- Indexing every column (wastes storage, slows writes)
- Not indexing foreign keys (JOIN performance tanks)
- Indexing low-cardinality columns (boolean, status with 2 values — minimal benefit)

## Migration Patterns

### Zero-Downtime Migrations

```sql
-- BAD: locks table during ALTER
ALTER TABLE users ADD COLUMN age INTEGER NOT NULL;  -- blocks reads/writes

-- GOOD: non-blocking approach
-- Step 1: Add nullable column (instant)
ALTER TABLE users ADD COLUMN age INTEGER;

-- Step 2: Backfill in batches (won't lock)
UPDATE users SET age = 0 WHERE age IS NULL AND id BETWEEN 1 AND 10000;

-- Step 3: Add NOT NULL constraint after backfill (PostgreSQL 12+: no rewrite)
ALTER TABLE users ALTER COLUMN age SET NOT NULL;
```

### Backwards-Compatible Migrations

```
Rename a column safely:
1. Add new column (age_years)
2. Write to both columns in application code
3. Backfill new column from old
4. Read from new column in application code
5. Drop old column (after confirming nothing reads it)
```

## Common Anti-Patterns

| Anti-pattern | Problem | Fix |
|---|---|---|
| Storing JSON everywhere | Unqueryable, no type safety, no constraints | Use proper columns; JSON only for truly unstructured data |
| EAV (Entity-Attribute-Value) | Extremely slow queries, no type safety | Use PostgreSQL JSONB or separate tables |
| Soft delete via `deleted_at` without indexes | Slow queries (must filter deleted everywhere) | Partial index: `WHERE deleted_at IS NULL` |
| String IDs generated in application | Collisions under concurrency, no ordering | Use `gen_random_uuid()` or `BIGSERIAL` |
| No updated_at trigger | No way to track when data changed | Add trigger to auto-update |
| SELECT * in queries | Fetches unused columns, breaks on schema changes | Always select only needed columns |
