# Red Team / Blue Team Pattern

Two adversarial agents with opposite goals — one attacks/finds flaws, one defends/justifies. An arbiter evaluates both and produces a hardened conclusion.

```mermaid
flowchart TD
    P["Plan / Proposal"] --> RT["Red Team\nAttacker"]
    P --> BT["Blue Team\nDefender"]
    RT -->|"vulnerabilities\n& weaknesses"| ARB["Arbiter\nOpus"]
    BT -->|"justifications\n& mitigations"| ARB
    ARB --> O["Hardened Plan\n& Risk Assessment"]
```

## When to Use
- Security review of architectures or code
- Stress-testing business plans or strategies
- Identifying edge cases before shipping
- When you want to find problems before users do
