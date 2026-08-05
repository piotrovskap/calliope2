# ERD Diagrams

One ERD per database. Drop files here as `<db>.<ext>` matching the slug of the doc in the parent folder (e.g. `dwrpt.svg` for `../dwrpt.md`).

| Ext | Role |
|---|---|
| `.svg` / `.png` | Rendered diagram (referenced from the DB doc's **ERD** section). SVG preferred — crisp, diff-able. |
| `.dbml` / `.drawio` | **Editable source** — keep alongside the rendered image so the ERD can be regenerated. |

**Generate from a schema dump:**
- [dbdiagram.io](https://dbdiagram.io) — paste/import DDL → export SVG, keep the `.dbml`.
- [SchemaSpy](https://schemaspy.org) — auto-ERD from a live connection.
- Mermaid `erDiagram` — hand-author inline in the DB doc for small schemas.

_Pending — researchers add diagrams as each DB is analyzed. See [../README.md](../README.md)._
