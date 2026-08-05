"""Phase 2 — daily-bucket volume per ETL-relevant table.

For each (db, schema, table, ts_col) target, compute rows per day, then
derive: total rows, days observed, daily p50/p95/p99, max-day, busy
hour-of-day, busy day-of-week, ingest gaps.

Outputs:
  data/10_daily_rows__{db}_{schema}_{table}.csv  (raw per-day series)
  data/11_daily_summary.csv                      (per-table summary stats)
  data/12_hour_of_day.csv                         (24-bucket histograms)
  data/13_day_of_week.csv                         (7-bucket histograms)
"""
from __future__ import annotations

import csv
from datetime import datetime, timedelta
from pathlib import Path

from db import query

DATA = Path(__file__).resolve().parents[1] / "data"

# (db, schema, table, ts_col, role, recent_only_days)
# recent_only_days: if set, limit hour-of-day & day-of-week analysis to last N days
TARGETS = [
    # WAREHOUSE OUTPUT TABLES
    ("Megatron",            "dbo", "ListingImageDownload_ReDownload", "lid_created",      "image_dl_queue",       730),
    ("RedDawn",             "dbo", "ListingImageDownload_Queue_History","lid_Created",    "image_dl_history",     730),
    ("MegatronRepository",  "dbo", "ListingRepository",                "lst_Created",     "listings_warehouse",   730),
    ("MegatronRepository",  "dbo", "ListingVehicleRepository",         "lvh_Created",     "vehicle_warehouse",    730),
    ("Megatron",            "dbo", "Listing",                          "lst_Created",     "listings_live",        730),
    ("Prime",               "dbo", "grail_srpactions_daily",           "event_date",      "srp_actions_daily",   1000),
    ("Prime",               "dbo", "DisplayGEO",                       "disgeo_date",     "display_geo",          730),
    ("RedDawn",             "dbo", "SmartVDPClicks",                   "event_date",      "vdp_clicks",           730),
    ("WEB",                 "dbo", "FEEDADS",                          "faCREATED",       "feed_ads",             730),
    ("WEB",                 "dbo", "FEEDEXTRAS",                       "fxDateInStock",   "feed_extras",          730),
    ("Megatron",            "dbo", "PhyronVideos",                     "created",         "phyron_videos",        730),
    ("OutboundFeeds",       "dbo", "obf_CarFax_Data",                  "llst_created",    "outbound_carfax",      730),
    # ETL META — execution + input + backup windows
    ("Megatron",            "dbo", "ActivityLog",                      "LogDateTime",     "META_activity",        365),
    ("Megatron",            "dbo", "FileDetails_Log",                  "fileLogged",      "META_file_ingest",    1500),
    ("Megatron",            "dbo", "BackupLog",                        "BackupFinishDate","META_backups",         365),
]


def daily_rows(db: str, sch: str, tbl: str, col: str):
    """Returns list of (day, rows). Filters out sentinel dates."""
    sql = f"""
    SELECT CAST([{col}] AS date) AS d, COUNT_BIG(*) AS n
    FROM [{sch}].[{tbl}] WITH (NOLOCK)
    WHERE [{col}] IS NOT NULL
      AND [{col}] >= '2018-01-01'
      AND [{col}] <  '2027-01-01'
    GROUP BY CAST([{col}] AS date)
    ORDER BY d
    """
    _, rows, dt = query(sql, database=db)
    return rows, dt


def hour_of_day(db: str, sch: str, tbl: str, col: str, recent_days: int):
    cutoff = (datetime(2026, 6, 14) - timedelta(days=recent_days)).strftime("%Y-%m-%d")
    sql = f"""
    SELECT DATEPART(hour, [{col}]) AS h, COUNT_BIG(*) AS n
    FROM [{sch}].[{tbl}] WITH (NOLOCK)
    WHERE [{col}] >= '{cutoff}'
      AND [{col}] <  '2027-01-01'
    GROUP BY DATEPART(hour, [{col}])
    ORDER BY h
    """
    _, rows, dt = query(sql, database=db)
    return rows, dt


def day_of_week(db: str, sch: str, tbl: str, col: str, recent_days: int):
    cutoff = (datetime(2026, 6, 14) - timedelta(days=recent_days)).strftime("%Y-%m-%d")
    sql = f"""
    SELECT DATEPART(weekday, [{col}]) AS dow, COUNT_BIG(*) AS n
    FROM [{sch}].[{tbl}] WITH (NOLOCK)
    WHERE [{col}] >= '{cutoff}'
      AND [{col}] <  '2027-01-01'
    GROUP BY DATEPART(weekday, [{col}])
    ORDER BY dow
    """
    _, rows, dt = query(sql, database=db)
    return rows, dt


def pctile(sorted_vals, p):
    if not sorted_vals:
        return 0
    k = (len(sorted_vals) - 1) * p
    f, c = int(k), min(int(k) + 1, len(sorted_vals) - 1)
    return sorted_vals[f] if f == c else sorted_vals[f] + (sorted_vals[c] - sorted_vals[f]) * (k - f)


def main():
    summary = []
    hod_rows = []
    dow_rows = []

    for (db, sch, tbl, col, role, recent) in TARGETS:
        print(f"\n== {role}: {db}.{sch}.{tbl}.{col} ==")
        try:
            series, dt = daily_rows(db, sch, tbl, col)
        except Exception as e:
            print(f"  ! daily_rows failed: {str(e)[:200]}")
            summary.append([db, sch, tbl, col, role, 0, 0, 0, 0, 0, 0, 0, 0, "", "", str(e)[:200]])
            continue
        counts = [int(n) for _, n in series]
        n_days = len(series)
        total = sum(counts)
        if n_days == 0:
            print(f"  empty (no rows in 2018-2027 window). q={dt:.1f}s")
            summary.append([db, sch, tbl, col, role, 0, 0, 0, 0, 0, 0, 0, 0, "", "", ""])
            continue

        # Write per-table daily series
        safe = f"{db}_{sch}_{tbl}".replace(".", "_")
        with (DATA / f"10_daily_rows__{safe}.csv").open("w", newline="") as f:
            w = csv.writer(f)
            w.writerow(["date", "rows"])
            for d, n in series:
                w.writerow([d.isoformat(), int(n)])

        counts_sorted = sorted(counts)
        p50 = pctile(counts_sorted, 0.50)
        p95 = pctile(counts_sorted, 0.95)
        p99 = pctile(counts_sorted, 0.99)
        max_day = max(counts)
        max_day_idx = counts.index(max_day)
        first_day = series[0][0]
        last_day = series[-1][0]
        span_days = (last_day - first_day).days + 1
        gap_pct = round(100.0 * (1 - n_days / span_days), 1) if span_days > 0 else 0

        print(f"  rows={total:,}  days_w_data={n_days}/{span_days} ({gap_pct}% gaps)  q={dt:.1f}s")
        print(f"  p50={p50:,.0f}  p95={p95:,.0f}  p99={p99:,.0f}  max={max_day:,} on {series[max_day_idx][0]}")

        # Hour-of-day & day-of-week (limited window)
        try:
            hod, _ = hour_of_day(db, sch, tbl, col, recent)
        except Exception as e:
            print(f"  ! hour_of_day failed: {str(e)[:150]}")
            hod = []
        try:
            dow, _ = day_of_week(db, sch, tbl, col, recent)
        except Exception as e:
            print(f"  ! day_of_week failed: {str(e)[:150]}")
            dow = []
        for h, n in hod:
            hod_rows.append([db, sch, tbl, role, int(h), int(n)])
        for d, n in dow:
            dow_rows.append([db, sch, tbl, role, int(d), int(n)])

        summary.append([
            db, sch, tbl, col, role,
            total, n_days, span_days, gap_pct,
            int(p50), int(p95), int(p99), max_day,
            str(series[max_day_idx][0]),
            f"{first_day} → {last_day}",
            "",
        ])

    with (DATA / "11_daily_summary.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["database", "schema", "table", "ts_column", "role",
                    "total_rows", "days_with_data", "span_days", "gap_pct",
                    "p50_per_day", "p95_per_day", "p99_per_day", "max_per_day",
                    "max_day", "date_range", "error"])
        for r in summary:
            w.writerow(r)

    with (DATA / "12_hour_of_day.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["database", "schema", "table", "role", "hour", "rows"])
        for r in hod_rows:
            w.writerow(r)

    with (DATA / "13_day_of_week.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["database", "schema", "table", "role", "weekday_1is_sun", "rows"])
        for r in dow_rows:
            w.writerow(r)

    print("\n== summary CSV at", DATA / "11_daily_summary.csv")


if __name__ == "__main__":
    main()
