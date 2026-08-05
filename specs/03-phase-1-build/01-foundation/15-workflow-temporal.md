---
title: "Workflow engine (Temporal)"
type: story
status: planned
priority: high
estimate: M
depends_on: [phase-1-build.foundation.boilerworks-opscode-iac, phase-1-build.foundation.data-stores-provisioning]
labels: [foundation, workflow, temporal, 1a]
date: ~
---

Provision Temporal as the durable workflow engine for app-layer sagas — the erasure saga (delete vault row → confirm dereference → audit), identity merge/unmerge and curation sagas, and admin-utility orchestration. Self-hosted on the node group (cloud-neutral), backed by its own persistence; Airflow owns ingest, Temporal owns app/admin workflows (no overlap).

**Acceptance:** Temporal stands up per environment with persistence, reachable by app services; a sample durable workflow survives a worker restart and resumes idempotently; worker task queues are environment-scoped; metrics flow to the observability stack. This is the engine the erasure saga and resolver sagas run on.

**References:**
- Decided 2026-06-15 (Leo): Airflow owns all ingest, Temporal = application/API layer only (identity sagas, conflict-queue human-in-loop, admin orchestration), off the ingest path — `memory/decisions.md#d-073`
- Approved 2026-06-19 (Alicia, Privacy-by-Design): erasure runs as a single durable Temporal workflow saga (Option C2); orchestration approval stands after 2026-06-21 mechanism change to vault-row delete — `memory/decisions.md#d-011`
- Portability 2026-06-17 (Dan): Temporal is part of the portable OSS core, self-hosted on AKS/EKS unchanged across clouds — `memory/decisions.md`
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — Temporal as the self-hosted workflow engine (sagas, conflict queue, workers, admin utilities); Airflow/Temporal boundary
- `docs/cdp-reference-topology.md` — Temporal sizing/placement (×2 replicas, anti-affinity, persistence)
- `wiki/Privacy-by-Design.md` · `specs/03-phase-1-build/03-backend-data-model/08-pii-vault-erasure.md` — the erasure saga this engine runs
