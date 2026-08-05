---
source: DAS Technology (internal spec)
version: v4
date: March 2026
type: source-doc
original: das-cdp-mvp-spec-v4.docx
---

> Original: [das-cdp-mvp-spec-v4.docx](/artifacts/phase-0/source-docs/das-cdp-mvp-spec-v4.docx) — this markdown is the processed/machine-readable form.

# DAS Technology — Customer Data Platform: MVP Specification

> 4 Stages: Plan → Build Foundation → Build Core → Ship | Cloud-Agnostic | Containerized | AI-Ready
>
> 27 Data Points | Deterministic Identity Resolution | Multi-Tenant
>
> TypeScript / Node.js | Next.js 15 | PostgreSQL 16 | Docker + Azure AKS
>
> March 2026

## 1. MVP Scope & Principles

This document specifies the Minimum Viable Product for the DAS Technology CDP, organized into 4 stages: Stage 1 covers planning, architecture review, and setup of the AI-assisted development environment. Stages 2–4 are build, using AI coding tools (Claude Code) for accelerated development. The MVP captures 27 specific data points across vehicle ownership, service, equity, and insurance — with deterministic identity resolution, multi-tenant isolation, and real-time data ingestion from DAS internal apps and third-party integrations (CRM, DMS, Meta, TikTok, etc.).

### What's IN the MVP

- 27 defined data points across 5 categories: Vehicle & Owner Info, Service & Parts, Service History, Vehicle Protection, and Equity/Trade-In/Insurance.
- Multi-tenant data model with PostgreSQL Row-Level Security (dealership isolation).
- Deterministic identity resolution (Tier 1): exact match on email, phone, VIN, dealer customer ID.
- Real-time event ingestion API (with consumer_id return for fast-path subsequent events) + batch file import.
- 4 ingestion channels: Webhook (real-time push), Event Grid (subscription), Bulk Manual Upload (UI), Batch Ingestion (scheduled pull from DB/FTP/API). At least 1 test input per channel for MVP.
- Consumer merge/unmerge with full audit trail.
- Next.js frontend: DAS admin dashboard, consumer 360° profiles, match review, dealer portal.
- Data normalization (email, phone, VIN, address, name).
- 100% containerized: Docker Compose for local dev. Production deploys to DAS DevOps' existing Azure AKS cluster as a new tenant.
- Cloud-agnostic: zero cloud SDKs. PostgreSQL, Redis, S3, OIDC — industry standards only.

### What's NOT in the MVP (Phase 2)

- AI/ML identity resolution (Tier 2 pairwise classifier, Tier 3 embeddings/GNN, LLM review).
- Audience builder, analytics dashboards, data redaction/deletion workflows.
- ML model registry, activation/export connectors, Cosmos DB identity graph, data warehouse.
- JavaScript website pixel (DAS does not have this today; all data comes via internal apps and integrations).

### AI-Ready: How the MVP Prepares for Phase 2

- All 19 database tables deployed from Stage 2 — including 4 AI/ML tables (empty, structurally complete). Zero schema migrations for AI.
- `identity_link.link_type` already includes: `ml_confirmed`, `gnn_cluster`, `llm_confirmed`.
- The identity resolver has a clear extension point: after Tier 1 returns no match, a function call to Tier 2 is stubbed. Plugging in the ML model is one code change.
- `match_review_queue` exists in MVP for manual conflict review. AI fills it automatically in Phase 2.
- `packages/ml` directory scaffolded, ready for ONNX inference code.
- Event Grid outbound publishing infrastructure built and wired (EventPublisher service, hook points in identity/merge/consent, `outbound_event_log` table, CloudEvents format) but disabled via config. Phase 2 activation is config-only — no code changes.

### Cloud-Agnostic Principles

- Zero cloud-specific SDKs. No Azure SDK, no AWS SDK, no GCP SDK in application code.
- Standard protocols only: PostgreSQL wire, Redis, S3 API, OIDC. Works everywhere.
- Docker Compose for local dev. Production deploys to DAS DevOps' existing Azure AKS infrastructure (new tenant/namespace).
- Secrets via environment variables. Auth via any OIDC provider (Keycloak, Auth0, Entra, Cognito).

## 2. Data Model: 27 MVP Data Points

The MVP captures exactly 27 data points across 5 categories. These map directly to database columns and API fields. The `consumer_attribute` EAV table handles multi-valued and extensible attributes, while dedicated columns on the `consumer` and `vehicle` tables store the most-queried fields for performance.

### 2.1 Vehicle & Owner Info (13 fields)

| # | Field | DB Location | Type |
|---|-------|-------------|------|
| 1 | CustomerFirstName | `consumer.first_name` | TEXT |
| 2 | CustomerLastName | `consumer.last_name` | TEXT |
| 3 | CustomerEmail | `consumer.primary_email` + `consumer_attribute` | TEXT (normalized) |
| 4 | CustomerCellPhone | `consumer.primary_phone` + `consumer_attribute` | TEXT (E.164) |
| 5 | VehicleYear | `vehicle.year` | INTEGER |
| 6 | VehicleMake | `vehicle.make` | TEXT |
| 7 | VehicleModel | `vehicle.model` | TEXT |
| 8 | TrimLevel | `vehicle.trim` | TEXT |
| 9 | VehicleVIN | `vehicle.vin` | TEXT (17-char, unique) |
| 10 | PurchaseDate | `consumer_vehicle.acquired_at` | TIMESTAMPTZ |
| 11 | VehicleMileage | `vehicle.mileage` | INTEGER |
| 12 | PurchasePrice | `consumer_vehicle.metadata->'purchase_price'` | NUMERIC (JSONB) |
| 13 | VehicleCondition | `vehicle.vehicle_type` | TEXT (new/used/cpo) |

### 2.2 Service & Parts (5 fields)

| # | Field | DB Location | Type |
|---|-------|-------------|------|
| 14 | OemMaintenanceSchedule | `consumer_attribute` (name='oem_maintenance_schedule') | JSONB (dates/mileage array) |
| 15 | CompletedServices | `consumer_attribute` (name='completed_services') | JSONB (service + date/mileage) |
| 16 | DeclinedServices | `consumer_attribute` (name='declined_services') | JSONB (service array) |
| 17 | OpenRecallsByVIN | `consumer_attribute` (name='open_recalls') | JSONB (recall array per VIN) |
| 18 | CompletedRecallsByVIN | `consumer_attribute` (name='completed_recalls') | JSONB (recall array per VIN) |

### 2.3 Service History (3 fields)

| # | Field | DB Location | Type |
|---|-------|-------------|------|
| 19 | CompletedServicesWithMedia | `consumer_attribute` (name='service_history_media') | JSONB (service + date + image URLs) |
| 20 | ServiceCoupons | `consumer_attribute` (name='service_coupons') | JSONB (coupon array) |
| 21 | ServicePlanOffering | `consumer_attribute` (name='service_plan_offering') | JSONB (plan details) |

### 2.4 Protect the Vehicle (1 field)

| # | Field | DB Location | Type |
|---|-------|-------------|------|
| 22 | ServiceOrWarrantyPlanOfferings | `consumer_attribute` (name='warranty_plan_offerings') | JSONB (offering array) |

### 2.5 Equity, Trade-In & Insurance (5 fields)

| # | Field | DB Location | Type |
|---|-------|-------------|------|
| 23 | EquityAmount | `consumer_attribute` (name='equity_amount') | NUMERIC |
| 24 | MarketValue | `consumer_attribute` (name='market_value') | NUMERIC |
| 25 | VehicleUpgradeOptions | `consumer_attribute` (name='upgrade_options') | JSONB (option array) |
| 26 | InsuranceProvider | `consumer_attribute` (name='insurance_provider') | TEXT |
| 27 | InsuranceQuoteList | `consumer_attribute` (name='insurance_quotes') | JSONB (quote array) |

### Design Decision: consumer_attribute EAV + JSONB

Fields 1–4 and 5–13 are stored as dedicated columns on `consumer` and `vehicle` tables for fast querying and indexing. Fields 14–27 are stored in the `consumer_attribute` EAV table with JSONB values. This gives maximum flexibility: new data points can be added in Phase 2 without schema migrations, while the most-queried owner/vehicle fields remain fast first-class columns.

## 3. Architecture

Four layers, all containerized. No managed cloud services required.

### Layer 1 — Ingestion

Four channels feed data into the CDP: (1) Webhook API for real-time event pushes from external apps, (2) Event Grid subscription listener for asynchronous topic-based events, (3) Bulk manual upload via the frontend UI to S3-compatible storage, (4) Batch ingestion workers that pull on a schedule from databases, FTP servers, and APIs. All channels converge into the same validation → normalization → identity resolution pipeline.

### Layer 2 — Identity Resolution (Deterministic)

If a `consumer_id` is provided (from a prior response), the event links directly ('fast path', <5ms). Otherwise, exact match on normalized email → phone → VIN → dealer_customer_id. Conflicts go to review queue. Extension point for Tier 2 ML in Phase 2.

### Layer 3 — Storage

PostgreSQL 16 + pgvector (pre-installed for Phase 2). All 19 tables deployed. RLS enforces multi-tenant isolation as a safety net. Drizzle ORM provides type-safe database access. Redis for session cache and BullMQ job queue.

### Layer 4 — API + Frontend

Express API (TypeScript) + Next.js 15 frontend + NGINX reverse proxy. All containerized.

### Data Flow

```
Webhook / Event Grid / Upload / Batch Pull → Validate → Normalize → Deterministic Resolution → PostgreSQL → API → Frontend
```

## 4. Technology Stack

Everything containerized. Zero cloud vendor lock-in.

| Component | Technology | Container | Notes |
|-----------|------------|-----------|-------|
| API Server | TypeScript / Node.js 20 / Express | `cdp-api` | All business logic. Dockerfile: `node:20-slim`. |
| Frontend | Next.js 15 (App Router, SSR) | `cdp-web` | Standalone build. shadcn/ui + Tailwind CSS. |
| Reverse Proxy | NGINX | `cdp-nginx` | Path routing, TLS, static cache. |
| Database | PostgreSQL 16 + pgvector | `cdp-postgres` | `pgvector/pgvector:pg16` image. RLS enabled. |
| Cache / Queue | Redis 7 + BullMQ | `cdp-redis` | Session cache + background job queue. |
| Object Storage | MinIO (S3-compatible) | `cdp-minio` | Batch uploads. Swap for any S3 in prod. |
| ORM | Drizzle ORM | (in `cdp-api`) | See rationale below. |
| Validation | Zod | (in all packages) | Shared between API and frontend. |
| Auth | NextAuth.js v5 + any OIDC | (in `cdp-web`) | Keycloak, Auth0, Entra, Cognito — all work. |
| UI | shadcn/ui + Tailwind + TanStack | (in `cdp-web`) | Table, Query, React Hook Form. |
| Testing | vitest | (all packages) | Unit + integration. |
| Monorepo | pnpm workspaces | — | Shared types across packages. |
| K8s Deploy | Azure AKS (existing DAS infra) | DAS DevOps tenant | New namespace in DAS' existing AKS cluster. K8s manifests for deployments. |

### Portability

Application code imports ZERO cloud-specific packages. PostgreSQL, Redis, S3, OIDC are industry standards supported everywhere.

## 5. Data Sources & Ingestion

### 5.1 Ingestion Sources (MVP)

The CDP accepts data through 4 ingestion channels. For MVP, at least 1 working input will be provided for each source to validate end-to-end ingestion.

| Source | How It Works | MVP Test Input | Example Use Cases |
|--------|--------------|----------------|-------------------|
| Webhook | External apps push events to `POST /api/v1/events`. Real-time. Returns `consumer_id` for fast-path subsequent calls. | DAS internal app sends a consumer update event | CRM pushes a new lead, DMS sends a service completion, call tracking posts a call event, Meta/TikTok sends a lead form submission |
| Event Grid | CDP subscribes to Azure Event Grid topics. Events arrive asynchronously via push subscription. A listener worker validates and routes events through the identity pipeline. | Subscribe to 1 Event Grid topic (e.g., DMS service events) | OEM recall notifications, DMS inventory changes, third-party data provider updates, cross-system event orchestration |
| Bulk Manual Upload | Users upload CSV/JSON files through the CDP frontend UI. File lands in S3-compatible storage. A BullMQ worker processes row-by-row through identity resolution. | Upload a sample CSV of 50 consumers + vehicles via the UI | Dealer onboarding (initial data load), CRM export import, periodic DMS data dumps, manual data corrections |
| Batch Ingestion | CDP pulls data on a configurable schedule from external resources (database connections, FTP/SFTP servers, API endpoints). A scheduled worker fetches, transforms, and ingests. | Pull from 1 test database table on a schedule | Nightly DMS sync, scheduled CRM pulls, FTP file pickup from OEM partners, periodic third-party data refresh |

### 5.2 Ingestion Architecture

All 4 sources converge into the same processing pipeline: validate → normalize → identity resolution → store. The only difference is how data enters the system.

```
Webhook (POST /api/v1/events)  ───┐
Event Grid (subscription listener) ─┼─→ Validate → Normalize → Identity Resolution → PostgreSQL
Bulk Upload (UI → S3 → worker)   ─┤
Batch Pull (scheduled worker)     ──┘
```

#### Webhook: Real-Time Event API

`POST /api/v1/events` — the primary real-time ingestion endpoint. Returns `consumer_id` for fast-path subsequent events.

First Event (full identity resolution):

```http
POST /api/v1/events
{ event_type, event_source, dealership_code, timestamp,
  identifiers: { email, phone, vin, ... },
  properties: { ... } }

Response: 202 { event_id, consumer_id, resolution: 'matched'|'created'|'conflict' }
```

Subsequent Events (fast path, <5ms):

```http
POST /api/v1/events
{ event_type, consumer_id: 'con_xxx', dealership_code, ... }

Response: 202 { event_id, consumer_id, resolution: 'direct' }
// If merged since last call: resolution: 'redirected', new consumer_id returned
```

#### Event Grid: Subscription Listener

The CDP registers as a subscriber to Azure Event Grid topics. An Event Grid listener worker (BullMQ-backed) receives pushed events, maps them to the CDP event schema, and routes through the standard pipeline. Event Grid provides at-least-once delivery with built-in retry.

#### Bulk Manual Upload: UI-Driven

`POST /api/v1/ingest/upload` (multipart form) from the CDP frontend. File lands in S3-compatible storage. A BullMQ worker processes row-by-row. Status tracking: `GET /api/v1/ingest/upload/{id}` returns progress, success/error counts, and `consumer_id` mapping per row.

#### Batch Ingestion: Scheduled Pull

A configurable scheduled worker connects to external data sources (database via connection string, FTP/SFTP via credentials, REST API via endpoint + auth). Pulls new/changed records since last sync (using timestamps or change tokens). Transforms to CDP event schema and processes through identity resolution. Schedule is configurable per source.

#### Resolution Types (All Sources)

| resolution | Meaning | Latency |
|------------|---------|---------|
| direct | `consumer_id` provided and valid. No resolution. | <5ms |
| redirected | `consumer_id` was merged. Linked to survivor. New ID returned. | <10ms |
| matched | Identifiers matched existing consumer. | 30–50ms |
| created | No match. New consumer created. | 30–50ms |
| conflict | Identifiers match different consumers. Flagged for review. | 30–50ms |

### 5.3 Outbound: Event Grid Publishing (Prepped for Phase 2)

The CDP will also publish events to Azure Event Grid, enabling downstream systems to react to CDP state changes (e.g., new consumer created, consumer merged, identity resolved, consent changed). In the MVP, the publishing infrastructure is built and wired but no events are actually sent.

#### What's Built in MVP

- An `EventPublisher` service with a `publish(topic, eventType, payload)` method that accepts any CDP event and formats it as a CloudEvents-compliant message.
- A configuration system for registering outbound Event Grid topics (topic URL, access key, enabled/disabled flag).
- Hook points inside the identity resolution pipeline, merge service, and consent service where `publish()` calls are placed but disabled via config (`enabled: false`).
- An `outbound_event_log` table that records every event the CDP would publish (topic, event type, payload, timestamp, status: 'pending'/'sent'/'disabled'). In MVP, all entries are logged with `status='disabled'`.

#### Event Types (Ready to Activate in Phase 2)

| Event Type | Trigger | Payload |
|------------|---------|---------|
| consumer.created | New consumer created via identity resolution | consumer_id, dealership_id, identifiers |
| consumer.merged | Two consumers merged (manual or automatic) | surviving_id, merged_id, match_rule |
| consumer.updated | Consumer profile or attributes changed | consumer_id, changed_fields |
| identity.resolved | Event successfully linked to a consumer | event_id, consumer_id, resolution_type |
| consent.changed | Consent granted, denied, or withdrawn | consumer_id, dealership_id, consent_type, new_status |

#### Phase 2 Activation

To start publishing: set `enabled: true` in the Event Grid topic config. The hook points, CloudEvents formatting, and outbound log are already in place. No code changes required — config-only activation.

## 6. Database Schema

19 tables total. 11 core + 4 AI/ML (empty in MVP) + 4 supporting. The 27 data points map to `consumer`, `vehicle`, `consumer_vehicle`, and `consumer_attribute` tables.

### 6.1 Core Tables

| Table | Purpose |
|-------|---------|
| dealership | Client tenants. id, name, code, status, config. |
| consumer | Golden record. first/last name, primary_email/phone, confidence_score. |
| consumer_dealership | Multi-tenant M:N join. consumer_id, dealership_id, external_id, relationship. |
| consumer_attribute | EAV for fields 14–27 + any extensible attrs. dealership_id scoped, is_shared flag. |
| vehicle | Fields 5–13. vin (unique), year, make, model, trim, mileage, condition. |
| consumer_vehicle | Links consumers to vehicles. purchase_date, purchase_price in metadata. |
| identity | Identity graph nodes. identifier_type, normalized_value, confidence. |
| identity_link | Graph edges. link_type includes ML types for Phase 2. |
| event | All ingested events. JSONB identifiers + properties. resolution_type + consumer_id. |
| consent | Per consumer per dealer. consent_type, status (granted/denied/withdrawn). |
| merge_history | Audit trail. surviving_id, merged_id, snapshot in JSONB, match_rule. |

### 6.2 AI/ML Tables (Empty in MVP)

| Table | Phase 2 Usage |
|-------|---------------|
| ml_match_score | ML confidence scores, feature vectors, decisions from classifier. |
| consumer_embedding | 128-dim vectors (pgvector) for ANN similarity search. |
| ml_model_registry | ONNX model versioning, metrics, staging/production lifecycle. |
| match_review_queue | Manual conflict review in MVP. AI fills it in Phase 2. |

### 6.3 Row-Level Security

Enabled on all dealership-scoped tables. `SET LOCAL` per request. DAS admin bypasses all. Dealers see own data + shared attributes only.

## 7. Identity Resolution

### 7.1 Flow

```
Event arrives
  │
  ├─ consumer_id in request?
  │   YES → validate consumer exists
  │         Active → link directly (resolution='direct', <5ms) → DONE
  │         Merged → follow chain → return survivor (resolution='redirected') → DONE
  │         Invalid → fall through to resolution
  │   NO → continue
  │
  ├─ Normalize identifiers (email, phone, VIN)
  ├─ Exact lookup in identity table
  │
  ├─ All match same consumer → link (resolution='matched')
  ├─ No match → create consumer + identities (resolution='created')
  ├─ Match different consumers → review queue (resolution='conflict')
  │
  └─ Return consumer_id in response (caller caches for fast path)

  PHASE 2 EXTENSION: If no match → tierTwoResolver() (stubbed in MVP)
```

### 7.2 Merge / Unmerge

Single transaction: re-point all child records, set `status='merged'`, store snapshot. Unmerge reverses from snapshot. All audited in `merge_history`.

## 8. Frontend (MVP)

| Page | Route | Role | Description |
|------|-------|------|-------------|
| Login | `/login` | All | OIDC sign-in (any provider) |
| DAS Dashboard | `/dashboard` | DAS admin | Consumer count, dealers, events today, pending reviews |
| Consumer List | `/dashboard/consumers` | DAS admin | Search, sort, paginate, filter by dealership |
| Consumer 360° | `/dashboard/consumers/[id]` | DAS admin | Tabs: overview (27 data points), attributes, vehicles, events, consent, history |
| Review Queue | `/dashboard/reviews` | DAS admin | Pending conflicts from identity resolution |
| Review Detail | `/dashboard/reviews/[id]` | DAS admin | Side-by-side profiles. Merge / Reject / Skip. |
| Dealerships | `/dashboard/dealerships` | DAS admin | CRUD for dealerships |
| Dealer Home | `/dealer` | Dealer user | Scoped KPIs + quick links |
| Dealer Consumers | `/dealer/consumers` | Dealer user | Scoped consumer list + profile (own attrs + shared) |

### 8.1 Consumer 360° — 27 Data Points Display

The consumer profile page organizes the 27 data points into the 5 categories from Section 2. Each section is a collapsible card:

- **Vehicle & Owner Info:** Name, email, phone, vehicle details (year/make/model/trim/VIN), purchase date, mileage, price, condition.
- **Service & Parts:** OEM maintenance schedule, completed/declined services, open/completed recalls.
- **Service History:** Service records with media, coupons, plan offerings.
- **Vehicle Protection:** Warranty and service plan offerings.
- **Equity & Insurance:** Equity amount, market value, upgrade options, insurance provider, quote list.

### 8.2 Design

- Dark navy sidebar (#1B3A5C), white content, blue accents (#2E75B6). shadcn/ui only.
- Responsive. TanStack Table with server-side pagination. TanStack Query for all API calls.

## 9. Multi-Tenancy & Access Control

| Role | Scope | Access |
|------|-------|--------|
| das_admin | Global | All consumers, all attributes (all 27 data points), all dealerships. Full CRUD. |
| das_analyst | Global | Read-only across all. Match review access. |
| dealer_admin | One dealership | Own consumers, own attributes + shared. CRUD on own data. |
| dealer_user | One dealership | Same as dealer_admin but read-only. |

Three enforcement layers: PostgreSQL RLS (`SET LOCAL` per request), API middleware (JWT role extraction), Frontend route guards.

## 10. Implementation Stages

The MVP is delivered in 4 sequential stages. Stage 1 is planning and environment setup. Stages 2–4 are build, using Claude Code for accelerated development.

### Stage 1 — Planning, Review & AI Workspace Setup

No production code is written in Stage 1. This stage ensures the team is aligned on scope, the architecture is validated, and the AI-assisted development environment is fully configured so Stages 2–4 start at full speed.

#### MVP Review & Architecture Decisions

- Walk through this MVP spec with all stakeholders. Confirm the 27 data points are correct and complete. Identify any missing fields or data source nuances.
- Architecture deep-dive: review the 4-layer architecture, container strategy, and database schema. Confirm PostgreSQL + Drizzle ORM + RLS approach.
- Decide on OIDC provider for auth (Keycloak, Auth0, Azure Entra, etc.). Decide on production S3 target (Cloudflare R2, Azure Blob, AWS S3).
- Confirm the 4 roles (das_admin, das_analyst, dealer_admin, dealer_user). Map each role to specific API endpoints and UI pages. Review RLS policy logic.

#### Data Source Mapping

- For each ingestion source (Webhook, Event Grid, Bulk Upload, Batch Pull): document the exact API format / file format, authentication method, and field-by-field mapping to the 27 data points.
- Classify each source's expected inputs for MVP testing.
- Identify which `consumer_attribute` fields are shared (visible cross-dealer) vs. dealer-scoped (private to contributing dealership).
- Document any data transformation rules specific to each source (e.g., DMS date formats, Meta lead field names).

#### AI Development Environment Setup

Set up the collaborative AI coding environment so every developer starts Stage 2 with Claude Code fully configured and productive from the first prompt.

- Provision GitHub repository. Initialize the empty monorepo structure (directories only, no code). Set up branch protection rules (main requires PR + passing CI).
- Set up CI/CD skeleton: GitHub Actions workflow files for lint, type-check, test, build, and Docker image push to Azure Container Registry (ACR). Coordinate with DAS DevOps on AKS namespace, ingress, and secrets configuration.
- Configure OIDC provider for the dev environment. Create test users for each role (das_admin, dealer_admin, dealer_user). Document the login flow.
- Create and commit the `CLAUDE.md` project file — the most important file for AI-assisted development. Gives Claude Code full project context (architecture, tech stack, conventions, database schema, 27 data points, multi-tenancy rules, code style).
- Create Claude Code slash commands in `.claude/commands/`: `/task` (execute a coding plan task), `/verify` (check acceptance criteria), `/phase-check` (integration gate between stages).
- Create Claude Code skills in `.claude/skills/` for domain-specific guidance: `identity-resolution/SKILL.md` (matching rules, normalization specs), `data-model/SKILL.md` (27 data points, EAV pattern, JSONB structure), `multi-tenancy/SKILL.md` (RLS patterns, role definitions, scoping rules).
- Set up each developer's Claude Code workspace: clone repo, verify `CLAUDE.md` loads on startup, test slash commands work, verify Docker Compose starts clean.
- Create the seed data specification: define the exact 3 dealerships, 50 consumers, 30 vehicles, and 200 events that will be used for development and testing.
- Prepare the task backlog: break the Stage 2–4 coding plan into individual tasks, each formatted as a `/task` prompt ready to copy-paste into Claude Code.

#### Stage 1 Deliverable

Signed-off data model with field mappings per source. OIDC provider configured with test users. GitHub repo with CI skeleton. `CLAUDE.md`, slash commands, and skills committed. Every developer's Claude Code workspace tested and ready. Task backlog prepared. Zero ambiguity going into build.

### Stage 2 — Foundation + Database + API

- Monorepo scaffold (pnpm, TS, ESLint, vitest). Docker Compose (PG+Redis+MinIO). Package scaffolds (shared, api, workers, ml, web).
- All 19 database migrations + runner. pgvector, pg_trgm. RLS policies on all dealership-scoped tables.
- Shared package: Drizzle schema (all 19 tables), Zod validators (27 data points), TypeScript types. DB client + RLS session helpers.
- Express API scaffold + OIDC auth middleware + tenant context middleware. Normalization library (email, phone, VIN, address, name) with tests.
- CRUD routes: dealerships, consumers (with 27 data points), vehicles. Webhook ingestion endpoint (`POST /api/v1/events` with `consumer_id` return). Unit tests.

#### Stage 2 Deliverable

`docker-compose up` starts the system. API serves CRUD for all entities with RLS. Events ingest with `consumer_id` fast-path. 19 tables. Tests pass.

### Stage 3 — Identity Resolution + Ingestion + Frontend Core

- Identity service (upsert, lookup, link). Deterministic resolver with fast-path (`consumer_id` direct → merged redirect → full resolution). Merge/unmerge service.
- Ingestion channels: Webhook endpoint (`POST /api/v1/events` with `consumer_id` return), Event Grid subscription listener worker, Bulk upload endpoint + S3 worker, Batch pull scheduler skeleton. Seed script (3 dealers, 50 consumers, 30 vehicles, 200 events). Integration tests.
- Next.js app shell + NextAuth OIDC. Login page. Route guards. API client + TanStack Query hooks for all endpoints.
- DAS layout (sidebar, topbar, nav). Consumer list (search, sort, paginate, filter). Consumer 360° profile page (27 data points organized in 5 category cards + events/consent/history tabs).
- Dealer portal layout + scoped views. Dealership CRUD page. DAS dashboard (KPI cards). Dockerize frontend container.

#### Stage 3 Deliverable

Identity resolution works (deterministic + fast path). All 4 ingestion channels functional (webhook, Event Grid, bulk upload, batch pull). Full frontend: consumer search, 360° profiles with all 27 data points, dealer portal.

### Stage 4 — Review UI + Containers + Ship

- Match review queue page. Review detail (side-by-side comparison). Merge/reject actions.
- Consumer attribute editing (27 data points). Consent management in profile. Polish all frontend pages.
- Event Grid outbound publishing infrastructure (`EventPublisher` service, hook points, `outbound_event_log` table — disabled via config for MVP).
- NGINX reverse proxy. Full Docker Compose (6 containers end-to-end). Multi-stage Dockerfiles.
- Kubernetes deployment manifests for DAS DevOps' existing AKS cluster (new namespace). GitHub Actions CI/CD (test → build → push to ACR → deploy to AKS).
- End-to-end testing. Bug fixes. README documentation. Final seed data validation. Demo prep.

#### Stage 4 Deliverable

Complete MVP. Review UI. Event Grid outbound prepped. 6 containers in Docker Compose. K8s manifests ready for DAS AKS. CI/CD deploys to ACR + AKS. Ready for pilot deployment.

## 11. Phase 2 Roadmap (Post-MVP)

Every Phase 2 feature plugs into MVP extension points:

| Feature | MVP Extension Point | Effort |
|---------|---------------------|--------|
| Event Grid Publishing | Set `enabled: true` in topic config. Hook points + outbound log already built. | Days (config only) |
| Tier 2 ML Classifier | `resolver.ts`: call `tierTwoResolver()` after Tier 1 miss | 2–3 weeks |
| Tier 3 Embeddings + GNN | Batch job writes to `consumer_embedding` table | 3–4 weeks |
| LLM Match Review | `match_review_queue`: LLM processes pending items | 1–2 weeks |
| Audience Builder | New API routes + frontend page | 2 weeks |
| Analytics Dashboard | New API routes + Recharts pages | 1–2 weeks |
| Data Redaction / Deletion | New API routes + frontend page | 1–2 weeks |
| Kafka / Event Streaming | Swap BullMQ for Kafka consumer (same interface) | 1 week |
| Website Pixel / SDK | New JS SDK that calls existing `POST /api/v1/events` | 1 week |
| Additional Data Points | Add to `consumer_attribute` — no schema migration | Days per field |

### Full Architecture Reference

The v3.0 Architecture Plan covers all Phase 2 features: three-tier AI matching, LLM integration, embeddings, GNN, full Kubernetes topology, analytics, and data management.

---

End of MVP Specification
