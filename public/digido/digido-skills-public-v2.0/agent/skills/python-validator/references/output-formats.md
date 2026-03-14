# Validation Output Formats

## VALIDATION PASSED
```
✅ VALIDATION PASSED

Task: {task name}
Level: {pytest | smoke | import | syntax}
Command: {exact command}
Output:
  {actual output}
Expected: {what was expected}
Verdict: Output matches expectation
```

---

## VALIDATION FAILED
```
❌ VALIDATION FAILED

Task: {task name}
Level: {pytest | smoke | import | syntax}
Command: {exact command}
Output:
  {actual output}
Expected: {what was expected}
Mismatch: {what differs}
Next: {back to debugger | new bug | environment fix}
```

---

## VALIDATION PARTIAL
```
⚠️ VALIDATION PARTIAL

Task: {task name}
Level: {syntax only}
Checks passed: {syntax valid, imports OK}
Checks NOT possible: {execution, output comparison}
Reason: {why full validation isn't possible}
Needs: {what's required for full validation}
Follow-up: {task to complete validation later}
```

---

## SESSION-HISTORY.md / STATE.md Entry

```markdown
## Validation: {task name}
- Level: pytest | smoke test | import | syntax
- Command: `{exact command}`
- Output:
  ```
  {actual output — copy/paste}
  ```
- Verdict: ✅ PASS | ❌ FAIL
- Timestamp: {when}
```

---

## Failure Handling

### When Validation Fails

```
1. DO NOT mark task as complete
2. Document the failure:
   - What was expected
   - What actually happened
   - The exact error/output
3. Classify:
   - Is this the same bug? → back to python-debugger
   - Is this a new bug? → new debug cycle
   - Is this an environment issue? → fix environment first
4. user-explainer → tell the user what happened
```

### When Validation Is Impossible

Sometimes you genuinely cannot run the code (external API not available, database not set up, etc.)

```
1. Do the highest level check possible (syntax at minimum)
2. Document WHY you couldn't do a full validation
3. Mark task as "partially verified" — NOT complete
4. List what needs to be true for full verification:
   - "Needs database running on localhost:5432"
   - "Needs OPENAI_API_KEY in .env"
   - "Needs test_data.csv in /data folder"
5. Create a follow-up task: "Full validation when {dependency} is available"
```

---

## Forbidden Phrases

**Never use these as justification for marking a task complete:**

| Phrase | Why It's Forbidden |
|--------|-------------------|
| "This should work" | Should ≠ does |
| "The code looks correct" | Looking ≠ running |
| "I've made similar changes before" | Past ≠ present |
| "Based on my understanding" | Understanding ≠ evidence |
| "It follows the pattern" | Pattern ≠ proof |
| "The logic is sound" | Logic ≠ execution |
| "I'm confident this works" | Confidence ≠ verification |

**The only valid phrase:** "I ran [command], got [output], which matches [expectation]."
