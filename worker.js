// DAS CDP portal worker — serves the repo as static assets, injects the chat
// bubble into HTML pages, and exposes the knowledge-base chat agent at
// POST /api/chat. Auth is handled upstream by Cloudflare Access — configured in
// the Cloudflare dashboard (Zero Trust -> Access), out-of-repo; confirmed in
// place 2026-06-21. This Worker performs no auth of its own and assumes every
// request has already been authenticated by Access. See wrangler.toml.

import Anthropic from "@anthropic-ai/sdk";

const MODEL = "claude-sonnet-4-6";
const MAX_AGENT_TURNS = 8;
const MAX_DOC_CHARS = 120000; // ~30k tokens per doc
const TOOL_CHAR_BUDGET = 450000; // ~115k tokens of tool output total per request —
// keeps the running tool context well under the model window so a multi-read loop
// can't overflow and turn into a 500 that breaks the chat bubble.
const ALLOWED_NAV_URLS = new Set([
  "/",
  "/specs/",
  "/tracker/",
  "/docs/",
  "/app/",
  "/analysis/",
  "/analysis/artifacts/open-questions/",
  "/analysis/artifacts/access-tracker/",
  "/analysis/artifacts/golden-record/",
  "/analysis/artifacts/identity-strategies/",
  "/analysis/artifacts/engagement-timeline/",
  "/analysis/artifacts/decisions-tracker/",
  "/analysis/artifacts/action-items/",
  "/analysis/artifacts/ssis-job-catalog-v2/",
  "/analysis/artifacts/dwrpt-view-inventory/",
  "/analysis/artifacts/infrastructure-architecture/",
  "/analysis/artifacts/reporting-data-flow/",
  "/analysis/artifacts/api-integration-catalog/",
]);
const SUPPORTED_DOC_EXT = /\.(md|json|txt|py|js|toml|html|css)$/;

const SYSTEM = `You are the DAS CDP portal assistant, embedded in the CONFLICT engagement portal at das.conflict.media. You answer questions about the DAS Customer Data Platform engagement using the portal's knowledge base: project memory (decisions, open questions, data sources), wiki (architecture, ingestion channels, tech stack), docs (ETL inventory, field-source matrix, database schemas), specs (the project plan), live JSON trackers, portal assets, the project knowledge graph (1,300+ entities and relationships extracted from discovery sessions), and the compiled project brain (2,600+ structured project records — decisions, open questions, action items, risks, stories, deliverables, the golden record, the database/field catalog, access requests — each with provenance and typed relationships).

Ground every answer in what you have read this conversation — use search_knowledge to find documents, read_doc to read them, search_graph to look up discovery-session entities (people, systems, data sources) and how they relate, and search_brain to locate a specific structured project record (a decision, story, risk, golden-record field, database, access request) and trace how it connects. search_brain is broader than search_graph and provenance-tracked — prefer it for project records and their relationships, and search_graph for who-discussed-what across the discovery sessions; documents are the authority for details and status. If the knowledge base does not cover something, say so plainly; never invent project facts. Quote decisions and statuses as recorded, with dates where they matter. Every document you read with read_doc is automatically listed as a clickable source under your answer — so read the documents you rely on, and in deep/academic modes attribute claims inline by document name and date (plain text).

When a portal page would help the user, call navigate to offer it. Use ONLY these URLs with navigate: / (command center), /specs/ (project plan), /tracker/ (tracker), /docs/ (docs hub), /app/ (knowledge graph viewer), /analysis/ (sessions and artifacts), or /analysis/artifacts/<id>/ where <id> is one of: open-questions, access-tracker, golden-record, identity-strategies, engagement-timeline, decisions-tracker, action-items, ssis-job-catalog-v2, dwrpt-view-inventory, infrastructure-architecture, reporting-data-flow, api-integration-catalog. Never navigate to .md or .json file paths. At most two navigation targets per reply.

Turn discipline: only the text in your FINAL message (after all tool calls are done) is shown to the user — text written alongside tool calls is discarded. So: search and read first, call navigate if useful, and then write the complete answer in ONE final message — never split an answer across multiple messages or turns. The final message must be a self-contained prose answer to the question. Do not narrate what you are about to do.

Length: governed by the answer-mode instruction at the end of this system prompt. The mode is a user-chosen UI setting and is AUTHORITATIVE — it overrides any length implied by the question's phrasing.

Style: simple markdown is rendered — use ## subheadings, **bold**, - bullet lists, and --- dividers where they aid scanning; prose paragraphs otherwise. NEVER write markdown link syntax [text](url), raw URLs, or file paths as links — page links are created exclusively by the navigate tool and rendered as chips. No emojis. Be direct and token-efficient — maximum information per sentence, no filler. Audience is the DAS and CONFLICT project team; they know the project context.`;

const TOOLS = [
  {
    name: "search_knowledge",
    description:
      "Search the knowledge-base index (95+ documents: memory, wiki, docs, specs, live trackers). Returns matching documents with path, title, and summary. Call this first for any project question, then read_doc the best matches.",
    input_schema: {
      type: "object",
      properties: {
        query: {
          type: "string",
          description: "Keywords to search for, e.g. 'identity resolution CCID' or 'event bus ingestion'",
        },
      },
      required: ["query"],
    },
  },
  {
    name: "read_doc",
    description:
      "Read a file from the knowledge base by its path (as returned by search_knowledge). Returns the full text (truncated if very large). Markdown, JSON, text, and code files (.py/.js/.html/.toml) supported.",
    input_schema: {
      type: "object",
      properties: {
        path: {
          type: "string",
          description: "Repo-relative path, e.g. 'memory/decisions.md' or 'specs/manifest.json'",
        },
      },
      required: ["path"],
    },
  },
  {
    name: "search_graph",
    description:
      "Search the project knowledge graph (entities: people, systems, databases, data sources, decisions, concepts — with typed relationships between them). Returns matching entities and all their relationships with neighbor names. Use for who/what/how-related questions, e.g. 'Ron Mulder', 'DWRPT', 'Acceptor'.",
    input_schema: {
      type: "object",
      properties: {
        query: {
          type: "string",
          description: "Entity name or keyword, e.g. 'Common Client ID' or 'Event Hubs'",
        },
      },
      required: ["query"],
    },
  },
  {
    name: "search_brain",
    description:
      "Search the compiled project brain: every structured project record as a node with provenance and typed relationships — decisions, open questions, action items, risks (RAID), user stories, deliverables, phases/workstreams, the golden-record entities/fields/sources, the database and field catalog, access requests, and sessions (2,600+ nodes). Returns matching records with their kind, status, source file, and how they connect. Broader than search_graph and provenance-tracked; use it to locate a specific project record and trace its relationships, then read_doc the source file for full detail.",
    input_schema: {
      type: "object",
      properties: {
        query: {
          type: "string",
          description: "Record name or keyword, e.g. 'identity resolution', 'consumer_email field', or 'RLS decision'",
        },
      },
      required: ["query"],
    },
  },
  {
    name: "navigate",
    description:
      "Offer the user a portal page as a clickable navigation chip in the chat UI. Use for pages that answer or illustrate their question. The user decides whether to click.",
    input_schema: {
      type: "object",
      properties: {
        url: {
          type: "string",
          description: "Portal-relative URL, e.g. '/analysis/artifacts/open-questions/' or '/specs/'",
        },
        label: { type: "string", description: "Short chip label, e.g. 'Open Questions'" },
      },
      required: ["url", "label"],
    },
  },
];

let packCache = null;

async function loadPack(env) {
  if (!packCache) {
    try {
      const resp = await env.ASSETS.fetch("https://portal/app/knowledge-pack.json");
      packCache = resp.ok ? (await resp.json()).items : [];
    } catch (err) {
      // A 200 with malformed JSON (or a fetch hiccup) must not 500 the whole chat —
      // fall back to an empty pack so search just returns no matches.
      console.error(`loadPack failed: ${err?.message || err}`);
      packCache = [];
    }
  }
  return packCache;
}

function searchKnowledge(pack, query) {
  const terms = query.toLowerCase().split(/[^a-z0-9]+/).filter((t) => t.length > 1);
  const scored = pack
    .map((item) => {
      const hay = `${item.path} ${item.title} ${item.summary}`.toLowerCase();
      let score = 0;
      for (const t of terms) {
        if (hay.includes(t)) score += 1;
        if (item.title.toLowerCase().includes(t)) score += 2;
      }
      return { item, score };
    })
    .filter((s) => s.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 12);
  if (!scored.length) return "No matches. Try different keywords.";
  return scored
    .map(({ item }) => `${item.path}\n  ${item.title} — ${item.summary}`)
    .join("\n");
}

let graphCache = null;

async function loadGraph(env) {
  if (!graphCache) {
    try {
      const resp = await env.ASSETS.fetch("https://portal/app/knowledge_graph.json");
      graphCache = resp.ok ? await resp.json() : { nodes: [], edges: [] };
    } catch (err) {
      console.error(`loadGraph failed: ${err?.message || err}`);
      graphCache = { nodes: [], edges: [] };
    }
  }
  return graphCache;
}

function searchGraph(graph, query) {
  const q = query.toLowerCase();
  const terms = q.split(/[^a-z0-9]+/).filter((t) => t.length > 1);
  const hits = graph.nodes
    .map((n) => {
      const name = (n.name || n.id).toLowerCase();
      let score = 0;
      if (name === q) score += 10;
      if (name.includes(q)) score += 5;
      for (const t of terms) if (name.includes(t)) score += 1;
      return { n, score };
    })
    .filter((h) => h.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 5);
  if (!hits.length) return "No matching entities. Try a different name or keyword.";
  const out = [];
  for (const { n } of hits) {
    const id = n.id;
    const rels = graph.edges
      .filter((e) => e.source === id || e.target === id)
      .slice(0, 30)
      .map((e) =>
        e.source === id ? `  -> ${e.type} -> ${e.target}` : `  <- ${e.type} <- ${e.source}`,
      );
    out.push(
      `${n.name || id} (${n.type || "entity"})${n.sessions ? ` [sessions: ${n.sessions.join(", ")}]` : ""}\n` +
        (rels.length ? rels.join("\n") : "  (no relationships recorded)"),
    );
  }
  return out.join("\n\n");
}

let brainCache = null;

async function loadBrain(env) {
  if (!brainCache) {
    try {
      const resp = await env.ASSETS.fetch("https://portal/app/brain.json");
      const raw = resp.ok ? await resp.json() : { nodes: [], edges: [] };
      const nodes = raw.nodes || [];
      const edges = raw.edges || [];
      // id -> node, so neighbor edges can be printed with human labels.
      brainCache = { nodes, edges, byId: new Map(nodes.map((n) => [n.id, n])) };
    } catch (err) {
      // Mirror loadGraph: a malformed brain.json must degrade to empty, not 500 the chat.
      console.error(`loadBrain failed: ${err?.message || err}`);
      brainCache = { nodes: [], edges: [], byId: new Map() };
    }
  }
  return brainCache;
}

function searchBrain(brain, query) {
  const q = query.toLowerCase();
  const terms = q.split(/[^a-z0-9]+/).filter((t) => t.length > 1);
  const hits = brain.nodes
    .map((n) => {
      const label = (n.label || n.id).toLowerCase();
      let score = 0;
      if (label === q) score += 10;
      if (label.includes(q)) score += 5;
      for (const t of terms) if (label.includes(t)) score += 1;
      return { n, score };
    })
    .filter((h) => h.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, 6);
  if (!hits.length) return "No matching brain records. Try a different name or keyword.";
  const labelOf = (id) => brain.byId.get(id)?.label || id;
  const out = [];
  for (const { n } of hits) {
    const id = n.id;
    const meta = [n.kind || "Node"];
    if (n.status && n.status !== "na") meta.push(n.status);
    if (n.owner && n.owner !== "TBD") meta.push(`owner: ${n.owner}`);
    const rels = brain.edges
      .filter((e) => e.src === id || e.dst === id)
      .slice(0, 25)
      .map((e) =>
        e.src === id ? `  -> ${e.type} -> ${labelOf(e.dst)}` : `  <- ${e.type} <- ${labelOf(e.src)}`,
      );
    out.push(
      `${n.label || id} (${meta.join(" · ")})${n.source?.path ? ` [source: ${n.source.path}]` : ""}\n` +
        (rels.length ? rels.join("\n") : "  (no relationships recorded)"),
    );
  }
  return out.join("\n\n");
}

async function readDoc(env, path) {
  const clean = cleanDocPath(path);
  if (!clean.ok) return clean.error;
  const resp = await env.ASSETS.fetch(`https://portal/${clean.path}`);
  if (!resp.ok) return `Error: ${clean.path} not found (${resp.status}).`;
  const text = await resp.text();
  return text.length > MAX_DOC_CHARS
    ? text.slice(0, MAX_DOC_CHARS) + `\n\n[truncated — ${text.length} chars total]`
    : text;
}

function cleanDocPath(path) {
  const raw = String(path || "").replace(/\\/g, "/").replace(/^\/+/, "");
  const parts = raw.split("/");
  if (!raw || parts.some((part) => part === ".." || part === "." || part === "")) {
    return { ok: false, error: "Error: invalid document path." };
  }
  if (!SUPPORTED_DOC_EXT.test(raw)) return { ok: false, error: "Error: unsupported file type." };
  return { ok: true, path: raw };
}

function isAllowedNavUrl(url) {
  return ALLOWED_NAV_URLS.has(String(url || ""));
}

async function handleChat(request, env) {
  let body;
  try {
    body = await request.json();
  } catch {
    return json({ error: "invalid JSON body" }, 400);
  }
  const history = Array.isArray(body.messages) ? body.messages.slice(-40) : [];
  if (!history.length || history[history.length - 1].role !== "user") {
    return json({ error: "messages must end with a user message" }, 400);
  }

  const client = env.__ANTHROPIC_CLIENT || new Anthropic({ apiKey: env.ANTHROPIC_API_KEY });
  const pack = await loadPack(env);

  const MODES = {
    terse: {
      effort: "medium",
      maxTokens: 750,
      hint: "Answer mode: TERSE. HARD LIMIT: the final answer is 1-2 sentences — the single most important fact, nothing else. No headings, no lists. Overrides ANY request for detail in the question; the user can switch modes for more.",
    },
    brief: {
      effort: "medium",
      maxTokens: 1500,
      hint: "Answer mode: BRIEF. HARD LIMIT: the final answer is at most 5 sentences (~100 words). No headings, no lists, no dividers — one short paragraph. Research properly first, then distill to the essentials. This limit overrides ANY request for detail in the user's question (\"explain everything\", \"walk me through\") — give the 5-sentence core and note they can switch the chat to deep mode for the full picture.",
    },
    standard: {
      effort: "medium",
      maxTokens: 15000,
      hint: "Answer mode: STANDARD — match length to the ask: tight for narrow questions, fuller (with headings/lists) for broad ones.",
    },
    deep: {
      effort: "high",
      maxTokens: 30000,
      hint: "Answer mode: DEEP — be exhaustive: read every relevant document, cover all angles, organized with headings and lists.",
    },
    academic: {
      effort: "high",
      maxTokens: 60000,
      hint: "Answer mode: ACADEMIC — exhaustive and rigorous. Read every relevant document. Structure: a one-paragraph abstract, then sections with headings. Define terms on first use. Attribute every claim to its source document by name and date (as plain text, never links). State confidence and known gaps explicitly; end with open questions and their owners. Formal register.",
    },
  };
  const mode = MODES[body.mode] || MODES.standard;

  // History from the client is text-only turns; tool round-trips stay server-side per request.
  const messages = history.map((m) => ({
    role: m.role === "assistant" ? "assistant" : "user",
    content: String(m.content).slice(0, 32000),
  }));

  const actions = [];
  const textsSeen = [];
  const sourcesRead = [];
  let response;
  let degraded = false;
  let toolCharsUsed = 0;
  for (let turn = 0; turn < MAX_AGENT_TURNS; turn++) {
    try {
      const stream = client.messages.stream({
        model: MODEL,
        max_tokens: mode.maxTokens,
        thinking: { type: "adaptive" },
        output_config: { effort: mode.effort },
        system: [
          { type: "text", text: SYSTEM, cache_control: { type: "ephemeral" } },
          { type: "text", text: mode.hint },
        ],
        tools: TOOLS,
        messages,
      });
      response = await stream.finalMessage();
    } catch (err) {
      // API error (commonly oversized context, or a transient hiccup): stop the
      // loop and answer from what was already gathered rather than 500-ing the
      // bubble. The fallback below recovers the best text produced so far.
      console.error(`/api/chat degraded on turn ${turn}: ${err?.message || err}`);
      degraded = true;
      break;
    }

    for (const b of response.content) {
      if (b.type === "text" && b.text.trim()) textsSeen.push(b.text.trim());
    }
    if (response.stop_reason !== "tool_use") break;

    // Navigate-only turns: the model writes its answer alongside navigate
    // calls. Collect the chips and treat this turn's text as final instead of
    // forcing another round trip (which orphans the real answer).
    const toolBlocks = response.content.filter((b) => b.type === "tool_use");
    if (toolBlocks.length && toolBlocks.every((b) => b.name === "navigate")) {
      for (const block of toolBlocks) {
        const u = String(block.input.url || "/");
        if (isAllowedNavUrl(u)) {
          actions.push({ url: u, label: String(block.input.label || "Open") });
        }
      }
      break;
    }

    messages.push({ role: "assistant", content: response.content });
    const results = [];
    for (const block of response.content) {
      if (block.type !== "tool_use") continue;
      let result;
      if (block.name === "search_knowledge") {
        result = searchKnowledge(pack, block.input.query || "");
      } else if (block.name === "search_graph") {
        result = searchGraph(await loadGraph(env), block.input.query || "");
      } else if (block.name === "search_brain") {
        result = searchBrain(await loadBrain(env), block.input.query || "");
      } else if (block.name === "read_doc") {
        result = await readDoc(env, block.input.path || "");
        if (!result.startsWith("Error")) {
          const cp = String(block.input.path || "").replace(/^\/+/, "");
          if (!sourcesRead.includes(cp)) sourcesRead.push(cp);
        }
      } else if (block.name === "navigate") {
        const u = String(block.input.url || "/");
        if (isAllowedNavUrl(u)) {
          actions.push({ url: u, label: String(block.input.label || "Open") });
          result = "Navigation chip added to the reply.";
        } else {
          result = "Rejected: URL is not an allowed portal page. Use only the URLs listed in your instructions.";
        }
      } else {
        result = `Unknown tool: ${block.name}`;
      }
      if (typeof result === "string") {
        const remaining = TOOL_CHAR_BUDGET - toolCharsUsed;
        if (result.length > remaining) {
          result =
            remaining > 400
              ? result.slice(0, remaining) +
                "\n\n[context budget reached — do not read more documents; answer from what you have already read]"
              : "[context budget reached — do not call more tools; answer now from the material already read]";
        }
        toolCharsUsed += result.length;
      }
      results.push({ type: "tool_result", tool_use_id: block.id, content: result });
    }
    messages.push({ role: "user", content: results });
  }

  // Strip markdown link syntax the model emitted despite instructions —
  // navigation belongs to the chips. Other markdown renders in the bubble.
  const deLink = (t) => t.replace(/\[([^\]]+)\]\(([^)]*)\)/g, "$1").trim();

  let reply = deLink(
    (response?.content || [])
      .filter((b) => b.type === "text")
      .map((b) => b.text)
      .join("\n"),
  );
  // Degenerate final message (e.g. links-only or near-empty): fall back to the
  // longest substantive text produced anywhere in the loop.
  const minReply = { terse: 40, brief: 60, standard: 200, deep: 600, academic: 600 }[body.mode] || 200;
  if (reply.length < minReply) {
    const best = textsSeen.map(deLink).sort((a, b) => b.length - a.length)[0] || "";
    if (best.length > reply.length) reply = best;
  }
  const sources = sourcesRead.map((p) => {
    const item = pack.find((i) => i.path === p);
    return { path: p, title: item ? item.title : p.split("/").pop() };
  });
  return json({
    reply:
      reply ||
      (degraded
        ? "I hit a limit pulling that together — try a narrower question, or switch to a lighter answer mode (terse/brief)."
        : "I could not produce an answer — try rephrasing."),
    actions,
    sources,
  });
}

function json(obj, status = 200) {
  return new Response(JSON.stringify(obj), {
    status,
    headers: { "content-type": "application/json" },
  });
}

export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    if (url.pathname === "/api/chat") {
      if (request.method !== "POST") return json({ error: "POST only" }, 405);
      try {
        return await handleChat(request, env);
      } catch (err) {
        return json({ error: `agent error: ${err.message || err}` }, 500);
      }
    }

    const resp = await env.ASSETS.fetch(request);
    const ct = resp.headers.get("content-type") || "";
    if (!ct.includes("text/html")) return resp;

    // The local product-design preview must show only the designed interface.
    // Keep the chat API available, but do not inject the portal's “Ask me anything”
    // bubble into the localhost pages.
    return resp;
  },
};
