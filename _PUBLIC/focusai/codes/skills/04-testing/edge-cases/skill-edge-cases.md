---
name: edge-cases
description: Identify edge cases and boundary conditions. Auto-load when writing tests, reviewing code for bugs, or when code handles user input or external data.
---

# Edge Cases

Systematically find inputs and conditions that break code.

## The Edge Case Taxonomy

### 1. Null / Undefined / Empty

For every input, ask what happens with:

| Value | Example | Common break |
|-------|---------|--------------|
| `null` | `user.name` where user is null | TypeError |
| `undefined` | Missing object key | Silent propagation |
| `""` empty string | Form submitted empty | `if (value)` passes |
| `[]` empty array | `items[0]` | undefined |
| `0` | Numeric field blank | `if (count)` fails |
| `false` | Boolean flag | Same falsy trap |

```js
// Falsy trap
if (value) process(value);          // breaks on "", 0, false, null, undefined

// Correct: check for null/undefined only
if (value != null) process(value);  // passes on "", 0, false
```

### 2. Boundary Values

Test at the limit, one below, and one above:

| Type | Test these values |
|------|------------------|
| Array index | `-1`, `0`, `length-1`, `length` |
| Pagination | `page=0`, `page=1`, `page=99999` |
| String length | `""`, max exactly, max+1 |
| Integer | `0`, `-1`, `MAX_SAFE_INTEGER`, `MAX_SAFE_INTEGER+1` |
| Percentage | `0`, `0.5`, `1.0`, `>1.0`, negative |

### 3. JavaScript Type Coercion Traps

```js
0 == false              // true
"" == false             // true
null == undefined       // true
null == false           // false (surprise!)
NaN === NaN             // false
typeof null             // 'object' (JS historical bug)
+"3"                    // 3 (string to number)
+""                     // 0
+undefined              // NaN
parseInt("12px")        // 12 (not an error!)
parseInt("0x10")        // 16 (hex!)
```

### 4. Unicode and Special Characters

| Character class | Example | What breaks |
|----------------|---------|-------------|
| Multi-byte UTF-8 | `"café"` | Byte-based length calculations |
| Emoji | `"👨‍👩‍👧"` | `str.length` returns 8, not 1 |
| SQL injection | `"'; DROP TABLE users;--"` | Unparameterized queries |
| HTML injection | `<script>alert(1)</script>` | XSS |
| Null byte | `"file.txt\x00.exe"` | Path traversal |
| Very long strings | 10MB text | Memory, regex backtracking |
| Newlines in single-line fields | `"first\nsecond"` | CSV/log injection |

### 5. Concurrent Access

For shared mutable state: what if two requests arrive simultaneously?

- **TOCTOU:** Check balance, then deduct — another request deducts between check and update
- **Lost updates:** Two writers both read `n`, both write `n + 1` — should be `n + 2`
- **Cache stampede:** Cache expires, 1000 requests all hit DB at once

### 6. Network Failures

Every external service call must handle:
- Timeout (service takes 30s)
- Connection refused (service down)
- Partial response (connection drops mid-stream)
- Rate limiting (429 with `Retry-After`)
- Unexpected response shape (missing fields, wrong types)
- Empty success (200 OK with empty body)

### 7. Date and Time

| Edge case | Why it matters |
|-----------|----------------|
| Daylight saving time | 2:00 AM may not exist or exist twice |
| Leap year (Feb 29) | `addYears(date, 1)` breaks |
| Year 2038 | 32-bit Unix timestamp overflow |
| Timezone offset changes | Countries change UTC offset |
| `new Date("2024-01-15")` | Midnight UTC, not local midnight |
| End of month arithmetic | March 31 + 1 month = ? |

### 8. Large Inputs

- 10,000 items where 10 were expected
- 100MB file upload
- Regex on 1MB string (catastrophic backtracking: `(a+)+$`)
- 100-level nested JSON
- 10,000-character single field value

---

## Decision Table Technique

For functions with multiple conditions, enumerate all combinations:

```
Input A: null | valid | invalid
Input B: missing | present

           | B missing | B present |
|----------|-----------|-----------|
| A null   |  Case 1   |  Case 2   |
| A valid  |  Case 3   |  Case 4   |
| A invalid|  Case 5   |  Case 6   |
```

Each cell is a test case. Decide consciously, don't accidentally miss.

---

## The Evil User Mindset

When reviewing code that handles user input:
- What if I submit the form twice simultaneously?
- What if I put a script tag in the name field?
- What if I send a negative price?
- What if I send an array where you expect a string?
- What if I manipulate hidden fields in the form?

The evil user doesn't care about your assumptions. Test them.
