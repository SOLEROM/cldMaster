---
description: Initialize a new project with deep context gathering (Interactive Flow)
---

# /new-project Workflow

<objective>
Initialize a new project through a guided, interactive flow.
This workflow prioritizes understanding the project state (New vs. Brownfield), leveraging existing specifications, and setting up the correct documentation foundation before writing code.

**Key Principles:**
- **Interactive:** Ask the user before running automated scripts.
- **Skill-Based:** Delegate deep questioning and spec creation to the `specifications` skill.
- **Foundation-First:** Create the necessary documentation (`SPEC`, `ROADMAP`, `CHANGELOG`, `STATE`) to guide all future work.
</objective>

<process>

## Phase 1: Initial Assessment

**Goal:** Determine if we are starting from scratch or have existing context.

1.  **Ask the user:**
    > "Do you already have a `SPEC.md` file for this project?
    > A) Yes, I have a spec.
    > B) No, we are starting from scratch."

2.  **Logic:**
    -   **If (A) Yes:**
        -   Read the existing `SPEC.md`.
        -   Ask: "I see the existing spec. Can we base our work on this? Does it need updates?"
        -   If updates needed: Go to **Phase 3 (Specifications)**.
        -   If ready: Proceed directly to **Phase 4 (Roadmap Creation)**.

    -   **If (B) No:**
        -   Proceed to **Phase 2 (Brownfield Detection)**.

---

## Phase 2: Brownfield Detection

**Goal:** Check if there is existing code that needs to be mapped.

1.  **Ask/Check:**
    > "Is there existing code in this folder that we should account for?"

2.  **Logic:**
    -   **If Yes (Existing Code):**
        -   Ask: "Should we map the existing codebase first to create an `ARCHITECTURE.md` file?"
        -   **Option A:** Run `/map` (Recommended for existing code).
        -   **Option B:** Skip mapping and treat as a fresh start (or if architecture is already known).
        -   *After mapping (or skipping), proceed to Phase 3.*

    -   **If No (Empty Folder/New Project):**
        -   Proceed to **Phase 3 (Specifications)**.

---

## Phase 3: Specifications & Deep Questioning

**Goal:** Create a clear, finalized `SPEC.md`.

**ACTION:**
-   **STOP** running this workflow logic temporarily.
-   **READ and FOLLOW** the instructions in `skills/specifications/SKILL.md`.
-   Use the `specifications` skill to:
    1.  Conduct deep questioning (Vision, Users, Scope, Constraints).
    2.  Research technical options if needed (using `context7` or web search).
    3.  Create and finalize `.digido/SPEC.md`.

**Completion Condition:**
-   You have a finalized `.digido/SPEC.md` approved by the user.

---

## Phase 4: Create Roadmap

**Goal:** Translate the SPEC into an executable plan.

**Prerequisite:** A finalized `.digido/SPEC.md`.

1.  **Create `.digido/ROADMAP.md`**:
    -   Break down the project into Milestones and Phases.
    -   **Crucial:** format the roadmap to support parallel execution where possible.
    -   *Example Structure:*
        ```markdown
        # ROADMAP.md

        ## Phase 1: Foundation
        - [ ] 1.1 Core Setup (Critical Path)
        - [ ] 1.2 Database Schema (Can run in parallel with 1.3)
        - [ ] 1.3 API Scaffolding (Can run in parallel with 1.2)
        ```

2.  **Verify:** Ask the user to review the high-level roadmap.

---

## Phase 5: Initialize Project Documentation

**Goal:** Create the "Brain" of the project.

Create the following files in `.digido/` (if they don't exist):

1.  **`.digido/CHANGELOG.md`** (formerly SESSION-HISTORY)
    -   *Purpose:* Track every significant change, decision, and session update.
    -   *Content:* Initialize with "Project Initialized".

2.  **`.digido/STATE.md`**
    -   *Purpose:* Dynamic context for the agent. Current phase, current task, active context.
    -   *Content:* Initialize with current phase (Planning).


4.  **Create Directory:**
    -   `.digido/phases/` (For storing detailed phase plans).
    -   *(Do NOT create `.digido/templates/` found in older versions).*

---

## Phase 6: Git Setup

**Goal:** Version control setup.

1.  **Create `.gitignore`**:
    -   Generate a generic `.gitignore` file suitable for the detected stack (Python/Node/etc).
    -   **Always include:** `.digido/` (optional, based on user pref, usually we keep it), `.env`, `node_modules`, `venv`, `__pycache__`, `.DS_Store`.
    -   *Note:* Ask user if they want to keep digido documentation in git (Recommended: Yes, for context persistence).

2.  **Initialize Repo**:
    -   **Ask:** "Do you want me to initialize the git repository (`git init`)?"
    -   If yes: Run `git init`.
    -   If no: Leave it to the user.

---

## Phase 7: Next Steps

**Goal:** Guide the user to the start line.

1.  **Consult `skill-advisor`**:
    -   Read `skills/skill-advisor/SKILL.md`.
    -   Based on the project type defined in the SPEC (Python Script, Web App, etc.), recommend the next specific command.
    -   *Examples:*
        -   "For this Python project, let's run `/python-build-session`."
        -   "For this Web App, we should start with `/discuss-phase 1`."

2.  **Final Message**:
    ```
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
     digido ► PROJECT SETUP COMPLETE
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    Files Created:
    - .digido/SPEC.md
    - .digido/ROADMAP.md
    - .digido/CHANGELOG.md
    - .digido/STATE.md

    Ready to start?
    Recommended Command: {command from skill-advisor}
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ```

</process>