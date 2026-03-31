# claude
* [install](./install/install.md) | [desktop](./install/desktop.md)
* [concepts](./concepts.md)
* [manuals](./manuals.md) | [tips](./tips/readme.md)


## basic concepts
* [custom commands](./configs/customCmds.md) add new commands to claude
* [permissions](./configs/permissions.md) for tools
* [repetitive errors](./tips/repetiveErrors.md) tips
* [planMode](./modes/planMode.md) 
* [thinking](./modes/thinking.md)
* [github](./actions/githubs.md) integration
* [sdk](./sdk/readme.md)
* [plugins](./plugins/readme.md) 

### customization options
* [claude.md](./claude_md/readme.md)  - always-on project standards
* [skills](./skills/readme.md) - load on demand for task-specific expertise
* [subagents](./subagents/readme.md) - isolated execution contexts
* [hooks](./hooks/readme.md) - trigger actions on events
* [mcpServers](./mcp/readme.md) - provide external tools 

## teams
* [teams](./teams/readme.md) 
* [superpowers](./superpowers/readme.md)


**advanced features include:**
- **Planning Mode**: Create detailed implementation plans before coding
- **Extended Thinking**: Deep reasoning for complex problems
- **Auto Mode**: Background safety classifier reviews each action before execution (Research Preview)
- **Background Tasks**: Run long operations without blocking the conversation
- **Permission Modes**: Control what Claude can do (`default`, `acceptEdits`, `plan`, `auto`, `dontAsk`, `bypassPermissions`)
- **Print Mode**: Run Claude Code non-interactively for automation and CI/CD (`claude -p`)
- **Session Management**: Manage multiple work sessions
- **Interactive Features**: Keyboard shortcuts, multi-line input, and command history
- **Voice Dictation**: Push-to-talk voice input with 20-language STT support
- **Channels**: MCP servers push messages into running sessions (Research Preview)
- **Remote Control**: Control Claude Code from Claude.ai or the Claude app
- **Web Sessions**: Run Claude Code in the browser at claude.ai/code
- **Desktop App**: Standalone app for visual diff review and multiple sessions
- **Task List**: Persistent task tracking across context compactions
- **Prompt Suggestions**: Smart command suggestions based on context
- **Git Worktrees**: Isolated worktree branches for parallel work
- **Sandboxing**: OS-level filesystem and network isolation
- **Managed Settings**: Enterprise deployment via plist, Registry, or managed files
- **Configuration**: Customize behavior with JSON configuration files

