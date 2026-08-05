"""Phase 3b — drill into ActivityLog: SQL Agent job patterns, QueryText
content, and per-DB activity distribution."""
from pathlib import Path
import csv
from db import query

DATA = Path(__file__).resolve().parents[1] / "data"


def write_csv(name, cols, rows):
    with (DATA / name).open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(cols)
        for r in rows:
            w.writerow([str(v) if v is not None else "" for v in r])


print("== sample non-null QueryText to see what's actually captured ==")
_, rows, dt = query("""
    SELECT TOP 20
        LEFT(QueryText, 200) AS qt,
        ProgramName,
        DatabaseName,
        Status,
        LogDateTime
    FROM dbo.ActivityLog WITH (NOLOCK)
    WHERE QueryText IS NOT NULL
      AND LEN(QueryText) > 20
      AND LogDateTime >= DATEADD(day, -7, GETDATE())
    ORDER BY LogDateTime DESC
""", database="Megatron")
print(f"  q={dt:.1f}s, {len(rows)} rows")
for r in rows[:15]:
    print(f"  [{r[1][:25]:25s}] {r[2]:18s} {r[3]:15s} | {r[0][:120]}")

print("\n== SQL Agent JobStep activity (last 90 days, ETL-bearing jobs only) ==")
_, rows, dt = query("""
    SELECT ProgramName,
           DatabaseName,
           COUNT_BIG(*) AS samples,
           COUNT(DISTINCT CAST(LogDateTime AS date)) AS days,
           MIN(LogDateTime) AS first_seen,
           MAX(LogDateTime) AS last_seen
    FROM dbo.ActivityLog WITH (NOLOCK)
    WHERE ProgramName LIKE 'SQLAgent - TSQL JobStep%'
      AND LogDateTime >= DATEADD(day, -90, GETDATE())
    GROUP BY ProgramName, DatabaseName
    ORDER BY samples DESC
""", database="Megatron")
print(f"  q={dt:.1f}s, {len(rows)} jobs")
for r in rows[:25]:
    print(f"  db={r[1]:18s} samples={r[2]:>6,}  days={r[3]:>3}  | {r[0][:70]}")
write_csv("26_sql_agent_jobs.csv",
          ["program", "database", "samples", "days_seen", "first_seen", "last_seen"], rows)

print("\n== per-database activity (last 90 days) ==")
_, rows, dt = query("""
    SELECT DatabaseName,
           COUNT_BIG(*) AS samples,
           COUNT(DISTINCT SessionID) AS sessions,
           COUNT(DISTINCT LoginName) AS logins,
           AVG(CAST(LogicalReads AS BIGINT)) AS avg_logical_reads,
           SUM(CAST(CPUTime AS BIGINT)) / 60000 AS sum_cpu_minutes
    FROM dbo.ActivityLog WITH (NOLOCK)
    WHERE DatabaseName IS NOT NULL
      AND LogDateTime >= DATEADD(day, -90, GETDATE())
    GROUP BY DatabaseName
    ORDER BY samples DESC
""", database="Megatron")
print(f"  q={dt:.1f}s")
for r in rows:
    print(f"  {str(r[0])[:20]:20s} samples={r[1]:>8,}  sessions={r[2]:>5}  cpu_min={int(r[5] or 0):>8,}")
write_csv("27_per_db_activity.csv",
          ["database", "samples", "distinct_sessions", "distinct_logins",
           "avg_logical_reads", "sum_cpu_minutes"], rows)

print("\n== running queries (status=running) by program ==")
_, rows, dt = query("""
    SELECT TOP 25 ProgramName, COUNT_BIG(*) AS running_samples,
           AVG(CAST(TotalElapsedTime AS BIGINT)) AS avg_elapsed_ms,
           MAX(CAST(TotalElapsedTime AS BIGINT)) AS max_elapsed_ms
    FROM dbo.ActivityLog WITH (NOLOCK)
    WHERE Status = 'running'
      AND LogDateTime >= DATEADD(day, -90, GETDATE())
    GROUP BY ProgramName
    ORDER BY running_samples DESC
""", database="Megatron")
print(f"  q={dt:.1f}s")
for r in rows[:20]:
    print(f"  {str(r[0])[:45]:45s} running={r[1]:>6,}  avg_ms={r[2] or 0:>9,}  max_ms={r[3] or 0:>9,}")
write_csv("28_running_by_program.csv",
          ["program", "running_samples", "avg_elapsed_ms", "max_elapsed_ms"], rows)
