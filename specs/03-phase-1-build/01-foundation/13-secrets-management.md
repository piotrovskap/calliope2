---
title: "Secrets & key management (+ pepper store)"
type: story
status: planned
priority: high
estimate: M
depends_on: [phase-1-build.foundation.aws-org-iam-identity-center, phase-1-build.foundation.accounts-prod-dev-staging]
labels: [foundation, secrets, security, 1a]
date: ~
---

Provision the managed secrets + key store (Azure Key Vault; AWS Secrets Manager + KMS) as a Foundation primitive, behind a cloud-neutral interface. Holds application secrets, at-rest encryption keys, and — critically — the **external pepper** that the PII-vault salt+pepper hardening and the privacy policy-config layer depend on (the pepper is held outside the database, per-tenant by default, configurable to global). Scoped access by environment and by tier; rotation supported; no plaintext secrets in app config, logs, or images.

**Acceptance:** a secret and an encryption key resolve at runtime from the managed store via the cloud-neutral interface (Key Vault on Azure / Secrets Manager + KMS on AWS) with no plaintext in source, config, or container images; the pepper store is provisioned with per-tenant scoping and a documented rotation procedure; access is environment- and tier-scoped (a dev role cannot read prod secrets); and the erasure saga's pepper-clear and policy-config's pepper reference both resolve against this store.

**References:**
- Decided 2026-06-21 (Leo): external pepper held outside the DB in the secrets manager, per-tenant by default, configurable to global; pepper-clear as coarse kill-switch — `memory/decisions.md#d-012`
- Decided 2026-06-18 (Leo): cloud-agnostic KMS abstraction, not a specific cloud KMS — `memory/decisions.md#d-013`
- Portability principle: KMS/Secrets are AWS-proprietary swap-points (KMS+Secrets Manager → Key Vault) isolated behind interfaces — `memory/decisions.md`
- `docs/cloud-aws-vs-azure-bakeoff.md` · `wiki/Privacy-by-Design.md` — secrets/key store per cloud behind a neutral interface; salt+pepper hardening and pepper scope
- `specs/03-phase-1-build/03-backend-data-model/08-pii-vault-erasure.md` · `specs/03-phase-1-build/03-backend-data-model/18-policy-config-layer.md` — the consumers (pepper-clear, policy-config pepper reference)
