#!/usr/bin/env python3
"""Interactive REPL to scaffold a new spec node (epic / feature / story).

Prompts for the target location and frontmatter, auto-numbers the file within
its folder, writes the markdown with a correct frontmatter block, echoes the
derived id, and offers to regenerate manifest.json.

Usage:
    python3 specs/_new.py

The spec schema lives in specs/README.md. ids are derived from the path, so you
never type one — this tool shows you what it will be. Pair-friendly: run it,
answer the prompts, done.
"""

from __future__ import annotations

import os
import re
import subprocess
import sys

SPECS_DIR = os.path.dirname(os.path.abspath(__file__))
LEADING_NUM_RE = re.compile(r"^\d+[-_]?")
SLUG_RE = re.compile(r"[^a-z0-9]+")


def strip_segment(seg: str) -> str:
    return LEADING_NUM_RE.sub("", seg)


def slugify(text: str) -> str:
    return SLUG_RE.sub("-", text.strip().lower()).strip("-")


def derive_id(rel_path: str, is_container: bool) -> str:
    """Mirror specs/_gen.py: de-ordinaled, dotted path id."""
    parts = rel_path.split(os.sep)
    folders = parts[:-1]
    stem = os.path.splitext(parts[-1])[0]
    segments = [strip_segment(f) for f in folders]
    if not is_container:
        segments.append(strip_segment(stem))
    return ".".join(s for s in segments if s)


def next_ordinal(folder: str) -> str:
    """Next NN- prefix in a folder, scanning both files and subfolders."""
    if not os.path.isdir(folder):
        return "01"
    nums = []
    for name in os.listdir(folder):
        m = re.match(r"^(\d+)[-_]", name)
        if m:
            nums.append(int(m.group(1)))
    nxt = (max(nums) + 1) if nums else 1
    return f"{nxt:02d}"


def list_dirs(folder: str) -> list[str]:
    if not os.path.isdir(folder):
        return []
    return sorted(
        d for d in os.listdir(folder) if os.path.isdir(os.path.join(folder, d))
    )


def ask(prompt: str, default: str | None = None) -> str:
    suffix = f" [{default}]" if default is not None else ""
    val = input(f"{prompt}{suffix}: ").strip()
    return val or (default or "")


def ask_list(prompt: str) -> list[str]:
    raw = input(f"{prompt} (comma-separated, blank for none): ").strip()
    return [x.strip() for x in raw.split(",") if x.strip()]


def ask_body() -> str:
    print("Body (end with a single '.' on its own line, or Ctrl-D):")
    lines: list[str] = []
    try:
        while True:
            line = input()
            if line.strip() == ".":
                break
            lines.append(line)
    except EOFError:
        pass
    return "\n".join(lines).strip()


def pick_folder(start: str, label: str) -> str:
    """Walk down ordinal subfolders to choose a parent container folder."""
    cur = start
    while True:
        subs = [d for d in list_dirs(cur) if re.match(r"^\d", d)]
        if not subs:
            return cur
        print(f"\n{label} — pick under {os.path.relpath(cur, SPECS_DIR)}/:")
        for i, d in enumerate(subs, 1):
            print(f"  {i}. {d}")
        print("  0. (use this folder)")
        choice = input("choice: ").strip()
        if choice in ("", "0"):
            return cur
        if choice.isdigit() and 1 <= int(choice) <= len(subs):
            cur = os.path.join(cur, subs[int(choice) - 1])
        else:
            print("  invalid choice")


def main() -> None:
    print("New spec node — epic (e) / feature (f) / story (s)")
    kind = ask("type", "s").lower()[:1]
    if kind == "e":
        node_type, container, base = "epic", True, SPECS_DIR
    elif kind == "f":
        node_type, container, base = "feature", True, pick_folder(SPECS_DIR, "Epic")
    else:
        node_type, container, base = "story", False, pick_folder(SPECS_DIR, "Feature")

    title = ask("title")
    if not title:
        print("title is required"); sys.exit(1)
    priority = ask("priority (high/medium/low)", "medium")
    status = ask("status (planned/active/done)", "planned")
    date = ask("date (YYYY-MM-DD or ~)", "~")
    depends = ask_list("depends_on ids")
    labels = ask_list("labels")
    body = ask_body()

    ordinal = next_ordinal(base)
    if container:
        folder_name = f"{ordinal}-{slugify(title)}"
        folder = os.path.join(base, folder_name)
        os.makedirs(folder, exist_ok=True)
        fname = "00-epic.md" if node_type == "epic" else "00-feature.md"
        path = os.path.join(folder, fname)
    else:
        path = os.path.join(base, f"{ordinal}-{slugify(title)}.md")

    rel = os.path.relpath(path, SPECS_DIR)
    node_id = derive_id(rel, container)

    fm = [f'title: "{title}"', f"type: {node_type}", f"status: {status}",
          f"priority: {priority}"]
    if depends:
        fm.append("depends_on: [" + ", ".join(depends) + "]")
    if labels:
        fm.append("labels: [" + ", ".join(labels) + "]")
    fm.append(f"date: {date}")
    content = "---\n" + "\n".join(fm) + "\n---\n\n" + (body or "TODO.") + "\n"

    if os.path.exists(path):
        print(f"refusing to overwrite existing {rel}"); sys.exit(1)
    with open(path, "w", encoding="utf-8") as fh:
        fh.write(content)
    print(f"\nWrote specs/{rel}\n  id: {node_id}")

    if ask("regenerate manifest.json now? (y/n)", "y").lower().startswith("y"):
        subprocess.run([sys.executable, os.path.join(SPECS_DIR, "_gen.py")], check=False)


if __name__ == "__main__":
    main()
