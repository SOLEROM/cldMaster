## Auto Mode

Auto Mode is a Research Preview permission mode (March 2026) that uses a background safety classifier to review each action before execution. It allows Claude to work autonomously while blocking dangerous operations.

### Requirements

- **Plan**: Team plan (Enterprise and API rolling out)
- **Model**: Claude Sonnet 4.6 or Opus 4.6
- **Classifier**: Runs on Claude Sonnet 4.6 (adds extra token cost)

### Enabling Auto Mode

```bash
# Unlock auto mode with CLI flag
claude --enable-auto-mode

# Then cycle to it with Shift+Tab in the REPL
```

Or set it as the default permission mode:

```bash
claude --permission-mode auto
```

Setting via config:
```json
{
  "permissions": {
    "defaultMode": "auto"
  }
}
```

### How the Classifier Works

The background classifier evaluates each action using the following decision order:

1. **Allow/deny rules** -- Explicit permission rules are checked first
2. **Read-only/edits auto-approved** -- File reads and edits pass automatically
3. **Classifier** -- The background classifier reviews the action
4. **Fallback** -- Falls back to prompting after 3 consecutive or 20 total blocks

### Default Blocked Actions

Auto mode blocks the following by default:

| Blocked Action | Example |
|----------------|---------|
| Pipe-to-shell installs | `curl \| bash` |
| Sending sensitive data externally | API keys, credentials over network |
| Production deploys | Deploy commands targeting production |
| Mass deletion | `rm -rf` on large directories |
| IAM changes | Permission and role modifications |
| Force push to main | `git push --force origin main` |

### Default Allowed Actions

| Allowed Action | Example |
|----------------|---------|
| Local file operations | Read, write, edit project files |
| Declared dependency installs | `npm install`, `pip install` from manifest |
| Read-only HTTP | `curl` for fetching documentation |
| Pushing to current branch | `git push origin feature-branch` |

### Configuring Auto Mode

**Print default rules as JSON**:
```bash
claude auto-mode defaults
```

**Configure trusted infrastructure** via the `autoMode.environment` managed setting for enterprise deployments. This allows administrators to define trusted CI/CD environments, deployment targets, and infrastructure patterns.

### Fallback Behavior

When the classifier is uncertain, auto mode falls back to prompting the user:
- After **3 consecutive** classifier blocks
- After **20 total** classifier blocks in a session

This ensures the user always retains control when the classifier cannot confidently approve an action.
