# Frontmatter

```yaml
---
name: my-skill
description: What this skill does and when to use it
argument-hint: "[filename] [format]"        # Hint for autocomplete
disable-model-invocation: true              # Only user can invoke
user-invocable: false                       # Hide from slash menu
allowed-tools: Read, Grep, Glob             # Restrict tool access
model: opus                                 # Specific model to use
effort: high                                # Effort level override (low, medium, high, max)
context: fork                               # Run in isolated subagent
agent: Explore                              # Which agent type (with context: fork)
shell: bash                                 # Shell for commands: bash (default) or powershell
hooks:                                      # Skill-scoped hooks
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
---
```

| Field | Description |
|-------|-------------|
| `name` | Lowercase letters, numbers, hyphens only (max 64 chars). Cannot contain "anthropic" or "claude". |
| `description` | What the Skill does AND when to use it (max 1024 chars). Critical for auto-invocation matching. |
| `argument-hint` | Hint shown in the `/` autocomplete menu (e.g., `"[filename] [format]"`). |
| `disable-model-invocation` | `true` = only the user can invoke via `/name`. Claude will never auto-invoke. |
| `user-invocable` | `false` = hidden from the `/` menu. Only Claude can invoke it automatically. |
| `allowed-tools` | Comma-separated list of tools the skill may use without permission prompts. |
| `model` | Model override while the skill is active (e.g., `opus`, `sonnet`). |
| `effort` | Effort level override while the skill is active: `low`, `medium`, `high`, or `max`. |
| `context` | `fork` to run the skill in a forked subagent context with its own context window. |
| `agent` | Subagent type when `context: fork` (e.g., `Explore`, `Plan`, `general-purpose`). |
| `shell` | Shell used for `!`command`` substitutions and scripts: `bash` (default) or `powershell`. |
| `hooks` | Hooks scoped to this skill's lifecycle (same format as global hooks). |
