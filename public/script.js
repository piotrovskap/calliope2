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
    { t: "Governance — Zemtino", h: "Govern", a: "#govern", k: "grc governance policy risk compliance audit observability secrets" },
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
