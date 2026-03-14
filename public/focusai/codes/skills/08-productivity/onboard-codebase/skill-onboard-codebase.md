---
name: onboard-codebase
description: Rapid codebase onboarding and exploration. Auto-load when joining a new project, exploring an unfamiliar codebase, or when asked to understand how a project is structured.
context: fork
agent: Explore
---

# Codebase Onboarding

You are doing a thorough exploration of this codebase to understand its structure, patterns, and key entry points. Produce a comprehensive onboarding report.

## Exploration Checklist

Work through these systematically:

### 1. Project Identity
- Language(s), framework(s), runtime version
- Package manager and dependency count
- Project purpose (infer from README, package.json description, main routes)

### 2. Entry Points
- Where does the application start? (main.ts, index.js, app.py, server.js)
- What are the top-level routes or handlers?
- What's the build/start command?

### 3. Folder Structure
- Map the top-level directories and their purpose
- Identify the feature/domain boundaries
- Find where components, services, models, and tests live

### 4. Configuration
- Environment variables required (.env.example)
- Config files (tsconfig, webpack, vite, etc.)
- Feature flags or environment-specific behavior

### 5. Data Layer
- Database type and ORM/query library
- Schema location (migrations, models, prisma.schema)
- Key entities and their relationships

### 6. Authentication & Authorization
- Auth mechanism (JWT, sessions, OAuth?)
- Middleware location
- Role/permission system

### 7. External Integrations
- Third-party APIs and services called
- Webhooks received
- Message queues or event buses

### 8. Testing Setup
- Test framework (Jest, Vitest, Pytest, RSpec?)
- Test structure (co-located or separate `/tests`?)
- How to run tests

### 9. Deployment
- CI/CD config (GitHub Actions, CircleCI, etc.)
- Deployment target (Docker, serverless, VPS?)
- Environment stages (dev, staging, prod)

### 10. Known Patterns
- State management approach
- Error handling conventions
- Logging setup
- Code style / linting configuration

## Output Format

```
# Codebase Onboarding Report

## TL;DR
[2-3 sentences: what this project does, main tech stack, maturity level]

## Project Structure
[annotated directory tree, 2 levels deep]

## Getting Started
[commands to install, configure, and run locally]

## Key Files to Know
[10-15 most important files with one-line descriptions]

## Architecture Overview
[how the pieces connect — data flow, request lifecycle]

## Gotchas & Non-Obvious Things
[things that would take a new developer days to discover]

## Where to Make Changes
[for common tasks: "to add a new API endpoint, look at...", "to add a UI component..."]

## Open Questions
[things you couldn't determine from the codebase alone]
```

Explore the codebase thoroughly before writing the report. Read actual source files — don't guess from file names alone.
