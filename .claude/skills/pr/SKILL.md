---
name: pr
description: gh-wrapper for the PR lifecycle on this repo — open a PROCESS.md-compliant PR (preflight gate + body template + reviewer notes), check CI output and diagnose failures, and address PR review feedback. Use when opening a PR, when CI is red, or when responding to review comments. Multi-agent (mirrored at .codex/skills/pr/).
---

# /pr — PR lifecycle helper (gh wrapper)

Wraps `gh` for the three things PRs need on this repo. `main` is protected: **PR required, CI check `ci` must pass, 0 approvals** — a PR merges as soon as CI is green. Policy lives in [`PROCESS.md`](../../../PROCESS.md) §3; this skill is the operational runbook that enforces it.

**Usage:** `/pr open [#issue] [@reviewer…]` · `/pr checks [#PR]` · `/pr feedback [#PR]`
(Default `#PR` = the PR for the current branch: `gh pr view --json number -q .number`.)

Always operate as the **CONFLICT identity** for this org (ConflictHQ → `ragelink` / `@weareconflict.com`). Never a personal/cross-org identity, never add `Co-Authored-By`/AI-attribution to commits or PR bodies.

---

## `/pr open` — open a well-formed PR

**Preflight — block on any failure, fix before opening:**

1. On a feature branch, not `main` (`feature/<area>-<short>`, `fix/…`, `chore/…`; reference the issue when one exists).
2. Identity + attribution on this branch's commits:
   ```bash
   git log origin/main..HEAD --format='%h %ae %s' | grep -v '@weareconflict.com ' && echo "STOP: non-CONFLICT author — fix git config (no amend/rebase; PROCESS.md §8)"
   git log origin/main..HEAD --format=%B | grep -qiE 'co-?authored-by:' && echo "STOP: remove Co-Authored-By"
   ```
3. Clean tree (commit outstanding work).
4. **Run the exact gate CI runs — green locally first:**
   ```bash
   make ci-checks portal-verify
   ```
   `portal-generated-clean` failing → `make portal-generate` and commit the regenerated outputs (let the generator own counts; never hand-edit). Submodule SHA unreachable → push the submodule first (PROCESS.md §5): `( cd wiki && git push )`.

**Compose + create:**
- Issue: from the `#issue` arg, else the branch name (`…-<issue#>-…`) or a commit `Refs:`/`Closes:`; if none and the change is non-trivial, ask whether to file one.
- Title: conventional, imperative, < 70 chars — `<type>(<scope>): <summary>`.
- Body — fill this template (explain WHY, be specific):
  ```markdown
  ## Summary
  <1–3 sentences: what & why>

  ## Changes
  - <key change>

  ## Test plan
  - <how verified: commands run / what was checked>

  Refs: #<issue>      <!-- or "Closes: #<issue>" -->
  ```
- ```bash
  git push -u origin "$(git branch --show-current)"
  gh pr create --base main --title "<title>" --body "<body>"
  ```
- **Notes:** tag reviewers by GitHub **login** (not display name) in a comment so they're notified: `gh pr comment <#> --body "@<login> …"`. Report the URL; note it merges once `ci` is green (no approval needed).

## `/pr checks` — check CI output + diagnose

```bash
gh pr checks <#>                                   # pass/fail per check
gh pr view <#> --json mergeable,mergeStateStatus -q '{mergeable,state:.mergeStateStatus}'
```
If `ci` is failing, open the run and read only the failed step:
```bash
rid=$(gh run list --branch "$(gh pr view <#> --json headRefName -q .headRefName)" --workflow CI -L1 --json databaseId -q '.[0].databaseId')
gh run view "$rid" --log-failed | grep -iE 'error|fail|dirty|traceback' | head
```
**Common failures → fix:**
- *"generated portal outputs are dirty"* → `make portal-generate`, commit the four PORTAL_GENERATED files, push. (Ensure `wiki` is checked out at the pinned SHA first.)
- *submodule SHA not reachable* → push the submodule, repoint, push.
- *Co-Authored-By / non-CONFLICT author* → only on **new** commits (published history isn't rewritten); fix config + recommit going forward.
- *merge conflict / DIRTY* → `git merge origin/main` (no rebase), resolve, push.

## `/pr feedback` — address review comments

```bash
gh pr view <#> --comments                                          # issue-level comments
gh api repos/ConflictHQ/das-tech/pulls/<#>/reviews                 # review summaries
gh api repos/ConflictHQ/das-tech/pulls/<#>/comments                # inline review threads (path+line)
```
For each comment: summarize the ask, implement the change on the branch, then commit + push. Reply on the thread (`gh pr comment <#> --body "…"` or the review-comment reply API) noting what you did. Re-run `/pr checks` until green. Keep replies concise and specific; don't mark resolved what you didn't actually address.

---

## Conventions (see PROCESS.md §2/§3/§8, bootstrap.md §5)
- PR required + `ci` green + **no approval** to merge (branch protection). No force-push to `main`, no rebases.
- Every PR: linked issue (when one exists), what/why description, test plan. No AI/co-author attribution. Conventional title.
