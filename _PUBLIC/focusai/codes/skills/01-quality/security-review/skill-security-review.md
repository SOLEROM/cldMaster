---
name: security-review
description: Security-focused code audit based on OWASP Top 10. Use when reviewing code for vulnerabilities, before shipping features that handle user data, or when explicitly requested.
disable-model-invocation: true
argument-hint: [file-or-scope]
---

# Security Review

Perform a security-focused audit of the specified code. This is a deliberate, explicit review — do not auto-trigger on general code review requests.

## OWASP Top 10 Checklist

### A01 — Broken Access Control
- [ ] Access control checks on every protected route/function (server-side)
- [ ] No reliance on client-provided role or permission values
- [ ] Direct Object References validated against the current user's permissions (IDOR check)
- [ ] Principle of least privilege applied to service accounts and API keys
- [ ] CORS policy is restrictive, not `*`

### A02 — Cryptographic Failures
- [ ] No sensitive data stored in plaintext (passwords, PII, financial data)
- [ ] Passwords hashed with bcrypt, argon2, or scrypt (NOT md5, sha1, sha256)
- [ ] Encryption keys not hardcoded; stored in secrets manager
- [ ] TLS enforced; HTTP not used for any sensitive endpoint
- [ ] Tokens/sessions have appropriate expiry

### A03 — Injection
- [ ] No string concatenation in SQL queries → use parameterized queries
- [ ] No user input in shell commands → use execFile, not exec
- [ ] No direct HTML interpolation of user data → use framework escaping
- [ ] NoSQL queries sanitized (MongoDB $where, $regex from user input)
- [ ] XML/JSON parsing from untrusted sources uses safe parsers

### A04 — Insecure Design
- [ ] Rate limiting on authentication and sensitive endpoints
- [ ] Account enumeration not possible via timing or error messages
- [ ] Password reset flow is secure (token expiry, single-use)
- [ ] Sensitive operations require re-authentication

### A05 — Security Misconfiguration
- [ ] Debug mode disabled in production
- [ ] Default credentials changed
- [ ] Stack traces not exposed to users
- [ ] Unnecessary features/endpoints disabled
- [ ] Security headers present (CSP, HSTS, X-Frame-Options)

### A06 — Vulnerable Components
- [ ] Dependencies checked against known CVE database (`npm audit`, `pip-audit`)
- [ ] No outdated packages with known HIGH/CRITICAL CVEs
- [ ] No use of deprecated crypto APIs

### A07 — Authentication Failures
- [ ] JWT signatures verified server-side (not just decoded)
- [ ] JWT `alg: none` attack prevented
- [ ] Session invalidation on logout (not just cookie deletion)
- [ ] Brute force protection on login
- [ ] MFA available for sensitive operations

### A08 — Integrity Failures
- [ ] Deserialization of untrusted data avoided
- [ ] Package integrity verified (lockfiles committed)
- [ ] CI/CD pipeline cannot be modified by untrusted code paths

### A09 — Logging & Monitoring
- [ ] Authentication events logged (success and failure)
- [ ] Sensitive data NOT logged (passwords, tokens, PII)
- [ ] Errors logged with context but without sensitive details
- [ ] Alerts exist for repeated authentication failures

### A10 — SSRF
- [ ] User-controlled URLs are validated against allowlist
- [ ] Internal network addresses blocked from user-controlled fetch
- [ ] Cloud metadata endpoints (169.254.169.254) not reachable via user input

---

## Output Format

```
[CRITICAL/HIGH/MEDIUM/LOW] OWASP Category — Location
CWE: CWE-XXX (Common Weakness Enumeration)
Vulnerability: [What is vulnerable]
Exploit scenario: [How an attacker could exploit this in 1-2 sentences]
Remediation: [Specific fix with code example if applicable]
```

End with:
1. Summary table (category → severity → count)
2. Top 3 issues to fix immediately
3. Estimated security posture (Needs Work / Acceptable / Strong)
