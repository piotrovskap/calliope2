# DAS CDP Workspace Memory

Cross-repo decisions and context. Read the linked files for detail — this index is the entry point.

- [Objectives](objectives.md) — READ FIRST: the client's north-star objectives (Dan + Mike, 2026-06-12); every design and task decision should trace to one
- [Project Context](client.md) — Who's involved, what we're building, CONFLICT team with full names and emails
- [Tech Stack](tech-stack.md) — DAS current architecture, what's reliable vs. fragile, approved tools
- [ETL Repo Structure](etl-repo-structure.md) — Map of DAS's (removed) `etl/` submodule: SSIS, Juicebox Reporting, BlackBook, Mautic, PostgreSQL analytics (paths historical; authoritative catalog in docs/etl-data-inventory.md)
- [Data Sources](data-sources.md) — 14 categories, 50+ sources, ingestion methods, identity keys per source
- [Decisions](decisions.md) — Architecture and process decisions (portable OSS core, Azure-primary preferred; Auth0, object-store bronze, Django + DRF/Strawberry, Apache Superset reporting, Airflow ETL)
- [Sources & Access](sources.md) — GitHub, Google Drive, Confluence auth, KG location, artifact paths
- [Open Questions](open-questions.md) — open/answered log (Phase-0 design questions resolved; remainder deferred to Phase 1 onboarding)
- [Process Extensions](process.md) — CDP-specific rules that extend the standard primer (multi-tenancy, provenance, identity conflict)
- [Language Policy](feedback-language.md) — English for docs/artifacts/sheets; Spanish for #das-digital Slack messages
- [No Emojis](feedback-no-emojis.md) — No emojis in CONFLICT-authored content; words or typographic glyphs instead; DAS source material never edited for style
- [Spec System](project-spec-system.md) — Federated markdown specs in specs/; schema, folder conventions, GitHub/Jira export via gh + acli skills (no export code)
