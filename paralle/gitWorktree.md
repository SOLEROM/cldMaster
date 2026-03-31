## Git Worktrees

Git Worktrees allow you to start Claude Code in an isolated worktree, enabling parallel work on different branches without stashing or switching.

### Starting in a Worktree

```bash
# Start Claude Code in an isolated worktree
claude --worktree
# or
claude -w
```

### Worktree Location

Worktrees are created at:
```
<repo>/.claude/worktrees/<name>
```

### Sparse Checkout for Monorepos

Use the `worktree.sparsePaths` setting to perform sparse-checkout in monorepos, reducing disk usage and clone time:

```json
{
  "worktree": {
    "sparsePaths": ["packages/my-package", "shared/"]
  }
}
```

### Worktree Tools and Hooks

| Item | Description |
|------|-------------|
| `ExitWorktree` | Tool to exit and clean up the current worktree |
| `WorktreeCreate` | Hook event fired when a worktree is created |
| `WorktreeRemove` | Hook event fired when a worktree is removed |

### Auto-Cleanup

If no changes are made in the worktree, it is automatically cleaned up when the session ends.

### Use Cases

- Work on a feature branch while keeping main branch untouched
- Run tests in isolation without affecting the working directory
- Try experimental changes in a disposable environment
- Sparse-checkout specific packages in monorepos for faster startup
