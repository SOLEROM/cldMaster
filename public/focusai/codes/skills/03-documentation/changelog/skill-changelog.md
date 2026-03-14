---
name: changelog
description: Generate a changelog from git history. Use when preparing a release, updating CHANGELOG.md, or summarizing what changed in a version.
disable-model-invocation: true
argument-hint: [version-or-date-range]
---

# Changelog

Generate a structured changelog from git history. Version/range: `$ARGUMENTS`

## Step 1: Gather Git History

**Commits since last tag:**
`!git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline --no-merges`

**Files changed:**
`!git diff $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --stat`

**Recent tags:**
`!git tag --sort=-version:refname | head -5`

## Step 2: Categorize Every Commit

| Category | What belongs here |
|----------|------------------|
| **Breaking Changes** | Anything that breaks existing callers |
| **New Features** | New capabilities users can use |
| **Bug Fixes** | Fixes to existing behavior |
| **Performance** | Measurable speed/resource improvements |
| **Security** | CVE fixes, auth changes, data exposure fixes |
| **Internal** | Refactors, tests, CI, deps — NOT user-facing |

**Omit:** `chore: update lockfile`, `fix: typo in comment`, `test: add case`, `WIP`, debug commits.

## Step 3: Rewrite for Users

Raw commits are for developers. Changelog is for users.

| Raw commit | Changelog entry |
|------------|----------------|
| `fix: null check in user resolver` | Fixed crash when loading users with no profile |
| `feat: add Redis adapter` | Added Redis support for session storage |
| `perf: batch DB queries in list endpoint` | Improved list response time by ~60% |
| `feat!: rename config.auth to config.authentication` | **BREAKING:** Renamed `config.auth` to `config.authentication` |

Rules: verb in past tense, user-facing impact (not mechanism), `(#123)` for issues, under 80 chars.

## Step 4: Keep A Changelog Format

```markdown
# Changelog

## [Unreleased]

## [1.3.0] — 2024-03-15

### Breaking Changes
- **Config:** Renamed `config.auth` to `config.authentication`. (#201)

### Added
- Redis adapter for session storage with automatic TTL management (#198)
- `session.invalidateAll(userId)` method to revoke all sessions (#195)

### Fixed
- Fixed crash when loading users with no profile set (#203)
- Fixed email validation rejecting addresses with `+` characters (#199)

### Performance
- Improved list endpoint response time by ~60% via query batching (#197)

### Security
- Updated `jsonwebtoken` to 9.0.2 (CVE-2022-23529)

---

[Unreleased]: https://github.com/org/repo/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/org/repo/compare/v1.2.1...v1.3.0
```

## SemVer Quick Reference

| Bump | When |
|------|------|
| `MAJOR` | Any breaking change |
| `MINOR` | New feature, backward-compatible |
| `PATCH` | Bug fix, security fix |

Breaking change + features in same release = MAJOR (breaking change dominates).
