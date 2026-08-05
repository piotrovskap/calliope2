---
source: Megatron.Client, Megatron.CommonClientIdMapping (live SQL Server audit — 2026-06-14)
title: Common Client ID — Audit Findings
type: db-schema
database: CommonClientID
owner: Ron Mulder
researcher: Alicia Salazar
access: partial        # CCID tables live inside Megatron — accessible; a dedicated CommonClientID DB may exist separately (pending Ron confirmation)
status: complete
dump: dumps/common-client-id.sql
erd: erd/common-client-id.svg
updated: 2026-06-14
---

# Common Client ID — Audit Findings

> Researcher: Alicia Salazar · Audited: 2026-06-14 · Source: live SSMS queries against `20.51.108.231 / Megatron`

## TL;DR

**CCID is not functional in any of the 9 accessible databases.** The `Client.common_client_id` column exists but contains only the integer default `0` for all 5,328 rows. `CommonClientIdMapping` holds external-system GUIDs (`ref_id`) that may be the real cross-system identifier, but the table is not joined to anything in the live schema. CDP identity resolution must be **fully probabilistic** (email + phone + VIN) until CCID data quality is resolved.

---

## Audit queries run

All queries executed with `NOLOCK` on `20.51.108.231`, database `Megatron`, 2026-06-14.

### 1 — `common_client_id` value distribution in `Client`

```sql
SELECT common_client_id, COUNT(*) AS cnt
FROM [Client] WITH (NOLOCK)
GROUP BY common_client_id
ORDER BY cnt DESC;
```

| `common_client_id` | count |
|---|---|
| `0` | 5,328 |

**Finding:** The only distinct value is `0` — the uninitialized default for an INT column. The field was added to the schema but never populated with a real identity value.

### 2 — Sample `Client` rows

```sql
SELECT TOP 10 client_id, account_id, common_client_id, company_name
FROM [Client] WITH (NOLOCK)
ORDER BY client_id DESC;
```

| `client_id` | `account_id` | `common_client_id` | `company_name` |
|---|---|---|---|
| 5814 | NULL | 0 | Desert Wind Harley-Davidson |
| 5813 | NULL | 0 | Volcano Harley-Davidson |
| 5812 | NULL | 0 | RideNow Powersports Tucson |
| … | NULL | 0 | … |

**Findings:**
- `account_id` is NULL for all sampled rows — the FK from `Client` to `Account` is also unpopulated. `Client` is a disconnected entity.
- `company_name` values are powersports dealerships (Harley-Davidson, RideNow) — `Client` appears to represent a newer advertiser tier or a separate vertical, not the main advertiser accounts in `Account`.

### 3 — `CommonClientIdMapping` (TOP 20)

```sql
SELECT TOP 20 * FROM [CommonClientIdMapping] WITH (NOLOCK);
```

| `acc_id` | `sales_channel_id` | `ref_id` | `client_id` | `account_tier` |
|---|---|---|---|---|
| -11920946 | 52 | `5e5359fd-6485-33e1-e90a-551716f5d33e` | 7602 | NULL |
| -11919907 | 43 | `e4d34ba8-6854-d22f-d929-b381ef249cb3` | 8350 | NULL |
| -9762588 | 27 | `f1a2b3c4-…` | 8281 | NULL |
| … | … | … | … | NULL |

**Column-by-column analysis:**

| Column | DDL type | Observed values | Interpretation |
|---|---|---|---|
| `acc_id` | `INT NOT NULL` (PK part) | Negative integers: -11,920,946 … -9,762,588 | **Not a valid `Account.acc_ID`** (those are positive small integers). This is a foreign system's account namespace — possibly a partner platform or legacy import. No join path to `Account` exists. |
| `sales_channel_id` | `INT NOT NULL` (PK part) | 7, 10, 27, 30, 31, 43, 52, 58, 64 | Small-integer lookup, likely maps to a SalesChannel table (Google, Facebook, OEM portals, etc.). |
| `ref_id` | `VARCHAR(50) NOT NULL` (PK part) | GUIDs (e.g. `5e5359fd-6485-33e1-e90a-551716f5d23e`) | **The most credible cross-system identity token.** UUID format suggests origin in Salesforce, a CDI/MDM service, or the DAS AI system. Source unknown — needs Ron Mulder confirmation. |
| `client_id` | `VARCHAR(50) NULL` | Integers: 7602, 8281, 27878… | Integer values stored as VARCHAR. Range (7000–28000) does not overlap with `Client.client_id` (max ~5,814). Appears to be an external system's client ID, not Megatron's. |
| `account_tier` | `VARCHAR(50) NULL` | NULL (all rows) | Unused / never populated. |

---

## Coverage map summary (from `common-client-id-coverage.sql`)

| Database | CCID column found | Status | Notes |
|---|---|---|---|
| Megatron | `Client.common_client_id` | **ABSENT (null)** — all rows = 0 | See audit above |
| Megatron | `CommonClientIdMapping` | **MAPPING TABLE** | GUIDs present but disconnected |
| EndeavorCentral | — | ABSENT | No CCID variant column in any table |
| MegatronRepository | — | ABSENT | No CCID variant column in any table |
| OutboundFeeds | — | ABSENT | No CCID variant column in any table |
| PetFinder | — | ABSENT | No CCID variant column in any table |
| Prime | — | ABSENT | No CCID variant column in any table |
| RedDawn | — | ABSENT | No CCID variant column in any table |
| Trax | — | ABSENT | No CCID variant column in any table |
| Web | — | ABSENT | No CCID variant column in any table |
| DWRPT | — | READ ACCESS GRANTED (2026-06-12) | Used self-serve for this audit + reporting-parity reference; not a CDP ingestion source |
| EDW_Staging | — | NOT REQUIRED | No direct grant needed — granted source DBs (CIM/ML/RL) + SSIS procs cover discovery (access tracker, 2026-06-15) |

---

## CDP architecture implications

| Layer | Status |
|---|---|
| Deterministic identity via CCID | **Not available** in any of the 9 accessible DBs |
| `Client` ↔ `Account` join | **Broken** — `account_id` NULL for all Client rows |
| `CommonClientIdMapping.ref_id` GUIDs | **Potentially salvageable** as cross-channel tokens — origin must be confirmed |
| Identity resolution approach | **Must be fully probabilistic**: email + phone + VIN as primary match keys |

The CDP identity graph will need to be built from scratch on first-party match signals. The `ref_id` GUIDs in `CommonClientIdMapping` are the only candidate for a pre-existing cross-system ID and should be prioritized for investigation.

---

## Open questions — resolved / parked

CCID is **closed as an identity-foundation question** (2026-06-18). The audit settled it: CCID is non-functional (all-zero) and is at most one weighted signal in the deterministic waterfall — never the foundation. The CDP builds its own deterministic Common Client ID from first principles (Option A, locked 2026-06-17), so the questions below no longer block the design; they are build-time caveats or migration-time details, validated/backfilled at Phase 1 if ever.

1. **What generated `CommonClientIdMapping.ref_id` GUIDs?** Salesforce? DAS AI? An MDM/CDI platform? Build-time caveat — determines only whether these GUIDs are reusable as a backfill/migration token, not whether the design proceeds.
2. **Why is `acc_id` negative?** External platform IDs? An INT overflow from a large import? A partner's account namespace? Legacy-ID reconciliation, migration-time only.
3. **Was `Client.common_client_id` ever meant to be populated from `CommonClientIdMapping`?** Or was the CCID rollout abandoned before the ETL was written? Historical; does not affect the ground-up build.
4. **Does a standalone `CommonClientID` database exist on `20.51.108.231`?** Parked — a backfill-signal investigation, not a blocker; DWRPT (granted 2026-06-12) is the self-serve reference for any further CCID study.
5. **Does CCID live in DWRPT or EDW_Staging?** Resolved: DWRPT read access was granted (2026-06-12) and used for this audit; EDW_Staging direct access is not required (granted source DBs + SSIS procs suffice). The CDP ingests from original sources, not the warehouse layer.

> Owner: Alicia Salazar · CCID closed as a foundation issue 2026-06-18; residual items are build-time/migration-time, validated at Phase 1.
