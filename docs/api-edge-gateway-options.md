# API Edge Gateway — Options (Kong vs ALB)

**Status: open decision — no pick.** Reopened 2026-06-14. The edge for the CDP API surface (REST + GraphQL + event webhook). The 2026-06-13 stack notes leaned ALB with Kong deferred; this note reopens it so the choice is explicit. Recorded as an open decision in `memory/decisions.md` (API ingress / edge gateway).

## Context

Auth0 JWT is validated first-line in Django regardless of edge. The question is whether the edge is a plain L7 load balancer or a full API gateway. Reusing DAS's own Kong stays off the table (it lives in Azure — cross-cloud).

## Option A — ALB (AWS Application Load Balancer)

Provisioned on EKS via the AWS Load Balancer Controller. Topology: Internet -> Cloudflare DNS -> ALB (TLS via ACM, WAF, optional OIDC offload) -> EKS services (Django REST/GraphQL, event webhook).

- **Pros:** near-zero ops, AWS-native (ACM, WAF, Shield), L7 host/path routing, autoscaling, optional OIDC/Cognito auth offload. Nothing to run or patch.
- **Cons:** it is a load balancer, not an API gateway — no per-consumer API keys, no rate limiting/quotas per consumer, no request/response transformation, no developer portal, only basic auth offload.

## Option B — Kong at the edge (self-hosted on EKS)

Kong Gateway (OSS or Konnect) as the API gateway, sitting behind an AWS NLB/ALB. Topology: Internet -> Cloudflare -> NLB/ALB -> Kong (data plane on EKS) -> EKS services.

- **Pros:** a real gateway — per-consumer API keys + consumer management, rate limiting/quotas, JWT/OAuth2/mTLS, request/response transformation, plugin ecosystem (bot/WAF/observability), developer portal, and a single policy plane across REST + GraphQL + ingestion webhooks. Cloud-agnostic (improves edge portability). Strong fit if the CDP exposes APIs to many consumers.
- **Cons:** you run another self-hosted control + data plane (HA, upgrades, CVE cadence — same flavor as the Superset ops concern), added cost (infra/ops, or Konnect license), and an extra hop. Some overlap with auth already in Django.

## Decision drivers

- **How API-product-like is the external surface?** M2M ingestion auth (API-key/HMAC is a noted build-time requirement), dealer/external API exposure, and future activation push toward a gateway. A mostly-internal surface (the 4 web surfaces + ingestion) does not need one.
- **Ops appetite.** ALB ~ zero; Kong is a real, ongoing platform commitment.
- **Portability.** Both portable; Kong removes AWS lock-in at the edge (ALB -> App Gateway is the Azure swap already noted).

## Phasing option (reduces lock-in of the decision)

Ship **ALB now**, add **Kong behind it later** when API-product needs materialize — it is an additive layer, not a rip-replace. Or adopt the Kong Ingress Controller from day one if the gateway need is already clear.

**No decision — options for discussion.**
