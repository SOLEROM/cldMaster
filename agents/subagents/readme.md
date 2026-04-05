# subagents

Subagents enable delegated task execution in Claude Code by:

- Creating **isolated AI assistants** with separate context windows
- Providing **customized system prompts** for specialized expertise
- Enforcing **tool access control** to limit capabilities
- Preventing **context pollution** from complex tasks
- Enabling **parallel execution** of multiple specialized tasks

Each subagent operates independently with a clean slate, receiving only the specific context necessary for their task, then returning results to the main agent for synthesis.


- Subagents run in isolated execution contexts (skills adds to the same context)
- use them for delegated work
- if needed different toll access that the main conversation
- if islolated context is needed to avoid conflicts with the main conversation
- delagating subagent dont see the skill loaded in the main conversation and vice versa.
- for needed skill for the subagent add it to agents/aaa.md file the ```skills:``` meta;


## File Locations

Subagent files can be stored in multiple locations with different scopes:

| Priority | Type | Location | Scope |
|----------|------|----------|-------|
| 1 (highest) | **CLI-defined** | Via `--agents` flag (JSON) | Session only |
| 2 | **Project subagents** | `.claude/agents/` | Current project |
| 3 | **User subagents** | `~/.claude/agents/` | All projects |
| 4 (lowest) | **Plugin agents** | Plugin `agents/` directory | Via plugins |


## using
```
/agents
```
This provides an interactive menu to:
- View all available subagents (built-in, user, and project)
- Create new subagents with guided setup
- Edit existing custom subagents and tool access
- Delete custom subagents
- See which subagents are active when duplicates exist

## call options

### Explicit Invocation

You can explicitly request a specific subagent:

```
> Use the test-runner subagent to fix failing tests
> Have the code-reviewer subagent look at my recent changes
> Ask the debugger subagent to investigate this error
```

### @-Mention Invocation

Use the `@` prefix to guarantee a specific subagent is invoked (bypasses automatic delegation heuristics):

```
> @"code-reviewer (agent)" review the auth module
```

### Session-Wide Agent

Run an entire session using a specific agent as the main agent:

```bash
# Via CLI flag
claude --agent code-reviewer

# Via settings.json
{
  "agent": "code-reviewer"
}
```

## list available subagents
```
claude agents
```

