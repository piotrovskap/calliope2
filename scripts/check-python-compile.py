#!/usr/bin/env python3
"""Compile Python sources in memory without writing __pycache__ files."""

from __future__ import annotations

import sys
from pathlib import Path


def main(paths: list[str]) -> int:
    if not paths:
        print("ERROR: no Python files given to compile (empty glob?)", file=sys.stderr)
        return 1
    failed = False
    for raw in paths:
        path = Path(raw)
        try:
            source = path.read_text(encoding="utf-8")
            compile(source, str(path), "exec")
        except Exception as exc:  # noqa: BLE001 - report any syntax/compile error.
            print(f"ERROR: {path}: {exc}", file=sys.stderr)
            failed = True
    if failed:
        return 1
    print(f"OK: compiled {len(paths)} Python files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
