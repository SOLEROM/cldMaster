---
name: microservices
description: Microservices architecture patterns and trade-offs. Auto-load when designing distributed systems, breaking up monoliths, or evaluating service boundaries.
---

# Microservices Reference

Understanding when microservices help and when they hurt — and how to do them right.

## First: When NOT to Use Microservices

> "Don't start with microservices. Monoliths are underrated." — most senior engineers who've built both

Start with a monolith when:
- Team is < 5 engineers
- Domain is not yet understood (premature service boundaries are painful to fix)
- Deployment/ops maturity is low (microservices require sophisticated CI/CD)
- Data consistency requirements are high (distributed transactions are hard)

Move to microservices when:
- A specific part of the system needs to scale independently
- Different parts have genuinely different deployment needs
- Teams are large enough that coordination on a monolith is slowing everyone down
- You've already built the monolith and identified the right boundaries

## Service Boundary Identification (Domain-Driven Design)

Services should map to **bounded contexts** — areas of the business with their own language and rules.

```
Good boundaries (aligned with business domains):
- UserService: authentication, profiles, preferences
- OrderService: cart, checkout, order lifecycle
- InventoryService: stock, warehouse, fulfillment
- PaymentService: payment processing, refunds, billing

Bad boundaries (technical layers):
- DatabaseService: all DB operations ← shared mutable state = monolith but worse
- APIService: all API calls ← no cohesion
- ValidationService: all validation ← too fine-grained
```

Test for a good boundary: Can this service make its core decisions without synchronously calling another service?

## Inter-Service Communication

### Synchronous (REST / gRPC)

```
ServiceA --HTTP POST--> ServiceB
```

**Use when:** The caller needs the result before it can proceed (real-time, transactional).
**Risks:**
- Cascade failures: B down = A fails
- Latency multiplication: A→B→C→D = sum of all latencies
- Temporal coupling: services must be up simultaneously

**Mitigation:** Circuit breakers (stop calling a failing service), timeouts, retries with exponential backoff.

### Asynchronous (Events / Message Queue)

```
ServiceA --event--> [Queue] --consume--> ServiceB
```

**Use when:** The caller doesn't need the result immediately; operations can be eventual.
**Benefits:**
- A continues if B is down (queue buffers)
- B can process at its own rate (backpressure handling)
- Easy to add new consumers (C, D) without changing A

**Risks:**
- Eventual consistency (B may not have processed the event yet)
- Event ordering not guaranteed (unless you enforce it)
- Debug complexity (trace a request through multiple services + queues)

**Rule of thumb:** Use events for anything where "eventual" is acceptable. Use sync for anything that requires "right now."

## Data Management

### Each Service Owns Its Data (Critical Rule)

```
✅ OrderService has orders database
   PaymentService has payments database
   Each accessed ONLY by its owner service

❌ OrderService and PaymentService both have access to the same `orders` table
   → You have a distributed monolith: worst of both worlds
```

**How to share data:**
- API calls (sync): OrderService exposes `GET /orders/:id` → PaymentService calls it
- Events (async): OrderService publishes `order.created` event → PaymentService subscribes
- Data replication: PaymentService maintains its own eventual-consistent copy of order data it needs

### Saga Pattern (Distributed Transactions)

When a business operation spans multiple services:

```
Create Order saga:
1. OrderService creates order (pending)
2. InventoryService reserves items
3. PaymentService charges customer
4. OrderService confirms order (confirmed)

If step 3 fails:
- PaymentService saga: emit payment.failed
- InventoryService: cancel reservation
- OrderService: cancel order
```

Two implementations:
- **Choreography:** Each service listens for events and reacts (decentralized, harder to debug)
- **Orchestration:** A saga orchestrator calls each service in order (centralized, easier to trace)

## Distributed Systems Problems

### Network Is Not Reliable

Every service call can fail, timeout, or return unexpected results. Always:
- Set timeouts on all service calls
- Implement circuit breakers (Hystrix, Resilience4j, custom)
- Handle partial failures (some services responded, some didn't)

### Distributed Tracing

Single service: one log file, easy to trace.
10 services: trace ID must flow through every call.

```
Every service must:
1. Accept X-Request-ID header (or generate if missing)
2. Pass it to all outgoing calls
3. Include it in all log lines
4. Report it in all error responses
```

Use: OpenTelemetry → Jaeger/Zipkin/Datadog for visualization.

### Health Checks

Each service must expose:
```
GET /health        → 200 if service is up
GET /health/ready  → 200 if service is ready to accept traffic (DB connected, etc.)
```

## Strangler Fig Pattern (Monolith → Microservices)

```
Step 1: Run both systems simultaneously
  [Client] → [Proxy/Router]
                ├── /users → New UserService
                └── /* → Old Monolith

Step 2: Move one domain at a time
  [Client] → [Proxy/Router]
                ├── /users → New UserService
                ├── /orders → New OrderService
                └── /* → Old Monolith (shrinking)

Step 3: Retire the monolith
  [Client] → [API Gateway]
                ├── /users → UserService
                ├── /orders → OrderService
                └── /payments → PaymentService
```

Move one bounded context at a time. Never try to rewrite everything at once.

## Observability Requirements (Non-Negotiable)

Before shipping a microservice to production, it must have:
- **Metrics:** request rate, error rate, latency (P50/P95/P99)
- **Structured logs:** JSON format, includes service name, request ID, trace ID
- **Distributed traces:** spans for every outgoing call
- **Health checks:** `/health` and `/health/ready`
- **Alerts:** on error rate spike, latency spike, dependency failure
