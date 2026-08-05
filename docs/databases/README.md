# Per-Database Schema Documentation

One doc per database we have access to — capturing each DB's **schema, tables, indexes, views, and ERD** so the CDP team sees exactly what each source holds without re-querying it.

**Schema research:** whoever's assigned to a database (Alicia, Luis) dumps the schema, analyzes it, and describes the structures here. Owners grant access; we capture the knowledge. The raw dump is the source of truth; the `.md` is the readable map of it. Read [`../discovery-guide.md`](../discovery-guide.md) first for the shared conventions (semantic density, originals + processed, provenance).

## What lives here

| File | What |
|---|---|
| `<db>.md` | The per-DB doc (overview, tables, indexes, views, ERD, CDP relevance). Reader-renderable. |
| `dumps/<db>.sql` | The **authoritative raw schema dump** (DDL, schema-only) — the original we describe. Keep it alongside. |
| `erd/<db>.{svg,png,dbml,drawio}` | The ERD diagram. `.svg`/`.png` renders; `.dbml`/`.drawio` is the editable source. |
| `_template.md` | Copy this to start a **new** database not already stubbed below. |
| [`data-flow.md`](data-flow.md) | End-to-end data flow diagram — all systems, all ETL paths, key identity join routes. |

## How to add a database (research workflow)

1. **Claim a stub** below (set `researcher:` to your name), or for a new DB `cp _template.md <db>.md` (kebab-case, e.g. `dwrpt.md`).
2. **Dump the schema** — DDL only, no data — into `dumps/<db>.sql`:
   - SQL Server: `mssql-scripter -S <host> -d <db> --schema-only -f dumps/<db>.sql`
   - PostgreSQL: `pg_dump --schema-only <db> > dumps/<db>.sql`
3. **Describe** tables / indexes / views in `<db>.md` — fill the template tables (purpose, PK, rough row count, anything CDP-relevant). Don't paste the whole DDL into the `.md`; link the dump.
4. **ERD** — generate from the DDL, drop `erd/<db>.svg` (+ editable source), reference it from the doc's ERD section:
   - DDL → [dbdiagram.io](https://dbdiagram.io) (paste/import → export SVG + keep the `.dbml`)
   - or [SchemaSpy](https://schemaspy.org) (auto-ERD from a live connection)
   - or hand-author a Mermaid `erDiagram` block inline for small schemas
5. **CDP relevance** — note which tables/columns feed the CDP → cross-ref [`../cdp-field-source-matrix.md`](../cdp-field-source-matrix.md).
6. **Flag open questions**, set frontmatter `status:` (pending → in-progress → complete) and `updated:`, then commit (`docs(db): describe <db> schema`).

## Reference & accuracy

Follow the [Quality standards](../discovery-guide.md#quality-standards--references): describe only what the dump shows, flag inference vs fact, cite real object names. Verify table/view/index names against the dump before asserting them.

## RL Production Server (20.65.216.199:49577)

Response Logix lead response automation platform. Discovered 2026-06-14. `oltp` is the largest single-server database in the accessible estate (196 GB, 1.13B rows). `DataOne` is blocked.

| Database | Purpose | Tables | Doc | Dump |
|---|---|---|---|---|
| [oltp](oltp.md) | Response Logix Production OLTP — consumer identity graph, leads, smart quotes, campaigns | 240 | complete | [sql](dumps/oltp.sql) |
| [oltp_Archive](oltp-archive.md) | Historical archive of high-volume tables (1.9B rows, 225 GB) | 9 | complete | — |
| [DataOne](dataone.md) | Likely VIN/vehicle reference data — access blocked | unknown | blocked | — |

## DWRPT Server (40.83.161.93)

Four databases live on the DWRPT server, all discovered on 2026-06-14. DataStaging and DWRPT_AI share nearly identical 13-schema structures and serve as the primary analytics layer for the DAS CDP platform and the AI assistant at ai.das-technology.com. Feedhub and Zuora were partially accessible — schemas inferred from ETL staging copies and backup metadata.

| Database | Purpose | Tables | Doc | Dump |
|---|---|---|---|---|
| [DataStaging](datastaging.md) | Central staging and analytics layer consolidating all DAS product lines into a single queryable surface | 100 | complete | [sql](dumps/datastaging.sql) |
| [DWRPT_AI](dwrpt-ai.md) | Data warehouse / analytics hub | ~108 | complete | [sql](dumps/dwrpt-ai.sql) |
| [Feedhub](feedhub.md) | Automotive CIM — vehicle inventory feed syndication from dealers to publisher editions | ~2 confirmed + 4–6 inferred | complete | [sql](dumps/feedhub.sql) |
| [Zuora](zuora.md) | Subscription billing and accounts-receivable platform for the full DAS dealer roster | unknown (access blocked) | complete | [sql](dumps/zuora.sql) |

## Status

Owner = who owns/grants access to the DB. Researcher = whoever's doing the analysis (claim by editing `researcher:`).

<!-- BEGIN generated: db-status-table (scripts/gen-databases.py) -->
| Database | Owner | Access | Researcher | Doc |
|---|---|---|---|---|
| [Feedhub](feedhub.md) | Ron Mulder | partial | Alicia Salazar | partial |
| [Zuora](zuora.md) | Ron Mulder | partial | Alicia Salazar | partial |
| [ML_Production](ml-production.md) | Ron Mulder | granted | Alicia Salazar | pending |
| [DataOne](dataone.md) | Unknown (RL DBA) | blocked | Alicia Salazar | blocked |
| [CIM](cim.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [CommonClientID](common-client-id.md) | Ron Mulder | partial | Alicia Salazar | complete |
| [DataStaging](datastaging.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [DWRPT](dwrpt.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [DWRPT_AI](dwrpt-ai.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [endeavorcentral](endeavorcentral.md) | Ron Mulder | granted | Alicia | complete |
| [megatron](megatron.md) | Ron Mulder | granted | Alicia | complete |
| [megatron-repository](megatron-repository.md) | Ron Mulder | granted | Alicia | complete |
| [oltp](oltp.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [oltp_Archive](oltp-archive.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [outbound-feeds](outbound-feeds.md) | Ron Mulder | granted | Alicia | complete |
| [petfinder](petfinder.md) | Ron Mulder | granted | Alicia | complete |
| [prime](prime.md) | Ron Mulder | granted | Alicia | complete |
| [reddawn](reddawn.md) | Ron Mulder | granted | Alicia | complete |
| [RL_Production](rl-production.md) | Ron Mulder | granted | Alicia Salazar | complete |
| [trax](trax.md) | Ron Mulder | granted | Alicia | complete |
| [web](web.md) | Ron Mulder | granted | Alicia | complete |
| [EDW_Staging](edw-staging.md) | Rick Sorich | na | Alicia Salazar | na |
<!-- END generated -->

_Access status mirrors the [System Access Tracker](/analysis/artifacts/access-tracker/index.html) — keep in sync. Add a row when a new DB is documented._

## Tooling TODO

Scaffold-level follow-ups (tracked on GitHub — add as we go):

- [ ] **Web ERD viewer** — render whatever ERD format we receive (`.svg`/`.png` inline, plus `.dbml` / `.drawio` / Mermaid `erDiagram` rendered client-side) so diagrams are viewable in the portal without external tools. Auto-discover `erd/*` and surface per-DB. ([#5](https://github.com/ConflictHQ/das-tech/issues/5))
- [ ] **Schema-dump browser** — render/search the DDL in `dumps/` alongside the doc (table → definition jump).
- [ ] **DB status roll-up** — drive the Status table above from frontmatter (`status`/`access`/`researcher`) instead of hand-editing.
