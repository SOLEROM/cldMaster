---
description: Clean handoff between sessions or agents — saves complete state for seamless continuation.
argument-hint: "[reason: 'end of session' | 'context full' | 'switching agent' | 'blocked']"
---

# /python-session-handoff Workflow

<role>
You are a session handoff specialist. When a session ends — by choice, by context limits, or by blockage — you make sure the NEXT session can pick up instantly without losing a single piece of context.

The next session might be you with fresh context, a different agent, or the same user tomorrow. They should read your handoff and know exactly where they are in 30 seconds.
</role>

<objective>
Create a complete, clean handoff that captures: what was done, what's in progress, what's next, what's broken, and what decisions are pending. The next session reads STATE.md and starts working — no archaeology needed.
</objective>

<context>
**Input:** $ARGUMENTS — reason for handoff (end of session, context full, switching agent, blocked).

**Required files:**
- `.digido/STATE.md` (current state)
- `ARCHITECTURE.md` (current structure)
- `PLAN.md` (current plan)
- `.digido/DEBUG.md` (if debugging was in progress)

**Skills used:**
- `architect-mirror` → Final status snapshot
- `user-explainer` → Explain to user what's being saved
</context>

<process>

## 1. Trigger Handoff
Acknowledge the handoff request and reason (End of session, Context full, etc.).

## 2. Run Architect Mirror — Final Snapshot
Use `architect-mirror` to generate a final status report of what was accomplished and what is pending.

## 3. Update STATE.md
Write a complete state file that the next session can parse instantly. This is the "brain dump" for the next agent.

```markdown
---
last_updated: {timestamp}
session_number: {N}
handoff_reason: {end_of_session | context_full | switching_agent | blocked}
---

## Quick Resume
> The next session should start from: {exact next action}
> Priority: {what's most important right now}
> Warning: {any active issues or risks}

## Progress
- phase: {current phase}
- plan: {current plan name}
- tasks_completed: {N}/{total}
- percentage: {N}%

## Last Action
- what: {exact description of last thing done}
- file: {file that was being worked on}
- status: {completed | in_progress | failed}
- validated: {yes | no | partial}

## Next Action
- what: {exact description of what to do next}
- file: {file to work on}
- context_needed: [{files the next session should load}]
- notes: {anything important about this task}

## In Progress (Unfinished)
- task: {if a task was mid-execution}
  status: {where it stopped}
  what_was_done: {partial work completed}
  what_remains: {what still needs to happen}

## Open Issues
- {issue 1}: severity {low/med/high} — {description}
- {issue 2}: severity {low/med/high} — {description}

## Active Debug (If Any)
- issue: {what's being debugged}
- strikes: {0-3}
- circular: {false | true}
- debug_file: .digido/DEBUG.md
- last_hypothesis: {what was being tested}

## Files Touched This Session
| File | Action | Status |
|------|--------|--------|
| {file} | {created/modified/deleted} | {complete/partial} |

## Packages Installed This Session
| Package | Version | Reason |
|---------|---------|--------|
| {pkg} | {ver} | {why} |

## Decisions Made
- {decision}: {what was decided and why}

## Decisions Pending
- {question}: {options being considered — user needs to decide}

## Environment State
- python: {version}
- venv: {path}
- os: {Windows/Linux/Mac}
- key_packages: {relevant versions}
```

## 4. Update CHANGELOG.md
Append a clear, concise session summary to `CHANGELOG.md`. This serves as the permanent history of the project.

```markdown
## [{Date}] Session {N}
- **Type:** {Feature | Fix | Refactor | Docs...}
- **Changes:**
  - {Brief bullet point of change 1}
  - {Brief bullet point of change 2}
- **Decisions:** {Key decision if any}
```

## 5. User Summary (Hebrew)
Use `user-explainer` to give a final summary in Hebrew.
- **מה עשינו:** Summary of work.
- **איפה עצרנו:** Exact point to resume.
- **הצעד הבא:** What needs to happen next.

## 6. Close Session
Indicate clearly that the state is saved and the session can be closed or restarted with `/python-build-session continue`.

</process>

<related>
## Related

### Workflows
| Workflow | Relationship |
|----------|-------------|
| `/python-build-session` | Resume after handoff |
| `/python-verify-and-fix` | Fix blockers before resuming |

### Skills
| Skill | Role in Handoff |
|-------|----------------|
| `architect-mirror` | Final status snapshot |
| `user-explainer` | Explain handoff to user |
</related>
