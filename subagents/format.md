# Format

Subagents are defined in YAML frontmatter followed by the system prompt in markdown:

```yaml
---
name: your-sub-agent-name
description: Description of when this subagent should be invoked
tools: tool1, tool2, tool3  # Optional - inherits all tools if omitted
disallowedTools: tool4  # Optional - explicitly disallowed tools
model: sonnet  # Optional - sonnet, opus, haiku, or inherit
permissionMode: default  # Optional - permission mode
maxTurns: 20  # Optional - limit agentic turns
skills: skill1, skill2  # Optional - skills to preload into context
mcpServers: server1  # Optional - MCP servers to make available
memory: user  # Optional - persistent memory scope (user, project, local)
background: false  # Optional - run as background task
effort: high  # Optional - reasoning effort (low, medium, high, max)
isolation: worktree  # Optional - git worktree isolation
initialPrompt: "Start by analyzing the codebase"  # Optional - auto-submitted first turn
hooks:  # Optional - component-scoped hooks
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/security-check.sh"
---

Your subagent's system prompt goes here. This can be multiple paragraphs
and should clearly define the subagent's role, capabilities, and approach
to solving problems.
```

### Configuration Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique identifier (lowercase letters and hyphens) |
| `description` | Yes | Natural language description of purpose. Include "use PROACTIVELY" to encourage automatic invocation |
| `tools` | No | Comma-separated list of specific tools. Omit to inherit all tools. Supports `Agent(agent_name)` syntax to restrict spawnable subagents |
| `disallowedTools` | No | Comma-separated list of tools the subagent must not use |
| `model` | No | Model to use: `sonnet`, `opus`, `haiku`, full model ID, or `inherit`. Defaults to configured subagent model |
| `permissionMode` | No | `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | No | Maximum number of agentic turns the subagent can take |
| `skills` | No | Comma-separated list of skills to preload. Injects full skill content into the subagent's context at startup |
| `mcpServers` | No | MCP servers to make available to the subagent |
| `hooks` | No | Component-scoped hooks (PreToolUse, PostToolUse, Stop) |
| `memory` | No | Persistent memory directory scope: `user`, `project`, or `local` |
| `background` | No | Set to `true` to always run this subagent as a background task |
| `effort` | No | Reasoning effort level: `low`, `medium`, `high`, or `max` |
| `isolation` | No | Set to `worktree` to give the subagent its own git worktree |
| `initialPrompt` | No | Auto-submitted first turn when the subagent runs as the main agent |

### Tool Configuration Options

**Option 1: Inherit All Tools (omit the field)**
```yaml
---
name: full-access-agent
description: Agent with all available tools
---
```

**Option 2: Specify Individual Tools**
```yaml
---
name: limited-agent
description: Agent with specific tools only
tools: Read, Grep, Glob, Bash
---
```

**Option 3: Conditional Tool Access**
```yaml
---
name: conditional-agent
description: Agent with filtered tool access
tools: Read, Bash(npm:*), Bash(test:*)
---
```