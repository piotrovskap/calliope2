# Schema Dumps

The **authoritative raw DDL** for each database — schema-only, no data. One file per DB as `<db>.sql` matching the doc slug (e.g. `dwrpt.sql` for `../dwrpt.md`). This is the *original*; the `.md` doc is the readable description of it (originals + processed).

**Generate (schema-only):**
- SQL Server: `mssql-scripter -S <host> -d <db> --schema-only -f <db>.sql`
- PostgreSQL: `pg_dump --schema-only <db> > <db>.sql`

Rules: no row data, no secrets/connection strings; regenerate rather than hand-edit; commit the dump alongside the doc update.

_Pending — researchers add dumps as each DB is analyzed. See [../README.md](../README.md)._
