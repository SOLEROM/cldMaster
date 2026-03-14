---
description: Mark current milestone as complete and archive (Collaborative)
---

# /complete-milestone

<objective>
**Starting milestone completion process.**
We will review your progress, archive completed work, and prepare the project for the next phase. This ensures your project history is clean, organized, and ready for new goals.
</objective>

<process>

## 1. Verify Progress
**Goal:** Ensure we only archive completed work.

**Agent Action:**
1.  Read `.digido/ROADMAP.md`.
2.  Scan the status of all phases.
3.  **If any phase is incomplete:** Stop and kindly inform the Architect which phases are still in progress.
4.  **If all phases are complete:** Proceed to the next step.
   *   *Translation:* "Checking your roadmap to ensure all tasks for this milestone are finished..."

---

## 2. Generate Milestone Summary
**Goal:** Create a permanent record of what was achieved.

**Agent Action:**
1.  Create a new file: `.digido/milestones/{milestone_name}-SUMMARY.md`.
2.  Include the following sections:
    *   **Milestone Name & Date:** When it was finished.
    *   **Deliverables:** A list of the key phases marked as 'Completed' in the Roadmap.
    *   **Highlights:** (Optional) Any major decisions or wins from `DECISIONS.md`.
3.  *Translation:* "Creating a summary document of everything we accomplished in this milestone..."

---

## 3. Archive Documentation
**Goal:** Clean up the workspace for fresh thinking.

**Agent Action:**
1.  Create the archive folder: `.digido/milestones/{milestone_name}/`.
2.  **Move** all phase-specific files (specs, tasks, plans) from `.digido/phases/` into this new folder.
3.  Ensure `.digido/phases/` is now empty but ready for new files.
4.  *Translation:* "Moving completed phase documents to the archive to keep your workspace clean..."

---

## 4. Reset Roadmap for Next Phase
**Goal:** Prepare the board for new tasks.

**Agent Action:**
1.  Edit `.digido/ROADMAP.md`:
    *   Remove the completed phases (they are now archived).
    *   Keep the header and structure intact.
2.  Update `.digido/STATE.md`:
    *   Set current status to "Milestone {name} Complete".
3.  *Translation:* "Clearing the roadmap board so it's ready for your next set of goals..."

---

## 5. Version Control (Git)
**Goal:** Save this state in history.

**Agent Action:**
1.  Propose the following git commands to the Architect:
    *   `git add .`
    *   `git commit -m "docs: complete milestone {name}"`
    *   `git tag -a "{name}" -m "Milestone {name} complete"`
2.  Execute upon approval.
3.  *Translation:* "Saving a snapshot of the project at this milestone using Git..."

---

## 6. Completion
**Goal:** Celebrate and look forward.

**Agent Action:**
1.  Notify the Architect:
    > "🎉 **Milestone {name} Complete!** All work has been archived and your roadmap is clean.
    >
    > **Next Steps:**
    > *   Run `/new-milestone` to start planning the next phase.
    > *   Run `/audit-milestone` if you want to review the summary."

</process>
