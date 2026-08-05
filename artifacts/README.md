# DAS CDP — Artifacts

Source documents, working files, and Phase 0 deliverables for the DAS CDP engagement.

## Structure

```
artifacts/
└── phase-0/
    ├── kickoff/              ← Kickoff meeting materials
    │   ├── kickoff-agenda.md ← Official agenda + questions (2026-05-27)
    │   └── Kickoff - Agenda & Notes.md  ← Original Google Docs export
    ├── source-docs/          ← Source documents from DAS (original + processed)
    │   ├── das-cdp-mvp-spec-v4.md / .docx            ← DAS MVP Specification v4 (March 2026)
    │   ├── das-cdp-architecture-plan-v3.md / .docx   ← DAS Architecture Plan v3 (March 2026)
    │   ├── vss-spec-v2-microservices.md / .html      ← VSS Spec v2 — reference material
    │   └── vss-data-mapping.md / .xlsx               ← VSS Data Mapping — reference data
    └── deliverables/         ← Phase 0 deliverables (produced — see docs/deliverables/)
        ├── executive-summary.md
        ├── revised-cdp-architecture-plan.md
        └── das-cdp-roadmap/
            ├── cdp-scoping-document.md
            ├── privacy-by-design-framework.md
            ├── identity-resolution-strategy.md
            └── phase-1-and-2-plans.md
```

## Source Documents

| Document | Version | Type | Key Content |
|----------|---------|------|-------------|
| `das-cdp-mvp-spec-v4.md` | v4 | DAS internal spec | MVP field set (the v1 27, exact fields + DB locations), 4-stage build plan, MVP table schema (sketched 19), identity resolution flow, ingestion channels, frontend pages — DAS MVP figures, not our committed scope |
| `das-cdp-architecture-plan-v3.md` | v3 | DAS internal spec | Full system architecture including Phase 2 AI/ML layers, multi-cloud topology, security model |
| `vss-spec-v2-microservices.md` | v2 | DAS reference material | Vehicle Smart Score microservices spec — services, Kong gateway, Azure AKS/Event Grid, DB schema |
| `vss-data-mapping.md` | — | DAS reference data | VSS field → source-system mapping (Authenticom/CDK support, EDW_staging tables); 5 sheets |
| `das-cdp-phase0-proposal-final.md` | — | Conflict proposal | Final signed Phase 0 proposal — authoritative scope, deliverables, and team (`.md` + `.pdf`) |

**Note on source documents:** The DAS source docs (v4 MVP spec, v3 architecture plan, VSS spec/data) reflect DAS's own pre-Phase-0 assumptions and existing systems. These are inputs to Phase 0 discovery, not conclusions. The Revised CDP Architecture Plan (Phase 0 deliverable) will supersede the architecture inputs.

### Convention: originals + processed knowledge

Every document shared with us is kept in **two forms, side by side**:

- **Original** — the authoritative file as received (`.docx` / `.html` / `.xlsx` / `.pdf`).
- **Processed** — a `.md` conversion that is machine-readable and the form we pull from / cite.

The markdown is the working copy; the original is the source of truth. Each `.md` links to its original (root-relative path) and carries a header noting it is DAS-provided source material, not a Conflict deliverable. When a new doc arrives: drop the original in `source-docs/`, convert to markdown, link the two, and add a row above.

Source docs originate from the DAS shared Drive folder; pull additional files with the `/gdrive` skill (`gws drive files get --params '{"fileId":"…","alt":"media"}' -o <path>`).

## Phase 0 Deliverables

Produced during Phase 0. Five of the six exist in draft (links below); the Executive Summary is not yet started. See [[Phase-0]] for the full scope and deliverable descriptions.

| Deliverable | Status |
|-------------|--------|
| Executive Summary | Not started |
| Revised CDP Architecture Plan | Draft — [`phase-0/deliverables/das-cdp-revised-architecture-plan.md`](phase-0/deliverables/das-cdp-revised-architecture-plan.md) |
| CDP Scoping Document | Draft — [`../docs/deliverables/cdp-scoping-document.md`](../docs/deliverables/cdp-scoping-document.md) |
| Privacy-by-Design Framework | Draft — [`../docs/deliverables/privacy-by-design-framework.md`](../docs/deliverables/privacy-by-design-framework.md) |
| Identity Resolution Strategy & Graph Plan | Draft — [`../docs/deliverables/identity-resolution-strategy.md`](../docs/deliverables/identity-resolution-strategy.md) |
| Detailed Phase 1 & Phase 2 Plans | Draft — [`../docs/deliverables/detailed-phase-1-2-plans.md`](../docs/deliverables/detailed-phase-1-2-plans.md) |

## For AI Agents

All source docs are in markdown with frontmatter. Key facts for agent context:

- **Field Catalog v1 (the initial 27)** is defined in `das-cdp-mvp-spec-v4.md` §2 with exact field names + DB column mappings — DAS's MVP floor, not a closed set; the catalog grows past MVP (see `memory/decisions.md`)
- **DAS's v4 MVP schema** is sketched in `das-cdp-mvp-spec-v4.md` §6 (19 tables — a historical MVP figure, not our target; the normalized model is larger, final count set by the data-model design)
- **Identity resolution flow** (with fast-path, conflict queue, Phase 2 extension points) is in §7
- **4 ingestion channels** are defined in §5
- **Frontend pages** (routes, roles, descriptions) are in §8
- The **v3 architecture plan** is the full AI-enhanced target state — v4 spec is the deterministic MVP only
- **Phase 0 discovery** work lives in `../../analysis/` — transcripts, Planopticon outputs
- **Wiki** at `../../wiki/` is the living knowledge base — more current than these source docs
