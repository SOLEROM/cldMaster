## Cloud Scheduled Tasks

Use `/schedule` to create Cloud scheduled tasks that run on Anthropic infrastructure:

```
/schedule daily at 9am run the test suite and report failures
```

Cloud scheduled tasks persist across restarts and do not require Claude Code to be running locally.

### Disabling scheduled tasks

```bash
export CLAUDE_CODE_DISABLE_CRON=1
```

### Example: monitoring a deployment

```
/loop 5m check the deployment status of the staging environment.
        If the deploy succeeded, notify me and stop looping.
        If it failed, show the error logs.
```

> **Tip**: Scheduled tasks are session-scoped. For persistent automation that survives restarts, use CI/CD pipelines, GitHub Actions, or Desktop App scheduled tasks instead.
