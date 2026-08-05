# DAS CDP — Process

> **What this file is.** The branch / commit / PR / release conventions for this engagement. Read alongside `bootstrap.md`.

---

## 1. Branching Model

| Branch | Purpose | Lifetime |
|--------|---------|----------|
| `main` | The truth. Everything releasable lands here. | Permanent |
| `feature/<area>-<short>` | New feature work | Until merged |
| `fix/<area>-<short>` | Bug fix | Until merged |
| `chore/<short>` | Refactors, dep bumps, doc updates | Until merged |

**Rules:**
- **No rebasing.** Ever. New commits only.
- **No force-push to `main`.** No exceptions.
- **Force-push to your own feature branch is fine** until a review is open.
- **Branch names reference the issue** when one exists: `feature/<area>-<issue#>-<short>`.

---

## 2. Commits

### Format

```
<type>(<scope>): <short summary>

<body — optional, wrap at 100 col, explain WHY>

<footer — optional; "Refs: #123", "Closes: #123">
```

- `<type>` ∈ `feat | fix | chore | docs | refactor | test | perf | build | ci | revert`
- `<scope>` is a submodule or area (`api`, `frontend`, `ingestion`, `identity`, `opscode`, `wiki`)
- **No AI / co-author attribution.** No `Co-Authored-By` lines, ever — applies to commits made by humans and by AI agents alike. If your tooling (Claude Code, Copilot, etc.) appends a `Co-Authored-By` trailer by default, turn it off. Enforced pre-push by `make check-no-ai-attribution`, which scans unpushed commits only.

### What makes a good commit message

- Explain **why**, not **what** — the diff shows what
- Reference the issue: `Refs: #42`
- Short summary under 72 characters; body at 100-character wrap

---

## 3. Pull Requests

`main` is protected: every change lands via a PR, the `ci` check must pass, and direct pushes are rejected. **No approving review is required** — a PR merges once CI is green.

Every PR must have:
- Link to the issue it addresses (when one exists)
- Description: WHAT changed and WHY
- Test plan: how to verify the changes work
- `ci` green — run `make ci-checks portal-verify` locally before pushing

PR title: short, imperative, under 70 characters (conventional `<type>(<scope>): …`).

Use the **`/pr` skill** (`.claude/skills/pr/`, mirrored to `.codex/skills/pr/`) to open PRs with a compliant body, check CI output, and address review feedback.

---

## 4. Issue Lifecycle

```
Backlog → Groomed → In Progress → In Review → Done
```

1. **Backlog** — filed, may be vague
2. **Groomed** — requirements clear, acceptance criteria defined, priority set
3. **In Progress** — branch exists, plan comment posted on issue
4. **In Review** — PR open
5. **Done** — PR merged, CI green, issue closed with summary comment

**What "Done" means:**
- [ ] Code merged to main
- [ ] Tests pass (including new tests)
- [ ] Lint clean
- [ ] CI green
- [ ] Issue has: plan comment, learnings comment, summary comment
- [ ] No TODOs, stubs, or "fix later" in merged code

---

## 5. Submodule Push Order

When a change spans more than one repo (most often the `wiki` submodule):
1. Push submodule(s) first — each submodule commit must be on its remote
2. Commit the metarepo with the new submodule SHAs
3. Push the metarepo

**Never** push a metarepo commit that references a submodule SHA not yet on the remote.

**Why it matters.** A metarepo bump pointing at an unpushed submodule SHA leaves `main` with a *dangling reference*: git cannot fetch that commit, so it breaks `pull`/`merge` for everyone else — the gitlink 3-way merge fails with `commits not present`, and any open PR goes `CONFLICTING`. The fix then requires manually repointing the gitlink at a reachable SHA.

**Safe path:** `make all-push` pushes each submodule, then the metarepo, in the correct order.

**Verify before pushing the metarepo** (the staged submodule SHA must exist on its remote):
```bash
git -C wiki branch -r --contains "$(git rev-parse @:wiki)" >/dev/null 2>&1 \
  && echo "wiki SHA is pushed — OK" || echo "STOP: push the wiki submodule first"
```

**Branch naming is inverted between the code repo and the wiki — do not confuse them:**

| Repo | Primary branch | The other branch | Enforcement |
|------|----------------|------------------|-------------|
| `ConflictHQ/das-tech` (code) | `main` | `master` must never exist | Ruleset `lock-master-branch` (id 17850953): blocks creation/update/deletion of `refs/heads/master`, no bypass |
| `ConflictHQ/das-tech.wiki` | `master` (GitHub serves the wiki only from here) | `main` must never exist | Cannot be branch-protected — GitHub wikis are not addressable by the rulesets API (404). Enforcement is manual: keep only `master`; delete any stray `main`/SHA-named branch |

**Wiki branch — `master` only.** GitHub serves the wiki exclusively from the `master` branch (hardcoded; a `main` or renamed branch makes the wiki *disappear*). Commit wiki changes to `master` — never to `main` or SHA-named branches, which don't render and fork the wiki. The metarepo's `wiki` gitlink must reference a commit on `master`. (We hit this twice: divergent SHA-named wiki branches that omitted reconciled content, and a stale `main` 80 commits behind `master` that stranded a full "second pass" of CDP research — both consolidated back onto `master` and the stray branches deleted, 2026-06-18.)

---

## 6. Quality Gates

| Gate | Enforcement |
|------|-------------|
| Lint | CI, blocks merge |
| Tests | CI, real database, blocks merge |
| Build | CI, blocks merge |
| Review | Not required — PRs merge on green CI (see §3) |
| Commit hygiene | `make ci-checks` (run before every push): no `Co-Authored-By` trailers, `@weareconflict.com` author identity, submodule SHAs resolvable. Scans unpushed commits only — already-published history is never rewritten. |

---

## 7. Coding Non-Negotiables

- Auth check on every endpoint (first line of every resolver / controller)
- Group-based permissions only — never assign directly to users
- Soft deletes only — never hard-delete business objects
- No integer PKs in APIs — UUID or cuid
- Real database in tests — never mock
- Multi-tenant scoping — every query scoped to tenant context; unscoped = bug
- Validate at system boundaries — all input validated at API entry points

---

## 8. Git Identity

Commit with your CONFLICT identity, not a personal account.

- **Author email = your `@weareconflict.com` address.** Set it per-repo (never rely on a global personal default):
  ```bash
  git config user.name  "<Your Name>"
  git config user.email "<you>@weareconflict.com"
  ```
- **Add that email to your GitHub account** so commits attribute to your CONFLICT identity rather than a personal Gmail: https://docs.github.com/en/account-and-profile/how-tos/email-preferences/adding-an-email-address-to-your-github-account
- **Verify before you start:** `git log -1 --format="%ae"` should show your CONFLICT email.
- **Enforced pre-push:** `make check-author-identity` rejects any unpushed commit whose author email is not `@weareconflict.com`.
- Commits already pushed under a personal email are **not** rewritten (no rebases, no force-push to shared `main`) — just fix the config so future commits are correct. The pre-push gate ignores published history by design.
