# DEBUG.md Format & Output Templates

## DEBUG.md — Python Version

When debugging, create or update `.digido/DEBUG.md`:

```markdown
---
status: gathering | investigating | fixing | verifying | resolved | blocked
trigger: "{exact error message or user description}"
error_type: {SyntaxError | ImportError | TypeError | etc.}
file: {file where error occurs}
created: {timestamp}
updated: {timestamp}
strikes: {0 | 1 | 2 | 3}
circular: {false | true — description if true}
---

## Current Focus
hypothesis: {current theory — specific and falsifiable}
test: {how you're testing it}
expecting: {what result would confirm/deny}
next_action: {immediate next step}

## Environment
python_version: {python --version}
venv: {path or "none"}
os: {Windows | Linux | Mac}
key_packages: {relevant packages + versions}

## Symptoms
expected: {what should happen}
actual: {what actually happens}
traceback: |
  {full traceback — copy/paste exactly}

## Attempts
- attempt: 1
  hypothesis: {theory}
  change: {what was changed}
  result: {what happened}
  learning: {what this tells us}

- attempt: 2
  hypothesis: {theory}
  change: {what was changed}
  result: {what happened}
  learning: {what this tells us}

## Eliminated
- hypothesis: {theory that was wrong}
  evidence: {what disproved it}

## Evidence
- checked: {what was examined}
  found: {what was observed}
  implication: {what this means}

## Resolution
root_cause: {when found}
fix: {what was changed}
verification: {how it was verified — command + output}
```

---

## Output Formats

### ROOT CAUSE FOUND
```
ROOT CAUSE: {specific cause}
ERROR TYPE: {Python error class}
EVIDENCE: {proof — traceback, print output, etc.}
FIX: {what was changed}
VERIFIED: {command that proves it works}
STRIKES: {how many attempts it took}
```

### 3-STRIKE STOP
```
🛑 3-STRIKE RULE ACTIVATED

ATTEMPTS:
  1. {what was tried → what happened}
  2. {what was tried → what happened}
  3. {what was tried → what happened}

ELIMINATED: {hypotheses ruled out}
REMAINING: {hypotheses not yet tested}
CIRCULAR: {yes/no — if yes, what repeated}

STATE SAVED TO: .digido/DEBUG.md
RECOMMENDATION: {fresh session | different approach | need user info}
```

### CIRCULAR STOP
```
🔄 CIRCULAR DETECTION — IMMEDIATE STOP

PATTERN: {what's repeating}
FIRST OCCURRENCE: Attempt #{n}
CURRENT OCCURRENCE: Attempt #{m}

The same approach has been tried in different forms.
The underlying hypothesis needs to change, not the implementation.

STATE SAVED TO: .digido/DEBUG.md
RECOMMENDATION: Fresh session with explicit instruction to avoid {approach}
```
