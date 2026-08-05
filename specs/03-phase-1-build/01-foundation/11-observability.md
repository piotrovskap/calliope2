---
title: "Observability (OTel / Prometheus / OpenSearch)"
type: story
status: planned
priority: high
estimate: XXL
depends_on: [phase-1-build.foundation.boilerworks-repos, phase-1-build.foundation.data-stores-provisioning]
labels: [foundation, observability, otel, 1a]
date: ~
---

The `boilerworks-django-nextjs` boilerplate ships observability tooling — OpenTelemetry, Prometheus, Grafana, and OpenSearch with Elastic Common Schema (ECS) and SS4O (Simple Schema for Observability). This story wires and standardizes **metrics and logs** across services: consistent ECS/SS4O log schema, Prometheus/Grafana metrics, dashboards, and alerts (including the Data Source Status and Data Health signals). Distributed tracing is its own story (Jaeger).

**Acceptance:** OTel metrics flow to Prometheus and are visible in Grafana for every service; ECS/SS4O-schema logs flow from every service to OpenSearch (no per-service bespoke schema); baseline dashboards exist (per-service health, ingest throughput, plus the Data Source Status and Data Health signals); at least one alert fires end-to-end on a forced condition (e.g. event-feed liveness for the Event Grid critical-path dependency). (Tracing is covered by the Jaeger story.)

**References:**
- Decided 2026-06-16 (infra sizing): dev baseline now, production rightsized on observed load; the system surfaces its own profile in flight — `memory/decisions.md#d-007`
- Decided 2026-06-17 (Conflict, Azure-primary refinement): monitoring stays managed per cloud (AMP + Amazon Managed Grafana on AWS; Azure Monitor managed Prometheus + Azure Managed Grafana on Azure) with portable OTel app instrumentation — `memory/decisions.md#d-091`
- The DAS-owned Event Grid subscription is a monitored critical-path dependency — Data Source Status alerts on event-feed liveness — `memory/decisions.md`
- `docs/cdp-architecture.md` §Observability — OTel feeds metrics (→Prometheus→Grafana) and logs (→OpenSearch, ECS/SS4O), reusing the search-tier OpenSearch; traces are the separate Jaeger story
- `wiki/Tech-Stack.md` — OTel + Prometheus + Grafana stack with managed backend per cloud
- `docs/cdp-reference-topology.md` — OTel collector / Prometheus / Grafana placement and dev-baseline sizing
