"""Per-server min/max timestamp probe on the largest tables.

Reads data/{prefix}/01_tables.csv + data/{prefix}/02_timestamp_columns.csv,
filters to row_count >= MIN_ROWS, picks the most likely load-timestamp column,
probes MIN/MAX/non-NULL count. Writes data/{prefix}/03_table_date_ranges.csv.
"""
from __future__ import annotations

import csv
import sys
from pathlib import Path

from db import query

DATA_ROOT = Path(__file__).resolve().parents[1] / "data"
MIN_ROWS = 1_000_000  # only probe million+ tables on new servers (they're bigger)
TOP_N = 50


def load_tables(prefix):
    out = {}
    with (DATA_ROOT / prefix.lower() / "01_tables.csv").open() as f:
        r = csv.DictReader(f)
        for row in r:
            try:
                rc = int(row["row_count"] or 0)
            except ValueError:
                rc = 0
            out[(row["database"], row["schema"], row["table"])] = {
                "rows": rc,
                "mb": float(row["total_mb"] or 0),
            }
    return out


def load_ts(prefix):
    out = []
    with (DATA_ROOT / prefix.lower() / "02_timestamp_columns.csv").open() as f:
        r = csv.DictReader(f)
        for row in r:
            out.append((row["database"], row["schema"], row["table"], row["column"], row["data_type"]))
    return out


def pick_best(cols):
    priority = ("etl", "load", "insert", "process", "create", "modif", "updat", "date", "time")
    for needle in priority:
        for c in cols:
            if needle in c.lower():
                return c
    return cols[0]


def probe(prefix):
    print(f"\n###### {prefix} probe ######")
    tables = load_tables(prefix)
    ts = load_ts(prefix)

    by_tbl = {}
    for db, sch, tbl, col, _ in ts:
        by_tbl.setdefault((db, sch, tbl), []).append(col)

    cands = [
        (key, by_tbl[key], tables[key]["rows"], tables[key]["mb"])
        for key in by_tbl
        if key in tables and tables[key]["rows"] >= MIN_ROWS
    ]
    cands.sort(key=lambda r: r[2], reverse=True)
    cands = cands[:TOP_N]
    print(f"probing {len(cands)} tables (>= {MIN_ROWS:,} rows)")

    results = []
    for (db, sch, tbl), cols, rc, mb in cands:
        col = pick_best(cols)
        sql = (
            f"SELECT MIN([{col}]) AS min_ts, MAX([{col}]) AS max_ts, "
            f"COUNT_BIG(*) AS non_null "
            f"FROM [{sch}].[{tbl}] WITH (NOLOCK) "
            f"WHERE [{col}] IS NOT NULL"
        )
        try:
            _, rows, dt = query(sql, database=db, prefix=prefix)
            mn, mx, nn = rows[0]
            span_days = None
            if mn and mx:
                span_days = (mx - mn).days
            results.append((db, sch, tbl, col, rc, mb, str(mn) if mn else "", str(mx) if mx else "", int(nn or 0), round(dt, 2)))
            print(f"  {db}.{sch}.{tbl:38s} col={col:22s} rows={rc:>11,} span={span_days}d  q={dt:.1f}s")
        except Exception as e:
            results.append((db, sch, tbl, col, rc, mb, "", "", 0, 0))
            print(f"  ! {db}.{sch}.{tbl} ({col}): {str(e)[:120]}")

    out = DATA_ROOT / prefix.lower() / "03_table_date_ranges.csv"
    with out.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["database", "schema", "table", "ts_column", "row_count",
                    "total_mb", "min_ts", "max_ts", "non_null_count", "query_seconds"])
        for r in results:
            w.writerow(r)
    print(f"  wrote {out}")


if __name__ == "__main__":
    prefixes = sys.argv[1:] or ["DWRPT", "CIM", "RL_PROD"]
    for p in prefixes:
        try:
            probe(p)
        except Exception as e:
            print(f"  ! {p} failed: {e}")
