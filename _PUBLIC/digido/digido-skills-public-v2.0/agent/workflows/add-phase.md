---
description: Add a new phase to the end of the roadmap (Architect Friendly)
argument-hint: "<phase-name> (optional)"
---

# /add-phase Workflow

<objective>
Add a new phase to the roadmap through a guided, human-centric conversation.
Focus on "Architect Experience" — no scary errors, no silent scripts, no automatic git commits.
</objective>

<process>

## 1. Check for Roadmap (Conversational)

Do not run silent failure scripts. Instead, ask the user:

> "I need to check the project roadmap to add a phase. Is there a `ROADMAP.md` file in `.digido/`? If so, may I read it?"

**If User says "Yes":**
- Read `.digido/ROADMAP.md`.
- Proceed to step 2.

**If User says "No" or file is missing:**
- **Do NOT error.**
- Explain kindly:
  Example: *"That's okay. Without a Roadmap or Specification (SPEC), we can't really track phases yet. I recommend we start by using the `specifications` skill or `new-project` workflow to build that foundation first. Would you like help with that?"*
- Stop workflow here gracefully.

---

## 2. Determine Next Phase

Scan the roadmap to see existing phases (e.g., Phase 1, Phase 2...).
Calculate **Next Phase Number (N)** = (Last Phase + 1).

*If no phases exist yet, start at Phase 1.*

---

## 3. Gather Phase Details (Interactive)

Engage the user to define the phase. Do not assume.

**Ask specific questions:**
1.  **"What should we call Phase {N}?"** (If not provided in arguments)
2.  **"What is the main Objective of this phase?** (Short description)"
3.  **"Does it depend on Phase {N-1}, or something else?"** (Suggest N-1 as default)

*Wait for user inputs.*

---

## 4. Add to ROADMAP.md

Append the new phase block to the end of `.digido/ROADMAP.md`.
**Crucial**: Use clean Markdown.

Template to append:

```markdown
---

### Phase {N}: {Title}
**Status**: ⬜ Not Started
**Objective**: {Objective}
**Depends on**: {Dependencies}

**Tasks**:
- [ ] TBD (run /plan {N} to breakdown)

**Verification**:
- [ ] TBD
```

> **Note to Agent**: Tell the user you are adding this to the file now.

---

## 5. Update STATE.md

Update `.digido/STATE.md` to reflect that we are now focused on this new phase (or just planning it).

---

## 6. Manual Wrap-up (No Auto-Git)

**Do NOT run git commands automatically.**

Instead, finalize with a helpful summary and a suggestion:

> "I've added **Phase {N}: {Title}** to the roadmap! 🚀"
>
> "I recommend you save this change to git now. You can use the Source Control tab or run: `git add .digido/ROADMAP.md; git commit -m 'feat: add phase {N}'`"

---

## 7. Suggest Next Step

Propose the logical next move:

> "When you are ready to break this down into actionable tasks, just run:
> **/plan {N}**"

</process>
