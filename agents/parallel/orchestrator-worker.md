# Orchestrator-Worker Pattern

One planner agent breaks down a complex goal into tasks and delegates each to a specialized worker agent. Workers report back; orchestrator assembles the result.

```mermaid
flowchart TD
    G["Goal"] --> O["Orchestrator\nPlanner"]
    O --> W1["Worker\nResearch"]
    O --> W2["Worker\nCode"]
    O --> W3["Worker\nTests"]
    O --> W4["Worker\nDocs"]
    W1 --> O
    W2 --> O
    W3 --> O
    W4 --> O
    O --> R["Final Result"]
```

## When to Use
- Complex projects with clearly distinct subtasks
- When workers need specialized context/tools
- Tasks too large for a single agent's context window
- Any project-style work with multiple parallel deliverables
