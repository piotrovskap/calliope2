---
title: "Golden-record view (portal)"
type: story
status: done
priority: high
estimate: L
assignee: CONFLICT
labels: [identity, golden-record, portal, phase-0-architecture]
date: "2026-06-12"
artifacts:
  - "Golden record | /analysis/artifacts/golden-record/index.html"
---
**Closed 2026-06-18 (done):** bitemporal as-of golden-record view designed; working record built from real DAS data.

Committed to Mike Paylor at the 2026-06-12 sync — his #1 ask. A dedicated portal view showing the customer record as the design develops: the golden-record shape, which sources/events feed each element, and field prioritization (super-valuable vs interesting-but-not-now, supporting a progressive build).

**Why it matters:** this is how the client validates the identity design. Mike's framing: he doesn't know the full scope of what DAS knows about a person; the engagement must answer "is a golden record achievable from our real data?" — demonstrated, not asserted. Placeholders already exist in the app; fill as the identity strategy lands.

**Acceptance:** a DAS exec can open the view and see what the record contains and where each element comes from, with the source-attribution display states from the survivorship design rendered: the surviving (golden) value per field with its winning source, a low-confidence/secondary badge where a lower-trust source supplied the value, "Not yet available — [provider TBD]" for fields with no source yet (GAP fields), and what resolves vs remains an orphan identifier (e.g., unlinked Facebook IDs from reviews). Field prioritization (super-valuable vs interesting-but-not-now) is visible to support the progressive build.

**References:**
- Mike Paylor's #1 ask, 2026-06-12 sync: golden-record portal view (record shape + per-element source/event provenance + field prioritization for progressive build) — `memory/decisions.md`
- Survivorship + source-trust ladder LOCKED 2026-06-17 (Luis + Alicia): DMS → CRM → Email/Twilio → third-party enrichment, recency tie-break, per-element provenance retained alongside surviving value (drives the winning-source and low-confidence display states) — `memory/decisions.md`
- Confidence bands 2026-06-17 (Luis + Alicia): High/Medium/Low → auto-merge / curation / new-consumer+orphan (drives the orphan-vs-resolved display) — `memory/decisions.md`
- Orphan identifiers stored, never discarded 2026-06-17 (Dan's Facebook-ID case): `identity_link.link_type='orphan'`, no consumer_id until linkable — `memory/decisions.md`
- Field Catalog v1 prioritization LOCKED 2026-06-19 (Alicia): 14 valuable-now / 13 interesting-later (drives the prioritization display and GAP fields) — `memory/decisions.md`
- `specs/02-phase-1-architecture/01-data-model/05-survivorship-rules.md` — per-field winning source, fallback chain, and rule type; explicitly feeds this view
- `docs/cdp-field-source-matrix.md` — per-field source mapping + Phase (valuable-now / interesting-later) column and GAP fields
- `wiki/Identity-Resolution.md` — resolution + survivorship strategy; `wiki/Data-Model.md` — golden record / observation-layer shape; `wiki/Frontend.md` — the Golden Record portal surface
