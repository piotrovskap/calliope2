---
date: 2026-05-27
type: artifact
---

# DAS CDP

## Phase 0 Kickoff

## Agenda

1. **Introductions (5 min)**
   1. **Purpose:** align on scope, establish rhythm, surface blockers early.
   2. **Objective:** If anything is off, fix it now — not in week 3.
   3. **Duration:** ~60 min

2. **Scope Alignment (10 min)**
   - Walk through the 4 deliverables together — make sure everyone in the room is working from the same definition.
     1. **Executive Summary** — findings, proposed solution, recommended scope, implementation roadmap
     2. **Revised CDP Architecture Plan** — target-state data flow, services topology, deployment architecture, cloud alignment
     3. **DAS CDP Roadmap** — the main document, 4 components:
        - CDP Scoping Document (converts to backlog if proceeding)
        - Privacy-by-Design Framework for Dealer Data
        - Identity Resolution Strategy & Identity Graph Plan
        - Detailed Phase 1 & 2 Plans (structured for a fixed-scope SOW)

3. **DAS Context & Discovery (30–35 min)**
   - See questions below.

4. **Access, Logistics & Working Mode (10 min)**
   - How do we get eyes on data sources, schemas, and existing architecture docs? (Data model exports specifically — what format, where do they live?)
   - Who are the right contacts for: data/sources, infra/cloud, product priorities?
   - Preferred channel (Slack, Teams, email)?
   - Weekly check-in cadence — which day/time?
   - Single primary DAS point of contact for routing questions?

5. **Week 1 Plan & Next Steps (5 min)**
   - What Conflict is doing this week
   - What we need from DAS this week to not stall
   - Hard blockers to name immediately

## Introductory Questions

### Scope & Priorities

1. The proposal references 100+ data sources. How many of those does the DAS team have a clear picture of today — and how many are "we know they exist but haven't mapped them"? We want to calibrate how much of weeks 1–2 is cataloging vs. validating.
2. The 27 core data points in the v4 MVP spec — how locked is that scope? Are there points on the list that are aspirational vs. actually available today? And anything obviously missing that came up after v4?
3. What's the first concrete thing VSS needs from the CDP to function? Not the full platform — the minimum it needs to get value. That's probably our Week 1 anchor.
4. Is there a hard date driving this? A product launch, board commitment, contract milestone — anything that puts pressure on the 3–4 week Phase 0 window.

### Data & Identity

5. How does pulling data models from existing systems with internal tooling work. Can you walk us through what you have? Format, coverage, how current is it — and how do we get access?
6. How does DAS identify a customer across systems today? When the same person appears in your CRM, DMS, and a Meta ad — what's supposed to tie them together? What actually does?
7. Where do you expect identity to break down the most? Which sources are the messiest on customer identifiers, and which have reliable keys?
8. Are there any data sources that are off-limits right now — contractually, technically, or politically? Things we should know not to plan around for Phase 1.

### Privacy & Compliance

9. The Privacy-by-Design Framework is an explicit deliverable. Are there existing compliance requirements or constraints we should understand before we design the tenant isolation and PII model? CCPA, GLBA, DMS vendor agreements, anything DAS has already committed to?
10. Who owns the dealer data relationship at DAS — is there a legal/compliance stakeholder we should pull into the framework review before we finalize it?

### Infrastructure & Team

11. Walk us through the full cloud footprint — both Azure and AWS. For Azure: how mature is AKS, who manages it, what's actively running there? For AWS: what accounts exist, what's deployed, who owns it? We're going in expecting to recommend AWS-forward, but we want to map what's actually there before we design around it.
12. What's the DAS engineering team's composition on this project? Who do we pair with for data access, who owns infra decisions, who's the product owner making scope calls?
13. What does CI/CD look like today? GitHub Actions, Azure DevOps, something else, and how mature is it?

### Path & Stack

14. We're going into this expecting to recommend an AWS-forward architecture. Before we formalize that, we want to make sure you've seen the full lay of the land — Azure-native (Path A), AWS-native (Path B), and any hybrid considerations given your existing Azure footprint. Does that framing match where you're heads? Any strong opinions on the DAS side we should know before we start the infrastructure inventory?
15. On the AWS side — what accounts, org structure, and IAM setup exists today? Are we starting from scratch, or is there an existing AWS presence we're building into? And are there any procurement or security review requirements we need to thread for new AWS services?

### End State

16. At the end of Phase 0, what would make you confident enough to continue for Phase 1? What does "good enough to proceed" look like from your side — what has to be answered?
