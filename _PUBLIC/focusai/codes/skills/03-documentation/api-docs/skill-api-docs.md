---
name: api-docs
description: Generate API documentation (REST or GraphQL). Use when documenting API endpoints, creating OpenAPI specs, or writing developer-facing API reference.
disable-model-invocation: true
argument-hint: [endpoint-or-file]
---

# API Docs

Generate developer-ready API documentation. Target: `$ARGUMENTS`

## For Each REST Endpoint, Document Exactly:

### 1. Endpoint Declaration
```
POST /api/v1/sessions
```
Always include HTTP method + full path with version prefix.

### 2. Description
One to three sentences: what does the caller get, and what real-world action occurs?

```
Creates an authenticated session. Returns a short-lived access token (15 min)
and a long-lived refresh token (30 days). Use the refresh endpoint to obtain
a new access token without re-authenticating.
```

### 3. Authentication
```markdown
**Authentication:** None (this is the login endpoint)
**Authentication:** Bearer token — `Authorization: Bearer <access_token>`
**Authentication:** API key — `X-API-Key: <your_api_key>`
**Authentication:** OAuth 2.0 scope required: `sessions:write`
```

### 4. Parameters

**Path parameters:**
| Name | Type | Required | Description |
|------|------|----------|-------------|
| `userId` | `string (UUID)` | Yes | Target user's database ID |

**Query parameters:**
| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| `include` | `string` | No | — | Comma-separated: `profile`, `permissions` |

**Request body** (Content-Type: `application/json`):
```json
{
  "email": "user@example.com",   // required, valid email
  "password": "...",              // required, min 8 characters
  "remember": false               // optional, extends session to 30 days
}
```

For every field: type, required/optional, validation rules, example value.

### 5. Response Schema

**Success (201 Created):**
```json
{
  "accessToken": "eyJ...",
  "refreshToken": "rt_...",
  "expiresAt": "2024-01-15T10:30:00Z"
}
```

**All error codes — most documentation fails here:**
| Status | Code | When | Body shape |
|--------|------|------|------------|
| `400` | `INVALID_EMAIL` | Email format invalid | `{ "error": "INVALID_EMAIL", "message": "..." }` |
| `401` | `WRONG_PASSWORD` | Password mismatch | Same shape |
| `429` | `RATE_LIMITED` | > 10 attempts in 5 min | Includes `retryAfter` seconds |

### 6. Rate Limits
```
10 requests per 5 minutes per IP. Exceeds: 429 with Retry-After header.
```

### 7. Example Request
```bash
curl -X POST https://api.example.com/v1/sessions \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "correct-horse-battery"}'
```

---

## OpenAPI 3.0 YAML

When generating a spec:

```yaml
openapi: 3.0.3
info:
  title: API Name
  version: 1.0.0

paths:
  /sessions:
    post:
      summary: Create session
      tags: [Authentication]
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/LoginRequest'
      responses:
        '201':
          description: Session created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/SessionResponse'
        '401':
          $ref: '#/components/responses/Unauthorized'
        '429':
          $ref: '#/components/responses/RateLimited'
```

Always use `$ref` for reusable schemas.

---

## Most Common Documentation Mistakes

| Mistake | Fix |
|---------|-----|
| Only documenting success response | Document every 4xx and 5xx with example body |
| Missing authentication docs | Always add, even for public endpoints ("No auth required") |
| Unrealistic examples (`"foo"`, `123`) | Use real-looking data |
| Missing validation rules | State min/max, pattern, enum values |
| No versioning strategy | Document deprecation policy |
