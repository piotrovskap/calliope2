# Golden Record — Worked Examples

> Illustrative records grounded in the actual DAS CDP proposed schema and confirmed source systems. Together they exercise every proposed strategy: all three confidence bands, the full deterministic + heuristic + moderated resolution paths, orphan handling and upgrade, bitemporal provenance, CCID backfill, household detection, merge reversal/split, consent ledger, PII vault erasure (delete-the-row), and identity event sourcing. Field values are fictional but structurally real — every field maps to a concrete DB column or `consumer_attribute` EAV row from a verified source system.
>
> **Coverage map** at the bottom cross-references each strategy to the scenario that exercises it.

Sources: `docs/cdp-field-source-matrix.md` · `wiki/Data-Model.md` · `wiki/Identity-Resolution.md` · `analysis/artifacts/golden-record/record.json` · `specs/03-phase-1-build/06-identity-resolution-engine/` · `specs/03-phase-1-build/07-identity-curation-data-quality/`

---

## Example 1 — Clean single-source record (deterministic auto-merge, high confidence)

**Scenario:** Maria submitted a VinSolutions CRM lead. She bought a car four months later. The DMS (Authenticom/CDK) had her on file. Email matched exactly → one deterministic link, single candidate → auto-merged, no conflict queue. BlackBook has run equity on the VIN. She's opted into email and SMS.

**Strategies exercised:** deterministic waterfall · high-confidence auto-merge · per-fact provenance · bitemporal fields · survivorship (DMS over CRM) · consent ledger

---

### `consumer`

| Column | Value | Source | Survivorship |
|---|---|---|---|
| `consumer_id` | `c_01JK9M3ABCDE` | CDP-minted | — |
| `first_name` | `Maria` | `EDW_staging.source_dms_sales.CustomerFirstName` (CDK) | DMS trust-tier 1 beats CRM |
| `last_name` | `Gonzalez` | `EDW_staging.source_dms_sales.CustomerLastName` (CDK) | same |
| `primary_email` | `maria.gonzalez@gmail.com` | `source_dms_sales.CustomerEmail` | normalized lowercase + trim |
| `primary_phone` | `+14805550192` | `source_dms_sales.CustomerCellPhone` | E.164 via `sp_update_DMS_Fact_CellPhone` |
| `confidence_score` | `0.98` | identity engine | single candidate, exact email match |

> **Note:** `first_name`, `last_name`, `primary_email`, and `primary_phone` shown here are resolved display values. The CDP stores a surrogate vault token in these columns; the PII vault row holds the raw value and is what gets deleted on erasure.
| `created_at` | `2023-09-03T14:22:11Z` | CDP ingest | first event: VinSolutions lead |
| `updated_at` | `2025-11-02T09:15:00Z` | CDP ingest | last service visit |

### Bitemporal provenance on `first_name`

Every fact on the golden record carries two time axes — when the fact was true in the real world (`valid_from`/`valid_to`) and when the CDP observed it (`recorded_at`/`superseded_at`). This powers as-of queries ("what did the record look like on 2024-01-01?") and the event-sourcing replay.

```
fact:  first_name = "Maria"
  source:          EDW_staging.source_dms_sales.CustomerFirstName (CDK via Authenticom)
  method:          deterministic
  confidence:      0.98
  event_id:        evt_01JK9MDMS01
  valid_from:      2023-09-03          ← when this was true in the world (deal date)
  valid_to:        null                ← still current
  recorded_at:     2023-09-03T14:22Z  ← when CDP first observed it
  superseded_at:   null               ← not yet overwritten
```

If the CRM later delivers a different spelling ("Mari"), the engine applies survivorship (DMS beats CRM), writes a new row with `valid_from` = now, and sets `superseded_at` on the old row — both rows are retained and the full history is replayable.

---

### `vehicle`

| Column | Value | Source |
|---|---|---|
| `vin` | `1FAHP3F22CL201847` | `source_dms_sales.VehicleVIN` (Authenticom) |
| `year` | `2023` | `source_dms_sales.VehicleYear` |
| `make` | `Ford` | `source_dms_sales.VehicleMake` |
| `model` | `Escape` | `source_dms_sales.VehicleModel` |
| `trim` | `SE` | `source_dms_sales.TrimLevel` — VALIDATE: CDK 3PA vs DMS reliability varies |
| `mileage` | `21400` | `source_dms_service.VehicleMileage` — updated from most recent service visit |
| `vehicle_type` | `new` | derived from deal type flag in `source_dms_sales` |

### `consumer_vehicle`

| Column | Value | Source |
|---|---|---|
| `dealership_id` | `dealer_114` | — |
| `acquired_at` | `2024-01-15T00:00:00Z` | `source_dms_sales.ClosedDate` |
| `metadata` | `{"purchase_price": 29450.00}` | `source_dms_sales.FrontGross + BackGross` — VALIDATE |

### `consumer_attribute` (EAV)

| `name` | Value | Source |
|---|---|---|
| `completed_services` | `[{"service":"Oil Change","date":"2024-06-10","mileage":8100},{"service":"Tire Rotation","date":"2025-11-02","mileage":21400}]` | `source_dms_service` → `DMS_Fact_Services` — VALIDATE |
| `equity_amount` | `4200.00` | `EDW_staging.stage_Vehicle_Valuation` → `sp_Calculate_Equity` (BlackBook) |
| `market_value` | `26800.00` | `EDW_staging.stage_Vehicle_Valuation` → `Vehicle_Valuation` (BlackBook) |

### Identity resolution path

```
Incoming DMS event (email: maria.gonzalez@gmail.com)
  │
  ▼  Deterministic waterfall — step 1: email
  ├─ normalize: lowercase + trim → "maria.gonzalez@gmail.com"
  ├─ indexed lookup against identity graph
  ├─ candidate found: id_maria_crm (VinSolutions, same email)
  ├─ single candidate → HIGH confidence band
  └─ auto-merge → consumer_id assigned, no queue entry
```

### `identity_link`

| Column | Value |
|---|---|
| `source` | `id_maria_dms` (source_dms_sales, CDK) |
| `target` | `id_maria_crm` (source_CRM_VS, VinSolutions) |
| `link_type` | `deterministic` |
| `key_used` | `email` |
| `confidence` | `0.98` |
| `justification` | `"Exact email match on normalized maria.gonzalez@gmail.com; single candidate; auto-confirmed"` |
| `event_id` | `evt_01JK9MDMS01` |
| `recorded_at` | `2024-01-15T09:00:00Z` |

### `event` timeline

| `event_type` | `source_system` | `occurred_at` |
|---|---|---|
| `lead_submitted` | `CRM_VinSolutions` | `2023-09-03T14:22:11Z` |
| `deal_closed` | `DMS_CDK_Authenticom` | `2024-01-15T09:00:00Z` |
| `service_visit` | `DMS_CDK_Authenticom` | `2024-06-10T11:30:00Z` |
| `email_open` | `Mailgun` | `2025-03-04T08:14:00Z` |
| `service_visit` | `DMS_CDK_Authenticom` | `2025-11-02T09:15:00Z` |

### `consent_event` ledger (append-only, hash-chained)

The `consent` table stores current state; `consent_event` is the immutable audit ledger. Every change is a new append — no updates or deletes. Each row includes a `prev_hash` linking it to the prior entry for tamper-evidence.

```
row 1:
  event_id:     ce_01JK9MCONSENT01
  consumer_id:  c_01JK9M3ABCDE
  channel:      email
  type:         marketing
  state:        opted_in
  source:       CRM_VinSolutions (lead form)
  occurred_at:  2023-09-03T14:22Z
  recorded_at:  2023-09-03T14:22Z
  prev_hash:    null  ← first entry

row 2:
  event_id:     ce_01JK9MCONSENT02
  consumer_id:  c_01JK9M3ABCDE
  channel:      sms
  type:         marketing
  state:        opted_in
  source:       Twilio (point-of-sale opt-in)
  occurred_at:  2024-01-15T09:00Z
  recorded_at:  2024-01-15T09:01Z
  prev_hash:    sha256(row 1)  ← chained
```

The current `consent` row (opted_in / opted_in) is derived from the ledger tail. Activation reads consent at send-time, not at consumer-creation time.

---

## Example 2 — Complex cross-source resolution (deterministic + curation queue + orphan upgrade)

**Scenario:** Jason submitted a Meta lead form with a throwaway email (`jw_deals@tempmail.com`). DMS had him as "J. Williams" with his real email. DealerSocket CRM had "Jason Williams" with a matching phone. Meta lead became an orphan (throwaway email matched nothing). Name variation ("J." vs "Jason") triggered the conflict queue. Operator confirmed merge. When a second Meta lead arrived with the real email + same Facebook ID, the orphan upgraded to deterministic. He bought from two dealerships — two `consumer_dealership` rows, RLS-isolated. Open F-150 recall from RecallMasters. CCID present as a legacy identifier from historical backfill.

**Strategies exercised:** deterministic waterfall · curation queue (medium confidence) · orphan storage + late upgrade · multi-tenant RLS · merge/split audit · survivorship (curation supremacy · null/non-null preference · channel-state recency) · CCID as migration key · per-fact provenance · bitemporal fields

---

### `consumer`

| Column | Value | Source | Survivorship |
|---|---|---|---|
| `consumer_id` | `c_01JK9NWILL01` | CDP-minted | — |
| `ccid` | `CCID-8821447` | legacy DAS Common Client ID | retained as legacy identifier; not a join key post-cutover |
| `first_name` | `Jason` | `source_CRM_DS.CustomerFirstName` (DealerSocket), operator-confirmed | Curation supremacy: DMS had "J. Williams"; the operator resolving the merge queue confirmed "Jason" (the DealerSocket full name) as the golden first name. An operator-confirmed value is highest trust — above DMS — and is not overwritten by a later automated feed |
| `last_name` | `Williams` | `source_dms_sales.CustomerLastName` | DMS wins |
| `primary_email` | `jwilliams@outlook.com` | `source_dms_sales.CustomerEmail` | DMS trust-tier 1; throwaway Meta email demoted |
| `primary_phone` | `+16025550847` | `source_dms_sales.CustomerCellPhone` | E.164 |
| `confidence_score` | `0.94` | identity engine | deterministic on email+phone; briefly queued (name variation) |

> **Note:** `first_name`, `last_name`, `primary_email`, and `primary_phone` shown here are resolved display values. The CDP stores a surrogate vault token in these columns; the PII vault row holds the raw value and is what gets deleted on erasure.
>
> **null/non-null preference:** separately, Jason's `mailing_address` was null on the DMS sales feed but present on the DealerSocket CRM lead, so the CRM address fills the DMS null. A non-null lower-trust value beats a null/blank higher-trust value — the cross-tier exception to the trust ladder: never let a higher-trust NULL win.
| `created_at` | `2023-07-18T20:04:00Z` | CDP ingest | Meta orphan phase |
| `updated_at` | `2025-08-30T13:00:00Z` | CDP ingest | second dealer service visit |

### CCID as migration/backfill key

Jason's historical record existed in the legacy DAS estate under `CCID-8821447`. At CDP cutover, the backfill process:

1. Reads `CCID-8821447` from the DWRPT/EDW layer
2. Mints `c_01JK9NWILL01` keyed to that CCID
3. Stores the CCID on the entity as a legacy identifier — it is **one weighted signal in the deterministic waterfall**, not a join key
4. Any new event arriving with `CCID-8821447` scores it as a strong match signal in the waterfall alongside email/phone/dealer-ID/VIN
5. No production read path depends on CCID after cutover

```
identity_link (legacy backfill):
  source:     id_ccid_8821447
  target:     c_01JK9NWILL01
  link_type:  deterministic
  key_used:   ccid
  note:       "backfill — CCID retained as legacy identifier, not join key"
  recorded_at: 2026-01-01T00:00Z  ← CDP cutover date
```

### Vehicles

**Vehicle 1 — F-150 (dealer_77)**

| Column | Value | Source |
|---|---|---|
| `vin` | `1FTFW1ET5DKE12345` | `source_dms_sales.VehicleVIN` (dealer_77, Authenticom) |
| `year` | `2022` | `source_dms_sales.VehicleYear` |
| `make` | `Ford` | `source_dms_sales.VehicleMake` |
| `model` | `F-150` | `source_dms_sales.VehicleModel` |
| `mileage` | `38200` | `source_dms_service.VehicleMileage` — updated from most recent service visit |
| `vehicle_type` | `used` | derived from deal type flag |

**Vehicle 2 — Explorer (dealer_203)**

| Column | Value | Source |
|---|---|---|
| `vin` | `1FM5K8D82LGA04521` | `source_dms_sales.VehicleVIN` (dealer_203, CDK) |
| `year` | `2024` | `source_dms_sales.VehicleYear` |
| `make` | `Ford` | `source_dms_sales.VehicleMake` |
| `model` | `Explorer` | `source_dms_sales.VehicleModel` |
| `mileage` | `6100` | `source_dms_sales.VehicleMileage` — snapshot at sale |
| `vehicle_type` | `new` | derived |

### `consumer_dealership` — multi-tenant rows (RLS boundary)

| `consumer_id` | `dealership_id` | `first_seen_at` | `source` |
|---|---|---|---|
| `c_01JK9NWILL01` | `dealer_77` | `2023-07-18` | DMS sale |
| `c_01JK9NWILL01` | `dealer_203` | `2025-03-12` | DMS sale |

dealer_77 sees only their row and their events. dealer_203 sees only theirs. DAS admin sees both. RLS enforced at the PostgreSQL row level — unscoped queries are bugs.

### `consumer_attribute` (EAV)

| `name` | Value | Source |
|---|---|---|
| `open_recalls` | `[{"vin":"1FTFW1ET5DKE12345","recall_id":"23V123000","description":"Fuel pump may fail","remedy_available":true}]` | `acceleratordb.leads_recall_data` (RecallMasters) — VALIDATE: new integration required |
| `completed_services` | `[{"service":"Brake Inspection","date":"2024-03-01","mileage":22100},{"service":"Oil Change","date":"2025-08-30","mileage":38200}]` | `source_dms_service` → `DMS_Fact_Services` (dealer_77) |
| `equity_amount` | `3800.00` | `EDW_staging.stage_Vehicle_Valuation` (BlackBook, F-150) |
| `market_value` | `31200.00` | `EDW_staging.stage_Vehicle_Valuation` (BlackBook, F-150) |

### Full identity resolution story

```
── 2023-07-18: Meta lead form ──────────────────────────────────────────────
  email: jw_deals@tempmail.com (throwaway)
  facebook_id: fb_9912xx

  Deterministic waterfall:
    step 1 (email): normalize → lookup → NO MATCH
    step 2 (phone): none on Meta form → skip
    step 3 (dealer customer ID): none → skip
    step 4 (VIN):   none on Meta form → skip
  Waterfall exhausted → heuristic recovery not triggered (no name/address either)
  → NEW ORPHAN created: id_meta_orphan, link_type='orphan', no consumer_id

── 2023-08-29: DealerSocket CRM lead ───────────────────────────────────────
  name: Jason Williams
  email: jwilliams@outlook.com
  phone: +16025550847

  Deterministic waterfall:
    step 1 (email): normalize → lookup → CANDIDATE FOUND: id_dms_77
      ↳ id_dms_77 has name "J. Williams", same email
    single candidate, but name token mismatch raises heuristic score check:
      phonetic match (Williams ≈ Williams): 1.0
      first-name token: "J." vs "Jason" — initial-vs-full-name pattern → 0.7
      combined heuristic score: 0.81 → within MEDIUM confidence band
  → routes to CURATION QUEUE (not auto-merged)

  Queue item:
    candidate_a: id_dms_77    name="J. Williams"  source=DMS
    candidate_b: id_crm_ds    name="Jason Williams" source=DealerSocket CRM
    evidence: exact email match + phonetic last-name match + initial-vs-full first name
    heuristic_score: 0.81
    justification: "Exact email; last name phonetically identical; first name is
                   likely abbreviation (J. → Jason). High prior on same person;
                   name variation consistent with DMS abbreviation patterns."
    assigned_to: mvalencia
    priority: high (email is a strong deterministic key)

  Operator action: CONFIRM MERGE
    → merge_history row created
    → consumer_id c_01JK9NWILL01 minted
    → first_name "Jason" survives (curation_supremacy: operator-confirmed value is
      highest trust — above DMS "J." — and is not overwritten by a later automated feed)

── 2024-02-11: second Meta lead form ───────────────────────────────────────
  email: jwilliams@outlook.com  ← real email this time
  facebook_id: fb_9912xx        ← same Facebook ID as the 2023-07-18 orphan

  Deterministic waterfall:
    step 1 (email): normalize → lookup → MATCH: c_01JK9NWILL01 (high confidence)
    → auto-merge confirmed

  Orphan upgrade:
    id_meta_orphan (fb_9912xx) was stored with observed_at=2023-07-18
    linking event delivers email + facebook_id together
    → link_type upgraded: orphan → deterministic
    → original attribution retained (source, event_id, observed_at preserved)
    → no history lost
```

### `identity_link` snapshot (final state)

| `source_id` | `target_id` | `link_type` | `key_used` | `confidence` | `recorded_at` |
|---|---|---|---|---|---|
| `id_dms_77` | `c_01JK9NWILL01` | `deterministic` | `email` | `0.98` | `2023-09-10` |
| `id_crm_ds` | `c_01JK9NWILL01` | `manual_merge` | `email+phone` | `1.0` | `2023-09-05` |
| `id_dms_203` | `c_01JK9NWILL01` | `deterministic` | `email` | `0.98` | `2025-03-12` |
| `id_meta_orphan` | `c_01JK9NWILL01` | `deterministic` | `email+facebook_id` | `0.95` | `2024-02-11` |
| `id_ccid_8821447` | `c_01JK9NWILL01` | `deterministic` | `ccid` | `1.0` | `2026-01-01` |

### `merge_history`

| Column | Value |
|---|---|
| `source_consumer_id` | `c_tmp_crm_9921` (pre-merge CRM record) |
| `target_consumer_id` | `c_01JK9NWILL01` |
| `merged_by` | `operator:mvalencia` |
| `merge_reason` | `manual_confirm` |
| `evidence` | `{"email_match": true, "heuristic_score": 0.81, "queue_item": "qi_01JK9NQUEUE01"}` |
| `bitemporal_snapshot` | S3 artifact URI (pre-merge state archived for replay) |
| `reversible` | `true` — split re-attaches bitemporal facts intact |
| `created_at` | `2023-09-05T13:44:00Z` |

### `consent_event` ledger

```
row 1 — opted_in email (CRM lead form):
  channel: email · state: opted_in · source: CRM_DealerSocket
  occurred_at: 2023-08-29 · prev_hash: null

row 2 — opted_in SMS (point of sale, dealer_77):
  channel: sms · state: opted_in · source: Twilio
  occurred_at: 2023-09-10 · prev_hash: sha256(row 1)

row 3 — STOP reply (Twilio opt-out):
  channel: sms · state: opted_out · source: Twilio
  occurred_at: 2024-06-03 · prev_hash: sha256(row 2)

row 4 — opted_in email (dealer_203 sale):
  channel: email · state: opted_in · source: DMS_CDK_203
  occurred_at: 2025-03-12 · prev_hash: sha256(row 3)
```

Current consent (derived from ledger tail): email=opted_in, sms=opted_out.
SMS is opted_out even though a later email opt-in arrived — channel-state recency applies **per channel**: SMS is governed by the most recent Twilio signal regardless of trust tier.

### `event` timeline

| `event_type` | `source_system` | `occurred_at` | Note |
|---|---|---|---|
| `lead_submitted` | `Meta_LeadForms` | `2023-07-18T20:04Z` | throwaway email; orphan created |
| `lead_submitted` | `CRM_DealerSocket` | `2023-08-29T11:00Z` | real email; triggered conflict queue |
| `deal_closed` | `DMS_Authenticom_77` | `2023-09-10T00:00Z` | F-150 purchase |
| `lead_submitted` | `Meta_LeadForms` | `2024-02-11T17:30Z` | orphan upgraded |
| `deal_closed` | `DMS_CDK_203` | `2025-03-12T00:00Z` | Explorer purchase (second dealer) |
| `service_visit` | `DMS_Authenticom_77` | `2025-08-30T13:00Z` | oil change, F-150 |

---

## Example 3 — Heuristic path, below-floor rejection, and no-link outcome

**Scenario:** Sandra Lee submits a lead via Cars.com (ADF/XML). The DMS has a "Sandra Li" (married name vs maiden name) at the same address, different email, no phone overlap. The heuristic scorer runs — score is 0.61, which is above the blocking floor but below the auto-merge threshold, putting it in the medium band and routing to the curation queue. Meanwhile, a separate event arrives with a name "S. Lee" and only a work email that has never appeared before — the waterfall exhausts, heuristic scores low (0.29, below the floor), and a new independent consumer record is created (no-link outcome). The two are never linked.

**Strategies exercised:** heuristic recovery path (blocking + scoring) · medium confidence band → curation queue · below-floor no-link → new independent record · association provenance + justification · per-field score breakdown

---

### Heuristic recovery — how the scorer runs

After the deterministic waterfall exhausts (no email/phone/dealer-ID/VIN match), the heuristic layer runs blocking to find candidates, then scores feature pairs:

```
Incoming event:
  name:     Sandra Lee
  email:    sandra.lee@gmail.com  (new — not in identity graph)
  address:  4420 W Bell Rd, Phoenix AZ 85053

Waterfall result: NO MATCH (email/phone/dealer_id/VIN all miss)
Heuristic blocking triggers:
  blocking keys: phonetic last name ("Lee" / "Li" both → Soundex L000) + canonical address

Candidate found: id_dms_sandra_li
  name:    Sandra Li
  email:   sli@hotmail.com
  address: 4420 W Bell Rd, Phoenix AZ 85053

Feature scoring:
  ┌─────────────────────────────┬────────┬────────────────────────────────────┐
  │ Feature                     │ Score  │ Note                               │
  ├─────────────────────────────┼────────┼────────────────────────────────────┤
  │ Last name phonetic (Lee/Li) │  0.85  │ Soundex match L000                 │
  │ First name exact            │  1.00  │ "Sandra" = "Sandra"                │
  │ Canonical address           │  1.00  │ USPS-normalized exact match        │
  │ Email                       │  0.00  │ no overlap                         │
  │ Phone                       │  0.00  │ absent on incoming event           │
  │ VIN                         │  0.00  │ absent                             │
  └─────────────────────────────┴────────┴────────────────────────────────────┘
  Combined heuristic score: 0.61

Confidence bands:
  > 0.90  → auto-merge (high)
  0.55–0.90 → curation queue (medium)   ← 0.61 lands here
  < 0.55  → no-link, new record (low)
```

> **The numeric cutoffs above are illustrative, not locked.** The confidence bands are
> qualitative for Phase 1 — high (deterministic single-key match → auto-merge), medium
> (heuristic + multiple candidates → curation queue), low (nothing above threshold → new
> identity + orphan). Numeric thresholds are per-tenant configurable and tuned after 2–4
> weeks of measurement, not fixed at these values; the bias is to over-queue rather than
> over-merge. See `identity_binding.confidence_bands` in the golden record and decisions
> d-104 / d-106. All scores shown in these examples (0.98, 0.94, 0.81, 0.61, 0.29) are
> illustrative on the same basis.

→ Routes to curation queue. Operator sees side-by-side comparison.

### Curation queue item

```
queue_item_id:  qi_01SANDRA01
consumer_a:     id_dms_sandra_li  — "Sandra Li", sli@hotmail.com, 4420 W Bell Rd
consumer_b:     incoming event   — "Sandra Lee", sandra.lee@gmail.com, 4420 W Bell Rd
heuristic_score: 0.61
justification:  "Same first name, phonetically similar last name (Lee/Li — likely
                 married/maiden name change), exact canonical address match.
                 Emails differ with no overlap. Moderate confidence; cannot
                 auto-merge on address alone."
priority:       medium
aging_sla:      72h
assigned_to:    (unassigned — operator claims)
```

Operator checks the DMS record: notes service history at that address, same name pattern, decides to **CONFIRM MERGE**. Sandra Lee and Sandra Li resolve to a single golden record. The name change is captured in `merge_history` with the full evidence trail.

### Below-floor: the "S. Lee" event — no-link outcome

A separate event arrives around the same time:

```
Incoming event:
  name:   S. Lee
  email:  sleework@company.com  (new — not in identity graph)
  phone:  (none)
  VIN:    (none)
  dealer_id: (none)

Waterfall: NO MATCH
Heuristic blocking: Soundex L000 finds candidates (Sandra Li, Sandra Lee)
Feature scoring vs Sandra Lee golden record (post-merge):
  ┌─────────────────────────────┬────────┬────────────────────────────────┐
  │ Feature                     │ Score  │ Note                           │
  ├─────────────────────────────┼────────┼────────────────────────────────┤
  │ Last name phonetic          │  0.85  │ "Lee" Soundex L000             │
  │ First name token            │  0.30  │ "S." initial vs "Sandra"       │
  │ Address                     │  0.00  │ absent on incoming event       │
  │ Email                       │  0.00  │ no overlap                     │
  └─────────────────────────────┴────────┴────────────────────────────────┘
  Combined heuristic score: 0.29 — below floor (< 0.55)
```

**Outcome: no-link.** A new independent consumer record is created for `sleework@company.com`. The S. Lee identifier is stored with full provenance (`source`, `event_id`, `observed_at`) but no `consumer_id` link to Sandra Lee's golden record. If a future event delivers both `sleework@company.com` and Sandra's email or VIN together, the orphan can be upgraded. Until then, the records are not linked — the system prefers over-queuing to over-merging.

```
new consumer:   c_01JKSLEE_NEW
  first_name:   null  (initial only — not a survivable value)
  last_name:    "Lee"
  primary_email: sleework@company.com
  confidence_score: 0.0  (provisional — single unlinked source)

identity_link:
  type:    orphan
  value:   sleework@company.com
  status:  stored_unlinked
  resolve_when: "a later event delivers this email + a known identity key"
```

---

## Appendix A — Household detection

**Scenario:** Jason Williams (Example 2) and his spouse Robin Williams live at the same address. Robin bought a separate vehicle from dealer_77. The CDP detects them as a household from shared address + shared surname + co-occurring vehicle service history.

**Strategy exercised:** household as a detected entity (never asserted by source system) · provisional membership until human curation confirms · activation targets either consumer or household layer

```
household_id:  h_01JK9NHOUSE01
detection_signals:
  - canonical_address_match: "4831 E Camelback Rd, Phoenix AZ 85018"  (both consumers)
  - shared_surname: "Williams"
  - co_occurring_service: both vehicles serviced at dealer_77 on overlapping dates

members:
  - consumer_id: c_01JK9NWILL01  (Jason Williams)
  - consumer_id: c_01JK9NROBIN01 (Robin Williams)

membership_status: provisional  ← requires human curation to confirm
detection_method: address + surname + service_co_occurrence
valid_from: 2024-03-01   ← first co-occurring signal observed
valid_to:   null         ← current

Household is DETECTED, never imported from a source.
Activation:
  - service appointment reminder → consumer-level (Jason or Robin individually)
  - F-150 recall campaign        → household-level (one send, not two)
```

Household lifecycle events (forming, splitting on divorce, merging) are Phase 2. The schema models membership as bitemporal so Phase 2 adds lifecycle logic without migration.

---

## Appendix B — Merge reversal / split

**Scenario:** An operator incorrectly merged two consumers — Jason Williams (dealer_77) and a different Jason Williams (dealer_44) who happened to share a last name and zip code but are not the same person. The merge is discovered and reversed.

**Strategy exercised:** reversible merge · bitemporal facts reattached on split · full audit trail · no history lost

```
Original (incorrect) merge:
  merge_history_id:  mh_01JK9NBADMERGE
  source_consumer_id: c_01JK9NWILL44  (dealer_44 Jason)
  target_consumer_id: c_01JK9NWILL01  (dealer_77 Jason)
  merged_by: operator:jsmith
  merge_reason: manual_confirm
  created_at: 2025-01-10T11:00Z

Split operation:
  split_by:       operator:mvalencia  (discovered the error)
  split_reason:   "Different consumers — different purchase history, different VINs,
                  different phones. Matched only on last name + zip."
  split_at:       2025-02-03T14:30Z

Post-split result:
  c_01JK9NWILL01  → restored to its pre-merge identity graph (dealer_77 Jason)
    - all bitemporal facts from pre-merge period reattached with original valid_from/to
    - identity_links from dealer_44 removed
    - events from dealer_44 Jason removed and reassigned to c_01JK9NWILL44

  c_01JK9NWILL44  → restored as an independent consumer (dealer_44 Jason)
    - re-minted with new consumer_id (original was absorbed into the merge)
    - all its bitemporal facts restored from the merge_history snapshot
    - no history lost — the S3 pre-merge artifact is the restore source

merge_history audit trail:
  mh_01JK9NBADMERGE.split_at    = 2025-02-03T14:30Z
  mh_01JK9NBADMERGE.split_by    = operator:mvalencia
  mh_01JK9NBADMERGE.split_reason = "..."
  mh_01JK9NBADMERGE.reversible   = true  (was set at merge time)
```

The identity graph is consistent after the split. Both records have intact bitemporal histories. The merge and split are both logged — neither is deleted.

---

## Appendix C — Identity record event sourcing & replay

Every change to an identity record — attribute facts, edges, resolution decisions, merges/splits — is a recorded row in the bitemporal store. The canonical store is live and queryable. Older partitions rotate to compressed parquet in object storage (S3 / Azure Blob) for long-term retention and re-hydration/replay, queryable in place as external tables via a parquet-compatible engine (AWS Glue or the Azure equivalent). This powers the Golden Record evolution view.

**Example: reconstructing Jason's record as of 2023-10-01** (after DMS sale, before the second Meta lead and orphan upgrade):

```
Replay query: consumer_id = c_01JK9NWILL01, as_of = 2023-10-01T00:00Z

Filter: recorded_at <= 2023-10-01 AND (superseded_at IS NULL OR superseded_at > 2023-10-01)

Result:
  first_name:    "Jason"        (from CRM merge 2023-09-05; still current)
  last_name:     "Williams"     (from DMS 2023-09-10)
  primary_email: jwilliams@outlook.com  (from DMS 2023-09-10)
  primary_phone: +16025550847   (from DMS 2023-09-10)
  vehicles:      [F-150 1FTFW1ET5DKE12345]  (deal closed 2023-09-10)
  identity_links: [id_dms_77, id_crm_ds, id_ccid_8821447]
    NOTE: id_meta_orphan NOT present — orphan upgrade happened 2024-02-11 (after as_of date)
  consent:       email=opted_in, sms=opted_in
    NOTE: Twilio STOP reply not yet received (2024-06-03)
```

The record at any historical point is reconstructable without touching current state. S3 artifacts store snapshots at merge/split boundaries for fast re-hydration of historical windows.

---

## Appendix D — Erasure (PII vault delete)

**Scenario:** Jason Williams submits a GDPR/CCPA erasure request. The CDP does not hard-delete and does not use per-consumer encryption keys. Instead, identity-class PII (name / email / phone) is centralized in a single mutable **PII vault** keyed by a surrogate token. Everything else — the observation log, golden record, analytics, OpenSearch — stores tokens and non-PII provenance only. Erasure = delete/null the vault row(s). Tokens elsewhere dereference to nothing, so there is no cross-store PII purge to propagate. (d-012, d-084)

**Strategy exercised:** soft-delete (30-day retention stage) → vault-row delete (PII gone, tokens remain) · resolver blocking-hash scrub (d-117) · `person_id` shell + tokenized history retained for bitemporal integrity · erasure-no-resurrect (blocking hashes scrubbed so deleted value cannot re-resolve) · Temporal saga orchestration

```
Erasure request received: 2026-03-01
  consumer_id:  c_01JK9NWILL01
  request_type: ccpa_delete
  submitted_by: consumer (self-service portal)

Stage 1 — Soft delete (30-day retention):
  deleted_at:        2026-03-01T10:00Z
  hard_delete_after: 2026-03-31T10:00Z
  status:            soft_deleted
  During this window: record is suppressed from all activation paths;
  consent_event ledger appended with erasure_request entry.

Stage 2 — Vault delete (executed 2026-03-31):
  PII vault rows deleted for c_01JK9NWILL01:
    first_name, last_name, primary_email, primary_phone → vault rows deleted / nulled
  Effect: all tokens referencing those vault rows dereference to nothing.
  No cross-store propagation needed — the observation log, analytics, and
  OpenSearch never held raw PII; only tokens. Tokens go stale in place.

  Bitemporal shell RETAINED:
    - All row timestamps, event IDs, source references, vehicle IDs, deal IDs intact
    - Aggregates, segments, campaign attribution remain valid (no PII required)
    - Provenance / lineage retained: observation log records "phone provided by DMS
      on 2026-01-01 via batch" by token — erasing the value leaves the lineage trail
    - Audit trail (merge_history, consent_event, identity_link) preserved — PII gone,
      structure and provenance intact

Stage 2 — Resolver blocking-hash scrub (d-117, executed alongside vault delete):
  The `person` shell carries pseudonymous one-way blocking keys outside the vault
  (email/phone hashes, metaphone, zip) so the deterministic waterfall can query them.
  They are not vault PII, but they are a re-identification path — so erasure scrubs them:
    person_email_hash → null
    person_phone_hash → null
  The `person_id` shell and tokenized history remain for bitemporal integrity.

Erasure-no-resurrect:
  Blocking hashes are scrubbed, so if a new ingest event arrives carrying
  jwilliams@outlook.com after erasure:
    → the email does NOT match the person shell (hash is gone)
    → a new independent consumer_id is minted
    → the erased record is not resurrected by a lower-trust re-ingest
    → erasure is durable across re-resolution

Orchestration:
  Temporal saga drives the sequence: vault-row delete → blocking-hash scrub →
  soft-delete flag update → consent_event ledger append.
  C2 orchestration design still applies — the mechanism change (vault delete
  instead of DEK destruction) affects only the first saga step.

Defense-in-depth (optional, off by default):
  Per-record salt (stored in the row) + external pepper (secrets manager) derive
  a per-row protection key via KDF. Pepper-clear is a coarse kill-switch for
  decommission / offboard / breach scenarios. This is defense-in-depth, not
  the erasure mechanism — erasure is the vault delete above.
```

---

## Strategy coverage map

| Strategy | Where demonstrated |
|---|---|
| Deterministic waterfall (email → phone → dealer_id → VIN) | Examples 1, 2, 3 |
| High confidence → auto-merge | Example 1 |
| Medium confidence → curation queue | Examples 2 (name variation), 3 (Sandra) |
| Below-floor → no-link, new record | Example 3 (S. Lee) |
| Heuristic recovery (blocking + scoring + feature breakdown) | Example 3 |
| Orphan storage with attribution | Example 2 (Meta FB ID), Example 3 (S. Lee) |
| Orphan late upgrade when linking evidence arrives | Example 2 (second Meta form) |
| Association provenance + human-readable justification | Examples 2, 3 (queue items) |
| Per-fact bitemporal provenance (valid_time + system_time) | Example 1 (first_name fact) |
| Identity record event sourcing + as-of replay | Appendix C |
| CCID as migration/backfill key (not join key) | Example 2 |
| Survivorship: DMS trust-tier 1 | Examples 1, 2 |
| Survivorship: null/non-null preference (non-null lower-trust beats null/blank higher-trust; never let a higher-trust NULL win) | Example 2 (Jason `mailing_address`) |
| Survivorship: channel-state recency override (most recent per channel wins; most-restrictive on conflict) | Example 2 (SMS opted_out) |
| Survivorship: curation supremacy (operator-confirmed value is highest trust — above DMS) | Example 2 (Jason first name), Appendix B (post-split) |
| Multi-tenant `consumer_dealership` + RLS isolation | Example 2 |
| Household detection (address + surname + service co-occurrence) | Appendix A |
| Merge/split with reversibility + bitemporal reattachment | Appendix B |
| Merge/split full audit trail | Examples 2, Appendix B |
| Consent ledger (append-only, hash-chained `consent_event`) | Examples 1, 2 |
| Consent at send-time (not consumer-creation time) | Examples 1, 2 |
| PII vault erasure (delete vault rows; tokens elsewhere dereference to nothing; no cross-store purge) | Appendix D |
| Resolver blocking-hash scrub on erasure (email/phone hashes nulled; `person_id` shell retained) | Appendix D |
| Erasure-no-resurrect (blocking hashes scrubbed; deleted value cannot re-resolve) | Appendix D |
| Soft-delete 30-day retention stage | Appendix D |
