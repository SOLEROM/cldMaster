---
description: Collaborative review of risks and assumptions before execution
argument-hint: "phase-number"
---

# 🕵️ list-phase-assumptions (Collaborative)

<objective>
Before we start coding Phase {N}, we must identify what we are "guessing" might work, versus what we *know* works.
This prevents the "It works on my machine" or "I thought the API did that" problems.
</objective>

<process>

## 1. Agent Analysis (Internal)
The agent will read the PHASE PLAN (`.digido/phases/{N}/*`) and look for:
- **Magic Integrations:** "Just call the API" (Does it exist? Do we have keys?)
- **Data Structure:** "Save to DB" (Is the schema ready?)
- **Libraries:** "Use library X" (Is it compatible with our specific need?)
- **User Behavior:** "User clicks X" (Is that flow actually defined?)

## 2. The Conversation (External)
The agent will present a simple list to the Architect:

> **Phase {N} Assumptions Check:**
> 
> ❓ **Technical:** I'm assuming library `xyz` supports Hebrew RTL. **Verify?**
> ❓ **Data:** I'm assuming we have the `user_id` available in this context. **Verify?**
> ❓ **Scope:** I'm assuming we DON'T need to build the admin panel for this yet. **Correct?**

## 3. Decision
For each assumption, the Architect decides:
- **Verified:** "Yes, I checked, it works." -> *Proceed.*
- **To Research:** "I don't know." -> *Agent creates a quick research task. it has to be followed by context7-integration/SKILL.md*
- **To Descope:** "Actually, let's not do that part." -> *Update Plan.*

</process>
