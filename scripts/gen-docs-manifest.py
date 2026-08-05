#!/usr/bin/env python3
"""Regenerate docs/manifest.json for the portal documentation browser.

The manifest is intentionally curated: section/group placement carries product
meaning, so the generator preserves existing placement and metadata, validates
paths, corrects counts, and appends newly discovered markdown files to safe
default groups instead of dropping them silently.
"""

from __future__ import annotations

import datetime as dt
import json
import os
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "docs" / "manifest.json"


def load_existing() -> dict:
    if not MANIFEST.exists():
        return {"sections": []}
    return json.loads(MANIFEST.read_text(encoding="utf-8"))


def flatten_docs(manifest: dict) -> dict[str, dict]:
    out: dict[str, dict] = {}
    for section in manifest.get("sections", []):
        for item in section.get("docs", []) or []:
            out[item["path"]] = item
        for group in section.get("groups", []) or []:
            for item in group.get("docs", []) or []:
                out[item["path"]] = item
    return out


def git_date(path: str) -> str:
    try:
        if path.startswith("wiki/"):
            result = subprocess.check_output(
                ["git", "-C", str(ROOT / "wiki"), "log", "-1", "--format=%as", "--", path[5:]],
                text=True,
            ).strip()
        else:
            result = subprocess.check_output(
                ["git", "log", "-1", "--format=%as", "--", path],
                cwd=ROOT,
                text=True,
            ).strip()
        return result or dt.date.today().isoformat()
    except subprocess.CalledProcessError:
        return dt.date.today().isoformat()


def titleize(path: str) -> str:
    stem = Path(path).stem
    return re.sub(r"\s+", " ", stem.replace("-", " ").replace("_", " ")).strip().title()


def normalize_display(text: str) -> str:
    return re.sub(r"\bConflict\b", "CONFLICT", text)


def make_doc(path: str, existing: dict[str, dict], title: str | None = None) -> dict | None:
    old = existing.get(path, {})
    if not (ROOT / path).exists():
        print(f"WARNING: dropping missing docs manifest path: {path}")
        return None
    item = {
        "title": normalize_display(title or old.get("title") or titleize(path)),
        "path": path,
        "updated": old.get("updated") or git_date(path),
    }
    return item


def existing_section(manifest: dict, section_id: str) -> dict:
    for section in manifest.get("sections", []):
        if section.get("id") == section_id:
            return section
    raise SystemExit(f"missing section in existing docs manifest: {section_id}")


def doc_paths(section: dict) -> set[str]:
    paths = {item["path"] for item in section.get("docs", []) or []}
    for group in section.get("groups", []) or []:
        paths.update(item["path"] for item in group.get("docs", []) or [])
    return paths


def rebuild_simple_section(seed: dict, existing: dict[str, dict], extra_paths: list[str] | None = None) -> dict:
    docs = [
        doc
        for item in seed.get("docs", []) or []
        if (doc := make_doc(item["path"], existing, item.get("title"))) is not None
    ]
    for path in extra_paths or []:
        if path not in {item["path"] for item in docs}:
            doc = make_doc(path, existing)
            if doc is not None:
                docs.append(doc)
    return {
        "id": seed["id"],
        "label": normalize_display(seed["label"]),
        "description": normalize_display(seed.get("description", "")),
        "count": len(docs),
        "docs": docs,
    }


def rebuild_grouped_section(seed: dict, existing: dict[str, dict], extras_by_group: dict[str, list[str]] | None = None) -> dict:
    groups = []
    for group in seed.get("groups", []) or []:
        docs = [
            doc
            for item in group.get("docs", []) or []
            if (doc := make_doc(item["path"], existing, item.get("title"))) is not None
        ]
        group_id = group.get("id") or ""
        for path in (extras_by_group or {}).get(group_id, []):
            if path not in {item["path"] for item in docs}:
                doc = make_doc(path, existing)
                if doc is not None:
                    docs.append(doc)
        new_group = {}
        if group.get("id"):
            new_group["id"] = group["id"]
        new_group["label"] = normalize_display(group["label"])
        new_group["docs"] = docs
        groups.append(new_group)
    return {
        "id": seed["id"],
        "label": normalize_display(seed["label"]),
        "description": normalize_display(seed.get("description", "")),
        "count": sum(len(group["docs"]) for group in groups),
        "groups": groups,
    }


def discover_unindexed(manifest: dict) -> tuple[list[str], dict[str, list[str]], list[str]]:
    indexed = set()
    for section in manifest.get("sections", []):
        indexed.update(doc_paths(section))

    wiki_extra = []
    das_general_extra: list[str] = []
    research_extra: list[str] = []
    for path in sorted(str(p.relative_to(ROOT)).replace(os.sep, "/") for p in (ROOT / "wiki").glob("*.md")):
        if path not in indexed and not path.endswith("-API-Info.md"):
            wiki_extra.append(path)
    for base in [
        ROOT / "artifacts" / "phase-0" / "confluence",
        ROOT / "artifacts" / "phase-0" / "source-docs",
    ]:
        for p in sorted(base.glob("*.md")):
            path = str(p.relative_to(ROOT)).replace(os.sep, "/")
            if path not in indexed:
                das_general_extra.append(path)
    for p in sorted((ROOT / "docs").glob("*.md")):
        path = str(p.relative_to(ROOT)).replace(os.sep, "/")
        if path not in indexed:
            research_extra.append(path)
    return wiki_extra, {"general": das_general_extra}, research_extra


def main() -> None:
    current = load_existing()
    existing = flatten_docs(current)
    wiki_extra, das_extras, research_extra = discover_unindexed(current)

    sections = [
        rebuild_simple_section(existing_section(current, "wiki"), existing, wiki_extra),
        rebuild_grouped_section(existing_section(current, "das-source"), existing, das_extras),
        rebuild_simple_section(existing_section(current, "specs"), existing),
        rebuild_simple_section(existing_section(current, "agendas"), existing),
        rebuild_grouped_section(existing_section(current, "api-references"), existing),
        rebuild_simple_section(existing_section(current, "research"), existing, research_extra),
    ]
    # A doc must appear at most once across all sections — drop later duplicates
    # (a curated doc that was filed under two groups, e.g. LotVantage / Integrations
    # Description) and recompute each section's count from what actually remains.
    seen: set[str] = set()

    def _dedupe(node):
        if isinstance(node, list):
            out = []
            for v in node:
                if isinstance(v, dict) and isinstance(v.get("path"), str):
                    if v["path"] in seen:
                        continue
                    seen.add(v["path"])
                out.append(_dedupe(v))
            return out
        if isinstance(node, dict):
            return {k: _dedupe(v) for k, v in node.items()}
        return node

    def _count(node):
        if isinstance(node, list):
            return sum(_count(v) for v in node)
        if isinstance(node, dict):
            return (1 if isinstance(node.get("path"), str) else 0) + sum(
                _count(v) for k, v in node.items() if k != "count"
            )
        return 0

    sections = _dedupe(sections)
    for section in sections:
        section["count"] = _count(section)

    generated = current.get("generated") if current.get("sections") == sections else dt.date.today().isoformat()
    payload = {"generated": generated, "sections": sections}
    MANIFEST.write_text(json.dumps(payload, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    total = sum(section["count"] for section in sections)
    print(f"Wrote {MANIFEST} ({total} docs)")


if __name__ == "__main__":
    main()
