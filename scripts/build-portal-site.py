#!/usr/bin/env python3
"""Build the Cloudflare assets directory for the portal.

Wrangler serves static assets from `_site/`; this script stages tracked portal
assets there so local caches, git metadata, secrets, and process files never
enter the asset namespace.

Raw source artifacts (PDF / DOCX / XLSX) ARE included in `_site` by design: the
client portal ships them as reference material, gated by Cloudflare Access (Zero
Trust) rather than by omission. Runtime/process/dev files are excluded via the
ignore rules below.
"""

from __future__ import annotations

import fnmatch
import os
import shutil
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "_site"
IGNORE = ROOT / ".assetsignore"


def load_patterns() -> list[str]:
    if not IGNORE.exists():
        return []
    patterns = []
    for line in IGNORE.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if stripped and not stripped.startswith("#"):
            patterns.append(stripped.rstrip("/"))
    return patterns


def ignored(path: str, patterns: list[str]) -> bool:
    parts = path.split("/")
    for pattern in patterns:
        if path == pattern or path.startswith(pattern + "/"):
            return True
        if fnmatch.fnmatch(path, pattern):
            return True
        # Directory pattern (possibly globbed, e.g. analysis/sessions/*/cache):
        # also exclude everything nested under it. fnmatch '*' spans '/', so a
        # single trailing '/*' covers any depth.
        if fnmatch.fnmatch(path, pattern + "/*"):
            return True
        # A leading '**/' must also match at the repo root (fnmatch's '**/' needs
        # at least one dir segment), so '**/*.pyc' also excludes a root 'x.pyc'.
        if pattern.startswith("**/") and fnmatch.fnmatch(path, pattern[3:]):
            return True
        if "/" not in pattern and any(part == pattern for part in parts):
            return True
    return False


def git_files(cwd: Path, prefix: str = "") -> list[str]:
    try:
        output = subprocess.check_output(["git", "-C", str(cwd), "ls-files", "-z"], text=False)
        files = [item.decode("utf-8") for item in output.split(b"\0") if item]
    except (FileNotFoundError, subprocess.CalledProcessError):
        # Some delivery environments contain a source snapshot without .git.
        # Fall back to the filesystem; tracked_asset_files still applies
        # .assetsignore before anything is copied to the public asset directory.
        files = [
            str(path.relative_to(cwd))
            for path in cwd.rglob("*")
            if path.is_file()
            and ".git" not in path.parts
            and "node_modules" not in path.parts
        ]
    return [f"{prefix}{path}" for path in files]


def ensure_wiki() -> None:
    """Best-effort populate the wiki submodule so its pages ship in _site.

    The wiki is a submodule with `update = none` in .gitmodules, so a generic
    `git submodule update` skips it — it must be named explicitly. Deploy build
    environments (Cloudflare) often start with an uninitialized wiki dir, which
    is why live wiki pages 404. Non-fatal: if the wiki can't be fetched (e.g. no
    remote auth in the build env), the build proceeds without it (see issue #71).
    """
    wiki = ROOT / "wiki"
    if wiki.is_dir() and any(wiki.iterdir()):
        return  # already populated (CI / local)
    try:
        # `-c submodule.wiki.update=checkout` + `--force` overrides the `update = none`
        # in .gitmodules (a plain `submodule update` skips it) — matches CI's command.
        subprocess.run(
            ["git", "-C", str(ROOT), "-c", "submodule.wiki.update=checkout",
             "submodule", "update", "--init", "--force", "wiki"],
            check=True, timeout=180)
    except Exception as exc:  # noqa: BLE001 - best-effort, never break the build
        print(f"  warning: wiki submodule not initialized ({exc}); wiki pages will be absent")


def tracked_asset_files(patterns: list[str]) -> list[str]:
    files = [path for path in git_files(ROOT) if path != "wiki"]
    wiki = ROOT / "wiki"
    if wiki.is_dir() and any(wiki.iterdir()):
        try:
            files.extend(git_files(wiki, "wiki/"))
        except subprocess.CalledProcessError:
            print("  warning: wiki/ present but not a git repo; skipping wiki pages")
    return [path for path in sorted(files) if not ignored(path, patterns)]


def main() -> int:
    ensure_wiki()
    patterns = load_patterns()
    if OUT.exists():
        shutil.rmtree(OUT)
    OUT.mkdir(parents=True)

    count = 0
    for rel in tracked_asset_files(patterns):
        src = ROOT / rel
        if not src.is_file():
            continue
        dst = OUT / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dst)
        count += 1

    # Customers is the public application entry point. Keep the original
    # /customers/ paths available, but publish the UI at the site root so the
    # Pages URL opens directly on the customer dashboard.
    for name in ("index.html", "profile.html", "daisyui.generated.css"):
        src = ROOT / name
        if src.is_file():
            shutil.copy2(src, OUT / name)
    print("Published Customers UI at /")
    print(f"Wrote {OUT} ({count} files)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
