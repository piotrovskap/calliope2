---
title: "Next.js app shell"
type: story
status: planned
priority: high
estimate: XL
labels: [frontend, nextjs, 1a]
date: ~
---

Scaffold the Next.js (TypeScript) app on `boilerworks-django-nextjs`: base layout, navigation, and routes for the four read surfaces plus the admin. Wire the API client so the shell calls the Django backend.

**Acceptance:** `next build` succeeds; the shell renders with base layout + nav; routes for the four read surfaces (Golden Record, Identity Map, Source Status, Data Health) plus admin are stubbed and reachable; the typed API client makes at least one successful call to the Django backend (REST and/or GraphQL) with the response rendered.

**References:**
- Decided 2026-06-13 (Phase 0): Next.js frontend on `boilerworks-django-nextjs`, 4 read surfaces (Golden Record / Identity Map / Source Status / Data Health); dual REST + GraphQL surface — `memory/decisions.md#d-087`
- Language strategy 2026-06-14: TypeScript/Next.js kept on the frontend (Python backend) — `memory/decisions.md`
- `wiki/Frontend.md` — defines the four surfaces and the operator/analyst (not consumer-facing) scope
- `wiki/Tech-Stack.md` — canonical stack: Next.js on `boilerworks-django-nextjs`
