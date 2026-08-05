/* ──────────────────────────────────────────────────────────────────────────
   KBRender — shared rich-markdown renderer.

   One module every markdown surface uses so they all render the same:
   tables, GFM task lists, footnotes, fenced-code syntax highlighting (highlight.js),
   GitHub-style callouts ([!NOTE]/[!TIP]/[!IMPORTANT]/[!WARNING]/[!CAUTION]),
   Mermaid diagrams (theme-aware, re-run safe), and responsive image / iframe
   embeds — all from a safe subset of HTML (untrusted raw HTML is escaped).

   Adopted from the client-portal-kg template (see issue #20). Footnotes require
   the marked-footnote extension to be registered on the page (marked.use(...)).

   Dependencies (load order does not matter; KBRender degrades if absent):
     - marked          (required)   — https://cdn.jsdelivr.net/npm/marked/marked.min.js
     - mermaid@11       (optional)   — diagrams; else ```mermaid stays a code block
     - highlight.js     (optional)   — lazy-loaded from CDN on first code block
   Styles live in app/render.css (link it on the page). The rendered container
   gets class `.md`.

   API (see bottom of file):
     KBRender.render(markdown, targetEl, opts?) -> targetEl   (full render)
     KBRender.parse(markdown, opts?)            -> html string (no enhancements)
     KBRender.enhance(scopeEl)                  -> applies highlight + mermaid to a subtree
     KBRender.renderMermaid(scopeEl)            -> (re)render mermaid in a subtree
     KBRender.highlight(scopeEl)                -> syntax-highlight code in a subtree
     KBRender.refreshTheme()                    -> re-theme mermaid for current data-theme
   ────────────────────────────────────────────────────────────────────────── */
(function () {
  'use strict';

  var HLJS_CSS = 'https://cdn.jsdelivr.net/npm/highlight.js@11/styles/github-dark.min.css';
  var HLJS_JS  = 'https://cdn.jsdelivr.net/npm/highlight.js@11/lib/common.min.js';

  // ── HTML escaping ──────────────────────────────────────────────────────────
  function esc(s) {
    return String(s == null ? '' : s).replace(/[&<>"']/g, function (c) {
      return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[c];
    });
  }

  // ── Theme detection ──────────────────────────────────────────────────────────
  function currentTheme() {
    var t = document.documentElement.dataset.theme;
    return t === 'light' ? 'light' : 'dark';
  }

  // ── Mermaid ──────────────────────────────────────────────────────────────────
  var mermaidInit = false;
  var mermaidTheme = null;     // theme mermaid was last initialized with
  var mermaidSeq = 0;

  // Pull a few palette values off a probe element so diagrams match the page.
  function mermaidThemeVars() {
    var cs = getComputedStyle(document.documentElement);
    function v(name, fallback) {
      var x = cs.getPropertyValue(name).trim();
      return x || fallback;
    }
    return {
      primaryColor:       v('--surface2', '#222'),
      primaryTextColor:   v('--text', '#fff'),
      primaryBorderColor: v('--border2', '#444'),
      lineColor:          v('--muted', '#999'),
      secondaryColor:     v('--surface', '#1a1a1a'),
      tertiaryColor:      v('--surface', '#1a1a1a'),
      fontFamily:         v('--kb-font-body', 'sans-serif')
    };
  }

  function initMermaid(force) {
    if (!window.mermaid) return false;
    var theme = currentTheme();
    if (mermaidInit && mermaidTheme === theme && !force) return true;
    try {
      window.mermaid.initialize({
        startOnLoad: false,
        securityLevel: 'strict',           // no click-bound JS / raw HTML in labels
        theme: theme === 'light' ? 'default' : 'dark',
        themeVariables: mermaidThemeVars(),
        flowchart: { useMaxWidth: true, htmlLabels: false }
      });
      mermaidInit = true;
      mermaidTheme = theme;
      return true;
    } catch (e) { return false; }
  }

  // Render every ```mermaid block within `scope` into an SVG. Re-run safe: a
  // block already rendered (data-processed) is skipped, and a re-clone of an
  // un-rendered source (the pagination case) is picked up fresh each call.
  function renderMermaid(scope) {
    if (!scope || !initMermaid()) return;
    var sources = scope.querySelectorAll('code.language-mermaid, pre > code.language-mermaid');
    var divs = [];
    sources.forEach(function (code) {
      var pre = code.closest('pre') || code;
      var div = document.createElement('div');
      div.className = 'mermaid';
      div.id = 'kb-mmd-' + (mermaidSeq++);
      div.textContent = code.textContent;
      pre.replaceWith(div);
      divs.push(div);
    });
    // Also pick up any .mermaid divs that haven't been processed yet.
    scope.querySelectorAll('div.mermaid:not([data-processed])').forEach(function (d) {
      if (divs.indexOf(d) === -1) divs.push(d);
    });
    if (!divs.length) return;
    try {
      var p = window.mermaid.run({ nodes: divs });
      if (p && p.catch) p.catch(function () { markMermaidFailed(divs); });
    } catch (e) { markMermaidFailed(divs); }
  }

  function markMermaidFailed(divs) {
    divs.forEach(function (d) {
      if (!d.querySelector('svg')) d.setAttribute('data-failed', '');
    });
  }

  // ── highlight.js (lazy) ───────────────────────────────────────────────────────
  var hljsLoading = null;
  function ensureHljs() {
    if (window.hljs) return Promise.resolve(window.hljs);
    if (hljsLoading) return hljsLoading;
    hljsLoading = new Promise(function (resolve) {
      if (!document.querySelector('link[data-kb-hljs]')) {
        var link = document.createElement('link');
        link.rel = 'stylesheet'; link.href = HLJS_CSS; link.setAttribute('data-kb-hljs', '');
        document.head.appendChild(link);
      }
      var s = document.createElement('script');
      s.src = HLJS_JS;
      s.onload = function () { resolve(window.hljs || null); };
      s.onerror = function () { resolve(null); };
      document.head.appendChild(s);
    });
    return hljsLoading;
  }

  function highlight(scope) {
    if (!scope) return;
    var blocks = scope.querySelectorAll('pre > code[class*="language-"]:not(.language-mermaid):not([data-hl])');
    if (!blocks.length) return;
    ensureHljs().then(function (hljs) {
      if (!hljs) return;
      blocks.forEach(function (code) {
        if (code.getAttribute('data-hl')) return;
        try { hljs.highlightElement(code); } catch (e) { /* leave plain */ }
        code.setAttribute('data-hl', '1');
      });
    });
  }

  // ── marked configuration ──────────────────────────────────────────────────────
  var configured = false;
  function configure() {
    if (configured || !window.marked) return;
    window.marked.setOptions({
      gfm: true,
      breaks: false,
      headerIds: true,
      mangle: false
    });
    configured = true;
  }

  // ── Callout / admonition transform ───────────────────────────────────────────
  // Rewrites GitHub-style admonition blockquotes in the rendered DOM:
  //   > [!NOTE]
  //   > body…
  // into a styled .callout box. Operates on <blockquote> elements after parse so
  // it composes with marked's blockquote handling and stays sanitization-safe.
  var CALLOUTS = {
    NOTE:      { cls: 'callout-note',      ico: 'ⓘ', label: 'Note' },
    TIP:       { cls: 'callout-tip',       ico: '✓', label: 'Tip' },
    IMPORTANT: { cls: 'callout-important', ico: '★', label: 'Important' },
    WARNING:   { cls: 'callout-warning',   ico: '⚠', label: 'Warning' },
    CAUTION:   { cls: 'callout-caution',   ico: '⚠', label: 'Caution' }
  };
  var CALLOUT_RE = /^\s*\[!(NOTE|TIP|IMPORTANT|WARNING|CAUTION)\]\s*(.*)$/i;

  function transformCallouts(scope) {
    scope.querySelectorAll('blockquote').forEach(function (bq) {
      var first = bq.querySelector('p');
      if (!first) return;
      // The marker lives at the very start of the first paragraph's text.
      var firstText = first.textContent || '';
      var m = CALLOUT_RE.exec(firstText.split('\n')[0]);
      if (!m) return;
      var kind = CALLOUTS[m[1].toUpperCase()];
      if (!kind) return;

      // Strip the marker line from the first paragraph. If a title followed the
      // marker on the same line, keep it as the heading instead of the default.
      var customTitle = (m[2] || '').trim();
      var rest = firstText.replace(CALLOUT_RE, '').replace(/^\n/, '');
      if (rest.trim()) first.textContent = rest; else first.remove();

      var box = document.createElement('div');
      box.className = 'callout ' + kind.cls;
      var title = document.createElement('div');
      title.className = 'callout-title';
      title.innerHTML = '<span class="callout-ico">' + esc(kind.ico) + '</span>' +
        '<span>' + esc(customTitle || kind.label) + '</span>';
      var body = document.createElement('div');
      body.className = 'callout-body';
      while (bq.firstChild) body.appendChild(bq.firstChild);
      box.appendChild(title);
      box.appendChild(body);
      bq.replaceWith(box);
    });
  }

  // ── Embed transform ───────────────────────────────────────────────────────────
  // Safe convention for external diagrams: an autolink/explicit link whose href
  // ends in a known iframe-able pattern, written on its own line, becomes a
  // responsive iframe. Everything else stays a normal link. Only https URLs from
  // an allowlist of hosts are framed; others are left as links (no injection).
  var EMBED_HOSTS = [
    'www.youtube.com', 'youtube.com', 'youtube-nocookie.com',
    'player.vimeo.com', 'docs.google.com', 'drive.google.com',
    'miro.com', 'app.diagrams.net', 'viewer.diagrams.net', 'whimsical.com',
    'lucid.app', 'figma.com', 'www.figma.com'
  ];
  function isEmbeddable(url) {
    try {
      var u = new URL(url);
      if (u.protocol !== 'https:') return false;
      return EMBED_HOSTS.indexOf(u.hostname) !== -1;
    } catch (e) { return false; }
  }
  function transformEmbeds(scope) {
    // A paragraph that is exactly one anchor whose href is an embeddable URL
    // and whose link text is "embed:" (explicit opt-in) becomes an iframe.
    scope.querySelectorAll('p > a').forEach(function (a) {
      var p = a.parentNode;
      if (p.childNodes.length !== 1) return;
      var href = a.getAttribute('href') || '';
      var label = (a.textContent || '').trim().toLowerCase();
      if (label !== 'embed' && label !== 'embed:') return;
      if (!isEmbeddable(href)) return;
      var wrap = document.createElement('div');
      wrap.className = 'kb-embed';
      var iframe = document.createElement('iframe');
      iframe.src = href;
      iframe.loading = 'lazy';
      iframe.setAttribute('allowfullscreen', '');
      iframe.setAttribute('referrerpolicy', 'no-referrer');
      iframe.setAttribute('sandbox', 'allow-scripts allow-same-origin allow-popups allow-forms allow-presentation');
      wrap.appendChild(iframe);
      p.replaceWith(wrap);
    });
  }

  // ── Sanitize: strip dangerous nodes/attrs from the rendered subset ────────────
  // marked does not execute scripts, but untrusted markdown can contain raw HTML.
  // We allow a safe subset by removing <script>/<style>/<iframe>/<object> (except
  // our own .kb-embed iframes built above), event handler attributes, and
  // javascript: URLs. Run BEFORE the embed/callout transforms add trusted nodes.
  var BANNED_TAGS = ['SCRIPT', 'STYLE', 'IFRAME', 'OBJECT', 'EMBED', 'LINK', 'META', 'BASE', 'FORM'];
  function sanitize(scope) {
    BANNED_TAGS.forEach(function (tag) {
      scope.querySelectorAll(tag.toLowerCase()).forEach(function (n) { n.remove(); });
    });
    var all = scope.querySelectorAll('*');
    all.forEach(function (el) {
      for (var i = el.attributes.length - 1; i >= 0; i--) {
        var attr = el.attributes[i];
        var name = attr.name.toLowerCase();
        var val = attr.value || '';
        if (name.indexOf('on') === 0) { el.removeAttribute(attr.name); continue; }
        if ((name === 'href' || name === 'src' || name === 'xlink:href') &&
            /^\s*javascript:/i.test(val)) {
          el.removeAttribute(attr.name);
        }
      }
    });
  }

  // ── Public render pipeline ────────────────────────────────────────────────────
  function parse(markdown, opts) {
    configure();
    if (!window.marked) return esc(markdown);
    return window.marked.parse(String(markdown == null ? '' : markdown), opts || {});
  }

  // Annotate fenced blocks with a language tag for the CSS label, and ensure the
  // standard language-* class shape highlight.js expects.
  function tagCodeBlocks(scope) {
    scope.querySelectorAll('pre > code[class*="language-"]').forEach(function (code) {
      var m = /language-([\w+-]+)/.exec(code.className);
      if (m && m[1] && m[1] !== 'mermaid') {
        code.closest('pre').setAttribute('data-lang', m[1]);
      }
    });
  }

  // Turn inline-code repo paths (e.g. `wiki/Privacy-by-Design.md`,
  // `docs/consent-pii-erasure-options.md`, `memory/decisions.md#d-12`) into
  // clickable links that open the target in the reader. One renderer change makes
  // every doc/story cross-referenced and navigable — no per-file link editing.
  // An optional #fragment is preserved (the reader scrolls to it when present).
  var DOC_PATH_RE = /^((?:docs|wiki|specs|memory|app|analysis|artifacts|knowledge|reference)\/[\w./-]+\.(?:md|json))(#[\w:=.\-]+)?$/;
  function linkifyDocPaths(scope) {
    scope.querySelectorAll('code').forEach(function (code) {
      if (code.closest('pre') || code.closest('a')) return; // skip code blocks + already-linked
      var t = (code.textContent || '').trim();
      var m = DOC_PATH_RE.exec(t);
      if (!m) return;
      var a = document.createElement('a');
      a.className = 'doc-xref';
      a.setAttribute('href', '/docs/reader.html?f=' + m[1] + (m[2] || ''));
      a.title = 'Open ' + m[1] + ' in the reader';
      var c = document.createElement('code');
      c.textContent = t;
      a.appendChild(c);
      code.replaceWith(a);
    });
  }

  // Apply every enhancement to an already-parsed subtree (used by render and by
  // paginated re-renders that clone parsed HTML into the page).
  function enhance(scope) {
    if (!scope) return scope;
    sanitize(scope);
    linkifyDocPaths(scope);
    transformCallouts(scope);
    transformEmbeds(scope);
    tagCodeBlocks(scope);
    renderMermaid(scope);
    highlight(scope);
    return scope;
  }

  // Full render: parse markdown → inject into target (with .md class) → enhance.
  function render(markdown, targetEl, opts) {
    if (!targetEl) return targetEl;
    targetEl.classList.add('md');
    targetEl.innerHTML = parse(markdown, opts);
    enhance(targetEl);
    return targetEl;
  }

  // Re-theme mermaid for the current data-theme and re-render existing diagrams.
  // Mermaid bakes colors into the SVG at render time, so a theme flip needs a
  // re-run from the original source. We keep source on a data attribute.
  function refreshTheme(scope) {
    scope = scope || document;
    initMermaid(true);
    scope.querySelectorAll('div.mermaid[data-processed]').forEach(function (d) {
      var src = d.getAttribute('data-kb-src');
      if (src == null) return;
      d.removeAttribute('data-processed');
      d.removeAttribute('data-failed');
      d.innerHTML = '';
      d.textContent = src;
    });
    renderMermaid(scope);
  }

  // Stash mermaid source before run so refreshTheme can re-render after a flip.
  var _origRenderMermaid = renderMermaid;
  renderMermaid = function (scope) {
    if (scope) {
      scope.querySelectorAll('div.mermaid:not([data-kb-src])').forEach(function (d) {
        d.setAttribute('data-kb-src', d.textContent);
      });
    }
    return _origRenderMermaid(scope);
  };

  // Re-theme diagrams automatically when the theme toggles.
  if (window.MutationObserver) {
    new MutationObserver(function (muts) {
      for (var i = 0; i < muts.length; i++) {
        if (muts[i].attributeName === 'data-theme') { refreshTheme(document); break; }
      }
    }).observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });
  }

  window.KBRender = {
    render: render,
    parse: parse,
    enhance: enhance,
    renderMermaid: renderMermaid,
    highlight: highlight,
    refreshTheme: refreshTheme,
    esc: esc
  };
})();
