# DAS CDP — Workspace Makefile
#
# Aggregates operations across all submodules.
# Read bootstrap.md and PROCESS.md before adding targets.
#
# Conventions:
# - Targets that aggregate across submodules iterate over $(SUBMODULES).
# - Targets that act on one submodule accept SUB=<slug>.
# - .PHONY unless producing an actual file.
# - On submodule failure, aggregate target halts (set -e in recipes).

SHELL := /usr/bin/env bash
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --no-print-directory --warn-undefined-variables

# ----------------------------------------------------------------------------
# Configuration
# ----------------------------------------------------------------------------

# Submodules in build order (expand as repos are added).
# wiki is knowledge-only; it does not participate in build/test/lint cycles.
SUBMODULES :=
# das-cdp-opscode \
# das-cdp-app \
# das-cdp-dags    (Airflow DAGs — batch ETL per source system, MWAA)

PORTAL_GENERATED := specs/manifest.json specs/estimates.json docs/manifest.json docs/databases.json app/knowledge-pack.json docs/databases/README.md app/knowledge_graph.json docs/databases/schema.json docs/cdp-field-catalog.json app/brain.json
PYTHON_SOURCES := $(wildcard scripts/*.py) specs/_gen.py specs/_new.py

.DEFAULT_GOAL := help

# ----------------------------------------------------------------------------
# Help
# ----------------------------------------------------------------------------

.PHONY: help
help:  ## Show this help.
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | \
	  awk -F ':.*?## ' '{printf "  \033[36m%-28s\033[0m %s\n", $$1, $$2}' | sort

# ----------------------------------------------------------------------------
# Bootstrap & sync
# ----------------------------------------------------------------------------

.PHONY: bootstrap
bootstrap:  ## Initialize submodules to pinned SHAs; print next steps.
	git submodule update --init --recursive
	@echo ""
	@echo "Workspace ready. Submodules:"
	@git submodule status
	@echo ""
	@echo "Next: make all-status"

.PHONY: sync
sync:  ## Pull tip of every submodule (--remote --merge), then prompt to review.
	git fetch --recurse-submodules
	git submodule update --remote --merge
	@echo "Review each submodule diff before staging the metarepo update."
	@for sub in $(SUBMODULES); do \
	  echo "=== $$sub incoming ==="; \
	  ( cd $$sub && git log --oneline HEAD@{1}..HEAD ) || true; \
	done

.PHONY: pin
pin:  ## Force all submodules to the SHAs the metarepo references.
	git submodule update --init --recursive

.PHONY: all-status
all-status:  ## git status for metarepo + each submodule.
	@echo "=== metarepo ==="; git status --short
	@for sub in $(SUBMODULES) wiki; do \
	  echo "=== $$sub ==="; \
	  ( cd $$sub && git status --short ) || true; \
	done

.PHONY: all-push
all-push:  ## Push each submodule first, then the metarepo (PROCESS.md §5).
	@for sub in $(SUBMODULES) wiki; do \
	  echo "==> pushing $$sub"; \
	  ( cd $$sub && git push ) || exit 1; \
	done
	@echo "==> pushing metarepo"
	git push

# ----------------------------------------------------------------------------
# Wiki
# ----------------------------------------------------------------------------

.PHONY: wiki-sync
wiki-sync:  ## Pull latest wiki content from the GitHub wiki remote.
	( cd wiki && git pull ) && echo "Wiki updated."

.PHONY: wiki-push
wiki-push:  ## Push wiki changes, then update the metarepo pointer.
	( cd wiki && git push ) && git add wiki && git commit -m "chore(wiki): update wiki pointer" && git push

# ----------------------------------------------------------------------------
# Aggregate quality (expand as submodules are added)
# ----------------------------------------------------------------------------

.PHONY: all-fmt
all-fmt:  ## Run each submodule's formatter.
	@for sub in $(SUBMODULES); do \
	  echo "==> fmt: $$sub"; \
	  $(MAKE) -C $$sub fmt; \
	done

.PHONY: all-lint
all-lint:  ## Run each submodule's linter.
	@for sub in $(SUBMODULES); do \
	  echo "==> lint: $$sub"; \
	  $(MAKE) -C $$sub lint; \
	done

.PHONY: all-test
all-test:  ## Run each submodule's test suite with real Postgres.
	@for sub in $(SUBMODULES); do \
	  echo "==> test: $$sub"; \
	  $(MAKE) -C $$sub test; \
	done

.PHONY: all-verify
all-verify: all-fmt all-lint all-test  ## fmt + lint + test (CI-equivalent local check).

# ----------------------------------------------------------------------------
# Portal quality gates
# ----------------------------------------------------------------------------

.PHONY: portal-generate
portal-generate:  ## Regenerate committed portal indexes.
	PYTHONDONTWRITEBYTECODE=1 python3 specs/_gen.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-estimates.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-databases.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/parse-ddl.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-field-catalog.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-kg.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-docs-manifest.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-knowledge-pack.py
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/gen-brain.py

.PHONY: portal-json-validate
portal-json-validate:  ## Validate every tracked JSON file parses.
	@while IFS= read -r f; do \
	  python3 -m json.tool "$$f" >/dev/null || exit 1; \
	done < <(git ls-files '*.json')
	@echo "OK: tracked JSON parses"

.PHONY: portal-python-compile
portal-python-compile:  ## Compile portal/support Python scripts without writing pycache.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-python-compile.py $(PYTHON_SOURCES)

.PHONY: portal-schema-check
portal-schema-check:  ## Validate portal tracker JSON contracts.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/validate-portal-data.py

.PHONY: portal-link-check
portal-link-check:  ## Smoke-test key portal links and static asset references.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-portal-links.py

.PHONY: portal-worker-test
portal-worker-test:  ## Run Worker unit tests for /api/chat behavior.
	npm test

.PHONY: portal-site
portal-site:  ## Build the staged Cloudflare assets directory.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/build-portal-site.py

.PHONY: portal-generated-clean
portal-generated-clean:  ## Fail if generated portal outputs are not committed.
	@git diff --quiet --exit-code HEAD -- $(PORTAL_GENERATED) || \
	  (echo "ERROR: generated portal outputs are dirty; run make portal-generate and commit $(PORTAL_GENERATED)"; exit 1)

.PHONY: portal-verify
portal-verify: portal-generate portal-json-validate portal-python-compile portal-schema-check portal-worker-test portal-link-check portal-site portal-generated-clean  ## Full portal verification before deploy.

# ----------------------------------------------------------------------------
# One-submodule operations
# ----------------------------------------------------------------------------

.PHONY: sub-fmt sub-lint sub-test sub-build
sub-fmt sub-lint sub-test sub-build:  ## Run target for a single submodule: make sub-test SUB=das-cdp-app.
	@test -n "$(SUB)" || (echo "usage: make sub-<target> SUB=<submodule>"; exit 2)
	$(MAKE) -C $(SUB) $(subst sub-,,$@)

# ----------------------------------------------------------------------------
# Convention checks
# ----------------------------------------------------------------------------

# Both checks scan a range of commits — locally the UNPUSHED ones (reachable from
# HEAD, not on any remote), so they police what THIS workspace is about to push,
# not already-published history (which PROCESS.md §2/§8 forbid rewriting). CI
# overrides HYGIENE_RANGE with the PR/push range (e.g. <base-sha>..<head-sha>).
# Empty range = nothing to flag.
HYGIENE_RANGE ?= HEAD --not --remotes
.PHONY: check-no-ai-attribution
check-no-ai-attribution:  ## Reject commits in HYGIENE_RANGE with ANY Co-Authored-By trailer (PROCESS.md §2).
	@bad="$$(for h in $$(git rev-list $(HYGIENE_RANGE)); do \
	  if git log -1 --format=%B "$$h" | grep -qiE "co-?authored-by:"; then \
	    git log -1 --format='%h %s' "$$h"; \
	  fi; \
	done)"; \
	if [[ -n "$$bad" ]]; then \
	  echo "ERROR: Co-Authored-By trailer in unpushed commit(s) — remove it before pushing (PROCESS.md §2):"; \
	  echo "$$bad"; \
	  exit 1; \
	fi; \
	echo "OK: no co-author attribution in unpushed commits"

.PHONY: check-author-identity
check-author-identity:  ## Reject commits in HYGIENE_RANGE not authored with a CONFLICT identity (PROCESS.md §8).
	@bad="$$(for h in $$(git rev-list $(HYGIENE_RANGE)); do \
	  ae="$$(git log -1 --format='%ae' "$$h")"; \
	  case "$$ae" in \
	    *@weareconflict.com) ;; \
	    *@users.noreply.github.com) ;; \
	    *) git log -1 --format="%h %s  <$$ae>" "$$h" ;; \
	  esac; \
	done)"; \
	if [[ -n "$$bad" ]]; then \
	  echo "ERROR: commit(s) not authored with a CONFLICT identity (@weareconflict.com, or a GitHub no-reply for squash/merge commits) — fix 'git config user.email' (PROCESS.md §8):"; \
	  echo "$$bad"; \
	  exit 1; \
	fi; \
	echo "OK: unpushed commits authored with a CONFLICT identity"

.PHONY: check-submodule-resolvable
check-submodule-resolvable:  ## Verify each submodule's pinned SHA is reachable on its remote.
	@git submodule foreach 'git fetch -q origin && git branch -r --contains "$$sha1" 2>/dev/null | grep -q . || (echo "ERROR: $$name pinned SHA $$sha1 is not reachable on the remote — push the submodule first"; exit 1)'
	@echo "OK: all submodule pinned SHAs are reachable on their remotes"

.PHONY: check-content-consistency
check-content-consistency:  ## Validate cross-file content claims (README/frontmatter, CSS coverage, open-questions, access tracker).
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-content-consistency.py

.PHONY: check-kg
check-kg:  ## Validate the generated KG: superset of frozen baselines, no untraceable nodes/edges, findings present.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-kg.py

.PHONY: check-brain
check-brain:  ## Validate the compiled brain: every node sourced, edges connect real nodes, counts reconcile.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-brain.py

.PHONY: check-golden-record
check-golden-record:  ## Verifiability gate: record.json conforms to schema.json; refs resolve; every field traced to a real source + justified.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-golden-record.py

.PHONY: check-portal-literals
check-portal-literals:  ## Guard portal counts/versions against their JSON/markdown sources (anti-drift).
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-portal-literals.py

.PHONY: check-no-internal-published
check-no-internal-published:  ## Guard: internal-only files (_internal/) must never reach the published _site.
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/check-no-internal-published.py

.PHONY: brain-db
brain-db:  ## Build the SQLite encoding of the brain (app/brain.db; derived/untracked).
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/brain-sqlite.py build

.PHONY: check-brain-db
check-brain-db:  ## Verify the brain.json <-> brain.db round-trip is lossless (optional; SQLite is opt-in, not yet in use).
	PYTHONDONTWRITEBYTECODE=1 python3 scripts/brain-sqlite.py check

.PHONY: ci-checks
ci-checks: check-no-ai-attribution check-author-identity check-submodule-resolvable check-content-consistency check-kg check-brain check-golden-record check-portal-literals check-no-internal-published  ## Run all convention checks. (SQLite round-trip is optional: run `make check-brain-db` when adopting brain.db.)

# ----------------------------------------------------------------------------
# Cleanup
# ----------------------------------------------------------------------------

.PHONY: clean
clean:  ## Remove build artifacts.
	@for sub in $(SUBMODULES); do \
	  $(MAKE) -C $$sub clean || true; \
	done
