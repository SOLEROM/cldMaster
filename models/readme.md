# Claude Models

## Current Models (as of 2025)

| Model | ID | Speed | Cost | Best For |
|---|---|---|---|---|
| **Opus 4.6** | `claude-opus-4-6` | Slowest | Highest | Complex reasoning, research, long-horizon tasks |
| **Sonnet 4.6** | `claude-sonnet-4-6` | Balanced | Mid | General-purpose coding, analysis, most tasks |
| **Haiku 4.5** | `claude-haiku-4-5-20251001` | Fastest | Lowest | Simple tasks, high-volume, latency-sensitive |

## When to Use Each

### Opus — Use when quality matters most
- Multi-step agentic tasks requiring sustained reasoning
- Complex architecture decisions or code reviews
- Research synthesis across many sources
- Tasks where mistakes are costly

### Sonnet — Default choice
- Everyday coding tasks and bug fixes
- Feature implementation and refactoring
- Most Claude Code interactions (this is the default)
- Good balance of speed, cost, and capability

### Haiku — Use when speed/cost matters
- Simple lookups or transformations
- High-throughput pipelines (e.g. classifying many items)
- Latency-sensitive UX (streaming responses)
- Cheap background agents doing simple subtasks

## Rule of Thumb

> Start with **Sonnet**. Step up to **Opus** when the task requires deep reasoning or has high stakes. Step down to **Haiku** when you need volume or low latency.
