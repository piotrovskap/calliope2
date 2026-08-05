// DAS CDP portal chat bubble — injected into every HTML page by worker.js.
// Talks to POST /api/chat; renders replies + navigation chips.
(function () {
  if (window.__dasBubble) return;
  window.__dasBubble = true;

  const css = `
  #das-bubble-btn { position:fixed; bottom:22px; right:22px; z-index:9999; width:52px; height:52px;
    border-radius:50%; background:#DB394C; border:none; cursor:pointer; box-shadow:0 4px 18px rgba(0,0,0,.45);
    display:flex; align-items:center; justify-content:center; transition:transform .15s; }
  #das-bubble-btn:hover { transform:scale(1.07); }
  #das-bubble-btn svg { width:24px; height:24px; fill:#fff; }
  #das-chat { position:fixed; bottom:86px; right:22px; z-index:9999; width:380px; max-width:calc(100vw - 44px);
    height:520px; max-height:calc(100vh - 130px); background:#161616; border:1px solid #333; border-radius:10px;
    display:none; flex-direction:column; overflow:hidden; box-shadow:0 10px 40px rgba(0,0,0,.6);
    font-family:'Roboto',system-ui,sans-serif; font-size:13px; color:#F8F8F8; transition:width .15s, height .15s; }
  #das-chat.open { display:flex; }
  #das-chat.max { width:calc(100vw - 44px); height:calc(100vh - 130px); max-width:1100px; }
  #das-chat.max .das-msg { max-width:760px; font-size:14px; }
  #das-chat-expand { background:none; border:none; color:#888; font-size:14px; cursor:pointer; margin-right:6px; }
  #das-chat-expand:hover, #das-chat-close:hover { color:#F8F8F8; }
  #das-chat-mode { background:#1a1a1a; border:1px solid #333; border-radius:10px; color:#888; font-size:10px;
    font-family:'Roboto Mono',monospace; text-transform:uppercase; letter-spacing:.05em; cursor:pointer;
    padding:2px 9px; margin-right:8px; }
  #das-chat-mode:hover { color:#F8F8F8; border-color:#555; }
  #das-chat-head { padding:10px 14px; background:#0d0d0d; border-bottom:1px solid #2a2a2a; display:flex;
    justify-content:space-between; align-items:center; }
  #das-chat-head b { font-family:'Unica One',sans-serif; font-weight:400; letter-spacing:.08em; color:#DB394C;
    text-transform:uppercase; font-size:13px; }
  #das-chat-head small { color:#666; font-size:10px; margin-left:8px; }
  #das-chat-close { background:none; border:none; color:#888; font-size:16px; cursor:pointer; }
  #das-chat-log { flex:1; overflow-y:auto; padding:14px; display:flex; flex-direction:column; gap:10px; }
  .das-msg { max-width:88%; padding:8px 11px; border-radius:8px; line-height:1.55; word-wrap:break-word; }
  .das-msg.user { align-self:flex-end; background:#2a2a2a; white-space:pre-wrap; }
  .das-msg.bot { align-self:flex-start; background:#111; border:1px solid #2a2a2a; }
  .das-msg.bot.thinking { color:#666; font-style:italic; }
  .das-msg.bot p { margin:0 0 8px; } .das-msg.bot p:last-child { margin-bottom:0; }
  .das-msg.bot h4 { font-family:'Unica One',sans-serif; font-weight:400; font-size:13px; letter-spacing:.06em;
    text-transform:uppercase; color:#DB394C; margin:12px 0 6px; }
  .das-msg.bot ul { margin:0 0 8px; padding-left:18px; }
  .das-msg.bot li { margin-bottom:3px; }
  .das-msg.bot hr { border:none; border-top:1px solid #2a2a2a; margin:10px 0; }
  .das-msg.bot code { font-family:'Roboto Mono',monospace; font-size:11px; background:#1d1d1d;
    border:1px solid #2a2a2a; border-radius:3px; padding:0 4px; }
  .das-msg.bot strong { color:#fff; }
  .das-chips { display:flex; gap:6px; flex-wrap:wrap; align-self:flex-start; }
  .das-chip { font-size:11px; color:#F8F8F8; background:rgba(219,57,76,.12); border:1px solid rgba(219,57,76,.45);
    border-radius:14px; padding:3px 11px; cursor:pointer; text-decoration:none; }
  .das-chip:hover { background:rgba(219,57,76,.25); }
  .das-sources { align-self:flex-start; max-width:88%; border-left:2px solid #2a2a2a; padding:2px 0 2px 10px; }
  .das-sources b { display:block; font-family:'Roboto Mono',monospace; font-size:9px; font-weight:700;
    text-transform:uppercase; letter-spacing:.08em; color:#555; margin-bottom:3px; }
  .das-sources a { display:block; font-family:'Roboto Mono',monospace; font-size:10px; color:#4A7FA5;
    text-decoration:none; line-height:1.7; }
  .das-sources a:hover { color:#F8F8F8; }
  #das-chat-form { display:flex; border-top:1px solid #2a2a2a; }
  #das-chat-input { flex:1; background:#0d0d0d; border:none; outline:none; color:#F8F8F8; padding:11px 13px;
    font-family:inherit; font-size:13px; }
  #das-chat-send { background:none; border:none; color:#DB394C; font-weight:700; cursor:pointer; padding:0 14px;
    font-size:12px; letter-spacing:.05em; }
  #das-chat-send:disabled { color:#444; cursor:default; }`;

  const style = document.createElement("style");
  style.textContent = css;
  document.head.appendChild(style);

  const btn = document.createElement("button");
  btn.id = "das-bubble-btn";
  btn.title = "Ask the knowledge base";
  btn.innerHTML =
    '<svg viewBox="0 0 24 24"><path d="M12 3C7 3 3 6.6 3 11c0 2.2 1 4.2 2.7 5.6L5 21l4-1.6c.9.3 1.9.4 3 .4 5 0 9-3.6 9-8s-4-8.8-9-8.8z"/></svg>';
  document.body.appendChild(btn);

  const panel = document.createElement("div");
  panel.id = "das-chat";
  panel.innerHTML = `
    <div id="das-chat-head"><div><b>Chat CDP</b><small>knowledge base agent</small></div>
      <div><button id="das-chat-mode" title="Answer depth — click to cycle"></button><button id="das-chat-expand" aria-label="Expand" title="Expand">⛶</button><button id="das-chat-close" aria-label="Close">✕</button></div></div>
    <div id="das-chat-log"></div>
    <form id="das-chat-form"><input id="das-chat-input" placeholder="Ask about the project…" autocomplete="off"/>
      <button id="das-chat-send" type="submit">SEND</button></form>`;
  document.body.appendChild(panel);

  const log = panel.querySelector("#das-chat-log");
  const input = panel.querySelector("#das-chat-input");
  const send = panel.querySelector("#das-chat-send");
  const history = [];

  const MODES = ["terse", "brief", "standard", "deep", "academic"];
  const modeBtn = panel.querySelector("#das-chat-mode");
  let mode = localStorage.getItem("das-chat-mode") || "standard";
  if (!MODES.includes(mode)) mode = "standard";
  modeBtn.textContent = mode;
  modeBtn.addEventListener("click", () => {
    mode = MODES[(MODES.indexOf(mode) + 1) % MODES.length];
    localStorage.setItem("das-chat-mode", mode);
    modeBtn.textContent = mode;
    input.focus();
  });

  // Minimal markdown -> HTML for bot messages. Escapes all HTML first, then
  // renders only: ## headings, **bold**, \`code\`, - lists, --- dividers.
  function md(text) {
    const esc = String(text).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
    const inline = (s) =>
      s.replace(/\*\*([^*]+)\*\*/g, "<strong>$1</strong>").replace(/`([^`]+)`/g, "<code>$1</code>");
    const out = [];
    let list = null, para = [];
    const flushPara = () => { if (para.length) { out.push(`<p>${para.join("<br>")}</p>`); para = []; } };
    const flushList = () => { if (list) { out.push(`<ul>${list.join("")}</ul>`); list = null; } };
    for (const raw of esc.split("\n")) {
      const line = raw.trim();
      if (!line) { flushPara(); flushList(); continue; }
      if (/^-{3,}$/.test(line)) { flushPara(); flushList(); out.push("<hr>"); continue; }
      const h = line.match(/^#{1,4}\s+(.*)$/);
      if (h) { flushPara(); flushList(); out.push(`<h4>${inline(h[1])}</h4>`); continue; }
      const li = line.match(/^[-*•]\s+(.*)$/) || line.match(/^\d+[.)]\s+(.*)$/);
      if (li) { flushPara(); (list = list || []).push(`<li>${inline(li[1])}</li>`); continue; }
      flushList(); para.push(inline(line));
    }
    flushPara(); flushList();
    return out.join("");
  }

  function add(role, text, cls) {
    const div = document.createElement("div");
    div.className = `das-msg ${role}${cls ? " " + cls : ""}`;
    if (role === "bot" && !cls) div.innerHTML = md(text);
    else div.textContent = text;
    log.appendChild(div);
    log.scrollTop = log.scrollHeight;
    return div;
  }

  function addChips(actions) {
    if (!actions || !actions.length) return;
    const wrap = document.createElement("div");
    wrap.className = "das-chips";
    for (const a of actions.slice(0, 3)) {
      const chip = document.createElement("a");
      chip.className = "das-chip";
      chip.textContent = a.label + " →";
      chip.href = a.url;
      wrap.appendChild(chip);
    }
    log.appendChild(wrap);
    log.scrollTop = log.scrollHeight;
  }

  function addSources(sources) {
    if (!sources || !sources.length) return;
    const wrap = document.createElement("div");
    wrap.className = "das-sources";
    const head = document.createElement("b");
    head.textContent = "Sources";
    wrap.appendChild(head);
    for (const s of sources) {
      const a = document.createElement("a");
      a.textContent = s.title + " — " + s.path;
      a.href = s.path.endsWith(".md") ? "/docs/reader.html?f=" + encodeURIComponent(s.path) : "/" + s.path;
      a.target = "_blank";
      wrap.appendChild(a);
    }
    log.appendChild(wrap);
    log.scrollTop = log.scrollHeight;
  }

  btn.addEventListener("click", () => {
    panel.classList.toggle("open");
    if (panel.classList.contains("open")) {
      if (!log.children.length)
        add("bot", "Ask me anything about the DAS CDP engagement — decisions, data sources, open questions, the plan. I answer from the portal knowledge base.");
      input.focus();
    }
  });
  panel.querySelector("#das-chat-close").addEventListener("click", () => panel.classList.remove("open"));
  panel.querySelector("#das-chat-expand").addEventListener("click", () => {
    panel.classList.toggle("max");
    log.scrollTop = log.scrollHeight;
    input.focus();
  });

  panel.querySelector("#das-chat-form").addEventListener("submit", async (e) => {
    e.preventDefault();
    const q = input.value.trim();
    if (!q || send.disabled) return;
    input.value = "";
    add("user", q);
    history.push({ role: "user", content: q });
    send.disabled = true;
    const pending = add("bot", "Searching the knowledge base…", "thinking");
    try {
      const resp = await fetch("/api/chat", {
        method: "POST",
        headers: { "content-type": "application/json" },
        body: JSON.stringify({ messages: history, mode }),
      });
      const data = await resp.json();
      pending.remove();
      if (!resp.ok || data.error) {
        add("bot", "Error: " + (data.error || resp.status));
      } else {
        add("bot", data.reply);
        addSources(data.sources);
        addChips(data.actions);
        history.push({ role: "assistant", content: data.reply });
      }
    } catch (err) {
      pending.remove();
      add("bot", "Network error — try again.");
    } finally {
      send.disabled = false;
      input.focus();
    }
  });
})();
