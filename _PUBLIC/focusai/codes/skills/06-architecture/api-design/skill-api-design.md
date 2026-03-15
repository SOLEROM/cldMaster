---
name: api-design
description: REST and GraphQL API design principles. Auto-load when designing new endpoints, reviewing API contracts, or when asked about API best practices.
---

# API Design Reference

Design APIs that are intuitive, consistent, and easy to evolve.

## REST Design Principles

### Resource Naming

```
# Nouns, not verbs — the HTTP method IS the verb
GET    /users            ✅  (not /getUsers)
POST   /users            ✅  (not /createUser)
PUT    /users/123        ✅  (not /updateUser?id=123)
DELETE /users/123        ✅  (not /deleteUser/123)

# Plural nouns
/users         ✅
/user          ❌

# Hierarchical for owned resources
GET /users/123/orders      # orders belonging to user 123
GET /users/123/orders/456  # specific order for user 123

# Flat for non-owned resources
GET /orders/456            # access order directly (if user is inferred from auth)
```

### HTTP Methods

| Method | Idempotent? | Safe? | Use for |
|--------|------------|-------|---------|
| GET | Yes | Yes | Read; never modify state |
| POST | No | No | Create; non-idempotent actions |
| PUT | Yes | No | Full replacement of a resource |
| PATCH | No | No | Partial update |
| DELETE | Yes | No | Delete |

### Status Codes — Use the Right One

```
200 OK           — success (GET, PUT, PATCH)
201 Created      — resource created (POST)
204 No Content   — success, no body (DELETE, PUT with no response)
400 Bad Request  — invalid request syntax or missing required fields
401 Unauthorized — not authenticated (no/invalid token)
403 Forbidden    — authenticated but not authorized
404 Not Found    — resource doesn't exist
409 Conflict     — resource already exists or state conflict
422 Unprocessable Entity — valid syntax but fails validation
429 Too Many Requests    — rate limited
500 Internal Server Error — unexpected server error
503 Service Unavailable  — dependency down
```

**Common mistakes:**
- Using 200 for errors (wrong — use 4xx or 5xx)
- Using 400 for authorization failures (wrong — use 401/403)
- Using 404 for validation errors (wrong — use 422)

### Versioning

```
# URL versioning (most common, most explicit)
/api/v1/users
/api/v2/users

# Header versioning (cleaner URLs, less visible)
Accept: application/vnd.api+json; version=2

# No versioning (for internal APIs with controlled consumers)
```

URL versioning is recommended for public APIs: it's visible in logs, bookmarkable, easy to test with curl.

### Pagination

```
# Cursor-based (preferred for large/real-time data)
GET /users?cursor=eyJpZCI6MTIzfQ&limit=20

Response:
{
  "data": [...],
  "nextCursor": "eyJpZCI6MTQzfQ",  // null if no more pages
  "hasMore": true
}

# Offset-based (simple, good for static data)
GET /users?page=3&limit=20

Response:
{
  "data": [...],
  "total": 847,
  "page": 3,
  "limit": 20
}
```

Cursor-based is better for large datasets and real-time data (no "page drift" when items are added/removed).

### Filtering and Sorting

```
GET /users?status=active&role=admin              # filtering
GET /orders?created_after=2024-01-01             # date filtering
GET /users?sort=name&order=asc                   # sorting
GET /users?sort=-created_at                      # minus prefix for desc
GET /users?fields=id,name,email                  # sparse fieldsets
```

### Error Response Format

Consistent error format across all endpoints:

```json
{
  "error": "VALIDATION_ERROR",
  "message": "The request contains invalid fields",
  "details": [
    {
      "field": "email",
      "code": "INVALID_FORMAT",
      "message": "Must be a valid email address"
    },
    {
      "field": "age",
      "code": "OUT_OF_RANGE",
      "message": "Must be between 18 and 120"
    }
  ],
  "requestId": "req_01HN8X4K"  // for tracing
}
```

---

## GraphQL Design Principles

### Query Design
- Queries should return exactly what the client needs — no over-fetching
- Nest related data, but keep depth reasonable (max 3-4 levels)
- Avoid "godqueries" that return everything

### Mutation Naming
```graphql
# Clear verb + noun pattern
mutation CreateUser($input: CreateUserInput!) { ... }
mutation UpdateUserEmail($userId: ID!, $email: String!) { ... }
mutation DeleteOrder($orderId: ID!) { ... }

# Return the mutated object — lets clients update their cache
type Mutation {
  createUser(input: CreateUserInput!): CreateUserPayload!  # not just User
}

type CreateUserPayload {
  user: User
  errors: [UserError!]!  # GraphQL errors that are part of the domain
}
```

### N+1 Prevention with DataLoader

```ts
// BAD — N+1: one query per user when resolving posts.author
Post: {
  author: (post) => UserService.findById(post.authorId)  // N queries!
}

// GOOD — batch with DataLoader
const userLoader = new DataLoader(async (ids: string[]) => {
  const users = await UserService.findByIds(ids);  // 1 query for all
  return ids.map(id => users.find(u => u.id === id));
});

Post: {
  author: (post) => userLoader.load(post.authorId)  // batched automatically
}
```

---

## API Contract First

**Design the interface before the implementation:**

1. Write the API documentation first (or OpenAPI spec)
2. Get consumer review and approval
3. Generate mocks from the spec
4. Implement against the approved contract

This prevents the "we need to break the API because the implementation was easier this way" problem.

## Backwards Compatibility Rules

- **Adding** optional fields to request/response: ✅ backwards compatible
- **Removing** fields from response: ❌ breaking change
- **Renaming** fields: ❌ breaking change (add new field, deprecate old)
- **Changing** field type: ❌ breaking change
- **Adding** required request fields: ❌ breaking change
- **Adding** new endpoints: ✅ backwards compatible
