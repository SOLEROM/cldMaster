---
name: regex-helper
description: Regex construction, debugging, and optimization. Auto-load when writing regex patterns, debugging regex failures, or when pattern matching is needed.
---

# Regex Reference

Build, debug, and optimize regular expressions. Regex is powerful but can be slow, unreadable, and wrong in subtle ways.

---

## Anatomy of a Regex

```
/^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$/i
  │  └──────────┘  └──────────┘  └───────┘
  │  local part    domain         TLD
  │
  └─ anchors: ^ = start, $ = end
```

### Core Syntax

| Symbol | Meaning | Example |
|--------|---------|---------|
| `.` | Any character except newline | `a.c` matches "abc", "a1c" |
| `\d` | Digit [0-9] | `\d+` matches "123" |
| `\w` | Word char [a-zA-Z0-9_] | `\w+` matches "hello_1" |
| `\s` | Whitespace | `\s+` matches spaces, tabs, newlines |
| `\D`, `\W`, `\S` | Negations of above | |
| `^` | Start of string (or line with `m` flag) | |
| `$` | End of string (or line with `m` flag) | |
| `\b` | Word boundary | `\bcat\b` matches "cat" but not "catch" |
| `*` | 0 or more (greedy) | |
| `+` | 1 or more (greedy) | |
| `?` | 0 or 1 | |
| `{n,m}` | Between n and m times | |
| `*?`, `+?` | Lazy (match as few as possible) | |
| `(a\|b)` | Alternation | `cat\|dog` |
| `[abc]` | Character class | `[aeiou]` matches any vowel |
| `[^abc]` | Negated class | `[^0-9]` matches any non-digit |
| `(...)` | Capturing group | |
| `(?:...)` | Non-capturing group | |
| `(?=...)` | Lookahead | `\d(?=px)` matches digit before "px" |
| `(?!...)` | Negative lookahead | |

---

## JavaScript: RegExp vs String Methods

```js
// RegExp methods
regex.test(str)        // returns boolean
regex.exec(str)        // returns match array or null

// String methods that accept regex
str.match(regex)       // returns array of matches (with /g: all matches; without: first + groups)
str.matchAll(regex)    // returns iterator of all matches (regex must have /g flag)
str.replace(regex, replacement)
str.replaceAll(regex, replacement)  // regex must have /g flag
str.search(regex)      // returns index of first match or -1
str.split(regex)       // split on pattern
```

### The `g` Flag Gotcha with `exec()`

```js
const regex = /\d+/g;

// WRONG — stateful regex in a loop is a classic bug
function findNumbers(str) {
  const regex = /\d+/g;
  const results = [];
  let match;
  while ((match = regex.exec(str)) !== null) {
    results.push(match[0]);
  }
  return results;
}

// RIGHT — use matchAll (no statefulness)
function findNumbers(str) {
  return [...str.matchAll(/\d+/g)].map(m => m[0]);
}
```

---

## Named Capture Groups

```js
const dateRegex = /(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/;
const match = '2024-01-15'.match(dateRegex);

// Access by name — clear and refactoring-safe
const { year, month, day } = match.groups;
// year = '2024', month = '01', day = '15'

// vs. by index — fragile, breaks if group order changes
const [, y, m, d] = match;
```

---

## Catastrophic Backtracking

The most dangerous regex performance issue. A regex that can match the same string in exponentially many ways will hang the process.

**The pattern to watch for:**
```
(a+)+
(a|aa)+
(\w+\s*)+
```

These allow the regex engine to try exponentially many ways to match on failure.

**Example:**
```js
// This regex hangs for ~30s on modern hardware with 25 characters
const evil = /^(a+)+$/;
evil.test('aaaaaaaaaaaaaaaaaaaaaaaaaX');  // backtrack explosion!
```

**How to spot it:**
- Nested quantifiers: `(a+)+`, `(a*)*`
- Alternation inside repetition: `(a|b)+` where a and b can match the same thing
- The regex must be able to match empty string inside a `+` or `*`

**Fix: make the pattern atomic or rewrite without ambiguity**

---

## Common Patterns (Copy-Paste Ready)

```js
// Email (basic — doesn't cover all edge cases, good for 99% of uses)
/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/

// URL
/^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&//=]*)$/

// Phone (international format +X-XXX-XXX-XXXX)
/^\+?[1-9]\d{1,14}$/  // E.164 format

// Date (YYYY-MM-DD)
/^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])$/

// Strong password (min 8 chars, upper, lower, digit, special)
/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/

// Hex color
/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/

// UUID v4
/^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i

// IP address (v4)
/^(\d{1,3}\.){3}\d{1,3}$/  // simple; use a library for strict validation

// Slug (URL-safe string)
/^[a-z0-9]+(?:-[a-z0-9]+)*$/

// Extract content between tags (non-greedy!)
/<tag>(.*?)<\/tag>/s  // s flag: . matches newlines
```

---

## Regex in Astro/Build Tools

**IMPORTANT:** Regex in `<script>` blocks in `.astro` files can have backslashes stripped during build.

```js
// UNSAFE in Astro <script> blocks
const emailRegex = /^[\w.]+@[\w]+\.[\w]+$/;  // \w may become w

// SAFE — always use String.raw or move to a .js file
const emailRegex = new RegExp(String.raw`^[\w.]+@[\w]+\.[\w]+$`);

// OR: move to a separate file and import
// lib/validators.js — regex are safe in plain .js files
export const emailRegex = /^[\w.]+@[\w]+\.[\w]+$/;
```

---

## Testing Strategy

Always test against:
1. The valid case you expect to match
2. A close-but-wrong case that should NOT match
3. An empty string
4. A very long string
5. Unicode / special characters relevant to your domain

Use regex101.com for visual debugging with explanation of each token.
