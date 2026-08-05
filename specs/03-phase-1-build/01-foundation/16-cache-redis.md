---
title: "Cache (Redis)"
type: story
status: planned
priority: medium
estimate: S
depends_on: [phase-1-build.foundation.boilerworks-opscode-iac, phase-1-build.foundation.accounts-prod-dev-staging]
labels: [foundation, cache, redis, 1a]
date: ~
---

Provision the Redis cache tier (managed — Azure Cache for Redis / ElastiCache — or self-hosted; cloud-neutral behind a cache interface). Serves hot-read caching for the serving APIs and the optional isolated short-TTL cache for the PII-vault salt+pepper derived keys (separate instance / access-controlled, per the privacy design).

**Acceptance:** Redis stands up per environment (HA pair in prod), reachable through the cache interface; a cached read returns within target latency and honors TTL/eviction; the optional pepper-key cache is a separate access-controlled instance with short TTL and is evicted on vault-row delete; metrics flow to the observability stack.

**References:**
- Decided 2026-06-21 (Leo): PII erasure = tokenized vault + delete-the-row; optional salt+pepper hardening may cache the pepper/derived keys in an isolated Redis (short TTL, separate from app cache, own access controls, evicts on vault-row delete) — `memory/decisions.md#d-012`
- `wiki/Privacy-by-Design.md` — isolated pepper-key cache pattern (short TTL, separate from app cache); deleted vault row evicts cached key, pepper-clear invalidates all at once
- `docs/cdp-reference-topology.md` — Redis HA pair (primary + replica) in prod, ElastiCache / Azure Cache for Redis, caches hot reads on the serving path
- `wiki/Tech-Stack.md` — Redis is the approved cache tier
