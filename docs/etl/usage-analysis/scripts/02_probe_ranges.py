"""Phase 1b — for every table with >= MIN_ROWS and at least one timestamp-like
column, probe the min/max of that column to surface real ETL output tables.

Cheap query per column: SELECT MIN, MAX, COUNT(*) WHERE col IS NOT NULL.
We use `WITH (NOLOCK)` to avoid blocking production.
"""
from __future__ import annotations

import csv
from pathlib import Path

from db import query

DATA = Path(__file__).resolve().parents[1] / "data"
MIN_ROWS = 100_000  # focus on tables that actually matter for sizing
TOP_N = 200          # safety cap on probes


def load_tables():
    tables = {}
    with (DATA / "01_tables.csv").open() as f:
        r = csv.DictReader(f)
        for row in r:
            try:
                rc = int(row["row_count"] or 0)
            except ValueError:
                rc = 0
            tables[(row["database"], row["schema"], row["table"])] = {
                "rows": rc,
                "mb": float(row["total_mb"] or 0),
            }
    return tables


def load_ts_cols():
    out = []
    with (DATA / "02_timestamp_columns.csv").open() as f:
        r = csv.DictReader(f)
        for row in r:
            out.append((row["database"], row["schema"], row["table"], row["column"], row["data_type"]))
    return out


def pick_best_ts_col(cols: list[str]) -> str:
    """Prefer load/created/inserted timestamps; fall back to first available."""
    priority = ("etl", "load", "insert", "process", "create", "modif", "updat", "date", "time")
    for needle in priority:
        for c in cols:
            if needle in c.lower():
                return c
    return cols[0]


def main():
    tables = load_tables()
    ts_cols = load_ts_cols()

    # group ts columns by (db, schema, table)
    by_tbl: dict[tuple, list[str]] = {}
    for db, sch, tbl, col, _ty in ts_cols:
        by_tbl.setdefault((db, sch, tbl), []).append(col)

    # rank candidates by row count desc, filter MIN_ROWS, cap at TOP_N
    candidates = [
        (key, by_tbl[key], tables[key]["rows"], tables[key]["mb"])
        for key in by_tbl
        if key in tables and tables[key]["rows"] >= MIN_ROWS
    ]
    candidates.sort(key=lambda r: r[2], reverse=True)
    candidates = candidates[:TOP_N]
    print(f"probing {len(candidates)} candidate tables (>= {MIN_ROWS:,} rows)")

    results = []
    for (db, sch, tbl), cols, rc, mb in candidates:
        col = pick_best_ts_col(cols)
        sql = (
            f"SELECT MIN([{col}]) AS min_ts, MAX([{col}]) AS max_ts, "
            f"COUNT_BIG(*) AS non_null "
            f"FROM [{sch}].[{tbl}] WITH (NOLOCK) "
            f"WHERE [{col}] IS NOT NULL"
        )
        try:
            _, rows, dt = query(sql, database=db)
            mn, mx, nn = rows[0]
            results.append((db, sch, tbl, col, rc, mb, str(mn) if mn else "", str(mx) if mx else "", int(nn or 0), round(dt, 2)))
            span_days = None
            if mn and mx:
                span_days = (mx - mn).days
            print(f"  {db}.{sch}.{tbl:40s} col={col:25s} rows={rc:>11,} span={span_days}d  q={dt:.1f}s")
        except Exception as e:
            results.append((db, sch, tbl, col, rc, mb, "", "", 0, 0))
            print(f"  ! {db}.{sch}.{tbl} ({col}): {str(e)[:120]}")

    with (DATA / "03_table_date_ranges.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["database", "schema", "table", "ts_column", "row_count",
                    "total_mb", "min_ts", "max_ts", "non_null_count", "query_seconds"])
        for r in results:
            w.writerow(r)

    print(f"\nwrote {DATA / '03_table_date_ranges.csv'}")


if __name__ == "__main__":
    main()
