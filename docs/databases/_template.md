---
source: <Database name> (<platform · owner>)
title: <Database Name> — Schema Documentation
type: db-schema
database: <db-id>
owner: <DB owner>      # who grants access (e.g. Ron Mulder)
researcher: <assignee>    # who does the analysis (Alicia / Luis)
access: pending          # pending | committed | granted
status: pending          # pending | in-progress | complete
dump: dumps/<db>.sql     # authoritative DDL dump (originals + processed)
erd: erd/<db>.svg        # ERD diagram
updated: YYYY-MM-DD
---

# <Database Name> — Schema Documentation

> _Status: pending — research to be done._ Describe only what the schema dump shows; flag inference; cite real object names. See [quality standards](../discovery-guide.md#quality-standards--references).

## Overview

What this DB is, what it powers, where it sits in the data flow. 1–3 sentences.

## Access

- **Owner:** <who grants access> · **Researcher:** <assignee> · **Status:** <access> · **Reach:** <host / role / tool>
- Cross-ref: [System Access Tracker](/analysis/artifacts/access-tracker/index.html)

## Schema dump

Authoritative DDL: `dumps/<db>.sql` — schema-only, no data. Regenerate, don't hand-edit. _Add the file, then link it here._

## Tables

| Table | ~Rows | Purpose | PK | CDP-relevant |
|---|---|---|---|---|
| _pending_ | | | | |

## Indexes

| Table | Index | Columns | Type | Notes |
|---|---|---|---|---|
| _pending_ | | | | |

## Views

| View | Purpose | Underlying tables | Notes |
|---|---|---|---|
| _pending_ | | | |

## ERD

<!-- add erd/<db>.svg + an editable source (.dbml / .drawio), then uncomment: -->
<!-- ![<db> ERD](erd/<db>.svg) -->

_pending — generation hints in [README](README.md#how-to-add-a-database-research-workflow)._

## CDP relevance

Which tables/columns feed the CDP; raw-vs-derived notes. Cross-ref [CDP Field Source Matrix](../cdp-field-source-matrix.md).

## Open questions

- _pending_
