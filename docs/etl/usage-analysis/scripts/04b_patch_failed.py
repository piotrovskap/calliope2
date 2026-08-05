"""Re-run the 3 targets that failed in phase 2."""
import csv
from pathlib import Path
from datetime import datetime, timedelta
from db import query

DATA = Path(__file__).resolve().parents[1] / "data"

# Fixed targets
FIXES = [
    # (db, sch, tbl, col, role, recent_days, is_date_typed_no_hour)
    ("RedDawn",            "dbo", "ListingImageDownload_Queue_History", "lid_Received", "image_dl_queue_received", 730, False),
    ("RedDawn",            "dbo", "ListingImageDownload_Queue_History", "lid_Processed", "image_dl_queue_processed", 730, False),
    # ListingVehicleRepository has NO datetime — skip
    # grail_srpactions_daily & DisplayGEO are date-only — keep daily but no hour-of-day
]


def pctile(s, p):
    if not s:
        return 0
    k = (len(s) - 1) * p
    f, c = int(k), min(int(k) + 1, len(s) - 1)
    return s[f] if f == c else s[f] + (s[c] - s[f]) * (k - f)


def daily(db, sch, tbl, col):
    sql = f"""
    SELECT CAST([{col}] AS date) AS d, COUNT_BIG(*) AS n
    FROM [{sch}].[{tbl}] WITH (NOLOCK)
    WHERE [{col}] IS NOT NULL AND [{col}] >= '2018-01-01' AND [{col}] < '2027-01-01'
    GROUP BY CAST([{col}] AS date)
    ORDER BY d
    """
    _, rows, dt = query(sql, database=db)
    return rows, dt


def hod_dow(db, sch, tbl, col, recent, has_time):
    cutoff = (datetime(2026, 6, 14) - timedelta(days=recent)).strftime("%Y-%m-%d")
    out_h, out_w = [], []
    if has_time:
        sql_h = f"""
        SELECT DATEPART(hour, [{col}]), COUNT_BIG(*)
        FROM [{sch}].[{tbl}] WITH (NOLOCK)
        WHERE [{col}] >= '{cutoff}' AND [{col}] < '2027-01-01'
        GROUP BY DATEPART(hour, [{col}])
        ORDER BY 1
        """
        _, out_h, _ = query(sql_h, database=db)
    sql_w = f"""
    SELECT DATEPART(weekday, [{col}]), COUNT_BIG(*)
    FROM [{sch}].[{tbl}] WITH (NOLOCK)
    WHERE [{col}] >= '{cutoff}' AND [{col}] < '2027-01-01'
    GROUP BY DATEPART(weekday, [{col}])
    ORDER BY 1
    """
    _, out_w, _ = query(sql_w, database=db)
    return out_h, out_w


def append_summary(db, sch, tbl, col, role, series, hod, dow):
    counts = [int(n) for _, n in series]
    if not counts:
        return None
    total = sum(counts)
    cs = sorted(counts)
    p50, p95, p99 = pctile(cs, 0.5), pctile(cs, 0.95), pctile(cs, 0.99)
    max_day = max(counts)
    idx = counts.index(max_day)
    first, last = series[0][0], series[-1][0]
    span = (last - first).days + 1
    gap = round(100 * (1 - len(series) / span), 1)

    print(f"  {role}: rows={total:,}  days={len(series)}/{span} ({gap}% gaps)")
    print(f"    p50={p50:,.0f}  p95={p95:,.0f}  p99={p99:,.0f}  max={max_day:,} on {series[idx][0]}")

    # Save per-day csv
    safe = f"{db}_{sch}_{tbl}_{col}".replace(".", "_")
    with (DATA / f"10_daily_rows__{safe}.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["date", "rows"])
        for d, n in series:
            w.writerow([d.isoformat(), int(n)])

    return {
        "summary": [db, sch, tbl, col, role, total, len(series), span, gap,
                    int(p50), int(p95), int(p99), max_day,
                    str(series[idx][0]), f"{first} → {last}", ""],
        "hod": [(db, sch, tbl, role, int(h), int(n)) for h, n in hod],
        "dow": [(db, sch, tbl, role, int(d), int(n)) for d, n in dow],
    }


def main():
    new_summary = []
    new_hod = []
    new_dow = []
    for (db, sch, tbl, col, role, recent, no_hour) in FIXES:
        print(f"\n== {role}: {db}.{sch}.{tbl}.{col} ==")
        try:
            series, _ = daily(db, sch, tbl, col)
            hod, dow = hod_dow(db, sch, tbl, col, recent, has_time=not no_hour)
            res = append_summary(db, sch, tbl, col, role, series, hod, dow)
            if res:
                new_summary.append(res["summary"])
                new_hod.extend(res["hod"])
                new_dow.extend(res["dow"])
        except Exception as e:
            print(f"  ! {e}")

    # Append to existing CSVs
    for path, rows in [
        (DATA / "11_daily_summary.csv", new_summary),
        (DATA / "12_hour_of_day.csv", new_hod),
        (DATA / "13_day_of_week.csv", new_dow),
    ]:
        with path.open("a", newline="") as f:
            w = csv.writer(f)
            for r in rows:
                w.writerow(r)
        print(f"appended {len(rows)} rows to {path.name}")


if __name__ == "__main__":
    main()
