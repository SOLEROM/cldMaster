# team hooks

Agent Teams introduce two additional hook events:

| Event | Fires When | Use Case |
|-------|-----------|----------|
| `TeammateIdle` | A teammate finishes its current task and has no pending work | Trigger notifications, assign follow-up tasks |
| `TaskCompleted` | A task in the shared task list is marked complete | Run validation, update dashboards, chain dependent work |
