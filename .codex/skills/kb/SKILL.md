---
name: kb
description: Use when the user wants to query the compiled brain (app/brain.json / app/brain.db) with SQL or full-text search across databases, fields, decisions, sessions, action items, RAID, specs, docs, and the KG. For graph neighbor/path queries over the semantic KG, use /kg.
---

# /kb — Brain query (SQLite)

Mirror of `.claude/skills/kb/SKILL.md`. The brain is the compiled graph over every
structured source (`docs/knowledge-engine.md`): JSON at `app/brain.json` (generated
by `scripts/gen-brain.py`), SQLite at `app/brain.db` (derived/untracked).

- Build: `make brain-db`
- Query: `python3 /Users/ragelink/repos/das-tech/scripts/brain-sqlite.py query "<SQL>"`
  or `sqlite3 app/brain.db "<SQL>"`
- Schema: `node(id,kind,label,derived,durability,status,owner,source_path,json)`,
  `edge(id,src,dst,type,class,json)`, `node_fts(id,label,kind,headings)` (FTS5).

Examples:
```sql
SELECT id,kind FROM node_fts WHERE node_fts MATCH 'megatron';
SELECT n.label,e.dst FROM edge e JOIN node n ON n.id=e.src WHERE e.type='arose-in';
SELECT type,dst FROM edge WHERE src='db:megatron';
```

Read facts from their canonical owner (`docs/source-of-truth.md`); the brain only
relates data. For semantic traversal use `/kg`. D1 is specced but gated (see
`wrangler.toml`).
