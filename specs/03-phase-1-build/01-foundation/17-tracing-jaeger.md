---
title: "Distributed tracing (Jaeger)"
type: story
status: planned
priority: medium
depends_on: [phase-1-build.foundation.observability, phase-1-build.foundation.data-stores-provisioning]
estimate: M
labels: [foundation, observability, tracing, jaeger, 1a]
date: ~
---

Stand up distributed tracing on Jaeger, OpenSearch-backed (reuses the search/observability OpenSearch tier), receiving OTel traces from every service. Self-hosted on the node group; on AWS run hosted/managed Jaeger where possible. Jaeger is preferred over proprietary X-Ray / Application Insights to keep the stack portable across clouds (avoid-SaaS direction).

**Acceptance:** OTel traces from every service flow to Jaeger and persist in OpenSearch; a single request is traceable end-to-end across services (API → resolver → datastore spans) in the Jaeger UI; trace sampling is configurable; the tracing backend is cloud-neutral (no X-Ray / App Insights dependency).

**References:**
- Decided 2026-06-17 (Dan Aston direction): avoid proprietary SaaS, prefer self-hosted OSS so the stack moves between clouds unchanged — the rationale for Jaeger over X-Ray / App Insights — `memory/decisions.md#d-092`
- `docs/cdp-architecture.md` — Traces: OTel → Jaeger, self-hosted and OpenSearch-backed; hosted/managed Jaeger on AWS where possible; X-Ray / Application Insights rejected as proprietary (breaks portability)
- `docs/cdp-reference-topology.md` — Jaeger sizing/placement on the node group, using OpenSearch as its trace store (reuses the search/observability tier)
- `wiki/Tech-Stack.md` — observability is OTel + portable backends; managed per-cloud backend is the opt-in flavoring, not the default
