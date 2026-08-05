"""Generate charts for the RL_PROD process_log analysis."""
from __future__ import annotations

import csv
from datetime import date
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

DATA = Path(__file__).resolve().parents[1] / "data" / "rl_prod"
CHARTS = Path(__file__).resolve().parents[1] / "charts" / "rl_prod"
CHARTS.mkdir(parents=True, exist_ok=True)


# 1) Daily volume + exceptions stacked
with (DATA / "44_process_log_daily.csv").open() as f:
    r = csv.DictReader(f)
    rows = list(r)
days = [date.fromisoformat(x["date"]) for x in rows]
totals = [int(x["total"]) for x in rows]
excs = [int(x["exceptions"]) for x in rows]
logs = [t - e for t, e in zip(totals, excs)]

fig, ax = plt.subplots(figsize=(12, 4))
ax.bar(days, logs, color="#1f77b4", label="Log entries")
ax.bar(days, excs, bottom=logs, color="#d62728", label="Exceptions")
ax.set_title("RL_PROD process_log — events per day (last 82 days)")
ax.set_ylabel("events/day")
ax.legend()
ax.grid(axis="y", alpha=0.3)
fig.autofmt_xdate()
fig.tight_layout()
fig.savefig(CHARTS / "01_daily_volume.png", dpi=110)
plt.close(fig)

# 2) Hour-of-day with exceptions overlay
with (DATA / "45_process_log_hour_of_day.csv").open() as f:
    r = csv.DictReader(f)
    rows = list(r)
hours = [int(x["hour"]) for x in rows]
totals = [int(x["total"]) for x in rows]
excs = [int(x["exceptions"]) for x in rows]

fig, ax1 = plt.subplots(figsize=(10, 4))
ax1.bar(hours, totals, color="#ff7f0e", alpha=0.7, label="total events")
ax1.set_xlabel("hour of day (UTC)")
ax1.set_ylabel("total events", color="#ff7f0e")
ax1.set_xticks(range(0, 24))
ax1.grid(axis="y", alpha=0.3)
ax2 = ax1.twinx()
ax2.plot(hours, excs, color="#d62728", marker="o", linewidth=2, label="exceptions")
ax2.set_ylabel("exceptions", color="#d62728")
fig.suptitle("RL_PROD process_log — hour-of-day distribution")
fig.tight_layout()
fig.savefig(CHARTS / "02_hour_of_day.png", dpi=110)
plt.close(fig)

# 3) Top 15 components by volume
with (DATA / "42_process_log_components.csv").open() as f:
    r = csv.DictReader(f)
    rows = list(r)[:15]
comps = [x["component"][:30] for x in rows]
ttls = [int(x["total"]) for x in rows]
exs = [int(x["exceptions"]) for x in rows]

fig, ax = plt.subplots(figsize=(11, 6))
y = list(range(len(comps)))
ax.barh(y, ttls, color="#2ca02c", label="total events")
ax.barh(y, exs, color="#d62728", label="exceptions")
ax.set_yticks(y)
ax.set_yticklabels(comps)
ax.invert_yaxis()
ax.set_xlabel("events (last 82 days)")
ax.set_title("RL_PROD process_log — top 15 components by volume")
ax.set_xscale("log")
ax.legend()
ax.grid(axis="x", alpha=0.3)
fig.tight_layout()
fig.savefig(CHARTS / "03_top_components.png", dpi=110)
plt.close(fig)

# 4) Top 20 subjects by volume
with (DATA / "43_process_log_subjects.csv").open() as f:
    r = csv.DictReader(f)
    rows = list(r)[:20]
labels = [(x["subject"][:50]) for x in rows]
ttls = [int(x["total"]) for x in rows]
exs = [int(x["exceptions"]) for x in rows]

fig, ax = plt.subplots(figsize=(12, 7))
y = list(range(len(labels)))
ax.barh(y, ttls, color="#9467bd", label="total events")
ax.barh(y, exs, color="#d62728", label="exceptions")
ax.set_yticks(y)
ax.set_yticklabels(labels)
ax.invert_yaxis()
ax.set_xlabel("events (last 82 days)")
ax.set_title("RL_PROD process_log — top 20 processes (subjects)")
ax.set_xscale("log")
ax.legend()
ax.grid(axis="x", alpha=0.3)
fig.tight_layout()
fig.savefig(CHARTS / "04_top_subjects.png", dpi=110)
plt.close(fig)

# 5) Per-server activity (top 6)
with (DATA / "41_process_log_servers.csv").open() as f:
    r = csv.DictReader(f)
    rows = list(r)[:6]
labels = [x["server"] or "(empty)" for x in rows]
ttls = [int(x["total"]) for x in rows]
exs = [int(x["exceptions"]) for x in rows]

fig, ax = plt.subplots(figsize=(10, 4))
y = list(range(len(labels)))
ax.barh(y, ttls, color="#17becf", label="total events")
ax.barh(y, exs, color="#d62728", label="exceptions")
ax.set_yticks(y)
ax.set_yticklabels(labels)
ax.invert_yaxis()
ax.set_xlabel("events (last 82 days)")
ax.set_title("RL_PROD process_log — events per server")
ax.set_xscale("log")
ax.legend()
ax.grid(axis="x", alpha=0.3)
fig.tight_layout()
fig.savefig(CHARTS / "05_servers.png", dpi=110)
plt.close(fig)

print(f"Wrote 5 charts to {CHARTS}")
