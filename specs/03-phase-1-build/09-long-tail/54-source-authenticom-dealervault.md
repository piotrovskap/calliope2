---
title: "Onboard Authenticom DealerVault"
type: story
status: planned
priority: medium
estimate: L
depends_on: [phase-1-build.long-tail.primitive-sftp]
labels: [long-tail, source, dms, sftp, ingest, 1a]
date: ~
---

Onboard the **Authenticom DealerVault** source through the sftp primitive: register it in the source registry, map its schema and identity keys to the canonical model, validate tenant attribution, and land it through ingest to processed. Config + mapping against the `primitive-sftp` scaffold — no bespoke connector code.

**Acceptance:** Authenticom DealerVault records land through ingest with correct tenant attribution, map to the canonical identity keys, and reconcile to source counts; the source is declared as a single registry entry (per-connection instances handled as registry config, not new stories).

**Subtasks:** primary DMS aggregator — **sftp channel representative (1a)**; aggregates many dealers.

**References:**
- Decided 2026-06-18 (Leo): the CDP ingests from **original sources, not EDW/DWRPT** — `memory/decisions.md`
- Config-driven source registry — one declarative entry per source, no bespoke connector code — `specs/03-phase-1-build/04-ingest/06-source-registry.md`
- `docs/cdp-field-source-matrix.md` — per-source identity keys + field mapping; `docs/source-onboarding-ledger.md` — the source decomposition plan
