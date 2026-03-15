# File Update Formats

## STATE.md Updates

Every mirror report updates `.digido/STATE.md`:

```markdown
---
last_updated: {timestamp}
session: {session number or id}
---

## Current Status
phase: {phase name}
task: {current task}
status: {on_track | behind | blocked | completed}
progress: {N}/{total} tasks ({percentage}%)

## Last Completed
- task: {name}
  result: {success | partial | failed}
  files_changed: [{list}]

## Current Focus
- task: {name}
  started: {when}
  status: {description}
  blockers: [{if any}]

## Next Up
1. {next task}
2. {task after that}

## Open Issues
- {issue description} — severity: {low/med/high}

## Decisions Made
- {decision}: {what was decided and why}

## Decisions Pending
- {question}: {options being considered}
```

## ARCHITECTURE.md Updates

When the mirror detects structural changes:

```
- New file created → Add to Components section
- File deleted → Remove from Components
- New dependency added → Update integration points
- Import structure changed → Update import graph
- New env var needed → Add to configuration
```

**Don't rewrite the whole file.** Update only the sections that changed.
