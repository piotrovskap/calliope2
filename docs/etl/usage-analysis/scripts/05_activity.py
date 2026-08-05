"""Phase 3 — mine Megatron.dbo.ActivityLog for ETL execution patterns.

ActivityLog is a polled snapshot of sys.dm_exec_requests — each row =
a session-instant. We can use it to surface:
  - Top programs/logins by row count (~ activity volume proxy)
  - ETL-flavored sessions (QueryText/Command matches sp_insert_*, sp_juice_*, etc.)
  - Daily concurrency: distinct active sessions per minute
  - Hour-of-day busiest windows by program family
"""
from __future__ import annotations

import csv
from pathlib import Path

from db import query

DATA = Path(__file__).resolve().parents[1] / "data"
DB = "Megatron"


def write_csv(name, cols, rows):
    with (DATA / name).open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(cols)
        for r in rows:
            w.writerow([str(v) if v is not None else "" for v in r])


def main():
    print("== top programs ==")
    _, rows, dt = query("""
        SELECT TOP 25 ProgramName, COUNT_BIG(*) AS samples,
               COUNT(DISTINCT LoginName) AS distinct_logins,
               COUNT(DISTINCT HostName)  AS distinct_hosts,
               MIN(LogDateTime) AS first_seen,
               MAX(LogDateTime) AS last_seen
        FROM dbo.ActivityLog WITH (NOLOCK)
        WHERE ProgramName IS NOT NULL
        GROUP BY ProgramName
        ORDER BY samples DESC
    """, database=DB)
    print(f"  q={dt:.1f}s, {len(rows)} rows")
    for r in rows:
        print(f"  {str(r[0])[:45]:45s} samples={r[1]:>10,}  logins={r[2]:>3}  hosts={r[3]:>3}  {r[4]} → {r[5]}")
    write_csv("20_activity_top_programs.csv",
              ["program", "samples", "distinct_logins", "distinct_hosts", "first_seen", "last_seen"], rows)

    print("\n== top logins ==")
    _, rows, dt = query("""
        SELECT TOP 25 LoginName, COUNT_BIG(*) AS samples,
               COUNT(DISTINCT ProgramName) AS programs,
               COUNT(DISTINCT DatabaseName) AS databases
        FROM dbo.ActivityLog WITH (NOLOCK)
        WHERE LoginName IS NOT NULL
        GROUP BY LoginName
        ORDER BY samples DESC
    """, database=DB)
    print(f"  q={dt:.1f}s")
    for r in rows:
        print(f"  {str(r[0])[:35]:35s} samples={r[1]:>10,}  programs={r[2]:>3}  dbs={r[3]:>3}")
    write_csv("21_activity_top_logins.csv",
              ["login", "samples", "distinct_programs", "distinct_databases"], rows)

    print("\n== ETL-flavored commands (sp_insert_*, sp_juice_*, sp_extract_*) ==")
    _, rows, dt = query("""
        SELECT TOP 50
            LEFT(QueryText, 120) AS snippet,
            COUNT_BIG(*) AS samples,
            COUNT(DISTINCT CAST(LogDateTime AS date)) AS days_seen,
            MIN(LogDateTime) AS first_seen,
            MAX(LogDateTime) AS last_seen,
            AVG(CAST(TotalElapsedTime AS BIGINT)) AS avg_elapsed_ms
        FROM dbo.ActivityLog WITH (NOLOCK)
        WHERE QueryText IS NOT NULL
          AND (QueryText LIKE '%sp_insert_%'
               OR QueryText LIKE '%sp_juice_%'
               OR QueryText LIKE '%sp_extract_%'
               OR QueryText LIKE '%sp_Calculate_%'
               OR QueryText LIKE '%sp_JuiceReporting_%')
        GROUP BY LEFT(QueryText, 120)
        ORDER BY samples DESC
    """, database=DB)
    print(f"  q={dt:.1f}s, {len(rows)} distinct ETL queries")
    for r in rows[:20]:
        print(f"  samples={r[1]:>8,}  days={r[2]:>4}  avg_ms={r[5] or 0:>8}  | {str(r[0])[:90]}")
    write_csv("22_activity_etl_queries.csv",
              ["query_snippet", "samples", "days_seen", "first_seen", "last_seen", "avg_elapsed_ms"], rows)

    print("\n== hour-of-day, last 90 days, all activity ==")
    _, rows, dt = query("""
        SELECT DATEPART(hour, LogDateTime) AS h, COUNT_BIG(*) AS n,
               COUNT(DISTINCT SessionID) AS distinct_sessions
        FROM dbo.ActivityLog WITH (NOLOCK)
        WHERE LogDateTime >= DATEADD(day, -90, GETDATE())
        GROUP BY DATEPART(hour, LogDateTime)
        ORDER BY h
    """, database=DB)
    print(f"  q={dt:.1f}s")
    for h, n, ds in rows:
        bar = "#" * int(n / max(r[1] for r in rows) * 40)
        print(f"  {int(h):02}:00  samples={int(n):>8,}  sessions={int(ds):>5}  {bar}")
    write_csv("23_activity_hour_of_day.csv", ["hour", "samples", "distinct_sessions"], rows)

    print("\n== concurrency: distinct sessions per 1-min bucket, last 30 days ==")
    _, rows, dt = query("""
        WITH bins AS (
            SELECT DATEADD(minute, DATEDIFF(minute, 0, LogDateTime), 0) AS minute_bin,
                   SessionID
            FROM dbo.ActivityLog WITH (NOLOCK)
            WHERE LogDateTime >= DATEADD(day, -30, GETDATE())
              AND IsUserProcess = 1
        )
        SELECT minute_bin, COUNT(DISTINCT SessionID) AS concurrent_sessions
        FROM bins
        GROUP BY minute_bin
        ORDER BY concurrent_sessions DESC
    """, database=DB)
    print(f"  q={dt:.1f}s, {len(rows)} minute buckets")
    if rows:
        print(f"  max concurrency: {int(rows[0][1])} sessions at {rows[0][0]}")
        topN = rows[:10]
        for mb, n in topN:
            print(f"    {mb}  sessions={int(n)}")
    write_csv("24_activity_concurrency.csv", ["minute_bin", "concurrent_sessions"], rows)

    print("\n== daily activity rollup (last 365 days) ==")
    _, rows, dt = query("""
        SELECT CAST(LogDateTime AS date) AS d,
               COUNT_BIG(*) AS samples,
               COUNT(DISTINCT SessionID) AS distinct_sessions,
               SUM(CAST(CPUTime AS BIGINT))     AS sum_cpu_ms,
               SUM(CAST(LogicalReads AS BIGINT)) AS sum_logical_reads
        FROM dbo.ActivityLog WITH (NOLOCK)
        WHERE LogDateTime >= DATEADD(day, -365, GETDATE())
        GROUP BY CAST(LogDateTime AS date)
        ORDER BY d
    """, database=DB)
    print(f"  q={dt:.1f}s, {len(rows)} days")
    write_csv("25_activity_daily.csv",
              ["date", "samples", "distinct_sessions", "sum_cpu_ms", "sum_logical_reads"], rows)


if __name__ == "__main__":
    main()
