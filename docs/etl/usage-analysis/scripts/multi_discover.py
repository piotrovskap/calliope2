"""Phase 1 discovery against any server via env prefix.

Outputs go into data/{prefix_lower}/ to keep servers separate.
"""
from __future__ import annotations

import csv
import sys
from pathlib import Path

from db import query

DATA_ROOT = Path(__file__).resolve().parents[1] / "data"
SYSTEM_DBS = {"master", "tempdb", "model", "msdb", "rdsadmin", "distribution"}
TS_PATTERNS = (
    "%date%", "%time%", "%created%", "%modified%", "%updated%",
    "%inserted%", "%loaded%", "%load_dt%", "%loaddt%", "%etl%", "%processed%",
)


def list_databases(prefix: str):
    _, rows, _ = query(
        "SELECT name, HAS_DBACCESS(name) FROM sys.databases "
        "WHERE state_desc='ONLINE' ORDER BY name",
        prefix=prefix,
    )
    return [(r[0], int(r[1] or 0)) for r in rows if r[0].lower() not in SYSTEM_DBS]


def tables_with_size(prefix, db):
    sql = """
    SELECT s.name, t.name, p.rows,
           SUM(a.total_pages) * 8 / 1024.0,
           SUM(a.used_pages)  * 8 / 1024.0
    FROM sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
    JOIN sys.indexes i ON t.object_id = i.object_id
    JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
    JOIN sys.allocation_units a ON p.partition_id = a.container_id
    WHERE i.index_id IN (0,1) AND t.is_ms_shipped = 0
    GROUP BY s.name, t.name, p.rows
    ORDER BY p.rows DESC
    """
    return query(sql, database=db, prefix=prefix)


def timestamp_columns(prefix, db):
    where = " OR ".join([f"LOWER(c.name) LIKE '{p}'" for p in TS_PATTERNS])
    sql = f"""
    SELECT s.name, t.name, c.name, ty.name
    FROM sys.columns c
    JOIN sys.tables  t  ON c.object_id = t.object_id
    JOIN sys.schemas s  ON t.schema_id = s.schema_id
    JOIN sys.types   ty ON c.user_type_id = ty.user_type_id
    WHERE t.is_ms_shipped = 0
      AND ty.name IN ('datetime','datetime2','smalldatetime','date','datetimeoffset')
      AND ({where})
    ORDER BY s.name, t.name, c.name
    """
    return query(sql, database=db, prefix=prefix)


def write_csv(path, cols, rows):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(cols)
        for r in rows:
            w.writerow(r)


def main(prefix):
    out = DATA_ROOT / prefix.lower()
    print(f"\n###### {prefix} → {out} ######")
    dbs = list_databases(prefix)
    print(f"== databases ({len(dbs)}) ==")
    for name, access in dbs:
        flag = "✓" if access else "✗"
        print(f"  {flag} {name}")
    write_csv(out / "00_databases.csv", ["database", "has_access"], dbs)

    all_tables, all_ts = [], []
    for db, access in dbs:
        if not access:
            print(f"\n== {db}: SKIP (no access) ==")
            continue
        print(f"\n== {db}: tables ==")
        try:
            _, rows, dt = tables_with_size(prefix, db)
            print(f"  {len(rows)} tables in {dt:.2f}s")
            for r in rows:
                all_tables.append((db, *r))
        except Exception as e:
            print(f"  ! tables_with_size: {str(e)[:200]}")
            continue
        try:
            _, rows, dt = timestamp_columns(prefix, db)
            print(f"  {len(rows)} timestamp-like cols in {dt:.2f}s")
            for r in rows:
                all_ts.append((db, *r))
        except Exception as e:
            print(f"  ! timestamp_columns: {str(e)[:200]}")

    write_csv(out / "01_tables.csv",
              ["database", "schema", "table", "row_count", "total_mb", "used_mb"],
              all_tables)
    write_csv(out / "02_timestamp_columns.csv",
              ["database", "schema", "table", "column", "data_type"],
              all_ts)

    print(f"\n== {prefix} summary ==")
    accessible = sum(1 for _, a in dbs if a)
    print(f"  databases: {len(dbs)} total, {accessible} accessible")
    print(f"  tables:    {len(all_tables)}")
    print(f"  ts cols:   {len(all_ts)}")
    top = sorted(all_tables, key=lambda r: (r[3] or 0), reverse=True)[:15]
    print(f"\n  top 15 tables by row_count:")
    for db, sch, tbl, rc, tmb, _ in top:
        print(f"    {db}.{sch}.{tbl:40s}  rows={rc:>12,}  size={tmb or 0:>8.1f} MB")


if __name__ == "__main__":
    prefixes = sys.argv[1:] or ["DWRPT", "CIM"]
    for p in prefixes:
        try:
            main(p)
        except Exception as e:
            print(f"\n###### {p} FAILED: {e} ######")
