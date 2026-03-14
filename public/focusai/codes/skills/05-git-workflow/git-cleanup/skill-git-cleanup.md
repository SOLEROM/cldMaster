---
name: git-cleanup
description: Clean up git branches, stashes, and repository clutter. Use when managing stale branches, after merging PRs, or when the repo has accumulated clutter.
disable-model-invocation: true
---

# Git Cleanup

Clean up the repository safely. Always verify before deleting.

## Current State

**All local branches:**
`!git branch -a`

**Merged branches:**
`!git branch --merged main 2>/dev/null || git branch --merged master`

**Stale remote-tracking branches:**
`!git remote prune origin --dry-run`

**Current stashes:**
`!git stash list`

---

## Branch Cleanup

### Step 1: Delete merged local branches

```bash
# Preview — check these are safe to delete
git branch --merged main | grep -v 'main\|master\|develop\|HEAD'

# Delete them
git branch --merged main | grep -v 'main\|master\|develop\|HEAD' | xargs git branch -d
```

### Step 2: Clean up stale remote-tracking refs

```bash
# Remove remote-tracking branches where the remote branch is gone
git remote prune origin

# Or: fetch with prune in one step
git fetch --prune
```

### Step 3: Delete remote branches (after merging PRs)

```bash
# Delete a remote branch after its PR is merged
git push origin --delete feature/my-old-feature

# List all remote branches older than 30 days (no automatic delete — review first)
git for-each-ref --sort=committerdate refs/remotes/origin --format='%(committerdate:relative) %(refname:short)' | grep -v 'HEAD\|main\|master\|develop'
```

---

## Stash Cleanup

```bash
# Review stashes before deleting
git stash list
git stash show stash@{0}  # see what's in oldest stash
git stash show stash@{0} -p  # see full diff

# Drop a specific stash
git stash drop stash@{0}

# Clear ALL stashes (irreversible)
git stash clear
```

---

## Squash Before Merge

For PRs with "fix typo", "WIP", "oops" commits — squash to one clean commit:

```bash
# Interactive rebase to squash last N commits
git rebase -i HEAD~N

# In the editor: change 'pick' to 'squash' (or 's') for commits to squash
# The first 'pick' stays as 'pick' — it's the base commit
```

Or squash-merge from the PR UI (GitHub/GitLab "Squash and Merge").

---

## Tag Cleanup

```bash
# List all tags
git tag

# Delete a local tag
git tag -d v0.0.1-test

# Delete a remote tag
git push origin --delete v0.0.1-test
```

---

## Safety Rules

1. **Never force-delete** (`-D`) without confirming the branch is truly merged
2. **Never prune remote** without fetching first (`git fetch --prune` in one step)
3. **Check stash content** before dropping — stashes have no recovery
4. **Don't delete branches** with unmerged work someone else might need
5. **Backup before squashing** — create a backup branch: `git branch backup/feature-name`

---

## After Cleanup

```bash
# Verify clean state
git branch -a | wc -l          # total branches remaining
git log --oneline --graph -15  # confirm history looks correct
git status                     # clean working tree
```
