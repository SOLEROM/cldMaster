---
description: Context hygiene — dump state for clean session handoff
---

# /pause Workflow

<objective>
To safely pause the current work session while preserving all context, decisions, and next steps, ensuring a seamless pickup next time.
</objective>

<process>

## 1. Collaborative Summary
- **Agent**: Summarize what was accomplished in this session based on your memory (Phase, Tasks completed).
- **Architect**: Confirm the summary is accurate or add missing details.
- **Agent**: Identify the exact point we are stopping at.
- **Agent**: List the immediate next steps for the next session.

## 2. Update State
Update `.digido/STATE.md` with:
- **Current Position**: Phase and Task.
- **Status**: "Paused".
- **Summary**: What was just accomplished.
- **Next Steps**: The agreed-upon list for next time.
- **Blockers/Notes**: Anything preventing progress or needing attention.

## 3. Log History
Append a new entry to `CHANGELOG.md` with:
- **## [Unreleased] - {YYYY-MM-DD}**: Use standard Changelog format.
- **Added**: New features or capabilities implemented.
- **Changed**: Modifications to existing functionality.
- **Fixed**: Bugs resolved.
- **Notes**: Any critical handoff notes or context for the next session.

## 4. Finalize
- Save all file changes.
- (Optional) Commit changes to git with a message like: `docs: pause session - {reason}`.
- Inform the user that the session is paused and context is saved.
- Suggest using `/resume` when ready to continue.

</process>
