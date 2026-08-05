#!/usr/bin/env python3
"""Live spec stats — counts, size distribution, design-gate split, critical
path, and low/high relative-effort bounds, computed from specs/manifest.json.

Counts are data-driven by design: nothing here is stored in the specs, because
stored counts go stale the moment the tree changes. Run this (or open
/specs/stats.html) to get current numbers.

T-shirt sizes score RELATIVE EFFORT + COMPLEXITY, not time. The effort-point
bounds below are a relative score (Fibonacci-ish), not a duration; convert to
calendar time only at the end, with an explicit velocity assumption.

Usage:  python3 scripts/spec-stats.py [id-prefix]   (default: phase-1-build)
"""
from __future__ import annotations

import collections
import json
import os
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ITEMS = json.load(open(os.path.join(ROOT, "specs", "manifest.json")))["items"]
BY = {i["id"]: i for i in ITEMS}
ALL = set(BY)

PREFIX = sys.argv[1] if len(sys.argv) > 1 else "phase-1-build"
DESIGN = "phase-1-architecture.data-model"
ORDER = ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL", "EPIC", "Milestone"]
# relative effort-points (low, high) — a complexity score, NOT time
POINTS = {"XXS": (0.5, 1), "XS": (1, 2), "S": (2, 3), "M": (3, 5), "L": (5, 8),
          "XL": (8, 13), "XXL": (13, 21), "XXXL": (21, 34), "EPIC": (34, 55),
          "Milestone": (55, 89)}

nodes = [i for i in ITEMS if i["id"] == PREFIX or i["id"].startswith(PREFIX + ".")]
stories = [i for i in nodes if i["type"] == "story"]

_g: dict = {}
def gated(nid, stk=()):
    if nid in _g:
        return _g[nid]
    if nid in stk:
        return False
    ds = [d for d in (BY.get(nid, {}).get("depends_on") or []) if d in ALL]
    r = any(d.startswith(DESIGN) for d in ds) or any(gated(d, stk + (nid,)) for d in ds)
    _g[nid] = r
    return r

_lp: dict = {}
def longest(nid, stk=()):
    if nid in _lp:
        return _lp[nid]
    if nid in stk:
        return (0, [])
    ds = [d for d in (BY.get(nid, {}).get("depends_on") or []) if d in ALL]
    if not ds:
        r = (1, [nid])
    else:
        s = max((longest(d, stk + (nid,)) for d in ds), key=lambda t: t[0])
        r = (s[0] + 1, s[1] + [nid])
    _lp[nid] = r
    return r

def bar(n, total, width=24):
    return "█" * round(width * n / total) if total else ""

print(f"SPEC STATS  ::  {PREFIX}")
print(f"nodes: {len(nodes)}  ({', '.join(f'{k} {v}' for k, v in collections.Counter(i['type'] for i in nodes).items())})")

print("\nstories by status:")
for k, v in collections.Counter(s["status"] for s in stories).items():
    print(f"  {k:8s} {v}")

sizes = collections.Counter(s.get("estimate") for s in stories)
print("\nstories by size (relative effort/complexity):")
for s in ORDER:
    if sizes.get(s):
        print(f"  {s:5s} {sizes[s]:3d}  {bar(sizes[s], len(stories))}")

print("\nsize by feature:")
fb = collections.defaultdict(collections.Counter)
for s in stories:
    fb[".".join(s["id"].split(".")[:2])][s.get("estimate")] += 1
for fid in sorted(fb):
    dist = " ".join(f"{k}:{fb[fid][k]}" for k in ORDER if fb[fid][k])
    print(f"  {fid.split('.')[-1]:28s} {dist}")

g = sum(gated(s["id"]) for s in stories)
print("\ndesign-gate split:")
print(f"  pre-gate (startable now)   {len(stories) - g}")
print(f"  gated on design lock 06-19 {g}")

cp = max((longest(s["id"]) for s in stories), key=lambda t: t[0]) if stories else (0, [])
print(f"\ncritical path (deepest dependency chain, {cp[0]} nodes):")
for n in cp[1]:
    print(f"  -> {n.split('.', 1)[1] if '.' in n else n}  [{BY[n].get('estimate', '-')}]" if n in BY else f"  -> {n}")

lo = sum(POINTS.get(s.get("estimate"), (0, 0))[0] for s in stories)
hi = sum(POINTS.get(s.get("estimate"), (0, 0))[1] for s in stories)
epics = [s["id"].split(".")[-1] for s in stories if s.get("estimate") == "EPIC"]
print("\nrelative effort bounds (complexity score, NOT time):")
print(f"  total: {lo:.0f}–{hi:.0f} effort-points")
if epics:
    print(f"  EPICs excluded from a firm plan until broken down: {', '.join(epics)}")
