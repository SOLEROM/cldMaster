# Background Subagents

Subagents can run in the background, freeing up the main conversation for other tasks.

### Configuration

Set `background: true` in the frontmatter to always run the subagent as a background task:

```yaml
---
name: long-runner
background: true
description: Performs long-running analysis tasks in the background
---
```


### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+B` | Background a currently running subagent task |
| `Ctrl+F` | Kill all background agents (press twice to confirm) |
