---
title: "Self-serve data export"
type: story
status: planned
priority: medium
estimate: M
depends_on: [phase-1-build.backend-data-model.graphql-surface, phase-1-build.backend-data-model.tool-access-api]
labels: [phase-2, data-exposure, export, portability, net-new, 2a]
date: ~
---

Let dealers export and download their own tenant data from the CDP — both a portability/ownership story and a practical bulk-pull, tenant- and RLS-scoped. The export half of data exposure: a dealer can take its golden-record data out without a custom extract job.

**Scope:** a dealer-initiated export of its own tenant data — select scope (entities/fields/date range), generate a download in a standard format (e.g. CSV/JSON), delivered through the governed surfaces (golden-record GraphQL read + the Phase-1 tool-access API for programmatic/bulk pulls); scoped so a dealer exports only its own tenant data, RLS-enforced; consent/erasure state respected so suppressed/erased data is not re-exposed. Data-out only — no reverse-ETL/writeback to legacy systems.

**Acceptance:** a dealer requests an export of its own data, scoped by entity/field/date range, and downloads it in a standard format containing only that dealer's tenant data with consent/erasure honored — no cross-tenant data reachable and no bespoke extract job.

**References:**
- Decided 2026-06-18 (Alicia + Luis): GraphQL is the consumer-360 surface, REST for ingestion/ops — the governed golden-record read path the export draws from — `memory/decisions.md#d-002`
- Decided 2026-06-21 (Leo): PostgreSQL RLS is the confirmed multi-tenant isolation mechanism (tenant context via `app.current_tenant`) — the per-dealer scoping that keeps an export to its own tenant — `memory/decisions.md#d-004`
- Decided 2026-06-19 (Alicia, Privacy-by-Design): consent is first-class and read at access time; suppression scope is hybrid (regulatory global, dealer opt-outs tenant-scoped) — what gates what an export may include — `memory/decisions.md#d-112`
- Decided 2026-06-21 (Leo): PII erasure via tokenized vault + delete-the-row — erased values dereference to nothing, so a suppressed/erased value is not re-exposed in an export — `memory/decisions.md#d-012`
- `wiki/Privacy-by-Design.md` — tenant isolation model, consent enforcement, erasure mechanism
- `wiki/Multi-Tenancy.md` — per-dealer tenant scoping and consumer portability
