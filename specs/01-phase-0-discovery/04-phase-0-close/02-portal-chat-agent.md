---
title: "Portal chat-agent bubble"
type: story
status: done
priority: medium
estimate: L
assignee: CONFLICT
labels: [portal, agent, phase-0]
date: "2026-06-12"
artifacts:
  - "Client agent brief | docs/client-agent-brief.md"
---

Committed at the 2026-06-12 sync: a lightweight chat-agent bubble on the portal so Dan/Mike can ask questions against the knowledge base directly through the UI (instead of code access). Reuses the existing web/browser agent. Target: days, not weeks.

**Why it matters:** lets the client interrogate the discovery material themselves — catch wrong directions and gaps early, per Mike's request to "see the process and ask questions."

**Shipped 2026-06-12.** Worker endpoint at `/api/chat` (claude-sonnet-4-6 — right-sized the same day from the initial Opus-4.8 commit; tool loop at ship: search_knowledge over a 95-doc index, read_doc against portal assets, navigate with a server-validated page whitelist); bubble injected into every page via HTMLRewriter. Index regenerates with `python3 scripts/gen-knowledge-pack.py`; deploy with `npx wrangler deploy`. Verified live against identity, reporting, and CCID questions. *Since evolved: the knowledge index has grown well past the ship-time 95 docs and a `search_graph` tool over the KG was added — see `worker.js` and `app/knowledge-pack.json` for current values.*
