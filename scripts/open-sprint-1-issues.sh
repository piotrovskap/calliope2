#!/usr/bin/env bash
# Open the Sprint 1 issue batch as GitHub issues, parsed from
# specs/sprint-1-issue-batch.md (the single source of truth).
#
#   scripts/open-sprint-1-issues.sh            # dry run — lists what would open
#   scripts/open-sprint-1-issues.sh --create   # actually opens them via `gh`
#
# Idempotent on labels (creates them if missing). Requires `gh` authenticated.
set -euo pipefail
cd "$(dirname "$0")/.."
exec python3 - "$@" <<'PY'
import re, subprocess, sys

REPO = "ConflictHQ/das-tech"
BATCH = "specs/sprint-1-issue-batch.md"
create = "--create" in sys.argv

text = open(BATCH, encoding="utf-8").read()
blocks = re.split(r"\n### \d+\. ", text)[1:]  # drop the preamble
issues = []
labels_all = set()
for b in blocks:
    title, rest = b.split("\n", 1)
    title = title.strip()
    m = re.search(r"\*\*Labels:\*\*\s*(.+)", rest)
    labels = [l.strip() for l in m.group(1).split(",")] if m else []
    labels_all.update(labels)
    body = rest.split("\n---\n")[0].strip()
    issues.append((title, labels, body))

print(f"{len(issues)} issues parsed from {BATCH}:")
for i, (t, l, _) in enumerate(issues, 1):
    print(f"  {i:2}. {t}   [{', '.join(l)}]")

if not create:
    print("\nDry run. Re-run with --create to open them as GitHub issues.")
    sys.exit(0)

# Ensure labels exist (idempotent)
for lab in sorted(labels_all):
    subprocess.run(["gh", "label", "create", lab, "--repo", REPO, "--force"],
                   capture_output=True, text=True)

print()
for title, labels, body in issues:
    cmd = ["gh", "issue", "create", "--repo", REPO, "--title", title, "--body", body]
    for lab in labels:
        cmd += ["--label", lab]
    r = subprocess.run(cmd, capture_output=True, text=True)
    out = (r.stdout or r.stderr).strip().splitlines()[-1] if (r.stdout or r.stderr).strip() else ""
    print(("opened : " if r.returncode == 0 else "FAILED : ") + title + "  " + out)
PY
