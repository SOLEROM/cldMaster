# Common Lookup Scenarios

## Scenario 1: New Project, Unknown Stack

```
User starts a project with FastAPI + SQLAlchemy + Alembic.
You've used FastAPI before, but not with SQLAlchemy 2.0.

Decision:
  FastAPI basics      → ❌ Don't look up (you know this)
  SQLAlchemy 2.0      → ✅ Look up (2.0 has new API patterns)
  Alembic             → ✅ Look up (migration commands are easy to get wrong)
  Python typing       → ❌ Don't look up (standard)
  Pydantic v2         → ✅ Look up (v1 → v2 had breaking changes)
```

## Scenario 2: Debugging an Import Error

```
Error: ImportError: cannot import name 'ChatCompletion' from 'openai'

Decision:
  → ✅ Look up — this smells like openai v0 → v1 migration.
     The import path changed completely.

  Query: "openai v1 migration chat completions import"
  Extract: New import path + minimal example
```

## Scenario 3: Writing a Simple Script

```
User wants a script that reads CSV, filters rows, writes JSON.

Decision:
  csv module      → ❌ Don't look up
  json module     → ❌ Don't look up
  pathlib         → ❌ Don't look up

  Total lookups: 0. Just write it.
```

## Scenario 4: Error After pip install

```
Installed a package. Code that used to work now throws TypeError.

Decision:
  → ✅ Look up — the package likely updated with breaking changes.

  First: pip show package_name → check version
  Then:  Query changelog/migration guide for that version
  Extract: What changed + how to update code
```

## Scenario 5: User Says "Use Supabase"

```
User wants to connect to Supabase from Python.

Decision:
  supabase-py     → ✅ Look up (external service, API changes)
  .env loading    → ❌ Don't look up (python-dotenv, you know this)
  HTTP basics     → ❌ Don't look up

  Query: "supabase python client insert select auth"
  Extract: Client init + CRUD examples
```
