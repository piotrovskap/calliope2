# Architecture Design Review — CDP Stack

**Human <> AI agent work session** (Leo Mata + Claude) · 2026-06-13 · no recording

Working session to design the CDP target architecture (informing the Phase 0 Revised Architecture Plan), validate it against client requirements, and route the follow-up work. Canonical decisions + rationale: `memory/decisions.md` (2026-06-13).

## What we did

### 1. CDP target architecture (recommended — Phase 0)
- **Cloud:** AWS, self-contained; kept portable to Azure/AKS (no lock-in in app code).
- **Data tiering:** S3 raw (bronze, SSE-KMS) → RDS for PostgreSQL (native) + RLS + Proxy + read replicas → Redshift (zero-ETL) for analytics; OpenSearch (search + query log); NATS JetStream (event backbone/log).
- **Orchestration:** Airflow (MWAA) = all ingest; Temporal = identity sagas, conflict queue, workers, admin utilities.
- **Ingestion:** original sources (not EDW); AWS DMS for CDC; SSIS ingest logic rewritten; DAS Event Grid via Option A (config-only subscription → CDP webhook).
- **Data-model invariants (settle before schema):** bitemporal provenance (valid + system time), cross-tenant resolver above tenant RLS, KMS crypto-shred erasure.
- **API:** Django REST + Strawberry GraphQL (confirmed). **Frontend:** Next.js — 4 surfaces (Golden Record, Identity Map, Source Status, Data Health).
- **Auth:** Auth0 (Cognito fallback). **Ops:** EKS + Terraform (`boilerworks-opscode`).

### 2. Requirements validation
- Cross-checked the stack against Dan's guidance + Mike's requirements — validated clean; surfaced 7 design-level gaps, none blocking the stack.
- Routed to owners: survivorship, household/family resolution, bitemporal schema, consent model, AI/agentic-readiness, source-onboarding registry (Alicia + Luis, due 2026-06-19); **real-data golden-record proof** (Alicia + Luis, review Leo) — the gap not to let slide.

### 3. Deliverables
- Drafted the **Revised CDP Architecture Plan** (4 components) → `artifacts/phase-0/deliverables/`; marked in-progress and wired to the portal reader.
- Assigned owners to every Phase 0 deliverable: Exec Summary (Leo), CDP Scoping (Alicia + Luis + Leo), Privacy-by-Design (Luis), Phase 1 & 2 Plans (Leo), Identity Strategy (Alicia + Luis).

### 4. Tracking + timeline
- Action tracker updated — owners on all open items; **field prioritization** broken out (Alicia).
- Timeline refreshed (access closed; exec sync + this session added). Two discovery steps (Juicebox sampling, Common Client ID coverage) reframed as **optional DAS open questions**.

### 5. Wiki + process docs
- Reconciled Architecture / Tech-Stack / Ingestion-Channels / Roadmap / Home to the recommendation; added the Frontend page.
- Hardened conventions: submodule push-order failure mode + verify, and the git-identity rule (`PROCESS.md`, `bootstrap.md`). Trimmed CLAUDE/AGENTS to pure shims (restored the Codex `$kg` command).

### 6. Team comms (Slack — Conflict-internal)
- Nudges: API ingest grooming (Hiram/Julio/Oscar/Byron), identity directions (Alicia/Luis); weekly broadcast to `#das-digital`.
- Push-order gotcha (personal DM + unattributed team reminder) and GitHub-email attribution notes — Costa Rican Spanish.

### 7. Git
- PRs #12–16 merged to `main`. Integrated the team's concurrent Twilio/MailGun/Mandrill API-catalog work; repaired a dangling wiki submodule pointer left by a push-order violation.

## Outcomes
- Phase 0 architecture recommendation captured, documented, and reconciled across decisions log, wiki, deliverables, tracker, and timeline.
- Every Dan/Mike want and every promise is **done, owned-and-tracked, or an optional DAS open question** — zero implicit work.

## Open / parked
- DAS Teams messages (Dan — data profile; Ron — Common Client ID logic; Rick — SSIS job descriptions) — deferred to Leo.
- Data model + identity schema — in design (Alicia + Luis, due 2026-06-19).
