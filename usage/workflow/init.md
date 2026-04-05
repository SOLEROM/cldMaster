# /init

The `/init` command scans your project and generates a `CLAUDE.md` file at the repository root.

`CLAUDE.md` is automatically loaded into Claude's context on every session start. It serves as persistent project documentation — build commands, architecture notes, conventions, and any instructions you want Claude to follow consistently.

**When to use it:**
- At the start of a new project to bootstrap `CLAUDE.md`
- After major structural changes to refresh the project summary

**What it does:**
1. Reads the repo structure, key files, and existing docs
2. Infers build/test commands, tech stack, and conventions
3. Writes a `CLAUDE.md` draft for you to review and edit

After running `/init`, review the generated file and add anything project-specific that Claude missed.

## When to run `/init` again

Run it again when your `CLAUDE.md` has drifted from reality:

- **Major refactor** — directory structure, tech stack, or module boundaries changed significantly
- **New tooling** — build system, test runner, linter, or package manager replaced
- **Onboarding a new area** — you added a backend to a frontend repo (or vice versa) and the existing `CLAUDE.md` doesn't cover it
- **CLAUDE.md is stale/wrong** — Claude keeps making mistakes that a correct `CLAUDE.md` would prevent

**When NOT to run it** — if your `CLAUDE.md` is hand-tuned with custom instructions, `/init` will overwrite or dilute them. In that case, manually update the relevant sections instead.
