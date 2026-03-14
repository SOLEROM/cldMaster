---
name: csp-setup
description: Content Security Policy setup and security headers configuration. Auto-load when configuring web security headers, setting up CSP, or when asked about XSS prevention.
---

# Security Headers & CSP Reference

Security headers are the last line of defense against XSS, clickjacking, and data injection. Most are a single line to add but provide significant protection.

## The Essential Security Headers

```
Content-Security-Policy     — Prevents XSS and data injection (most important)
Strict-Transport-Security   — Forces HTTPS (prevents downgrade attacks)
X-Frame-Options             — Prevents clickjacking
X-Content-Type-Options      — Prevents MIME sniffing
Referrer-Policy             — Controls referrer header leakage
Permissions-Policy          — Restricts browser features
```

## Content Security Policy (CSP)

CSP tells the browser what sources of content are legitimate. Inline scripts from injected XSS payloads get blocked.

```
# CSP directive reference
default-src   — Fallback for all content types not specified
script-src    — JavaScript sources
style-src     — CSS sources
img-src       — Image sources
font-src      — Font sources
connect-src   — Fetch/XHR/WebSocket sources
frame-src     — Iframe sources
media-src     — Audio/video sources
object-src    — Plugin content (set to 'none' almost always)
base-uri      — Restricts <base> tag
form-action   — Form submission targets
frame-ancestors — Who can embed this page in an iframe
upgrade-insecure-requests — Auto-upgrade HTTP to HTTPS
```

## CSP by Framework

### Next.js (next.config.js)

```javascript
const securityHeaders = [
  {
    key: 'Content-Security-Policy',
    value: [
      "default-src 'self'",
      "script-src 'self' 'nonce-{NONCE}'",   // Use nonces for inline scripts
      "style-src 'self' 'unsafe-inline'",     // unsafe-inline needed for CSS-in-JS
      "img-src 'self' data: https://res.cloudinary.com",
      "font-src 'self' https://fonts.gstatic.com",
      "connect-src 'self' https://api.myapp.com",
      "frame-ancestors 'none'",
      "base-uri 'self'",
      "form-action 'self'",
      "object-src 'none'",
    ].join('; '),
  },
  {
    key: 'Strict-Transport-Security',
    value: 'max-age=63072000; includeSubDomains; preload',
  },
  {
    key: 'X-Frame-Options',
    value: 'DENY',
  },
  {
    key: 'X-Content-Type-Options',
    value: 'nosniff',
  },
  {
    key: 'Referrer-Policy',
    value: 'strict-origin-when-cross-origin',
  },
  {
    key: 'Permissions-Policy',
    value: 'camera=(), microphone=(), geolocation=()',
  },
];

module.exports = {
  async headers() {
    return [{ source: '/(.*)', headers: securityHeaders }];
  },
};
```

### Express.js (Helmet)

```typescript
import helmet from 'helmet';

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      imgSrc: ["'self'", 'data:', 'https://res.cloudinary.com'],
      connectSrc: ["'self'", 'https://api.myapp.com'],
      fontSrc: ["'self'", 'https://fonts.gstatic.com'],
      objectSrc: ["'none'"],
      frameAncestors: ["'none'"],
      baseUri: ["'self'"],
      formAction: ["'self'"],
      upgradeInsecureRequests: [],
    },
  },
  hsts: {
    maxAge: 63072000,          // 2 years
    includeSubDomains: true,
    preload: true,
  },
  frameguard: { action: 'deny' },
  noSniff: true,
  referrerPolicy: { policy: 'strict-origin-when-cross-origin' },
}));
```

### Nginx

```nginx
server {
    # Security headers
    add_header Content-Security-Policy "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; connect-src 'self'; font-src 'self'; object-src 'none'; frame-ancestors 'none'; base-uri 'self'; form-action 'self';" always;
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
    add_header X-Frame-Options "DENY" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Permissions-Policy "camera=(), microphone=(), geolocation=()" always;

    # Remove server version info
    server_tokens off;
}
```

### Astro (astro.config.mjs)

```javascript
export default defineConfig({
  server: {
    headers: {
      'Content-Security-Policy': [
        "default-src 'self'",
        "script-src 'self'",
        "style-src 'self' 'unsafe-inline'",
        "img-src 'self' data: https://res.cloudinary.com",
        "connect-src 'self'",
        "frame-ancestors 'none'",
        "object-src 'none'",
      ].join('; '),
      'X-Frame-Options': 'DENY',
      'X-Content-Type-Options': 'nosniff',
    },
  },
});
```

## CSP Nonces (For Inline Scripts)

When you need inline scripts, use nonces instead of `'unsafe-inline'`:

```typescript
// Server generates a unique nonce per request
import crypto from 'crypto';

function generateNonce(): string {
  return crypto.randomBytes(16).toString('base64');
}

// Add to CSP header
const nonce = generateNonce();
res.setHeader('Content-Security-Policy', `script-src 'self' 'nonce-${nonce}'`);

// Add to inline scripts
res.send(`
  <script nonce="${nonce}">
    // This inline script is now allowed
  </script>
`);
```

## CSP Report-Only Mode (Safe Testing)

Test CSP without breaking anything:

```
Content-Security-Policy-Report-Only: default-src 'self'; report-uri /csp-report
```

This reports violations without blocking anything. Monitor the reports to find what your policy would break before enforcing it.

## Testing Your Headers

```bash
# Check headers with curl
curl -I https://yourdomain.com

# Online tools:
# https://securityheaders.com
# https://observatory.mozilla.org

# Check CSP specifically
# Chrome DevTools → Network → Response Headers
# Chrome DevTools → Console shows CSP violations
```

## Common CSP Problems and Fixes

| Problem | Cause | Fix |
|---------|-------|-----|
| Google Analytics blocked | External script | Add `https://www.googletagmanager.com` to `script-src` |
| Google Fonts blocked | External font | Add `https://fonts.googleapis.com` to `style-src`, `https://fonts.gstatic.com` to `font-src` |
| Stripe blocked | Payment iframe | Add `https://js.stripe.com` to `script-src`, `https://*.stripe.com` to `frame-src` |
| Inline styles blocked | CSS-in-JS | Add `'unsafe-inline'` to `style-src` (unavoidable for CSS-in-JS) |
| WebSocket blocked | Real-time | Add `wss://api.myapp.com` to `connect-src` |
| Data URIs blocked | Base64 images | Add `data:` to `img-src` |

## Header Checklist

- [ ] CSP configured and tested (report-only first, then enforce)
- [ ] `object-src 'none'` (disables Flash, plugins)
- [ ] `frame-ancestors 'none'` or `'self'` (prevents clickjacking)
- [ ] HSTS with `max-age` ≥ 1 year + `includeSubDomains` + `preload`
- [ ] `X-Content-Type-Options: nosniff`
- [ ] `X-Frame-Options: DENY` (belt-and-suspenders with `frame-ancestors`)
- [ ] `Referrer-Policy: strict-origin-when-cross-origin`
- [ ] Server version headers removed (Nginx `server_tokens off`)
- [ ] No `'unsafe-eval'` in script-src
- [ ] Tested with SecurityHeaders.com (target: A+)
