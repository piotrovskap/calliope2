"""Aggregate stats across all process_log_* tables on RL_PROD.oltp.

Builds a single read query via UNION ALL, scoped to (component, subject, type)
to keep result sets bounded.

Outputs:
  data/rl_prod/41_process_log_servers.csv          per-server activity
  data/rl_prod/42_process_log_components.csv       per-component activity
  data/rl_prod/43_process_log_subjects.csv         per-process (subject) activity
  data/rl_prod/44_process_log_daily.csv            daily volume + exception count
  data/rl_prod/45_process_log_hour_of_day.csv      hour-of-day across all weeks
  data/rl_prod/46_process_log_durations.csv        parsed durations per subject
"""
from __future__ import annotations

import csv
from pathlib import Path

from db import query

DATA = Path(__file__).resolve().parents[1] / "data" / "rl_prod"
DATA.mkdir(parents=True, exist_ok=True)

# Discovered tables (including current "process_log")
TABLES = [
    "process_log",
    "process_log_20260613T23", "process_log_20260606T23", "process_log_20260530T23",
    "process_log_20260523T23", "process_log_20260516T23", "process_log_20260509T23",
    "process_log_20260502T23", "process_log_20260425T23", "process_log_20260418T23",
    "process_log_20260411T23", "process_log_20260404T23",
]


def union_subset(cols: str, where: str = "") -> str:
    parts = [f"SELECT {cols} FROM dbo.[{t}] WITH (NOLOCK) {where}" for t in TABLES]
    return " UNION ALL ".join(parts)


def run(sql: str, label: str):
    print(f"\n== {label} ==")
    _, rows, dt = query(sql, database="oltp", prefix="RL_PROD")
    print(f"  q={dt:.1f}s, {len(rows)} rows")
    return rows


def write_csv(name, cols, rows):
    p = DATA / name
    with p.open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(cols)
        for r in rows:
            w.writerow([str(v) if v is not None else "" for v in r])
    print(f"  wrote {p}")


# 1) Per-server
sql = f"""
WITH all_log AS ({union_subset('server, type, created_date')})
SELECT server,
       COUNT_BIG(*) AS total,
       SUM(CASE WHEN type = 'Exception' THEN 1 ELSE 0 END) AS exceptions,
       MIN(created_date) AS first_seen,
       MAX(created_date) AS last_seen,
       COUNT(DISTINCT CAST(created_date AS date)) AS days
FROM all_log
GROUP BY server
ORDER BY total DESC
"""
rows = run(sql, "per-server")
for r in rows:
    print(f"  {str(r[0])[:30]:30s} total={int(r[1]):>10,}  exc={int(r[2]):>7,}  days={int(r[5]):>3}  {r[3]} → {r[4]}")
write_csv("41_process_log_servers.csv",
          ["server", "total", "exceptions", "first_seen", "last_seen", "days"], rows)

# 2) Per-component
sql = f"""
WITH all_log AS ({union_subset('component, type')})
SELECT TOP 50 component,
       COUNT_BIG(*) AS total,
       SUM(CASE WHEN type = 'Exception' THEN 1 ELSE 0 END) AS exceptions
FROM all_log
GROUP BY component
ORDER BY total DESC
"""
rows = run(sql, "per-component")
for r in rows[:20]:
    print(f"  {str(r[0])[:40]:40s} total={int(r[1]):>10,}  exc={int(r[2]):>7,}")
write_csv("42_process_log_components.csv",
          ["component", "total", "exceptions"], rows)

# 3) Per-subject (the actual process name)
sql = f"""
WITH all_log AS ({union_subset('component, subject, type, created_date')})
SELECT TOP 200 component,
       subject,
       COUNT_BIG(*) AS total,
       SUM(CASE WHEN type = 'Exception' THEN 1 ELSE 0 END) AS exceptions,
       COUNT(DISTINCT CAST(created_date AS date)) AS days_active,
       MIN(created_date) AS first_seen,
       MAX(created_date) AS last_seen
FROM all_log
GROUP BY component, subject
ORDER BY total DESC
"""
rows = run(sql, "per-process (subject)")
for r in rows[:25]:
    pct_exc = 100.0 * int(r[3]) / int(r[2]) if int(r[2]) > 0 else 0
    print(f"  {str(r[0])[:18]:18s} | {str(r[1])[:55]:55s} total={int(r[2]):>9,}  exc={int(r[3]):>6,} ({pct_exc:4.1f}%)  days={int(r[4]):>3}")
write_csv("43_process_log_subjects.csv",
          ["component", "subject", "total", "exceptions", "days_active",
           "first_seen", "last_seen"], rows)

# 4) Daily volume + exceptions
sql = f"""
WITH all_log AS ({union_subset('created_date, type')})
SELECT CAST(created_date AS date) AS d,
       COUNT_BIG(*) AS total,
       SUM(CASE WHEN type = 'Exception' THEN 1 ELSE 0 END) AS exceptions
FROM all_log
GROUP BY CAST(created_date AS date)
ORDER BY d
"""
rows = run(sql, "daily volume")
print(f"  first day: {rows[0][0]}  last day: {rows[-1][0]}")
totals = [int(r[1]) for r in rows]
excs = [int(r[2]) for r in rows]
print(f"  total events: {sum(totals):,}  total exceptions: {sum(excs):,}  ({100*sum(excs)/sum(totals):.2f}% err)")
print(f"  daily avg: {sum(totals)/len(totals):,.0f}  daily max: {max(totals):,} on {rows[totals.index(max(totals))][0]}")
write_csv("44_process_log_daily.csv",
          ["date", "total", "exceptions"], rows)

# 5) Hour-of-day across all weeks
sql = f"""
WITH all_log AS ({union_subset('created_date, type')})
SELECT DATEPART(hour, created_date) AS h,
       COUNT_BIG(*) AS total,
       SUM(CASE WHEN type = 'Exception' THEN 1 ELSE 0 END) AS exceptions
FROM all_log
GROUP BY DATEPART(hour, created_date)
ORDER BY h
"""
rows = run(sql, "hour-of-day")
total_all = sum(int(r[1]) for r in rows)
for r in rows:
    bar = "#" * int(int(r[1]) / max(int(rr[1]) for rr in rows) * 50)
    print(f"  {int(r[0]):02}:00  total={int(r[1]):>8,}  exc={int(r[2]):>5,}  {bar}")
write_csv("45_process_log_hour_of_day.csv",
          ["hour", "total", "exceptions"], rows)

# 6) Concurrency proxy: events per minute, top 20 minute-buckets
sql = f"""
WITH all_log AS ({union_subset('created_date')})
SELECT TOP 20
    DATEADD(minute, DATEDIFF(minute, 0, created_date), 0) AS minute_bin,
    COUNT_BIG(*) AS events_in_minute
FROM all_log
GROUP BY DATEADD(minute, DATEDIFF(minute, 0, created_date), 0)
ORDER BY events_in_minute DESC
"""
rows = run(sql, "top 20 busiest minutes")
for r in rows:
    print(f"  {r[0]}  events={int(r[1]):>6,}")
write_csv("46_process_log_busy_minutes.csv",
          ["minute_bin", "events_in_minute"], rows)
