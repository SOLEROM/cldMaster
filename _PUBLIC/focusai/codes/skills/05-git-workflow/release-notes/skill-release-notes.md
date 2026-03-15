---
name: release-notes
description: Generate user-facing release notes for a new version. Use when preparing a release, writing CHANGELOG.md entries, or communicating changes to users.
disable-model-invocation: true
argument-hint: [version-number]
---

# Release Notes

Generate user-facing release notes. Version: `$ARGUMENTS`

## Gather Git Context

**Commits since last release:**
`!git log $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --oneline --no-merges`

**Files changed:**
`!git diff $(git describe --tags --abbrev=0 2>/dev/null || git rev-list --max-parents=0 HEAD)..HEAD --name-only | head -30`

**Recent tags:**
`!git tag --sort=-version:refname | head -5`

---

## Commit Triage

**Include in release notes:**
- New features users can use
- Bug fixes users would notice
- Performance improvements (with numbers)
- Security fixes (especially CVEs)
- Breaking changes (ALWAYS include)

**Omit or put in "Internal":**
- `chore: update lockfile`
- `fix: typo in comment`
- `test: add missing coverage`
- `ci: fix flaky timeout`
- `WIP`, debug commits, squashed fixups

## Rewrite for Users

| Raw commit | Release note |
|-----------|--------------|
| `fix: null check in user resolver` | Fixed crash when loading users with no profile configured |
| `feat: add Redis session adapter` | Added Redis support for session storage (dramatically reduces database load) |
| `perf: batch DB queries in /users` | Users list endpoint is now ~60% faster |
| `feat!: rename config.auth to config.authentication` | **⚠️ BREAKING:** Renamed `config.auth` to `config.authentication` in config files |
| `fix(cve): update jsonwebtoken to 9.0.2` | Security: Updated JWT library to address CVE-2022-23529 |

**Writing rules:**
- Past tense: "Added", "Fixed", "Improved", "Removed"
- User outcome, not implementation: "Users can now X" not "Implemented X in service Y"
- Numbers for performance: "~60% faster" not just "faster"
- Under 80 characters per line
- Issue reference: `(#123)` at the end

---

## Release Notes Format

```markdown
# Release Notes — v$ARGUMENTS

**Released:** $(date +%Y-%m-%d)

---

## ⚠️ Breaking Changes

These changes require action before upgrading:

- **Config:** Renamed `config.auth` to `config.authentication`. Update config files before deploying. (#201)
- **API:** `GET /users` now requires `Authorization` header. Update clients. (#198)

---

## ✨ What's New

- Added Redis support for session storage — dramatically reduces database load on auth endpoints (#197)
- Users can now export their data as CSV from Account Settings (#203)
- Added `session.invalidateAll(userId)` to revoke all sessions for a user (#195)

## 🐛 Bug Fixes

- Fixed crash when loading users with no profile configured (#210)
- Fixed email validation incorrectly rejecting addresses with `+` characters (#208)
- Fixed order total showing incorrect amount when discount codes are applied (#205)

## ⚡ Performance

- Users list endpoint is now ~60% faster due to query batching (#197)
- Dashboard load time reduced by 40% with lazy loading for charts (#199)

## 🔒 Security

- Updated `jsonwebtoken` to 9.0.2 (addresses CVE-2022-23529)
- Session tokens are now invalidated server-side on logout (not just client-side)

## 📦 Upgrading

\`\`\`bash
npm install your-package@$ARGUMENTS
\`\`\`

If you have breaking changes: list the steps to migrate here.
```

---

## SemVer Decision

| What changed | Version bump |
|-------------|-------------|
| Any breaking change | MAJOR |
| New feature, backward-compatible | MINOR |
| Bug fix, security fix | PATCH |
| Breaking + features | MAJOR (breaking dominates) |
