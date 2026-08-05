#!/usr/bin/env python3
"""Guard hand-written portal literals against their source of truth.

Counts and versions typed directly into portal HTML / markdown drift as the
data grows underneath them (the 'snapshot' failure mode: correct when written,
stale later). Most live counts are now fetch-bound at runtime; this gate covers
the committed fallbacks and the markdown literals that cannot fetch, asserting
each still equals its generated/canonical source so the class can't regress.

Run:  python3 scripts/check-portal-literals.py
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
errors = []


def load(rel):
    return json.loads((ROOT / rel).read_text(encoding="utf-8"))


def read(rel):
    return (ROOT / rel).read_text(encoding="utf-8")


def check(label, needle, rel):
    """Assert a source-derived string appears verbatim in a file."""
    if needle not in read(rel):
        errors.append(f"{label}: {rel} missing expected literal {needle!r} (source drifted — regenerate/update the literal)")


# --- sources of truth ---
kgc = load("app/knowledge_graph.json")["meta"]["counts"]
nodes, edges = f"{kgc['nodes']:,}", f"{kgc['edges']:,}"

brainc = load("app/brain.json")["meta"]["counts"]
brain_nodes, brain_edges = f"{brainc['nodes']:,}", f"{brainc['edges']:,}"
brain_kinds = len(brainc["by_kind"])

dbs = load("docs/databases.json")["databases"]
db_total = len(dbs)
db_erd = sum(1 for d in dbs if d.get("erd"))

access = load("analysis/artifacts/access-tracker/access.json")
access_items = sum(len(s.get("items", [])) for s in access.get("sections", []))

record = load("analysis/artifacts/golden-record/record.json")
gr_ver = str(record.get("status", "")).split("·")[0].strip() or f"v{record.get('version')}.0"

phases = load("specs/estimates.json").get("rollup_by_phase", [])
p1 = next((p for p in phases if "Phase 1" in str(p.get("label", ""))), None)

api_md = read("docs/api-integration-catalog.md")
api_m = re.search(r"(\d+)\s+integrations across\s+(\d+)\s+categories", api_md)

# --- assertions: literal must match source ---
check("KG nodes (home)", nodes, "index.html")
check("KG edges (home)", edges, "index.html")
check("KG nodes (knowledge)", nodes, "knowledge/index.html")
check("KG edges (knowledge)", edges, "knowledge/index.html")
check("brain nodes (knowledge)", f"{brain_nodes} nodes", "knowledge/index.html")
check("brain edges (knowledge)", f"{brain_edges} edges", "knowledge/index.html")
check("brain kinds (knowledge)", f"{brain_kinds} kinds", "knowledge/index.html")
check("access items (home fallback)", f"{access_items} access item", "index.html")
check("db total (reference fallback)", f"{db_total} databases", "reference/index.html")
check("db erd (reference fallback)", f"{db_erd} with erd", "reference/index.html")
check("golden-record version (home)", f"Golden Record ({gr_ver})", "index.html")
check("golden-record version (source-of-truth)", gr_ver, "docs/source-of-truth.md")

if api_m:
    check("api count (reference)", f"{api_m.group(1)} apis", "reference/index.html")
    check("api categories (reference)", f"{api_m.group(2)} categories", "reference/index.html")
else:
    errors.append("docs/api-integration-catalog.md: could not parse 'N integrations across M categories'")

if p1:
    est = f"{int(p1['points'])} points / {p1['low']:g}–{p1['high']:g} engineering-days"
    check("estimates Phase 1 (detailed plan)", est, "docs/deliverables/detailed-phase-1-2-plans.md")
    check("estimates Phase 1 (phase0-deliverables)", est, "docs/phase0-deliverables.json")
else:
    errors.append("specs/estimates.json: no 'Phase 1' rollup found")

if errors:
    print(f"Portal literal check FAILED ({len(errors)} issue(s)):")
    for e in errors:
        print(f"  - {e}")
    sys.exit(1)

print(f"OK: portal literals match sources — KG {nodes}/{edges}, dbs {db_total}/{db_erd} erd, "
      f"access {access_items}, {gr_ver}, "
      f"est {int(p1['points'])}pts" if p1 else "OK: portal literals match sources")
