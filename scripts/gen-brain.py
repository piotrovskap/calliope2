#!/usr/bin/env python3
"""Compile the brain: app/brain.json — one graph over every structured source.

Each adapter reads a canonical source and emits nodes + edges in the shared
envelope (docs/knowledge-engine.md). The brain is a generated projection: it
relocates and relates existing data and authors nothing. Column-level DB detail
stays in docs/databases/schema.json (referenced by Database nodes); the brain
graph is the connective layer across domains.

Invariant (enforced by scripts/check-brain.py): every node has a resolvable
source (or is flagged derived), and every node/edge traces to a source.

Run from the repo root:  python3 scripts/gen-brain.py
"""
import json
import re
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'app' / 'brain.json'

MD_LINK = re.compile(r'\[[^\]]*\]\(([^)]+?\.md)(?:#[^)]*)?\)')
HEADING = re.compile(r'^(#{1,4})\s+(.+?)\s*#*$')
FRONT_TITLE = re.compile(r'^---\s*\n.*?^title:\s*(.+?)\s*$.*?^---', re.S | re.M)


def load(rel):
    p = ROOT / rel
    return json.loads(p.read_text(encoding='utf-8')) if p.exists() else None


def node(nid, kind, label, path=None, locator=None, durability='point-in-time',
         data=None, status=None, owner=None, derived=False):
    n = {'id': nid, 'kind': kind, 'label': label,
         'source': ({'path': path, 'locator': locator} if path else None),
         'derived': derived, 'durability': durability}
    if status is not None:
        n['status'] = status
    if owner is not None:
        n['owner'] = owner
    if data:
        n['data'] = data
    return n


def edge(src, dst, etype, cls='structural', data=None):
    e = {'id': f'{src}\t{etype}\t{dst}', 'src': src, 'dst': dst, 'type': etype, 'class': cls}
    if data:
        e['data'] = data
    return e


# ---------------------------------------------------------------- adapters

def adapt_databases(nodes, edges, sess_keys):
    d = load('docs/databases.json') or {}
    schema = load('docs/databases/schema.json') or {'databases': []}
    sch_by_id = {db['id']: db for db in schema['databases']}
    for db in d.get('databases', []):
        sid = db['id']
        sc = sch_by_id.get(sid)
        nodes.append(node(
            f'db:{sid}', 'Database', db.get('database') or sid,
            path=f"docs/databases/{db.get('doc', sid + '.md')}", durability='durable-logic',
            status=db.get('status'), owner=db.get('owner') or None,
            data={'server': db.get('source'), 'access': db.get('access'),
                  'researcher': db.get('researcher'),
                  'schema_ref': sc['dump'] if sc else None,
                  'table_count': sc['table_count'] if sc else None}))


def adapt_fields(nodes, edges, db_ids):
    d = load('docs/cdp-field-catalog.json') or {}
    for f in d.get('fields', []):
        fid = f'field:{f["cdp_field"]}'
        cands = f.get('candidate_columns', [])
        nodes.append(node(
            fid, 'Field', f['cdp_field'], path='docs/cdp-field-source-matrix.md',
            durability='durable-logic', status=f.get('status'),
            data={'cdp_target': f.get('cdp_target'), 'providers': f.get('providers'),
                  'source_raw': f.get('source_raw'), 'resolved': f.get('resolved'),
                  'resolved_to': f.get('resolved_to'),
                  'resolution_note': f.get('resolution_note'),
                  'candidate_columns': cands}))
        # confirmed sourced-by edge only when the field resolves exactly (none yet)
        if f.get('resolved') and f.get('resolved_to'):
            db = f['resolved_to'].split('.')[0]
            edges.append(edge(fid, f'col:{f["resolved_to"]}', 'sourced-by',
                              data={'column': f['resolved_to']}))
            if db in db_ids:
                edges.append(edge(fid, f'db:{db}', 'sourced-from'))
        # candidate (name-match) sourced-from edges to the databases that hold a
        # same-named column — relationship exists; lineage not yet confirmed
        for db in f.get('candidate_dbs', []):
            if db in db_ids:
                cols = [c for c in cands if c.split('.', 1)[0] == db]
                edges.append(edge(fid, f'db:{db}', 'sourced-from',
                                  data={'match': 'name-candidate', 'columns': cols}))


def adapt_action_items(nodes, edges, dir_to_key):
    d = load('analysis/action-items.json') or {}
    for i, it in enumerate(d.get('items', []), 1):
        aid = f'ai:{i}'
        nodes.append(node(
            aid, 'ActionItem', (it.get('action') or '')[:80], path='analysis/action-items.json',
            status=it.get('status'), owner=it.get('assignee') or None,
            data={'priority': it.get('priority'), 'deadline': it.get('deadline'),
                  'session': it.get('session')}))
        # action-items record the session DIRECTORY; map it to the registry key
        key = dir_to_key.get(it.get('session') or '')
        if key:
            edges.append(edge(aid, f'sess:{key}', 'arose-in'))


def adapt_raid(nodes, edges):
    d = load('app/raid.json') or {}
    for it in d.get('items', []):
        nodes.append(node(
            f'risk:{it["id"]}', 'Risk', it.get('title') or it['id'], path='app/raid.json',
            status=it.get('status'), owner=it.get('owner') or None,
            data={'type': it.get('type'), 'severity': it.get('severity'),
                  'mitigation': it.get('mitigation')}))


def adapt_sessions(nodes, edges):
    d = load('analysis/sessions/catalog.json') or {}
    keys, dir_to_key = set(), {}
    for s in d.get('sessions', []):
        keys.add(s['key'])
        dir_to_key[Path(s['dir']).name] = s['key']
        nodes.append(node(
            f'sess:{s["key"]}', 'Session', s.get('title') or s['key'],
            path=s.get('dir'), durability='durable-logic',
            data={'date': s.get('date'), 'system': s.get('system'), 'phase': s.get('phase')}))
    return keys, dir_to_key


def adapt_specs(nodes, edges):
    d = load('specs/manifest.json') or {}
    ids = {it['id'] for it in d.get('items', [])}
    for it in d.get('items', []):
        kind = {'epic': 'Workstream', 'feature': 'Workstream', 'story': 'Story'}.get(
            it.get('type', ''), 'Story')
        sid = f'spec:{it["id"]}'
        nodes.append(node(
            sid, kind, it.get('title') or it['id'], path=it.get('path'),
            status=it.get('status'),
            data={'priority': it.get('priority'), 'spec_type': it.get('type'),
                  'parent_id': it.get('parent_id')}))
        pid = it.get('parent_id')
        if pid and pid in ids:
            edges.append(edge(sid, f'spec:{pid}', 'part-of'))


def adapt_deliverables(nodes, edges):
    d = load('docs/phase0-deliverables.json') or {}
    for dv in d.get('deliverables', []):
        # canonical source is the store; md (when a real .md file) is a link, else kept in data
        md = dv.get('md')
        md_path = f"docs/deliverables/{md}" if md and md.endswith('.md') and '?' not in md else None
        src = md_path if md_path and (ROOT / md_path).exists() else 'docs/phase0-deliverables.json'
        nodes.append(node(
            f'deliv:{dv["id"]}', 'Deliverable', dv.get('title') or dv['id'], path=src,
            status=dv.get('status'),
            data={'type': dv.get('type'), 'summary': dv.get('summary'), 'md_link': md}))
        # Phase nodes live verbatim in the roadmap deliverable's roadmap[] array
        for ph in dv.get('roadmap') or []:
            pid = f'phase:{ph["phase"].lower().replace(" ", "-")}'
            nodes.append(node(
                pid, 'Phase', ph['phase'], path='docs/phase0-deliverables.json',
                durability='point-in-time', status=ph.get('state'),
                data={'focus': ph.get('focus'), 'detail': ph.get('detail')}))


def _slugify(text, maxlen=50, maxwords=6):
    s = re.sub(r'[*`~]', '', text or '').strip().strip('"\'').lower()
    s = re.sub(r'[^a-z0-9]+', '-', s).strip('-')
    words = [w for w in s.split('-') if w][:maxwords]
    s = '-'.join(words)[:maxlen].strip('-')
    return s


DATE_RE = re.compile(r'\b20\d{2}-\d{2}-\d{2}\b')
BOLD_HEAD = re.compile(r'^\*\*(.+?):\*\*$')
ITALIC_HEAD = re.compile(r'^\*(.+?):\*$')


def adapt_decisions(nodes, edges, sess_keys):
    """One Decision node per top-level bullet in memory/decisions.md.

    Status/owner/date/why are only set when literally present in the bullet.
    decided-in edges fire only on an unambiguous (session-name + date) match
    against the catalog; supersedes only on a literal cross-reference to
    another generated decision slug (none in the current file).
    """
    path = 'memory/decisions.md'
    text = (ROOT / path).read_text(encoding='utf-8')
    lines = text.splitlines()
    # strip frontmatter
    body_start = 0
    if lines and lines[0].strip() == '---':
        for i in range(1, len(lines)):
            if lines[i].strip() == '---':
                body_start = i + 1
                break

    # name/date -> session-key crosswalk from the catalog
    cat = load('analysis/sessions/catalog.json') or {}
    date_to_keys, name_to_key = {}, {}
    for s in cat.get('sessions', []):
        date_to_keys.setdefault(s.get('date'), []).append(s['key'])
        sys_tok = (s.get('system') or '').lower()
        if 'ssis' in sys_tok:
            name_to_key['ssis'] = s['key']
        if 'juice' in sys_tok or 'reporting' in (s.get('title') or '').lower():
            name_to_key['juice'] = name_to_key['reporting'] = s['key']
        if 'kickoff' in (s.get('title') or '').lower():
            name_to_key['kickoff'] = s['key']

    file_date = None
    for ln in lines[body_start:body_start + 5]:
        m = DATE_RE.search(ln)
        if m:
            file_date = m.group(0)
            break

    seen_slugs = {}
    bullets = []  # (lead_phrase, statement_lines, section_header)
    section_header = None
    cur = None  # current bullet accumulator: dict

    def flush():
        if cur is not None:
            bullets.append(cur)

    for ln in lines[body_start:]:
        stripped = ln.strip()
        bh = BOLD_HEAD.match(stripped)
        ih = ITALIC_HEAD.match(stripped)
        if bh:
            flush(); cur = None
            section_header = bh.group(1)
            continue
        if ih:
            flush(); cur = None
            continue  # italic sub-label is body context, not a decision
        if re.match(r'^- ', ln):
            flush()
            cur = {'lines': [ln], 'section': section_header}
            continue
        if cur is not None:
            # continuation: indented sub-bullets, wrapped lines, numbered list items
            if ln.startswith(('  ', '\t')) or (stripped and not stripped.startswith('- ')
                                               and not re.match(r'^\d+\.\s', stripped)):
                cur['lines'].append(ln)
            elif re.match(r'^\d+\.\s', stripped):
                cur['lines'].append(ln)
            else:
                flush(); cur = None
    flush()

    for b in bullets:
        statement = '\n'.join(b['lines']).strip()
        body = re.sub(r'^- ', '', b['lines'][0]).strip()
        # leading phrase: up to first bold-colon, em-dash, ' - ', or sentence period
        lead = body
        mb = re.match(r'^\*\*(.+?):\*\*', body)
        if mb:
            lead = mb.group(1)
        else:
            for sep in (' — ', ' - ', ': ', '. '):
                if sep in lead:
                    lead = lead.split(sep, 1)[0]
                    break
        lead = re.sub(r'[*`~]', '', lead).strip().strip('"\'')
        slug = _slugify(lead) or _slugify(body)
        if not slug:
            continue
        n = seen_slugs.get(slug, 0) + 1
        seen_slugs[slug] = n
        if n > 1:
            slug = f'{slug}-{n}'
        label = lead[:80] if lead else body[:80]

        data = {'statement': statement}
        # date: first date in bullet, else section header date, else file date
        md = DATE_RE.search(statement)
        sect = b['section'] or ''
        sd = DATE_RE.search(sect)
        data['date'] = (md.group(0) if md else (sd.group(0) if sd else file_date))
        # why: only on an explicit rationale marker
        if re.search(r'Rationale|Rejected .*(because|for )|moves the problem', statement):
            data['why'] = statement
        # status: only on a literal token
        status = None
        if re.search(r'OPEN DECISION|Not decided|NOT yet locked', statement):
            status = 'open'
        elif 'AMENDED' in statement:
            status = 'amended'
        elif re.search(r'\bDECIDED\b', statement):
            status = 'decided'
        # owner: only on a literal attribution
        owner = None
        mo = re.search(r'Owners?:\s*([^.\n]+)', statement)
        if mo:
            owner = mo.group(1).strip().rstrip(')')

        nodes.append(node(
            f'dec:{slug}', 'Decision', label, path=path,
            locator=sect or None, durability='durable-logic',
            data={k: v for k, v in data.items() if v}, status=status, owner=owner))

        # decided-in: only when the SECTION HEADER names a cataloged session.
        # Conservative: require the header to (a) mention "session(s)" and carry a
        # session-name token, and (b) carry a date that matches a catalog session.
        # Prose token hits inside the statement are ignored (they describe topics,
        # not provenance). This lands edges only on e.g.
        # "Confirmed 2026-06-08 (SSIS + Juice sessions):".
        targets = set()
        hctx = sect.lower()
        if sd and sd.group(0) in date_to_keys and 'session' in hctx:
            for tok, key in name_to_key.items():
                if re.search(rf'\b{tok}\b', hctx):
                    targets.add(key)
        for key in sorted(targets):
            if key in sess_keys:
                edges.append(edge(f'dec:{slug}', f'sess:{key}', 'decided-in'))


def adapt_open_questions(nodes, edges):
    """One OpenQuestion node per bullet under a tracked ## section.

    Status derives purely from the section. gates edges fire only on an
    explicit reference to an existing deliverable node (none resolvable today).
    """
    path = 'memory/open-questions.md'
    text = (ROOT / path).read_text(encoding='utf-8')
    lines = text.splitlines()

    section_status = [
        ('## Active Asks', 'open', 'active-asks'),
        ('## Active Design Questions', 'open', 'active-design-questions'),
        ('## Parked', 'parked', 'parked-not-actionable'),
        ('## Answered / Discovered', 'answered', 'answered-discovered'),
        ('## Historical / Closed', 'answered', 'historical-closed'),
    ]

    cur_status = cur_section = cur_anchor = None
    cur_group = None
    seen_slugs = {}
    in_tracked = False
    for ln in lines:
        stripped = ln.strip()
        if ln.startswith('## '):
            cur_status = cur_section = cur_anchor = cur_group = None
            heading = ln[3:].strip()
            for prefix, st, anchor in section_status:
                key = prefix[3:].strip()  # e.g. "Active Asks", "Parked"
                if heading.startswith(key):
                    cur_status, cur_section, cur_anchor = st, heading, anchor
                    break
            in_tracked = cur_status is not None
            continue
        if ln == '---':
            in_tracked = False
            continue
        if not in_tracked:
            continue
        bh = re.match(r'^\*\*(.+?):?\*\*$', stripped)
        if bh:
            cur_group = bh.group(1).rstrip(':')
            continue
        if not re.match(r'^- ', ln):
            continue
        item = re.sub(r'^- ', '', stripped).strip()
        if not item:
            continue

        # id: leading Q<n>:, else (Q<n>) parenthetical, else slug of lead phrase
        mq = re.match(r'^Q(\d+):', item)
        mqp = re.search(r'\(Q(\d+)\)', item)
        if mq:
            qid = f'q:Q{mq.group(1)}'
        elif mqp:
            qid = f'q:Q{mqp.group(1)}'
        else:
            lead = item
            for sep in (' — ', ' - ', ': ', '. '):
                if sep in lead:
                    lead = lead.split(sep, 1)[0]
                    break
            slug = _slugify(lead, maxlen=50, maxwords=8) or _slugify(item)
            n = seen_slugs.get(slug, 0) + 1
            seen_slugs[slug] = n
            qid = f'q:{slug}' if n == 1 else f'q:{slug}-{n}'

        label = re.sub(r'[*`]', '', item)[:80]
        data = {'question': item, 'section': cur_section, 'group': cur_group}
        priority = 'next session' if (cur_group or '').lower().startswith('priority for next') else None
        if priority:
            data['priority'] = priority
        # owner: only on unambiguous (Name) parenthetical or "from <Name>"
        owner = None
        mo = re.search(r'from (Rick|Ron Mulder|Ron)\b', item) or re.search(r'\((Ron Mulder)\)', item)
        if mo:
            owner = mo.group(1)
        if owner:
            data['owner'] = owner
        # answered date from an **Answered <date>:** group, or resolved/ANSWERED verb
        answered = asked = None
        mg = re.search(r'Answered\s+(20\d{2}-\d{2}-\d{2}(?:/\d{2})?)', cur_group or '')
        if mg:
            answered = mg.group(1)
        ma = re.search(r'(?:ANSWERED|resolved|Answered)[^\n]*?(20\d{2}-\d{2}-\d{2})', item)
        if ma and not answered:
            answered = ma.group(1)
        mr = re.search(r'(?:relayed|committed)\s+(20\d{2}-\d{2}-\d{2})', item)
        if mr:
            asked = mr.group(1)
        if asked:
            data['asked'] = asked
        if answered:
            data['answered'] = answered

        nodes.append(node(
            qid, 'OpenQuestion', label, path=path, locator=cur_anchor,
            durability='point-in-time', status=cur_status, owner=owner,
            data={k: v for k, v in data.items() if v}))
        # gates edges: only to an existing deliverable node, referenced verbatim.
        # No bullet names a deliverable by id; component names aren't nodes. None today.


def adapt_golden_record(nodes, edges, field_labels):
    path = 'analysis/artifacts/golden-record/record.json'
    d = load(path) or {}
    model = d.get('model', {})
    # Core/adjacent entities of the golden-record model.
    ent_ids = set()
    for e in model.get('entities', []):
        ent_ids.add(e['id'])
        nodes.append(node(
            f"gre:{e['id']}", 'GoldenEntity', e.get('name') or e['id'], path=path,
            locator='model.entities', status=e.get('role'),
            data={'role': e.get('role'), 'purpose': e.get('purpose'), 'key': e.get('key'),
                  'is_temporal': e.get('is_temporal'), 'attribute_storage': e.get('attribute_storage')}))
    # Typed relationships between entities.
    for r in model.get('relationships', []):
        if r.get('from') in ent_ids and r.get('to') in ent_ids:
            edges.append(edge(
                f"gre:{r['from']}", f"gre:{r['to']}", r.get('kind') or 'relates-to', cls='semantic',
                data={'cardinality': r.get('cardinality'), 'temporal': r.get('temporal')}))
    # The 100+-source registry.
    src_ids = set()
    for s in d.get('source_registry', []):
        src_ids.add(s['id'])
        nodes.append(node(
            f"grs:{s['id']}", 'GoldenSource', s.get('name') or s['id'], path=path,
            locator='source_registry', status=s.get('access_status'),
            data={'category': s.get('category'), 'type': s.get('type'),
                  'identity_signals': s.get('identity_signals'), 'contributes': s.get('contributes')}))
    # Field dictionary, attached to its entity and sources.
    for sec in d.get('sections', []):
        label = sec.get('label')
        for f in sec.get('fields', []):
            slug = _slugify(f['name'], maxlen=60, maxwords=10)
            fid = f'grf:{slug}'
            nodes.append(node(
                fid, 'GoldenField', f['name'], path=path,
                locator=label, durability='point-in-time', status=f.get('status'),
                data={'tier': f.get('tier'), 'sources': f.get('sources'),
                      'identity_role': f.get('identity_role'),
                      'note': f.get('note') or None, 'section': label}))
            # maps-to an existing Field only on an exact name match (none today)
            if f['name'] in field_labels:
                edges.append(edge(fid, f'field:{f["name"]}', 'maps-to', cls='semantic'))
            if f.get('entity_id') in ent_ids:
                edges.append(edge(fid, f"gre:{f['entity_id']}", 'attaches-to', cls='semantic'))
            for sm in f.get('source_mappings', []):
                if sm.get('source_id') in src_ids:
                    edges.append(edge(fid, f"grs:{sm['source_id']}", 'sourced-from', cls='semantic'))


def adapt_ssis(nodes, edges, dir_to_key):
    path = 'analysis/artifacts/ssis-job-catalog-v2.json'
    d = load(path) or {}
    if not d:
        return
    cid = f'cat:{d["id"]}'
    nodes.append(node(
        cid, 'Catalog', d.get('title') or d['id'], path=path,
        durability='point-in-time',
        data={'description': d.get('description'), 'type': d.get('type'),
              'icon': d.get('icon'), 'href': d.get('href'),
              'supersedes': d.get('supersedes'),
              'source_sessions': d.get('source_sessions')}))
    if d.get('supersedes'):
        edges.append(edge(cid, f'cat:{d["supersedes"]}', 'supersedes'))
    for ss in d.get('source_sessions', []) or []:
        key = dir_to_key.get(ss)
        if key:
            edges.append(edge(cid, f'sess:{key}', 'derived-from'))


def adapt_timeline(nodes, edges, deliv_ids):
    path = 'analysis/artifacts/engagement-timeline/timeline.json'
    d = load(path) or {}
    if not d:
        return
    groups = {g['id']: g for g in d.get('groups', [])}
    phase_ids = set()
    for p in d.get('phases', []):
        pid = f'phase:{p["id"]}'
        phase_ids.add(p['id'])
        g = groups.get(p['id'], {})
        nodes.append(node(
            pid, 'Phase', p.get('label') or p['id'], path=path,
            durability='durable-logic',
            data={'sub': p.get('sub'), 'active': p.get('active'),
                  'badge': g.get('badge'), 'badgeClass': g.get('badgeClass')}))
    # phase-0-deliverables is a group, not a phase — mint it so step edges resolve
    if 'phase-0-deliverables' in groups and 'phase-0-deliverables' not in phase_ids:
        g = groups['phase-0-deliverables']
        nodes.append(node(
            'phase:phase-0-deliverables', 'Phase', g.get('label'), path=path,
            durability='durable-logic',
            data={'badge': g.get('badge'), 'badgeClass': g.get('badgeClass')}))
        phase_ids.add('phase-0-deliverables')

    for s in d.get('steps', []):
        sid = f'step:{s["id"]}'
        data = {'desc': s.get('desc'), 'date': s.get('date'), 'tags': s.get('tags'),
                'output': s.get('output'), 'produces': s.get('produces'),
                'group': s.get('group'), 'deliverable': s.get('deliverable')}
        label = s.get('title') or s.get('deliverable') or s['id']
        nodes.append(node(
            sid, 'Step', label, path=path, durability='point-in-time',
            status=s.get('status'),
            data={k: v for k, v in data.items() if v}))
        grp = s.get('group')
        if grp in phase_ids:
            edges.append(edge(sid, f'phase:{grp}', 'in-phase'))
        dv = s.get('deliverable')
        if dv and f'deliv:{dv}' in deliv_ids:
            edges.append(edge(sid, f'deliv:{dv}', 'references'))


ACCESS_DB_MAP = {
    'CIM (Central Inventory Management)': 'cim',
    'ML Production Database (MediaLogix)': 'ml-production',
    'RL Production Database (Response Logic OLTP)': 'rl-production',
    'DWRPT (Data Warehouse)': 'dwrpt',
    'EDW_Staging': 'edw-staging',
    'Common Client ID tables': 'common-client-id',
}


def adapt_access(nodes, edges, db_ids, dir_to_key):
    path = 'analysis/artifacts/access-tracker/access.json'
    d = load(path) or {}
    seen = {}
    for sec in d.get('sections', []):
        label = sec.get('label')
        for it in sec.get('items', []):
            slug = _slugify(it['resource'], maxlen=50, maxwords=8)
            n = seen.get(slug, 0) + 1
            seen[slug] = n
            aid = f'acc:{slug}' if n == 1 else f'acc:{slug}-{n}'
            nodes.append(node(
                aid, 'AccessRequest', it['resource'], path=path, locator=label,
                durability='point-in-time', status=it.get('status'),
                owner=it.get('owner') or None,
                data={'resource': it.get('resource'), 'note': it.get('note'),
                      'type': it.get('type'), 'requestedBy': it.get('requestedBy'),
                      'detail': it.get('detail'), 'section': label}))
            dbid = ACCESS_DB_MAP.get(it['resource'])
            if dbid and dbid in db_ids:
                edges.append(edge(aid, f'db:{dbid}', 'grants-access-to'))
            key = dir_to_key.get(it.get('session') or '')
            if key:
                edges.append(edge(aid, f'sess:{key}', 'arose-in'))


def adapt_kg(nodes, edges, sess_keys):
    d = load('app/knowledge_graph.json') or {}
    type_kind = {'concept': 'Concept', 'person': 'Person', 'organization': 'Organization',
                 'technology': 'Technology', 'time': 'Time'}
    ids = set()
    for n in d.get('nodes', []):
        nid = f'kgn:{n["id"]}'
        ids.add(nid)
        nodes.append(node(
            nid, type_kind.get(n.get('type'), 'Concept'), n['name'],
            path='app/knowledge_graph.json', derived=True,
            data={'kg_type': n.get('type'), 'sessions': n.get('sessions', [])}))
        for sk in n.get('sessions', []):
            if sk in sess_keys:
                edges.append(edge(nid, f'sess:{sk}', 'mentions', cls='semantic'))
    for e in d.get('edges', []):
        s, t = f'kgn:{e["source"]}', f'kgn:{e["target"]}'
        if s in ids and t in ids:
            edges.append(edge(s, t, e.get('type', 'related'), cls='semantic'))


DOC_GLOBS = ['*.md', 'docs/**/*.md', 'memory/*.md', 'specs/**/*.md',
             'analysis/*.md', 'analysis/artifacts/**/*.md', 'wiki/*.md']
# Path components to exclude at any depth. Matching any path component (not just a
# prefix) skips nested artifact directories — e.g. a Python virtualenv at
# docs/etl/usage-analysis/.venv, or node_modules anywhere in the tree — that
# would otherwise pollute brain.json with package-shipped LICENSE.md files.
DOC_SKIP = ('_site', 'node_modules', '.claude', '.codex', '.venv', '_internal')


def adapt_docs(nodes, edges):
    catalog = {e['page']: e for e in (load('docs/wiki-research-catalog.json') or [])}
    seen = {}
    for g in DOC_GLOBS:
        for p in ROOT.glob(g):
            rel = str(p.relative_to(ROOT))
            if rel in seen or any(s in rel.split('/') for s in DOC_SKIP):
                continue
            seen[rel] = p
    doc_ids = {f'doc:{rel}' for rel in seen}
    for rel, p in sorted(seen.items()):
        text = p.read_text(encoding='utf-8', errors='replace')
        m = FRONT_TITLE.search(text)
        title = m.group(1).strip().strip('"\'') if m else None
        headings = [h.group(2) for h in (HEADING.match(ln) for ln in text.splitlines()) if h]
        if not title:
            title = headings[0] if headings else Path(rel).stem
        is_mem = rel.startswith('memory/')
        data = {'headings': headings[:40]}
        c = catalog.get(Path(rel).name) if rel.startswith('wiki/') else None
        if c:  # wiki research page — attach catalogue tags (source: docs/wiki-research-catalog.json)
            data.update(category=c['category'], tags=c['tags'],
                        status=c['status'], cdp_relevance=c['cdp_relevance'])
        nodes.append(node(
            f'doc:{rel}', 'Memory' if is_mem else 'Document', title, path=rel,
            durability='durable-logic' if is_mem else 'point-in-time',
            data=data))
        # references edges to other indexed docs
        for link in MD_LINK.findall(text):
            tgt = (p.parent / link).resolve()
            try:
                trel = str(tgt.relative_to(ROOT))
            except ValueError:
                continue
            if f'doc:{trel}' in doc_ids and trel != rel:
                edges.append(edge(f'doc:{rel}', f'doc:{trel}', 'references'))


def adapt_relationships(nodes, edges):
    """Declared cross-type logic edges (maps-to / gates / supersedes / relates).

    These are not derivable from the structured sources; they are DECLARED in
    analysis/kg-relationships.json (domain-confirmed, never inferred). main()
    drops any edge whose endpoint is not a real node.
    """
    d = load('analysis/kg-relationships.json') or {}
    for e in d.get('edges', []):
        edges.append(edge(e['src'], e['dst'], e.get('type', 'relates'),
                          data={'note': e.get('note'), 'declared_in': 'analysis/kg-relationships.json'}))


def main():
    nodes, edges = [], []
    sess_keys, dir_to_key = adapt_sessions(nodes, edges)
    adapt_databases(nodes, edges, sess_keys)
    db_ids = {n['id'].split(':', 1)[1] for n in nodes if n['kind'] == 'Database'}
    adapt_fields(nodes, edges, db_ids)
    adapt_action_items(nodes, edges, dir_to_key)
    adapt_raid(nodes, edges)
    adapt_specs(nodes, edges)
    adapt_deliverables(nodes, edges)
    deliv_ids = {n['id'] for n in nodes if n['kind'] == 'Deliverable'}
    field_labels = {n['label'] for n in nodes if n['kind'] == 'Field'}
    adapt_decisions(nodes, edges, sess_keys)
    adapt_open_questions(nodes, edges)
    adapt_golden_record(nodes, edges, field_labels)
    adapt_ssis(nodes, edges, dir_to_key)
    adapt_timeline(nodes, edges, deliv_ids)
    adapt_access(nodes, edges, db_ids, dir_to_key)
    adapt_kg(nodes, edges, sess_keys)
    adapt_docs(nodes, edges)
    adapt_relationships(nodes, edges)

    # dedup nodes by id (first wins), drop edges with a missing endpoint
    by_id = {}
    for n in nodes:
        by_id.setdefault(n['id'], n)
    node_ids = set(by_id)
    seen_edges, final_edges = set(), []
    for e in edges:
        if e['src'] in node_ids and e['dst'] in node_ids and e['id'] not in seen_edges:
            seen_edges.add(e['id'])
            final_edges.append(e)
    final_nodes = sorted(by_id.values(), key=lambda n: (n['kind'], n['id']))
    final_edges.sort(key=lambda e: (e['type'], e['src'], e['dst']))

    counts = {}
    for n in final_nodes:
        counts[n['kind']] = counts.get(n['kind'], 0) + 1

    prev = load('app/brain.json') or {}
    generated = date.today().isoformat()
    if (prev.get('nodes'), prev.get('edges')) == (final_nodes, final_edges):
        generated = prev.get('meta', {}).get('generated_at', generated)

    out = {
        'meta': {
            'version': 1,
            'generated_at': generated,
            'generator': 'scripts/gen-brain.py',
            'counts': {'nodes': len(final_nodes), 'edges': len(final_edges), 'by_kind': counts},
        },
        'nodes': final_nodes,
        'edges': final_edges,
    }
    OUT.write_text(json.dumps(out, indent=2, ensure_ascii=False) + '\n', encoding='utf-8')
    print(f'Wrote {OUT.relative_to(ROOT)}: {len(final_nodes)} nodes, {len(final_edges)} edges')
    for k in sorted(counts):
        print(f'  {k:<14} {counts[k]}')


if __name__ == '__main__':
    main()
