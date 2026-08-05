#!/usr/bin/env python3
"""
Common Client ID Coverage Map
==============================
Phase 0 deliverable — specs/01-phase-0-discovery/03-data-inventory/02-common-client-id-map.md

Queries every known DAS SQL Server database and produces a coverage matrix:
  - DETERMINISTIC: table carries common_client_id with ≥ threshold % non-null rows
  - PARTIAL:       column present but low coverage (< threshold)
  - SCHEMA ONLY:   column exists, no rows to measure
  - ABSENT:        no common_client_id column — fuzzy matching required

Output: console table + docs/databases/common-client-id-coverage.md

Usage:
    pip install pyodbc pandas tabulate
    python scripts/common-client-id-coverage.py

    # Override connection string:
    CCID_SERVER=20.51.108.231 CCID_USER=ConflictAI CCID_PASS=... python scripts/common-client-id-coverage.py

    # Dry-run (schema only, skip row counts — faster, safe on large tables):
    python scripts/common-client-id-coverage.py --schema-only

    # Limit to specific databases:
    python scripts/common-client-id-coverage.py --databases Megatron,EDW_Staging,DWRPT
"""

import os
import sys
import argparse
import datetime
from typing import Optional

# ── Configuration ─────────────────────────────────────────────────────────────

SERVER   = os.getenv("CCID_SERVER", "20.51.108.231")
PORT     = int(os.getenv("CCID_PORT", "1433"))
USER     = os.getenv("CCID_USER",   "ConflictAI")
PASSWORD = os.getenv("CCID_PASS",   "")  # set CCID_PASS env var — see .env
DRIVER   = os.getenv("CCID_DRIVER", "ODBC Driver 17 for SQL Server")

# Coverage threshold: % non-null rows to call a column "deterministic"
DETERMINISTIC_THRESHOLD = 80  # %

# Column name variants to search for (case-insensitive)
CCID_COLUMN_VARIANTS = [
    "common_client_id",
    "CommonClientId",
    "ccid",
    "client_id",          # only in identity-mapping tables (see note below)
    "MccId",              # Megatron CommonClientIdMapping
]

# Databases to audit — add DWRPT / EDW_Staging when access is granted
DATABASES = [
    # ── Already accessible ──────────────────────────────────────────────────
    {"name": "Megatron",            "tier": "core",    "role": "Advertiser / Listing hub"},
    {"name": "EndeavorCentral",     "tier": "core",    "role": "Sales / billing"},
    {"name": "MegatronRepository",  "tier": "archive", "role": "Historical leads / listings"},
    {"name": "OutboundFeeds",       "tier": "dist",    "role": "Feed distribution"},
    {"name": "PetFinder",           "tier": "vert",    "role": "Pet vertical"},
    {"name": "prime",               "tier": "perf",    "role": "Performance advertising"},
    {"name": "RedDawn",             "tier": "crawl",   "role": "Web crawlers"},
    {"name": "Trax",                "tier": "analytics","role": "Traffic analytics"},
    {"name": "web",                 "tier": "core",    "role": "Main website / listings"},
    # ── Pending access — uncomment when Ron Mulder provisions ───────────────
    # {"name": "DWRPT",             "tier": "dw",      "role": "Data warehouse / reporting"},
    # {"name": "EDW_Staging",       "tier": "dw",      "role": "EDW staging (DMS/CRM/CVH)"},
    # {"name": "CIM",               "tier": "inv",     "role": "Central inventory management"},
    # {"name": "ML_Production",     "tier": "legacy",  "role": "MediaLogix"},
    # {"name": "RL_Production",     "tier": "legacy",  "role": "Response Logic OLTP"},
]

# Tables known to be identity-mapping tables (common_client_id IS the subject)
MAPPING_TABLES = {
    "CommonClientIdMapping",
    "ClientId_Mapping",
    "ClientIdMapping",
    "MappingClient",
}

# ── SQL Queries ────────────────────────────────────────────────────────────────

SCHEMA_QUERY = """
SELECT
    t.TABLE_SCHEMA,
    t.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.IS_NULLABLE,
    c.CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS c
JOIN INFORMATION_SCHEMA.TABLES t
    ON  t.TABLE_NAME   = c.TABLE_NAME
    AND t.TABLE_SCHEMA = c.TABLE_SCHEMA
WHERE t.TABLE_TYPE = 'BASE TABLE'
  AND LOWER(c.COLUMN_NAME) IN ({placeholders})
ORDER BY t.TABLE_NAME, c.COLUMN_NAME
"""

COVERAGE_QUERY = """
SELECT
    COUNT(*)                                    AS total_rows,
    COUNT([{col}])                              AS non_null_rows,
    COUNT(DISTINCT [{col}])                     AS distinct_values,
    CASE WHEN COUNT(*) = 0 THEN NULL
         ELSE CAST(COUNT([{col}]) * 100.0 / COUNT(*) AS DECIMAL(5,1))
    END                                         AS coverage_pct
FROM [{schema}].[{table}] WITH (NOLOCK)
"""

ROW_COUNT_QUERY = """
SELECT SUM(p.row_count) AS row_count
FROM sys.dm_db_partition_stats p
JOIN sys.objects o ON o.object_id = p.object_id
JOIN sys.schemas s ON s.schema_id = o.schema_id
WHERE o.name = ? AND s.name = ? AND p.index_id IN (0,1)
"""

OUTPUT_PATH = os.path.join(
    os.path.dirname(__file__), "..", "docs", "databases", "common-client-id-coverage.md"
)

# ── Helpers ────────────────────────────────────────────────────────────────────

def make_conn_str(database: str) -> str:
    return (
        f"DRIVER={{{DRIVER}}};"
        f"SERVER={SERVER},{PORT};"
        f"DATABASE={database};"
        f"UID={USER};"
        f"PWD={PASSWORD};"
        f"TrustServerCertificate=yes;"
    )


def classify(has_column: bool, coverage_pct: Optional[float], is_mapping_table: bool) -> str:
    if is_mapping_table:
        return "MAPPING TABLE"
    if not has_column:
        return "ABSENT"
    if coverage_pct is None:
        return "SCHEMA ONLY"
    if coverage_pct >= DETERMINISTIC_THRESHOLD:
        return "DETERMINISTIC"
    if coverage_pct > 0:
        return "PARTIAL"
    return "ABSENT (null)"


STATUS_EMOJI = {
    "DETERMINISTIC":  "✅",
    "PARTIAL":        "🟡",
    "SCHEMA ONLY":    "🔵",
    "MAPPING TABLE":  "🗝️",
    "ABSENT":         "⛔",
    "ABSENT (null)":  "⛔",
    "ERROR":          "❌",
    "NO ACCESS":      "🔒",
}

# ── Core audit ────────────────────────────────────────────────────────────────

def audit_database(db_info: dict, schema_only: bool) -> list[dict]:
    """Return list of result rows for one database."""
    import pyodbc

    db_name = db_info["name"]
    results = []

    try:
        conn = pyodbc.connect(make_conn_str(db_name), timeout=15)
    except Exception as e:
        return [{"database": db_name, "tier": db_info["tier"], "role": db_info["role"],
                 "table": "—", "column": "—", "status": "NO ACCESS",
                 "coverage_pct": None, "total_rows": None, "distinct_values": None,
                 "notes": str(e)[:120]}]

    cursor = conn.cursor()

    # Find tables with any CCID column variant
    col_lower = [v.lower() for v in CCID_COLUMN_VARIANTS]
    placeholders = ",".join(f"'{v}'" for v in col_lower)
    try:
        cursor.execute(SCHEMA_QUERY.format(placeholders=placeholders))
        hits = cursor.fetchall()
    except Exception as e:
        conn.close()
        return [{"database": db_name, "tier": db_info["tier"], "role": db_info["role"],
                 "table": "—", "column": "—", "status": "ERROR",
                 "coverage_pct": None, "total_rows": None, "distinct_values": None,
                 "notes": str(e)[:120]}]

    if not hits:
        results.append({
            "database": db_name, "tier": db_info["tier"], "role": db_info["role"],
            "table": "(none)", "column": "—", "status": "ABSENT",
            "coverage_pct": None, "total_rows": None, "distinct_values": None,
            "notes": "No common_client_id variant found in any table",
        })
        conn.close()
        return results

    for row in hits:
        schema, table, column, dtype, nullable, max_len = row
        is_mapping = table in MAPPING_TABLES
        result = {
            "database":        db_name,
            "tier":            db_info["tier"],
            "role":            db_info["role"],
            "table":           f"{schema}.{table}",
            "column":          column,
            "dtype":           dtype,
            "coverage_pct":    None,
            "total_rows":      None,
            "distinct_values": None,
            "status":          None,
            "notes":           "",
        }

        if not schema_only:
            try:
                # Get fast row count estimate first
                cursor.execute(ROW_COUNT_QUERY, table, schema)
                rc = cursor.fetchone()
                est_rows = rc[0] if rc and rc[0] is not None else 0

                if est_rows == 0:
                    result["total_rows"] = 0
                    result["status"] = classify(True, None, is_mapping)
                    result["notes"] = "Empty table"
                else:
                    cursor.execute(
                        COVERAGE_QUERY.format(col=column, schema=schema, table=table)
                    )
                    cov = cursor.fetchone()
                    if cov:
                        result["total_rows"]      = cov[0]
                        result["coverage_pct"]    = float(cov[3]) if cov[3] is not None else None
                        result["distinct_values"] = cov[2]
                        result["status"] = classify(True, result["coverage_pct"], is_mapping)
            except Exception as e:
                result["status"] = "ERROR"
                result["notes"]  = str(e)[:120]
        else:
            result["status"] = classify(True, None, is_mapping)
            result["notes"]  = "schema-only mode"

        results.append(result)

    conn.close()
    return results


# ── Output ────────────────────────────────────────────────────────────────────

def render_markdown(all_results: list[dict], args) -> str:
    today = datetime.date.today().isoformat()

    summary_counts = {}
    for r in all_results:
        s = r["status"] or "?"
        summary_counts[s] = summary_counts.get(s, 0) + 1

    det   = summary_counts.get("DETERMINISTIC", 0)
    part  = summary_counts.get("PARTIAL", 0)
    abs_  = summary_counts.get("ABSENT", 0) + summary_counts.get("ABSENT (null)", 0)
    map_  = summary_counts.get("MAPPING TABLE", 0)
    locked = summary_counts.get("NO ACCESS", 0)

    lines = [
        "---",
        "title: Common Client ID — Coverage Map",
        "type: analysis",
        f"updated: {today}",
        "status: in-progress",
        "depends_on: specs/01-phase-0-discovery/03-data-inventory/02-common-client-id-map",
        "---",
        "",
        "# Common Client ID — Coverage Map",
        "",
        f"> Generated {today} · {'' if args.schema_only else 'row counts included · '}server `{SERVER}`",
        "",
        "Maps which DAS source systems carry a `common_client_id` (or equivalent) column,",
        "and what percentage of rows are populated — determining whether identity resolution",
        "can be **deterministic** (join on CCID) or must fall back to **fuzzy matching**.",
        "",
        "## Summary",
        "",
        f"| Status | Count |",
        f"|---|---|",
        f"| ✅ Deterministic (≥{DETERMINISTIC_THRESHOLD}% coverage) | {det} |",
        f"| 🟡 Partial (column present, low coverage) | {part} |",
        f"| 🗝️ Mapping table (CCID is the subject) | {map_} |",
        f"| ⛔ Absent (fuzzy matching required) | {abs_} |",
        f"| 🔒 No access yet | {locked} |",
        "",
        "## Coverage Matrix",
        "",
        "| Database | Tier | Table | Column | Status | Coverage | Distinct | Notes |",
        "|---|---|---|---|---|---|---|---|",
    ]

    for r in sorted(all_results, key=lambda x: (x["database"], x["table"])):
        emoji  = STATUS_EMOJI.get(r["status"] or "?", "?")
        status = f"{emoji} {r['status']}"
        cov    = f"{r['coverage_pct']:.1f}%" if r["coverage_pct"] is not None else "—"
        rows   = f"{r['total_rows']:,}" if r["total_rows"] is not None else "—"
        dist   = f"{r['distinct_values']:,}" if r["distinct_values"] is not None else "—"
        col    = f"`{r['column']}`" if r.get("column") and r["column"] != "—" else "—"
        tbl    = f"`{r['table']}`" if r.get("table") and r["table"] not in ("—", "(none)") else r.get("table", "—")
        notes  = r.get("notes", "")
        lines.append(
            f"| **{r['database']}** | {r['tier']} | {tbl} | {col} | {status} | {cov} / {rows} rows | {dist} | {notes} |"
        )

    lines += [
        "",
        "## Identity Resolution Strategy (inferred from coverage)",
        "",
        "Based on the coverage above:",
        "",
        "- **Deterministic path** — use `common_client_id` as the primary join key for any",
        "  source table with ≥80% coverage. No probabilistic step needed.",
        "",
        "- **Partial coverage** — join on `common_client_id` where present; fall back to",
        "  email + phone + VIN fuzzy matching for null rows. Flag in CDP identity graph",
        "  as lower-confidence links.",
        "",
        "- **Absent** — source system has no CCID. Identity resolution is fully probabilistic:",
        "  email → phone → VIN → name+zip. These sources go into the CDP review queue for",
        "  manual resolution above a configurable conflict threshold.",
        "",
        "- **Mapping tables** — `CommonClientIdMapping` and siblings are the authoritative",
        "  cross-system lookup. The CDP ingest pipeline should load these first, before any",
        "  other table, to populate the identity graph seed layer.",
        "",
        "## Data quality notes",
        "",
        "- `common_client_id` in `Megatron.Client` has known cleanliness issues (flagged at",
        "  kickoff 2026-05-27 by Ron Mulder). Run the audit queries below before relying on",
        "  coverage numbers for identity design.",
        "- `Megatron.CommonClientIdMapping` maps `acc_id + sales_channel_id → client_id`.",
        "  The `ref_id` column holds the external system reference. Confirm `client_id` is",
        "  the same namespace as `common_client_id` in `Client`.",
        "",
        "## Audit queries",
        "",
        "Run these against `Megatron` to validate coverage before using in CDP:",
        "",
        "```sql",
        "-- 1. Null rate for common_client_id in Client",
        "SELECT",
        "    COUNT(*)                                  AS total,",
        "    COUNT(common_client_id)                   AS non_null,",
        "    COUNT(DISTINCT common_client_id)          AS distinct_ids,",
        "    CAST(COUNT(common_client_id) * 100.0",
        "         / COUNT(*) AS DECIMAL(5,1))          AS pct_populated",
        "FROM [Client] WITH (NOLOCK);",
        "",
        "-- 2. CommonClientIdMapping — check for duplicate acc_id mappings",
        "SELECT acc_id, COUNT(*) AS mapping_count",
        "FROM [CommonClientIdMapping]",
        "GROUP BY acc_id",
        "HAVING COUNT(*) > 1",
        "ORDER BY mapping_count DESC;",
        "",
        "-- 3. Cross-check: Client.common_client_id vs CommonClientIdMapping.client_id",
        "SELECT",
        "    c.acc_ID,",
        "    c.common_client_id        AS client_common_client_id,",
        "    m.client_id               AS mapping_client_id,",
        "    CASE WHEN CAST(c.common_client_id AS VARCHAR) = m.client_id",
        "         THEN 'MATCH' ELSE 'MISMATCH' END AS id_match",
        "FROM [Client] c",
        "LEFT JOIN [CommonClientIdMapping] m ON m.acc_id = c.acc_ID",
        "WHERE c.common_client_id IS NOT NULL",
        "ORDER BY id_match DESC;",
        "```",
        "",
        "## Pending databases (access not yet granted)",
        "",
        "These were not included in this run. Re-run after Ron Mulder provisions access:",
        "",
        "| Database | Role | Why it matters for CCID |",
        "|---|---|---|",
        "| `DWRPT` | Data warehouse | Views likely join on CCID — coverage here = reporting layer coverage |",
        "| `EDW_Staging` | ETL staging | `source_dms_*`, `source_CRM_*` — raw DMS/CRM records; CCID presence here = upstream coverage |",
        "| `CIM` | Central Inventory | Inventory records may carry dealer CCID |",
        "| `ML_Production` | MediaLogix | Legacy CRM/engagement — unknown CCID adoption |",
        "| `RL_Production` | Response Logic | Legacy OLTP — unknown CCID adoption |",
        "",
        "---",
        "",
        f"_Script: `scripts/common-client-id-coverage.py` · Researcher: Alicia Salazar · {today}_",
    ]

    return "\n".join(lines)


# ── Main ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Common Client ID coverage audit")
    parser.add_argument("--schema-only", action="store_true",
                        help="Skip row counts (faster; safe on large tables like Web/Megatron)")
    parser.add_argument("--databases", type=str, default=None,
                        help="Comma-separated list of DB names to audit (default: all configured)")
    parser.add_argument("--threshold", type=int, default=DETERMINISTIC_THRESHOLD,
                        help=f"Coverage %% to call deterministic (default: {DETERMINISTIC_THRESHOLD})")
    parser.add_argument("--output", type=str, default=None,
                        help="Output markdown path (default: docs/databases/common-client-id-coverage.md)")
    args = parser.parse_args()
    det_threshold = args.threshold

    try:
        import pyodbc
    except ImportError:
        print("ERROR: pyodbc not installed. Run: pip install pyodbc")
        sys.exit(1)

    databases = DATABASES
    if args.databases:
        wanted = {d.strip().lower() for d in args.databases.split(",")}
        databases = [d for d in DATABASES if d["name"].lower() in wanted]
        if not databases:
            print(f"ERROR: none of the requested databases match configured list.")
            sys.exit(1)

    print(f"DAS — Common Client ID Coverage Audit")
    print(f"Server : {SERVER}:{PORT}")
    print(f"Mode   : {'schema-only' if args.schema_only else 'full (row counts)'}")
    print(f"DBs    : {len(databases)}")
    print(f"Threshold: {det_threshold}%")
    print()

    all_results = []
    for db_info in databases:
        print(f"  Auditing {db_info['name']} ... ", end="", flush=True)
        rows = audit_database(db_info, args.schema_only)
        all_results.extend(rows)
        statuses = {r["status"] for r in rows}
        print(", ".join(statuses))

    print()
    print("Results:")
    try:
        from tabulate import tabulate
        table_data = [
            [r["database"], r["table"], r["column"],
             f"{STATUS_EMOJI.get(r['status'],'?')} {r['status']}",
             f"{r['coverage_pct']:.1f}%" if r["coverage_pct"] is not None else "—"]
            for r in all_results
        ]
        print(tabulate(table_data,
                       headers=["Database", "Table", "Column", "Status", "Coverage"],
                       tablefmt="simple"))
    except ImportError:
        for r in all_results:
            print(f"  {r['database']:20} {r['table']:40} {r['status']}")

    # Write markdown
    md = render_markdown(all_results, args)
    out_path = args.output or os.path.normpath(
        os.path.join(os.path.dirname(__file__), OUTPUT_PATH)
    )
    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(md)
    print(f"\nMarkdown written to: {out_path}")


if __name__ == "__main__":
    main()
