# Spawnable Subagents


You can control which subagents a given subagent is allowed to spawn by using the `Agent(agent_type)` syntax in the `tools` field. This provides a way to allowlist specific subagents for delegation.

> **Note**: In v2.1.63, the `Task` tool was renamed to `Agent`. Existing `Task(...)` references still work as aliases.

### Example

```yaml
---
name: coordinator
description: Coordinates work between specialized agents
tools: Agent(worker, researcher), Read, Bash
---

You are a coordinator agent. You can delegate work to the "worker" and
"researcher" subagents only. Use Read and Bash for your own exploration.
```
