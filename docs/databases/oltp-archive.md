---
name: oltp_Archive
status: complete
owner: Ron Mulder
access: granted
server: 20.65.216.199:49577 (RL_MSSQL in .env)
discovery-date: 2026-06-14
researcher: Alicia Salazar
dump: dumps/oltp.sql
updated: 2026-06-14
---

# oltp_Archive — Response Logix Historical Archive

Historical archive of high-volume tables periodically moved from `oltp`. Contains ~1.9 billion rows of lead history, consumer transactions, and smart quotes.

> **DDL dump:** included in `docs/databases/dumps/oltp.sql`

---

## Overview

| Property | Value |
|---|---|
| Server | 20.65.216.199:49577 (RL_MSSQL) |
| Tables | 9 |
| Total rows | ~1.91 billion |
| Total on-disk | ~225 GB |
| Growth rate | +0.44 GB/month (stable — periodic bulk move from oltp) |

---

## Tables

| Table | ~Rows | Size GB | Notes |
|---|---|---|---|
| `lead_history` | 1,026,853,836 | 82.8 | Full lead lifecycle history — historical (pre-cutoff) |
| `franchise_consumer_txn` | 422,483,667 | 23.8 | Consumer transaction audit log — historical |
| `franchise_consumer_txn_old` | 209,347,512 | 14.2 | Older consumer txn archive (pre-`franchise_consumer_txn`) |
| `lead` | 178,456,719 | 64.0 | Historical leads (pre-cutoff) |
| `smart_quote` | 66,399,672 | 19.9 | Historical smart quotes |
| `lead_additional_info` | 2,401,500 | 0.67 | Additional lead fields |
| `ChatStatistics` | 778,263 | 0.058 | Chat interaction statistics |
| `franchise` | 5,301 | 0.002 | Snapshot of franchise table (older/inactive records) |
| `sysdiagrams` | 0 | — | System |

---

## CDP relevance

The 178M historical leads + 1B lead_history rows are relevant for:
- Long-term identity resolution (same consumer across years)
- Churn/re-engagement pattern detection
- Historical vehicle purchase confirmation

All use the same `franchise_id` / `franchise_consumer_id` / `lead_id` keys as `oltp`.
