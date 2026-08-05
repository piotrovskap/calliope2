#!/usr/bin/env python3
"""Guard: internal-only files must never reach the published portal.

`_internal/` holds team-only material (e.g. the accuracy ledger documenting past
defects in client-facing docs). It is meant to be excluded from `_site/` by
`.assetsignore`, but a mis-written ignore pattern (`**/_internal` only matches
paths *ending* in `/_internal`, not the files under it) silently leaks it. This
gate computes the exact published file list using the build script's own matcher
and fails if any private path survives — so the exclusion can't regress.
"""
import sys
import importlib.util
from pathlib import Path

SCRIPTS = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location("build_portal_site", SCRIPTS / "build-portal-site.py")
build = importlib.util.module_from_spec(spec)
spec.loader.exec_module(build)

# Path components that must never appear in a published asset path.
PRIVATE_SEGMENTS = ("_internal",)

patterns = build.load_patterns()
published = build.tracked_asset_files(patterns)

leaks = [p for p in published if any(seg in p.split("/") for seg in PRIVATE_SEGMENTS)]

if leaks:
    print(f"Internal-file publish check FAILED ({len(leaks)} leaked):")
    for p in leaks:
        print(f"  - {p}  (private — fix the .assetsignore pattern; bare name, not '**/name')")
    sys.exit(1)

print(f"OK: no internal files published — {len(published)} assets, none under {PRIVATE_SEGMENTS}")
