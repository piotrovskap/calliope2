---
title: "Data-quality assessment (identity)"
type: story
status: planned
priority: high
estimate: XL
depends_on: [phase-1-build.backend-data-model.data-model-foundation]
labels: [data-quality, identity, observability, 1a]
date: ~
---

DQ tooling around identity resolution: match coverage, conflict and duplicate rates, orphan-identifier volume (e.g. unresolved Facebook IDs), and source-trust/survivorship signals. Great Expectations runs on the ingest path to validate incoming data; metrics surface to the Data Health view.

**Acceptance:** identity DQ metrics (match coverage, conflict/duplicate rates, orphan-identifier volume, source-trust/survivorship signals) are computed and surfaced to the Data Health view; Great Expectations runs on the ingest path and a failed expectation raises an alert and is visible in that view.

**References:**
- Decided 2026-06-18: no dbt — transform is imperative Python on the ingest path; DQ via Great Expectations/SQL, health aggregations in Redshift — `memory/decisions.md#d-075`
- Identity strategy locked 2026-06-17 (Luis + Alicia): survivorship + source-trust ladder (DMS ground truth → CRM → Email/Twilio → enrichment) and orphan identifiers (`link_type='orphan'`) stored, never discarded — `memory/decisions.md#d-107`
- `wiki/Identity-Resolution.md` — survivorship/source-trust ranking and orphan-identifier handling that the DQ signals measure
- `wiki/Frontend.md` — the Data Health surface these metrics feed
