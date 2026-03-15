# install

## local

```
> npx get-shit-done-cc@latest

   ██████╗ ███████╗██████╗
  ██╔════╝ ██╔════╝██╔══██╗
  ██║  ███╗███████╗██║  ██║
  ██║   ██║╚════██║██║  ██║
  ╚██████╔╝███████║██████╔╝
   ╚═════╝ ╚══════╝╚═════╝

  Get Shit Done v1.22.4
  A meta-prompting, context engineering and spec-driven
  development system for Claude Code, OpenCode, Gemini, and Codex by TÂCHES.

  Which runtime(s) would you like to install for?

  1) Claude Code (~/.claude)
  2) OpenCode    (~/.config/opencode) - open source, free models
  3) Gemini      (~/.gemini)
  4) Codex       (~/.codex)
  5) All

  Choice [1]: 1
  Where would you like to install?

  1) Global (~/.claude) - available in all projects
  2) Local  (./.claude) - this project only

  Choice [1]: 2
  Installing for Claude Code to ./.claude

  ✓ Installed commands/gsd
  ✓ Installed get-shit-done
  ✓ Installed agents
  ✓ Wrote VERSION (1.22.4)
  ✓ Wrote package.json (CommonJS mode)
  ✓ Installed hooks (bundled)
  ✓ Wrote file manifest (gsd-file-manifest.json)
  ✓ Configured update check hook
  ✓ Configured context window monitor hook
  ✓ Configured statusline

  Done! Open a blank directory in Claude Code and run /gsd:new-project.

  Join the community: https://discord.gg/gsd


```


## tree

```
.claude
├── agents
│   ├── gsd-codebase-mapper.md
│   ├── gsd-debugger.md
│   ├── gsd-executor.md
│   ├── gsd-integration-checker.md
│   ├── gsd-nyquist-auditor.md
│   ├── gsd-phase-researcher.md
│   ├── gsd-plan-checker.md
│   ├── gsd-planner.md
│   ├── gsd-project-researcher.md
│   ├── gsd-research-synthesizer.md
│   ├── gsd-roadmapper.md
│   └── gsd-verifier.md
├── commands
│   └── gsd
│       ├── add-phase.md
│       ├── add-tests.md
│       ├── add-todo.md
│       ├── audit-milestone.md
│       ├── check-todos.md
│       ├── cleanup.md
│       ├── complete-milestone.md
│       ├── debug.md
│       ├── discuss-phase.md
│       ├── execute-phase.md
│       ├── health.md
│       ├── help.md
│       ├── insert-phase.md
│       ├── join-discord.md
│       ├── list-phase-assumptions.md
│       ├── map-codebase.md
│       ├── new-milestone.md
│       ├── new-project.md
│       ├── pause-work.md
│       ├── plan-milestone-gaps.md
│       ├── plan-phase.md
│       ├── progress.md
│       ├── quick.md
│       ├── reapply-patches.md
│       ├── remove-phase.md
│       ├── research-phase.md
│       ├── resume-work.md
│       ├── set-profile.md
│       ├── settings.md
│       ├── update.md
│       ├── validate-phase.md
│       └── verify-work.md
├── get-shit-done
│   ├── bin
│   │   ├── gsd-tools.cjs
│   │   └── lib
│   │       ├── commands.cjs
│   │       ├── config.cjs
│   │       ├── core.cjs
│   │       ├── frontmatter.cjs
│   │       ├── init.cjs
│   │       ├── milestone.cjs
│   │       ├── phase.cjs
│   │       ├── roadmap.cjs
│   │       ├── state.cjs
│   │       ├── template.cjs
│   │       └── verify.cjs
│   ├── references
│   │   ├── checkpoints.md
│   │   ├── continuation-format.md
│   │   ├── decimal-phase-calculation.md
│   │   ├── git-integration.md
│   │   ├── git-planning-commit.md
│   │   ├── model-profile-resolution.md
│   │   ├── model-profiles.md
│   │   ├── phase-argument-parsing.md
│   │   ├── planning-config.md
│   │   ├── questioning.md
│   │   ├── tdd.md
│   │   ├── ui-brand.md
│   │   └── verification-patterns.md
│   ├── templates
│   │   ├── codebase
│   │   │   ├── architecture.md
│   │   │   ├── concerns.md
│   │   │   ├── conventions.md
│   │   │   ├── integrations.md
│   │   │   ├── stack.md
│   │   │   ├── structure.md
│   │   │   └── testing.md
│   │   ├── config.json
│   │   ├── context.md
│   │   ├── continue-here.md
│   │   ├── DEBUG.md
│   │   ├── debug-subagent-prompt.md
│   │   ├── discovery.md
│   │   ├── milestone-archive.md
│   │   ├── milestone.md
│   │   ├── phase-prompt.md
│   │   ├── planner-subagent-prompt.md
│   │   ├── project.md
│   │   ├── requirements.md
│   │   ├── research.md
│   │   ├── research-project
│   │   │   ├── ARCHITECTURE.md
│   │   │   ├── FEATURES.md
│   │   │   ├── PITFALLS.md
│   │   │   ├── STACK.md
│   │   │   └── SUMMARY.md
│   │   ├── retrospective.md
│   │   ├── roadmap.md
│   │   ├── state.md
│   │   ├── summary-complex.md
│   │   ├── summary.md
│   │   ├── summary-minimal.md
│   │   ├── summary-standard.md
│   │   ├── UAT.md
│   │   ├── user-setup.md
│   │   ├── VALIDATION.md
│   │   └── verification-report.md
│   ├── VERSION
│   └── workflows
│       ├── add-phase.md
│       ├── add-tests.md
│       ├── add-todo.md
│       ├── audit-milestone.md
│       ├── check-todos.md
│       ├── cleanup.md
│       ├── complete-milestone.md
│       ├── diagnose-issues.md
│       ├── discovery-phase.md
│       ├── discuss-phase.md
│       ├── execute-phase.md
│       ├── execute-plan.md
│       ├── health.md
│       ├── help.md
│       ├── insert-phase.md
│       ├── list-phase-assumptions.md
│       ├── map-codebase.md
│       ├── new-milestone.md
│       ├── new-project.md
│       ├── pause-work.md
│       ├── plan-milestone-gaps.md
│       ├── plan-phase.md
│       ├── progress.md
│       ├── quick.md
│       ├── remove-phase.md
│       ├── research-phase.md
│       ├── resume-project.md
│       ├── set-profile.md
│       ├── settings.md
│       ├── transition.md
│       ├── update.md
│       ├── validate-phase.md
│       ├── verify-phase.md
│       └── verify-work.md
├── gsd-file-manifest.json
├── hooks
│   ├── gsd-check-update.js
│   ├── gsd-context-monitor.js
│   └── gsd-statusline.js
├── package.json
└── settings.json

```

