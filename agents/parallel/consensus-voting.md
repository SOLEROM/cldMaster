# Consensus Voting Pattern

N independent agents each produce an answer without seeing each other's work. A aggregator picks the majority answer or flags disagreement for human review.

```mermaid
flowchart TD
    Q["Question"] --> A1["Agent 1\nAnswer"]
    Q --> A2["Agent 2\nAnswer"]
    Q --> A3["Agent 3\nAnswer"]
    Q --> A4["Agent 4\nAnswer"]
    Q --> A5["Agent 5\nAnswer"]
    A1 --> AGG["Aggregator\nMajority Vote"]
    A2 --> AGG
    A3 --> AGG
    A4 --> AGG
    A5 --> AGG
    AGG -->|"consensus"| O["Final Answer"]
    AGG -->|"no consensus"| H["Human Review"]
```

## When to Use
- High-stakes answers where confidence matters
- Reducing hallucination risk on factual questions
- Classification tasks needing reliability
- When a single agent's output is not trustworthy enough alone
