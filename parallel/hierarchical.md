# Hierarchical Pattern

A tree of agents where a top-level manager delegates to sub-managers, who each delegate to workers. Each layer handles coordination for its own subtree.

```mermaid
flowchart TD
    G["Goal"] --> M["Top Manager"]
    M --> SM1["Sub-Manager\nFrontend"]
    M --> SM2["Sub-Manager\nBackend"]
    M --> SM3["Sub-Manager\nInfra"]
    SM1 --> W1["Worker\nUI"]
    SM1 --> W2["Worker\nStyles"]
    SM2 --> W3["Worker\nAPI"]
    SM2 --> W4["Worker\nDB"]
    SM3 --> W5["Worker\nDeploy"]
    SM3 --> W6["Worker\nMonitor"]
```

## When to Use
- Very large tasks that overwhelm a single orchestrator
- Projects with distinct domains that each have their own subtasks
- When sub-managers need autonomy within their domain
- Simulating team structures (PM → Tech Lead → Engineer)
