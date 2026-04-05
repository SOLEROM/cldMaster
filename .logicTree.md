# logicTree.md

## Structure Principles
- max_depth: 3
- naming: snake_case
- index folders preferred
- placeholders must include "TBD"

## Folder Definitions

### actions/
- purpose: GitHub and external service integrations
- contains: github integration docs
- excludes: non-markdown images (preserved in place)

### authority/
- purpose: Topic node for authority/permissions concepts
- contains: overview readme

### checkpoints/
- purpose: Checkpoint usage patterns and examples
- contains: checkpoint examples, readme

### claude_md/
- purpose: Topic node for CLAUDE.md configuration
- contains: overview readme

### cli/
- purpose: CLI commands, built-in tools, keyboard shortcuts, memory, usage
- contains: buildIn.md, commands.md, keyboard.md, memory.md, usage.md
- excludes: non-CLI topics

### config/
- purpose: All configuration — settings, examples, custom commands, permissions
- contains: settings.md, config_example.md, custom_cmds.md, permissions.md
- excludes: mode-specific config (→ modes/)

### design/
- purpose: Topic node for design patterns
- contains: overview readme

### eval/
- purpose: Topic node for evaluation approaches
- contains: overview readme

### hooks/
- purpose: Hook demos, gotchas, and how-to guides with code examples
- contains: demo files, gotchas.md, readme, how_to_guide/ subfolder
- excludes: non-markdown scripts in how_to_guide/ (preserved in place)

### install/
- purpose: Installation guides for CLI and desktop
- contains: install.md, desktop.md

### mcp/
- purpose: MCP server documentation
- contains: browser.md, server.md, readme

### media/
- purpose: Non-KB image assets — skipped (0% markdown)

### modes/
- purpose: Claude Code operating modes
- contains: plan.md, plan_example.md, auto.md, thinking.md, print.md, extend.md

### parallel/
- purpose: Parallel task execution patterns
- contains: parallel execution docs

### permissions/
- purpose: Permission configuration reference
- contains: permission docs

### plugins/
- purpose: Plugin creation and examples
- contains: createPlugin.md, howto.md, example subfolders

### rules/
- purpose: Rules and constraints documentation
- contains: README.md

### sdk/
- purpose: SDK documentation
- contains: readme

### session/
- purpose: Session management
- contains: session docs

### skills/
- purpose: Skills system — discovery, creation, usage, verification
- contains: discovery.md, front.md, skillCreator.md, skill_demo1.md, usage.md, verifier.md

### subagents/
- purpose: Subagent execution contexts
- contains: background.md, buildIn.md, format.md, memory.md, spaw.md, worktree.md

### superpowers/
- purpose: Topic node for superpowers feature
- contains: overview readme

### tasks/
- purpose: Task scheduling, background execution, loop management
- contains: background.md, loop.md, schedule.md

### teams/
- purpose: Team and multi-agent setup
- contains: team docs, example subfolder

### tips/
- purpose: Tips, common error patterns, command reference
- contains: commands.md, repetitive_errors.md, readme

### token_optimization/
- purpose: Token usage optimization strategies
- contains: optimization docs

## Grouping Rules
- group by topic similarity
- if folder > 10 items → split
- avoid single-file folders unless they are clear conceptual/topic nodes
- prefer flat structure (all active topics at depth 1)

## Anti-Patterns
- deep nesting (> 3)
- camelCase names (use snake_case)
- duplicate folders for same topic (e.g. config + configs → merge)
- ungrouped large folders

## Manifest
| folder | depth | readme | items |
|--------|-------|--------|-------|
| actions/ | 1 | ✓ | 1 |
| authority/ | 1 | ✓ | 1 |
| checkpoints/ | 1 | ✓ | 2 |
| claude_md/ | 1 | ✓ | 1 |
| cli/ | 1 | ✓ | 5 |
| config/ | 1 | ✓ | 4 |
| design/ | 1 | ✓ | 1 |
| eval/ | 1 | ✓ | 1 |
| hooks/ | 1 | ✓ | 4 |
| install/ | 1 | ✓ | 2 |
| mcp/ | 1 | ✓ | 3 |
| modes/ | 1 | ✓ | 6 |
| parallel/ | 1 | ✓ | 2 |
| permissions/ | 1 | ✓ | 2 |
| plugins/ | 1 | ✓ | 4 |
| rules/ | 1 | ✓ | 1 |
| sdk/ | 1 | ✓ | 1 |
| session/ | 1 | ✓ | 2 |
| skills/ | 1 | ✓ | 7 |
| subagents/ | 1 | ✓ | 7 |
| superpowers/ | 1 | ✓ | 1 |
| tasks/ | 1 | ✓ | 3 |
| teams/ | 1 | ✓ | 8 |
| tips/ | 1 | ✓ | 3 |
| token_optimization/ | 1 | ✓ | 3 |
