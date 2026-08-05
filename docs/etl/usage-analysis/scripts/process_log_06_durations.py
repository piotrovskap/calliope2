"""Per-process duration distribution from message_text 'Completed: HH:MM:SS.fff'.

Pass 1: count + sum + min + max per subject across all 12 weekly tables.
Pass 2: PERCENTILE_CONT (p50/p95/p99) for top 30 subjects by event count.

Outputs:
  data/rl_prod/50_durations_summary.csv         per-subject stats (all subjects)
  data/rl_prod/51_durations_percentiles.csv     p50/p95/p99 for top 30
"""
from __future__ import annotations

import csv
from pathlib import Path

from db import query

DATA = Path(__file__).resolve().parents[1] / "data" / "rl_prod"
DATA.mkdir(parents=True, exist_ok=True)

TABLES = [
    "process_log",
    "process_log_20260613T23", "process_log_20260606T23", "process_log_20260530T23",
    "process_log_20260523T23", "process_log_20260516T23", "process_log_20260509T23",
    "process_log_20260502T23", "process_log_20260425T23", "process_log_20260418T23",
    "process_log_20260411T23", "process_log_20260404T23",
]


def duration_extract_select(table: str) -> str:
    """SELECT clause that extracts duration_ms from rows where message_text
    starts with 'Completed: '. Returns NULL for rows without that prefix."""
    return f"""
    SELECT subject,
           TRY_CAST(SUBSTRING(message_text, 12, 2) AS INT) * 3600000
         + TRY_CAST(SUBSTRING(message_text, 15, 2) AS INT) * 60000
         + TRY_CAST(SUBSTRING(message_text, 18, 2) AS INT) * 1000
         + TRY_CAST(SUBSTRING(message_text, 21, 3) AS INT) AS duration_ms
    FROM dbo.[{table}] WITH (NOLOCK)
    WHERE message_text LIKE 'Completed:%'
      AND TRY_CAST(SUBSTRING(message_text, 12, 2) AS INT) IS NOT NULL
      AND TRY_CAST(SUBSTRING(message_text, 15, 2) AS INT) IS NOT NULL
      AND TRY_CAST(SUBSTRING(message_text, 18, 2) AS INT) IS NOT NULL
      AND TRY_CAST(SUBSTRING(message_text, 21, 3) AS INT) IS NOT NULL
    """


def union_all() -> str:
    return " UNION ALL ".join(duration_extract_select(t) for t in TABLES)


print("== pass 1: count / sum / min / max / stddev per subject ==")
sql = f"""
WITH d AS ({union_all()})
SELECT subject,
       COUNT_BIG(*)            AS n,
       SUM(CAST(duration_ms AS BIGINT)) AS sum_ms,
       MIN(duration_ms)        AS min_ms,
       MAX(duration_ms)        AS max_ms,
       AVG(CAST(duration_ms AS BIGINT)) AS avg_ms,
       STDEV(CAST(duration_ms AS FLOAT)) AS stddev_ms
FROM d
GROUP BY subject
ORDER BY n DESC
"""
_, rows, dt = query(sql, database="oltp", prefix="RL_PROD")
print(f"  q={dt:.1f}s, {len(rows)} subjects with parseable durations")
print(f"  {'subject':50s}  {'n':>10s}  {'avg':>8s}  {'min':>6s}  {'max':>8s}  {'stddev':>8s}")
for r in rows[:30]:
    subj, n, sum_ms, mn, mx, avg, sd = r
    print(f"  {str(subj)[:50]:50s}  {int(n):>10,}  {int(avg or 0):>6,} ms  {int(mn or 0):>4,}  {int(mx or 0):>6,}  {int(sd or 0):>6,}")

with (DATA / "50_durations_summary.csv").open("w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["subject", "n", "sum_ms", "min_ms", "max_ms", "avg_ms", "stddev_ms"])
    for r in rows:
        w.writerow([str(r[0] or ""), int(r[1] or 0), int(r[2] or 0),
                    int(r[3] or 0), int(r[4] or 0), int(r[5] or 0), float(r[6] or 0)])

# Pick the top 30 subjects by count for percentile analysis
top_subjects = [r[0] for r in rows[:30] if r[0] is not None]

print(f"\n== pass 2: PERCENTILE_CONT for top {len(top_subjects)} subjects ==")
# Build IN list safely (subjects are well-known process names; quote them)
in_list = ", ".join("'" + s.replace("'", "''") + "'" for s in top_subjects)

sql = f"""
WITH d AS ({union_all()})
SELECT DISTINCT subject,
       PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY subject) AS p50,
       PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY subject) AS p95,
       PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY duration_ms) OVER (PARTITION BY subject) AS p99
FROM d
WHERE subject IN ({in_list})
"""
_, prows, dt = query(sql, database="oltp", prefix="RL_PROD")
print(f"  q={dt:.1f}s, {len(prows)} rows")
perc_map = {r[0]: (float(r[1] or 0), float(r[2] or 0), float(r[3] or 0)) for r in prows}

# Print joined output
print(f"\n  {'subject':50s}  {'n':>10s}  {'avg':>8s}  {'p50':>8s}  {'p95':>8s}  {'p99':>8s}  {'max':>8s}")
combined = []
for r in rows[:30]:
    subj, n, _, mn, mx, avg, _ = r
    p50, p95, p99 = perc_map.get(subj, (0, 0, 0))
    print(f"  {str(subj)[:50]:50s}  {int(n):>10,}  {int(avg or 0):>6,} ms  {int(p50):>6,} ms  {int(p95):>6,} ms  {int(p99):>6,} ms  {int(mx or 0):>6,} ms")
    combined.append([str(subj or ""), int(n or 0), int(avg or 0), int(p50), int(p95), int(p99), int(mx or 0)])

with (DATA / "51_durations_percentiles.csv").open("w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["subject", "n", "avg_ms", "p50_ms", "p95_ms", "p99_ms", "max_ms"])
    for r in combined:
        w.writerow(r)

print(f"\nwrote {DATA / '50_durations_summary.csv'} ({len(rows)} subjects)")
print(f"wrote {DATA / '51_durations_percentiles.csv'} (top 30 with percentiles)")
