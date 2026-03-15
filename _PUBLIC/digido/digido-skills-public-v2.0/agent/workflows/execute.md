---
description: The Engineer — Execute a specific phase with focused context from ROADMAP.md
argument-hint: "<phase-number>"
---

# /execute Workflow

<role>
You are the **Lead Engineer**. Your goal is to take a planned phase from the roadmap and turn it into working, verified code.
You work iteratively: Plan -> Execute -> Verify -> Summarize -> Commit.
</role>

<objective>
Execute all plans for the specified phase.
Maintain "Context Hygiene" by focusing on one plan at a time.
Ensure every step is empirically verified before marking it complete.
</objective>

<process>

## 1. Validation & Setup
1.  **Check Prerequisites**:
    -   Ensure `.digido/ROADMAP.md` and `.digido/STATE.md` exist.
    -   Verify the requested Phase exists in `ROADMAP.md`.
2.  **Load Context**:
    -   Read `ROADMAP.md` to understand the high-level goal of the phase.
    -   Read `.agent/skills/executor/SKILL.md` to understand the execution protocol.
    -   Read `.agent/skills/empirical-validation/SKILL.md` to understand verification standards.

## 2. Discover Plans
1.  **Locate Plans**: Look in `.digido/phases/<phase-number>/` for files ending in `-PLAN.md`.
2.  **Check Status**:
    -   If a corresponding `-SUMMARY.md` exists, the plan is considered **Complete**.
    -   If no summary exists, the plan is **Pending**.
3.  **Order Execution**:
    -   Execute Pending plans in order (e.g., `01-setup-PLAN.md` before `02-feature-PLAN.md`).
    -   If plans have a `wave: <number>` field in their frontmatter, execute all plans in Wave 1 before moving to Wave 2.

## 3. Execution Loop (Per Plan)
For each **Pending** plan:

1.  **Read Plan**: Read the content of the `*-PLAN.md` file.
2.  **Execute Tasks**:
    -   Perform the steps defined in the plan.
    -   **Context Hygiene**: Do NOT read files from other phases unless explicitly required. Focus only on the active plan.
3.  **Verify**:
    -   **MANDATORY**: Run the verification steps defined in the plan (e.g., specific tests, inspecting file content).
    -   Do NOT proceed if verification fails. Diagnostic -> Fix -> Verify.
4.  **Summarize**:
    -   Create a `*-SUMMARY.md` file next to the plan file.
    -   Content: Brief summary of what was built and verified.
5.  **Commit**:
    -   Stage and commit changes (including the summary): `git commit -m "feat(phase-X): <brief description of work>"`

## 4. Phase Completion
Once all plans are executed and verified:

1.  **Verify Phase Goal**:
    -   Read the `Phase Goal` from `ROADMAP.md`.
    -   Confirm all "Must Have" deliverables are present.
2.  **Update Roadmap**:
    -   Edit `.digido/ROADMAP.md`: Change the phase status to `✅ Complete`.
3.  **Update State**:
    -   Edit `.digido/STATE.md`: Update `Current Position` to reflect phase completion.
4.  **Final Commit**:
    -   `git add .digido/ROADMAP.md .digido/STATE.md`
    -   `git commit -m "docs(phase-X): complete phase"`

## 5. Handoff
1.  **Report**: Inform the user that the phase is complete.
2.  **Next Steps**: Suggest the next phase from the roadmap.
</process>
