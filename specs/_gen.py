#!/usr/bin/env python3
"""Walk specs/ and generate manifest.json.

Schema: folder depth = hierarchy level. `00-epic.md` / `00-feature.md` files
describe containers; numbered sibling files are stories under them.

Run from anywhere:  python3 specs/_gen.py
Writes:             specs/manifest.json
"""

from __future__ import annotations

import datetime
import json
import os
import re

try:
    import yaml  # type: ignore

    _HAVE_YAML = True
except ImportError:  # pragma: no cover - fallback path
    _HAVE_YAML = False

SPECS_DIR = os.path.dirname(os.path.abspath(__file__))
REPO_ROOT = os.path.dirname(SPECS_DIR)
MANIFEST = os.path.join(SPECS_DIR, "manifest.json")

# Files that are not specs.
SKIP_NAMES = {"readme.md", "claude.md", "agents.md", "index.html", "story-standard.md", "sprint-1-issue-batch.md"}

FRONTMATTER_RE = re.compile(r"^---\s*\n(.*?)\n---\s*\n?(.*)$", re.DOTALL)
LEADING_NUM_RE = re.compile(r"^\d+[-_]?")


def strip_segment(segment: str) -> str:
    """Strip a leading numeric ordinal (e.g. ``01-kickoff`` -> ``kickoff``)."""
    return LEADING_NUM_RE.sub("", segment)


def split_frontmatter(text: str) -> tuple[str, str]:
    """Return (frontmatter_block, body). Empty frontmatter if none present."""
    match = FRONTMATTER_RE.match(text)
    if not match:
        return "", text
    return match.group(1), match.group(2)


def parse_scalar(raw: str):
    """Coerce a bare YAML scalar string into a Python value."""
    value = raw.strip()
    if value in ("", "~", "null", "None"):
        return None
    if (value.startswith('"') and value.endswith('"')) or (
        value.startswith("'") and value.endswith("'")
    ):
        return value[1:-1]
    if value.startswith("[") and value.endswith("]"):
        inner = value[1:-1].strip()
        if not inner:
            return []
        return [parse_scalar(item) for item in inner.split(",")]
    return value


def parse_frontmatter_manual(block: str) -> dict:
    """Minimal YAML parser for the subset this project uses.

    Handles ``key: value``, inline ``[a, b]`` lists, and block lists of the
    form::

        key:
          - item
          - item
    """
    data: dict = {}
    lines = block.splitlines()
    i = 0
    while i < len(lines):
        line = lines[i]
        if not line.strip() or line.lstrip().startswith("#"):
            i += 1
            continue
        # Block list item belonging to the previous key is consumed below, so a
        # stray one here means malformed input — skip it defensively.
        if line.lstrip().startswith("- "):
            i += 1
            continue
        if ":" not in line:
            i += 1
            continue
        key, _, rest = line.partition(":")
        key = key.strip()
        rest = rest.strip()
        if rest == "":
            # Possible block list on following indented lines.
            items = []
            j = i + 1
            while j < len(lines) and lines[j].lstrip().startswith("- "):
                items.append(parse_scalar(lines[j].lstrip()[2:]))
                j += 1
            if items:
                data[key] = items
                i = j
                continue
            data[key] = None
            i += 1
            continue
        data[key] = parse_scalar(rest)
        i += 1
    return data


def parse_frontmatter(block: str) -> dict:
    if not block.strip():
        return {}
    if _HAVE_YAML:
        loaded = yaml.safe_load(block)
        return loaded if isinstance(loaded, dict) else {}
    return parse_frontmatter_manual(block)


def derive_id(rel_path: str) -> str:
    """Derive a dotted id from a spec path.

    ``01-phase-0-discovery/01-kickoff-sessions/01-kickoff.md``
    -> ``phase-0-discovery.kickoff-sessions.kickoff``

    Container files (``00-epic.md`` / ``00-feature.md``) derive the id of the
    folder they describe — the trailing filename segment is dropped.
    """
    parts = rel_path.split(os.sep)
    filename = parts[-1]
    folders = parts[:-1]
    stem = os.path.splitext(filename)[0]

    segments = [strip_segment(f) for f in folders]
    if not is_container(stem):
        segments.append(strip_segment(stem))
    return ".".join(seg for seg in segments if seg)


def is_container(stem: str) -> bool:
    return stem in ("00-epic", "00-feature") or stem.startswith("00-")


def level_for(rel_path: str, stem: str) -> int:
    """Hierarchy level: epic=1, feature=2, story=3+ (by folder depth)."""
    folders = rel_path.split(os.sep)[:-1]
    depth = len(folders)
    if is_container(stem):
        # 00-epic.md sits at depth 1, 00-feature.md at depth 2.
        return depth
    # A story file lives one level below its containing folder.
    return depth + 1


def parent_id_of(rel_path: str, stem: str) -> str | None:
    """Parent id, derived from the path (never from a custom frontmatter id).

    - Epic container (``00-epic.md`` at depth 1) has no parent.
    - Any other container (``00-feature.md``) parents to its enclosing folder.
    - A story parents to its own containing folder (the feature/epic).

    Using the *derived* folder id here means a story with an overridden id
    (e.g. ``discovery.access-provisioning.foo``) still links to its real
    parent folder (``phase-0-discovery.access-provisioning``) rather than to a
    truncation of its custom id.
    """
    folders = rel_path.split(os.sep)[:-1]
    if is_container(stem):
        # Drop the container's own folder; parent is the folder above it.
        parent_folders = folders[:-1]
    else:
        # Story's parent is the folder it lives in.
        parent_folders = folders
    if not parent_folders:
        return None
    return ".".join(strip_segment(f) for f in parent_folders if strip_segment(f))


def body_preview(body: str, length: int = 200) -> str:
    text = " ".join(body.split())
    return text[:length]


def collect_items() -> list[dict]:
    items: list[dict] = []
    for dirpath, dirnames, filenames in os.walk(SPECS_DIR):
        dirnames.sort()
        for name in sorted(filenames):
            if not name.lower().endswith(".md"):
                continue
            if name.lower() in SKIP_NAMES:
                continue
            abs_path = os.path.join(dirpath, name)
            rel_to_specs = os.path.relpath(abs_path, SPECS_DIR)
            stem = os.path.splitext(name)[0]

            with open(abs_path, encoding="utf-8") as fh:
                text = fh.read()
            block, body = split_frontmatter(text)
            fm = parse_frontmatter(block)

            container = is_container(stem)
            derived = derive_id(rel_to_specs)
            item_id = fm.get("id") or derived

            rel_to_repo = os.path.relpath(abs_path, REPO_ROOT)

            depends = fm.get("depends_on") or []
            if isinstance(depends, str):
                depends = [depends]
            labels = fm.get("labels") or []
            if isinstance(labels, str):
                labels = [labels]
            artifacts = fm.get("artifacts") or []
            if isinstance(artifacts, str):
                artifacts = [artifacts]

            items.append(
                {
                    "id": item_id,
                    "title": fm.get("title") or stem,
                    "type": fm.get("type"),
                    "status": fm.get("status"),
                    "priority": fm.get("priority"),
                    "depends_on": depends,
                    "estimate": fm.get("estimate"),
                    "assignee": fm.get("assignee"),
                    "labels": labels,
                    "artifacts": artifacts,
                    "date": fm.get("date"),
                    "path": rel_to_repo,
                    "level": level_for(rel_to_specs, stem),
                    "parent_id": parent_id_of(rel_to_specs, stem),
                    "children": [],
                    "body_preview": body_preview(body),
                    "_container": container,
                    "_derived_id": derived,
                }
            )
    return items


def link_children(items: list[dict]) -> None:
    by_id = {it["id"]: it for it in items}
    # Container files also expose their folder id under the derived id so that
    # stories whose parent_id points at the folder resolve even when the
    # container declares a custom frontmatter id.
    for it in items:
        if it["_container"] and it["_derived_id"] not in by_id:
            by_id[it["_derived_id"]] = it
    for it in items:
        parent = it["parent_id"]
        if parent and parent in by_id and by_id[parent] is not it:
            by_id[parent]["children"].append(it["id"])


def main() -> None:
    items = collect_items()
    link_children(items)
    for it in items:
        it.pop("_container", None)
        it.pop("_derived_id", None)

    generated = datetime.date.today().isoformat()
    if os.path.exists(MANIFEST):
        try:
            with open(MANIFEST, encoding="utf-8") as fh:
                current = json.load(fh)
            if current.get("items") == items:
                generated = current.get("generated") or generated
        except (OSError, json.JSONDecodeError):
            pass

    payload = {
        "generated": generated,
        "items": items,
    }
    with open(MANIFEST, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, indent=2, ensure_ascii=False)
        fh.write("\n")
    print(f"Wrote {MANIFEST} ({len(items)} items)")


if __name__ == "__main__":
    main()
