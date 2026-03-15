---
description: Create a new milestone with phases (Agentic & Collaborative)
argument-hint: "<milestone-name>"
---

# /new-milestone Workflow

<objective>
Collaboratively define a new milestone with the user (Architect), including its goal, phases, and success criteria. Then, update the project roadmap and state files accordingly.
</objective>

<process>

## 1. Validate Prerequisites
1.  **Check for Specification**: Verify that `.digido/SPEC.md` exists.
    -   *Action*: Use `find_by_name` or `view_file` to check.
    -   *If missing*: **Stop** and inform the user: "SPEC.md is required to define milestones. Please run `/new-project` or `/specifications` first to define the project scope."

## 2. Collaborative Definition
1.  **Gather Information**: Discuss with the user to define:
    -   **Milestone Name**: (e.g., "v1.0", "MVP", "Beta")
    -   **Goal**: The primary objective.
    -   **Must-haves**: Non-negotiable deliverables.
2.  **Propose Phases**: Based on the goal and `SPEC.md`, propose a logical breakdown of phases.
    -   *Example Request*: "Based on the goal 'MVP', I suggest breaking it down into: Foundation, Core Features, and Polish. What do you think?"
3.  **Refine**: Iterate until the user approves the phase structure.

## 3. Update Documentation
Once the plan is agreed upon, perform the following updates:

### A. Update ROADMAP.md
-   **Read** the existing `.digido/ROADMAP.md` (create if missing).
-   **Append** the new milestone section. Use this format:

    ```markdown
    # Milestone: {Milestone Name}
    > **Goal**: {Goal}

    ## Must-Haves
    - [ ] {Must-have 1}
    - [ ] {Must-have 2}
    ...

    ## Phases

    ### Phase 1: {Phase Name}
    **Status**: ⬜ Not Started
    **Objective**: {Description}

    ### Phase 2: {Phase Name}
    **Status**: ⬜ Not Started
    **Objective**: {Description}
    ...
    ```

### B. Update STATE.md
-   **Update** `.digido/STATE.md` to reflect the new context:
    -   `current_milestone`: {Milestone Name}
    -   `current_phase`: "Not Started"
    -   `status`: "Milestone defined, ready for planning"

## 4. Finalize
1.  **Commit**: (Optional) Commit the changes to `ROADMAP.md` and `STATE.md` with message: `docs: define milestone {Name}`.
2.  **Notify**: Inform the user that the milestone is set up.
3.  **Suggest Next Step**: "Ready to plan Phase 1? Run `/plan 1`."

</process>
