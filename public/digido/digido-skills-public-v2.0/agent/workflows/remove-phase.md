---
description: Remove a phase from the roadmap and renumber subsequent phases
argument-hint: "<phase-number>"
---

# Remove Phase Workflow

## 1. Safety Checks
1.  **Read** `.digido/ROADMAP.md`.
2.  **Verify** that Phase `<phase-number>` exists.
3.  **Check Status** of the phase:
    -   If "Not Started": Safe to remove.
    -   If "In Progress": **STOP** and ask for user confirmation before proceeding.
    -   If "Completed": **STOP**. Do not remove completed phases; archive them instead (unless explicitly overruled by user).
4.  **Check Dependencies**:
    -   Look for other phases that depend on this phase (e.g., "Depends on Phase N").
    -   If dependencies exist, **STOP** and warn the user. They must update dependencies first or confirm breaking changes.

## 2. Removal
1.  **Remove** the phase block from `.digido/ROADMAP.md`.
2.  **Delete** the corresponding directory `.digido/phases/<phase-number>/` if it exists (Use `run_command` with `Remove-Item` for PowerShell or `rm -rf` for Bash, or `delete_file` tool if available/applicable for single files, but likely need recursive delete for directory).
    - Checks for OS to use correct command.

## 3. Renumbering
1.  **Renumber** all subsequent phases in `ROADMAP.md`:
    -   Phase N+1 becomes Phase N.
    -   Phase N+2 becomes Phase N+1.
    -   Etc.
2.  **Update Dependencies** in `ROADMAP.md` to reflect the new numbers.

## 4. State Update
1.  **Update** `.digido/STATE.md` to reflect the change.
2.  **Commit** changes:
    -   Message: "docs: remove phase <phase-number>"
