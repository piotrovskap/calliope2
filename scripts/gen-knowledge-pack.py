#!/usr/bin/env python3
"""Walk the knowledge markdowns and emit app/knowledge-pack.json — the chat
agent's search index. Each entry: path (portal-relative), title, summary.

Run from anywhere:  python3 scripts/gen-knowledge-pack.py
"""

from __future__ import annotations

import json
import os
import re

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "app", "knowledge-pack.json")

# (directory, recursive) pairs to index
SOURCES = [
    ("memory", False),
    ("wiki", False),
    ("docs", False),
    ("docs/databases", False),
    ("specs", True),
    ("artifacts/phase-0", False),
    ("artifacts/phase-0/source-docs", False),
]

SKIP_NAMES = {"readme.md", "claude.md", "agents.md"}


def _golden_record_title() -> str:
    """Derive the golden-record title from record.json so it can't drift.
    Reflects the locked version only, deliberately NOT the disputed
    'reviewed & approved / all verified' status text (the verified-flags
    reconciliation is still owed to Alicia + Luis)."""
    p = os.path.join(ROOT, "analysis/artifacts/golden-record/record.json")
    try:
        d = json.load(open(p, encoding="utf-8"))
    except Exception:
        return "Golden Record"
    ver = str(d.get("status", "")).split("·")[0].strip()
    if not ver:
        v = d.get("version")
        ver = f"v{v}.0" if isinstance(v, int) else (f"v{v}" if v else "")
    return f"Golden Record ({ver}, locked)" if ver else "Golden Record"


# Key JSON artifacts the agent can read directly (registered explicitly)
JSON_DOCS = [
    ("analysis/artifacts/open-questions/questions.json", "Open Questions (live tracker)"),
    ("analysis/artifacts/access-tracker/access.json", "Access Tracker (live)"),
    ("analysis/artifacts/golden-record/record.json", _golden_record_title()),
    ("analysis/artifacts/identity-strategies/strategies.json", "Identity Strategy Options (experimental v0)"),
    ("specs/manifest.json", "Project plan manifest (epics/features/stories + statuses)"),
    ("activity.json", "Recent activity feed"),
    ("app/raid.json", "RAID Log — strategic risks, assumptions, issues, dependencies"),
]


def normalize_display(text: str) -> str:
    """Normalize public portal metadata without changing source documents."""
    return re.sub(r"\bConflict\b", "CONFLICT", text)


def extract(path: str) -> tuple[str, str]:
    """Return (title, summary) from a markdown file."""
    text = open(path, encoding="utf-8", errors="replace").read()
    title, summary = "", ""
    m = re.search(r"^---\n(.*?)\n---", text, re.S)
    if m:
        fm = m.group(1)
        t = re.search(r"^(?:title|name):\s*[\"']?(.*?)[\"']?\s*$", fm, re.M)
        d = re.search(r"^description:\s*[\"']?(.*?)[\"']?\s*$", fm, re.M)
        if t:
            title = t.group(1)
        if d:
            summary = d.group(1)
        text = text[m.end():]
    if not title:
        h = re.search(r"^#\s+(.+)$", text, re.M)
        title = h.group(1).strip() if h else os.path.basename(path)
    if not summary:
        for line in text.splitlines():
            line = line.strip()
            if line and not line.startswith(("#", "<!--", "|", "```", ">")):
                summary = line
                break
    return normalize_display(title), normalize_display(summary[:300])


items = []
for src, recursive in SOURCES:
    base = os.path.join(ROOT, src)
    if not os.path.isdir(base):
        continue
    if recursive:
        walker = ((dp, fn) for dp, _, fns in os.walk(base) for fn in fns)
    else:
        walker = ((base, fn) for fn in os.listdir(base))
    for dp, fn in walker:
        if not fn.endswith(".md") or fn.lower() in SKIP_NAMES:
            continue
        full = os.path.join(dp, fn)
        if not os.path.isfile(full):
            continue
        rel = os.path.relpath(full, ROOT).replace(os.sep, "/")
        title, summary = extract(full)
        items.append({"path": rel, "title": title, "summary": summary})

for path, title in JSON_DOCS:
    if os.path.isfile(os.path.join(ROOT, path)):
        items.append({
            "path": path,
            "title": normalize_display(title),
            "summary": "Versioned JSON data file — read directly for current values.",
        })

items.sort(key=lambda x: x["path"])
os.makedirs(os.path.dirname(OUT), exist_ok=True)
json.dump({"generated_for": "portal-chat-agent", "count": len(items), "items": items},
          open(OUT, "w", encoding="utf-8"), indent=1)
print(f"Wrote {OUT} ({len(items)} entries)")
