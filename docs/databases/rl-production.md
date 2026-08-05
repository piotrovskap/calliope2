---
source: RL Production (Response Logix · 20.65.216.199:49577)
title: RL Production — Schema Documentation
type: db-schema
database: RL_Production
owner: Ron Mulder
researcher: Alicia Salazar
access: granted
status: complete
dump: dumps/rl-production.sql
erd: erd/rl-production.svg
updated: 2026-06-21
---

# RL Production — Schema Documentation

> _Resolved (discovery caveat). No standalone database named `RL_Production` exists on the RL server (`20.65.216.199:49577`); the accessible databases are `oltp` (complete) and `oltp_Archive` (complete), read access granted. No separate dump is needed and this is not a blocker — see below._

## Discovery finding

Live discovery probe against `20.65.216.199:49577` (2026-06-14) returned the following databases:

| Database | HAS_DBACCESS |
|---|---|
| oltp | 1 — **documented** ([oltp.md](oltp.md)) |
| oltp_Archive | 1 — **documented** ([oltp-archive.md](oltp-archive.md)) |
| DataOne | 0 — access blocked ([dataone.md](dataone.md)) |
| DBATools | 0 — access blocked |

**No database named `RL_Production` exists on this server.** The Response Logix production OLTP system is the `oltp` database (196 GB, 240 tables, 1.13B rows) — already fully documented. This stub was likely created before the actual database name was confirmed.

## Access

- **Owner:** Ron Mulder · **Researcher:** Alicia Salazar · **Status:** granted (to `oltp` and `oltp_Archive`)
- Cross-ref: [System Access Tracker](/analysis/artifacts/access-tracker/index.html)

## Open questions

1. **Is `RL_Production` an alias for `oltp`?** Most likely yes — confirm with Ron Mulder and close out this stub.
2. **`DBATools` database:** `HAS_DBACCESS = 0` — is access grantable, and does it contain anything relevant?
