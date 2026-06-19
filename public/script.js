/* ============================================================
   Calliope — lead-magnet mechanics
   - Exit-intent modal (desktop) + scroll/time trigger (all)
   - Shown once per session (localStorage), suppressed after capture
   - Sticky header on scroll, mobile sticky CTA bar
   - Form capture: stores lead, posts to optional endpoint, success state
   ============================================================ */
(function () {
  "use strict";

  var LS = {
    modalSeen: "cal_modal_seen",
    lead: "cal_lead_captured",
    announce: "cal_announce_closed",
  };

  /* ---- OPTIONAL: set a real endpoint to receive leads ----
     e.g. a Cloudflare Pages Function (/api/lead), Formspree, etc.
     Leave null to run in capture-to-localStorage demo mode.        */
  var LEAD_ENDPOINT = null;

  function store(key, val) { try { localStorage.setItem(key, val); } catch (e) {} }
  function read(key) { try { return localStorage.getItem(key); } catch (e) { return null; } }
  function hasLead() { return !!read(LS.lead); }

  /* ---------------- Announcement bar ---------------- */
  var announce = document.getElementById("announce");
  if (announce) {
    if (read(LS.announce)) announce.classList.add("hide");
    var aClose = announce.querySelector("[data-close-announce]");
    if (aClose) aClose.addEventListener("click", function () {
      announce.classList.add("hide");
      store(LS.announce, "1");
    });
  }

  /* ---------------- Sticky header ---------------- */
  var header = document.getElementById("header");
  var stickyBar = document.getElementById("stickyBar");
  function onScroll() {
    var y = window.pageYOffset || document.documentElement.scrollTop;
    if (header) header.classList.toggle("scrolled", y > 60);
    if (stickyBar) stickyBar.classList.toggle("show", y > 700);
  }
  window.addEventListener("scroll", onScroll, { passive: true });
  onScroll();

  /* ---------------- Mobile menu ---------------- */
  var hamburger = document.getElementById("hamburger");
  var mobileMenu = document.getElementById("mobileMenu");
  if (hamburger && mobileMenu) {
    hamburger.addEventListener("click", function () {
      var open = mobileMenu.classList.toggle("open");
      hamburger.setAttribute("aria-expanded", open ? "true" : "false");
    });
    mobileMenu.addEventListener("click", function (e) {
      if (e.target.tagName === "A") {
        mobileMenu.classList.remove("open");
        hamburger.setAttribute("aria-expanded", "false");
      }
    });
  }

  /* ---------------- Search (command palette) ---------------- */
  var SEARCH_ITEMS = [
    { t: "AI Lab", h: "Studio", a: "#studio", k: "notebook jupyter sql data analysis" },
    { t: "AI IDE & Agents", h: "Studio", a: "#studio", k: "ide agent code editor autonomous" },
    { t: "Chat Studio", h: "Studio", a: "#studio", k: "chat data business sql" },
    { t: "Deep Agent", h: "Studio", a: "#studio", k: "research rag knowledge" },
    { t: "Langflow", h: "Studio", a: "#studio", k: "pipeline visual builder workflow no-code" },
    { t: "Secure Browser", h: "Studio", a: "#studio", k: "browser air-gapped web isolated" },
    { t: "Deployment — Astrolift", h: "Run", a: "#deploy", k: "deploy cloud on-prem vpc air-gapped runtime aws gcp azure" },
    { t: "Governance — Zentinelle", h: "Govern", a: "#govern", k: "grc governance policy risk compliance audit observability secrets" },
    { t: "Security & compliance", h: "Govern", a: "#govern", k: "soc2 hipaa gdpr eu ai act security" },
    { t: "Pricing & packaging", h: "Pricing", a: "#pricing", k: "price cost plan packaging studio runtime enterprise" },
    { t: "Deployment Blueprint", h: "Resource", a: "#blueprint", k: "blueprint guide pdf download architecture" },
    { t: "How it works", h: "Learn", a: "#how", k: "how buy deploy govern steps" },
    { t: "Book a demo", h: "Contact", a: "#demo", k: "demo contact sales talk" }
  ];
  var sOverlay = document.getElementById("searchOverlay");
  var sInput = document.getElementById("searchInput");
  var sResults = document.getElementById("searchResults");
  var sBtn = document.getElementById("searchBtn");
  var sActive = 0, sCurrent = [];

  function escapeHtml(s) { return s.replace(/[&<>]/g, function (c) { return { "&": "&amp;", "<": "&lt;", ">": "&gt;" }[c]; }); }

  function renderSearch(q) {
    q = (q || "").trim().toLowerCase();
    sCurrent = SEARCH_ITEMS.filter(function (it) {
      return !q || (it.t + " " + it.h + " " + it.k).toLowerCase().indexOf(q) >= 0;
    });
    sActive = 0;
    if (!sCurrent.length) {
      sResults.innerHTML = '<li class="search-empty">No matches. Try “deploy”, “governance”, or “pricing”.</li>';
      return;
    }
    sResults.innerHTML = sCurrent.map(function (it, i) {
      return '<li role="option" class="' + (i === 0 ? "active" : "") +
        '"><span class="sr-dot"></span><span class="sr-title">' + escapeHtml(it.t) +
        '</span><span class="sr-hint">' + escapeHtml(it.h) + "</span></li>";
    }).join("");
    Array.prototype.forEach.call(sResults.children, function (li, i) {
      li.addEventListener("click", function () { goSearch(i); });
      li.addEventListener("mousemove", function () { setActive(i); });
    });
  }
  function setActive(i) {
    sActive = i;
    Array.prototype.forEach.call(sResults.children, function (li, idx) {
      li.classList.toggle("active", idx === i);
    });
  }
  function goSearch(i) {
    var it = sCurrent[i];
    if (!it) return;
    closeSearch();
    location.hash = it.a;
  }
  function sKey(e) {
    if (e.key === "Escape") closeSearch();
    else if (e.key === "ArrowDown") { e.preventDefault(); setActive(Math.min(sActive + 1, sCurrent.length - 1)); ensureVisible(); }
    else if (e.key === "ArrowUp") { e.preventDefault(); setActive(Math.max(sActive - 1, 0)); ensureVisible(); }
    else if (e.key === "Enter") { e.preventDefault(); goSearch(sActive); }
  }
  function ensureVisible() {
    var li = sResults.children[sActive];
    if (li && li.scrollIntoView) li.scrollIntoView({ block: "nearest" });
  }
  function openSearch() {
    if (!sOverlay) return;
    sOverlay.hidden = false;
    void sOverlay.offsetWidth;
    sOverlay.classList.add("open");
    sInput.value = "";
    renderSearch("");
    setTimeout(function () { sInput.focus(); }, 60);
    document.addEventListener("keydown", sKey);
  }
  function closeSearch() {
    if (!sOverlay) return;
    sOverlay.classList.remove("open");
    document.removeEventListener("keydown", sKey);
    setTimeout(function () { sOverlay.hidden = true; }, 160);
  }
  if (sBtn) sBtn.addEventListener("click", openSearch);
  if (sInput) sInput.addEventListener("input", function () { renderSearch(sInput.value); });
  if (sOverlay) sOverlay.addEventListener("click", function (e) { if (e.target === sOverlay) closeSearch(); });
  document.addEventListener("keydown", function (e) {
    if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "k") { e.preventDefault(); openSearch(); }
    else if (e.key === "/" && document.activeElement && !/INPUT|TEXTAREA/.test(document.activeElement.tagName)) { e.preventDefault(); openSearch(); }
  });

  /* ---------------- Lead modal ---------------- */
  var modal = document.getElementById("leadModal");
  var modalOpen = false;

  function openModal() {
    if (!modal || modalOpen || hasLead() || read(LS.modalSeen)) return;
    modalOpen = true;
    store(LS.modalSeen, "1");
    modal.hidden = false;
    // force reflow then animate
    void modal.offsetWidth;
    modal.classList.add("open");
    var input = modal.querySelector("input[type=email]");
    if (input) setTimeout(function () { input.focus(); }, 120);
    document.addEventListener("keydown", onEsc);
  }
  function closeModal() {
    if (!modal) return;
    modal.classList.remove("open");
    document.removeEventListener("keydown", onEsc);
    setTimeout(function () { modal.hidden = true; }, 200);
  }
  function onEsc(e) { if (e.key === "Escape") closeModal(); }

  if (modal) {
    modal.querySelectorAll("[data-close-modal]").forEach(function (el) {
      el.addEventListener("click", closeModal);
    });
    modal.addEventListener("click", function (e) {
      if (e.target === modal) closeModal();
    });
  }

  /* Trigger 1: exit intent (desktop) — cursor leaves toward top */
  document.addEventListener("mouseout", function (e) {
    if (!e.relatedTarget && e.clientY <= 4) openModal();
  });

  /* Trigger 2: time on page (fallback, esp. mobile) */
  setTimeout(openModal, 45000);

  /* Trigger 3: scroll depth (~60%) */
  var scrollFired = false;
  window.addEventListener("scroll", function () {
    if (scrollFired) return;
    var st = window.pageYOffset;
    var h = document.documentElement.scrollHeight - window.innerHeight;
    if (h > 0 && st / h > 0.6) { scrollFired = true; openModal(); }
  }, { passive: true });

  /* ---------------- Forms ---------------- */
  function isEmail(v) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v); }

  function markCaptured(form, email) {
    store(LS.lead, email || "1");
    // Suppress modal once we have a lead; close it if open
    if (modalOpen) closeModal();
  }

  function showSuccess(form, msg) {
    var s = document.createElement("div");
    s.className = "lead-success";
    s.innerHTML = '<span>✓</span> ' + (msg || "Thanks — check your inbox shortly.");
    form.parentNode.replaceChild(s, form);
  }

  function submitLead(form) {
    var data = {};
    Array.prototype.forEach.call(form.elements, function (el) {
      if (el.name) data[el.name] = el.value;
    });
    data.source = form.getAttribute("data-source") || "unknown";
    data.ts = new Date().toISOString();
    data.path = location.pathname;

    markCaptured(form, data.email);

    var done = function () {
      var msg = data.source === "demo"
        ? "Thanks — we'll reach out to schedule your private demo."
        : (data.source === "footer"
            ? "You're subscribed."
            : "Thanks — your blueprint is on its way.");
      showSuccess(form, msg);
    };

    if (LEAD_ENDPOINT) {
      fetch(LEAD_ENDPOINT, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data),
      }).then(done).catch(done);
    } else {
      // demo mode: persist locally so nothing is lost
      try {
        var all = JSON.parse(read("cal_leads") || "[]");
        all.push(data);
        store("cal_leads", JSON.stringify(all));
      } catch (e) {}
      setTimeout(done, 350);
    }
  }

  document.querySelectorAll("[data-lead-form]").forEach(function (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var email = form.querySelector("input[type=email]");
      if (email && !isEmail(email.value)) {
        email.focus();
        email.style.borderColor = "#e0564f";
        return;
      }
      submitLead(form);
    });
  });
})();

/* ===== Pricing billing toggle (monthly / annual) ===== */
(function () {
  var toggle = document.querySelector("[data-bill-toggle]");
  if (!toggle) return;
  var opts = toggle.querySelectorAll(".bill-opt");
  function apply(bill) {
    opts.forEach(function (b) {
      var on = b.getAttribute("data-bill") === bill;
      b.classList.toggle("is-active", on);
      b.setAttribute("aria-pressed", on ? "true" : "false");
    });
    document.querySelectorAll("[data-" + bill + "]").forEach(function (el) {
      var v = el.getAttribute("data-" + bill);
      if (v != null) el.textContent = v;
      // retrigger the roll animation
      el.classList.remove("num-roll");
      void el.offsetWidth;
      el.classList.add("num-roll");
    });
  }
  opts.forEach(function (b) {
    b.addEventListener("click", function () { apply(b.getAttribute("data-bill")); });
  });
})();

/* ===== Tab "come back" — gentle title swap when the tab loses focus ===== */
(function () {
  var original = document.title;
  var away = ["Your private-AI workspace is waiting", "← Come back to Calliope"];
  var timer = null, i = 0;
  function start() {
    if (timer) return;
    i = 0;
    document.title = away[0];
    timer = setInterval(function () { i = (i + 1) % away.length; document.title = away[i]; }, 1400);
  }
  function stop() {
    if (timer) { clearInterval(timer); timer = null; }
    document.title = original;
  }
  document.addEventListener("visibilitychange", function () {
    if (document.hidden) start(); else stop();
  });
})();

/* ===== Industry focus carousel (arrows + auto-rotate right) ===== */
(function () {
  var track = document.querySelector("[data-ind-track]");
  if (!track) return;
  var prev = document.querySelector("[data-ind-prev]");
  var next = document.querySelector("[data-ind-next]");
  function step() {
    var card = track.querySelector(".indcard");
    return card ? card.getBoundingClientRect().width + 16 : 300;
  }
  function go(dir) { track.scrollBy({ left: dir * step(), behavior: "smooth" }); }
  if (prev) prev.addEventListener("click", function () { go(-1); });
  if (next) next.addEventListener("click", function () { go(1); });

  /* drag-to-scroll with mouse (touch uses native swipe) */
  var down = false, moved = false, startX = 0, startScroll = 0;
  track.addEventListener("pointerdown", function (e) {
    if (e.pointerType !== "mouse") return;
    down = true; moved = false; startX = e.clientX; startScroll = track.scrollLeft;
    track.classList.add("dragging");
    track.setPointerCapture(e.pointerId);
  });
  track.addEventListener("pointermove", function (e) {
    if (!down) return;
    var dx = e.clientX - startX;
    if (Math.abs(dx) > 5) moved = true;
    track.scrollLeft = startScroll - dx;
  });
  function endDrag() { down = false; track.classList.remove("dragging"); }
  track.addEventListener("pointerup", endDrag);
  track.addEventListener("pointercancel", endDrag);
  /* swallow the click that follows a drag so cards don't navigate */
  track.addEventListener("click", function (e) {
    if (moved) { e.preventDefault(); e.stopPropagation(); moved = false; }
  }, true);

  var reduce = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var paused = false;
  ["mouseenter", "focusin", "touchstart"].forEach(function (e) { track.addEventListener(e, function () { paused = true; }); });
  ["mouseleave", "focusout"].forEach(function (e) { track.addEventListener(e, function () { paused = false; }); });
  if (!reduce) {
    setInterval(function () {
      if (paused) return;
      var max = track.scrollWidth - track.clientWidth - 4;
      if (track.scrollLeft >= max) track.scrollTo({ left: 0, behavior: "smooth" });
      else go(1);
    }, 3200);
  }
})();

/* ===== Interactive Calliope IDE mock ===== */
(function () {
  var code = document.getElementById("ideCode");
  if (!code) return;
  var tab = document.getElementById("ideTab");
  var crumb = document.getElementById("ideCrumb");
  var lang = document.getElementById("ideLang");
  var loc = document.getElementById("ideLoc");

  var FILES = {
    "index.ts": {
      icon: "fi-ts", lang: "TypeScript",
      crumb: "src › index.ts › replaceJupyternautWithCalliope()",
      lines: [
        '<span class="tk">import</span> {',
        "  JupyterFrontEnd,",
        "  JupyterFrontEndPlugin",
        '} <span class="tk">from</span> <span class="ts">\'@jupyterlab/application\'</span>;',
        '<span class="tk">import</span> { IThemeManager, NotificationManager } <span class="tk">from</span> <span class="ts">\'@jupyterlab/apputils\'</span>;',
        '<span class="tk">import</span> { ISettingRegistry } <span class="tk">from</span> <span class="ts">\'@jupyterlab/settingregistry\'</span>;',
        "",
        '<span class="tc">/**</span>',
        '<span class="tc"> * Function to replace "Jupyternaut" with "Calliope" in markdown</span>',
        '<span class="tc"> */</span>',
        '<span class="tk">function</span> <span class="tf">replaceJupyternautWithCalliope</span>() {',
        '  <span class="tk">const</span> paragraphs = <span class="tpl">document</span>.<span class="tf">querySelectorAll</span>(',
        '    <span class="ts">\'.lm-Widget.jp-RenderedHTMLCommon.jp-RenderedMarkdown>p\'</span>',
        "  );",
        "",
        '  paragraphs.<span class="tf">forEach</span>(p => {',
        '    <span class="tk">if</span> (p.<span class="tprop">textContent</span> &amp;&amp; p.<span class="tprop">textContent</span>.<span class="tf">includes</span>(<span class="ts">\'Jupyternaut\'</span>)) {',
        '      p.<span class="tprop">textContent</span> = p.<span class="tprop">textContent</span>.<span class="tf">replace</span>(<span class="ts">/Jupyternaut/g</span>, <span class="ts">\'Calliope\'</span>);',
        "    }",
        "  });",
        "}"
      ]
    },
    "package.json": {
      icon: "fi-js", lang: "JSON", crumb: "pergamon › package.json",
      lines: [
        "{",
        '  <span class="tprop">"name"</span>: <span class="ts">"pergamon_theme"</span>,',
        '  <span class="tprop">"version"</span>: <span class="ts">"0.1.0"</span>,',
        '  <span class="tprop">"description"</span>: <span class="ts">"Pergamon Theme Extension."</span>,',
        '  <span class="tprop">"keywords"</span>: [<span class="ts">"jupyter"</span>, <span class="ts">"jupyterlab"</span>, <span class="ts">"calliope"</span>],',
        '  <span class="tprop">"license"</span>: <span class="ts">"BSD-3-Clause"</span>,',
        '  <span class="tprop">"scripts"</span>: {',
        '    <span class="tprop">"build"</span>: <span class="ts">"jlpm build:lib"</span>,',
        '    <span class="tprop">"watch"</span>: <span class="ts">"run-p watch:src watch:labextension"</span>',
        "  },",
        '  <span class="tprop">"dependencies"</span>: {',
        '    <span class="tprop">"@jupyterlab/application"</span>: <span class="ts">"^4.0.0"</span>,',
        '    <span class="tprop">"@jupyterlab/apputils"</span>: <span class="ts">"^4.0.0"</span>',
        "  }",
        "}"
      ]
    },
    "README.md": {
      icon: "fi-md", lang: "Markdown", crumb: "pergamon › README.md",
      lines: [
        '<span class="tt"># Pergamon Theme</span>',
        "",
        'A clean JupyterLab theme, governed by <span class="tk">**Calliope**</span>.',
        "",
        '<span class="tt">## Features</span>',
        '<span class="tf">-</span> Light &amp; dark modes',
        '<span class="tf">-</span> Calliope AI Agent integration',
        '<span class="tf">-</span> One-click deploy to your own cloud',
        "",
        '<span class="tt">## Install</span>',
        '<span class="tc">```bash</span>',
        "pip install pergamon-theme",
        '<span class="tc">```</span>'
      ]
    },
    "tsconfig.json": {
      icon: "fi-ts", lang: "JSON", crumb: "pergamon › tsconfig.json",
      lines: [
        "{",
        '  <span class="tprop">"compilerOptions"</span>: {',
        '    <span class="tprop">"target"</span>: <span class="ts">"ES2018"</span>,',
        '    <span class="tprop">"module"</span>: <span class="ts">"esnext"</span>,',
        '    <span class="tprop">"moduleResolution"</span>: <span class="ts">"node"</span>,',
        '    <span class="tprop">"jsx"</span>: <span class="ts">"react"</span>,',
        '    <span class="tprop">"strict"</span>: <span class="tk">true</span>,',
        '    <span class="tprop">"declaration"</span>: <span class="tk">true</span>,',
        '    <span class="tprop">"outDir"</span>: <span class="ts">"lib"</span>,',
        '    <span class="tprop">"rootDir"</span>: <span class="ts">"src"</span>',
        "  },",
        '  <span class="tprop">"include"</span>: [<span class="ts">"src/*"</span>]',
        "}"
      ]
    },
    "CHANGELOG.md": {
      icon: "fi-md", lang: "Markdown", crumb: "pergamon › CHANGELOG.md",
      lines: [
        '<span class="tt"># Changelog</span>',
        "",
        '<span class="tt">## 0.1.0</span>',
        '<span class="tf">-</span> Initial Pergamon theme release',
        '<span class="tf">-</span> Rebranded Jupyternaut → Calliope',
        '<span class="tf">-</span> Added Calliope AI Agent panel'
      ]
    }
  };

  function render(name) {
    var f = FILES[name];
    if (!f) return;
    var html = "";
    for (var i = 0; i < f.lines.length; i++) {
      html += '<div class="cl"><span class="lnum">' + (i + 1) + '</span><span class="ltext">' + (f.lines[i] || "&nbsp;") + "</span></div>";
    }
    code.innerHTML = html;
    if (tab) tab.innerHTML = '<span class="fi ' + f.icon + '">' + (f.icon === "fi-ts" ? "TS" : f.icon === "fi-js" ? "{}" : "M↓") + "</span> " + name + ' <span class="tab-x">×</span>';
    if (crumb) crumb.textContent = f.crumb;
    if (lang) lang.textContent = f.lang;
    if (loc) loc.textContent = "Ln 1, Col 1";
  }

  document.querySelectorAll(".ide-tree .file").forEach(function (btn) {
    btn.addEventListener("click", function () {
      document.querySelectorAll(".ide-tree .file").forEach(function (b) { b.classList.remove("is-active"); });
      btn.classList.add("is-active");
      render(btn.getAttribute("data-file"));
    });
  });
  render("index.ts");

  /* dropdown pills cycle */
  var CYCLES = {
    mode: ["💬 Chat ⌄", "⚡ Agent ⌄", "🔍 Ask ⌄"],
    model: ["Claude Sonnet 4.5 ⌄", "Claude Opus 4.1 ⌄", "Claude Haiku 4.5 ⌄", "Gemini 2.5 Pro ⌄", "GPT-5 ⌄"]
  };
  document.querySelectorAll(".agent-pill[data-cycle]").forEach(function (pill) {
    var key = pill.getAttribute("data-cycle"), idx = 0;
    pill.addEventListener("click", function () {
      idx = (idx + 1) % CYCLES[key].length;
      pill.textContent = CYCLES[key][idx];
    });
  });

  /* agent chat */
  var form = document.getElementById("agentForm");
  var field = document.getElementById("agentField");
  var body = document.getElementById("agentBody");
  var REPLIES = [
    "Good question. I traced it through the codebase — the rename runs on every Markdown render, so it stays consistent across notebooks. Want me to add a unit test?",
    "Done. I mapped the dependency graph for this module — no circular imports, and every call is policy-checked. Shall I generate a sequence diagram?",
    "I scanned the repo: 3 files reference this symbol. I can refactor all of them in one commit, fully logged for audit. Proceed?",
    "Here's the gist: it replaces 'Jupyternaut' with 'Calliope' in rendered output. I can extend it to cover tooltips and menus too."
  ];
  var rIdx = 0;
  function add(cls, html) {
    var d = document.createElement("div");
    d.className = "msg " + cls;
    d.innerHTML = html;
    body.appendChild(d);
    body.scrollTop = body.scrollHeight;
    return d;
  }
  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      var q = (field.value || "").trim();
      if (!q) return;
      add("msg-user", q.replace(/</g, "&lt;"));
      field.value = "";
      var typing = add("msg-bot", '<span class="typing"><i></i><i></i><i></i></span>');
      setTimeout(function () {
        typing.innerHTML = REPLIES[rIdx % REPLIES.length];
        rIdx++;
        body.scrollTop = body.scrollHeight;
      }, 900);
    });
  }
})();

/* ===== Smooth scroll reveal (fade + slide, both directions) ===== */
(function () {
  if (window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
  if (!("IntersectionObserver" in window)) return;

  var SEL = [
    ".section-eyebrow", ".section-title", ".section-lead", ".cta-sub",
    ".proof-item", ".feature", ".bento-card", ".step", ".govern-item",
    ".tcard", ".plan", ".tf-step", ".show-row", ".logo-chip", ".target",
    ".deploy-copy", ".deploy-targets", ".teamflow-visual", ".valley-line",
    ".blueprint-inner", ".footer-top", ".cta-final .lead-inline"
  ].join(",");

  var els = Array.prototype.slice.call(document.querySelectorAll(SEL));
  // skip anything inside the hero (it has its own intro)
  els = els.filter(function (el) { return !el.closest(".hero"); });

  // stagger siblings that share a parent
  var seen = new Map();
  els.forEach(function (el) {
    el.classList.add("reveal");
    var p = el.parentElement;
    var i = seen.get(p) || 0;
    if (i) el.style.transitionDelay = Math.min(i * 70, 350) + "ms";
    seen.set(p, i + 1);
  });

  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (e) {
      if (e.isIntersecting) e.target.classList.add("in");
      else e.target.classList.remove("in");
    });
  }, { threshold: 0.12, rootMargin: "0px 0px -8% 0px" });

  els.forEach(function (el) { io.observe(el); });
})();

/* ===== Screenshot lightbox / gallery ===== */
(function () {
  var lb = document.getElementById("lightbox");
  if (!lb) return;
  var lbImg = document.getElementById("lbImg");
  var lbCap = document.getElementById("lbCap");
  var lbCounter = document.getElementById("lbCounter");
  var shots = Array.prototype.slice.call(document.querySelectorAll(".bento-shot"));
  if (!shots.length) return;

  var items = shots.map(function (s) {
    var img = s.querySelector("img");
    return { src: img.getAttribute("src"), alt: img.getAttribute("alt") || "" };
  });
  var idx = 0;

  function show(i) {
    idx = (i + items.length) % items.length;
    lbImg.src = items[idx].src;
    lbImg.alt = items[idx].alt;
    lbCap.textContent = items[idx].alt;
    lbCounter.textContent = (idx + 1) + " / " + items.length;
  }
  function open(i) {
    show(i);
    lb.hidden = false;
    void lb.offsetWidth;
    lb.classList.add("open");
    document.addEventListener("keydown", onKey);
  }
  function close() {
    lb.classList.remove("open");
    document.removeEventListener("keydown", onKey);
    setTimeout(function () { lb.hidden = true; lbImg.src = ""; }, 200);
  }
  function onKey(e) {
    if (e.key === "Escape") close();
    else if (e.key === "ArrowRight") show(idx + 1);
    else if (e.key === "ArrowLeft") show(idx - 1);
  }

  shots.forEach(function (s, i) {
    s.setAttribute("role", "button");
    s.setAttribute("tabindex", "0");
    s.addEventListener("click", function () { open(i); });
    s.addEventListener("keydown", function (e) {
      if (e.key === "Enter" || e.key === " ") { e.preventDefault(); open(i); }
    });
  });

  document.getElementById("lbClose").addEventListener("click", close);
  document.getElementById("lbPrev").addEventListener("click", function () { show(idx - 1); });
  document.getElementById("lbNext").addEventListener("click", function () { show(idx + 1); });
  lb.addEventListener("click", function (e) {
    if (e.target === lb) close();           // click backdrop closes
  });
})();

/* ===== Animated code field behind .split--figure Calliope figures (.split-ascii) ===== */
(function () {
  var reduce = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var glyphs = "CALLIOPEai01<>/\\*=+-#·".split("");
  [].forEach.call(document.querySelectorAll(".split-ascii"), function (cv) {
    if (!cv.getContext) return;
    var ctx = cv.getContext("2d");
    var STEP = 13, CW, CH, cols, rows, t = 0;
    function size() {
      CW = cv.clientWidth; CH = cv.clientHeight;
      cv.width = CW; cv.height = CH;
      cols = Math.ceil(CW / STEP); rows = Math.ceil(CH / STEP);
      ctx.font = STEP + "px ui-monospace, SFMono-Regular, Menlo, monospace";
      ctx.textBaseline = "top";
    }
    window.addEventListener("resize", size);
    function frame() {
      if (!CW || cv.clientWidth !== CW) size();
      if (!CW) { requestAnimationFrame(frame); return; }
      t++;
      ctx.clearRect(0, 0, CW, CH);
      for (var r = 0; r < rows; r++) {
        var yy = r / rows, dens = 0.28 + 0.72 * yy;
        for (var c = 0; c < cols; c++) {
          var fl = 0.5 + 0.5 * Math.sin(t * 0.022 - r * 0.55 + c * 0.32);
          var on = fl * dens;
          if (on < 0.1) continue;
          ctx.globalAlpha = Math.min(0.72, on);
          ctx.fillStyle = (fl > 0.9 && yy > 0.55) ? "rgba(63,241,239,.95)" : "rgb(122,131,156)";
          ctx.fillText(glyphs[(r * cols + c + (t >> 4)) % glyphs.length], c * STEP, r * STEP);
        }
      }
      if (!reduce) requestAnimationFrame(frame);
    }
    frame();
  });
})();
