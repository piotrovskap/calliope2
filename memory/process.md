---
name: das-cdp-process-extensions
description: Project-specific process rules that extend the standard CONFLICT primer — CDP and DAS-specific constraints
metadata:
  type: feedback
---

Standard CONFLICT process applies (see bootstrap.md + PROCESS.md). The following are extensions or heightened constraints specific to building a multi-tenant CDP on DAS's architecture.

**Multi-tenant safety — every query must be scoped.**
Every database query is scoped to a `dealership_id` in context. Unscoped queries are bugs, not just risks. PostgreSQL RLS is the last line of defense but application-layer scoping is also required. Same rule applies across all layers: API middleware, resolver, frontend route guard.

**Data provenance at ingestion — classify at write time.**
Every ingested record must be tagged as `dealer-provided` (non-shareable across dealers) or `third-party` (shareable globally). This is enforced at ingest time. Classify wrong and the data sharing rules fail downstream.

**DMS = source of truth for transactions.**
When a CRM record and a DMS record conflict on the same consumer, the DMS record wins. Dollars are attached to DMS. Lead data is an intent signal, not ground truth.

**No integer PKs anywhere in the API surface.**
UUID or cuid only. This is standard primer but heightened here because cross-system consumer IDs (Mautic contactID, DMS customer ID, CRM ID) are all integers — the CDP's own IDs must not be.

**Identity resolution owns conflict, not the caller.**
When a consumer can't be resolved to a single golden record, it goes to the conflict review queue. Never create duplicate consumer records silently. The ingestion API returns `resolution: 'conflict'` — the caller doesn't decide, the queue operator does.

**Don't build on SSIS or CVH.**
SSIS packages and the CVH hash are the fragile layers. No new integrations should depend on them. Airflow replaces SSIS; CDP identity resolution replaces CVH entirely.

**Why:** DAS has no dev/QA environment, dev apps point to production databases, and multi-tenancy rules have no contractual enforcement — they're relationship obligations. Getting any of these wrong has immediate real-world consequences for dealer relationships, not just test failures.
