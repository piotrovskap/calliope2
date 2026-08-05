---
name: das-cdp-objectives
description: The engagement's north-star objectives, in the client's own words (Dan Aston + Mike Paylor, 2026-06-12). Read before designing or building anything — every artifact should trace to one of these.
metadata:
  type: project
---

North-star objectives from the client, set 2026-06-12. These are the success criteria everything else serves. When a task does not trace to one of these, question the task.

## What the CDP must be

1. **The source of truth for the apps.** Lifecycle events, agentic events, and end-user capabilities all build ON the CDP. The legacy SSIS/CDXP stack retires once the CDP is reliable — every source that moves onto the CDP is another SSIS job that can be killed. (Dan, Mike)
2. **"Good for AI and good for regular application lifecycle events, or agentic events."** (Mike, verbatim.) Both consumption patterns are first-class: DAS's AI agents will draw from the CDP instead of DWRPT, and applications consume the same records and events.
3. **Capture raw, at the point of consumption.** The client does not trust CDXP/SSIS data manipulation. Ingest the original feeds flowing INTO the legacy systems — e.g. Acceptor receives a lead, publishes to the Event Bus, CDP captures the raw event — never the manipulated outputs. (Dan)

## The question the engagement must answer

4. **Is the golden record achievable from DAS's real data?** Mike's framing: "Is it possible to take all the data we have and make a golden record for myself — and what would that even look like?" Demonstrated against actual data ("all the people that could be Mike"), not asserted from schemas. The golden-record portal view is the validation artifact.
5. **Which record elements are super valuable vs interesting-but-not-useful-now?** The record is a progressive build, prioritized — not everything at once. (Mike)

## Standing design principles (CONFLICT, ratified by the direction above)

6. **Replace, don't improve.** No effort on improving, refactoring, or deeply documenting legacy systems (SSIS, CDXP, DWRPT internals, Juicebox). They are context, never foundation.
7. **First principles for identity and reporting.** DAS has zero cross-system identity resolution; Common Client ID is one candidate signal and the migration key, never the foundation. Reporting is designed fresh — the 14 CDXP-Live reports are acceptance criteria, not templates.
8. **Generic event intake + Airflow batch**, one validate→normalize→resolve pipeline. Bus-agnostic adapters (DAS's Azure Event Grid is the likely first, never a coupling). Sources graduate from batch to events without redesign.
9. **Orphan identifiers are first-class.** Identifiers with nothing to join to today (Facebook IDs from reviews) are stored, attributed, and resolvable later — never discarded. (Dan's edge case.)
10. **Consent/suppression is a first-class data category.** Unsubscribes, suppression lists, GLBA flags — authoritative before any activation use.

## Delivery commitments

- Phase 0 CDP document before July 4 (target end of June); drafts shared early for iteration.
- Identity strategy options (Alicia Salazar + Luis Hernandez) ~2026-06-19; war-room sessions feed the golden-record view.
- API documentation (Hiram Gonzalez, Byron Miranda, Julio Rojas, Oscar Morera): per-API business purpose, owning product, extracted-today vs available-later — partial answers land in docs/api-integration-catalog.md as confirmed; Dan is chasing the engineering walkthrough in parallel.

**How to apply:** Cite the objective number when making design trade-offs. If a proposed task improves or documents a legacy system beyond what CDP design needs, close it (objective 6). If a design anchors on CCID or replicates Juicebox, redirect it (objective 7).
