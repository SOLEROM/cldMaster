# Debate Pattern for Scholastic Consensus

A multi-agent pattern where N agents argue opposing or distinct positions on a topic, challenge each other's reasoning, and a judge agent evaluates the full debate to reach a well-reasoned consensus.

## How It Works

1. **Controller** defines the question and assigns each agent a distinct position/perspective
2. **Round 1 (Opening)** — each agent independently argues its position
3. **Round 2 (Rebuttal)** — each agent reads the others' arguments and challenges them
4. **Judge** reads the full transcript and delivers a reasoned verdict or synthesis

Agents are adversarial by design — this surfaces blind spots that a single agent would miss.

```mermaid
flowchart TD
    Q["Question / Topic"] --> C["Controller"]
    C --> A1["Agent 1\nPosition A"]
    C --> A2["Agent 2\nPosition B"]
    C --> A3["Agent 3\nPosition C"]

    A1 --> R1["Round 1\nOpening Arguments"]
    A2 --> R1
    A3 --> R1

    R1 --> A1R["Agent 1\nRebuttal"]
    R1 --> A2R["Agent 2\nRebuttal"]
    R1 --> A3R["Agent 3\nRebuttal"]

    A1R --> J["Judge / Opus\nScholastic Consensus"]
    A2R --> J
    A3R --> J

    J --> V["Final Verdict\n& Reasoning"]
```

## Model Split

| Role | Model | Why |
|---|---|---|
| Debaters | Sonnet | Fast argumentation, cost-effective per round |
| Judge | Opus | Needs to weigh complex, conflicting reasoning |

## Example Prompt

```
Use a debate pattern to evaluate: "Is X the right approach for Y?"
Spin 3 agents — one advocate, one critic, one devil's advocate.
Run 2 rounds (opening + rebuttal), then have Opus judge the debate
and deliver a scholastic consensus with supporting reasoning.
```

## When to Use

- Architecture or design decisions with real trade-offs
- Evaluating competing tools, frameworks, or strategies
- Any question where groupthink is a risk
- When you need a defensible, well-reasoned conclusion — not just an answer


## skill?

![](./image-3.png)