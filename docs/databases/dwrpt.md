---
source: DWRPT (Data Warehouse · 40.83.161.93)
title: DWRPT — Schema Documentation
type: db-schema
database: DWRPT
owner: Ron Mulder
researcher: Alicia Salazar
access: granted
status: complete
dump: dumps/dwrpt.sql
erd: erd/dwrpt.svg
updated: 2026-06-21
---

# DWRPT — Schema Documentation

> _Resolved (discovery caveat). No standalone database named `DWRPT` exists on the DWRPT server (`40.83.161.93`); the reporting layer is `DataStaging` (complete) + `DWRPT_AI` (complete), read access granted. No separate dump is needed and this is not a blocker — see below._

## Discovery finding

Live discovery probe against `40.83.161.93` (2026-06-14) returned the following databases:

| Database | HAS_DBACCESS |
|---|---|
| DataStaging | 1 — **documented** ([datastaging.md](datastaging.md)) |
| DWRPT_AI | 0 — **documented via dump** ([dwrpt-ai.md](dwrpt-ai.md)) |
| Feedhub | 0 — access blocked |
| Zuora | 0 — access blocked |

**No database named `DWRPT` exists on this server.** The stub was created based on early architecture notes referencing a "DWRPT reporting database." The actual reporting databases are `DataStaging` and `DWRPT_AI`, both of which are fully documented.

## Access

- **Owner:** Ron Mulder · **Researcher:** Alicia Salazar · **Status:** granted (DataStaging + DWRPT_AI documented; no standalone `DWRPT` DB exists)
- Cross-ref: [System Access Tracker](/analysis/artifacts/access-tracker/index.html)

## Open questions

1. **Does a database named `DWRPT` exist on any server?** It was not found on `40.83.161.93`. Confirm with Ron Mulder whether this is an alias for `DataStaging`, a decommissioned database, or exists on a different server.
2. **If it does exist:** grant `ConflictAI` access and run `mssql-scripter` to extract the dump, then complete this doc.
3. **If it does not exist:** mark this stub as `status: deprecated` and close out.
