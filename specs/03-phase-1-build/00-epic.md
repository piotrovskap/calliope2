---
title: "Phase 1 — Build (Product P1: MVP + Full Backend)"
type: epic
status: planned
priority: high
labels: [phase-1, build, product-p1]
date: ~
---

The first build phase — product-build **P1** (MVP + full backend → productionized V1), distinct from the `specs/` engagement phases (this is the build that follows Phase 0 discovery and the Phase 1 architecture/design package). Naming follows the team's product-phase convention; see `memory/decisions.md` (2026-06-13 stack + product-phasing note).

Scope is organized as a **foundation layer** plus **four parallel tracks**, with a dedicated identity-curation/data-quality capability, design-input spaces owned by Alicia + Luis, and a long-tail path that runs until every source is ingested and the legacy stack is retired.

- **Foundation** — repos (boilerworks / boilerworks-opscode), AWS org + IAM Identity Center + accounts (prod/dev/staging), tiered permissions, CI/CD, modeled push-button prod deploy, base org auth + local dev, data-store provisioning, observability (OTel / Prometheus / OpenSearch), DR + backups.
- **Track 1 — Frontend** — Next.js app shell, Auth0 auth, frontend RBAC, web-UI admin with CRUD (not Django admin), access/user management, the read surfaces, role-based app exposure.
- **Track 2 — Backend / Data Model** — canonical schema, permissions, org/tenancy data, GraphQL + REST surfaces.
- **Track 3 — Ingest (batch + event)** — Airflow split, DAG framework/base/conventions, stepped flows, DAG documentation design, source registry, initial feeds; co-primary event intake (Event Grid webhook -> NATS / CloudEvents) sharing the normalize -> resolve pipeline. Continues into the long tail.
- **Track 4 — Integration, ETL & Reporting** — Superset self-hosted, the Django meta layer that manages Superset via its API (Django -> API-generated, version-specific), dashboards-as-code, per-tenant guest-token + RLS harness, warehouse reporting cutover.
- **Identity Resolution Engine** — executes the resolution paths (automated / heuristic / moderated), with provenance + justification on every association and threshold-based positive grouping. Runs the strategy the design (below) defines; it does not define it.
- **Identity Curation & Data Quality** — human-in-the-loop curation queue, curation/eval UI, resolution-quality and data-quality tooling.
- **Segmentation Engine** — define, evaluate, and retrieve audiences across the resolved graph (patterns, contact, purchase, media usage, demographics); outbound activation deferred to P2.
- **Design gate (Alicia + Luis)** — the data-model schema, identity-resolution strategy, and privacy/tenancy model are designed in the architecture phase (`specs/02-phase-1-architecture/01-data-model/`), owned by Alicia + Luis, due 2026-06-19. The build does NOT duplicate that design; the relevant tracks `depends_on` it. Foundation and platform/data provisioning run in parallel ahead of the gate; Track 2 (data model), Track 3's resolve step, the resolution engine, curation, and segmentation gate on the design lock.
- **Long Tail** — full source onboarding, SSIS reimplementation, report migration, legacy deprecation; the team carrying this is Oscar, Byron, Hiram, Julio.

## Sizing & sequencing

Stories carry **T-shirt sizes** scoring **relative effort + complexity** (not time — see `specs/README.md` for the scale) and testable acceptance. Counts, size distribution, and effort bounds are **computed live** from the spec data — run `scripts/spec-stats.py` or open `/specs/stats.html`. They are not written here: stored counts go stale.

- **EPIC items need a spike + breakdown before scheduling** (multi-person, beyond a single story): full source onboarding, SSIS reimplementation, report migration. Each carries a break-down note in its body.
- **Design gate:** foundation, platform, ingest-framework, and Superset-deploy work has no design dependency and starts immediately; the data-model → tenancy → API → identity → curation → segmentation chain gates on the Alicia + Luis design lock (2026-06-19).
- **Long pole:** the ingest framework chain (airflow split → DAG framework → base/conventions → stepped flows → event-grid webhook → NATS backbone) is the deepest dependency chain; the critical path runs through it.

**Execution order:** start foundation + platform + ingest framework immediately (pre-gate, the long pole); the design-gated chain unlocks at the 06-19 design lock; long-tail EPICs run after the framework lands and must be decomposed before scheduling.
