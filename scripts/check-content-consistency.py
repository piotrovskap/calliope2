#!/usr/bin/env python3
"""Cross-file content consistency checks for the DAS CDP portal.

Catches drift between the JSON/HTML/Markdown sources that the portal renders
from — the kinds of inconsistency that pass `python3 -m json.tool` and a link
check but still render wrong or contradict each other:

  1. CSS coverage      — every status/access value in docs/databases.json has a
                         matching .st-/.ac- rule in docs/databases/index.html.
                         (Real bug: 'partial'/'blocked' rendered undefined CSS.)
  2. Open-questions     — no database/item is listed as BOTH active and parked
                         in memory/open-questions.md. (CommonClientID was both.)
  3. Tracker vs FM      — for a DB named in BOTH the access tracker and a per-DB
                         doc's frontmatter, flag only HARD access contradictions
                         (granted vs blocked). Lifecycle vs catalog axes differ.
  4. Frontmatter schema — every per-DB doc has the required keys and in-enum
                         access/status values.
  5. Question drift    — no bullet under an OPEN section of open-questions.md
                         (Active Asks / Active Design Questions) carries a
                         resolution marker (CLOSED/ANSWERED/DEPRIORITIZED +
                         date). This is the section-vs-text drift that made
                         7 already-answered questions read as open (2026-06-21).
  6. Action-item drift — no action-items.json item with status open/in-progress
                         has a closure marker (CLOSED/DONE/RESOLVED + date) in
                         its context. This is the field-vs-text drift #138 fixed
                         by hand. Closure dates must also be real calendar dates.

stdlib only. Exit 0 + 'OK: content consistency' when clean; exit 1 with one
clear line per issue otherwise. Wired into `make ci-checks`.

Checks 5 and 6 are the drift guard: status is encoded twice (section/field vs
inline prose) and they can silently disagree. The build now fails when they do,
so the manual consistency audits (PRs #138, #140) become automatic.
"""
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATABASES_JSON = ROOT / 'docs' / 'databases.json'
INDEX_HTML = ROOT / 'docs' / 'databases' / 'index.html'
DB_DIR = ROOT / 'docs' / 'databases'
OPEN_QUESTIONS = ROOT / 'memory' / 'open-questions.md'
ACCESS_JSON = ROOT / 'analysis' / 'artifacts' / 'access-tracker' / 'access.json'
ACTION_ITEMS = ROOT / 'analysis' / 'action-items.json'
DECISIONS_MD = ROOT / 'memory' / 'decisions.md'
SPEC_MANIFEST = ROOT / 'specs' / 'manifest.json'

# Docs that assert spec-id traceability: a full phase-N id they cite must exist
# in the generated manifest (catches stale/renamed ids and feature-shell typos).
TRACE_DOCS = ('docs/build-readiness-traceability.md', 'specs/sprint-1-issue-batch.md', 'BUILD-START.md')
# Trees excluded from decision-anchor scanning: generated projections and frozen
# KG baselines quote source text verbatim (including historical anchors), so they
# are not live claims to validate.
REF_SCAN_EXCLUDE = ('_site/', 'node_modules/', '__pycache__', '.git/',
                    'analysis/kg/baseline/', 'app/brain.json', 'app/knowledge', 'app/raid.json')

# open-questions.md '## ' headings whose bullets gen-brain.py maps to status
# 'open' (see adapt_open_questions). A resolution marker in one of these is drift.
OPEN_SECTION_KEYS = ('Active Asks', 'Active Design Questions')

# A full-resolution marker: the prose says this item is settled. A leading
# 20YY-MM-DD is captured for calendar validation. 'still open' / 're-open(ed)'
# describe a genuinely-open item and skip the whole bullet (RESOLVED_NOT).
# 'partially answered' is NOT a full resolution either, but it is handled
# per-occurrence (not whole-bullet) so a long bullet mentioning it as history
# cannot mask a leading CLOSED/ANSWERED marker — the Q16 gap, fixed 2026-06-21.
RESOLVED_MARKER = re.compile(
    r'\b(CLOSED|ANSWERED|DEPRIORITIZED|RESOLVED|DONE)\b\s*'
    r'(?:[—:-]\s*)?(\d{4}-\d{2}-\d{2})?', re.I)
RESOLVED_NOT = re.compile(r'still\s+open|re-?open', re.I)

# Per-DB docs that are not databases (mirror gen-databases.py's EXCLUDE + README).
FM_EXCLUDE = {'README.md', '_template.md', 'data-flow.md'}

# Frontmatter enums (the canonical sets the portal badges + gen-databases assume).
ACCESS_ENUM = {'granted', 'partial', 'pending', 'blocked', 'committed', 'na'}
STATUS_ENUM = {'pending', 'in-progress', 'partial', 'blocked', 'complete', 'na'}

# Access values that are a genuine grant/deny — the only pair that can hard-
# contradict between the tracker (lifecycle) and frontmatter (catalog state).
GRANT_VALUES = {'granted'}
DENY_VALUES = {'blocked'}


def fail(issues):
    """Print one line per issue and exit non-zero."""
    for msg in issues:
        print(f'FAIL: {msg}')
    sys.exit(1)


# ── frontmatter parsing (matches scripts/gen-databases.py semantics) ──────────
def parse_frontmatter(text):
    """Return the leading YAML frontmatter as a flat {key: value} dict.

    Same flat-key, inline-`# comment`-stripping behavior as gen-databases.py so
    this validator sees exactly what the generator sees (e.g. feedhub's
    `status: partial — ...` and the inline-commented access values).
    """
    text = text.lstrip('﻿')
    m = re.match(r'^---\s*\n(.*?)\n---\s*\n?', text, re.DOTALL)
    if not m:
        return {}
    meta = {}
    for line in m.group(1).splitlines():
        if not line.strip() or ':' not in line:
            continue
        key, val = line.split(':', 1)
        val = re.sub(r'\s+#.*$', '', val)  # drop trailing inline comment
        meta[key.strip()] = val.strip().strip('"\'')
    return meta


def norm_status(raw):
    """Normalize a status value to its leading token, as gen-databases.py does.

    'partial — direct access blocked; ...' -> 'partial'. Splits on the first
    whitespace-led em-dash / open-paren / hyphen so a clean badge token remains.
    """
    raw = raw or 'pending'
    return re.split(r'\s+[—(\-]', raw, maxsplit=1)[0].strip() or 'pending'


# ── name matching ─────────────────────────────────────────────────────────────
def slug(s):
    """Loose key for resource-name matching: lowercase alphanumerics only.

    Collapses case/space/punctuation so 'Common Client ID', 'CommonClientID',
    and 'common-client-id' all map to 'commonclientid'.
    """
    return re.sub(r'[^a-z0-9]+', '', (s or '').lower())


def load_db_aliases():
    """Map each known database to the set of loose-slug aliases that name it.

    Built from databases.json (id + display name). Used so the open-questions
    and tracker checks only react to real DB names, never arbitrary prose.
    Returns (alias_to_id: dict[str,str], id_to_label: dict[str,str]).
    """
    data = json.loads(DATABASES_JSON.read_text(encoding='utf-8'))
    alias_to_id, id_to_label = {}, {}
    for db in data.get('databases', []):
        db_id = db.get('id', '')
        label = db.get('database') or db_id
        id_to_label[db_id] = label
        for alias in (db_id, db.get('database'), db.get('title')):
            if alias:
                alias_to_id.setdefault(slug(alias), db_id)
    return alias_to_id, id_to_label


# ── check 1: CSS coverage ─────────────────────────────────────────────────────
def check_css_coverage():
    issues = []
    data = json.loads(DATABASES_JSON.read_text(encoding='utf-8'))
    css = INDEX_HTML.read_text(encoding='utf-8')

    statuses = sorted({d['status'] for d in data.get('databases', []) if d.get('status')})
    accesses = sorted({d['access'] for d in data.get('databases', []) if d.get('access')})

    # A class is "covered" if `.st-<value>` / `.ac-<value>` appears as a CSS
    # selector token. Match the class name followed by a non-identifier char so
    # `.st-partial` matches in `.st-partial, .ac-partial {` (comma-joined rules)
    # but `.st-pending` never satisfies a request for `.st-pend`.
    def covered(prefix, value):
        return re.search(r'\.' + re.escape(prefix + value) + r'(?![\w-])', css) is not None

    for s in statuses:
        if not covered('st-', s):
            issues.append(
                f"docs/databases/index.html missing CSS rule '.st-{s}' for status "
                f"'{s}' (present in databases.json) — badge would render unstyled")
    for a in accesses:
        if not covered('ac-', a):
            issues.append(
                f"docs/databases/index.html missing CSS rule '.ac-{a}' for access "
                f"'{a}' (present in databases.json) — badge would render unstyled")
    return issues


# ── check 2: open-questions active/parked integrity ───────────────────────────
def _split_sections(md):
    """Yield (heading_text, body_lines) for each bold '**Heading**' block."""
    lines = md.splitlines()
    head_re = re.compile(r'^\*\*(.+?)\*\*')
    sections, cur_head, cur_body = [], None, []
    for line in lines:
        m = head_re.match(line.strip())
        if m:
            if cur_head is not None:
                sections.append((cur_head, cur_body))
            cur_head, cur_body = m.group(1), []
        elif cur_head is not None:
            cur_body.append(line)
    if cur_head is not None:
        sections.append((cur_head, cur_body))
    return sections


def _bullet_heads(body_lines):
    """Return the 'head' of each '- ' bullet: text before the first clarifier.

    The clarifier is the first whitespace-led em-dash or an open-paren — i.e.
    the part that NAMES the item, before any parenthetical caveat. This is what
    keeps a parenthetical 'CommonClientID is in-progress ...' from counting as a
    parked item while 'EDW_Staging, Feedhub, Zuora, DataOne — ...' does.
    """
    heads = []
    for line in body_lines:
        stripped = line.strip()
        if not stripped.startswith('- '):
            continue
        text = stripped[2:]
        text = re.split(r'\s+—|\s+\(|:\s', text, maxsplit=1)[0]
        heads.append(text)
    return heads


def check_open_questions(alias_to_id, id_to_label):
    issues = []
    md = OPEN_QUESTIONS.read_text(encoding='utf-8')

    active_re = re.compile(r'awaiting|active|still open', re.I)
    parked_re = re.compile(r'parked', re.I)

    active_ids, parked_ids = set(), set()
    for head, body in _split_sections(md):
        if parked_re.search(head):
            target = parked_ids
        elif active_re.search(head):
            target = active_ids
        else:
            continue
        for bullet_head in _bullet_heads(body):
            key = slug(bullet_head)
            for alias, db_id in alias_to_id.items():
                # Substring on the loose slug: the bullet head 'commonclientidaccessschema'
                # contains the alias 'commonclientid'. Guard against trivially
                # short aliases that would over-match.
                if len(alias) >= 4 and alias in key:
                    target.add(db_id)

    for db_id in sorted(active_ids & parked_ids):
        label = id_to_label.get(db_id, db_id)
        issues.append(
            f"memory/open-questions.md lists '{label}' under BOTH an active "
            f"section and the parked section — it can only be one")
    return issues


# ── check 5: open-question status drift (section says open, text says closed) ─
def _valid_date(s):
    """True if s is a real calendar date (YYYY-MM-DD). Clock-independent."""
    try:
        from datetime import datetime
        datetime.strptime(s, '%Y-%m-%d')
        return True
    except ValueError:
        return False


def check_question_status_drift():
    """Flag bullets under an OPEN section that read as already resolved.

    Mirrors gen-brain.py's section->status mapping: a bullet under 'Active Asks'
    or 'Active Design Questions' becomes a status='open' OpenQuestion. If its
    prose carries a CLOSED/ANSWERED/DEPRIORITIZED marker, the brain reports it
    open while the text says otherwise — the exact drift fixed 2026-06-21. Move
    such a bullet to Historical/Closed (or drop the marker if truly still open).
    """
    issues = []
    lines = OPEN_QUESTIONS.read_text(encoding='utf-8').splitlines()
    in_open = False
    for ln in lines:
        if ln.startswith('## '):
            heading = ln[3:].strip()
            in_open = any(heading.startswith(k) for k in OPEN_SECTION_KEYS)
            continue
        if ln == '---':
            in_open = False
            continue
        if not in_open or not re.match(r'^- ', ln):
            continue
        item = re.sub(r'^- ', '', ln.strip())
        # 'still open' / 're-open(ed)' anywhere = a genuinely-open item; skip.
        if RESOLVED_NOT.search(item):
            continue
        # Find a definitive resolution marker. The 'partially answered' exclusion
        # is scoped to the specific ANSWERED occurrence (not the whole bullet), so
        # a long bullet that mentions 'partially answered' as history cannot mask
        # a leading CLOSED/ANSWERED marker (the Q16 gap, fixed 2026-06-21).
        m = None
        for mm in RESOLVED_MARKER.finditer(item):
            if mm.group(1).lower() == 'answered':
                preceding = item[max(0, mm.start(1) - 12):mm.start(1)].lower()
                if 'partial' in preceding:
                    continue
            m = mm
            break
        if not m:
            continue
        date = m.group(2)
        if date and not _valid_date(date):
            issues.append(
                f"memory/open-questions.md: '{item[:60]}...' has an invalid "
                f"closure date '{date}'")
        issues.append(
            f"memory/open-questions.md: bullet under an OPEN section reads as "
            f"resolved ('{m.group(1).upper()}') but stays open: "
            f"'{item[:70]}...' — move it to Historical/Closed or drop the marker")
    return issues


# ── check 6: action-item status drift (status open, context says closed) ──────
def check_action_item_status_drift():
    """Flag action-items.json items whose status is open/in-progress but whose
    context prose says they're closed/done/resolved — the field-vs-text drift
    that PR #138 reconciled by hand. Also validates closure dates are real.
    """
    issues = []
    data = json.loads(ACTION_ITEMS.read_text(encoding='utf-8'))
    for it in data.get('items', []):
        status = (it.get('status') or '').strip().lower()
        if status not in ('open', 'in-progress', 'in progress'):
            continue
        context = it.get('context') or ''
        if RESOLVED_NOT.search(context):
            # 're-scoped'/'partial' caveats are not closures; require a real one.
            pass
        m = RESOLVED_MARKER.search(context)
        if not m:
            continue
        # An action genuinely open can mention a past CLOSED sub-thread; only
        # flag when the marker is assertive about THIS item (leading clause or
        # immediately dated). Require an accompanying date to cut false positives.
        date = m.group(2)
        if not date:
            continue
        if not _valid_date(date):
            issues.append(
                f"analysis/action-items.json: '{(it.get('action') or '')[:50]}' "
                f"has an invalid closure date '{date}' in context")
        issues.append(
            f"analysis/action-items.json: '{(it.get('action') or '')[:55]}' is "
            f"status='{status}' but its context says "
            f"'{m.group(1).upper()} {date}' — reconcile status or wording")
    return issues


# ── check 3: access-tracker vs frontmatter (hard contradictions only) ─────────
def load_tracker_access():
    """Map loose-slug resource name -> tracker status, from access.json sections."""
    data = json.loads(ACCESS_JSON.read_text(encoding='utf-8'))
    out = {}
    for section in data.get('sections', []):
        for item in section.get('items', []):
            name = item.get('resource')
            status = item.get('status')
            if name and status:
                out[slug(name)] = (name, status)
    return out


def _tracker_match(tracker, fm_aliases):
    """Find a tracker entry whose slug loosely matches any frontmatter alias.

    Loose = one slug contains the other (so 'cim' frontmatter matches the
    tracker's 'CIM (Central Inventory Management)'). Longest alias first so the
    most specific name wins. Returns (resource_name, status) or None.
    """
    aliases = sorted({a for a in fm_aliases if len(a) >= 3}, key=len, reverse=True)
    for alias in aliases:
        for tslug, (name, status) in tracker.items():
            if alias in tslug or tslug in alias:
                return name, status
    return None


def check_tracker_vs_frontmatter():
    issues = []
    tracker = load_tracker_access()

    for md in sorted(DB_DIR.glob('*.md')):
        if md.name in FM_EXCLUDE:
            continue
        meta = parse_frontmatter(md.read_text(encoding='utf-8', errors='replace'))
        if not meta:
            continue
        fm_access = (meta.get('access') or '').strip().lower()
        if not fm_access:
            continue

        display = meta.get('database') or meta.get('name') or md.stem
        fm_aliases = {slug(x) for x in (md.stem, display, meta.get('name'),
                                        meta.get('database'), meta.get('title')) if x}
        match = _tracker_match(tracker, fm_aliases)
        if not match:
            continue
        resource, tstatus = match
        tstatus = tstatus.strip().lower()

        # Only a granted-vs-blocked disagreement is a real contradiction. na /
        # closed / pending / committed / partial live on a different axis
        # (lifecycle vs catalog state) and must NOT be flagged.
        hard = (tstatus in GRANT_VALUES and fm_access in DENY_VALUES) or \
               (tstatus in DENY_VALUES and fm_access in GRANT_VALUES)
        if hard:
            issues.append(
                f"{md.name}: access tracker says '{tstatus}' for '{resource}' but "
                f"frontmatter says '{fm_access}' — direct contradiction")
    return issues


# ── check 4: frontmatter schema ───────────────────────────────────────────────
def check_frontmatter_schema():
    issues = []
    for md in sorted(DB_DIR.glob('*.md')):
        if md.name in FM_EXCLUDE:
            continue
        meta = parse_frontmatter(md.read_text(encoding='utf-8', errors='replace'))
        if not meta:
            issues.append(f"{md.name}: no YAML frontmatter found")
            continue

        # database OR name satisfies the identity key.
        if not (meta.get('database') or meta.get('name')):
            issues.append(f"{md.name}: missing required key 'database' (or 'name')")
        for key in ('owner', 'access', 'status'):
            if not meta.get(key):
                issues.append(f"{md.name}: missing required key '{key}'")

        access = (meta.get('access') or '').strip().lower()
        if access and access not in ACCESS_ENUM:
            issues.append(
                f"{md.name}: access '{access}' not in "
                f"{{{', '.join(sorted(ACCESS_ENUM))}}}")

        status = norm_status(meta.get('status', '')).lower() if meta.get('status') else ''
        if status and status not in STATUS_ENUM:
            issues.append(
                f"{md.name}: status '{status}' not in "
                f"{{{', '.join(sorted(STATUS_ENUM))}}}")
    return issues


# ── check 7: field-priority count invariant (14 valuable-now / 13 later) ──────
def check_field_priority_invariant():
    """Canonical (memory/decisions.md, docs/cdp-field-source-matrix.md): Field
    Catalog v1 = 14 valuable-now / 13 interesting-later. Flag the recurring
    inverted '13 valuable-now / 14 later' miscount wherever it appears."""
    issues = []
    bad_now = re.compile(r'\b13\b[^.\n]{0,25}valuable-now', re.I)
    bad_later = re.compile(r'\b14\b[^.\n]{0,25}interesting-later', re.I)
    files = ['memory/decisions.md', 'docs/cdp-field-source-matrix.md',
             'analysis/action-items.json', 'docs/phase0-deliverables.json',
             'memory/open-questions.md']
    paths = [ROOT / f for f in files]
    wiki = ROOT / 'wiki'
    if wiki.exists():
        paths += sorted(wiki.glob('*.md'))
    for p in paths:
        if not p.exists():
            continue
        text = p.read_text(encoding='utf-8')
        for pat in (bad_now, bad_later):
            m = pat.search(text)
            if m:
                issues.append(
                    f"{p.relative_to(ROOT)}: field-priority count drift "
                    f"('{m.group(0).strip()[:40]}') — canonical is 14 valuable-now / 13 interesting-later")
    return issues


# ── check 8: RAID status drift (open/in-progress item reads as resolved) ──────
def check_raid_status_drift():
    """Flag app/raid.json items with status open/in-progress whose detail asserts
    resolution (RESOLVED/CLOSED/DONE/LOCKED/CONFIRMED/APPROVED + date) — e.g. I-2,
    whose six design items were all locked while the item stayed in-progress."""
    issues = []
    raid = ROOT / 'app' / 'raid.json'
    if not raid.exists():
        return issues
    marker = re.compile(
        r'\b(RESOLVED|CLOSED|DONE|LOCKED|CONFIRMED|APPROVED)\b[^.\n]{0,12}(\d{4}-\d{2}-\d{2})', re.I)
    data = json.loads(raid.read_text(encoding='utf-8'))
    items = data if isinstance(data, list) else data.get('items', [])
    for it in items:
        status = (it.get('status') or '').strip().lower()
        if status not in ('open', 'in-progress', 'in progress'):
            continue
        detail = (it.get('detail') or '') + ' ' + (it.get('title') or '')
        m = marker.search(detail)
        if m:
            issues.append(
                f"app/raid.json: '{(it.get('id') or it.get('title') or '')[:40]}' is "
                f"status='{status}' but its detail asserts '{m.group(1).upper()} {m.group(2)}' "
                f"— reconcile to resolved/decided or narrow the remaining scope")
    # cross-file: a RAID 'design question(s)' item still open while
    # open-questions.md reports no open design questions (the I-2 pattern, #1).
    oq = OPEN_QUESTIONS.read_text(encoding='utf-8') if OPEN_QUESTIONS.exists() else ''
    adq = re.search(r'(?ms)^## Active Design Questions\s*(.*?)^## ', oq)
    open_design_qs = bool(adq and re.search(r'(?m)^- ', adq.group(1)))
    if not open_design_qs:
        for it in items:
            status = (it.get('status') or '').strip().lower()
            if status not in ('open', 'in-progress', 'in progress'):
                continue
            blob = ((it.get('title') or '') + ' ' + (it.get('detail') or '')).lower()
            if 'design question' in blob:
                issues.append(
                    f"app/raid.json: '{(it.get('id') or it.get('title') or '')[:40]}' is "
                    f"status='{status}' and references design questions, but "
                    f"memory/open-questions.md reports none open — reconcile")
    return issues


# ── check 9: stale Phase-2 scope terms in the deliverables tracker ────────────
def check_phase2_scope_drift():
    """Phase 2 = activation + reporting parity + apps; audience builder / analytics
    dashboards / redaction-deletion / admin utilities ship in Phase 1. Flag a
    Phase-2 scope description (not a changelog note) that still lists a Phase-1
    item as Phase 2."""
    issues = []
    p = ROOT / 'docs' / 'phase0-deliverables.json'
    if not p.exists():
        return issues
    stale = re.compile(
        r'Phase 2[^.]{0,160}?(audience builder|redaction/deletion|admin utilit|analytics dashboard)', re.I)

    def walk(node, keypath=''):
        if isinstance(node, dict):
            for k, v in node.items():
                if k in ('note', 'changelog'):
                    continue  # historical record, not current scope
                if isinstance(v, str) and k in ('detail', 'summary') and stale.search(v):
                    issues.append(
                        f"docs/phase0-deliverables.json ({keypath}{k}): Phase-2 scope still lists a "
                        f"Phase-1 item (audience builder / analytics / redaction-deletion / admin utilities ship in Phase 1)")
                else:
                    walk(v, keypath + k + '.')
        elif isinstance(node, list):
            for x in node:
                walk(x, keypath)

    walk(json.loads(p.read_text(encoding='utf-8')))
    return issues


def check_decision_anchor_refs():
    """Every memory/decisions.md#d-NNN cited in a doc must resolve to a defined
    anchor. Existence-level guard for traceability links (the semantic 'wrong
    decision' case still needs human review, but a dangling anchor is a hard bug)."""
    issues = []
    anchors = set(re.findall(r'<a id="(d-\d+)">', DECISIONS_MD.read_text(encoding='utf-8')))
    for f in list(ROOT.rglob('*.md')) + list(ROOT.rglob('*.json')):
        rel = f.relative_to(ROOT).as_posix()
        if any(s in rel for s in REF_SCAN_EXCLUDE):
            continue
        for ln, line in enumerate(f.read_text(encoding='utf-8', errors='ignore').splitlines(), 1):
            for d in re.findall(r'decisions\.md#(d-\d+)', line):
                if d not in anchors:
                    issues.append(f"{rel}:{ln}: cites {d} but no such anchor in memory/decisions.md")
    return issues


def check_spec_id_refs():
    """Every full phase-N spec id cited in a traceability doc must exist in
    specs/manifest.json — catches stale ids (long-tail.* renames) and points-at-a-
    nonexistent-story typos. Leading-dot shorthands (`.foo`) are relative and skipped."""
    issues = []
    ids = {i['id'] for i in json.loads(SPEC_MANIFEST.read_text(encoding='utf-8'))['items']}
    for rel in TRACE_DOCS:
        p = ROOT / rel
        if not p.exists():
            continue
        for ln, line in enumerate(p.read_text(encoding='utf-8').splitlines(), 1):
            for tok in re.findall(r'`(phase-[0-9][a-z0-9.-]+)`', line):
                if tok.count('.') < 1:
                    continue  # bare phase root, not a story/feature id
                if tok not in ids:
                    issues.append(f"{rel}:{ln}: spec id `{tok}` not in specs/manifest.json (stale/renamed?)")
    return issues


def main():
    # Surface a clear error if a source file is missing, rather than a traceback.
    for required in (DATABASES_JSON, INDEX_HTML, OPEN_QUESTIONS, ACCESS_JSON,
                     ACTION_ITEMS):
        if not required.exists():
            print(f"FAIL: required file missing: {required.relative_to(ROOT)}")
            sys.exit(1)

    alias_to_id, id_to_label = load_db_aliases()

    issues = []
    issues += check_css_coverage()
    issues += check_open_questions(alias_to_id, id_to_label)
    issues += check_tracker_vs_frontmatter()
    issues += check_frontmatter_schema()
    issues += check_question_status_drift()
    issues += check_action_item_status_drift()
    issues += check_field_priority_invariant()
    issues += check_raid_status_drift()
    issues += check_phase2_scope_drift()
    issues += check_decision_anchor_refs()
    issues += check_spec_id_refs()

    if issues:
        fail(issues)
    print('OK: content consistency')


if __name__ == '__main__':
    main()
