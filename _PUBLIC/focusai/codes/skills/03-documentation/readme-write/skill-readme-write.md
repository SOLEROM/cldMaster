---
name: readme-write
description: Write a professional README for a project or package. Use when starting a new project, publishing an npm package, or when the README is outdated.
disable-model-invocation: true
argument-hint: [project-name-or-description]
---

# README Write

Write a README that lets an unfamiliar developer reach a working state in under 10 minutes.

## Gather Context First

Project description or name: `$ARGUMENTS`

## Required Structure

Every README needs these sections in this order:

### 1. Title + One-Line Description

```markdown
# project-name

Lightweight job queue for Node.js backed by Redis, optimized for high-throughput background processing.
```

One sentence. What it does and for whom. Not marketing copy.

### 2. Quick Start (≤ 5 commands)

The fastest path to working output. Every command must actually work.

```markdown
## Quick Start

\`\`\`bash
npm install your-package
\`\`\`

\`\`\`js
import { createQueue } from 'your-package';

const queue = createQueue('redis://localhost:6379');
await queue.add('send-email', { to: 'user@example.com' });
\`\`\`
```

### 3. Why This Exists

2-5 sentences: what problem does this solve, and why is this the right tool?

### 4. Installation (if non-trivial)

Include only when there's more to it than `npm install`. Platform requirements, build steps, environment setup.

### 5. Configuration Reference

A table for every option:

```markdown
| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `concurrency` | `number` | `1` | Max simultaneous jobs |
| `retries` | `number` | `3` | Max retry attempts |
```

### 6. Usage Examples

3 real scenarios. Not trivial toy examples — show actual use cases people will have.

### 7. API Reference (for libraries)

One section per major export. Link to generated typedocs if available.

### 8. Contributing (for open source)

```markdown
## Contributing

\`\`\`bash
git clone <repo>
npm install
npm test
\`\`\`

PRs welcome. Open an issue first for significant changes.
```

### 9. License

`MIT License — see LICENSE file.`

---

## Quality Bar

A developer who has never seen this project should be able to:
1. Understand what it does in 30 seconds
2. Decide if it's right for them in 2 minutes
3. Have it running in under 10 minutes

Read the finished README as that developer. Where do you reach for the source code to answer a question the README should have answered? Fix those gaps.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Installation before "why" | Move motivation above installation |
| Code examples that don't run | Test every example |
| `Coming soon` sections | Delete — add only what's implemented |
| Internal jargon | Write for someone new to the domain |
| No error handling examples | Add a section on common errors |
| Hardcoded version numbers | Use package.json badge or `@latest` |
