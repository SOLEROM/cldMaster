# Discovery

## general info

**Nested directories**: When you work with files in subdirectories, Claude Code automatically discovers skills from nested `.claude/skills/` directories. For example, if you're editing a file in `packages/frontend/`, Claude Code also looks for skills in `packages/frontend/.claude/skills/`. This supports monorepo setups where packages have their own skills.

**`--add-dir` directories**: Skills from directories added via `--add-dir` are loaded automatically with live change detection. Any edits to skill files in those directories take effect immediately without restarting Claude Code.

**Description budget**: Skill descriptions (Level 1 metadata) are capped at **2% of the context window** (fallback: **16,000 characters**). If you have many skills installed, some may be excluded. Run `/context` to check for warnings. Override the budget with the `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable.

## load unload toggle

TBD

