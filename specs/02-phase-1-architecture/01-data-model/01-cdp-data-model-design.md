---
title: "Core entity model"
type: story
status: done
priority: high
estimate: XXL
labels: [data-model, schema, phase-0-architecture]
date: ~
artifacts:
  - "CDP Scoping (data model) | docs/deliverables/cdp-scoping-document.md"
---
**Closed 2026-06-18 (done):** 15-table data model locked (11 core + 4 AI/ML stubs) — Alicia + Luis. The remaining schema DDL is a Phase 1 build story.

Requirements draft (2026-06-12). Field Catalog v1 — the initial 27 MVP fields — is the first slice, not the schema; the catalog grows past MVP by design. The schema is the entity set below; catalog fields land as attributes on it.

## Entities

| Entity | Notes |
|--------|-------|
| Person | Persistent ID, never reused. No identity keys stored as columns — keys are contact-point edges. |
| Contact point | Email, phone. First-class, not person attributes. One contact point ↔ many people (shared family inboxes), one person ↔ many contact points over time. |
| Address | One address ↔ many people. |
| Vehicle | VIN-keyed. Generalizes to `inventory_item` (decision logged: non-automotive verticals). One vehicle ↔ many people over time. |
| Household | Derived, never ingested. Computed from shared address + vehicle + contact-point clusters. Recomputable; allowed to be wrong. |
| Dealership | Tenant. The privacy boundary. |
| Event | Time spine: service visit, sale, lead, ad click (GCLID), message. Most identity evidence arrives as an event. |
| Deal/transaction | Binds person + vehicle + dealer at a point in time. |
| Consent | Per person, per channel, per tenant. |
| Identity graph | Identity nodes, links, merge history. See identity-resolution story. |

## Edge requirements

- All person↔address, person↔vehicle, person↔contact-point edges carry **valid-from / valid-to**. VIN identifies the vehicle, not the current owner; untimestamped edges mismarket prior owners.
- All edges and attribute facts carry **provenance**: contributing tenant + source system + ingestion timestamp. Per-fact, not per-table. Required at ingestion time (decision logged).
- Attribute storage stays EAV + JSONB (14 of the v1 catalog's 27 already fit it); new fields land without migration.

## Provenance & bitemporality

Locked 2026-06-17; see `memory/decisions.md` and `artifacts/phase-0/deliverables/das-cdp-revised-architecture-plan.md`.

- **Bitemporal, append-only.** The observation/provenance layer carries both **valid-time** (`valid_from` / `valid_to` — when the fact was true in the world) and **system-time** (`recorded_at` / `superseded_at` — when the CDP learned/superseded it). Reference tables are out of scope; bitemporality applies to the observation layer only.
- **Non-overlap is enforced**, not conventional: temporal columns are modeled as `tstzrange` with a **GiST exclusion constraint** so a given (entity, attribute) cannot have overlapping valid-time intervals.
- **No updates, no deletes** of observations — corrections are new rows that supersede prior ones (`superseded_at` set on the old row).
- **"As-of" time-travel** over this layer **is** the Golden Record evolution view: querying the surviving value at any (valid-time, system-time) point reconstructs what the golden record was, and what the CDP believed, at that moment.
- Survivorship (see `02-identity-resolution-strategy.md` §Survivorship & Source Trust) selects the winning value per field; losing values are never destroyed — they remain queryable in this layer.

## Table set (Phase 1)

Locked 2026-06-18 (Alicia + Luis, A3) at **15 tables** — 11 core + 4 AI/ML stubs. The legacy "19-table" DAS v4 figure is retired; this is the authoritative set. Detail in `wiki/Data-Model.md`.

**Core (11):** `dealership`, `consumer`, `consumer_dealership`, `consumer_attribute`, `vehicle`, `consumer_vehicle`, `identity`, `identity_link`, `event`, `consent`, `merge_history`.

**AI/ML stubs (4)** — deployed empty in Stage 1, populated in Phase 2/3: `ml_model_run`, `ml_match_candidate`, `match_review_queue`, `embedding_cache`.

The set grows by adding catalog fields as EAV+JSONB attributes (no new tables) and by the `inventory_item` generalization; new verticals do not add tables.

## Acceptance

- Schema DDL covering the 15-table set, with bitemporal observation layer (valid-time + system-time, `tstzrange` + GiST exclusion) and per-fact provenance.
- Every Field Catalog v1 field (the initial 27) mapped onto it (matrix: `docs/cdp-field-source-matrix.md`).
- Demonstrated extension: one post-v1 candidate field and one non-automotive inventory type added with zero migrations.

**References:**
- Decided 2026-06-18 (Alicia + Luis, A3): Phase 1 table set locked at 15 (11 core + 4 AI/ML stubs); legacy 19-table DAS v4 figure retired — `memory/decisions.md#d-116`
- Decided 2026-06-17 (Luis + Alicia): bitemporal append-only observation/provenance layer (valid-time + system-time, `tstzrange` + GiST exclusion); as-of query is the Golden Record evolution view; EAV+JSONB for attributes — `memory/decisions.md#d-082`
- Decided 2026-06-12 (Dan Aston sync): "inventory" not "vehicle" (non-automotive generalization); data provenance classification required at ingestion time — `memory/decisions.md#d-019`
- `wiki/Data-Model.md` — authoritative 15-table set and bitemporal/provenance table shapes
- `docs/cdp-field-source-matrix.md` — Field Catalog v1 (27 fields) mapped onto the entity model
