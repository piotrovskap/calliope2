---
title: "Data Exposure & Syndication"
type: feature
status: planned
priority: medium
labels: [phase-2, data-exposure, syndication]
date: ~
---

The data-out side of Phase 2 — exposing the unified CDP data for downstream consumption over the Phase-1 golden record + governed surfaces. **No reverse-ETL / writeback to legacy systems:** the CDP is the replacement for those systems, not a bridge that keeps feeding them — DAS is retiring them, not integrating with them long-term.

Exposure is via syndication feeds, embeddable surfaces, and self-serve export.

**Candidate, not a committed milestone:** a governed data/tool API for external apps and agents over the Phase-1 `tool-access-api`. Flagged as most likely **its own standalone web service** rather than a P2 story — revisit and scope separately. (Tags: `net-new`.)
