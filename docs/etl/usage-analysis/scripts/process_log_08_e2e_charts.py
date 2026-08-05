"""Charts for the end-to-end latency analysis."""
from __future__ import annotations

import csv
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

DATA = Path(__file__).resolve().parents[1] / "data" / "rl_prod"
CHARTS = Path(__file__).resolve().parents[1] / "charts" / "rl_prod"
CHARTS.mkdir(parents=True, exist_ok=True)

# 1) Per-component bar: p50/p95/p99 in seconds, log-scale
with (DATA / "60_e2e_latency_per_component.csv").open() as f:
    rows = list(csv.DictReader(f))

# Filter to components with >100 samples
rows = [r for r in rows if int(r["total"]) > 100]

comps = [r["component"][:35] for r in rows]
p50 = [int(r["p50_sec"]) for r in rows]
p95 = [int(r["p95_sec"]) for r in rows]
p99 = [int(r["p99_sec"]) for r in rows]

fig, ax = plt.subplots(figsize=(12, 7))
y = list(range(len(comps)))
w = 0.27
ax.barh([yi - w for yi in y], p50, w, label="p50", color="#2ca02c")
ax.barh(y,                p95, w, label="p95", color="#ff7f0e")
ax.barh([yi + w for yi in y], p99, w, label="p99", color="#d62728")
ax.set_yticks(y)
ax.set_yticklabels(comps)
ax.invert_yaxis()
ax.set_xscale("log")
ax.set_xlabel("end-to-end latency (seconds, log scale)")
ax.set_title("RL_PROD — txn → process_log end-to-end latency per component")
ax.axvline(60, color="gray", linestyle="--", alpha=0.5, label="1 min")
ax.axvline(3600, color="gray", linestyle="-.", alpha=0.5, label="1 hr")
ax.axvline(86400, color="gray", linestyle=":", alpha=0.5, label="1 day")
ax.legend(loc="lower right")
ax.grid(axis="x", which="both", alpha=0.3)
fig.tight_layout()
fig.savefig(CHARTS / "06_e2e_latency_per_component.png", dpi=110)
plt.close(fig)

# 2) Top 15 subjects (component:subject) by p99 — the slowest tails
with (DATA / "61_e2e_latency_per_subject.csv").open() as f:
    sub_rows = list(csv.DictReader(f))

sub_rows = [r for r in sub_rows if int(r["total"]) > 100]
# Two views: top 15 by p99 (slowest), top 15 by p50 (typical case)
sub_by_p99 = sorted(sub_rows, key=lambda r: int(r["p99_sec"]), reverse=True)[:15]
sub_by_p50 = sorted(sub_rows, key=lambda r: int(r["p50_sec"]), reverse=True)[:15]

for series, title, fname in [
    (sub_by_p99, "Slowest p99 — top 15 (component:subject)", "07_e2e_top_p99.png"),
    (sub_by_p50, "Slowest p50 — top 15 (component:subject)", "08_e2e_top_p50.png"),
]:
    labels = [f"{r['component'][:18]}:{r['subject'][:25]}" for r in series]
    p99s = [int(r["p99_sec"]) for r in series]
    p95s = [int(r["p95_sec"]) for r in series]
    p50s = [int(r["p50_sec"]) for r in series]
    fig, ax = plt.subplots(figsize=(12, 7))
    y = list(range(len(labels)))
    w = 0.27
    ax.barh([yi - w for yi in y], p50s, w, label="p50", color="#2ca02c")
    ax.barh(y,                p95s, w, label="p95", color="#ff7f0e")
    ax.barh([yi + w for yi in y], p99s, w, label="p99", color="#d62728")
    ax.set_yticks(y)
    ax.set_yticklabels(labels)
    ax.invert_yaxis()
    ax.set_xscale("log")
    ax.set_xlabel("latency (seconds, log scale)")
    ax.set_title(f"RL_PROD — {title}")
    ax.axvline(60, color="gray", linestyle="--", alpha=0.5)
    ax.axvline(3600, color="gray", linestyle="-.", alpha=0.5)
    ax.axvline(86400, color="gray", linestyle=":", alpha=0.5)
    ax.legend(loc="lower right")
    ax.grid(axis="x", which="both", alpha=0.3)
    fig.tight_layout()
    fig.savefig(CHARTS / fname, dpi=110)
    plt.close(fig)

print(f"wrote 3 charts to {CHARTS}")
