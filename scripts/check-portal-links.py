#!/usr/bin/env python3
"""Smoke-test local portal links and static asset references."""

from __future__ import annotations

import html.parser
import json
import re
import sys
from pathlib import Path
from urllib.parse import parse_qs, unquote, urlparse

ROOT = Path(__file__).resolve().parents[1]

KEY_PAGES = [
    "index.html",
    "docs/index.html",
    "docs/reader.html",
    "docs/deliverable.html",
    "specs/index.html",
    "app/index.html",
    "analysis/index.html",
    "analysis/session.html",
    "analysis/artifacts/index.html",
    "deliverables/index.html",
    "knowledge/index.html",
    "raid/index.html",
    "reference/index.html",
    "tracker/index.html",
]

ATTRS = {"href", "src"}
SKIP_PREFIXES = ("http://", "https://", "mailto:", "tel:", "javascript:", "data:", "#")
OPTIONAL_REFS = {"/client.config.json"}
FETCH_RE = re.compile(r"""fetch\(\s*['"]([^'"]+)['"]""")


class LinkParser(html.parser.HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.links: list[tuple[str, str]] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        for name, value in attrs:
            if name in ATTRS and value:
                self.links.append((name, value))


def local_target(raw: str, base_file: Path) -> Path | None:
    raw = raw.strip()
    if raw in OPTIONAL_REFS:
        return None
    if not raw or raw.startswith(SKIP_PREFIXES):
        return None
    parsed = urlparse(raw)
    if parsed.scheme or parsed.netloc:
        return None

    path = unquote(parsed.path)
    query = parse_qs(parsed.query)
    if path.endswith("reader.html") and query.get("f"):
        return ROOT / query["f"][0]

    if path.startswith("/"):
        target = ROOT / path.lstrip("/")
    else:
        target = base_file.parent / path

    if raw.endswith("/") or target.is_dir():
        target = target / "index.html"
    return target


def exists(raw: str, base_file: Path) -> bool:
    target = local_target(raw, base_file)
    if target is None:
        return True
    return target.exists()


def docs_from_manifest(rel: str) -> list[str]:
    data = json.loads((ROOT / rel).read_text(encoding="utf-8"))
    paths = []
    for section in data.get("sections", []):
        paths.extend(item["path"] for item in section.get("docs", []) or [])
        for group in section.get("groups", []) or []:
            paths.extend(item["path"] for item in group.get("docs", []) or [])
    return paths


def check_html_page(rel: str) -> list[str]:
    path = ROOT / rel
    errors = []
    if not path.exists():
        return [f"{rel}: key page missing"]
    text = path.read_text(encoding="utf-8", errors="replace")
    parser = LinkParser()
    parser.feed(text)
    refs = [value for _, value in parser.links] + FETCH_RE.findall(text)
    for ref in refs:
        # Dynamic template strings are not statically resolvable.
        if "${" in ref or "`" in ref:
            continue
        if not exists(ref, path):
            target = local_target(ref, path)
            errors.append(f"{rel}: missing target {ref} -> {target.relative_to(ROOT) if target else '?'}")
    return errors


def main() -> int:
    errors: list[str] = []
    for rel in KEY_PAGES:
        errors.extend(check_html_page(rel))

    for rel in ["docs/manifest.json"]:
        for doc in docs_from_manifest(rel):
            if not (ROOT / doc).exists():
                errors.append(f"{rel}: listed doc missing: {doc}")

    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    print("OK: portal links and static asset references")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
