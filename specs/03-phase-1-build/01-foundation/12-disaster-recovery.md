---
title: "Disaster recovery & backups"
type: story
status: planned
priority: medium
estimate: XXL
depends_on: [phase-1-build.foundation.data-stores-provisioning]
labels: [foundation, dr, backups, terraform, 1a]
date: ~
---

Layered DR: managed backup (AWS Backup / Azure Backup) + a dump script for the canonical stores, cross-region replication, and Terraform for a cross-region **pilot-light** buildout (warm/hot standby as optional add-ons, with cutover). Offsite resilience via data sync to Azure; the path extends to a cross-cloud pilot light + buildout with cutover if ever needed. Cloudflare provides top-level DNS for failover routing.

**Acceptance:** managed backup + dump script run on schedule and a restore is verified (PITR + dump replay both produce a usable store); object storage cross-region geo-replication confirmed for bronze + backups; the cross-region **pilot-light** standby is defined in Terraform and a `terraform plan` is clean; a documented cutover runbook promotes the standby and repoints Cloudflare DNS; Azure offsite sync runs and is verified. Warm/hot standby and cross-cloud buildout are documented as optional add-ons (not built).

**References:**
- Decided 2026-06-16 (infrastructure sizing): dev baseline (single-AZ RDS, no replicas, no cross-region) + rightsize prod once load is observed — so cross-region DR is a prod-only buildout, not in dev — `memory/decisions.md#d-007`
- Production-grade Phase-1 posture: DR = managed Backup (RDS PITR + EC2) + S3/object-store raw replay — `memory/decisions.md`
- `docs/cdp-reference-topology.md` — prod DR = cross-region pilot-light PG standby + object geo-replication; DR step promotes the standby (object storage already geo-replicated)
- `docs/cloud-aws-vs-azure-bakeoff.md` — DR/backup equivalence across clouds (AWS Backup + S3 cross-region / Azure Backup + GRS Blob + PG PITR); cross-region DR scoped to prod
- `docs/cdp-architecture.md` · `wiki/Tech-Stack.md` — managed backup/PITR + object-store raw replay + cross-region pilot-light standby as the canonical DR design
