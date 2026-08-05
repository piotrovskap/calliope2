import assert from "node:assert/strict";
import test from "node:test";

import worker from "../worker.js";

function jsonResponse(obj, init = {}) {
  return new Response(JSON.stringify(obj), {
    status: init.status || 200,
    headers: { "content-type": "application/json" },
  });
}

function textResponse(text, init = {}) {
  return new Response(text, {
    status: init.status || 200,
    headers: { "content-type": "text/plain" },
  });
}

function chatRequest(body, init = {}) {
  return new Request("https://portal.test/api/chat", {
    method: init.method || "POST",
    headers: { "content-type": "application/json" },
    body: body === undefined ? undefined : JSON.stringify(body),
  });
}

function makeClient(responder) {
  let calls = 0;
  const payloads = [];
  return {
    payloads,
    client: {
      messages: {
        stream(payload) {
          payloads.push(payload);
          return {
            async finalMessage() {
              return responder(payload, calls++);
            },
          };
        },
      },
    },
  };
}

function makeEnv(client, assetMap = {}, brain = { nodes: [], edges: [] }) {
  const assetFetches = [];
  const defaultPack = {
    items: [
      {
        path: "memory/decisions.md",
        title: "Decisions",
        summary: "Project decisions",
      },
    ],
  };
  return {
    __ANTHROPIC_CLIENT: client,
    ANTHROPIC_API_KEY: "test-key",
    assetFetches,
    ASSETS: {
      async fetch(input) {
        const url = new URL(String(input));
        const path = url.pathname.replace(/^\/+/, "");
        assetFetches.push(path);
        if (path === "app/knowledge-pack.json") return jsonResponse(defaultPack);
        if (path === "app/knowledge_graph.json") return jsonResponse({ nodes: [], edges: [] });
        if (path === "app/brain.json") return jsonResponse(brain);
        if (Object.hasOwn(assetMap, path)) return textResponse(assetMap[path]);
        return textResponse("not found", { status: 404 });
      },
    },
  };
}

async function json(resp) {
  return resp.json();
}

test("POST /api/chat rejects invalid request bodies before model calls", async () => {
  const { client, payloads } = makeClient(() => {
    throw new Error("model should not be called");
  });
  const env = makeEnv(client);

  let resp = await worker.fetch(new Request("https://portal.test/api/chat", { method: "GET" }), env, {});
  assert.equal(resp.status, 405);

  resp = await worker.fetch(
    new Request("https://portal.test/api/chat", { method: "POST", body: "not-json" }),
    env,
    {},
  );
  assert.equal(resp.status, 400);
  assert.match((await json(resp)).error, /invalid JSON/);

  resp = await worker.fetch(chatRequest({ messages: [] }), env, {});
  assert.equal(resp.status, 400);
  assert.match((await json(resp)).error, /messages must end/);

  resp = await worker.fetch(chatRequest({ messages: [{ role: "assistant", content: "x" }] }), env, {});
  assert.equal(resp.status, 400);
  assert.match((await json(resp)).error, /messages must end/);

  assert.equal(payloads.length, 0);
});

test("read_doc rejects unsupported file types", async () => {
  const { client } = makeClient((payload, call) => {
    if (call === 0) {
      return {
        stop_reason: "tool_use",
        content: [
          {
            type: "tool_use",
            id: "tool-1",
            name: "read_doc",
            input: { path: "secrets.env" },
          },
        ],
      };
    }
    const result = payload.messages.at(-1).content[0].content;
    return { stop_reason: "end_turn", content: [{ type: "text", text: result }] };
  });
  const env = makeEnv(client);

  const resp = await worker.fetch(chatRequest({ messages: [{ role: "user", content: "read env" }] }), env, {});
  assert.equal(resp.status, 200);
  assert.match((await json(resp)).reply, /unsupported file type/);
  assert.ok(!env.assetFetches.includes("secrets.env"));
});

test("read_doc rejects traversal paths before asset fetch", async () => {
  const { client } = makeClient((payload, call) => {
    if (call === 0) {
      return {
        stop_reason: "tool_use",
        content: [
          {
            type: "tool_use",
            id: "tool-1",
            name: "read_doc",
            input: { path: "../worker.js" },
          },
        ],
      };
    }
    const result = payload.messages.at(-1).content[0].content;
    return { stop_reason: "end_turn", content: [{ type: "text", text: result }] };
  });
  const env = makeEnv(client, { "worker.js": "should not be read" });

  const resp = await worker.fetch(chatRequest({ messages: [{ role: "user", content: "read worker" }] }), env, {});
  assert.equal(resp.status, 200);
  assert.match((await json(resp)).reply, /invalid document path/);
  assert.ok(!env.assetFetches.includes("worker.js"));
});

test("navigate chips are restricted to the explicit portal whitelist", async () => {
  const { client } = makeClient(() => ({
    stop_reason: "tool_use",
    content: [
      { type: "text", text: "Open the relevant project pages." },
      {
        type: "tool_use",
        id: "tool-1",
        name: "navigate",
        input: { url: "/analysis/artifacts/open-questions/", label: "Open Questions" },
      },
      {
        type: "tool_use",
        id: "tool-2",
        name: "navigate",
        input: { url: "/analysis/artifacts/not-real/", label: "Not Real" },
      },
      {
        type: "tool_use",
        id: "tool-3",
        name: "navigate",
        input: { url: "/docs/reader.html?f=memory/decisions.md", label: "Raw Doc" },
      },
    ],
  }));
  const env = makeEnv(client);

  const resp = await worker.fetch(chatRequest({ messages: [{ role: "user", content: "where?" }] }), env, {});
  assert.equal(resp.status, 200);
  const body = await json(resp);
  assert.equal(body.actions.length, 1);
  assert.deepEqual(body.actions[0], {
    url: "/analysis/artifacts/open-questions/",
    label: "Open Questions",
  });
});

test("search_brain returns matching records with kind, source, and neighbor labels", async () => {
  const { client } = makeClient((payload, call) => {
    if (call === 0) {
      return {
        stop_reason: "tool_use",
        content: [
          {
            type: "tool_use",
            id: "tool-1",
            name: "search_brain",
            input: { query: "RLS decision" },
          },
        ],
      };
    }
    const result = payload.messages.at(-1).content[0].content;
    return { stop_reason: "end_turn", content: [{ type: "text", text: result }] };
  });
  const brain = {
    nodes: [
      {
        id: "dec:rls",
        kind: "Decision",
        label: "RLS decision",
        status: "locked",
        owner: "Luis",
        source: { path: "memory/decisions.md" },
      },
      { id: "db:postgres", kind: "Database", label: "PostgreSQL", source: { path: "docs/databases.json" } },
    ],
    edges: [{ id: "e1", src: "dec:rls", dst: "db:postgres", type: "applies_to", class: "structural" }],
  };
  const env = makeEnv(client, {}, brain);

  const resp = await worker.fetch(
    chatRequest({ messages: [{ role: "user", content: "what was decided about RLS?" }] }),
    env,
    {},
  );
  assert.equal(resp.status, 200);
  const body = await json(resp);
  assert.match(body.reply, /RLS decision \(Decision · locked · owner: Luis\)/);
  assert.match(body.reply, /\[source: memory\/decisions\.md\]/);
  assert.match(body.reply, /-> applies_to -> PostgreSQL/);
  assert.ok(env.assetFetches.includes("app/brain.json"));
});

test("read_doc returns source metadata only for successful reads", async () => {
  const { client } = makeClient((payload, call) => {
    if (call === 0) {
      return {
        stop_reason: "tool_use",
        content: [
          {
            type: "tool_use",
            id: "tool-1",
            name: "read_doc",
            input: { path: "memory/decisions.md" },
          },
        ],
      };
    }
    const result = payload.messages.at(-1).content[0].content;
    return { stop_reason: "end_turn", content: [{ type: "text", text: `Read result: ${result}` }] };
  });
  const env = makeEnv(client, { "memory/decisions.md": "# Decisions\n\nUseful content." });

  const resp = await worker.fetch(chatRequest({ messages: [{ role: "user", content: "read decisions" }] }), env, {});
  assert.equal(resp.status, 200);
  const body = await json(resp);
  assert.match(body.reply, /Useful content/);
  assert.deepEqual(body.sources, [{ path: "memory/decisions.md", title: "Decisions" }]);
});
