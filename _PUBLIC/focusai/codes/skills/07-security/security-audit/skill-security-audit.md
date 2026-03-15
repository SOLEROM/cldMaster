---
name: security-audit
description: Comprehensive application security audit. Auto-load when asked to review code for security issues, before going to production, or when security vulnerabilities are suspected.
disable-model-invocation: true
---

# Security Audit

You are performing a comprehensive security audit of the provided code.

## OWASP Top 10 — Check Every Category

### A01: Broken Access Control
- Can users access resources they shouldn't (horizontal privilege escalation)?
- Can regular users perform admin actions (vertical privilege escalation)?
- Are authorization checks on the server-side (never trust client)?
- Are direct object references validated (`GET /invoices/123` — can user 456 access it)?
- Is CORS configured correctly (not `Access-Control-Allow-Origin: *` on authenticated endpoints)?

### A02: Cryptographic Failures
- Is sensitive data stored unencrypted (passwords, PII, payment info)?
- Are passwords hashed with bcrypt/argon2/scrypt (NOT MD5/SHA1/SHA256)?
- Is HTTPS enforced everywhere (no HTTP fallback)?
- Are secrets in environment variables (NOT hardcoded in source)?
- Is TLS 1.2+ required (no SSLv3, TLS 1.0, TLS 1.1)?

### A03: Injection
- SQL injection: are all DB queries parameterized (no string concatenation)?
- Command injection: is `exec()`, `eval()`, `system()` used with user input?
- LDAP/XPath/NoSQL injection: are inputs sanitized before queries?
- Template injection: is user input rendered in templates?

### A04: Insecure Design
- Are there rate limits on authentication endpoints?
- Is there account lockout after failed attempts?
- Are business logic rules enforced server-side?
- Is "security by obscurity" the only protection?

### A05: Security Misconfiguration
- Are default credentials changed?
- Are debug/development features disabled in production?
- Are error messages revealing stack traces to users?
- Are unnecessary ports, services, accounts enabled?
- Is the security HTTP headers configured (see CSP, HSTS, X-Frame-Options)?

### A06: Vulnerable Components
- Are dependencies up to date? (`npm audit`, `safety check`)
- Are there known CVEs in used library versions?
- Are development dependencies excluded from production builds?

### A07: Authentication Failures
- Are sessions invalidated on logout?
- Are session IDs regenerated after login?
- Are passwords validated for complexity?
- Is MFA available for sensitive operations?
- Are "remember me" tokens stored securely (httpOnly cookies)?

### A08: Software and Data Integrity
- Are file uploads validated (type, size, content — not just extension)?
- Are deserialized objects from untrusted sources validated?
- Are CI/CD pipelines protected from unauthorized changes?

### A09: Logging and Monitoring Failures
- Are authentication failures logged?
- Are privileged operations logged?
- Are logs protected from tampering?
- Are sensitive values (passwords, tokens) excluded from logs?
- Are alerts configured for suspicious activity?

### A10: Server-Side Request Forgery (SSRF)
- Does the application fetch URLs from user input?
- Is there validation to prevent fetching internal network addresses?
- Are cloud metadata endpoints (169.254.169.254) blocked?

---

## Audit Output Format

For each finding, report:

```
[SEVERITY] Category — Finding Title

Location: file.js:line_number (or endpoint/area if no specific line)

Description:
What the vulnerability is and why it's dangerous.

Evidence:
Specific code or configuration that demonstrates the issue.

Impact:
What an attacker could do if this is exploited.

Recommendation:
Concrete fix with code example if applicable.
```

Severity levels:
- **CRITICAL** — Exploitable now, immediate data breach / system compromise risk
- **HIGH** — Significant risk, fix before next release
- **MEDIUM** — Risk requires specific conditions, fix within 30 days
- **LOW** — Defense in depth improvement, fix when convenient
- **INFO** — Best practice violation, no direct attack vector

---

## Summary Section

End your audit with:

```
## Audit Summary

Total findings: X (Y Critical, Z High, A Medium, B Low, C Info)

Most critical issues:
1. [Brief description of highest-priority finding]
2. ...

Recommended immediate actions:
1. ...

Overall security posture: [Poor / Needs Improvement / Adequate / Good]
```
