---
name: architecture-review
description: Deep architectural analysis of a system or module. Use when evaluating a design proposal, reviewing system architecture, or planning a major refactor.
context: fork
agent: Plan
argument-hint: [system-or-component]
---

# Architecture Review

Perform a deep architectural analysis. Apply extended thinking to explore trade-offs thoroughly.

System or component to review: `$ARGUMENTS`

Use ultrathink mode to explore competing approaches and trade-offs before reaching conclusions.

---

## Review Framework

### Phase 1: Understand Requirements

Before evaluating architecture, clarify:

**Functional requirements:**
- What does this system do for users?
- What are the key user journeys?
- What data flows in, what flows out?

**Non-functional requirements:**
- Scale: requests/second, data volume, user count
- Latency: P50/P95/P99 requirements
- Availability: 99.9% (8.7h/year downtime) vs 99.99% (52min/year)?
- Consistency: strong, eventual, or causal?
- Security: data classification, compliance requirements
- Maintainability: team size, deployment frequency

### Phase 2: Map the Current Architecture

Identify:
- **Components:** what are the major pieces?
- **Boundaries:** where do they communicate?
- **Data flows:** how does data move between components?
- **Dependencies:** what external systems does this depend on?
- **State:** where is state held, and who can modify it?

Draw (in text) a component diagram:
```
[Client] → [API Gateway] → [Auth Service]
                        → [User Service] → [PostgreSQL]
                        → [Order Service] → [PostgreSQL]
                                         → [Redis (cache)]
                        → [Notification Service] → [SQS]
```

### Phase 3: Evaluate Against Quality Attributes

**Scalability**
- Where are the bottlenecks as load increases?
- Which components can scale horizontally? Which can't?
- What happens at 10x current load?

**Maintainability**
- Can a new developer understand each component in isolation?
- How many components need to change when a requirement changes?
- Is there a "God component" that everything depends on?

**Testability**
- Can each component be tested in isolation?
- How hard is it to write integration tests?
- Can you reproduce production scenarios in a test environment?

**Security**
- What is the attack surface?
- How does the system handle compromised credentials?
- Is sensitive data encrypted at rest and in transit?

**Operability**
- Is each component independently deployable?
- Are there sufficient metrics, logs, and traces?
- What happens when a dependency is slow or unavailable?
- How does the system recover from failure?

### Phase 4: Identify Anti-Patterns

| Anti-pattern | Signs | Risk |
|---|---|---|
| Big Ball of Mud | No clear boundaries, "everything depends on everything" | Unmaintainable, impossible to test |
| Distributed Monolith | Microservices that must deploy together | Worst of both worlds |
| God Object | One service that handles all business logic | Bottleneck, single point of failure |
| Chatty Interface | 10 API calls to render one screen | Latency, coupling |
| Shared Database | Multiple services reading/writing same tables | Can't evolve independently |
| Hardcoded Service Discovery | IP addresses or hostnames in code | Breaks on any infrastructure change |
| Synchronous chain | A→B→C→D all synchronous | Cumulative latency, cascade failures |

### Phase 5: Propose Alternatives with Trade-offs

For each identified problem, propose at minimum two alternatives:

```
Problem: Auth service is a synchronous bottleneck — all requests wait for it.

Alternative A: Async token validation via shared secret (JWT)
  Pro: No auth service call per request; scales with API load
  Con: Tokens can't be revoked until expiry; must trust the signing key everywhere
  Risk: If signing key is leaked, all tokens are compromised until key rotation

Alternative B: Cache auth results with short TTL (30s Redis cache)
  Pro: 99% of requests avoid auth service call; revoking still works within 30s
  Con: 30s delay on revocation; adds Redis dependency to auth path
  Risk: Cache invalidation bugs could allow access after revocation
```

---

## Output Format: Architecture Decision Record (ADR)

```markdown
# ADR: [Title]

## Status
Proposed / Accepted / Deprecated / Superseded by ADR-XXX

## Context
[What is the issue or situation that motivates this decision?]

## Decision Drivers
- [Quality attribute 1: scalability]
- [Quality attribute 2: team cognitive load]
- [Constraint: must deploy to existing infrastructure]

## Considered Options
1. [Option A]
2. [Option B]
3. Keep current approach

## Decision
[Option A], because [reason].

## Consequences
### Good
- [Positive outcomes]

### Bad
- [Negative outcomes / trade-offs accepted]

### Risks
- [What could go wrong and how to mitigate]
```

---

## Red Flags That Need Immediate Attention

- Synchronous chains of 3+ services for a single user request
- No circuit breakers on external service calls
- Shared mutable state between services
- No observability (metrics, logs, traces) in any layer
- All business logic in a single service with no separation
- Database as the integration point between services
