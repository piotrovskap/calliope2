#!/usr/bin/env python3
"""Validate portal JSON data contracts.

This is deliberately lightweight and dependency-free. It catches structural
drift in hand-maintained tracker files without introducing a JSON-schema tool
chain during Phase 0.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path
from urllib.parse import parse_qs, unquote, urlparse

ROOT = Path(__file__).resolve().parents[1]
DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")


class ValidationError(Exception):
    pass


def load(rel: str) -> dict:
    try:
        return json.loads((ROOT / rel).read_text(encoding="utf-8"))
    except json.JSONDecodeError as exc:
        raise ValidationError(f"{rel}: invalid JSON: {exc}") from exc


def require(condition: bool, msg: str) -> None:
    if not condition:
        raise ValidationError(msg)


def require_fields(obj: dict, fields: list[str], ctx: str) -> None:
    for field in fields:
        require(field in obj and obj[field] not in (None, ""), f"{ctx}: missing {field}")


def validate_versioned(rel: str, data: dict) -> None:
    require(isinstance(data.get("version"), int) and data["version"] >= 1, f"{rel}: version must be positive int")
    require(DATE_RE.match(str(data.get("updated", ""))) is not None, f"{rel}: updated must be YYYY-MM-DD")
    changelog = data.get("changelog")
    require(isinstance(changelog, list) and len(changelog) > 0, f"{rel}: changelog must be non-empty")
    for i, entry in enumerate(changelog):
        require(isinstance(entry, dict), f"{rel}: changelog[{i}] must be object")
        require(DATE_RE.match(str(entry.get("date", ""))) is not None, f"{rel}: changelog[{i}].date invalid")
        require(isinstance(entry.get("note"), str) and entry["note"].strip(), f"{rel}: changelog[{i}].note missing")


def portal_target_exists(raw: str, base: str) -> bool:
    if not raw or raw.startswith(("http://", "https://", "mailto:", "tel:", "#", "javascript:")):
        return True
    parsed = urlparse(raw)
    path = unquote(parsed.path)
    query = parse_qs(parsed.query)
    if path.endswith("reader.html") and query.get("f"):
        return (ROOT / query["f"][0]).exists()
    if path.startswith("/"):
        candidate = ROOT / path.lstrip("/")
    else:
        candidate = (ROOT / base).parent / path
    if str(candidate).endswith("/"):
        candidate = candidate / "index.html"
    if candidate.is_dir():
        candidate = candidate / "index.html"
    return candidate.exists()


def validate_raid() -> None:
    rel = "app/raid.json"
    data = load(rel)
    validate_versioned(rel, data)
    allowed_types = {"risk", "assumption", "issue", "dependency"}
    allowed_severity = {"low", "medium", "high"}
    allowed_status = {"open", "validated", "in-progress", "resolved", "decided", "blocked"}
    ids = set()
    items = data.get("items")
    require(isinstance(items, list) and items, f"{rel}: items must be non-empty list")
    for i, item in enumerate(items):
        ctx = f"{rel}: items[{i}]"
        require_fields(item, ["id", "type", "title", "detail", "severity", "status", "owner", "source"], ctx)
        require(item["id"] not in ids, f"{ctx}: duplicate id {item['id']}")
        ids.add(item["id"])
        require(item["type"] in allowed_types, f"{ctx}: invalid type {item['type']}")
        require(item["severity"] in allowed_severity, f"{ctx}: invalid severity {item['severity']}")
        require(item["status"] in allowed_status, f"{ctx}: invalid status {item['status']}")


def validate_deliverables() -> None:
    rel = "docs/deliverables.json"
    data = load(rel)
    validate_versioned(rel, data)
    items = data.get("items")
    require(isinstance(items, list) and items, f"{rel}: items must be non-empty list")
    for i, item in enumerate(items):
        ctx = f"{rel}: items[{i}]"
        require_fields(item, ["title", "type", "typeClass", "status", "statusClass", "date", "desc", "open"], ctx)
        require(DATE_RE.match(str(item["date"])) is not None, f"{ctx}: date must be YYYY-MM-DD")
        require(portal_target_exists(item["open"], rel), f"{ctx}: open target missing: {item['open']}")
        if item.get("preview"):
            require(portal_target_exists(item["preview"], rel), f"{ctx}: preview target missing: {item['preview']}")


def validate_phase0_deliverables() -> None:
    rel = "docs/phase0-deliverables.json"
    data = load(rel)
    validate_versioned(rel, data)
    items = data.get("deliverables")
    require(isinstance(items, list) and items, f"{rel}: deliverables must be non-empty list")
    allowed = {"pending", "in-progress", "done", "published", "final", "archived"}
    allowed_roadmap = {"complete", "current", "next", "future"}
    ids = set()
    for i, item in enumerate(items):
        ctx = f"{rel}: deliverables[{i}]"
        require_fields(item, ["id", "title", "type", "status", "summary", "detail"], ctx)
        require(item["id"] not in ids, f"{ctx}: duplicate id {item['id']}")
        ids.add(item["id"])
        require(item["status"] in allowed, f"{ctx}: invalid status {item['status']}")
        if item.get("md"):
            require(portal_target_exists(item["md"], rel), f"{ctx}: md target missing: {item['md']}")
        for j, component in enumerate(item.get("components", []) or []):
            cctx = f"{ctx}.components[{j}]"
            require_fields(component, ["id", "title", "status", "summary", "detail"], cctx)
            require(component["status"] in allowed, f"{cctx}: invalid status {component['status']}")
        # roadmap phase states are a distinct vocabulary (docs/status-glossary.md);
        # at most one phase may be "current" so the portal/brain show a single live phase.
        roadmap = item.get("roadmap") or []
        for k, phase in enumerate(roadmap):
            pctx = f"{ctx}.roadmap[{k}]"
            require(phase.get("state") in allowed_roadmap, f"{pctx}: invalid state {phase.get('state')}")
        require(sum(1 for p in roadmap if p.get("state") == "current") <= 1,
                f"{ctx}: more than one roadmap phase marked 'current'")


def validate_open_questions() -> None:
    rel = "analysis/artifacts/open-questions/questions.json"
    data = load(rel)
    validate_versioned(rel, data)
    allowed = {"blocker", "high", "medium", "low", "optional", "resolved"}
    sections = data.get("sections")
    require(isinstance(sections, list) and sections, f"{rel}: sections must be non-empty list")
    for si, section in enumerate(sections):
        require_fields(section, ["label", "items"], f"{rel}: sections[{si}]")
        require(isinstance(section["items"], list), f"{rel}: sections[{si}].items must be list")
        for ii, item in enumerate(section["items"]):
            ctx = f"{rel}: sections[{si}].items[{ii}]"
            require_fields(item, ["status", "question", "context", "owner", "session"], ctx)
            require(item["status"] in allowed, f"{ctx}: invalid status {item['status']}")


def validate_access_tracker() -> None:
    rel = "analysis/artifacts/access-tracker/access.json"
    data = load(rel)
    validate_versioned(rel, data)
    allowed = {"granted", "committed", "pending", "blocked", "na"}
    sections = data.get("sections")
    require(isinstance(sections, list) and sections, f"{rel}: sections must be non-empty list")
    for si, section in enumerate(sections):
        require_fields(section, ["label", "items"], f"{rel}: sections[{si}]")
        require(isinstance(section["items"], list), f"{rel}: sections[{si}].items must be list")
        for ii, item in enumerate(section["items"]):
            ctx = f"{rel}: sections[{si}].items[{ii}]"
            require_fields(item, ["resource", "note", "type", "status", "owner", "requestedBy", "detail"], ctx)
            require(item["status"] in allowed, f"{ctx}: invalid status {item['status']}")


def validate_manifest_quality() -> None:
    # specs/manifest.json: every item must have a non-null type and status
    # (a null type/status means a non-spec file leaked in — exclude it in _gen.py).
    rel = "specs/manifest.json"
    m = load(rel)
    spec_ids: set = set()
    for i, item in enumerate(m.get("items", [])):
        ctx = f"{rel}: items[{i}] ({item.get('id', '?')})"
        require(item.get("type"), f"{ctx}: null type — not a real spec")
        require(item.get("status"), f"{ctx}: null status")
        # ids key the portal/KG; a collision would silently shadow one story.
        require(item.get("id") not in spec_ids, f"{ctx}: duplicate id {item.get('id')}")
        spec_ids.add(item.get("id"))

    # docs/manifest.json: a doc path must appear at most once across all sections.
    drel = "docs/manifest.json"
    d = load(drel)
    seen: set = set()
    dups: list = []

    def walk(node):
        if isinstance(node, dict):
            p = node.get("path")
            if isinstance(p, str):
                dups.append(p) if p in seen else seen.add(p)
            for v in node.values():
                walk(v)
        elif isinstance(node, list):
            for v in node:
                walk(v)

    walk(d)
    require(not dups, f"{drel}: duplicate doc paths: {sorted(set(dups))[:5]}")


def validate_artifact_catalog() -> None:
    # analysis/catalog.json drives the artifacts grid. Two symmetry invariants:
    #   (1) every catalogued id has a descriptor stub the grid fetches as ./{id}.json
    #       (a dangling catalog id renders a broken/empty card);
    #   (2) every rendered artifact view dir (analysis/artifacts/<id>/index.html) is
    #       catalogued (a stray dir is an orphan with no nav path — e.g. cdp-dataflow).
    rel = "analysis/catalog.json"
    data = load(rel)
    ids = data.get("artifacts")
    require(isinstance(ids, list) and ids, f"{rel}: artifacts must be non-empty list")
    require(len(ids) == len(set(ids)), f"{rel}: duplicate artifact ids: {sorted(x for x in set(ids) if ids.count(x) > 1)[:5]}")
    art_dir = ROOT / "analysis" / "artifacts"
    for aid in ids:
        require((art_dir / f"{aid}.json").exists(), f"{rel}: artifact '{aid}' has no descriptor analysis/artifacts/{aid}.json")
    catalogued = set(ids)
    for sub in sorted(p for p in art_dir.iterdir() if p.is_dir()):
        if (sub / "index.html").exists():
            require(sub.name in catalogued, f"{rel}: orphaned artifact view analysis/artifacts/{sub.name}/index.html — not in catalog (add to artifacts[] or remove the dir)")


def main() -> int:
    validators = [
        validate_raid,
        validate_deliverables,
        validate_phase0_deliverables,
        validate_open_questions,
        validate_access_tracker,
        validate_manifest_quality,
        validate_artifact_catalog,
    ]
    try:
        for validator in validators:
            validator()
    except ValidationError as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 1
    print("OK: portal JSON schemas")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
