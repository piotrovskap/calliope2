---
name: das-sources-and-access
description: Where everything lives — repo, Drive, Confluence, recordings, KG
metadata:
  type: reference
---

**GitHub:** `github.com/ConflictHQ/das-tech` (private, org: ConflictHQ)
- Wiki submodule: `ConflictHQ/das-tech.wiki` (29 pages)
- Source catalog: `wiki/Sources.md`

**Google Drive Phase 0:** folder `1bdqnzVohVHMWyFQ0zAiz4MLO3cCuyjt9`
- Working Docs: `1lpssXidHWXSzzr-g-XrKQzX9paom0ja7`
- Initial Documentation (DAS specs): `1EId9U9YLkBgpFHIm0IJM2YOweekYzoBG`

**Working sheet — "DAS CDP — Data Source Catalog"** (a Phase 0 deliverable): `1i5F7TSkwYqlVTVjCGJ4igIF1PEBmKws1l1qnzWjCliU`
- Tabs: **Field Matrix** (gid 609072734) + **Source Index** (gid 0). Mirrored in `docs/cdp-field-source-matrix.md` — keep both in sync.
- Read/write via `gws sheets` (personal OAuth: `unset GOOGLE_WORKSPACE_CLI_CREDENTIALS_FILE`): `gws +read --params '{"spreadsheetId":"…","range":"Field Matrix"}'`; write with `gws sheets spreadsheets values update`.
- Meeting Recordings: `1HbfVAlehaACfLFg6qL5wmUEnbUswGhT-`
- Kickoff recording (2026-05-27): `https://drive.google.com/file/d/1-Txw2pqAzDNGEtjZnksvMZFQxPG0HN6e`
- Follow-up discussion recording (2026-03-09): `https://drive.google.com/file/d/11ySLUYoq-wSsP9ARFtrBCRe_kV17D9RE`
- Follow-up discussion notes (Gemini): `https://drive.google.com/file/d/1luPI20ABIfR54ohdVDX79wbJXlM5UC86`
- SSIS Review recording (2026-06-08): `https://drive.google.com/file/d/1DE-GcMlpxGeRDRGF_66IJIfnMKza090q`
- Juice Reporting Review recording (2026-06-08): `https://drive.google.com/file/d/1PrfLjyDIc-Plujka2OCmkL5u9kwOEA4m`

**Slack:** CONFLICT workspace — `SLACK_BOT_TOKEN` in `.env` (gitignored). Same bot token as other CONFLICT repo skills.
- User map: `.claude/skills/das-bot/slack-users.json` — CONFLICT team IDs pre-filled, DAS contacts (Dan/Alex/Mike) need Slack IDs added
- Skill: `/das-bot` — pull/nudge/broadcast

**Confluence:** `digitalairstrike.atlassian.net/wiki/spaces/Technology` (cloudId `7503916e-a51e-4d15-acfe-afc3bc61e0b8`)
- `JIRA_API_TOKEN` in `.env` is a **scoped** `ATATT…` token (named `DAS-data`) owned by `lmata@weareconflict.com`. Scoped tokens **only** work via the `api.atlassian.com` gateway with Basic auth — NOT against `{site}.atlassian.net` (that 401s).
- Working fetch: `curl -u "lmata@weareconflict.com:$JIRA_API_TOKEN" "https://api.atlassian.com/ex/confluence/<cloudId>/wiki/rest/api/content/<page_id>?expand=body.export_view"` → rendered HTML with structure.
- Re-pull all pages with `scripts/repull-confluence.py` (reads `page_id` from each file's frontmatter, `export_view` → pandoc → GFM, preserves frontmatter, sets `repulled:`). Run after `brew install pandoc`.
- `acli` cannot fetch page content (space-level commands only) — do not rely on it.
- 986 total pages, 105 pulled to `artifacts/phase-0/confluence/` (re-pulled with structure 2026-06-09).

**Portal (live site):** `https://das.conflict.media/` — Cloudflare Worker `das-tech` serving this repo as static assets (`wrangler.toml [assets]`), behind **Cloudflare Access** (team domain `cnflct.cloudflareaccess.com`, account CONFLICT LLC `e87eea63be7f065f610560a9d49c82ff`, zone `conflict.media` = `6097a87b031124f1de885879dedf7ce7`). Unauthenticated requests 302 to the Access login; raw curl gets 401 with a `cloudflare-access-protected-resource` challenge. `das-tech.pages.dev` does NOT exist (stale reference). Redirect-loop reports (2026-06-12) — ROOT CAUSE FOUND AND FIXED: the Access app's cookie Same Site Attribute was `Strict`, so `CF_Authorization` was withheld on cross-site navigations (links clicked from Teams/Slack/email), looping app ↔ Access login. Changed to `Lax` 2026-06-12. Access app: "das", id `4aac1be4-bd9c-45ad-8bed-9f5406af71f1`, policy `DAS-Access`, session 1 week. If loops recur, re-check this setting first.

**Cloudflare API creds (locations, not values):** `~/repos/calliope/media.env` `CLOUDFLARE_API_KEY` — valid user token, conflict.media DNS/zone read+edit only. `~/repos/calliope/resonance/backend/local.env` `CLOUDFLARE_API_TOKEN` — valid account-owned token (CONFLICT LLC; fails `/user/tokens/verify` by design, use account endpoints). **Neither has Access (Zero Trust) scope** — reading Access app config/logs needs "Access: Apps and Policies: Read" added in the dashboard. Wrangler OAuth (workers scopes only) also can't.

**Artifacts in repo:**
- `artifacts/phase-0/das-cdp-phase0-proposal-final.md` — signed Phase 0 proposal
- `artifacts/phase-0/source-docs/` — DAS MVP spec v4, Architecture Plan v3
- `artifacts/phase-0/confluence/` — 105 Confluence pages (see `wiki/Sources.md` for index)

**Session analyses** (all under `analysis/sessions/`):
- Kickoff 2026-05-27: `analysis/sessions/kickoff-2026-05-27-deep/` (deep analysis, source of master KG)
- SSIS Review 2026-06-08: `analysis/sessions/ssis-review-2026-06-08/results/analysis.md`
- Juice Reporting Review 2026-06-08: `analysis/sessions/reporting-juice-2026-06-08/results/analysis.md`
- Session synthesis 2026-06-08: `analysis/sessions/session-synthesis-2026-06-08.md`

**Knowledge graph:**
- Generated federation: `app/knowledge_graph.json` (single source; regenerate with `python3 scripts/gen-kg.py`, validate with `scripts/check-kg.py`)
- Merged: kickoff + SSIS review + Juice reporting sessions, per `analysis/sessions/catalog.json` + `analysis/kg-curation.json` overlay
- Viewer: `python3 -m http.server 8080` → `http://localhost:8080/app/`
- Query: `/kg` skill or `planopticon query --db-path app/knowledge_graph.json`
- Add a session: register it in `analysis/sessions/catalog.json`, then `python3 scripts/gen-kg.py`
