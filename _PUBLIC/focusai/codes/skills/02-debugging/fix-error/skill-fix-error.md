---
name: fix-error
description: Analyze and fix error messages. Use when you have an error message, stack trace, or exception you don't understand.
argument-hint: [paste-error-message]
---

# Fix Error

Parse the error message, identify the root cause, and provide a concrete fix.

---

## How to Read an Error

### Stack Trace: Read Bottom-Up

The bottom of the stack trace is where the error originated. The top is where your code was when it crashed. Start from the bottom — that's the root cause.

```
Error: Cannot read properties of undefined (reading 'map')    ← what happened
    at processUsers (app.js:47:18)                           ← your code (look here)
    at handleRequest (server.js:23:5)                        ← your code
    at Layer.handle (express/router/layer.js:95:5)           ← library (ignore)
    at next (express/router/route.js:137:13)                 ← library (ignore)
```

Focus on your code lines, not the library internals.

---

## Common Error Types

### JavaScript / TypeScript

**`TypeError: Cannot read properties of undefined (reading 'X')`**
- Cause: accessing `.X` on something that is `undefined` or `null`
- Fix: add null check, use optional chaining `obj?.property`, or trace where `obj` becomes undefined
- Debug: log the value just before the crash

**`ReferenceError: X is not defined`**
- Cause: variable used before declaration, or imported incorrectly
- Fix: check spelling, check scope, verify the import path
- Note: in ES modules, `import` is hoisted but `const`/`let` are not

**`TypeError: X is not a function`**
- Cause: calling something that isn't a function — could be `undefined`, `null`, a value
- Fix: log the value of X to see what it actually is; trace where it's assigned

**`SyntaxError`**
- Cause: invalid JavaScript syntax
- Fix: look at the line number, check for unclosed brackets/quotes, missing commas in objects
- Note: syntax errors mean no code runs — check imports and module loading

**Unhandled Promise Rejection**
- Cause: async function threw or rejected, and there's no `.catch()` / `try/catch`
- Fix: add `try/catch` around the await, or `.catch()` on the promise chain
- Node.js 18+: unhandled rejections crash the process by default

### HTTP / Network Errors

**400 Bad Request** — your request is malformed
- Check: Content-Type header matches body format
- Check: required fields are present and correctly named
- Check: data types match what the API expects

**401 Unauthorized** — authentication missing or invalid
- Check: token is being sent (Authorization header or cookie)
- Check: token hasn't expired
- Check: token format is correct (`Bearer <token>`, not just `<token>`)

**403 Forbidden** — authenticated but not authorized
- Different from 401: you're logged in, but you don't have permission
- Check: user has the required role/permission
- Check: resource belongs to the correct user

**404 Not Found** — URL doesn't exist
- Check: URL spelling and casing (servers are case-sensitive)
- Check: route is registered
- Check: resource ID exists in the database

**422 Unprocessable Entity** — request format valid but data invalid
- Check: validation rules on the server
- Response body usually contains field-specific error messages

**500 Internal Server Error** — server crashed
- Check: server logs for the actual exception
- This is never a client problem — look at server-side

**CORS Error** (Access-Control-Allow-Origin missing)
- Cause: server doesn't allow requests from your origin
- Fix: configure CORS on the server (not the client)
- Note: you cannot fix CORS from the frontend

### Node.js Specific

**`ENOENT: no such file or directory`** — file path doesn't exist
- Check: relative vs absolute path
- Check: file actually exists at that location
- Check: working directory when the script runs

**`EADDRINUSE: address already in use`** — port is taken
- Fix: `lsof -i :PORT` to find what's using it, or change your port

**`MODULE_NOT_FOUND`** — can't find a module
- Check: module is in `package.json` and `npm install` was run
- Check: import path is correct (relative paths need `./`)
- Check: file extension (`.js` vs `.ts`, CommonJS vs ESM)

---

## Debugging Process

1. **Read the full error** — don't skim, read every word
2. **Find your code in the stack** — ignore library internals
3. **Log the value** that's causing the problem just before the crash
4. **Ask: what SHOULD this value be?** — then trace where it went wrong
5. **Fix root cause** — not just the line that crashed

---

## Output

1. What the error means in plain English
2. Most likely root cause (with explanation)
3. Concrete fix with before/after code
4. How to verify the fix worked
5. How to prevent this class of error in the future
