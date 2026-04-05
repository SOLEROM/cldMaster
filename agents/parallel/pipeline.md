# Pipeline Pattern

A sequential chain where each agent's output becomes the next agent's input. Each stage has a single responsibility and transforms the work forward.

```mermaid
flowchart LR
    I["Input"] --> A1["Agent 1\nDraft"]
    A1 --> A2["Agent 2\nReview"]
    A2 --> A3["Agent 3\nPolish"]
    A3 --> A4["Agent 4\nFormat"]
    A4 --> O["Final Output"]
```

## When to Use
- Multi-stage content creation (draft → review → edit → publish)
- Data transformation with distinct processing steps
- Tasks where each stage requires different expertise
- When order matters and each step depends on the previous
