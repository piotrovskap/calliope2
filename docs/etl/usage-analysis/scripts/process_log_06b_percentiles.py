"""Percentile fallback: histogram-bucket per subject, interpolate p50/p95/p99
in Python. Compatible with SQL Server 2005 compat mode."""
from __future__ import annotations

import csv
import math
from pathlib import Path

from db import query

DATA = Path(__file__).resolve().parents[1] / "data" / "rl_prod"

TABLES = [
    "process_log",
    "process_log_20260613T23", "process_log_20260606T23", "process_log_20260530T23",
    "process_log_20260523T23", "process_log_20260516T23", "process_log_20260509T23",
    "process_log_20260502T23", "process_log_20260425T23", "process_log_20260418T23",
    "process_log_20260411T23", "process_log_20260404T23",
]

# Bucket upper bounds (inclusive lower, exclusive upper)
BUCKETS = [
    (0, 10), (10, 100), (100, 500), (500, 1_000),
    (1_000, 2_000), (2_000, 5_000), (5_000, 10_000),
    (10_000, 30_000), (30_000, 60_000),
    (60_000, 120_000), (120_000, 300_000), (300_000, 600_000),
    (600_000, 1_800_000), (1_800_000, 3_600_000),
    (3_600_000, 10**12),  # 1hr+
]


def extract_select(table: str) -> str:
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
    return " UNION ALL ".join(extract_select(t) for t in TABLES)


# Load the subject list from pass 1
top_subjects = []
with (DATA / "50_durations_summary.csv").open() as f:
    r = csv.DictReader(f)
    for row in r:
        top_subjects.append(row["subject"])
        if len(top_subjects) >= 30:
            break

in_list = ", ".join("'" + s.replace("'", "''") + "'" for s in top_subjects)

# Build histogram query
case_lines = []
for i, (lo, hi) in enumerate(BUCKETS):
    case_lines.append(
        f"SUM(CASE WHEN duration_ms >= {lo} AND duration_ms < {hi} THEN 1 ELSE 0 END) AS b{i:02d}"
    )

sql = f"""
WITH d AS ({union_all()})
SELECT subject, COUNT_BIG(*) AS n, {', '.join(case_lines)}
FROM d
WHERE subject IN ({in_list})
GROUP BY subject
"""

print(f"== histogram pass for top {len(top_subjects)} subjects ==")
_, rows, dt = query(sql, database="oltp", prefix="RL_PROD")
print(f"  q={dt:.1f}s, {len(rows)} subjects")


def percentile_from_hist(buckets_counts: list[int], p: float) -> float:
    """Log-interpolate the p-th percentile (p in [0,1]) from histogram counts."""
    total = sum(buckets_counts)
    if total == 0:
        return 0.0
    target = p * total
    cum = 0
    for i, c in enumerate(buckets_counts):
        if cum + c >= target:
            lo, hi = BUCKETS[i]
            if c == 0:
                return float(lo)
            # how far into this bucket?
            frac = (target - cum) / c
            # log-interpolate (durations are heavy-tailed)
            if lo == 0:
                return frac * hi
            return math.exp(math.log(lo) + frac * (math.log(hi) - math.log(lo)))
        cum += c
    return float(BUCKETS[-1][1])


# Write percentile CSV
out_rows = []
for r in rows:
    subj = r[0]
    n = int(r[1])
    counts = [int(r[i + 2]) for i in range(len(BUCKETS))]
    p50 = percentile_from_hist(counts, 0.50)
    p95 = percentile_from_hist(counts, 0.95)
    p99 = percentile_from_hist(counts, 0.99)
    out_rows.append((subj, n, p50, p95, p99, counts))

out_rows.sort(key=lambda r: r[1], reverse=True)

print(f"\n  {'subject':50s}  {'n':>10s}  {'p50':>9s}  {'p95':>9s}  {'p99':>9s}")
for subj, n, p50, p95, p99, _ in out_rows:
    print(f"  {str(subj)[:50]:50s}  {n:>10,}  {p50/1000:>7.2f}s  {p95/1000:>7.2f}s  {p99/1000:>7.2f}s")

with (DATA / "51_durations_percentiles.csv").open("w", newline="") as f:
    w = csv.writer(f)
    headers = ["subject", "n", "p50_ms", "p95_ms", "p99_ms"]
    headers += [f"bucket_{lo}_to_{hi}_ms" for lo, hi in BUCKETS]
    w.writerow(headers)
    for subj, n, p50, p95, p99, counts in out_rows:
        w.writerow([subj, n, int(p50), int(p95), int(p99)] + counts)

print(f"\nwrote {DATA / '51_durations_percentiles.csv'}")
