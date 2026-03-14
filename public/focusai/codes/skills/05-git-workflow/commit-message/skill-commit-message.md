---
name: commit-message
description: Generate a conventional commit message from staged changes. Use when ready to commit and want a well-structured message.
disable-model-invocation: true
allowed-tools: Bash(git *)
---

# Commit Message

Generate a conventional commit message from the staged diff.

## Staged Changes

`!git diff --staged --stat`

## Full Staged Diff

`!git diff --staged`

---

## Conventional Commits Format

```
type(scope): short description

[optional body explaining WHY, not WHAT]

[optional footer: BREAKING CHANGE, closes #123]
```

## Type Reference

| Type | When to use |
|------|------------|
| `feat` | New feature for the user |
| `fix` | Bug fix for the user |
| `docs` | Documentation only |
| `style` | Formatting, no logic change |
| `refactor` | Code restructure, no behavior change |
| `perf` | Performance improvement |
| `test` | Adding or fixing tests |
| `chore` | Build tools, dependencies, config |
| `ci` | CI/CD configuration |
| `build` | Build system changes |

Append `!` for breaking changes: `feat!:`, `fix!:`

## Rules for the Subject Line

- **Imperative mood:** "add feature" not "added feature" or "adds feature"
- **Under 72 characters**
- **Lowercase after colon**
- **No period at the end**
- **Scope is optional:** `feat(auth): add OAuth login` vs `feat: add OAuth login`

## Rules for the Body (When Needed)

- Blank line between subject and body
- Explain **why**, not **what** (the diff shows what)
- Wrap at 72 characters
- Add `Closes #123` to auto-close issues

## Breaking Changes

```
feat!: rename config.auth to config.authentication

BREAKING CHANGE: The `config.auth` key is renamed to `config.authentication`.
Update your configuration files before upgrading.

Closes #201
```

## Generate Three Options

Based on the diff above, generate three commit message options:

**Brief** — just the subject line (one-liner for simple changes)

**Standard** — subject + short body explaining why

**Detailed** — subject + full body with context and any breaking changes

Then ask which to use or offer to customize.

## What Not to Include

- Commit messages that restate the diff ("changed X to Y in file Z")
- "WIP", "fix", "update" with no context
- Author names or dates (git records these)
- Implementation details obvious from reading the code
