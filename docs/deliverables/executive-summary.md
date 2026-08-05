---
title: Executive Summary
type: deliverable
status: final
phase: 0
---

# Executive Summary

*Phase 0 deliverable — the leadership-facing distillation of the engagement. It states what we found in DAS's systems, what we recommend building, and what proceeding unlocks. It reads on its own; each supporting deliverable is linked at the end, and every decision below traces to a dated, recorded entry in `memory/decisions.md`.*

Prepared by: Leo Mata @ CONFLICT · Prepared for: Dan Aston, Digital Air Strike

## Overview

DAS holds substantial customer data across dozens of systems but has no way to resolve it into a single view of a customer. Two findings dominate Phase 0:

- First, there is no cross-dealer identity resolution today: the current CVH hash keys a contact to one dealer and one email, so the same person at two dealerships would have two unlinked records in the system.
- Second, the SSIS pipeline that moves customer data is near capacity and already flagged for replacement.

CONFLICT recommends building a productionized Customer Data Platform on a portable, open-source core that becomes DAS's system of record, with deterministic-first identity resolution and privacy built in by construction rather than added later. The platform runs on a full Python stack and is cost-neutral between Azure and AWS; Azure-primary is the preferred target, and the final cloud decision is DAS's.

## Engagement Context

CONFLICT was engaged for a fixed-scope, one-month Phase 0 discovery, beginning May 27, 2026. The mandate is assessment and design only: no code is written and no infrastructure is provisioned. Mike Paylor drives the CDP initiative for DAS and sets its central test, to demonstrate a golden record built from DAS's real data rather than describe one in principle. Phase 0 produces three deliverables (this Executive Summary, the Revised CDP Architecture Plan & Proposal, and the DAS CDP Roadmap) and a Phase 1 go/no-go recommendation.

### Phase 0 Scope & Boundaries

Phase 0 is a fixed-scope discovery engagement of roughly one month. No code is written and no infrastructure is provisioned. The three Phase 0 deliverables are:

- Executive Summary (this document)
- Revised CDP Architecture Plan & Proposal
- DAS CDP Roadmap (spreadsheet plus the companion key document)

## Current State Assessment

This assessment draws on the full body of material gathered during Phase 0. CONFLICT reviewed DAS's documentation, worked through the source systems directly, and held discovery sessions with DAS technical staff. The review spanned:

- DAS specifications: the MVP Specification v4, the Architecture Plan v3, and the Vehicle Smart Score microservice spec and data mapping.
- Confluence: application and system architecture, background processing, the CDK DMS onboarding flow, the AI microservice and lead-submission APIs, and logged CDXP defects.
- Discovery sessions from the May 27 kickoff through mid-June: a dedicated SSIS review with Rick Sorich, a Juicebox reporting review, an architecture working session, and several executive syncs.
- Internal data systems: the legacy ETL codebase (231 SQL objects across 20 modules and five platforms, verified against the SQL) and roughly two dozen internal databases through their DDL and schemas, including the Response Logix OLTP store (240 tables and 1.13 billion rows, with a 51-million-row consumer table and a 34-million-row alias graph), the DataStaging campaign layer, and the DWRPT and EDW reporting warehouse.
- External source landscape: 14+ source categories and more than 50 sources, with the vendor APIs behind them across CRM, DMS, advertising, enrichment, review, and communications platforms, each recorded with its ingestion method, identity key, and priority.

That review included a direct audit of the Common Client ID, the intended cross-system key, which was found to be entirely zero and therefore non-functional. Across those systems the pattern is consistent: rich data, no single view of the customer.

### Discovery Findings

Discovery surfaced four gaps that must be closed for a reliable customer platform:

- Identity: there is no way to recognize a customer across dealers today, which also breaks household linkage and lead-to-sale attribution. Closing this is the platform's core job.
- Ingestion: the legacy pipeline is fragile and near capacity, with no retry, monitoring, or safe handling of source changes. It gets replaced, not extended.
- Consumer 360: no single view of a customer exists today, which blocks personalization, suppression, and cross-dealer marketing. This unified profile, the Consumer 360, is a core Phase 1 deliverable.
- Privacy: some sources carry regulated financial data (GLBA), and there is no data-provenance or consent tracking today, so privacy must be built in from the start.

## Recommended Approach

Based on Phase 0 findings, CONFLICT recommends building the CDP in phases on a portable, open-source foundation: each dealer's data isolated by default, a modern pipeline replacing the existing legacy one, and a flexible way for applications to read the unified customer record. Full technical detail is in the accompanying Revised CDP Architecture Plan & Proposal.

### Core Architecture Principles

- Multi-tenancy RLS: the core dealer isolation mechanism, non-negotiable row-level security
- Privacy-by-design: provenance classification required at ingestion time, not retrofitted
- Soft deletes only: no hard data destruction
- No integer primary keys in APIs: UUIDs at all external surfaces
- The full CDP schema deployed in Phase 1, including the AI/ML stub tables, so Phase 2 and Phase 3 require no schema migrations (the final table set is fixed in the data-model deliverable)
- Data entity abstractions: "Inventory" rather than "vehicle": the data model generalizes to non-automotive verticals (per Dan Aston's direction)
- Two data types per record: DAS-global (shareable across dealers) vs. dealer-provided (isolated per dealer/channel)

### Phased Delivery Model

| Phase # | Name | Scope |
|---|---|---|
| 0 | Discovery | No code, no infrastructure. Assessment, architecture, and roadmap (current - completed). |
| 1 | Foundation | CDP schema, Airflow batch ingestion, identity resolution engine, and the Consumer 360 API. |
| 2 | Applications | Applications built on the CDP: the VSS retool, service and maintenance, marketing activation, and mobile, each built on the golden record instead of resolving identity again. Source coverage and advanced identity expand here as applications require. |
| 3 | AI/ML | Hosted AI against the CDP first (reusing DAS's existing AI layer), then DAS's own identity-resolution models, trained on the labeled review decisions Phase 1 produces. The schema ships AI/ML-ready, so this adds with no rebuild. |

### What Phase 1 Unlocks

- A unified consumer profile queryable via GraphQL (Consumer 360)
- Batch ingestion replacing SSIS for priority sources: CRM, DMS, CDXP, ADF leads, email engagement
- An identity resolution engine replacing the CVH hash
- A multi-tenant API with Auth0 authentication and Kong gateway
- The foundation for the application and AI/ML layers in later phases

### Technology Stack

CONFLICT recommends a full Python stack: Django for the API and ORM, Apache Airflow for orchestration, Temporal for durable workflows, and the identity resolution and transform logic, with React/NextJS TypeScript on the front end for web. The reasons:

- One language across the platform. The DAGs, ORM, scripts, and workers are all Python, and Temporal has first-class Python support, so a small team works in a single toolchain instead of splitting Python data engineers and TypeScript API engineers.
- Python is the fastest-growing major language, which protects the talent pool and the long-term investment. (https://survey.stackoverflow.co/2025/technology)
- Machine learning and AI run on Python. Keeping the platform Python-native means the AI/ML work in the later phases reuses the same stack with no rewrite.
- Python talent is straightforward to hire, so staffing and ongoing support are low-risk.

The full stack rationale is in the Technical Architecture document.

## Next Steps

Phase 0 is complete. The findings, the recommended architecture, the effort estimate, and a detailed Phase 1 roadmap are delivered and available in the CDP project portal (das.conflict.media) and the accompanying documents.

To begin Phase 1, CONFLICT needs three things from DAS:

- Go-ahead: sign-off on the recommendation and the decision to proceed.
- Access and credentials: cloud accounts, API credentials, and environment access needed to stand up the platform.
- Source data access: initial access to the raw source systems, needed shortly after kickoff rather than on day one.

On sign-off, CONFLICT can begin Phase 1 against the roadmap already provided.

## Supporting deliverables

- [`identity-resolution-strategy.md`](identity-resolution-strategy.md) — how fragmented records become one trustworthy view (deterministic-first, survivorship, households).
- [`privacy-by-design-framework.md`](privacy-by-design-framework.md) — deletion-first, tenant-isolated privacy built in by construction.
- [`detailed-phase-1-2-plans.md`](detailed-phase-1-2-plans.md) — stage-by-stage scope, sizing, sequencing, and infrastructure run-cost.
- [`cdp-scoping-document.md`](cdp-scoping-document.md) — the core scoping report: source mappings, data model, integration analysis, risk register.

*Architecture reference: [`../cdp-architecture.md`](../cdp-architecture.md) · Cloud comparison: [`../cloud-aws-vs-azure-bakeoff.md`](../cloud-aws-vs-azure-bakeoff.md) · Decision log: `memory/decisions.md` · Live golden record: [`/analysis/artifacts/golden-record/`](/analysis/artifacts/golden-record/)*

