---
description: Show current position in roadmap and next steps
---

# /progress Workflow

<objective>
To align on the project status quickly and clearly, as collaborative partners.
</objective>

<process>

## 1. Gather Context

Read the following files to understand the current state:
- `.digido/STATE.md` (Current position, task, blockers)
- `.digido/ROADMAP.md` (Overall phases and progress)
- `.digido/SPEC.md` (Project name and goal)

---

## 2. Analyze Progress

Determine:
- **Current Phase:** Which phase are we in? (e.g., Phase 3: Development)
- **Overall Progress:** How many phases are completed out of total? (e.g., 2/5 completed)
- **Current Task:** What is the active task we are working on?
- **Blockers:** Are there any issues blocking progress?

---

## 3. Report Status (Conversational Style)

Present the status to the user in a clear, natural language summary (Hebrew or English as per user preference). Avoid ASCII tables or robotic outputs.

**Structure the response as follows:**

1.  **Where we are:**
    > "We are currently in **Phase [X]: [Name]**. So far, we have completed [Y] out of [Z] phases ([P]%)."

2.  **What's happening now:**
    > "The current focus is: **[Current Task from STATE.md]**."
    
    *(If blocked, mention it here clearly: "Note: We are currently blocked by [Blocker].")*

3.  **What's next:**
    > "The recommended next step is: **[Next Action]** (e.g., Run `/execute [X]`, verify pending changes, or discuss the next phase)."

---

## 4. Interaction

Ask the user if they would like to proceed with the recommended action.

</process>
