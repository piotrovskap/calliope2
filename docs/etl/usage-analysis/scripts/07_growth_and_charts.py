"""Phase 4 + 5 — growth projection + chart generation.

Reads the daily series CSVs produced by 04_daily_volume.py + 04b, computes
monthly aggregates and a linear fit for the last 12 months, then projects
6 and 12 months forward.

Generates PNG charts saved to ../charts/.
"""
from __future__ import annotations

import csv
from datetime import date, timedelta
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

DATA = Path(__file__).resolve().parents[1] / "data"
CHARTS = Path(__file__).resolve().parents[1] / "charts"
CHARTS.mkdir(parents=True, exist_ok=True)

TODAY = date(2026, 6, 14)


def load_daily(path: Path):
    days, rows = [], []
    with path.open() as f:
        r = csv.reader(f)
        next(r)
        for row in r:
            d = date.fromisoformat(row[0])
            n = int(row[1])
            days.append(d)
            rows.append(n)
    return days, rows


def monthly_agg(days, rows):
    by_month: dict[str, int] = {}
    for d, n in zip(days, rows):
        key = f"{d.year:04d}-{d.month:02d}"
        by_month[key] = by_month.get(key, 0) + n
    return sorted(by_month.items())


def linear_fit(xs, ys):
    n = len(xs)
    if n < 2:
        return 0.0, 0.0
    mx = sum(xs) / n
    my = sum(ys) / n
    num = sum((x - mx) * (y - my) for x, y in zip(xs, ys))
    den = sum((x - mx) ** 2 for x in xs)
    if den == 0:
        return 0.0, my
    m = num / den
    b = my - m * mx
    return m, b


def project(monthly):
    """Returns (slope_rows_per_month, intercept, last_12_avg, +6mo, +12mo)
    fit on the last 12 full months excluding current month."""
    if len(monthly) < 4:
        return None
    # exclude current month
    series = monthly[:-1] if monthly[-1][0] == f"{TODAY.year:04d}-{TODAY.month:02d}" else monthly[:]
    last12 = series[-12:]
    xs = list(range(len(last12)))
    ys = [v for _, v in last12]
    m, b = linear_fit(xs, ys)
    avg = sum(ys) / len(ys)
    proj_6 = m * (len(last12) + 6) + b
    proj_12 = m * (len(last12) + 12) + b
    return {
        "monthly_avg_last12": int(avg),
        "slope_per_month": int(m),
        "projection_plus_6_mo": int(max(0, proj_6)),
        "projection_plus_12_mo": int(max(0, proj_12)),
        "last_12_data": last12,
    }


def chart_daily(path: Path, days, rows, title: str, out_png: Path):
    fig, ax = plt.subplots(figsize=(11, 4))
    ax.plot(days, rows, linewidth=0.6, color="#1f77b4")
    ax.set_title(title)
    ax.set_ylabel("rows / day")
    ax.set_xlabel("date")
    ax.grid(alpha=0.3)
    ax.xaxis.set_major_locator(mdates.YearLocator())
    ax.xaxis.set_major_formatter(mdates.DateFormatter("%Y"))
    fig.autofmt_xdate()
    fig.tight_layout()
    fig.savefig(out_png, dpi=110)
    plt.close(fig)


def chart_monthly_with_fit(monthly, fit, title: str, out_png: Path):
    if not monthly:
        return
    labels = [k for k, _ in monthly]
    vals = [v for _, v in monthly]
    fig, ax = plt.subplots(figsize=(11, 4))
    ax.bar(range(len(monthly)), vals, color="#2ca02c", alpha=0.7)
    if fit and fit.get("last_12_data"):
        n_fit = len(fit["last_12_data"])
        fit_x = list(range(len(monthly) - n_fit, len(monthly)))
        m, b = linear_fit(list(range(n_fit)), [v for _, v in fit["last_12_data"]])
        ax.plot(fit_x, [m * i + b for i in range(n_fit)], color="red",
                linewidth=2, label=f"linear fit on last 12 mo (slope: {int(m):+,}/mo)")
        # projections
        fut_x = [len(monthly) + 5, len(monthly) + 11]
        fut_y = [fit["projection_plus_6_mo"], fit["projection_plus_12_mo"]]
        ax.scatter(fut_x, fut_y, color="orange", s=80, zorder=5, label="+6 mo / +12 mo projection")
        ax.legend()
    step = max(1, len(monthly) // 16)
    ax.set_xticks(range(0, len(monthly), step))
    ax.set_xticklabels([labels[i] for i in range(0, len(monthly), step)], rotation=45, ha="right")
    ax.set_ylabel("rows / month")
    ax.set_title(title)
    ax.grid(axis="y", alpha=0.3)
    fig.tight_layout()
    fig.savefig(out_png, dpi=110)
    plt.close(fig)


def chart_hour_of_day(rows, title: str, out_png: Path):
    by_hour = {h: 0 for h in range(24)}
    for h, n in rows:
        by_hour[h] += n
    fig, ax = plt.subplots(figsize=(10, 4))
    ax.bar(list(by_hour.keys()), list(by_hour.values()), color="#ff7f0e")
    ax.set_xticks(range(0, 24))
    ax.set_xlabel("hour of day (UTC)")
    ax.set_ylabel("rows")
    ax.set_title(title)
    ax.grid(axis="y", alpha=0.3)
    fig.tight_layout()
    fig.savefig(out_png, dpi=110)
    plt.close(fig)


def chart_day_of_week(rows, title: str, out_png: Path):
    by_dow = {d: 0 for d in range(1, 8)}
    for d, n in rows:
        by_dow[d] += n
    labels = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    fig, ax = plt.subplots(figsize=(7, 4))
    ax.bar(labels, [by_dow[i] for i in range(1, 8)], color="#9467bd")
    ax.set_ylabel("rows")
    ax.set_title(title)
    ax.grid(axis="y", alpha=0.3)
    fig.tight_layout()
    fig.savefig(out_png, dpi=110)
    plt.close(fig)


def main():
    # Iterate over daily-series files
    growth = []
    for csvf in sorted(DATA.glob("10_daily_rows__*.csv")):
        stem = csvf.stem.replace("10_daily_rows__", "")
        days, rows = load_daily(csvf)
        if not days:
            continue
        monthly = monthly_agg(days, rows)
        fit = project(monthly)
        print(f"\n{stem}")
        print(f"  daily: {len(days)} days, {sum(rows):,} total rows")
        if fit:
            print(f"  monthly avg (last 12): {fit['monthly_avg_last12']:,}")
            print(f"  slope: {fit['slope_per_month']:+,}/mo")
            print(f"  +6mo: {fit['projection_plus_6_mo']:,}    +12mo: {fit['projection_plus_12_mo']:,}")
            growth.append([
                stem, len(days), sum(rows),
                fit["monthly_avg_last12"], fit["slope_per_month"],
                fit["projection_plus_6_mo"], fit["projection_plus_12_mo"],
            ])
        chart_daily(csvf, days, rows, f"{stem} — rows per day",
                    CHARTS / f"daily_{stem}.png")
        chart_monthly_with_fit(monthly, fit, f"{stem} — monthly + projection",
                               CHARTS / f"monthly_{stem}.png")

    with (DATA / "30_growth_projection.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["table_id", "days_observed", "total_rows",
                    "monthly_avg_last12", "slope_per_month",
                    "projection_plus_6mo", "projection_plus_12mo"])
        for g in growth:
            w.writerow(g)

    # hour-of-day & day-of-week aggregate charts across all warehouse tables
    hod_by_role: dict[str, list] = {}
    dow_by_role: dict[str, list] = {}
    for fname, target in [("12_hour_of_day.csv", hod_by_role),
                          ("13_day_of_week.csv", dow_by_role)]:
        with (DATA / fname).open() as f:
            r = csv.reader(f)
            next(r)
            for row in r:
                role = row[3]
                bucket = int(row[4])
                n = int(row[5])
                target.setdefault(role, []).append((bucket, n))

    for role, rows in hod_by_role.items():
        chart_hour_of_day(rows, f"{role} — hour-of-day (UTC)",
                          CHARTS / f"hod_{role}.png")
    for role, rows in dow_by_role.items():
        chart_day_of_week(rows, f"{role} — day-of-week",
                          CHARTS / f"dow_{role}.png")

    # ActivityLog hour-of-day from data/23
    with (DATA / "23_activity_hour_of_day.csv").open() as f:
        r = csv.reader(f)
        next(r)
        act_rows = [(int(row[0]), int(row[1])) for row in r]
    chart_hour_of_day(act_rows, "ActivityLog — hour-of-day (last 90 days, all activity)",
                      CHARTS / "activity_hour_of_day.png")

    # Daily activity rollup
    with (DATA / "25_activity_daily.csv").open() as f:
        r = csv.reader(f)
        next(r)
        rd = list(r)
        d = [date.fromisoformat(row[0]) for row in rd]
        sessions = [int(row[2]) for row in rd]
    fig, ax = plt.subplots(figsize=(11, 4))
    ax.plot(d, sessions, linewidth=0.7, color="#d62728")
    ax.set_title("ActivityLog — distinct sessions per day (last 365 days)")
    ax.set_ylabel("distinct sessions/day")
    ax.grid(alpha=0.3)
    fig.autofmt_xdate()
    fig.tight_layout()
    fig.savefig(CHARTS / "activity_sessions_per_day.png", dpi=110)
    plt.close(fig)

    print(f"\n{len(growth)} table projections written to data/30_growth_projection.csv")
    print(f"charts → {CHARTS}")


if __name__ == "__main__":
    main()
