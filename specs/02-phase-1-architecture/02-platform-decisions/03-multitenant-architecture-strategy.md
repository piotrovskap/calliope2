---
title: "Multi-tenant architecture strategy"
type: story
status: done
priority: high
estimate: L
labels: [architecture, multi-tenancy, rls, privacy, phase-0-architecture]
date: ~
artifacts:
  - "Architecture (canonical) | docs/cdp-architecture.md"
---
**Closed 2026-06-17 (done):** multi-tenant isolation via Postgres RLS decided; the resolver runs above tenant RLS, all serving stays tenant-scoped.

# DAS CDP — Multi-Tenant Architecture Strategy

> **Service names below are illustrative, not a cloud lock.** This analysis is written in AWS terms (RDS, Redshift, S3, EKS) for concreteness; the architecture is a portable OSS core and the substrate is decided by the AWS-vs-Azure bake-off (Azure-primary preferred — Dan 2026-06-17). Read each AWS service as "or its Azure equivalent": RDS / Azure Database for PostgreSQL, Redshift / Fabric-Synapse (or Postgres-only), S3 / Blob, EKS / AKS, MWAA / Azure Managed Airflow. See the revised architecture plan and `docs/cloud-aws-vs-azure-bakeoff.md`.

**Acceptance:** the multi-tenancy isolation model is decided and documented as RLS over a shared database/shared schema (Option C), with the supporting choices fixed: tenant_id-scoped tables + Postgres RLS policies, a `BYPASSRLS` resolver role for cross-tenant identity work, append-only bitemporal observation table as the provenance layer, tokenized PII vault (delete-the-row) for erasure, hash-chained append-only consent ledger, and hybrid golden-record computation (read-time for portal, Redshift/equivalent materialized view for analytics). Each of the 11 schema DDL sketches (§11) is consistent with these decisions and carries its RLS enforcement point where tenant-scoped.

**References:**
- Decided 2026-06-21 (Leo): RLS is the confirmed multi-tenant isolation mechanism — shared-DB/shared-schema + RLS, tenant context via `app.current_tenant` GUC, `FORCE ROW LEVEL SECURITY` on owner roles, `BYPASSRLS` reserved for the resolver/maintenance — `memory/decisions.md#d-004`
- Decided 2026-06-21 (Leo): PII erasure mechanism is the tokenized reference vault (delete-the-row), superseding per-consumer DEK / crypto-shred; pepper scope per-tenant by default — `memory/decisions.md#d-012`
- Decided 2026-06-18 (Leo): consent ledger is application-built, append-only, SHA-256 hash-chained and cloud-portable — `memory/decisions.md#d-013`
- Decided 2026-06-17 (Dan, client preference + bake-off deliverable): cloud substrate decided by the AWS-vs-Azure bake-off, Azure-primary preferred (service names here are illustrative, not a lock) — `memory/decisions.md#d-093`
- `wiki/Privacy-by-Design.md` — RLS isolation rationale/tradeoffs and the PII vault erasure model
- `docs/consent-pii-erasure-options.md` — the erasure option set (Option C DEK exploration retained; vault is the chosen mechanism)
- `docs/cloud-aws-vs-azure-bakeoff.md` — the substrate decision the AWS-named services map onto

## 0\. Data Flow — Current State vs. Proposed CDP

The two diagrams below show where data lives and how it moves today (CVH-based), and where it will live and move in the proposed CDP.

### 0.1 Current State — CVH Identity Layer (Pre-CDP)

### 0.2 Proposed State — CDP Target Architecture

### 0.3 Proposed CDP Comparison

Every row below is a specific limitation of CVH and the direct CDP capability that addresses it.

**Current State (CVH)**| **Proposed CDP**
---|---
Identity matching: 2 hard-coded rules (email exact + lastname+address) — no way to add new rules without code changes| Deterministic waterfall with 5+ blocking keys (email, phone E.164, VIN+surname, Metaphone+zip) — new rules are config, not code
No trust tiers — a lead provider's email value overwrites a DMS value silently| 5-tier source trust hierarchy — DMS always wins over CRM, CRM over enrichment; tunable per field
No provenance — once a value is in CVH you cannot tell which source contributed it| Every observation row carries source_id, trust_tier, valid_from, system_from — full audit trail forever
No consent history — current consent state only; cannot prove what consent existed at time T| Hash-chained append-only consent ledger — cryptographically verifiable at any point in time
No right-to-erasure — GDPR/CCPA delete is a manual scan-and-delete; destroys bitemporal history| Tokenized PII vault: delete the vault row to erase a person; tokens elsewhere dereference to nothing and the bitemporal structure + provenance survive
RL OLTP franchise_consumer_alias (34M rows, richest identity data in estate) is not wired into CVH| RL OLTP is a first-class tier-1 source; consumer_alias feeds the identity resolver directly
Survivorship rules are implicit in SQL stored procedures — changing them requires a full data migration| Survivorship is a query pattern over the observation table — changing rules is a config change; history is untouched
Schema-level isolation impossible at 200 dealers without a full rebuild| RLS + observation table partitioned by tenant_id — adding dealer #200 is a row insert, not a schema change
Reporting relies on CVH → DWRPT → DWRPT_AI pipeline with manual ETL steps and 335GB staging| Redshift zero-ETL from RDS — no manual ETL, always fresh, replaces DWRPT_AI for analytics and AI features
**★**|  The fundamental shift: CVH is a mutable, rule-based de-duplication system built for 20 dealers. CDP is an append-only, provenance-first, privacy-native platform built for 200 dealers and 10M customers.
---|---

## 1\. Context — Scaling

**Dealer tenants**|  20 today → 200 target (10× growth)
---|---
**Customer records (est.)**|  ~1M today (50k avg/dealer × 20) → ~10M at 200 dealers
**Observation rows**|  ~20M today (multiple fields × records) → ~200–500M at 200 dealers
**Concurrent API connections**|  Low (20 dealers, light usage) → potentially 200+ concurrent dealer sessions
**Identity resolution load**|  ~20 dealer graphs to cross-match → 200 dealer graphs; cross-tenant resolution exponentially harder
**PII vault rows**|  PII (name/email/phone/address) for ~1M customers → ~10M customers; one mutable vault keyed by token
**Consent records**|  ~4M (4 channels × 1M customers) → ~40M
**Erasure requests**|  Rare today → potentially thousands/month at 200 dealers (CCPA/GDPR volume)
**!**|  The core principle: build the isolation model right at 20 — it is nearly impossible to retrofit multi-tenant isolation into a system that wasn't designed for it. Build the scale-out mechanisms (read replicas, connection pooling, caching) later as traffic grows. Get isolation right first.
---|---

## 2\. Multi-Tenancy Approach — Options & Trade-offs

There are three main approaches to isolating data across tenants in a relational database. The choice locks in the data model and is extremely costly to change later.

**Approach**| **Description**| **Pros**| **Cons**| **Rec.**
---|---|---|---|---
**A — Schema per tenant (one Postgres schema per dealer)**|  Each dealer gets their own Postgres schema (namespace). Tables are replicated per tenant. Queries don't mix tenant data at the row level.| \+ Hard isolation — no RLS policy bug can leak data\+ Simple query logic — no tenant_id WHERE clauses\+ Easy to drop a tenant (DROP SCHEMA)| − 200 schemas = 200× the migration burden — every schema change runs 200 times− Impossible to query across tenants (identity resolver would need dynamic SQL across all schemas)− Connection pooling breaks — PgBouncer can't pool across schemas− Completely unmanageable at 200 dealers| **✗**
**B — Database per tenant (one Postgres DB per dealer)**|  Each dealer gets a separate Postgres database, potentially on separate RDS instances.| \+ Maximum isolation\+ Independent backup and key rotation per dealer\+ Can place high-volume dealers on dedicated instances| − 200 databases = 200 RDS instances = $20k–$100k/month infra cost− Cross-tenant identity resolution requires distributed joins — latency nightmare− Schema migrations are an ops nightmare at this scale− Monitoring and observability multiply by 200| **✗**
**C — Row-level security (one DB, tenant_id column + Postgres RLS)**|  All tenants share tables. Every tenant-scoped table has a tenant_id column. Postgres RLS policies enforce visibility at query time. The resolver role bypasses RLS for cross-tenant identity work.| \+ Scales to 200+ dealers with no schema changes\+ Cross-tenant identity resolution is a native join — no distributed queries\+ Single migration path — one schema, one database\+ Connection pooling works normally (RDS Proxy)\+ Enforcement is in the DB, not the app — a bug in app code can't bypass it\+ Operationally simple — one cluster to monitor, backup, and upgrade| − A misconfigured RLS policy can theoretically leak data — requires rigorous testing− All tenants share I/O — a noisy dealer can affect others (mitigated by read replicas + connection limits per role)− RLS adds a small per-query overhead (~1–5% — negligible)| **✓**
**✓**|  RLS (Option C) is the only approach that survives the 20→200 growth curve without a complete rebuild. Schema-per-tenant and database-per-tenant work at small scale but become operationally and economically impossible at 200 dealers.
---|---

## 3\. Provenance — Where Does Each Row and Column Come From?

The question is not just which table a row lives in — it's which source, which dealer, at what time, with what confidence contributed each individual value. Two approaches:

**Approach**| **Description**| **Pros**| **Cons**| **Rec.**
---|---|---|---|---
**A — Separate provenance table (data table + provenance table)**|  One table holds the current value, a linked provenance table holds the history and source metadata.| \+ Clean separation of concerns\+ Current-value reads are fast (no bitemporal filter needed)\+ Familiar pattern for engineers who know audit tables| − Two tables to keep in sync — consistency risk− 'Current value' becomes stale the moment an update arrives− Joining for provenance adds query complexity− At 2B rows, two tables = 4B rows + join overhead− Survivorship logic must touch both tables| **~**
**B — Observation table IS the provenance table (append-only, bitemporal)**|  Every value from every source is a row in a single observation table. No UPDATE or DELETE — superseded_at marks when a row was replaced. The golden record is computed from active observations by applying survivorship rules.| \+ Single source of truth — no sync risk\+ Full history of every field's value, from every source, always available\+ 'As-of' time-travel is native — filter by valid_from/valid_to\+ Erasure is a vault-row delete (not a destructive table DELETE) — bitemporal structure survives\+ Append-only = no write contention between concurrent ingest jobs\+ Survivorship is a query pattern, not a write-time operation — rules can be changed retroactively| − Observation table grows large (2–5B rows at 200 dealers) — requires careful indexing− Golden record computation is a non-trivial query — needs optimization (see Section 7)− Engineers used to mutable row updates need to adjust mental model| **✓**

 _Why Option B scales better: at 200 dealers, the ability to change survivorship rules without reprocessing data is critical. With Option A, changing a rule means updating millions of 'current value' rows. With Option B, the rule change is just a query change — the raw observations are untouched._

## 4\. Encryption — Options & Trade-offs

RLS controls who can see which rows at runtime. It does NOT provide erasure. In an append-only system, right-to-erasure (GDPR/CCPA) requires a separate mechanism. At 200 dealers and 10M customers, erasure requests will be routine — not rare.

**Approach**| **Description**| **Pros**| **Cons**| **Rec.**
---|---|---|---|---
**A — RLS only (no encryption)**|  Rely entirely on Postgres RLS for data isolation. No encryption of PII fields.| \+ Zero implementation complexity\+ No key management overhead\+ Fast reads — no decryption cost| − No erasure mechanism — DELETE breaks bitemporal history− A DB admin or backup restore exposes all PII− Fails GDPR/CCPA right-to-erasure at scale− Regulators do not accept 'we deleted the row' in an append-only audit log− At 200 dealers, regulatory exposure is significant| **✗**
**B — Per-tenant encryption (one key per dealer)**|  One encryption key per dealer (~200 keys at scale). All records for a dealer encrypted under that key. Dealer offboarding = destroy the key.| \+ Simple to implement\+ Offboarding a dealer = one key destroy, all their data goes dark\+ ~$200/month at 200 dealers (manageable)| − No per-consumer erasure — can't erase one customer without destroying the whole dealer's data− Fails individual right-to-erasure (GDPR/CCPA applies to individuals)− A breach of the tenant key exposes all 50k+ customers for that dealer| **~**
**C — Per-consumer DEK (envelope encryption, KMS)**|  Each person gets a unique Data Encryption Key (DEK), wrapped by a small number of KMS CMKs. Erasure = destroy the DEK → that person's PII goes dark everywhere, instantly.| \+ Granular erasure — one customer erased without touching any other customer's data\+ DEK caching in Redis keeps cost at $15–90/month (not $3,000)\+ Bitemporal structure survives erasure — only PII payload goes dark\+ Scales to 100M DEKs easily (DynamoDB keystore)\+ Composes with CMK-per-tenant for blast-radius control on offboarding\+ Defense-in-depth — DB breach yields encrypted data only| − Too complex/brittle/expensive at scale: 10M-key lifecycle, decrypt-per-read, cache coherence, accidental-erasure risk− Cross-store erasure propagation (S3/Redshift/OpenSearch) needs orchestration− GLBA partial-deletion forces per-purpose sub-keys| **considered → superseded (2026-06-21)**
**D — Tokenized PII vault (delete-the-row)**|  PII centralized in one mutable vault keyed by a surrogate token; everything else (incl. the append-only observation log) holds tokens + provenance, never raw values. Erasure = delete the vault row; tokens dereference to nothing.| \+ Granular per-person erasure as a plain row delete\+ No per-person keys — no DEK lifecycle, cache, or decrypt-per-read\+ Provenance survives (tokens + source/time/method in the observation log)\+ Scoped GLBA/legal-hold deletion = WHERE on source+purpose, no sub-keys\+ Nothing to propagate cross-store — tokens elsewhere just dereference\+ Optional per-record salt+pepper hardening (single external pepper); pepper-clear = coarse kill-switch| − Vault is a hot dependency on the PII read path (one indexed join)− Raw landing zone must be ephemeral/short-retention (tokenize on ingest into the CDP)| **✓ (2026-06-21, Leo)**

 _Per-consumer DEK (C) is **superseded** by the vault (D): per-person keys are too complex, brittle, and expensive, and centralizing PII removes the scattered-PII condition crypto-shred existed to handle. C's analysis is retained in `docs/consent-pii-erasure-options.md` as the design exploration the vault was iterated from (options weighed across cost, key lifecycle, and cross-store propagation). Tokenize on ingest into the CDP only — not in front of block storage or event processing. See `wiki/Privacy-by-Design.md`._

## 5\. Consent Store — Options & Trade-offs

At 200 dealers with 4 channels each, consent records will number in the hundreds of millions. The design question is: how tamper-evident does the consent ledger need to be, and what does that cost?

**Approach**| **Description**| **Pros**| **Cons**| **Rec.**
---|---|---|---|---
**A — Mutable consent table (UPDATE current state)**|  One row per person/channel/tenant. UPDATE when consent changes. Current state only.| \+ Simple to query\+ Small table size\+ Easy to implement| − No audit trail — cannot prove what consent existed at time T− Fails regulatory defensibility — GDPR/CCPA require provable consent history− UPDATE operations at scale create write contention− A bug or bad migration can silently alter consent history| **✗**
**B — Append-only consent table (no hashing)**|  Every consent change is a new row. No UPDATEs. Point-in-time queries filter by valid_from/valid_to.| \+ Full consent history preserved\+ Point-in-time consent is queryable\+ Simple to implement — just Postgres| − No cryptographic tamper evidence — a DB admin could alter rows without detection− Regulatory defensibility relies on DB audit logs, not cryptographic proof− Table grows large at 200 dealers (manageable but needs partitioning)| **~**
**C — Hash-chained append-only (recommended: B2+B3)**|  Append-only rows where each row stores the SHA-256 hash of the previous row for that person/channel/tenant. Optionally KMS-sign each entry. Chain breaks = tampering detected.| \+ Cryptographically verifiable — any retroactive edit breaks the chain and is provable\+ KMS-signed entries add non-repudiation (who captured consent is provable)\+ No new infrastructure — still Postgres\+ Regulatory defensibility is mathematically provable, not policy-reliant\+ Pseudonymous references only — ledger survives PII erasure intact| − Hash computation on write (negligible CPU cost)− Chain verification requires sequential read (for audit, not normal queries)− KMS signing cost: $0.15/10k events — consent volume is low, negligible cost| **✓**
**D — Managed ledger (Amazon QLDB)**|  Purpose-built immutable cryptographically verifiable ledger service.| \+ Native tamper evidence\+ Fully managed| − AWS QLDB retired July 2025 — AWS is directing customers to Aurora Postgres− Vendor lock-in violates portability principle− More expensive and less flexible than Option C| **✗**

## 6\. Golden Record Computation — Options & Trade-offs

The golden record is the single best-known value for each field for each person, computed from all observations using survivorship rules. The architectural question is when and where that computation happens.

**Approach**| **Description**| **Pros**| **Cons**| **Rec.**
---|---|---|---|---
**A — Compute at read time (query-time derivation)**|  Every golden record request runs a survivorship query against the observation table on the fly. No pre-computed golden record stored anywhere.| \+ Always fresh — zero staleness\+ Survivorship rules can change without reprocessing data\+ No materialization overhead or invalidation logic\+ Correct 'as-of' time-travel is trivially correct| − Query is non-trivial — a window function over potentially thousands of observations per person− At 10M customers, latency risk if queries are unoptimized− High-volume analytics (full-table scans) would crush the OLTP database| **~ (portal use)**
**B — Materialized golden record table (pre-computed, refreshed on write)**|  A golden_record table is maintained, updated whenever a new observation arrives for a person.| \+ Instant reads — golden record is a single row lookup\+ Good for high-volume serving (activation, export)| − Staleness between observation write and golden record update− Two sources of truth — the observation table and the golden record table must agree− Rule changes require full re-materialization of the golden record table− Complex invalidation logic — which records to re-derive when a rule changes| **✗**
**C — Hybrid: read-time for portal, materialized view in Redshift for analytics**|  Portal and API compute golden records at read time (low volume, freshness required). Analytics use a materialized Redshift view refreshed on a schedule (high volume, acceptable lag).| \+ Portal is always fresh — dealer's golden record view shows current state\+ Analytics can query billions of rows without touching OLTP database\+ Redshift materialization is a config, not custom code (zero-ETL handles replication)\+ Rule changes only rebuild the Redshift view — no OLTP impact\+ Best of both: freshness where it matters, performance where it matters| − Two derivation paths to keep in sync logically (not technically — same rules, different execution)− Analytics lag (minutes to hours) — acceptable for reporting, not for real-time decisions| **✓**

 _Optimization for read-time golden record queries: the key is the composite index on (person_id, field_name, superseded_at, source_id, valid_from DESC). With this index, the survivorship window function touches only the active rows for a person, not the full billions-row table._

## 7\. Scalability Analysis — 20 → 200 Dealers

The table below assesses each architectural component at current scale (20 dealers) and at target scale (200 dealers), with the scaling risk and the mitigation already designed into this architecture.

**Area**| **@ 20 Dealers**| **@ 200 Dealers**| **Scaling Risk**| **Mitigation**
---|---|---|---|---
**Row-Level Security**|  Negligible overhead. 20 tenants, small tables. Any policy works.| 200 tenants, billions of rows. RLS WHERE clause runs on every query. With proper indexes on tenant_id, overhead stays at 1–5%.| **LOW**|  Composite index on (tenant_id, person_id, field_name, superseded_at). RDS Proxy for connection pooling — prevents 200 dealers × concurrent connections from exhausting Postgres max_connections. Per-role connection limits prevent noisy tenants.
**Observation table size**|  ~20M rows — trivially fast.| 2–5B rows — large but manageable in Postgres with partitioning.| **MEDIUM**|  Partition observation table by tenant_id (range or list partitioning). Postgres partition pruning means a dealer query touches only their partition. Archive partitions for offboarded dealers. Redshift absorbs the analytical load via zero-ETL.
**Identity resolver**|  Cross-matching 20 dealer graphs is fast — even brute force works.| Cross-matching 200 dealer graphs with 10M customers is the hardest scaling challenge in the system.| **HIGH**|  Blocking keys (phonetic name+zip, email local-part, phone-last-7, VIN+surname) limit the candidate set before scoring. Temporal sagas run parallel resolution workers — horizontal scale-out. Resolver processes only changed/new records (incremental, not full-scan). Phase 3 ML identity (not Phase 1) adds probabilistic scoring at scale.
**PII vault**|  PII for ~1M customers — a trivial table.| PII for ~10M customers — one mutable vault keyed by token, indexed for single-join lookup.| **LOW**|  One indexed join on the PII read path — no decrypt-per-read, no per-person key lifecycle. Optional per-record salt+pepper hardening uses a single external pepper, not per-person keys. Erasure = delete the vault row.
**Erasure at scale**|  Rare events — can be handled manually if needed.| Potentially hundreds of CCPA/TDPSA requests/month. Manual handling impossible.| **MEDIUM**|  Temporal saga per request — durable, auditable, retryable: delete vault row(s) + tombstone, confirm token references dereference, write audit. No cross-store PII purge (downstream stores hold tokens). Batch / pepper-clear for bulk (dealer offboarding).
**Consent table size**|  ~4M rows — trivial.| ~40M+ rows — large but bounded (consent events are low-frequency vs observations).| **LOW**|  Partition consent by tenant_id. Archive old events to S3 (retain the chain, move old events out of hot storage). Hash-chain verification is an offline audit operation, not a hot-path query.
**Connection pooling**|  20 dealers × low concurrency = well within Postgres max_connections.| 200 dealers × concurrent sessions could exhaust Postgres max_connections (typically 500–5,000).| **HIGH**|  RDS Proxy is non-negotiable at 200 dealers. It pools and multiplexes connections — 200 application connections share a small pool of actual Postgres connections. Per-role max_connections limits prevent a single tenant from starving others.
**Read throughput**|  A single RDS instance handles all reads comfortably.| 200 dealers × portal users × API calls = significant read load.| **MEDIUM**|  RDS read replicas scale reads horizontally. Django read/write routing (via RDS Proxy) sends reads to replicas, writes to primary. Redshift handles all analytics reads. OpenSearch handles all person-search reads. OLTP primary is writes-only at scale.
**Schema migrations**|  One schema, easy to migrate. Downtime is a few minutes at worst.| One schema still — this is the RLS advantage. Migration runs once, touches all tenants simultaneously.| **LOW**|  Django expand/contract pattern for zero-downtime migrations. RLS means no tenant-by-tenant migration scripts. This is a major operational advantage over schema-per-tenant.
**Onboarding new dealers**|  Manual onboarding is feasible.| 200 dealers cannot be manually onboarded. Onboarding must be a scripted, self-service flow.| **MEDIUM**|  Config-driven source registry — adding a dealer is a data entry (one row in source_registry + one Airflow DAG config). No code changes. The same pattern used for Superset guest tokens (one template → per-dealer script) applies here.

## 8\. Advantages for the proposed architecture

### 8.1 It is designed to grow, not just to work today

This will not be a CDP build for small number of clients. This architecture is designed from the start for 200+ dealers — the isolation model is row-level security, which adds zero marginal cost per new dealer.

### 8.2 The observation table is the competitive moat

Storing every value from every source with full provenance is what makes the golden record trustworthy and auditable. It is also what makes it possible to change the survivorship rules retroactively. As DAS learns which data sources are more reliable for which fields, they can tune the rules without reprocessing historical data.

### 8.3 Erasure is built in, not bolted on

GDPR, CCPA, and the Texas TDPSA are not going away. At 200 dealers across North America, erasure requests will be routine. The tokenized PII vault means erasure is a single row delete — not a cross-table scan-and-delete, and not per-person key management. Provenance survives (the observation log holds tokens, not values), and there is nothing to propagate cross-store. Economically viable at 10M customers with no per-person key lifecycle.

### 8.4 The identity graph is the hardest thing to build later

The cross-tenant identity resolver is the most complex component and the highest-value differentiator. Starting with 20 dealers gives DAS the opportunity to tune the resolver's blocking keys, scoring thresholds, and curation queue workflows before the graph is 100× larger. The architecture must be designed for scale now, even if the traffic doesn't demand it yet.

### 8.5 The read-mostly model is a cost advantage

At 200 dealers, the CDP will serve far more reads than writes. The append-only observation layer + read replicas + Redshift zero-ETL means reads scale horizontally at low cost, while the write path stays simple and auditable. There is no complex distributed transaction coordination — each ingest is an independent append.

## 9\. Open Decisions

**CMK per tenant or shared CMK?** _(Superseded 2026-06-21 — the per-consumer DEK approach is replaced by the tokenized PII vault; there are no per-person DEKs to shred. The blast-radius control is now the optional salt+pepper hardening with per-tenant pepper scope; pepper-clear is the offboarding kill-switch. Historical:)_|  CMK per tenant ($200/mo at 200 dealers) gives blast-radius control on offboarding — one key destroy shreds all a dealer's DEKs. Shared CMK is cheaper. Recommend: start shared, add per-tenant CMK when first dealer offboarding event occurs.
---|---
**DynamoDB vs Postgres for keystore?** _(Superseded 2026-06-21 — the tokenized PII vault replaces the DEK keystore entirely; there is no per-person key store. Historical:)_|  DynamoDB gives independent backup/retention control (destroy DEKs without risk of backup resurrection). Postgres is simpler operationally. Recommend: DynamoDB with idempotency keys on the write path.
**Consent: KMS-signed entries?**|  Signing each consent event ($0.15/10k, negligible volume) adds non-repudiation. The hash chain alone gives tamper evidence. Recommend: ship hash-chain first; add KMS signing when a regulatory requirement surfaces.
**Resolver: Postgres BYPASSRLS or application-level?**|  Dedicated Postgres role with BYPASSRLS is auditable and enforced at the DB level. Application-level bypass is simpler but weaker. Recommend: BYPASSRLS role + audit logging on every cross-tenant read.
**Erasure orchestration: Temporal or Lambda?**|  Temporal is already in the stack and gives durable, auditable sagas. Lambda is simpler for one-shot jobs. At 200 dealers and thousands of erasure requests/month, durability and auditability are required. Recommend: Temporal.
**Observation table partitioning strategy?**|  Partition by tenant_id (list partitioning) gives clean per-tenant partition pruning and enables easy offboarding (DROP PARTITION). Partition by time (range) gives better archival. Recommend: list-partition by tenant_id; archive old partitions to S3 compressed storage.
**Golden record: index strategy?**|  Composite index on (person_id, field_name, superseded_at) for golden record reads. Composite index on (tenant_id, person_id) for tenant-scoped queries. Covering index for the most common query patterns. Luis to confirm index set with the schema design.
**Connection limits per tenant?**|  At 200 dealers on RDS Proxy, a single high-traffic dealer could starve others. Per-role or per-tenant connection limits in RDS Proxy prevent this. Recommend: set max connections per dealer role at 10–20 initially; tune based on observed usage.
**RL OLTP as CDP source?**|  franchise_consumer_alias (34M rows) is the richest identity table in the estate. Should CDP ingest it directly as a high-trust source for identity resolution? Recommend: yes — map to trust tier 1 for identity signals, tier 3 for enrichment fields. Requires Rick Sorich / RL team alignment.
**CVH transition strategy?**|  CDP golden record must be a drop-in replacement for CVH reads in BlueSky, Mautic, CDXP, and Juicebox. Define the cutover sequence and parallel-run period before Phase 1 ships. Recommend: 90-day parallel run; compare CVH vs CDP golden record for a sample of dealers; cut over dealer-by-dealer.

## 10\. Existing Database & ETL Landscape

CDP does not exist in a vacuum. DAS currently has 231 SQL objects across 20 modules and 5 platforms that perform identity resolution, enrichment, activation, and reporting. The table below maps each existing system to its role today and its relationship to the CDP — what it feeds, what it replaces, what it must keep running through the transition.

**!**|  Critical rule: CDP ingests from raw source tables only. It must NOT read from CVH, DWRPT views, or any derived/pre-joined table. These tables embed survivorship decisions we want to re-derive from scratch with our own rules. RL OLTP and DMS source tables are the ground truth.
---|---
**System**| **Role Today**| **Key Tables / Objects**| **CDP Relationship**| **Phase**
---|---|---|---|---
**RL OLTP (20.65.216.199)**|  Real-time franchise consumer database. Richest identity table in the estate.| franchise_consumer (51M rows)franchise_consumer_alias (34M)lead (11M)franchise_consumer_vehicle| CDP ingests franchise_consumer and consumer_alias as high-trust identity source. CommonClientID is the cross-system join key (data quality issues — requires validation before use as match key).| **MIGRATE**
**DMS Sources (via Authenticom/CDK 3PA)**|  Dealer Management System ground truth for transactions (sales, service, finance).| source_DMS_Sales_*source_DMS_Service_*source_DMS_Finance_*source_DMS_Customer_*| Trust tier 1 — highest trust for all transactional fields. CDP ingests these directly via Airflow MWAA + S3 bronze. CDK 3PA delivers trim more reliably than Authenticom in some franchise contexts.| **KEEP**
**CRM (21+ providers) (Megatron / DAS Primary)**|  Customer engagement history from eLeads, VinSolutions, DealerSocket, Tekion, etc.| staging_CRM_*CRM_DMS_Recipient_Matchessource_CRM_*| Trust tier 2. CDP ingests raw CRM source tables — not CRM_DMS_Recipient_Matches (that is a CVH join artifact). Email, phone, address from CRM feed the identity resolver.| **MIGRATE**
**CVH (DAS Primary / DWRPT)**|  Current identity merge layer. Applies a 2-rule match: email exact + (lastname + address). Powers BlueSky, Mautic, CDXP, Juicebox.| CVHCVH_ListCVH_Match_*CRM_DMS_Recipient_Matches| CDP replaces CVH entirely. CVH is NOT an ingestion source — its pre-joined output embeds survivorship decisions we want to rebuild. CDP golden record must be a drop-in for CVH reads. 90-day parallel run recommended before cutover.| **REPLACE**
**SSIS / Airflow ETLs (DAS Primary)**|  231 SQL objects in 20 modules. Moves data between source tables, staging, CVH, and analytics.| DMS_Dim_*DMS_Fact_*Email_Events/*Analytics_*| CDP replaces the identity portion of SSIS with Airflow MWAA DAGs. Enrichment ETLs (BlackBook, RecallMasters) are re-implemented as config-driven Airflow tasks in the source registry. Analytics ETLs to Juicebox are replaced by Redshift zero-ETL.| **REPLACE**
**Megatron (DAS Primary 20.51.108.231)**|  Main DAS OLTP — 852 tables, 438GB. Account, listing, transaction history.| Account (2M rows)Listing (7M)AccountVehicleTransactionHistory| CDP reads Account and AccountVehicle as a secondary identity source (CommonClientID linkage). Not a primary DMS source — treat as enrichment tier 3. CommonClientID data quality must be validated before using as a join key in the identity resolver.| **MIGRATE**
**DataStaging (DWRPT 40.83.161.93, 335GB)**|  DWRPT reporting staging. 13 schemas. Feeds Juicebox dashboards and AI pipeline.| ai.* (42 AI views)cdxp.*juice.*RLData.*core.*| DataStaging is a downstream consumer of CVH — not a CDP source. CDP replaces the upstream (CVH) and the analytics output (Juicebox via Redshift). DWRPT_AI views are replaced by CDP+Redshift serving layer.| **REPLACE**
**BlackBook API (batch enrichment)**|  Vehicle equity, trade-in, book value enrichment. Key for finance/equity golden record fields.| BlackBook_VehicleValue_*equity_snapshot| Trust tier 3 enrichment. CDP re-implements BlackBook pull as a config-driven Airflow DAG. Equity fields (current_vehicle_equity, trade_in_value) sourced here. VIN is the join key.| **KEEP**
**RecallMasters API (batch enrichment)**|  Open safety recall data by VIN.| RecallMasters_OpenRecalls_*| Trust tier 3 enrichment. Recall data feeds the vehicle object in CDP (open_recalls field). Low-frequency pull (daily or weekly batch).| **KEEP**
**Mautic (activation)**|  Email/SMS campaign execution. Currently reads from CVH for audience segmentation.| Mautic_Contact_*Mautic_Segment_*| Phase 2 activation target. CDP golden record replaces the CVH-based Mautic audience. Mautic reads from CDP API (not directly from Postgres). Transition requires mapping Mautic segment logic to CDP filter queries.| **MIGRATE**
**CDXP (activation)**|  Cross-channel experience platform. Reads CVH for audience.| cdxp.contactcdxp.audience_segment| Phase 2 activation target. CDP golden record feeds CDXP audience via API. Parallel run with CVH during transition.| **MIGRATE**
**Juicebox (reporting)**|  Dealer-facing analytics dashboards. 50+ reporting tables. Reads DWRPT.| JuiceReporting.*juice.* in DataStaging| Phase 3 reporting migration. Redshift zero-ETL + Superset replaces Juicebox for CDP-era reporting. Juicebox continues for non-CDP reports during transition.| **MIGRATE**
**DAS AI (ai.das-technology.com)**|  AI-assisted dealer tools. Currently reads DWRPT_AI views.| DWRPT_AI.* (42 views)| CDP golden record via Redshift replaces DWRPT_AI as the data foundation for AI features. Phase 3 dependency — AI uses CDP-sourced data instead of CVH-derived views.| **MIGRATE**

 _Phase legend: KEEP = continues as-is, feeds CDP. MIGRATE = is migrated/transitioned to use CDP data. REPLACE = CDP eliminates this component entirely. The sequence matters: KEEP systems onboard first, then REPLACE ones are sunset, then MIGRATE consumers cut over._

## 11\. Schema DDL — Key Table Definitions

The following DDL sketches define the core tables of the CDP canonical store (RDS PostgreSQL). These are architectural definitions — production DDL will be generated via Django migrations and reviewed by Luis. All tables use RLS; comments mark the enforcement point.

### 11.1 tenant

One row per dealer. The anchor for all RLS policies.

CREATE TABLE cdp.tenant ( tenant_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), dealer_code TEXT NOT NULL UNIQUE, -- DAS dealer code name TEXT NOT NULL, cmk_arn TEXT, -- per-tenant KMS CMK (optional) onboarded_at TIMESTAMPTZ NOT NULL DEFAULT now(), offboarded_at TIMESTAMPTZ, -- null = active metadata JSONB DEFAULT '{}');
---

### 11.2 person

One row per unique person identity. Human-readable PII (name/email/phone/address) lives in `cdp.pii_vault` (§11.6), referenced by token; the person row keeps only non-PII resolver-blocking signals.

CREATE TABLE cdp.person ( person_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), \-- Human-readable PII lives in cdp.pii_vault (keyed by pii_token), never here. \-- Pseudonymous blocking keys for the resolver (queryable; SCRUBBED on erasure) email_hash TEXT, -- SHA-256 of canonical email phone_hash TEXT, -- SHA-256 of E.164 phone last_name_metaphone TEXT, -- Metaphone of last name zip_code TEXT, \-- created_at TIMESTAMPTZ NOT NULL DEFAULT now(), updated_at TIMESTAMPTZ NOT NULL DEFAULT now());\-- person is a global (DAS-plane) table — no tenant_id, no RLS.\-- Tenant visibility is enforced via identity_link.
---

### 11.3 identity_link

Maps a person (global DAS plane) to a tenant (dealer plane). RLS enforced here — a dealer query only sees identity_links where tenant_id matches their session role.

CREATE TABLE cdp.identity_link ( link_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), person_id UUID NOT NULL REFERENCES cdp.person(person_id), tenant_id UUID NOT NULL REFERENCES cdp.tenant(tenant_id), source_person_id TEXT NOT NULL, -- ID in the source system source_id UUID NOT NULL REFERENCES cdp.source_registry(source_id), linked_at TIMESTAMPTZ NOT NULL DEFAULT now(), confidence NUMERIC(4,3), -- 0.000–1.000 link_method TEXT, -- deterministic | heuristic | manual UNIQUE(person_id, tenant_id, source_id));ALTER TABLE cdp.identity_link ENABLE ROW LEVEL SECURITY;CREATE POLICY tenant_isolation ON cdp.identity_link USING (tenant_id = current_setting('app.current_tenant_id')::UUID);\-- Resolver role bypasses RLS to perform cross-tenant matching.CREATE ROLE cdp_resolver BYPASSRLS;CREATE INDEX ON cdp.identity_link (tenant_id, person_id);CREATE INDEX ON cdp.identity_link (person_id);
---

### 11.4 source_registry

Config-driven registry of all data sources. Adding a new dealer data source is a row insert here + Airflow DAG config — no code changes.

CREATE TABLE cdp.source_registry ( source_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), tenant_id UUID REFERENCES cdp.tenant(tenant_id), -- null = global source source_code TEXT NOT NULL UNIQUE, -- e.g. 'cdk_3pa', 'elead_crm' source_type TEXT NOT NULL, -- dms | crm | lead | email | sms | enrichment | event trust_tier SMALLINT NOT NULL CHECK (trust_tier BETWEEN 1 AND 5), field_coverage JSONB, -- {field_name: true/false} ingest_config JSONB, -- Airflow DAG params, connection info active BOOLEAN NOT NULL DEFAULT true, onboarded_at TIMESTAMPTZ NOT NULL DEFAULT now());\-- Trust tier reference: 1=DMS, 2=CRM, 3=Enrichment, 4=Engagement, 5=Social/Ad
---

### 11.5 observation (append-only, bitemporal)

The heart of the CDP. Every value from every source for every person is a row here. No UPDATEs. superseded_at is set when a newer observation wins for the same field. Partitioned by tenant_id.

CREATE TABLE cdp.observation ( obs_id UUID NOT NULL DEFAULT gen_random_uuid(), tenant_id UUID NOT NULL REFERENCES cdp.tenant(tenant_id), person_id UUID NOT NULL REFERENCES cdp.person(person_id), source_id UUID NOT NULL REFERENCES cdp.source_registry(source_id), field_name TEXT NOT NULL, -- 'email' | 'phone' | 'trim' | etc. \-- Bitemporal timestamps valid_from TIMESTAMPTZ NOT NULL, -- when true in the real world valid_to TIMESTAMPTZ, -- null = currently valid system_from TIMESTAMPTZ NOT NULL DEFAULT now(), -- when CDP learned it superseded_at TIMESTAMPTZ, -- null = active; set when newer obs wins \-- Value (PII encrypted; non-PII plaintext) value_text TEXT, -- non-PII plaintext value pii_token UUID, -- PII fields: reference into cdp.pii_vault (null for non-PII) value_numeric NUMERIC, -- numeric fields (equity, mileage) value_jsonb JSONB, -- structured fields (address) \-- Provenance raw_event_id TEXT, -- ID in source system ingest_job_id UUID, -- Airflow run that created this row confidence NUMERIC(4,3), -- 0.000–1.000 PRIMARY KEY (obs_id, tenant_id) -- partition key included in PK) PARTITION BY LIST (tenant_id);\-- RLS: dealers see only their observations.ALTER TABLE cdp.observation ENABLE ROW LEVEL SECURITY;CREATE POLICY tenant_isolation ON cdp.observation USING (tenant_id = current_setting('app.current_tenant_id')::UUID);\-- Indexes (on parent; propagate to partitions automatically in PG 14+)CREATE INDEX obs_person_field ON cdp.observation (person_id, field_name, superseded_at);CREATE INDEX obs_tenant_person ON cdp.observation (tenant_id, person_id);CREATE INDEX obs_source_time ON cdp.observation (source_id, system_from);\-- Example: create partition for a new tenant\-- CREATE TABLE cdp.observation_tenant_abc PARTITION OF cdp.observation\-- FOR VALUES IN ('a1b2c3d4-...-tenant-uuid');
---

### 11.6 pii_vault (PII reference vault)

Holds the raw human-readable PII values, keyed by token — the single place PII lives. Everything else references it by token; erasure = delete the row. Optional per-row salt+pepper hardening protects values at rest (single external pepper, not per-person keys). _Proposed shape — the final data model (table set, column details) is in design, owned by Alicia + Luis._

CREATE TABLE cdp.pii_vault ( pii_token UUID PRIMARY KEY DEFAULT gen_random_uuid(), person_id UUID NOT NULL REFERENCES cdp.person(person_id), field_name TEXT NOT NULL, -- 'email' | 'phone' | 'first_name' | 'address' | ... source_id UUID REFERENCES cdp.source_registry(source_id), purpose TEXT, -- scope for GLBA/legal-hold deletion legal_hold BOOLEAN NOT NULL DEFAULT false, value_text TEXT, -- raw PII value (or ciphertext when hardened) protection_scheme TEXT NOT NULL DEFAULT 'none', -- none | salt_pepper | v1 salt BYTEA, -- per-row salt when hardened (pepper held outside the DB) created_at TIMESTAMPTZ NOT NULL DEFAULT now(), erased_at TIMESTAMPTZ -- set when an erasure saga deletes/tombstones the row);\-- Erasure: DELETE deletable rows (WHERE person_id = ... AND NOT legal_hold).\-- Provenance survives in cdp.observation (token + source/time/method, never the value).\-- Hardened rows: value_text = enc(value, KDF(pepper, salt)); clearing the pepper darkens all hardened rows.\-- Key cache: pepper / derived keys may be cached in an isolated Redis (short TTL, separate from app cache) to avoid a secrets/DB round-trip per decryption; cache evicts on erasure.
---

### 11.7 consent (hash-chained, append-only)

Consent ledger. Append-only. Each row hashes the previous row for that (person_id, tenant_id, channel) — tamper detection. PII references are pseudonymous (person_id only, no plaintext email/phone).

CREATE TABLE cdp.consent ( consent_id UUID NOT NULL DEFAULT gen_random_uuid(), tenant_id UUID NOT NULL REFERENCES cdp.tenant(tenant_id), person_id UUID NOT NULL REFERENCES cdp.person(person_id), channel TEXT NOT NULL CHECK (channel IN ('email','sms','push','mail')), granted BOOLEAN NOT NULL, captured_at TIMESTAMPTZ NOT NULL DEFAULT now(), captured_by TEXT NOT NULL, capture_method TEXT NOT NULL, expires_at TIMESTAMPTZ, prev_hash TEXT, row_hash TEXT NOT NULL, kms_signature TEXT, PRIMARY KEY (consent_id, tenant_id)) PARTITION BY LIST (tenant_id);ALTER TABLE cdp.consent ENABLE ROW LEVEL SECURITY;CREATE POLICY tenant_isolation ON cdp.consent USING (tenant_id = current_setting('app.current_tenant_id')::UUID);CREATE INDEX consent_person_channel ON cdp.consent (person_id, tenant_id, channel, captured_at DESC);
---

### 11.8 Golden Record Survivorship Query

No golden_record table exists. The golden record is a query over the observation table, applying survivorship: active rows only (superseded_at IS NULL), ranked by trust tier then recency.

WITH ranked AS ( SELECT o.field_name, o.value_text, o.pii_token, o.value_numeric, o.value_jsonb, o.valid_from, s.trust_tier, s.source_code, ROW_NUMBER() OVER ( PARTITION BY o.person_id, o.field_name ORDER BY s.trust_tier ASC, o.valid_from DESC ) AS rn FROM cdp.observation o JOIN cdp.source_registry s ON s.source_id = o.source_id WHERE o.person_id = $1 AND o.superseded_at IS NULL AND o.valid_to IS NULL)SELECT field_name, value_text, pii_token, value_numeric, value_jsonb, trust_tier, source_code, valid_fromFROM ranked WHERE rn = 1;
---
*****|  This query is the CDP core deliverable. Every portal view, every activation segment, every AI feature runs this pattern. The index on (person_id, field_name, superseded_at) is what makes it fast at 10M customers.
---|---
