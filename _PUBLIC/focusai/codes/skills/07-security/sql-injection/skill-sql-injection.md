---
name: sql-injection
description: SQL injection prevention and detection. Auto-load when writing database queries, reviewing DB access code, or when asked about SQL security.
---

# SQL Injection Prevention Reference

SQL injection is the #1 most dangerous web vulnerability. It's also completely preventable.

## What SQL Injection Is

When user input is concatenated into a SQL query instead of parameterized, an attacker can inject SQL syntax that changes the query's meaning.

```sql
-- Vulnerable code (Node.js + MySQL example)
const query = `SELECT * FROM users WHERE email = '${email}'`;

-- Attacker inputs: ' OR '1'='1
-- Query becomes:
SELECT * FROM users WHERE email = '' OR '1'='1'
-- Returns ALL users — authentication bypassed

-- Attacker inputs: '; DROP TABLE users; --
-- Query becomes:
SELECT * FROM users WHERE email = ''; DROP TABLE users; --'
-- Deletes the entire users table
```

## The Fix: Parameterized Queries (Always)

```typescript
// ❌ NEVER — string concatenation
const users = await db.query(`SELECT * FROM users WHERE id = ${userId}`);
const users = await db.query("SELECT * FROM users WHERE email = '" + email + "'");

// ✅ ALWAYS — parameterized queries
// Node.js + mysql2
const [users] = await db.execute('SELECT * FROM users WHERE id = ?', [userId]);

// Node.js + pg (PostgreSQL)
const result = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);

// Python + psycopg2
cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))

// Python + SQLAlchemy ORM
user = session.query(User).filter(User.id == user_id).first()

// Ruby on Rails ActiveRecord
User.where(id: user_id)          # ✅ parameterized automatically
User.where("id = #{user_id}")    # ❌ SQL injection vulnerable
User.where("id = ?", user_id)    # ✅ also fine

// Java + JDBC
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
stmt.setInt(1, userId);
```

## ORMs Are Safe — If Used Correctly

```typescript
// Prisma (TypeScript) — safe
const user = await prisma.user.findUnique({ where: { id: userId } });

// TypeORM — safe
const user = await userRepository.findOne({ where: { id: userId } });

// TypeORM raw query — UNSAFE if concatenated
const user = await userRepository.query(
  `SELECT * FROM users WHERE id = ${userId}` // ❌
);
// TypeORM raw query — safe with parameters
const user = await userRepository.query(
  'SELECT * FROM users WHERE id = ?', [userId] // ✅
);

// Sequelize — safe
User.findOne({ where: { id: userId } });

// Sequelize with literal — UNSAFE
User.findAll({ where: Sequelize.literal(`id = ${userId}`) }); // ❌
```

**Rule:** Raw/literal queries with string concatenation bypass ORM protection.

## Dynamic Table/Column Names

Parameterization only works for values, NOT for table names, column names, or SQL keywords.
When these must be dynamic, use an allowlist:

```typescript
// BAD — cannot parameterize table names
const query = `SELECT * FROM ${tableName}`; // SQL injection risk!

// GOOD — allowlist validation
const ALLOWED_TABLES = ['users', 'orders', 'products'] as const;
type AllowedTable = typeof ALLOWED_TABLES[number];

function getFromTable(tableName: string) {
  if (!ALLOWED_TABLES.includes(tableName as AllowedTable)) {
    throw new Error(`Invalid table name: ${tableName}`);
  }
  return db.query(`SELECT * FROM ${tableName}`); // safe: allowlisted
}

// Same for ORDER BY columns
const ALLOWED_SORT_COLUMNS = ['name', 'created_at', 'price'] as const;
const ALLOWED_SORT_DIRECTIONS = ['ASC', 'DESC'] as const;

function buildOrderBy(column: string, direction: string): string {
  const col = ALLOWED_SORT_COLUMNS.includes(column as any) ? column : 'created_at';
  const dir = ALLOWED_SORT_DIRECTIONS.includes(direction.toUpperCase() as any)
    ? direction.toUpperCase()
    : 'ASC';
  return `${col} ${dir}`;
}
```

## Stored Procedures

Stored procedures are NOT automatically safe:

```sql
-- SAFE stored procedure — uses parameterized input
CREATE PROCEDURE GetUser(@UserId INT)
AS
  SELECT * FROM users WHERE id = @UserId;

-- UNSAFE stored procedure — dynamic SQL via EXEC/sp_executesql with concatenation
CREATE PROCEDURE SearchUsers(@Filter NVARCHAR(100))
AS
  EXEC('SELECT * FROM users WHERE name LIKE ''' + @Filter + ''''); -- ❌ VULNERABLE
```

## Defense in Depth

Beyond parameterization:

```sql
-- 1. Principle of least privilege
-- App DB user should only have SELECT/INSERT/UPDATE/DELETE
-- NOT DROP, CREATE, ALTER, GRANT
-- NOT access to system tables

-- 2. Separate credentials per operation
-- read_user: SELECT only
-- write_user: INSERT, UPDATE, DELETE
-- admin_user: DDL (migrations only, never used by app)

-- 3. Schema isolation
-- App only has access to its own schema
-- No access to other databases/schemas
```

```typescript
// 4. Input validation (not a substitute for parameterization, but adds depth)
function validateUserId(id: unknown): number {
  const parsed = parseInt(String(id), 10);
  if (isNaN(parsed) || parsed <= 0) {
    throw new Error('Invalid user ID');
  }
  return parsed;
}
```

## Detecting SQL Injection in Code Review

Look for these patterns as injection risks:

```bash
# Search for dangerous patterns in codebase
grep -rn "query\s*[+=]\s*[\"'].*\$" src/         # Template literal in query
grep -rn "execute\s*[\"'].*\+\s*" src/            # String concatenation
grep -rn "\.raw\(" src/                            # Raw SQL calls
grep -rn "Sequelize\.literal\(" src/               # Sequelize literal
grep -rn "queryRunner\.query\(" src/               # TypeORM raw
```

## Testing for SQL Injection

```bash
# Quick manual test — try these as input values:
'                               # Single quote — should cause error or be escaped
' OR '1'='1                     # Classic bypass
' OR 1=1--                      # Comment-based bypass
'; SELECT SLEEP(5)--            # Time-based blind injection test (MySQL)
' UNION SELECT null--           # Union-based test
\x00                            # Null byte

# Automated scanning
sqlmap -u "https://target.com/users?id=1" --batch
# (Only on systems you own or have written permission to test!)
```

## Quick Reference

| Risk | Safe Pattern |
|------|-------------|
| String concat in query | Use `?` or `$1` placeholders |
| Dynamic table name | Allowlist validation |
| Dynamic column name | Allowlist validation |
| ORM literal/raw | Parameterize or allowlist |
| LIKE with wildcards | `LIKE ?` with `%` in the value, not the query |
| IN clause | Most ORMs handle this — if raw, build `?,?,?` from array length |
