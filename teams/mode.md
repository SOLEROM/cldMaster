# teammate-mode


Control how teammate activity is displayed:

| Mode | Flag | Description |
|------|------|-------------|
| **Auto** | `--teammate-mode auto` | Automatically chooses the best display mode for your terminal |
| **In-process** | `--teammate-mode in-process` | Shows teammate output inline in the current terminal (default) |
| **Split-panes** | `--teammate-mode tmux` | Opens each teammate in a separate tmux or iTerm2 pane |

```bash
claude --teammate-mode tmux
```

You can also set the display mode in `settings.json`:

```json
{
  "teammateMode": "tmux"
}
```


### Navigation

Use `Shift+Down` to navigate between teammates in split-pane mode.
