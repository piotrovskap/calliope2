---
source: DAS Technology (internal spec)
version: v3
date: March 2026
type: source-doc
original: das-cdp-architecture-plan-v3.docx
---

> Original: [das-cdp-architecture-plan-v3.docx](/artifacts/phase-0/source-docs/das-cdp-architecture-plan-v3.docx) — this markdown is the processed/machine-readable form.

# DAS Technology — Customer Data Platform: Architecture Plan, Technology Stack & Database Schema

> With AI-Enhanced Identity Resolution & Full-Stack UI
>
> Target Cloud: Microsoft Azure
>
> Scale: 10–50M Consumers | 100–500 Dealerships
>
> Backend: TypeScript / Node.js | Frontend: Next.js 15 + shadcn/ui
>
> March 2026 | Version 3.0 | CONFIDENTIAL

## Table of Contents

1. Executive Summary
2. High-Level Architecture
3. Technology Stack
4. Database Schema — Core Entities
5. AI-Enhanced Identity Resolution & Identity Graph
   - 5.1 Three-Tier AI Matching Architecture
   - 5.2 ML Pairwise Classifier (Tier 2)
   - 5.3 Entity Embeddings & Graph Neural Network (Tier 3)
   - 5.4 LLM-Assisted Matching for Edge Cases
   - 5.5 End-to-End AI Resolution Pipeline
   - 5.6 Training Pipeline & Data Flywheel
   - 5.7 Identity Graph Storage
   - 5.8 Merge / Unmerge Workflow
6. Database Schema — AI & ML Tables
7. Multi-Tenancy & Access Control
8. Event Ingestion Pipeline
9. Frontend Architecture & UI
   - 9.1 Technology Choices
   - 9.2 Application Structure
   - 9.3 UI Modules & Pages
   - 9.4 DAS Admin Dashboard
   - 9.5 Dealer Portal
   - 9.6 Consumer 360° Profile
   - 9.7 Match Review & Merge Resolution
   - 9.8 Audience Builder
   - 9.9 Data Management (Redaction & Deletion)
   - 9.10 Analytics & ML Model Monitoring
10. Privacy, Security & Compliance
11. Deployment Architecture (Azure)
12. Implementation Roadmap

## 1. Executive Summary

This document defines the architecture, technology choices, and database schema for the DAS Technology Customer Data Platform (CDP). The CDP serves as the central system of record for consumer, vehicle, and event data across all client dealerships in a multi-tenant environment. Version 2.0 integrates a comprehensive AI-enhanced identity resolution system that significantly improves match rates, reduces manual review, and continuously learns from data.

### Key Design Principles

- **Multi-tenant isolation:** Each dealership sees only its own consumers and the attributes it contributed, while DAS Technology maintains a global, unified view.
- **AI-first identity resolution:** A three-tier matching architecture combining deterministic rules, ML pairwise classifiers (XGBoost/ONNX), consumer embeddings with vector search, graph neural networks, and LLM-assisted review delivers 88–95% match rates with 98–99.5% precision.
- **Event-driven pipelines:** All data flows through a unified ingestion pipeline with real-time and batch paths, ensuring normalization and identity resolution before storage.
- **Privacy-by-design:** PII is encrypted and tokenized, consent is tracked per consumer per dealership, and row/column-level security enforces tenant boundaries.
- **Azure-native deployment:** Leveraging Azure's managed services for compute, storage, streaming, ML, and security while keeping the application layer portable via TypeScript/Node.js.
- **Continuous learning flywheel:** Human review decisions, LLM judgments, and confirmed merges feed back into ML model training, driving ongoing accuracy improvements with decreasing manual effort.
- **Full-stack user experience:** A Next.js 15 frontend provides a DAS admin dashboard with global KPIs, match review workbench, audience builder, and data management tools, plus a separate dealer portal with scoped consumer views — all enforcing the same multi-tenant security model as the API.

## 2. High-Level Architecture

The CDP is decomposed into seven architectural layers, each with clear responsibilities and bounded interfaces.

### Layer 1 — Ingestion Layer

Accepts data from dealership sources (DMS, CRM, websites, call tracking), third-party integrations (ad platforms, OEMs, data providers), and internal systems via REST APIs, webhooks, and file uploads. All inbound data lands on Azure Event Hubs for real-time streams and Azure Blob Storage for batch files.

### Layer 2 — Processing Layer

Consumes raw events from Event Hubs via containerized Node.js workers running as Kubernetes Deployments on AKS. KEDA (Kubernetes Event-Driven Autoscaler) scales worker pods based on Event Hubs consumer group lag. Performs schema validation, data normalization (phone/email/address/VIN standardization), and PII tokenization. Resolved events are then routed to the identity resolution engine.

### Layer 3 — AI Identity Resolution Layer

The core intelligence of the CDP. A three-tier matching engine resolves incoming identifiers to existing consumer profiles. Tier 1 performs deterministic exact matching in real-time (<50ms). Tier 2 invokes an ML pairwise classifier (XGBoost model served as ONNX in Node.js) for fuzzy matching on blocking candidates. Tier 3 runs nightly batch jobs using consumer embeddings (128-dimensional vectors with ANN search) and a Graph Neural Network (GraphSAGE) to discover transitive and latent identity clusters. Ambiguous cases are triaged by an LLM co-pilot (Azure OpenAI GPT-4o) before escalation to human reviewers.

### Layer 4 — Storage Layer

The canonical CDP datastore. Azure Database for PostgreSQL (Flexible Server) serves as the primary OLTP store — this remains a managed PaaS service outside Kubernetes for operational simplicity and enterprise-grade HA. pgvector extension stores consumer embeddings for ANN search. Azure Synapse Analytics provides the analytical layer for audience building, reporting, and 360-degree profile queries. Azure Cosmos DB (Gremlin API) stores the identity graph for low-latency traversals. Redis runs as a StatefulSet inside the AKS cluster for low-latency feature caching, with Azure Cache for Redis as a managed fallback.

### Layer 5 — ML Training & Model Management Layer

Azure Machine Learning manages the training pipeline for the pairwise classifier, embedding model, and GNN. Models are trained in Python, exported as ONNX artifacts, and served in the Node.js runtime. An active learning loop continuously improves model quality using human review decisions and LLM judgments as training signals. Model versions, metrics, and deployment state are tracked in the `ml_model_registry` table.

### Layer 6 — Activation & API Layer

A TypeScript/Node.js API running as a Kubernetes Deployment on AKS, exposed via an NGINX Ingress Controller with TLS termination. Horizontal Pod Autoscaler (HPA) scales API pods based on CPU utilization and request rate. The API exposes RESTful and GraphQL endpoints for profile lookups, audience queries, event ingestion, match review, and admin operations. Multi-tenant authorization is enforced here via middleware. Outbound activation pushes segments and profiles to downstream systems (ad platforms, email, CRM) via Azure Event Hubs or direct API calls.

### Layer 7 — Frontend (UI) Layer

A Next.js 15 application (App Router with React Server Components) containerized and deployed as a Kubernetes Deployment on AKS in a dedicated 'frontend' namespace. Exposed through the same NGINX Ingress Controller as the API, with path-based routing (`/` → frontend, `/api` → API). HPA scales frontend pods based on CPU. Provides two role-based portals: (1) the DAS Admin Dashboard for global operations including consumer 360° profiles, match review workbench, audience builder, analytics dashboards, data management (PII redaction and deletion), and ML model monitoring; (2) the Dealer Portal for per-dealership scoped views of consumers, vehicles, and events. Built with shadcn/ui and Tailwind CSS for a consistent, professional UI. Authentication via NextAuth.js v5 integrated with Azure Entra ID, enforcing the same RBAC roles as the API layer. All data access is mediated through the API — the frontend never connects directly to the database.

### Data Flow Summary

```
Sources → Ingestion (Event Hubs / Blob) → Processing (Functions / Workers) → AI Identity Resolution (Tier 1→2→3) → PostgreSQL + Cosmos DB → Synapse (Analytics) → API Layer → Frontend (Next.js) + Activation / Exports
```

### Architecture Diagram

The following diagram illustrates all six layers, the three-tier AI identity resolution engine, data stores, ML training loop, and activation targets.

## 3. Technology Stack

The following table summarizes the recommended technology for each component. All application workloads (API, workers, ML inference, frontend) are containerized and deployed on Azure Kubernetes Service (AKS) for unified orchestration, scaling, and operations.

| Component | Technology | Azure Service | Rationale |
|-----------|------------|---------------|-----------|
| Container Orchestration | Kubernetes 1.29+ | Azure Kubernetes Service (AKS) | Unified platform for all containerized workloads: API, workers, ML inference, frontend. Managed control plane, autoscaling, rolling deployments. |
| Primary Database (OLTP) | PostgreSQL 16 + pgvector | Azure Database for PostgreSQL Flexible Server | RLS, JSONB, pgvector for embeddings, strong TypeScript drivers. Managed — not containerized. |
| Identity Graph Store | Cosmos DB (Gremlin API) | Azure Cosmos DB | Low-latency graph traversals; GNN export source. Managed PaaS. |
| Analytical Warehouse | Synapse SQL (Serverless) | Azure Synapse Analytics | Audience building, 360° queries, reporting at scale. Managed PaaS. |
| Streaming / Messaging | Kafka protocol | Azure Event Hubs (Kafka surface) | Unified real-time ingestion bus; portable app code. Managed PaaS. |
| Batch File Storage | Parquet / CSV on blob | Azure Blob Storage (ADLS Gen2) | Landing zone for batch imports and Synapse external tables. |
| API Server | TypeScript / Node.js (Docker) | AKS Deployment + Service | Express API in container. HPA scales on CPU/request rate. Ingress via NGINX or Istio. |
| Event Workers | TypeScript / Node.js (Docker) | AKS Deployment (workers pool) | Event Hubs consumers. HPA scales on consumer lag (KEDA). Dedicated node pool. |
| Batch Jobs | TypeScript / Node.js (Docker) | AKS CronJob / Job | Nightly resolution, embedding computation, LLM review. K8s Jobs with TTL cleanup. |
| ML Model Serving | ONNX Runtime (Node.js, Docker) | AKS Deployment (ml pool) | Pairwise classifier + embeddings. Separate node pool with optional GPU for Tier 3. |
| ML Training | Python + XGBoost + PyTorch | Azure Machine Learning | Train classifiers, embeddings, GNN offline. Managed compute — not on AKS. |
| GNN Processing | PyTorch Geometric | Azure ML Compute (GPU) | Nightly GraphSAGE inference on identity graph. Managed GPU. |
| Vector Search (Alt.) | Azure AI Search (HNSW) | Azure AI Search | ANN search over 50M embeddings (alternative to pgvector). |
| LLM Review Co-Pilot | GPT-4o | Azure OpenAI Service | Intelligent triage for ambiguous match decisions. Managed PaaS. |
| Feature Cache | Redis 7 (Docker) | AKS StatefulSet or Azure Cache for Redis | In-cluster Redis for low latency; Azure managed Redis as fallback. |
| Ingress / API Gateway | NGINX Ingress + cert-manager | AKS Ingress Controller | TLS termination, rate limiting, path-based routing. Azure APIM optional outer gateway. |
| Service Mesh (optional) | Istio or Linkerd | AKS add-on | mTLS between services, traffic policies, observability. Phase 8 hardening. |
| Auth & Identity | OAuth 2.0 / OIDC | Azure Entra ID (B2C) | Dealership user auth, DAS admin auth, RBAC tokens. |
| Secrets Management | External Secrets Operator | Azure Key Vault + AKS CSI driver | Syncs Key Vault secrets into K8s Secrets. No secrets in env vars or code. |
| Monitoring | Prometheus + Grafana + OTel | AKS monitoring add-on + Azure Monitor | Prometheus scrapes pods, Grafana dashboards, OpenTelemetry for traces. |
| Logging | Fluent Bit (DaemonSet) | Azure Log Analytics | Pod logs collected by Fluent Bit, shipped to Log Analytics workspace. |
| CI/CD | GitHub Actions + Helm | GitHub Actions + ACR + AKS | Build images → push ACR → Helm upgrade on AKS. ArgoCD optional for GitOps. |
| Infrastructure as Code | Terraform | Azure Resource Manager | AKS cluster, node pools, managed services, networking. Reproducible. |
| Frontend (Next.js) | Next.js 15 (Docker) | AKS Deployment + Ingress | Containerized SSR frontend. Same cluster, separate namespace. HPA on CPU. |
| UI Components | shadcn/ui + Tailwind CSS 4 | — | Accessible, composable primitives; utility-first styling. |
| Frontend State | TanStack Query + React Hook Form | — | Server cache, mutations, form state; Zod schema sharing. |
| Frontend Auth | NextAuth.js v5 | Azure Entra ID (B2C) | OAuth/OIDC flow, session management, role-based route guards. |
| Data Tables | TanStack Table | — | Headless, sortable, paginated tables for consumer/review lists. |
| Charts | Recharts | — | Declarative React charting for dashboards and analytics. |

## 4. Database Schema — Core Entities

The schema is designed around a central `consumer` entity with satellite tables for multi-valued attributes, vehicle ownership, dealership tenancy, events, and identity links. All tables include `dealership_id` where applicable to support PostgreSQL row-level security. AI/ML-specific tables are in Section 6.

### 4.1 Entity Relationship Overview

- **consumer** — The golden record for a resolved person. One row per unique individual.
- **dealership** — A client tenant. Each dealership is an isolated tenant.
- **consumer_dealership** — Many-to-many join linking consumers to dealerships.
- **consumer_attribute** — EAV-style table for multi-valued, dealership-scoped attributes.
- **vehicle** — Individual vehicle records identified by VIN.
- **consumer_vehicle** — Many-to-many join linking consumers to vehicles, scoped by dealership.
- **identity** — All known identifiers for a consumer forming the identity graph.
- **identity_link** — Edges in the identity graph connecting identities to the same consumer.
- **event** — Raw and resolved events from all sources.
- **consent** — Per-consumer, per-dealership consent records.
- **merge_history** — Audit trail of consumer merge/unmerge operations.

### 4.2 Core Tables — SQL DDL

#### dealership

```sql
CREATE TABLE dealership (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name            TEXT NOT NULL,
  code            TEXT NOT NULL UNIQUE,
  status          TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active','suspended','inactive')),
  config          JSONB DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

#### consumer

```sql
CREATE TABLE consumer (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  status          TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active','merged','deleted')),
  merged_into_id  UUID REFERENCES consumer(id),
  first_name      TEXT,
  last_name       TEXT,
  primary_email   TEXT,
  primary_phone   TEXT,
  date_of_birth   DATE,
  gender          TEXT,
  address_line1   TEXT,
  address_line2   TEXT,
  city            TEXT,
  state           TEXT,
  zip             TEXT,
  country         TEXT DEFAULT 'US',
  metadata        JSONB DEFAULT '{}',
  confidence_score NUMERIC(3,2) DEFAULT 1.00,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_consumer_email ON consumer (primary_email);
CREATE INDEX idx_consumer_phone ON consumer (primary_phone);
CREATE INDEX idx_consumer_name ON consumer (last_name, first_name);
CREATE INDEX idx_consumer_merged ON consumer (merged_into_id) WHERE merged_into_id IS NOT NULL;
```

#### consumer_dealership

```sql
CREATE TABLE consumer_dealership (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_id     UUID NOT NULL REFERENCES consumer(id),
  dealership_id   UUID NOT NULL REFERENCES dealership(id),
  external_id     TEXT,
  relationship    TEXT DEFAULT 'prospect' CHECK (relationship IN
                    ('prospect','lead','customer','service','inactive')),
  first_seen_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_seen_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  metadata        JSONB DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (consumer_id, dealership_id)
);

CREATE INDEX idx_cd_dealership ON consumer_dealership (dealership_id);
CREATE INDEX idx_cd_consumer ON consumer_dealership (consumer_id);
CREATE INDEX idx_cd_external ON consumer_dealership (dealership_id, external_id);
```

#### consumer_attribute

```sql
CREATE TABLE consumer_attribute (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_id     UUID NOT NULL REFERENCES consumer(id),
  dealership_id   UUID REFERENCES dealership(id),
  attribute_name  TEXT NOT NULL,
  attribute_value TEXT NOT NULL,
  normalized_value TEXT,
  source          TEXT NOT NULL,
  source_type     TEXT DEFAULT 'first_party' CHECK (source_type IN
                    ('first_party','third_party','derived')),
  is_primary      BOOLEAN DEFAULT false,
  is_shared       BOOLEAN DEFAULT false,
  confidence      NUMERIC(3,2) DEFAULT 1.00,
  valid_from      TIMESTAMPTZ DEFAULT now(),
  valid_to        TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_ca_consumer ON consumer_attribute (consumer_id);
CREATE INDEX idx_ca_dealer ON consumer_attribute (dealership_id);
CREATE INDEX idx_ca_lookup ON consumer_attribute (attribute_name, normalized_value);
CREATE INDEX idx_ca_shared ON consumer_attribute (consumer_id) WHERE is_shared = true;
```

#### vehicle

```sql
CREATE TABLE vehicle (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  vin             TEXT UNIQUE,
  year            INTEGER,
  make            TEXT,
  model           TEXT,
  trim            TEXT,
  exterior_color  TEXT,
  interior_color  TEXT,
  mileage         INTEGER,
  vehicle_type    TEXT CHECK (vehicle_type IN ('new','used','cpo')),
  status          TEXT DEFAULT 'active' CHECK (status IN ('active','sold','traded','inactive')),
  metadata        JSONB DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_vehicle_vin ON vehicle (vin);
CREATE INDEX idx_vehicle_ymm ON vehicle (year, make, model);
```

#### consumer_vehicle

```sql
CREATE TABLE consumer_vehicle (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_id     UUID NOT NULL REFERENCES consumer(id),
  vehicle_id      UUID NOT NULL REFERENCES vehicle(id),
  dealership_id   UUID REFERENCES dealership(id),
  ownership_type  TEXT DEFAULT 'owner' CHECK (ownership_type IN
                    ('owner','lessee','interested','traded_in','co_signer')),
  acquired_at     TIMESTAMPTZ,
  disposed_at     TIMESTAMPTZ,
  source          TEXT,
  metadata        JSONB DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (consumer_id, vehicle_id, dealership_id)
);

CREATE INDEX idx_cv_consumer ON consumer_vehicle (consumer_id);
CREATE INDEX idx_cv_vehicle ON consumer_vehicle (vehicle_id);
CREATE INDEX idx_cv_dealer ON consumer_vehicle (dealership_id);
```

#### identity

```sql
CREATE TABLE identity (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_id     UUID NOT NULL REFERENCES consumer(id),
  identifier_type TEXT NOT NULL,
  identifier_value TEXT NOT NULL,
  normalized_value TEXT NOT NULL,
  source          TEXT NOT NULL,
  dealership_id   UUID REFERENCES dealership(id),
  confidence      NUMERIC(3,2) DEFAULT 1.00,
  is_active       BOOLEAN DEFAULT true,
  first_seen_at   TIMESTAMPTZ DEFAULT now(),
  last_seen_at    TIMESTAMPTZ DEFAULT now(),
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX idx_identity_unique ON identity (identifier_type, normalized_value)
  WHERE is_active = true;
CREATE INDEX idx_identity_consumer ON identity (consumer_id);
CREATE INDEX idx_identity_lookup ON identity (identifier_type, normalized_value);
```

#### identity_link

```sql
CREATE TABLE identity_link (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  identity_a_id   UUID NOT NULL REFERENCES identity(id),
  identity_b_id   UUID NOT NULL REFERENCES identity(id),
  link_type       TEXT NOT NULL CHECK (link_type IN
                    ('deterministic','probabilistic','ml_confirmed','gnn_cluster',
                     'llm_confirmed','manual','third_party')),
  confidence      NUMERIC(3,2) NOT NULL,
  source          TEXT NOT NULL,
  model_version   TEXT,              -- ML model version that produced this link
  is_active       BOOLEAN DEFAULT true,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  deactivated_at  TIMESTAMPTZ,
  UNIQUE (identity_a_id, identity_b_id)
);

CREATE INDEX idx_il_a ON identity_link (identity_a_id) WHERE is_active = true;
CREATE INDEX idx_il_b ON identity_link (identity_b_id) WHERE is_active = true;
```

#### event

```sql
CREATE TABLE event (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_id     UUID REFERENCES consumer(id),
  dealership_id   UUID REFERENCES dealership(id),
  event_type      TEXT NOT NULL,
  event_source    TEXT NOT NULL,
  event_timestamp TIMESTAMPTZ NOT NULL,
  identifiers     JSONB DEFAULT '{}',
  properties      JSONB DEFAULT '{}',
  raw_payload     JSONB,
  session_id      TEXT,
  resolved_at     TIMESTAMPTZ,
  resolution_type TEXT,    -- 'deterministic','ml_pairwise','embedding_ann',
                          -- 'gnn_cluster','llm_assisted','unresolved'
  resolution_confidence NUMERIC(5,4),  -- ML confidence score
  model_version   TEXT,                 -- which model version resolved this
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_event_consumer ON event (consumer_id, event_timestamp DESC);
CREATE INDEX idx_event_dealer ON event (dealership_id, event_timestamp DESC);
CREATE INDEX idx_event_type ON event (event_type, event_timestamp DESC);
CREATE INDEX idx_event_unresolved ON event (id) WHERE consumer_id IS NULL;
```

#### consent

```sql
CREATE TABLE consent (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_id     UUID NOT NULL REFERENCES consumer(id),
  dealership_id   UUID REFERENCES dealership(id),
  consent_type    TEXT NOT NULL,
  status          TEXT NOT NULL CHECK (status IN ('granted','denied','withdrawn')),
  granted_at      TIMESTAMPTZ,
  withdrawn_at    TIMESTAMPTZ,
  source          TEXT NOT NULL,
  ip_address      TEXT,
  user_agent      TEXT,
  metadata        JSONB DEFAULT '{}',
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_consent_consumer ON consent (consumer_id, consent_type);
CREATE INDEX idx_consent_dealer ON consent (dealership_id);
```

#### merge_history

```sql
CREATE TABLE merge_history (
  id                    UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  surviving_consumer_id UUID NOT NULL REFERENCES consumer(id),
  merged_consumer_id    UUID NOT NULL REFERENCES consumer(id),
  action                TEXT NOT NULL CHECK (action IN ('merge','unmerge')),
  reason                TEXT,
  match_rule            TEXT,      -- 'deterministic','ml_pairwise','gnn_cluster','llm','manual'
  confidence            NUMERIC(5,4),
  model_version         TEXT,      -- ML model version if AI-triggered
  merged_by             UUID,
  merged_data           JSONB,
  llm_reasoning         TEXT,      -- LLM explanation if LLM-assisted
  created_at            TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_mh_surviving ON merge_history (surviving_consumer_id);
CREATE INDEX idx_mh_merged ON merge_history (merged_consumer_id);
```

## 5. AI-Enhanced Identity Resolution & Identity Graph

Traditional deterministic matching catches only 40–60% of true matches in automotive CDP data. The remaining 40–60% involve misspellings, data entry errors, outdated information, incomplete records, and cross-channel identity fragmentation. The CDP uses a three-tier AI matching architecture that achieves 88–95% match rates with 98–99.5% precision while minimizing manual review.

### Impact Projections

| Matching Approach | Match Rate | Precision | Manual Review Load |
|-------------------|------------|-----------|--------------------|
| Deterministic only | 40–55% | 99.5%+ | None |
| Deterministic + rules-based probabilistic | 60–75% | 95–98% | High (10–15% flagged) |
| Deterministic + ML-enhanced probabilistic | 80–90% | 97–99% | Low (2–5% flagged) |
| Full AI pipeline (embeddings + GNN) | 88–95% | 98–99.5% | Minimal (1–3% flagged) |

### 5.1 Three-Tier AI Matching Architecture

The system operates in three tiers. Tier 1 runs on every incoming event in real-time. Tiers 2 and 3 run as near-real-time and batch processes respectively.

#### Tier 1 — Deterministic + Normalized Matching (Real-Time, <50ms)

Exact matches on high-confidence identifiers after normalization. Confidence = 1.00. No ML model is invoked.

- **Email:** Lowercase, trim whitespace, remove "+" aliases (`john+promo@gmail.com` → `john@gmail.com`).
- **Phone:** Strip to E.164 format (`+1XXXXXXXXXX`). Remove extensions.
- **VIN:** Uppercase, validate 17-character format and check digit.
- **Dealer Customer ID:** Scoped match within the same dealership (`dealership_id` + `external_id`).

### 5.2 ML Pairwise Classifier (Tier 2 — Near-Real-Time)

When Tier 1 produces no match, the event is queued for Tier 2. A trained binary classifier scores candidate pairs.

#### Blocking / Candidate Generation

Comparing every incoming record against 50M consumers is infeasible. Blocking narrows candidates:

- **Block 1 — Phonetic Last Name + ZIP:** Soundex/Double Metaphone encoding + first 3 ZIP digits. ~50–200 candidates.
- **Block 2 — Email Domain + First Name Initial:** For partial email matches.
- **Block 3 — Phone Last 7 Digits:** Catches formatting differences and country code mismatches.
- **Block 4 — Address Trigram Similarity:** pg_trgm index on normalized address, filtering similarity > 0.3.
- **Block 5 — VIN Prefix (First 11 Characters):** Catches VIN transcription errors in the serial digits.

Blocks are evaluated in parallel. The union (typically <500 per record) is passed to the ML scorer.

#### Feature Engineering (20-Feature Vector)

| Feature | Type | Description |
|---------|------|-------------|
| email_jaro_winkler | Float [0,1] | Jaro-Winkler similarity between normalized emails |
| email_exact_match | Boolean | 1 if emails match exactly after normalization |
| phone_exact_match | Boolean | 1 if E.164 phones match |
| phone_last7_match | Boolean | 1 if last 7 digits match |
| first_name_jaro_winkler | Float [0,1] | Jaro-Winkler on first names |
| last_name_jaro_winkler | Float [0,1] | Jaro-Winkler on last names |
| name_soundex_match | Boolean | 1 if Soundex codes match for both names |
| address_trigram_sim | Float [0,1] | pg_trgm similarity on full normalized address |
| zip_match | Boolean | 1 if ZIP codes match |
| city_match | Boolean | 1 if cities match (after normalization) |
| state_match | Boolean | 1 if states match |
| dob_match | Boolean | 1 if dates of birth match |
| dob_partial_match | Boolean | 1 if month+day match but year differs |
| vin_similarity | Float [0,1] | Character-level similarity on VINs |
| shared_dealership_count | Integer | Number of dealerships both records appear in |
| shared_vehicle_count | Integer | Number of vehicles linked to both records |
| time_since_last_seen | Float | Days since existing consumer was last active |
| source_reliability | Float [0,1] | Historical accuracy score of the data source |
| identifier_overlap_count | Integer | Number of identity types that overlap |
| name_email_consistency | Float [0,1] | How well the name matches the email local part |

#### Model Architecture & Serving

The classifier is a gradient-boosted tree model (XGBoost or LightGBM) chosen for strong tabular performance, interpretability, and low inference latency (<5ms per pair). The trained model is exported as ONNX and served in TypeScript via `onnxruntime-node`.

- **Input:** 20-feature vector per candidate pair.
- **Output:** Probability [0.0, 1.0] that two records represent the same person.
- **Thresholds:** `>= 0.85` auto-merge | `0.60–0.85` flagged for LLM/human review | `< 0.60` non-match.
- **Retraining:** Monthly, or triggered when precision drops below 97% on the review queue.

```typescript
// TypeScript — ONNX model inference
import * as ort from 'onnxruntime-node';

const session = await ort.InferenceSession.create('./models/pairwise_v3.onnx');

async function scorePair(features: number[]): Promise<number> {
  const tensor = new ort.Tensor('float32', Float32Array.from(features), [1, 20]);
  const results = await session.run({ input: tensor });
  const probs = results['probabilities'].data as Float32Array;
  return probs[1]; // P(match)
}

async function resolveIdentity(incoming: IncomingRecord, candidates: Consumer[]) {
  const scored = await Promise.all(
    candidates.map(async (c) => ({
      consumer: c,
      score: await scorePair(computeFeatures(incoming, c)),
    }))
  );
  const best = scored.sort((a, b) => b.score - a.score)[0];

  if (best.score >= 0.85) return { action: 'auto_merge', consumer: best.consumer, confidence: best.score };
  if (best.score >= 0.60) return { action: 'review', consumer: best.consumer, confidence: best.score };
  return { action: 'create_new', consumer: null, confidence: 0 };
}
```

### 5.3 Entity Embeddings & Graph Neural Network (Tier 3 — Batch)

Tier 3 discovers identity clusters that pairwise comparison alone misses — particularly transitive matches (A matches B, B matches C, so A and C should be linked).

#### Consumer Embedding Model

Each consumer profile is encoded into a 128-dimensional dense vector. Consumers that are the same person have embeddings close together, even if raw attributes differ.

| Input Head | Architecture | Processes |
|------------|--------------|-----------|
| Name Head | Character-level CNN + BiLSTM | First/last name → handles misspellings, abbreviations, nicknames |
| Contact Head | Dense layers with learned hashing | Email, phone → tolerant to formatting variation |
| Address Head | Character-level CNN | Full address string → captures partial matches |
| Behavioral Head | Temporal attention network | Event types, frequencies, recency → behavioral patterns |
| Vehicle Head | Categorical embedding | VIN prefix, make/model/year → vehicle interest patterns |
| Graph Head | GNN message passing | Identity graph neighborhood → relational structure |

The six heads are concatenated and projected through a fusion layer. Trained with contrastive loss (NT-Xent/Triplet Loss). Positive pairs = known-same-consumer records; negatives = different consumers.

#### ANN Search

With 50M embeddings, the system uses an Approximate Nearest Neighbor index. Azure AI Search (HNSW index, up to 50M vectors) is the primary option; pgvector with IVFFlat is an alternative. Top-K (K=50) neighbors are retrieved in <10ms and confirmed by the Tier 2 pairwise classifier.

#### Graph Neural Network for Cluster Resolution

A 3-layer GraphSAGE model operates on the identity graph (exported nightly from Cosmos DB). Each identity node has features derived from its type, value, and consumer. The GNN learns node embeddings placing same-consumer identities close together. DBSCAN clustering on GNN embeddings detects cross-consumer clusters. Clusters with cohesion > 0.90 auto-merge; others queue for review.

### 5.4 LLM-Assisted Matching for Edge Cases

For the 2–5% of cases that fall into the review queue (Tier 2 score 0.60–0.85), an LLM co-pilot dramatically reduces manual review time.

#### How It Works

The system constructs a structured prompt with both consumer profiles and asks the LLM to reason about whether they represent the same person:

```typescript
// TypeScript — LLM identity review
import { OpenAIClient, AzureKeyCredential } from '@azure/openai';

const client = new OpenAIClient(
  process.env.AZURE_OPENAI_ENDPOINT!,
  new AzureKeyCredential(process.env.AZURE_OPENAI_KEY!)
);

async function llmReviewPair(
  a: ConsumerProfile, b: ConsumerProfile, mlScore: number
): Promise<{ decision: 'match'|'no_match'|'uncertain'; confidence: number; reasoning: string }> {
  const prompt = buildReviewPrompt(a, b, mlScore);
  const resp = await client.getChatCompletions('gpt-4o', [
    { role: 'system', content: IDENTITY_SYSTEM_PROMPT },
    { role: 'user', content: prompt },
  ], { temperature: 0.1, responseFormat: { type: 'json_object' } });
  return JSON.parse(resp.choices[0].message.content!);
}
```

#### LLM Use Cases

- **Name variations and nicknames:** "Bob" / "Robert", "Liz" / "Elizabeth", "J.R." / "James Robert".
- **Address normalization ambiguity:** "123 N Main St Apt 4B" vs. "123 North Main Street #4B".
- **Cross-language names:** Transliterations and cultural name order differences.
- **Explainable decisions:** Every LLM decision includes natural language reasoning stored in the audit trail.
- **Batch triage:** The LLM processes the entire review queue (100–500 pairs/day) overnight.

#### Safeguards

- The LLM never auto-merges. It confirms the ML score (triggering auto-merge) or escalates to human review.
- All LLM decisions are logged with full prompt, response, and reasoning.
- Human reviewers can override any LLM recommendation.
- Profiles are summarized (no raw PII tokens sent outside Azure boundary via Azure OpenAI).

### 5.5 End-to-End AI Resolution Pipeline

#### Real-Time Flow (Per Event)

```
Event Arrives (Event Hub)
    │
    ├─ Normalize identifiers (email, phone, VIN, address)
    │
    ├─ TIER 1: Deterministic lookup
    │     ├─ Match → Link event (confidence=1.0) → DONE
    │     └─ No match → Continue to Tier 2
    │
    ├─ TIER 2: ML Pairwise Scoring
    │     ├─ Generate blocking candidates (~50–200)
    │     ├─ Compute features + score with ONNX (<5ms/pair)
    │     ├─ Score >= 0.85 → Auto-merge → DONE
    │     ├─ Score 0.60–0.85 → Queue for LLM review
    │     └─ Score < 0.60 → Create new consumer → DONE
    │
    └─ LLM Review (async, within minutes)
          ├─ LLM confirms → Auto-merge
          ├─ LLM no_match → Keep separate
          └─ LLM uncertain → Human review queue
```

#### Batch Flow (Nightly)

```
Nightly Batch Job
    │
    ├─ TIER 3a: Re-embed consumers (delta since last run)
    │     ├─ Run embedding model on updated profiles
    │     └─ Update ANN index (Azure AI Search / pgvector)
    │
    ├─ TIER 3b: ANN similarity scan
    │     ├─ For each consumer, find top-K similar consumers
    │     ├─ Filter already-linked pairs
    │     └─ Score candidates with Tier 2 ML model
    │
    ├─ TIER 3c: GNN cluster detection
    │     ├─ Export identity graph from Cosmos DB
    │     ├─ Run GraphSAGE inference
    │     ├─ Cluster with DBSCAN
    │     └─ Identify cross-consumer clusters → merge candidates
    │
    └─ Process merge candidates
          ├─ High confidence (>0.90) → Auto-merge
          ├─ Medium confidence → LLM review → merge or escalate
          └─ Low confidence → Human review queue
```

### 5.6 Training Pipeline & Data Flywheel

#### Training Data Sources

- **Confirmed merges:** Historical `merge_history` records confirmed by humans (strong positives).
- **Confirmed non-matches:** Pairs reviewed and rejected (strong negatives).
- **Synthetic pairs:** Generated by applying realistic corruptions to known records (typos, field swaps, partial data). Augments early-stage training data.
- **Cross-dealership signals:** Same consumer appearing in multiple dealerships with slightly different data.

#### Active Learning Loop

1. ML model flags uncertain cases (score 0.60–0.85) for review.
2. Human reviewers or LLM-assisted review make match/no-match decisions.
3. Decisions are added to the training dataset.
4. Model is retrained monthly on the expanded dataset.
5. Precision/recall tracked on held-out test set. Alert triggers expedited retraining if precision < 97% or recall < 85%.
6. Over time, the model learns data quality patterns specific to each dealership and source, becoming increasingly accurate with less human intervention.

#### Model Versioning & Deployment

| Concern | Approach |
|---------|----------|
| Model registry | Azure ML stores versioned ONNX artifacts with training metadata and metrics. |
| A/B testing | Shadow scoring: new model scores alongside production before promotion. |
| Rollback | Previous 3 versions in registry. Instant rollback via config swap. |
| Monitoring | Track match rate, auto-merge rate, review queue size, precision@review, feature drift daily. |
| Bias detection | Monthly audit: ensure match rates consistent across demographics and regions. |

### 5.7 Identity Graph Storage

The relational `identity` and `identity_link` tables in PostgreSQL serve as the source of truth. For real-time graph traversals during identity resolution, a shadow copy is maintained in Azure Cosmos DB (Gremlin API), where each identity is a vertex and each link is an edge (including ML-generated links with their confidence scores and model versions). The Cosmos graph is synced from PostgreSQL every 5 minutes and on-demand during merge operations. The GNN batch job exports from Cosmos DB nightly.

### 5.8 Merge / Unmerge Workflow

- **Merge:** The lower-confidence record is marked `status='merged'` with `merged_into_id` pointing to the surviving record. All child records are re-pointed. A snapshot is stored in `merge_history` with the `match_rule` (deterministic, ml_pairwise, gnn_cluster, llm, manual), `model_version`, and `llm_reasoning` if applicable.
- **Unmerge:** Restores the `merged_data` snapshot, re-points child records, and clears `merged_into_id`.
- All operations are transactional and fully audited.

## 6. Database Schema — AI & ML Tables

These tables extend the core schema to support AI-based identity resolution, ML model management, and the human/LLM review workflow.

#### ml_match_score

```sql
CREATE TABLE ml_match_score (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  consumer_a_id     UUID NOT NULL REFERENCES consumer(id),
  consumer_b_id     UUID NOT NULL REFERENCES consumer(id),
  model_version     TEXT NOT NULL,
  score             NUMERIC(5,4) NOT NULL,
  feature_vector    JSONB NOT NULL,
  decision          TEXT NOT NULL CHECK (decision IN
                      ('auto_merge','review','no_match','llm_confirmed',
                       'llm_rejected','human_confirmed','human_rejected')),
  decided_by        TEXT,         -- 'system', 'llm', or user UUID
  llm_reasoning     TEXT,
  reviewed_at       TIMESTAMPTZ,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_mms_pair ON ml_match_score (consumer_a_id, consumer_b_id);
CREATE INDEX idx_mms_review ON ml_match_score (decision) WHERE decision = 'review';
CREATE INDEX idx_mms_model ON ml_match_score (model_version, created_at);
```

#### consumer_embedding

```sql
-- Requires: CREATE EXTENSION IF NOT EXISTS vector;

CREATE TABLE consumer_embedding (
  consumer_id       UUID PRIMARY KEY REFERENCES consumer(id),
  embedding         vector(128) NOT NULL,   -- pgvector extension
  model_version     TEXT NOT NULL,
  computed_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_ce_embedding ON consumer_embedding
  USING ivfflat (embedding vector_cosine_ops) WITH (lists = 1000);
```

#### ml_model_registry

```sql
CREATE TABLE ml_model_registry (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  model_name        TEXT NOT NULL,      -- 'pairwise_classifier', 'embedding_model', 'gnn'
  version           TEXT NOT NULL,
  artifact_path     TEXT NOT NULL,       -- blob storage path to ONNX file
  training_set_hash TEXT,
  metrics           JSONB NOT NULL,      -- { precision, recall, f1, auc }
  status            TEXT NOT NULL DEFAULT 'staging' CHECK (status IN
                      ('staging','production','retired')),
  promoted_at       TIMESTAMPTZ,
  retired_at        TIMESTAMPTZ,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (model_name, version)
);
```

#### match_review_queue

```sql
CREATE TABLE match_review_queue (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  ml_match_score_id UUID NOT NULL REFERENCES ml_match_score(id),
  consumer_a_id     UUID NOT NULL REFERENCES consumer(id),
  consumer_b_id     UUID NOT NULL REFERENCES consumer(id),
  priority          INTEGER DEFAULT 0,
  status            TEXT NOT NULL DEFAULT 'pending' CHECK (status IN
                      ('pending','in_progress','completed','expired')),
  assigned_to       UUID,
  assigned_at       TIMESTAMPTZ,
  completed_at      TIMESTAMPTZ,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_mrq_status ON match_review_queue (status, priority DESC);
```

## 7. Multi-Tenancy & Access Control

### 7.1 Tenancy Model

The CDP uses a shared-database, shared-schema multi-tenancy model. All dealerships share the same PostgreSQL database and tables, with tenant isolation enforced at the application and database level through row-level security (RLS) and application middleware.

### 7.2 Row-Level Security (PostgreSQL RLS)

Every table containing dealership-scoped data includes a `dealership_id` column. PostgreSQL RLS policies restrict visibility based on the current session's tenant context.

```sql
ALTER TABLE consumer_attribute ENABLE ROW LEVEL SECURITY;

CREATE POLICY dealer_attr_policy ON consumer_attribute
  FOR SELECT
  USING (
    dealership_id = current_setting('app.current_dealership_id')::UUID
    OR is_shared = true
    OR current_setting('app.user_role') = 'das_admin'
  );

CREATE POLICY das_admin_policy ON consumer_attribute
  FOR ALL
  USING (current_setting('app.user_role') = 'das_admin');

-- Set session context in application middleware
SET LOCAL app.current_dealership_id = '<dealer-uuid>';
SET LOCAL app.user_role = 'dealer_user';
```

### 7.3 Application-Level Authorization (RBAC)

Roles are embedded in the JWT token issued by Azure Entra ID:

| Role | Scope | Permissions |
|------|-------|-------------|
| das_super_admin | Global | Full read/write across all dealerships, system config, user management, ML model management. |
| das_analyst | Global | Read-only across all consumers, events. Access to match review queue and ML monitoring. |
| dealer_admin | Single Dealership | Manage users, view all consumers/attributes/events for their dealership. |
| dealer_user | Single Dealership | View consumers and attributes contributed by their dealership + shared attributes. |
| api_service | Single Dealership | Programmatic access for integrations; scoped to the dealership's data. |

### 7.4 Column-Level Security for Attributes

The `consumer_attribute` table's EAV design naturally provides column-level security. A dealership can only see attribute rows where `dealership_id` matches their own OR where `is_shared = true`. DAS Technology sees all attributes regardless.

### 7.5 Visibility Rules Summary

| Data | DAS Technology | Dealership (Own Data) | Other Dealerships |
|------|----------------|------------------------|--------------------|
| Consumer profile (golden record) | Full access | Visible if linked to dealer | Not visible |
| Attributes contributed by Dealer A | Full access | Visible to Dealer A only | Not visible |
| Shared 3rd-party attributes | Full access | Visible to all linked dealers | Visible to all linked dealers |
| Events from Dealer A's sources | Full access | Visible to Dealer A only | Not visible |
| Identity graph / ML match scores | Full access | Not directly exposed | Not directly exposed |
| Vehicles linked by Dealer A | Full access | Visible to Dealer A only | Not visible |
| Consent records for Dealer A | Full access | Visible to Dealer A only | Not visible |

## 8. Event Ingestion Pipeline

### 8.1 Pipeline Stages

1. **Ingest:** Events arrive via REST API (webhooks), SDK (JavaScript pixel on dealer websites), file upload (batch CSV/JSON), or direct Azure Event Hubs producers.
2. **Validate:** Schema validation against registered event contracts (JSON Schema). Malformed events routed to dead-letter topic.
3. **Normalize:** Standardize PII fields (phone → E.164, email → lowercase, address → USPS, VIN → uppercase + check digit). Tag with source and dealership metadata.
4. **AI Identity Resolution:** Extract identifiers, run through the three-tier AI matching pipeline (Tier 1 deterministic → Tier 2 ML pairwise → LLM review). Link to existing consumer or create new. Record `resolution_type`, `confidence`, and `model_version` on the event.
5. **Store:** Write resolved event to PostgreSQL `event` table and push to Azure Synapse (via Blob/Delta Lake) for analytics.
6. **Activate:** Trigger downstream actions: audience membership updates, lifecycle stage changes, real-time notifications, outbound syncs.

### 8.2 Event Schema Contract (JSON)

```json
{
  "event_id": "uuid",
  "event_type": "page_view | form_submit | phone_call | ...",
  "event_source": "website | dms | facebook | ...",
  "dealership_code": "SMITH_FORD_LA",
  "timestamp": "2026-03-01T14:30:00Z",
  "identifiers": {
    "email": "john@example.com",
    "phone": "+15551234567",
    "cookie_id": "abc123",
    "ip": "192.168.1.1"
  },
  "properties": {
    "page_url": "https://smithford.com/inventory/F150",
    "vehicle_vin": "1FTEW1EP5MFA12345",
    "utm_source": "google",
    "utm_medium": "cpc"
  },
  "session_id": "sess_xyz789",
  "user_agent": "Mozilla/5.0 ..."
}
```

### 8.3 Batch Ingestion

Batch files (CSV, JSON, Parquet) are uploaded to Azure Blob Storage under `/ingest/{dealership_code}/{source}/{date}/`. An Azure Function trigger validates, normalizes, and routes records through the same AI identity resolution pipeline.

## 9. Frontend Architecture & UI

### 9.1 Technology Choices

The frontend is a Next.js 15 application using the App Router with React Server Components as the default rendering strategy. It is built entirely with TypeScript and shares Zod validation schemas with the API layer for type-safe, consistent data handling across the full stack.

- **Next.js 15 (App Router):** File-based routing, React Server Components for fast initial loads, streaming SSR for dynamic content, route groups for role-based layouts.
- **shadcn/ui + Tailwind CSS 4:** A library of accessible, composable primitives (not a monolithic component library). Tailwind provides utility-first styling with a consistent design system. The color palette uses dark navy (#1B3A5C) for the sidebar, white content areas, and blue (#2E75B6) accents.
- **TanStack Query (React Query):** Manages all server state — caching, refetching, optimistic updates, and pagination. Every API endpoint has a corresponding typed hook.
- **TanStack Table:** Headless table library powering all data tables (consumer lists, review queues, event logs) with server-side sorting, filtering, and pagination.
- **React Hook Form + Zod:** Form state management with Zod schema validation. The same Zod schemas used in the API are reused on the frontend for consistent validation.
- **Recharts:** Declarative charting library for all dashboard visualizations (KPI trends, resolution rate donuts, growth lines, activity bars).
- **NextAuth.js v5:** Handles Azure Entra ID OAuth/OIDC flows, session management, and JWT token refresh. Role claims from the JWT drive route guards and UI visibility.
- **Lucide React:** Consistent icon library used throughout the UI.

### 9.2 Application Structure

The frontend uses Next.js App Router route groups to separate DAS admin and dealer portal layouts. Both share the same component library but have distinct navigation, page access, and data scoping.

```
packages/web/src/
├─ app/
│   ├─ (auth)/               # Login, OAuth callback
│   ├─ (dashboard)/           # DAS admin layout + all admin pages
│   │   ├─ layout.tsx         # Navy sidebar, topbar, dealership switcher
│   │   ├─ dashboard/         # Home: KPI cards, charts
│   │   ├─ consumers/         # Search, list, 360° profile
│   │   ├─ reviews/           # Match review queue + comparison view
│   │   ├─ audiences/         # Segment builder + saved segments
│   │   ├─ analytics/         # Full analytics dashboard
│   │   ├─ data/              # Redaction, deletion, consent management
│   │   ├─ models/            # ML model registry + performance
│   │   └─ dealerships/       # Dealership management
│   ├─ (dealer)/              # Dealer portal layout + dealer pages
│   │   ├─ layout.tsx         # Simplified sidebar, dealer name in topbar
│   │   ├─ dealer/            # Dealer dashboard + scoped views
│   │   └─ consumers/         # Scoped consumer list + profile
│   └─ api/auth/              # NextAuth API routes
├─ components/
│   ├─ ui/                    # shadcn/ui primitives (Button, Card, Table, etc.)
│   ├─ consumers/             # Profile header, tabs, attribute editor
│   ├─ reviews/               # Side-by-side comparison, score breakdown
│   ├─ audiences/             # Rule groups, combinators, live preview
│   ├─ analytics/             # KPI cards, charts, date picker
│   ├─ data/                  # Redaction form, deletion queue
│   ├─ layout/                # Sidebar, topbar, nav components
│   └─ models/                # Model table, metrics, promote dialog
├─ hooks/                     # TanStack Query hooks (one file per domain)
├─ lib/
│   ├─ api-client.ts          # Typed fetch wrapper with JWT auth
│   ├─ auth.ts                # NextAuth configuration
│   └─ utils.ts               # cn() helper, date formatters
└─ styles/globals.css
```

### 9.3 UI Modules & Pages

The application contains eight major UI modules, each serving a specific operational need:

| Module | Route | Users | Description |
|--------|-------|-------|-------------|
| DAS Dashboard | `/dashboard` | DAS admin/analyst | Global KPIs, system health, cross-tenant metrics, resolution rate charts. |
| Consumer 360° | `/consumers/[id]` | All roles (scoped) | 7-tab profile: overview, attributes, vehicles, events, identity, consent, history. |
| Match Review | `/dashboard/reviews` | DAS admin/analyst | Side-by-side comparison, ML score breakdown, merge/reject with keyboard shortcuts. |
| Audience Builder | `/dashboard/audiences` | DAS admin/analyst | Visual segment builder with AND/OR rules, live count preview, CSV export. |
| Analytics | `/dashboard/analytics` | DAS admin/analyst | Resolution trends, event volume, match quality, dealership activity, consent trends. |
| Data Management | `/dashboard/data` | DAS admin only | PII redaction, deletion requests with grace period, consent dashboard. |
| ML Models | `/dashboard/models` | DAS admin only | Model registry, performance charts, promote/retire, A/B status. |
| Dealer Portal | `/dealer` | Dealer admin/user | Scoped dashboard, consumer list, simplified profile view, vehicle list. |

### 9.4 DAS Admin Dashboard

The primary landing page for DAS Technology users. Displays at-a-glance operational metrics updated every 60 seconds:

- **KPI Cards (top row):** Total Consumers (with 30-day trend arrow), Active Dealerships, Events Today, Pending Reviews count with urgency color coding.
- **Resolution Rate Donut:** Visual breakdown of Tier 1 / Tier 2 / Tier 3 / unresolved events as a donut chart showing the percentage resolved by each tier.
- **Consumer Growth Line Chart:** 30-day trend of new consumer profiles created, with separate lines for net-new vs. merged.
- **Top Dealerships Bar Chart:** Horizontal bar chart of dealerships ranked by consumer count or event volume (toggle).
- **System Health:** API latency p95, worker lag, review queue age, model precision — green/amber/red indicators.

### 9.5 Dealer Portal

A simplified, focused experience for dealership users. Shows only data scoped to their dealership with no access to admin tools, match review, or ML models.

- **Dealer Dashboard:** My Consumers count, My Vehicles count, Events This Week, Recent Activity feed.
- **Consumer List:** Searchable, sortable table showing only consumers linked to this dealership. Click through to a scoped 360° profile.
- **Scoped Profile View:** Same 7-tab profile as the DAS view, but attributes, events, and vehicles are filtered to show only what this dealership contributed plus shared third-party data.

### 9.6 Consumer 360° Profile

The most detailed view in the application. A single page showing everything known about a consumer, organized in 7 tabs:

- **Overview:** Key demographics, confidence score badge, linked dealerships, primary identifiers, quick action buttons (edit, merge, redact).
- **Attributes:** Grouped by type (email, phone, address, custom). Each shows source, dealership that contributed it, shared status, and validity dates. Inline editing for the owning dealership.
- **Vehicles:** Card layout showing each vehicle with VIN, year/make/model, ownership type, and the dealership that linked it.
- **Events:** Filterable timeline (by event type, source, date range) with expandable event details showing the full payload.
- **Identity:** Visual display of all linked identifiers (badges by type) with confidence scores. DAS admins can see the full identity link history.
- **Consent:** Toggle switches per consent type (marketing email, SMS, phone, data sharing, tracking) with last-updated dates. Changes create new consent records.
- **History:** Chronological audit trail showing merge/unmerge operations, attribute changes, and identity resolution decisions with timestamps and actors.

### 9.7 Match Review & Merge Resolution

The match review UI is the primary interface for resolving identity conflicts. It consists of a queue list page and a detailed comparison page.

- **Review Queue:** Table of pending reviews sorted by priority (descending) and ML confidence score. Columns: Consumer A name, Consumer B name, ML score, source/trigger, date flagged, status. Filterable by status (pending, in_progress, completed) and score range.
- **Comparison View:** Side-by-side panels for Consumer A (left) and Consumer B (right). Matching fields are highlighted in green. Conflicting fields are highlighted in amber. The center panel shows: ML confidence score bar (color-coded), feature vector breakdown as a horizontal bar chart (showing which of the 20 features contributed most to the score), and LLM reasoning in a collapsible card if available.
- **Actions:** Merge (confirm match → triggers merge service → success toast with 30-second undo window), Reject (with optional reason text → marks as human_rejected), Skip (moves to next review without action). Keyboard shortcuts: M = merge, R = reject, S = skip, → = next.
- **Post-Merge:** After merging, the surviving consumer's profile updates in real-time. A link is provided to view the merged profile.

### 9.8 Audience Builder

A visual interface for constructing consumer segments using a drag-and-drop rule builder:

- **Rule Groups:** Each group contains one or more rules connected by AND/OR (toggle switch). Groups themselves are combined with AND/OR at the top level.
- **Rule Types:** Attribute rules (field + operator + value, e.g., 'email contains @gmail.com'), Event rules (event_type + time window, e.g., 'page_view in last 30 days'), Vehicle rules (make + model + year range, e.g., 'Ford F-150, 2022+').
- **Live Preview:** As rules are added or modified, a debounced (500ms) query runs against the API and displays the matching consumer count in real-time.
- **Save/Load:** Segments can be saved with a name and description, listed, loaded for editing, and exported as CSV.

### 9.9 Data Management (Redaction & Deletion)

DAS admin-only tools for privacy compliance and data governance:

- **PII Redaction:** Search for a consumer, view all PII fields in a checklist. Select fields to redact → confirmation dialog (irreversible) → values replaced with `[REDACTED]` in the database. Audit log entry created.
- **Deletion Requests:** Initiate a right-to-delete request for a consumer. The request enters a 30-day grace period during which it can be cancelled. After the grace period, a batch job permanently removes the consumer and all related data from all tables. A deletion queue table shows all pending, active, and completed deletion requests with status tracking.
- **Consent Dashboard:** Overview of opt-in/opt-out rates by consent type across all dealerships (bar chart). Recent consent change activity table. Filter by dealership. Export consent report as CSV.

### 9.10 Analytics & ML Model Monitoring

Two analytics modules providing operational visibility:

- **Analytics Dashboard:** Date range picker (7d, 30d, 90d, custom). Identity Resolution Trends (stacked area chart by tier over time). Event Volume (grouped bar chart by source). Match Quality (line chart: auto-merge rate, review rate, conflict rate). Dealership Activity (horizontal bars: events/day per dealer). Consent Trends (line chart: opt-in rate over time).
- **ML Model Monitoring:** Model registry table with version, status (staging/production/retired), and metrics (precision, recall, F1, AUC). Model detail page with performance trend charts over time. Promote-to-production and retire actions with confirmation dialogs. Only one model can be in production at a time.

## 10. Privacy, Security & Compliance

### 10.1 PII Handling

- **Encryption at rest:** AES-256 on all storage services. Customer-managed keys via Azure Key Vault.
- **Encryption in transit:** TLS 1.3 enforced on all connections.
- **Tokenization:** High-sensitivity PII tokenized at ingestion. Tokens in CDP; real values in isolated vault.
- **Pseudonymization:** Consumer IDs are opaque UUIDs. Analytics views use pseudonymized identifiers.
- **ML data isolation:** Training data uses internal PostgreSQL data only. LLM prompts sent via Azure OpenAI (within Azure boundary, no external PII exposure).

### 10.2 Consent Management

The `consent` table tracks per-consumer, per-dealership, per-channel consent. Opt-out requests trigger suppression across all activation channels within the required timeframe.

### 10.3 Data Retention & Deletion

- Events: 24 months default. Consumer profiles: 36 months of inactivity. Consent records: indefinite.
- ML match scores: Retained for 12 months for audit. Consumer embeddings: overwritten on each batch run.
- Right to delete (CCPA/GDPR): Cascading soft-delete across all tables including ML match scores and embeddings. Hard-delete after 30-day grace period.

### 10.4 Audit Logging

All data access, modifications, ML decisions, LLM reviews, and administrative operations logged to Azure Monitor / Log Analytics. Retained for minimum 7 years.

## 11. Deployment Architecture (Azure)

### 11.1 Resource Group Layout

```
das-cdp-prod-rg/
  ├─ Azure Kubernetes Service (AKS)              (All containerized workloads)
  │     ├─ Namespace: cdp-api                    (API Deployment + Service)
  │     ├─ Namespace: cdp-workers                (Event workers + batch jobs)
  │     ├─ Namespace: cdp-ml                     (ML inference + ONNX serving)
  │     ├─ Namespace: cdp-frontend               (Next.js SSR)
  │     ├─ Namespace: cdp-infra                  (Redis, NGINX Ingress, cert-manager)
  │     └─ Namespace: monitoring                 (Prometheus, Grafana, Fluent Bit)
  ├─ Azure Database for PostgreSQL Flexible    (Primary OLTP + pgvector)
  ├─ Azure Cosmos DB Account                   (Identity Graph — Gremlin)
  ├─ Azure Event Hubs Namespace                (Streaming — Kafka surface)
  ├─ Azure Synapse Workspace                   (Analytics)
  ├─ Azure Blob Storage (ADLS Gen2)            (Data Lake + ML Artifacts)
  ├─ Azure Machine Learning Workspace          (Model Training + Registry)
  ├─ Azure OpenAI Service                      (LLM Identity Review)
  ├─ Azure AI Search                           (Vector Search / ANN index)
  ├─ Azure Entra ID (B2C Tenant)               (Auth)
  ├─ Azure Key Vault                           (Secrets / Keys)
  ├─ Azure Monitor + Log Analytics             (Cluster + app observability)
  └─ Azure Container Registry                  (Docker images)
```

### 11.2 AKS Cluster Architecture

The AKS cluster uses multiple node pools to isolate workloads by resource profile and criticality:

| Node Pool | VM SKU | Min/Max Nodes | Workloads | Scaling |
|-----------|--------|---------------|-----------|---------|
| system | Standard_D4s_v5 (4 vCPU, 16GB) | 2 / 4 | CoreDNS, kube-system, NGINX Ingress, cert-manager | Cluster autoscaler |
| api | Standard_D4s_v5 (4 vCPU, 16GB) | 2 / 10 | API pods, frontend pods | HPA on CPU (60%) + request rate |
| workers | Standard_D8s_v5 (8 vCPU, 32GB) | 1 / 8 | Event processing workers, batch jobs | KEDA on Event Hubs lag |
| ml | Standard_D8s_v5 (8 vCPU, 32GB) | 1 / 4 | ONNX inference, embedding computation | HPA on queue depth |
| gpu (optional) | Standard_NC6s_v3 (GPU) | 0 / 2 | GNN inference, embedding model (if on-cluster) | Manual or scheduled scale |

- All node pools use Azure CNI networking for direct pod-to-PaaS connectivity (PostgreSQL, Cosmos DB, Event Hubs).
- Azure Key Vault CSI driver mounts secrets into pods as volumes. External Secrets Operator syncs Key Vault secrets to Kubernetes Secrets for environment variable injection.
- KEDA (Kubernetes Event-Driven Autoscaler) scales worker pods based on Event Hubs consumer group lag, enabling zero-to-N scaling for event-driven workloads.
- Prometheus (via kube-prometheus-stack Helm chart) scrapes all pod metrics. Grafana provides operational dashboards. Fluent Bit DaemonSet ships logs to Azure Log Analytics.
- Network Policies restrict inter-namespace traffic: the frontend namespace can only reach the api namespace; workers can reach api and external PaaS services.

### 11.3 Container Strategy

Every application component is packaged as a Docker container and stored in Azure Container Registry (ACR). AKS pulls images from ACR via managed identity (no image pull secrets needed).

| Container | Base Image | K8s Resource | Namespace |
|-----------|------------|--------------|-----------|
| cdp-api | node:20-slim | Deployment + Service + HPA | cdp-api |
| cdp-workers | node:20-slim | Deployment + HPA (KEDA) | cdp-workers |
| cdp-batch-jobs | node:20-slim | CronJob / Job | cdp-workers |
| cdp-ml-inference | node:20-slim + onnxruntime | Deployment + HPA | cdp-ml |
| cdp-frontend | node:20-slim (Next.js standalone) | Deployment + Service + HPA | cdp-frontend |
| cdp-redis | redis:7-alpine | StatefulSet + Service | cdp-infra |
| cdp-migrate | node:20-slim | Job (run-once on deploy) | cdp-api |

### 11.4 Scaling Strategy

- **PostgreSQL Flexible Server:** General Purpose (8 vCores, 64GB). Read replicas for analytics offloading. Managed — not containerized.
- **AKS API pool:** HPA targets 60% CPU and 100 req/sec per pod. Min 2, max 10 replicas. Cluster autoscaler adds nodes if pod scheduling fails.
- **AKS Workers pool:** KEDA scales from 1 to 8 pods based on Event Hubs partition lag (target: <1000 events behind). Zero-scale to 0 when idle (optional).
- **AKS ML pool:** HPA on custom metric (review queue depth or inference queue). Min 1, max 4 pods.
- **AKS Frontend:** HPA at 60% CPU. Min 2, max 6 replicas.
- **Event Hubs:** Standard tier (20 TUs). Auto-Inflate for bursts. Partition by `dealership_code`.
- **Cosmos DB:** Autoscale (400–10,000 RU/s). Partition key = `consumer_id`.
- **Azure ML:** GPU compute (NC-series) for training. Auto-deallocate after jobs. Not on AKS.
- **Azure OpenAI:** Provisioned throughput deployment for predictable LLM review latency.

### 11.5 Environments

| Environment | Purpose | Data |
|-------------|---------|------|
| dev | Developer testing, feature branches | Synthetic data only |
| staging | Integration testing, ML model validation | Anonymized subset + shadow ML scoring |
| production | Live dealership data | Full data with encryption + RLS + live ML |

## 12. Implementation Roadmap

### Phase 1 — Foundation (Weeks 1–8)

- Provision Azure infrastructure via Terraform: AKS cluster with node pools (system, api, workers, ml), PostgreSQL Flexible Server, Azure Container Registry, Key Vault, Entra ID B2C.
- Set up Helm chart structure for all application services (api, workers, ml, frontend).
- Deploy PostgreSQL with core schema (all tables in Section 4) including pgvector extension.
- Deploy NGINX Ingress Controller + cert-manager for TLS on AKS.
- Build TypeScript API as Docker container, deploy to AKS `cdp-api` namespace with HPA.
- Implement RLS policies and multi-tenant middleware.
- Build basic CRUD endpoints for consumers, dealerships, vehicles.
- Scaffold Next.js 15 frontend container, deploy to AKS `cdp-frontend` namespace.

### Phase 2 — Ingestion & Deterministic Identity (Weeks 9–16)

- Deploy Event Hubs and build ingestion API (webhook receiver + SDK).
- Implement normalization pipeline (phone, email, VIN, address).
- Build Tier 1 deterministic identity resolution engine.
- Deploy Cosmos DB for identity graph with sync from PostgreSQL.
- Implement merge/unmerge workflows with audit logging.

### Phase 3 — ML Pairwise Classifier (Weeks 12–20)

Overlaps with Phase 2.

- Build feature engineering pipeline in TypeScript.
- Generate initial training data (synthetic pairs + early dealership imports).
- Train XGBoost model in Azure ML. Export to ONNX.
- Deploy ONNX inference container to AKS `cdp-ml` namespace with HPA.
- Integrate Tier 2 with identity resolution pipeline.
- Deploy Redis StatefulSet in `cdp-infra` namespace for feature cache.

### Phase 4 — LLM Review + Analytics API (Weeks 20–26)

- Deploy Azure OpenAI Service (GPT-4o).
- Build LLM prompt templates and structured output parsing.
- Integrate LLM with review queue: auto-process flagged pairs nightly.
- Build audit trail for LLM decisions.
- Deploy Synapse workspace and configure Delta Lake storage.
- Build 360-degree consumer profile API and audience builder API.
- Build activation connectors (email, Facebook Ads, Google Ads).

### Phase 5 — Embeddings, GNN & Advanced AI (Weeks 26–34)

- Train consumer embedding model (PyTorch, Azure ML GPU). Export to ONNX.
- Deploy pgvector ANN index (or Azure AI Search).
- Build nightly ANN scan pipeline: embed → search → score → merge/review.
- Build identity graph export pipeline (Cosmos DB → PyTorch Geometric).
- Train and deploy GraphSAGE model for cluster detection.
- Integrate GNN clusters with merge workflow.
- Implement active learning loop and monthly model retraining.

### Phase 6 — Frontend: Core UI (Weeks 28–36)

Overlaps with Phase 5. Frontend development can begin as soon as the API endpoints from Phases 1–4 are stable.

- Build Next.js app shell with NextAuth.js authentication flow.
- Build DAS admin layout (navy sidebar, topbar, dealership switcher, responsive).
- Build dealer portal layout (simplified, scoped navigation).
- Create TanStack Query hooks for all API endpoints.
- Build DAS admin dashboard (KPI cards, resolution donut, growth chart).
- Build consumer list + search page with TanStack Table.
- Build Consumer 360° profile page (7 tabs: overview, attributes, vehicles, events, identity, consent, history).
- Build dealer dashboard and scoped consumer views.

### Phase 7 — Frontend: Advanced UI (Weeks 36–42)

- Build match review workbench (queue table, side-by-side comparison, ML score breakdown, keyboard shortcuts, merge/reject/skip with undo).
- Build audience builder UI (visual rule groups, AND/OR toggles, live count preview, save/load segments, CSV export).
- Build data management tools (PII redaction workflow, deletion request queue with grace period tracking, consent dashboard).
- Build consent management UI (opt-in/opt-out rates, recent changes, bulk operations).
- Build ML model monitoring UI (registry table, performance charts, promote/retire actions).
- Build full analytics dashboard (date range picker, resolution trends, event volume, match quality, dealership activity, consent trends).

### Phase 8 — Hardening & Scale (Weeks 42–48)

- Load testing at 50M consumer scale (all 3 ML tiers + full UI under load on AKS).
- Implement consent management workflows and CCPA/GDPR deletion flows.
- ML model monitoring dashboards (match rate, precision drift, feature drift).
- A/B testing infrastructure for model promotion (canary deployments via Helm).
- Frontend performance optimization (bundle splitting, ISR, image optimization).
- Kubernetes hardening: Network Policies, Pod Security Standards, resource quotas per namespace.
- Implement Istio/Linkerd service mesh for mTLS between all pods.
- Security audit and penetration testing (API + frontend + K8s cluster).
- Accessibility audit (WCAG 2.1 AA) on all frontend pages.
- Set up Prometheus alerting rules and PagerDuty/Opsgenie integration.
- Onboard first 10 pilot dealerships.
- Bias audit across demographics and dealership regions.

---

End of Document — Version 3.0
