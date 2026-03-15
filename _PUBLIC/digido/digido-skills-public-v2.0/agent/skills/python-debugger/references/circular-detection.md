# Circular Detection

## What Is It?

Circular debugging = applying the same fix (or a variation of it) that you already tried. This wastes time and context.

## Detection Rules

**You are going in circles if:**

### 1. Same file, same line, same type of change
Even if the exact code differs:
```
Attempt 1: Added `if x is not None` check at line 42
Attempt 3: Added `if x:` check at line 42
→ CIRCULAR — same idea, different syntax
```

### 2. Reverting a revert
You changed A→B, then B→A, now considering A→B again:
```
Attempt 1: Changed json.loads() to json.load()
Attempt 2: Changed json.load() back to json.loads()
Attempt 3: Considering json.loads() with different params
→ CIRCULAR — you're oscillating
```

### 3. Same hypothesis, different fix
The underlying theory hasn't changed:
```
Attempt 1: "It's a type issue" → added int() cast
Attempt 2: "It's a type issue" → added str() cast
Attempt 3: "It's a type issue" → added float() cast
→ CIRCULAR — maybe it's NOT a type issue
```

## When Circular Detected

```
🔄 CIRCULAR DETECTION TRIGGERED

What's repeating: [description]
Original attempt: [attempt #N]
Current attempt:  [attempt #M]

ACTION: STOP. This approach is exhausted.
NEXT: Write state dump → recommend fresh session.
```

**Circular detection triggers an immediate STOP — same as Strike 3.**
