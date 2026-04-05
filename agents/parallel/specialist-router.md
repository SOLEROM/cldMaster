# Specialist Router Pattern

A router agent classifies incoming input and dispatches it to the most appropriate specialist agent. Each specialist handles only its domain.

```mermaid
flowchart TD
    I["Input"] --> R["Router\nClassifier"]
    R -->|"code question"| S1["Specialist\nCode"]
    R -->|"legal question"| S2["Specialist\nLegal"]
    R -->|"data question"| S3["Specialist\nData"]
    R -->|"design question"| S4["Specialist\nDesign"]
    S1 --> O["Response"]
    S2 --> O
    S3 --> O
    S4 --> O
```

## When to Use
- Mixed-domain query systems (chatbots, assistants)
- When different input types need very different handling
- To keep specialist agents small and focused
- When routing logic is simpler than a general agent handling all cases
