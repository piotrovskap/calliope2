#!/usr/bin/env python3
"""Validate app/brain.json — the no-new-data CI gate for the compiled brain.

Asserts the brain is a faithful projection, not an authored artifact:

  1. PROVENANCE  — every node has a `source.path` that exists on disk (or is
                   flagged `derived` with a resolvable source). Nothing floats free.
  2. INTEGRITY   — every edge connects two real nodes; node ids are unique.
  3. RECONCILE   — meta counts match the actual node/edge counts and per-kind tally.

Run from repo root:  python3 scripts/check-brain.py
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BRAIN = ROOT / 'app' / 'brain.json'


def main():
    b = json.loads(BRAIN.read_text(encoding='utf-8'))
    nodes, edges = b['nodes'], b['edges']
    errors = []

    # 1. PROVENANCE + unique ids
    ids = set()
    kind_counts = {}
    for n in nodes:
        nid = n.get('id')
        if nid in ids:
            errors.append(f'INTEGRITY: duplicate node id {nid!r}')
        ids.add(nid)
        kind_counts[n['kind']] = kind_counts.get(n['kind'], 0) + 1
        src = n.get('source')
        path = src.get('path') if src else None
        if not path and not n.get('derived'):
            errors.append(f'PROVENANCE: node {nid!r} has no source and is not derived')
        if path and not (ROOT / path).exists():
            errors.append(f'PROVENANCE: node {nid!r} source path does not exist: {path}')

    # 2. INTEGRITY — edges reference real nodes
    for e in edges:
        if e['src'] not in ids:
            errors.append(f'INTEGRITY: edge {e["id"]!r} src missing: {e["src"]}')
        if e['dst'] not in ids:
            errors.append(f'INTEGRITY: edge {e["id"]!r} dst missing: {e["dst"]}')

    # 3. RECONCILE meta counts
    meta = b.get('meta', {}).get('counts', {})
    if meta.get('nodes') != len(nodes):
        errors.append(f'RECONCILE: meta.nodes {meta.get("nodes")} != {len(nodes)}')
    if meta.get('edges') != len(edges):
        errors.append(f'RECONCILE: meta.edges {meta.get("edges")} != {len(edges)}')
    if meta.get('by_kind') != kind_counts:
        errors.append('RECONCILE: meta.by_kind does not match actual per-kind tally')

    if errors:
        print(f'Brain validation FAILED ({len(errors)} issue(s)):')
        for e in errors[:40]:
            print(f'  - {e}')
        if len(errors) > 40:
            print(f'  ... and {len(errors) - 40} more')
        sys.exit(1)

    derived = sum(1 for n in nodes if n.get('derived'))
    print(f'OK: brain valid — {len(nodes)} nodes ({derived} derived), {len(edges)} edges; '
          f'every node sourced, every edge connects real nodes, counts reconcile')


if __name__ == '__main__':
    main()
