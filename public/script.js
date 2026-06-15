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
