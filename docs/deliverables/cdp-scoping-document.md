---
title: CDP Scoping Document
type: deliverable
status: complete
phase: 0
owners: Leo Mata
review: Alicia Salazar, Luis Hernandez
---

# CDP Scoping Document

*Phase 0 deliverable: the core scoping report. It maps where DAS's customer data lives today, defines the unified record the CDP builds from it, explains how ~85 sources onboard, assesses current-state infrastructure against the target, and registers the material risks with a posture for each. Written for decision-makers; the canonical technical detail lives in the architecture, topology, and spec documents linked throughout, and every claim below traces to a dated decision or a discovery artifact. This document converts directly into a prioritized build backlog (see "From scope to backlog").*

## The problem we are solving

DAS knows an enormous amount about every dealer's customers, but that knowledge is scattered across dozens of databases, vendor feeds, and apps that do not talk to each other, joined by a legacy ETL stack that is fragile and near capacity. There is no single, trustworthy customer record, no system of record the apps can build on, and no clean way to answer "what does DAS actually know about this person?"

The CDP is the answer: one platform that ingests from the **original sources**, resolves fragmented records into a [**golden record**](/analysis/artifacts/golden-record/) per person, becomes the system of record, and lets the legacy stack retire. This document scopes that platform: what it reads from, what it produces, how it is built, what it runs on, and what could go wrong.

## 1. The source landscape — where the data lives

DAS's customer data sits in three tiers, all discovered in Phase 0 (SSIS review with Rick Sorich, 2026-06-08; database discovery, 2026-06-14). Full per-source detail is in `docs/source-onboarding-ledger.md`, the field-level mapping is in `docs/cdp-field-source-matrix.md`, and the legacy ETL it flows through is cataloged in `docs/etl-data-inventory.md` (231 SQL objects across 20 modules).

**DAS internal databases.** SQL Server on EC2: `ETL01` (the EDW staging/target and SSIS catalog), the legacy `3BHS001` (Auth, Automobiles, ClientDB, Lift), and `SQL01` (ActivityLog, DmsWarehouse, Inventory, Tracking); plus RDS MySQL (Analytics, the 3Birds/Mautic marketing DB). The richest identity data lives here, e.g. Response Logix `oltp` (240 tables, 1.13B rows) with `franchise_consumer` (51M rows) as a consumer master and `franchise_consumer_alias` (34M rows) as an email/phone alias graph. **The data gravity is on AWS:** these source systems already run there, which matters for the infrastructure choice (§4).

**Vendor APIs and feeds.** The bulk of the integration surface: CRM feeds (VinSolutions, eLeads, Reynolds & Reynolds, Tekion, DealerSocket, and others; 21+ CRM providers in the legacy ETL alone), DMS aggregators (Authenticom/DealerVault, CDK Global, DealerTrack), lead feeds (TrueCar, AutoTrader, Cars.com, CarGurus), reviews (Google Business Profile, DealerRater, Yelp), email/SMS (MailGun, Twilio, SendGrid), enrichment (BlackBook for equity, KBB, Recall Masters, Carfax, Experian, credit bureaus under GLBA), OEM feeds, and DAS's own app events.

**Scale.** The onboarding ledger enumerates **~85 distinct integrations** (16 existing internal DBs + 69 new vendor/app sources), each becoming an individually-tracked build story. The deliberate scope stance (Dan Aston, 2026-06-17) is that **every source and channel is in scope** for extracting identity value: the CDP documents and onboards all of them, rather than narrowing to a chosen few.

One grounding note: this is **discovery-level** mapping. The golden record carries verified column-level source mappings for 27 of its 34 modeled fields; the field matrix's machine-resolution against dumped DDL is still 0/27 because the paths are abbreviated or point at not-yet-dumped DBs. Binding every field to a concrete `db.schema.table.column` is a **Phase 1 build-time gate**, not a Phase 0 blocker.

## 2. The unified Dealer-Customer data model

The CDP's output is a single record per person, the golden record, assembled from those scattered sources with the evidence for every value preserved. You can see the modeled record, field by field with its sources, at the interactive page: [**/analysis/artifacts/golden-record/**](/analysis/artifacts/golden-record/). The canonical model is in `docs/cdp-architecture.md`.

In plain terms, the model holds:

- One **consumer entity** per resolved person, with identity fragments (emails, phones, VINs, dealer customer IDs) linked to it through an identity graph. Records that cannot link yet (Dan's "Facebook ID with nothing to join to") are kept as orphans, not discarded, and resolve later when a connecting record arrives.
- **Households** as their own entity (a consumer belongs to zero or one), because family identity is the hardest case and must be detected and human-confirmed, not assumed.
- Vehicles, deals, services, engagement, and consent attached to the consumer, with the source and timestamp of every value recorded.
- **Full history.** The store is append-only and bitemporal: it records both when something was true and when the CDP learned it, so the "as-of" time-travel view *is* the record's evolution over time (Mike Paylor's #1 requested artifact). No value is ever destroyed; when sources disagree, a source-trust ladder (DMS as ground truth) picks the surviving value and the rest stays in history.

The Phase 1 deployment unit is **15 tables** (11 core + 4 AI/ML stubs that ship empty-but-complete, so adding machine learning later needs zero schema migration), locked 2026-06-18 (Alicia + Luis). The broader logical model spans 23 entities. How a record actually gets resolved, and the survivorship and household rules, are the subject of the companion `docs/deliverables/identity-resolution-strategy.md`.

## 3. Integration analysis — how sources onboard

The legacy approach is the thing we are replacing: **SSIS**, 13 truncate-and-rebuild jobs running daily, fragile and near capacity. DAS confirmed they will be dropped (Dan Aston, 2026-06-12: "not a reliable end source for the CDP"). The CDP does **not** port them 1:1; it reimplements the ingest and transform logic against original sources (the decomposition, not the legacy 13, sets the job count), and it ingests from **raw originals, never from the EDW/DWRPT reporting views**, which contain manipulated and summarized data and are kept only as a reporting-parity reference.

The mechanism is a **config-driven source registry** over **five reusable ingest primitives**, one per channel: database (CDC), API, SFTP/file-drop, webhook/event, and CSV/flat-feed. A new source is onboarded by declaring its mapping and provenance tag against the matching primitive, not by writing a bespoke pipeline. This is what makes ~85 integrations affordable: the heavy lifting is in Airflow's connector ecosystem plus templated DAG patterns, so each new source increasingly assembles from existing building blocks and the marginal cost per source keeps falling (Dan Aston, 2026-06-17). All four channels feed **one universal pipeline** (land raw -> normalize -> validate -> resolve identity -> store), so a source can graduate from batch to events without a redesign. Architecture detail: `docs/cdp-architecture.md` (§Layer 1); ingest specs: `specs/03-phase-1-build/04-ingest/`.

## 4. Infrastructure assessment — current state to target

**Current state is the case for the project.** SSIS is fragile and near capacity; the EDW/DWRPT reporting layer bakes legacy merge and data-quality decisions into pre-joined views; Juicebox (221 reports) is institutional knowledge to migrate, not a foundation to build on; and there is no system of record the apps can depend on. None of this is a base to extend. It is the thing being retired.

**Target state** is a portable open-source core (Postgres as the canonical store, with row-level security for multi-tenant isolation; NATS JetStream for event intake; Temporal for workflow; OpenSearch for search; Airflow for ingest; Auth0; and OpenTelemetry) running on Kubernetes. The core runs **unchanged on either cloud**; only the managed substrate around it (object storage, secrets, the optional warehouse) is cloud-specific, and each piece sits behind an interface, so there is no vendor lock-in in the application code. Sizing and placement for a dev baseline and a production steady-state (≈10M consumers / ≈1,700 dealer tenants) are fixed in `docs/cdp-reference-topology.md`; the posture (2026-06-16) is **dev baseline first, production rightsized on observed load**, so scaling is a config change, not a redesign.

**Cloud is a client choice.** DAS prefers consolidating on its org-primary cloud, **Azure** (Dan Aston, 2026-06-17), and that is our preferred target unless cost or a technical concern says otherwise. We did not flip the earlier AWS recommendation by fiat; we built a side-by-side bake-off so DAS decides on evidence. The verified finding (`docs/cloud-aws-vs-azure-bakeoff.md`, costs re-verified 2026-06-22): with a Postgres-native warehouse the two clouds are **within ~3% (cost-neutral)**, the previously-cited AWS-at-scale advantage was based on a phantom surcharge and does not hold, and every Azure "gap" (no managed Airflow or OpenSearch peer) closes by self-hosting the OSS component, exactly the avoid-proprietary-SaaS direction we would build anyway. **Cost is not a blocker to DAS's Azure preference.** Where cloud choice does move money: a managed warehouse and managed monitoring both favor Azure; cross-cloud ingestion egress favors AWS (see §5).

## 5. Risk register

The material risks, each traced to a decision or open question (`memory/decisions.md`, `memory/open-questions.md`), with the posture we hold.

| Risk | Why it matters | Posture / mitigation |
|---|---|---|
| **Cross-cloud data gravity / egress** | DAS source DBs are on AWS; the preferred CDP target is Azure, so ingestion crosses a cloud boundary, incurring egress (~$90/mo steady-state + a one-time backfill). | Treated as a first-class line item in the bake-off, not a footnote. Cross-cloud ingestion volume is one of the two highest-leverage cost unknowns; quantified at build time. AWS remains the lower-egress alternative if the number proves material. Cost is not a blocker either way. |
| **Queue volume unknown until live** | The identity conflict-review queue's arrival rate can't be known before real traffic; under-sizing risks operator overload, over-sizing wastes headcount. | Decided 2026-06-17 (Alicia + Luis): size *after* measurement. Phase 1 ships configurable thresholds + manual SLAs; 2–4 weeks of live measurement sets thresholds and headcount. Hard limit: if volume exceeds capacity by >2×, Tier-1 thresholds relax with a rolling false-merge audit. Phase 2 ML absorbs 3–5× at the same headcount. |
| **Legacy `3BHS001` fragility** | The legacy SQL Server DB's internal dependencies are not fully mapped; careless reads or modifications could disrupt live DAS operations. | Modified cautiously: extract via read replica / low-impact windows. The CDP ingests raw and becomes the system of record, so it does not depend on `3BHS001` long-term; the dependency ends at migration. |
| **Common Client ID (CCID) all-zero / unreliable** | DAS's cross-source join key is recently implemented and has data-cleanliness issues (the audited column was found non-functional); anchoring identity on it would propagate its gaps into the CDP. | Decided 2026-06-12 / locked 2026-06-17: build CCID from first principles (deterministic Option A). The legacy CCID is at most **one weighted signal** in the matching waterfall plus a migration/backfill key, never the foundation. No production read path depends on it after cutover. |
| **GLBA-scoped deletion** | Right-to-erasure must work against an append-only, bitemporal store, must be scoped per channel (per Dan Aston) and per GLBA/legal-hold rules, and must not destroy provenance. | Decided 2026-06-21 (Leo): a centralized **tokenized PII vault**, where erasure means deleting the vault row; tokens elsewhere dereference to nothing, so there is no cross-store purge to propagate. Per-consumer crypto-shred was evaluated and rejected (too complex/brittle/expensive). Provenance is retained ("phone provided by DMS on 2026-01-01" survives the value's deletion). Scoped GLBA/legal-hold deletion is plain row selection on source + purpose. Policy values (retention, taxonomy) are owned by Alicia + Luis + DAS Legal; Legal approves at proposal stage, not a Phase 0 blocker. |

## From scope to backlog

This document is the scoping layer above an already-decomposed backlog. Section 1 maps directly to the per-source onboarding stories in `docs/source-onboarding-ledger.md`: five reusable primitives, one representative source per channel proving the platform end-to-end (sub-phase 1a), then the long-tail migration (1b). Once generated, those stories' authoritative sizing lives in `specs/manifest.json` + `specs/estimates.json`, surfaced live on the specs roadmap. The SSIS reimplementation and report migration similarly decompose into per-module and per-schema-family stories. Proceeding to build means generating and prioritizing that backlog, not re-scoping.

## Where to go deeper

- Unified data model and golden record, interactive: [/analysis/artifacts/golden-record/](/analysis/artifacts/golden-record/) · canonical model: `docs/cdp-architecture.md`
- How records get resolved (matching, survivorship, households, consent): `docs/deliverables/identity-resolution-strategy.md`
- Per-source onboarding and long-tail decomposition: `docs/source-onboarding-ledger.md`
- Field-to-source mapping: `docs/cdp-field-source-matrix.md` · legacy ETL catalog: `docs/etl-data-inventory.md`
- Infrastructure sizing and placement: `docs/cdp-reference-topology.md` · cloud cost comparison: `docs/cloud-aws-vs-azure-bakeoff.md`
- Privacy, consent, tenant isolation, and erasure: `docs/deliverables/privacy-by-design-framework.md`
- The decision log and open questions behind every claim above: `memory/decisions.md` · `memory/open-questions.md`
