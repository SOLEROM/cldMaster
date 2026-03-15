---
name: error-handling
description: Critical error handling protocol. Ensures systematic investigation before any fix — understanding the full picture, checking affected files, and avoiding breaking other parts of the project. Guides the architect through a safe, step-by-step error resolution process.
---

# Error Handling Protocol

## Core Principle
**חקירה לפני תיקון. שיתוף פעולה תמיד.**

Never rush to fix. Always investigate first. Always collaborate with the architect.

---

## 3-Step Process

### Step 1: Gather Context (חקירה ראשונית)

When the architect reports an error:

**Ask for:**
- [ ] Exact error message (paste from terminal/console)
- [ ] What action triggered it?
- [ ] Expected behavior vs actual behavior

**Your investigation:**
- [ ] Read `ARCHITECTURE.md` to understand project structure
- [ ] Read `STACK.md` to understand dependencies
- [ ] Identify potentially affected files

**Be transparent about limitations:**
- ❌ Don't: "I know how to fix this, let me start"
- ✅ Do: "I need to investigate. Can you share the console error and confirm which feature this affects?"

---

### Step 2: Collaborative Analysis (ניתוח משותף)

**Explain to the architect (in simple language):**
- What you found
- Which files are involved
- Potential risks: "If we fix X, Y might break"

**Propose approaches:**
- [ ] Present 2-3 possible solutions
- [ ] Explain pros/cons of each
- [ ] Get architect's decision

**Integration with existing workflows:**
- For Python errors → use `/python-debugger` or `/python-verify-and-fix`
- For complex investigations → use `/error-diagnose`
- For systematic debugging → use `/debug`

---

### Step 3: Controlled Fix (תיקון מבוקר)

**Before fixing:**
- [ ] Get explicit approval from architect
- [ ] Confirm which files will be modified

**During fix:**
- [ ] Fix the issue
- [ ] Update `CHANGELOG.md` with the fix

**After fix:**
- [ ] Ask architect to test
- [ ] Verify no side effects
- [ ] Document lessons learned (if significant)

---

## Critical Rules

### ✅ DO:
- Investigate thoroughly before proposing solutions
- Read project structure files (ARCHITECTURE.md, STACK.md)
- Explain in simple language the architect can understand
- Ask clarifying questions when context is missing
- Check for side effects before fixing

### ❌ DON'T:
- Rush to fix without understanding the full picture
- Say "I know the solution" before investigating
- Modify files without explicit architect approval
- Assume you understand without asking
- Act like an "automatic AI" — you're a collaborative partner

---

## Quick Triage

**Simple errors** (syntax, typos, missing imports):
- Quick investigation → propose fix → get approval → fix

**Complex errors** (system crashes, integration issues, performance):
- Deep investigation → use ARCHITECTURE.md → identify affected areas → collaborative analysis → phased fix

---

## Integration

This skill works alongside:
- `/python-debugger` - For systematic Python debugging
- `/error-diagnose` - For error diagnosis workflow
- `/python-verify-and-fix` - For verification and fixing
- `/debug` - For general debugging protocol

Use those workflows when they match the error type.


