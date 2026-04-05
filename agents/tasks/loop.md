## Scheduled Task - The `/loop` 

```bash
# Explicit interval
/loop 5m check if the deployment finished

# Natural language
/loop check build status every 30 minutes
```

Standard 5-field cron expressions are also supported for precise scheduling.

### One-time reminders

Set reminders that fire once at a specific time:

```
remind me at 3pm to push the release branch
in 45 minutes, run the integration tests
```

### Managing scheduled tasks

| Tool | Description |
|------|-------------|
| `CronCreate` | Create a new scheduled task |
| `CronList` | List all active scheduled tasks |
| `CronDelete` | Remove a scheduled task |

**Limits and behavior**:
- Up to **50 scheduled tasks** per session
- Session-scoped — cleared when the session ends
- Recurring tasks auto-expire after **3 days**
- Tasks only fire while Claude Code is running — no catch-up for missed fires

### Behavior details

| Aspect | Detail |
|--------|--------|
| **Recurring jitter** | Up to 10% of the interval (max 15 minutes) |
| **One-shot jitter** | Up to 90 seconds on :00/:30 boundaries |
| **Missed fires** | No catch-up — skipped if Claude Code was not running |
| **Persistence** | Not persisted across restarts |

