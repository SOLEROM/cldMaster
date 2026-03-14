---
name: auth-review
description: Authentication and authorization review. Auto-load when implementing login systems, JWT, sessions, OAuth, RBAC, or when asked to review auth-related code.
---

# Authentication & Authorization Reference

Auth bugs are high-severity. This reference covers implementation patterns and common mistakes.

## Authentication vs Authorization

```
Authentication (AuthN): Who are you?
  → Verify identity: password, MFA, OAuth token

Authorization (AuthZ): What can you do?
  → Verify permissions: can this user access this resource?

Common mistake: checking authentication but not authorization
  → User is logged in ✅ but can access OTHER users' data ❌
```

## Session-Based Authentication

```typescript
// Node.js + express-session
import session from 'express-session';

app.use(session({
  secret: process.env.SESSION_SECRET!,    // Long random string
  resave: false,
  saveUninitialized: false,               // Don't create session until data stored
  cookie: {
    httpOnly: true,                       // JS cannot access cookie
    secure: process.env.NODE_ENV === 'production',  // HTTPS only in production
    sameSite: 'lax',                      // CSRF protection
    maxAge: 1000 * 60 * 60 * 24 * 7,    // 7 days
  },
  store: new RedisStore({ client }),      // Don't use MemoryStore in production
}));

// On login — CRITICAL: regenerate session ID to prevent session fixation
req.session.regenerate((err) => {
  if (err) return next(err);
  req.session.userId = user.id;
  req.session.save(next);
});

// On logout — destroy session completely
req.session.destroy((err) => {
  res.clearCookie('connect.sid');
  res.redirect('/login');
});
```

## JWT Authentication

```typescript
import jwt from 'jsonwebtoken';

// Signing — access token (short-lived)
const accessToken = jwt.sign(
  { userId: user.id, role: user.role },   // payload — keep minimal!
  process.env.JWT_SECRET!,
  {
    expiresIn: '15m',      // Short expiry for access tokens
    issuer: 'myapp.com',
    audience: 'myapp-api',
  }
);

// Refresh token (long-lived, stored in DB for revocation)
const refreshToken = jwt.sign(
  { userId: user.id, tokenId: crypto.randomUUID() },
  process.env.JWT_REFRESH_SECRET!,
  { expiresIn: '7d' }
);

// Verification middleware
function verifyToken(req: Request, res: Response, next: NextFunction) {
  const token = req.headers.authorization?.replace('Bearer ', '');
  if (!token) return res.status(401).json({ error: 'No token' });

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET!, {
      issuer: 'myapp.com',
      audience: 'myapp-api',
    }) as JWTPayload;
    req.user = decoded;
    next();
  } catch (err) {
    return res.status(401).json({ error: 'Invalid token' });
  }
}
```

### JWT Common Mistakes

```typescript
// ❌ Algorithm confusion attack
// Never use jwt.decode() for auth — it doesn't verify!
const payload = jwt.decode(token);  // NO VERIFICATION!

// ❌ Accepting "none" algorithm
// Always specify accepted algorithms
jwt.verify(token, secret, { algorithms: ['HS256'] }); // specify explicitly

// ❌ Sensitive data in payload
// JWT payload is base64 encoded, NOT encrypted — anyone can read it
jwt.sign({ password: user.password, ssn: user.ssn }, secret); // NEVER

// ❌ No expiry
jwt.sign({ userId: user.id }, secret); // tokens live forever!

// ✅ Short access tokens + refresh token rotation
// Access: 15 min | Refresh: 7 days (stored in DB, can be revoked)
```

## Password Security

```typescript
import bcrypt from 'bcrypt';

const BCRYPT_ROUNDS = 12; // 10-12 is the sweet spot (2^12 iterations)

// Hashing (registration)
const hash = await bcrypt.hash(password, BCRYPT_ROUNDS);

// Verification (login)
const isValid = await bcrypt.compare(password, storedHash);

// Timing-safe comparison (for custom token verification)
import crypto from 'crypto';
const isEqual = crypto.timingSafeEqual(
  Buffer.from(providedToken),
  Buffer.from(storedToken)
); // Prevents timing attacks
```

### Password Anti-Patterns

```
❌ MD5/SHA1/SHA256 for passwords — too fast, rainbow tables defeat them
❌ bcrypt with rounds < 10 — too fast for modern hardware
❌ Truncating passwords before hashing — bcrypt has 72-char limit (use argon2 or pre-hash)
❌ Comparing passwords with === — timing attack vulnerable
❌ Logging passwords anywhere (even "for debugging")
❌ Returning whether email OR password is wrong specifically
   → Always: "Invalid credentials" (not "Email not found" — email enumeration)
```

## Authorization — Role-Based Access Control (RBAC)

```typescript
// Define permissions declaratively
const permissions = {
  admin: ['users:read', 'users:write', 'users:delete', 'orders:read', 'orders:write'],
  manager: ['users:read', 'orders:read', 'orders:write'],
  user: ['orders:read'],
} as const;

// Middleware
function requirePermission(permission: string) {
  return (req: Request, res: Response, next: NextFunction) => {
    const userPerms = permissions[req.user.role] ?? [];
    if (!userPerms.includes(permission)) {
      return res.status(403).json({ error: 'Forbidden' });
    }
    next();
  };
}

// Route-level enforcement
router.delete('/users/:id',
  verifyToken,                          // AuthN: are you logged in?
  requirePermission('users:delete'),    // AuthZ: can you do this?
  deleteUser
);
```

## Resource-Level Authorization (Critical)

Checking role is not enough — check ownership:

```typescript
// ❌ Vulnerable — checks auth but not ownership
router.get('/orders/:id', verifyToken, async (req, res) => {
  const order = await Order.findById(req.params.id);
  return res.json(order);  // Any logged-in user can see ANY order!
});

// ✅ Correct — enforce ownership
router.get('/orders/:id', verifyToken, async (req, res) => {
  const order = await Order.findOne({
    id: req.params.id,
    userId: req.user.id,   // Must belong to the requesting user
  });
  if (!order) return res.status(404).json({ error: 'Not found' });
  return res.json(order);
});

// For admins with cross-user access:
router.get('/orders/:id', verifyToken, requirePermission('orders:read:all'), async (req, res) => {
  const order = await Order.findById(req.params.id); // Admins only
  ...
});
```

## OAuth 2.0 / OpenID Connect

```typescript
// Using Auth0, Clerk, Supabase Auth, or NextAuth.js is strongly recommended
// over implementing OAuth from scratch

// If implementing callback handler:
async function oauthCallback(req: Request, res: Response) {
  const { code, state } = req.query;

  // CRITICAL: validate state to prevent CSRF
  if (state !== req.session.oauthState) {
    return res.status(403).json({ error: 'State mismatch — possible CSRF' });
  }

  // Exchange code for tokens (server-side only!)
  const tokens = await exchangeCodeForTokens(code as string);

  // Get user info from provider, create/update local user
  const userInfo = await fetchUserInfo(tokens.access_token);
  const user = await findOrCreateUser(userInfo);

  req.session.regenerate(() => {
    req.session.userId = user.id;
    res.redirect('/dashboard');
  });
}
```

## Rate Limiting Auth Endpoints

```typescript
import rateLimit from 'express-rate-limit';

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutes
  max: 5,                      // 5 attempts per window per IP
  message: 'Too many login attempts, please try again in 15 minutes',
  standardHeaders: true,
  legacyHeaders: false,
});

app.post('/auth/login', loginLimiter, handleLogin);
app.post('/auth/forgot-password', loginLimiter, handleForgotPassword);
```

## Security Headers for Auth

```typescript
// Helmet.js (Node.js)
import helmet from 'helmet';

app.use(helmet());
app.use(helmet.hsts({
  maxAge: 31536000,            // 1 year
  includeSubDomains: true,
  preload: true,
}));
```

## Auth Review Checklist

- [ ] Passwords hashed with bcrypt/argon2 (≥ 10 rounds)
- [ ] Timing-safe comparison for token validation
- [ ] Session ID regenerated after login (session fixation)
- [ ] Session destroyed (not just cleared) on logout
- [ ] JWT: short expiry, specific algorithm, no sensitive payload data
- [ ] Authorization checks on every protected endpoint
- [ ] Resource ownership validated (not just role)
- [ ] Rate limiting on login, registration, password reset
- [ ] MFA available (required for admin roles)
- [ ] "Invalid credentials" — don't reveal email vs password failure
- [ ] OAuth state parameter validated (CSRF prevention)
- [ ] Cookies: `httpOnly`, `secure`, `sameSite`
