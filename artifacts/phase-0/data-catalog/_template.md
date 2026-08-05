# [Source Name] — Data Map

**Category:** <!-- CRM / DMS / Lead Provider / Ad Platform / Review / Email-SMS / Website / Chat / Inventory / Credit / Valuation / Internal DAS / Video / OEM -->
**Assigned to:** <!-- Hiram / Julio / Byron / Oscar / Leo / Luis / Alicia -->
**Status:** <!-- Not Started / In Progress / Complete -->
**CDP Priority:** <!-- P0 / P1 / P2 -->

---

## Current State

**What it is:** <!-- One sentence description -->

**How DAS uses it today:** <!-- What data flows from this source, to where, for what purpose -->

**Current ingestion path:**
<!-- e.g. CSV export → email → FTP → SSIS → EDW_target -->

---

## Access & Connectivity

| Field | Value |
|-------|-------|
| API exists? | Yes / No / Unknown |
| API docs | |
| Auth method | API key / OAuth / Basic / FTP credentials / None |
| Credentials location | 1Password vault / .env / ask Dan |
| FTP/SFTP host | |
| Rate limits | |
| DAS contact / account owner | |

---

## Data Schema

What fields does this source actually provide? List everything, mark what matters for CDP.

| Field Name | Type | Example | CDP Relevant? | Notes |
|------------|------|---------|--------------|-------|
| | | | | |
| | | | | |

**Identity fields (for matching):**
- Primary: <!-- e.g. email -->
- Secondary: <!-- e.g. phone, DealerID+CustomerID -->
- Weak: <!-- e.g. name only -->

---

## Data Quality

| Dimension | Assessment | Notes |
|-----------|-----------|-------|
| Completeness | <!-- High / Medium / Low --> | |
| Consistency | <!-- High / Medium / Low --> | |
| Duplication rate | <!-- e.g. ~5% estimated --> | |
| Update frequency | <!-- Real-time / Daily / Weekly / Ad-hoc --> | |
| Known issues | | |

---

## CDP Mapping

How does this source map to the CDP data model?

| Source Field | CDP Entity | CDP Field | Transform needed? |
|-------------|-----------|-----------|------------------|
| | consumer | | |
| | vehicle | | |
| | event | | |

**Ingestion channel recommendation:** <!-- Webhook / Airflow Batch Pull / Bulk Upload / Event Stream -->

**Ingestion notes:** <!-- Anything special — auth, pagination, rate limits, file format quirks -->

---

## Open Questions

- [ ] <!-- Question 1 -->
- [ ] <!-- Question 2 -->

---

## Session Notes

<!-- Running log of what was discovered, when, and by whom. Append — don't overwrite. -->

**[Date] [Name]:**
