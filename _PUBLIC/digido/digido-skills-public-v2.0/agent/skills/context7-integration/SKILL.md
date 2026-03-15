---
name: Context7 Integration
description: Decision rules for when to look up external documentation and when not to. Prevents unnecessary context pollution from doc lookups, while ensuring the agent doesn't guess when real docs are needed. Uses Context7 MCP for library resolution and doc queries.
---

# Context7 Integration

<role>
You are the gatekeeper for external documentation lookups.

Most of the time, you already know the answer. Python's standard library hasn't changed. Looking it up wastes context and adds noise.

But sometimes you DON'T know — a library updated its API, a new version has breaking changes, or you've never used this package before. NOT looking it up leads to guessing, and guessing leads to bugs.

Your job: Know the difference. Look up docs when you need them. Don't when you don't.
</role>

---

## Core Principle

> **Default: Don't look it up.**
>
> Only reach for external docs when you have a specific reason to doubt your knowledge.
> The cost of an unnecessary lookup is context pollution.
> The cost of a missing lookup is a wrong implementation.

---

## Decision Matrix

### YES — Look It Up

| Situation | Example |
|-----------|---------|
| **Unfamiliar library** | `polars`, `pydantic v2`, `langchain` |
| **Version-sensitive API** | `openai` (v0 → v1), `sqlalchemy 2.0` |
| **Error smells like version mismatch** | `TypeError: unexpected keyword argument` on a known function |
| **External service API** | Supabase, OpenAI, Stripe, Firebase |
| **User explicitly asks** | "תבדוק מה הדרך העדכנית" / "check the latest docs" |
| **Complex configuration** | pytest config, logging config, pyproject.toml |
| **Security-sensitive code** | `cryptography`, `jwt`, `hashlib` usage patterns |
| **New framework patterns** | FastAPI dependency injection, SQLAlchemy 2.0 style |

### NO — Don't Look It Up

| Situation | Example |
|-----------|---------|
| **Python built-ins / standard library** | `os`, `json`, `pathlib`, `datetime`, `re` |
| **Basic language features** | list comprehension, dict methods, f-strings |
| **Info already in context** | Docs pasted in chat, README already loaded |
| **Trivial operations** | `open()`, `json.dumps()`, `os.path.exists()` |
| **Same lookup twice in session** | Don't re-query what you already have |

For detailed library-by-library reference, see [references/library-reference.md](references/library-reference.md).

---

## The Lookup Process

1. **Resolve library** — identify exact library + version (`pip show`)
   ```
   resolve-library-id → get the library identifier
   ```
2. **Query specific** — not "openai documentation" but "openai chat completions create python"
   ```
   query-docs → specific topic, not the whole library
   ```
3. **Extract only what you need** — function signature, required imports, minimal example, breaking changes. Discard everything else.
4. **Apply and move on** — don't keep docs open.

---

## Context Budget Rules

```
Per lookup:     Keep extracted info under 50 lines
Per session:    Maximum 5-7 lookups
Per topic:      One lookup. If you need more, you're reading too broadly.
```

### Signs You're Over-Looking-Up

- 3+ lookups and no code written yet
- Reading "getting started" for libraries you've used before
- Looking up things "just to be safe"
- Loading full API references instead of specific functions

**If this happens: STOP. Write the code. Look up ONLY when you hit an actual problem.**

For worked examples of lookup decisions in real scenarios, see [references/scenarios.md](references/scenarios.md).

---

## Integration With Other Skills

- **python-debugger** → When error suggests version mismatch, debugger triggers Context7 lookup BEFORE guessing.
- **python-executor** → During execution, if encountering unfamiliar API, executor pauses and consults Context7.
- **python-codebase-mapper** → Mapper identifies project libraries. Context7 checks for known breaking changes.
- **user-explainer** → If lookup reveals breaking change, explainer tells user: "הספרייה עודכנה ויש שינויים. אני מתאים את הקוד."

---

## Quick Reference

```
DEFAULT: Don't look it up.

LOOK UP:  Unfamiliar lib | Version-sensitive | Error=version mismatch
          External API | User asks | Security code | Complex config

DON'T:   stdlib | Basic Python | Already in context | Same lookup twice

PROCESS:  Resolve lib → Query specific → Extract <50 lines → Apply & move on

BUDGET:   <50 lines/lookup | 5-7 lookups/session | 1 lookup/topic
```
