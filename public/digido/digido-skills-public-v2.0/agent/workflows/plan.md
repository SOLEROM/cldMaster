---
description: The Strategist — Decompose requirements into executable phases in ROADMAP.md
---

# /plan Workflow

The **Strategist** takes high-level requirements and breaks them down into specific, atomic execution plans.
It is the bridge between **What** (Roadmap) and **How** (Code).

## Critical Prerequisites
Before starting, you must ensure the project has a clear definition.

1.  **Check for Specification (`.digido/SPEC.md`):**
    - Does this file exist?
    - Is it populated with project requirements and milestones?
    - *If NO:* **STOP**. You cannot plan without a spec. **Action:** Run the `specifications` skill to create it.

2.  **Check for Roadmap (`.digido/ROADMAP.md`):**
    - Does this file exist?
    - Does it contain defined execution phases?
    - *If NO:* **STOP**. You cannot plan without a roadmap. **Action:** Run the `specifications` skill to create it.

## Core Responsibilities
1.  **Orchestrate Planning**: Use the `Planner` skill to break down the phase.
2.  **Validate Output**: Use the `plan-checker` skill to ensure quality.
3.  **Manage Research**: Decide if `RESEARCH.md` is needed.

## Workflow Steps

### 1. Phase Selection
- **Identify the Phase:**
    - If the user provided a phase number (e.g., `/plan 2`), use that.
    - If not, find the **next unplanned phase** in `.digido/ROADMAP.md`.

### 2. Context Gathering & Research 🔍
- **Read Context:** `.digido/SPEC.md`, `.digido/ROADMAP.md`, `.digido/ARCHITECTURE.md`.
- **Analyze Risk:** Does this phase involve new libraries, complex integrations, or unknown patterns?
- **Action:**
    - **Low Risk/Known Pattern:** Skip research.
    - **Medium/High Risk:** Create `.digido/phases/{N}/RESEARCH.md`. Document specific implementation details, library choices, and architectural decisions *before* planning tasks.

### 3. Generate Plans (The Logic) 🧠
**CRITICAL:** You must not guess how to plan. You MUST use the `Planner` skill.

- **Action:** Read and follow the instructions in **`.agent/skills/Planner/SKILL.md`**.
- **Output:** Create atomic `PLAN.md` files in `.digido/phases/{N}/` (e.g., `1.1-PLAN.md`, `1.2-PLAN.md`).
    - **Rule:** Max 2-3 tasks per plan. Keep context usage low.
    - **Rule:** Files must be atomic.

#### Critical Rule: Registration Completeness
**Lesson Learned:** Creating a file without registering it causes silent failures (e.g., SchemaError).
- If a plan creates a **NEW** schema, component, or module, it **MUST** include a task to **register/import** it in the parent index file.
- **Verification:** The plan must verify that the registration is valid.

### 4. Verify Plans (The Quality Gate) ✅
**CRITICAL:** You must not skip verification. You MUST use the `plan-checker` skill.

- **Action:** Read and follow the instructions in **`.agent/skills/plan-checker/SKILL.md`**.
- **Loop:**
    - Run the checks defined in the skill on your generated `PLAN.md` files.
    - **If issues found:** Fix them immediately.
    - **If pass:** Proceed.

### 5. Update State
- Update `.digido/STATE.md`:
    - **Phase:** {N}
    - **Status:** Planning Complete. Ready for Execution.
    - **Next Step:** `/execute {N}`.

## Next Steps
- **Execute:** Run `/execute {N}` to start building.