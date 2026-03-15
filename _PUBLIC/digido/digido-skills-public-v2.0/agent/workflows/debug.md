---
description: Systematic debugging with persistent state
argument-hint: "[description of issue]"
---

# /debug Workflow

<role>
You are a digido debugger orchestrator. You diagnose and fix issues systematically, leveraging fresh context to see what polluted contexts miss.
</role>

<objective>
Systematically diagnose an issue using hypothesis-driven debugging, with persistent state to prevent circular attempts.
</objective>

<context>
**Issue:** $ARGUMENTS (description of the problem to debug)

**Skill reference:** `.agent/skills/debugger/SKILL.md`
</context>

<process>

## 1. Initialize Debug Session

Check for existing debug state in `.digido/DEBUG.md`.

If exists, load previous attempts. If not, create new session.

Display banner:
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 digido ► DEBUG SESSION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Issue: {description}
```

---

## 2. Document Symptom

Create/update `.digido/DEBUG.md`:

```markdown
# Debug Session: {Issue ID}

## Symptom
{Exact description of the problem}

**When:** {When does it occur?}
**Expected:** {What should happen?}
**Actual:** {What actually happens?}
```

---

## 3. Gather Evidence

Collect data BEFORE forming hypotheses using available tools (logs, strict checks, environment variables).

Document evidence in `.digido/DEBUG.md`.

---

## 4. Form Hypotheses

Based on evidence, list possible causes in `.digido/DEBUG.md`:

```markdown
## Hypotheses

| # | Hypothesis | Likelihood | Status |
|---|------------|------------|--------|
| 1 | {cause 1} | 80% | UNTESTED |
| 2 | {cause 2} | 15% | UNTESTED |
| 3 | {cause 3} | 5% | UNTESTED |
```

---

## 5. Test Hypotheses

Test highest likelihood first. Use `tools` to investigate.

Update `.digido/DEBUG.md` with:

```markdown
## Attempts

### Attempt 1
**Testing:** H1 — {hypothesis}
**Action:** {what you did to test}
**Result:** {outcome}
**Conclusion:** {CONFIRMED | ELIMINATED | INCONCLUSIVE}
```

---

## 6. Apply Fix (If Root Cause Found)

When root cause confirmed:

1. Implement fix using code editing tools.
2. Run original failing scenario to verify fix.
3. Check for regressions.

Update `.digido/DEBUG.md` with Resolution details.

---

## 7. Handle 3-Strike Rule

If 3 attempts fail on SAME approach:

1. **STOP** and reassess.
2. **Document** in `.digido/DEBUG.md`:
   ```
   ⚠️ 3 FAILURES ON SAME APPROACH
   ```
3. **Offer Options:**
   - Try fundamentally DIFFERENT approach.
   - `/pause` for fresh session context.
   - Ask user for additional information.

---

## 8. Commit Resolution

If fixed, commit changes with conventional commit message: `fix: {brief description of fix}`.
Update `.digido/STATE.md` with resolution.

</process>

<offer_next>

**If Resolved:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 digido ► BUG FIXED ✓
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Root cause: {what was wrong}
Fix: {what was done}

───────────────────────────────────────────────────────
```

**If Stuck After 3 Attempts:**
```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
 digido ► DEBUG PAUSED ⏸
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

3 attempts exhausted on current approach.
State saved to .digido/DEBUG.md

───────────────────────────────────────────────────────

Options:
• /debug {issue} — try different approach
• /pause — save state for fresh session
• Provide more context about the issue

───────────────────────────────────────────────────────
```

</offer_next>

<related>
## Related

### Workflows
| Command | Relationship |
|---------|--------------|
| `/pause` | Use after 3 failed attempts |
| `/resume` | Start fresh with documented state |
| `/verify` | Re-verify after fixing issues |

### Skills
| Skill | Purpose |
|-------|---------|
| `debugger` | Detailed debugging methodology |
| `context-health-monitor` | 3-strike rule |
</related>
