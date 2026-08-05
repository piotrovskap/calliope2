---
title: "Application messaging queue (RabbitMQ)"
type: story
status: planned
priority: high
estimate: M
depends_on: [phase-1-build.foundation.boilerworks-opscode-iac, phase-1-build.foundation.accounts-prod-dev-staging]
labels: [foundation, messaging, rabbitmq, 1a]
date: ~
---

Provision RabbitMQ as the application **work queue**, per the 2026-06-17 messaging split: NATS JetStream is the event-intake backbone, RabbitMQ is the app-layer work/task queue (aligns with DAS's existing CloudAMQP usage). Self-hosted on the node group (cloud-neutral), HA, behind a queue interface so app code is broker-agnostic.

**Acceptance:** RabbitMQ stands up per environment from Terraform/Helm, HA on the node group with anti-affinity, reachable by app services through the queue interface; a published task is consumed exactly-once-effective (ack + dedup); metrics flow to the observability stack.

**References:**
- Decided 2026-06-17 (Dan Aston, client-confirmed): messaging split — NATS JetStream = event-stream intake, RabbitMQ = app messaging / work queue (replaces SQS / Service Bus; aligns with DAS's existing CloudAMQP/RabbitMQ) — `memory/decisions.md#d-091`
- `docs/cdp-reference-topology.md` — RabbitMQ ×2 on the node group with anti-affinity (placement, sizing, storage)
- `wiki/Tech-Stack.md` — RabbitMQ as the approved app messaging / work-queue layer
