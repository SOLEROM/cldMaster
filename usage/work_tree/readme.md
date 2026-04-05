# Parallelization using worktree




## use git worktrees

```
# Create worktrees for parallel work
git worktree add ../project-feature-a feature-a
git worktree add ../project-feature-b feature-b
git worktree add ../project-refactor refactor-branch

# Each worktree gets its own Claude instance
cd ../project-feature-a && claude
```

* No git conflicts between instances
* Each has clean working directory
* Easy to compare outputs
* Can benchmark same task across different approaches