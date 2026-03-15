---
name: env-security
description: Environment variable and secrets security. Auto-load when handling .env files, API keys, secrets, credentials, or when asking about secure configuration management.
---

# Environment & Secrets Security Reference

The most common way credentials get leaked is poor secret management. These rules prevent it.

## The Golden Rules

1. **Never hardcode secrets in source code** — ever, even "temporarily"
2. **Never commit `.env` files** — only `.env.example` with placeholder values
3. **Secrets are not config** — they need special handling, not just environment variables
4. **Rotate compromised secrets immediately** — assume they're already exploited

## .env File Patterns

```bash
# .env.example — ALWAYS commit this (shows required vars, no real values)
DATABASE_URL=postgresql://user:password@localhost:5432/mydb
STRIPE_SECRET_KEY=sk_test_your_key_here
JWT_SECRET=your-32-char-secret-here
SENDGRID_API_KEY=SG.your_key_here

# .env — NEVER commit (real values, gitignored)
DATABASE_URL=postgresql://prod_user:ActualP@ss@prod.db.host:5432/prod_db
STRIPE_SECRET_KEY=
```

```gitignore
# .gitignore — must include these
.env
.env.local
.env.*.local
.env.production
*.env
```

## Detecting Leaked Secrets

**Check if you've already leaked secrets:**

```bash
# Search git history for common secret patterns
git log --all --full-history -- "*.env"
git grep -i "secret\|password\|api_key\|private_key" $(git rev-list --all)

# Use truffleHog or gitleaks for comprehensive scan
npx trufflehog git file://. --only-verified
```

**If you find leaked secrets in git history:**
1. Rotate the secret immediately (invalidate the old one)
2. Remove from history with `git filter-branch` or BFG Repo Cleaner
3. Force push (coordinate with team)
4. Assume it was already compromised

## Environment Variable Validation at Startup

Fail fast if required secrets are missing:

```typescript
// config.ts — validate all required env vars at startup
const required = [
  'DATABASE_URL',
  'JWT_SECRET',
  'STRIPE_SECRET_KEY',
] as const;

for (const key of required) {
  if (!process.env[key]) {
    throw new Error(`Missing required environment variable: ${key}`);
  }
}

export const config = {
  database: { url: process.env.DATABASE_URL! },
  jwt: { secret: process.env.JWT_SECRET! },
  stripe: { secretKey: process.env.STRIPE_SECRET_KEY! },
};
```

Don't let the app start silently and fail later — validate at startup.

## Secrets Management Systems (Production)

For production, environment variables in `.env` files are not enough. Use:

| System | Use When |
|--------|----------|
| **AWS Secrets Manager** | AWS infrastructure |
| **HashiCorp Vault** | Multi-cloud, complex rotation needs |
| **Azure Key Vault** | Azure infrastructure |
| **GCP Secret Manager** | GCP infrastructure |
| **Doppler** | Any stack, developer-friendly, team collaboration |
| **1Password Secrets Automation** | Already using 1Password |
| **GitHub/GitLab Secrets** | CI/CD only (not runtime app secrets) |

Benefits over .env files:
- Audit log (who accessed which secret, when)
- Automatic rotation
- Least-privilege access control
- No secret appears in server file system

## Common Secret Types and How to Handle Them

### Database Passwords
```bash
# Use connection string with env var
DATABASE_URL=postgresql://user:${DB_PASS}@host/db

# Rotate: update DB password → update secret in vault → redeploy
# Use IAM authentication where possible (AWS RDS IAM, GCP Cloud SQL IAM)
```

### JWT Secrets
```bash
# Minimum 32 characters, cryptographically random
JWT_SECRET=$(openssl rand -hex 32)

# Use asymmetric keys for distributed systems
# Private key signs tokens, public key verifies — share public key freely
JWT_PRIVATE_KEY=...RSA private key...
JWT_PUBLIC_KEY=...RSA public key...
```

### API Keys
```bash
# Use separate keys per environment (dev, staging, prod)
# Use the minimum scope/permissions the key needs
# Set IP allowlists where the API provider supports it
# Monitor usage — set up alerts for unusual activity
```

### Third-Party OAuth Credentials
```bash
GOOGLE_CLIENT_ID=...         # Not secret — can be public
GOOGLE_CLIENT_SECRET=...     # Secret — never expose
```

## What Should NOT Be in Environment Variables

Environment variables are **not** appropriate for:
- Large configuration files (use mounted volumes or config files)
- Binary data or certificates (use files or secrets manager)
- Secrets shared across many services (use a secrets manager with proper ACL)

## Logging Safety

```typescript
// BAD — leaks secrets to logs
console.log('Config:', config);                    // logs entire config object
console.log(`Connecting to: ${DATABASE_URL}`);     // exposes password in URL
logger.error('Auth failed', { headers: req.headers }); // exposes Authorization header

// GOOD — redact sensitive values
console.log('Config:', { ...config, jwt: '[REDACTED]', database: '[REDACTED]' });
console.log('Connecting to DB:', maskConnectionString(DATABASE_URL));

function maskConnectionString(url: string): string {
  return url.replace(/\/\/([^:]+):([^@]+)@/, '//$1:***@');
}
```

## Pre-Commit Secret Scanning

```bash
# Install pre-commit hook with gitleaks
brew install gitleaks                    # or download binary
gitleaks protect --staged --verbose      # scan staged files

# Add to .pre-commit-config.yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks
```

## Security Checklist

- [ ] `.env` files are in `.gitignore`
- [ ] `.env.example` committed with placeholder values
- [ ] No secrets hardcoded in source code (`grep -r "sk_live\|api_key\s*=" src/`)
- [ ] Git history scanned for past leaks
- [ ] All required env vars validated at startup
- [ ] Separate credentials per environment (dev/staging/prod)
- [ ] Secrets management system used in production (not .env files)
- [ ] Sensitive values excluded from logs
- [ ] Pre-commit secret scanning hook installed
- [ ] API key rotation plan documented
