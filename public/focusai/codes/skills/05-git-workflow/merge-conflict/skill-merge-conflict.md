---
name: merge-conflict
description: Resolve git merge conflicts systematically. Auto-load when merge conflicts are present or when asked how to resolve conflicts.
---

# Merge Conflict Resolution

Resolve conflicts by understanding what both sides *intended*, not just what they changed.

## Understanding the Conflict Markers

```
<<<<<<< HEAD (or ours)
Your current branch's version
=======
The incoming branch's version
>>>>>>> feature/other-branch (or theirs)
```

- **HEAD / ours** — what you have on your current branch
- **theirs** — what's coming in from the branch you're merging

The resolution is whatever the combined intent of both changes should be.

## Resolution Strategies

### 1. Take ours (discard theirs)
```bash
git checkout --ours file.txt
git add file.txt
```
Use when: their change is no longer needed, or was superseded by yours.

### 2. Take theirs (discard ours)
```bash
git checkout --theirs file.txt
git add file.txt
```
Use when: your change should be replaced by theirs.

### 3. Manual merge (most common)
Open the file, understand both changes, write the version that incorporates both intents.

```
<<<<<<< HEAD
const timeout = config.timeout;
=======
const timeout = options.timeout ?? 5000;
>>>>>>> feature/fallback-timeout

# Resolution — combine both: use config, fall back to options, then default
const timeout = config.timeout ?? options.timeout ?? 5000;
```

### 4. Use a merge tool
```bash
git mergetool  # opens your configured visual merge tool
# VS Code, IntelliJ, vimdiff — configure in .gitconfig
```

---

## Common Conflict Types

### Formatting conflicts
**Cause:** One branch ran the formatter, the other has unformatted code.

**Fix:** Take one side entirely, then run the formatter again:
```bash
git checkout --theirs file.js
npx prettier --write file.js
git add file.js
```

### Dependency conflicts (`package.json`, `package-lock.json`)
**Cause:** Both branches added/updated packages.

```json
// OURS
"dependencies": {
  "lodash": "4.17.21"
}

// THEIRS
"dependencies": {
  "ramda": "0.29.0"
}

// RESOLUTION — include both
"dependencies": {
  "lodash": "4.17.21",
  "ramda": "0.29.0"
}
```

Then: `npm install` to regenerate the lockfile.

### Logic conflicts
Both branches changed the same logic in different ways. Read both versions carefully:

1. What was the original code doing?
2. What did *our* change intend to accomplish?
3. What did *their* change intend to accomplish?
4. Write code that accomplishes both intents.

### Import order conflicts
Usually safe to combine both import lists. Run your import sorter afterward.

### Generated file conflicts
For generated files (Prisma client, GraphQL types, migration checksums):
- Resolve conflicts in the *source* first
- Then regenerate the file: `npx prisma generate`, etc.
- Never manually resolve generated file conflicts

---

## After Resolving

```bash
# Mark as resolved by staging
git add file.txt

# Continue the merge/rebase
git merge --continue
# or
git rebase --continue

# Verify the result compiles and tests pass
npm test
```

---

## When to Abort and Start Over

```bash
git merge --abort
git rebase --abort
```

Abort if:
- You're unsure which side is correct and need to ask the author
- The conflict is in generated code that needs to be regenerated
- You accidentally made a mess of the resolution

Starting over is always safer than committing a wrong resolution.

---

## Prevention

- **Merge main into your branch frequently** — smaller conflicts are easier to resolve
- **Keep PRs small** — large PRs create large conflicts
- **Communicate** — if you're about to refactor a heavily-used file, tell your team
- **Feature flags** — merge incomplete features behind flags to avoid long-lived branches
