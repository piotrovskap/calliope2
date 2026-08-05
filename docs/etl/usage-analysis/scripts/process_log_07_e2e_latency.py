"""End-to-end latency: time from `oltp.txn.created_date` (event arrival) to
`process_log.created_date` (when the script's log entry was written).

Joins every process_log_* table to oltp.txn on txn_id_1 (guid-typed only
via TRY_CAST). Aggregates per (component, subject):
  - count of matched rows
  - histogram of latency in log-scale buckets
  - p50/p95/p99 interpolated from histogram (oltp is SQL2005 compat → no
    PERCENTILE_CONT).

Negative or huge deltas (≥30 days) treated as not-an-arrival-event correlation
and excluded from percentiles (counted separately as 'outliers').

Outputs:
  data/rl_prod/60_e2e_latency_per_component.csv
  data/rl_prod/61_e2e_latency_per_subject.csv
  data/rl_prod/62_e2e_latency_histograms.csv
"""
from __future__ import annotations

import csv
import math
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

# Components that don't reference oltp.txn IDs in txn_id_1 (proven by 0% match):
EXCLUDE_COMPONENTS = ("RLScriptService",)

# Bucket boundaries in SECONDS — log-scale, covers <1s to >30 days
BUCKETS = [
    (-86400, 0),       # negative (log before txn)
    (0, 1), (1, 5), (5, 10), (10, 30), (30, 60),
    (60, 300), (300, 600),           # 1-5min, 5-10min
    (600, 1800), (1800, 3600),       # 10-30min, 30-60min
    (3600, 14400), (14400, 86400),   # 1-4hr, 4-24hr
    (86400, 7*86400),                # 1-7 days
    (7*86400, 30*86400),             # 7-30 days
    (30*86400, 10**12),              # >30 days (outliers)
]


def per_table_union() -> str:
    """Each table contributes rows where txn_id_1 is a valid GUID."""
    parts = []
    for t in TABLES:
        parts.append(f"""
        SELECT pl.component, pl.subject,
               DATEDIFF(second, t.created_date, pl.created_date) AS delta_sec
        FROM dbo.[{t}] pl WITH (NOLOCK)
        JOIN dbo.txn t WITH (NOLOCK)
          ON t.txn_id = TRY_CAST(pl.txn_id_1 AS uniqueidentifier)
        WHERE TRY_CAST(pl.txn_id_1 AS uniqueidentifier) IS NOT NULL
          AND pl.component NOT IN ({", ".join("'" + c + "'" for c in EXCLUDE_COMPONENTS)})
        """)
    return " UNION ALL ".join(parts)


def hist_select(prefix: str = "") -> str:
    """SQL CASE statements producing the 15 histogram buckets."""
    cases = []
    for i, (lo, hi) in enumerate(BUCKETS):
        cases.append(
            f"SUM(CASE WHEN delta_sec >= {lo} AND delta_sec < {hi} THEN 1 ELSE 0 END) AS {prefix}b{i:02d}"
        )
    return ", ".join(cases)


def percentile_from_hist(counts: list[int], p: float, exclude_outliers: bool = True) -> float:
    """Log-interpolate p-th percentile from histogram counts.
    If exclude_outliers, the negative bucket and last-bucket are excluded."""
    if exclude_outliers:
        # Use only buckets [1..-2] inclusive (skip negative bucket and >30d)
        eff = list(zip(BUCKETS[1:-1], counts[1:-1]))
    else:
        eff = list(zip(BUCKETS, counts))
    total = sum(c for _, c in eff)
    if total == 0:
        return 0.0
    target = p * total
    cum = 0
    for (lo, hi), c in eff:
        if cum + c >= target:
            if c == 0:
                return float(lo)
            frac = (target - cum) / c
            if lo <= 0:
                return frac * hi
            return math.exp(math.log(max(1, lo)) + frac * (math.log(hi) - math.log(max(1, lo))))
        cum += c
    return float(eff[-1][0][1])


def main():
    sql = f"""
    WITH d AS ({per_table_union()})
    SELECT component, subject, COUNT_BIG(*) AS n, {hist_select()}
    FROM d
    GROUP BY component, subject
    ORDER BY n DESC
    """
    print(f"== running e2e latency join across {len(TABLES)} tables ==")
    print("  (this can take several minutes — joins ~5M rows against 345M)")
    _, rows, dt = query(sql, database="oltp", prefix="RL_PROD")
    print(f"  q={dt:.1f}s, {len(rows)} (component, subject) groups\n")

    # Per-row decompose
    out_subjects = []
    for r in rows:
        comp, subj, n = r[0], r[1], int(r[2])
        counts = [int(r[i + 3]) for i in range(len(BUCKETS))]
        p50 = percentile_from_hist(counts, 0.50)
        p95 = percentile_from_hist(counts, 0.95)
        p99 = percentile_from_hist(counts, 0.99)
        negative = counts[0]
        outliers = counts[-1]
        in_window = n - negative - outliers
        out_subjects.append((comp, subj, n, in_window, negative, outliers, p50, p95, p99, counts))

    # Per-subject CSV
    with (DATA / "61_e2e_latency_per_subject.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["component", "subject", "total", "in_window", "negative_count",
                    "outlier_count_gt30d", "p50_sec", "p95_sec", "p99_sec"])
        for comp, subj, n, in_window, neg, out, p50, p95, p99, _ in out_subjects:
            w.writerow([comp, subj, n, in_window, neg, out, int(p50), int(p95), int(p99)])

    # Per-component aggregate
    by_comp = {}
    for comp, subj, n, in_window, neg, out, p50, p95, p99, counts in out_subjects:
        a = by_comp.setdefault(comp, {"n": 0, "in_window": 0, "negative": 0,
                                      "outliers": 0, "counts": [0]*len(BUCKETS)})
        a["n"] += n
        a["in_window"] += in_window
        a["negative"] += neg
        a["outliers"] += out
        for i, c in enumerate(counts):
            a["counts"][i] += c

    with (DATA / "60_e2e_latency_per_component.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["component", "total", "in_window", "negative_count",
                    "outlier_count_gt30d", "p50_sec", "p95_sec", "p99_sec"])
        for comp, a in sorted(by_comp.items(), key=lambda x: x[1]["n"], reverse=True):
            p50 = percentile_from_hist(a["counts"], 0.50)
            p95 = percentile_from_hist(a["counts"], 0.95)
            p99 = percentile_from_hist(a["counts"], 0.99)
            w.writerow([comp, a["n"], a["in_window"], a["negative"], a["outliers"],
                        int(p50), int(p95), int(p99)])

    # Histogram CSV (per subject)
    with (DATA / "62_e2e_latency_histograms.csv").open("w", newline="") as f:
        w = csv.writer(f)
        head = ["component", "subject", "total"]
        head += [f"b{i:02d}_{lo}_{hi}_sec" for i, (lo, hi) in enumerate(BUCKETS)]
        w.writerow(head)
        for comp, subj, n, _, _, _, _, _, _, counts in out_subjects:
            w.writerow([comp, subj, n] + counts)

    # Stdout: per-component summary
    print(f"{'component':45s}  {'matched':>9s}  {'p50':>9s}  {'p95':>9s}  {'p99':>9s}  {'in_win':>9s}  {'neg':>6s}  {'>30d':>6s}")
    for comp, a in sorted(by_comp.items(), key=lambda x: x[1]["n"], reverse=True):
        p50 = percentile_from_hist(a["counts"], 0.50)
        p95 = percentile_from_hist(a["counts"], 0.95)
        p99 = percentile_from_hist(a["counts"], 0.99)
        in_w = a['in_window']
        in_pct = round(100*in_w/a['n'], 1) if a['n'] else 0
        print(f"  {comp[:43]:43s}  {a['n']:>9,}  "
              f"{p50:>7.1f}s  {p95:>7.1f}s  {p99:>7.1f}s  "
              f"{in_w:>7,} ({in_pct:4.1f}%)  {a['negative']:>4,}  {a['outliers']:>4,}")

    print(f"\nwrote {DATA / '60_e2e_latency_per_component.csv'}")
    print(f"wrote {DATA / '61_e2e_latency_per_subject.csv'}")
    print(f"wrote {DATA / '62_e2e_latency_histograms.csv'}")


if __name__ == "__main__":
    main()
