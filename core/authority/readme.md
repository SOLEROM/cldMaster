# Authority

 putting everything in CLAUDE.md (user scope) or `.claude/rules/` (project scope) 
 * loads every sessions

When you use `@memory
.md` or put something in `.claude/rules/`, Claude reads it via the Read tool during the conversation - it comes in as tool output. 


### inject context dynamically.
```
claude --system-prompt "$(cat memory.md)"
```

more surgical about what context loads when. 


When you use `--system-prompt`, the content gets injected into the actual system prompt before the conversation starts.

### instruction hierarchy

System prompt content has higher authority than user messages, which have higher authority than tool results. 

System prompt content has higher authority than user messages, which have higher authority than tool results. 

## automate:

```
# Daily development
alias claude-dev='claude --system-prompt "$(cat ~/.claude/contexts/dev.md)"'

# PR review mode
alias claude-review='claude --system-prompt "$(cat ~/.claude/contexts/review.md)"'

# Research/exploration mode
alias claude-research='claude --system-prompt "$(cat ~/.claude/contexts/research.md)"'
```