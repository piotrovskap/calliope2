---
title: "Frontend (Auth, RBAC, Admin, App Exposure)"
type: feature
status: planned
priority: high
depends_on: [phase-1-build.foundation.base-org-auth-local-dev]
labels: [track-1, frontend, nextjs, phase-1]
date: ~
---

The operator/dealer-facing Next.js web app: app shell, Auth0 authentication, frontend RBAC, and a custom web-UI admin with CRUD that is explicitly NOT Django admin. Includes an access/user management surface, the four read surfaces (Golden Record, Identity Map, Source Status, Data Health), and role- and tenant-scoped exposure. Backend permission model is the single source of truth; frontend RBAC mirrors it deny-by-default.

**Milestone.** auth -> roles -> app exposure working; admin CRUD + access management usable.
