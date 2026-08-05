"""Phase 1 — discovery.

Enumerates user databases, then for each: tables with row counts, disk size,
timestamp-like columns, and (if present) a date-range sample for the most
recent timestamp column.

Outputs CSVs into ../data/.
"""
from __future__ import annotations

import csv
from pathlib import Path

from db import connect, query

DATA = Path(__file__).resolve().parents[1] / "data"
DATA.mkdir(parents=True, exist_ok=True)

# System DBs to skip
SYSTEM_DBS = {"master", "tempdb", "model", "msdb", "rdsadmin", "distribution"}

# Column-name patterns that hint at "this is when the row was loaded/created/updated"
TS_PATTERNS = (
    "%date%", "%time%", "%created%", "%modified%", "%updated%",
    "%inserted%", "%loaded%", "%load_dt%", "%loaddt%", "%etl%", "%processed%",
)


def list_databases() -> list[str]:
    cols, rows, _ = query("SELECT name FROM sys.databases WHERE state_desc='ONLINE' ORDER BY name")
    return [r[0] for r in rows if r[0].lower() not in SYSTEM_DBS]


def tables_with_size(db: str):
    sql = """
    SELECT
        s.name        AS [schema],
        t.name        AS [table],
        p.rows        AS row_count,
        SUM(a.total_pages) * 8 / 1024.0 AS total_mb,
        SUM(a.used_pages)  * 8 / 1024.0 AS used_mb
    FROM sys.tables t
    JOIN sys.schemas s        ON t.schema_id = s.schema_id
    JOIN sys.indexes i        ON t.object_id = i.object_id
    JOIN sys.partitions p     ON i.object_id = p.object_id AND i.index_id = p.index_id
    JOIN sys.allocation_units a ON p.partition_id = a.container_id
    WHERE i.index_id IN (0,1)  -- heap or clustered = base table footprint
      AND t.is_ms_shipped = 0
    GROUP BY s.name, t.name, p.rows
    ORDER BY p.rows DESC
    """
    return query(sql, database=db)


def timestamp_columns(db: str):
    where = " OR ".join([f"LOWER(c.name) LIKE '{p}'" for p in TS_PATTERNS])
    sql = f"""
    SELECT
        s.name AS [schema],
        t.name AS [table],
        c.name AS column_name,
        ty.name AS data_type
    FROM sys.columns c
    JOIN sys.tables  t  ON c.object_id = t.object_id
    JOIN sys.schemas s  ON t.schema_id = s.schema_id
    JOIN sys.types   ty ON c.user_type_id = ty.user_type_id
    WHERE t.is_ms_shipped = 0
      AND ty.name IN ('datetime','datetime2','smalldatetime','date','datetimeoffset')
      AND ({where})
    ORDER BY s.name, t.name, c.name
    """
    return query(sql, database=db)


def write_csv(path: Path, cols, rows):
    with path.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(cols)
        for r in rows:
            w.writerow(r)


def main():
    print("== databases ==")
    dbs = list_databases()
    for d in dbs:
        print(f"  - {d}")

    write_csv(DATA / "00_databases.csv", ["database"], [(d,) for d in dbs])

    all_tables, all_ts = [], []
    for db in dbs:
        print(f"\n== {db}: tables ==")
        try:
            cols, rows, dt = tables_with_size(db)
        except Exception as e:
            print(f"  ! tables_with_size failed: {e}")
            continue
        print(f"  {len(rows)} tables in {dt:.2f}s")
        for r in rows:
            all_tables.append((db, *r))

        try:
            tcols, trows, tdt = timestamp_columns(db)
        except Exception as e:
            print(f"  ! timestamp_columns failed: {e}")
            continue
        print(f"  {len(trows)} timestamp-like cols in {tdt:.2f}s")
        for r in trows:
            all_ts.append((db, *r))

    write_csv(
        DATA / "01_tables.csv",
        ["database", "schema", "table", "row_count", "total_mb", "used_mb"],
        all_tables,
    )
    write_csv(
        DATA / "02_timestamp_columns.csv",
        ["database", "schema", "table", "column", "data_type"],
        all_ts,
    )

    # Quick summary on stdout
    print("\n== summary ==")
    print(f"databases: {len(dbs)}")
    print(f"tables:    {len(all_tables)}")
    print(f"ts cols:   {len(all_ts)}")
    # top-10 biggest tables by row count across all dbs
    top = sorted(all_tables, key=lambda r: (r[3] or 0), reverse=True)[:15]
    print("\ntop tables by row_count:")
    for db, sch, tbl, rc, tmb, umb in top:
        print(f"  {db}.{sch}.{tbl:40s}  rows={rc:>12,}  size={tmb or 0:>8.1f} MB")


if __name__ == "__main__":
    main()
