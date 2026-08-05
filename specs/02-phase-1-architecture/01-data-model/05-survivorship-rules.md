---
title: "Survivorship & source-trust ranking"
type: story
status: done
priority: high
estimate: M
labels: [identity, survivorship, data-model, phase-0-architecture]
date: ~
artifacts:
  - "Identity Resolution Strategy | docs/deliverables/identity-resolution-strategy.md"
---
**Closed 2026-06-18 (done):** survivorship + source-trust ranking locked (DMS = ground truth).

# DAS CDP — Survivorship & Source-Trust Ranking

Field Catalog v1 (initial 27 fields) · Working Document · DRAFT

Owner: Alicia Salazar + Luis Hernandez Review: Leo Mata Due: 2026-06-19

 _Context: This document defines, for each of the 27 Field Catalog v1 fields, which source wins when multiple sources carry a value (the 'golden' value), the fallback chain when the primary source is null, and the survivorship rule type. It feeds directly into (a) the bitemporal provenance schema Luis is designing, (b) the identity-resolution strategy, and (c) the golden-record portal view._

## 1\. Global Source-Trust Hierarchy

DMS is the ground truth for all consumer and vehicle data, per Dan Aston (June 12 sync). The ranking below applies globally; the per-field rules in Section 3 inherit from it and specify overrides.

**Trust Tier**| **Source System**| **Source Tables / Feeds**| **Survivorship Notes**
---|---|---|---
**1 — GROUND TRUTH**| **DMS (Authenticom / CDK)**|  source_dms_sales, source_dms_service| Transactions with dollars attached — highest authority per Dan Aston. Ingest from raw tables, not CVH.
**2 — SECONDARY**| **CRM (21+ providers)**|  source_CRM_* (eLeads, VinSolutions, DealerSocket, DriveCentric, Momentum, R&R, …)| Lead / prospect data. Lower trust — CRM data is frequently dirty or stale. Fills non-identity fields when DMS is null; never promoted for identity keys (email, phone, VIN).
**3 — ENRICHMENT**| **BlackBook**|  EDW_staging.stage_Vehicle_Valuation| Provider-authoritative for equity and market value only. DMS has no equivalent. No competition with DMS.
**3 — ENRICHMENT**| **RecallMasters**|  acceleratordb.leads_recall_data| Provider-authoritative for open recall status by VIN. NHTSA-sourced. No DMS equivalent.
**4 — ENGAGEMENT**| **Email / SMS events**|  MailGun webhooks, Twilio, Mautic matchback (utm_term=c_hashkey)| Engagement signals — lowest trust for identity; high value for lifecycle events. Phase 1 candidate, not v1 core.
**4 — ENGAGEMENT**| **Lead events / ADF**|  DAS Acceptor → Event Bus, ADF/XML parsers (TrueCar, Cars.com, …)| Lead-arrival signals. Identity keys (email/phone) used for matching, not as golden values.
**5 — SOCIAL / AD**| **Meta / Facebook**|  Lead forms API — email/phone at click time| Orphan identifiers (Facebook reviewer IDs) stored unresolved; may resolve later. Page-scoped IDs never promoted to golden. Lowest identity trust.

**Critical constraint:**

  * The CDP ingests from raw source tables (source_dms_*, source_CRM_*), NOT from the CVH merged layer.
  * CVH uses DealerID+email-hash identity — structurally limited to within-dealer resolution.
  * The bitemporal observation layer in the CDP replaces CVH's merge role with an explicit, reversible identity graph.



## 2\. Survivorship Rule Types

Each field in the catalog is assigned one of the six rule types below. The rule type governs how the golden record resolution engine selects the winning value at ingest time.

**DMS ONLY**|  Identity key field — DMS is the sole accepted source. No CRM or other fallback. Missing DMS value → store as unresolved candidate, route to curation queue.
---|---
**HIGHEST TRUST**|  Multiple sources exist; DMS always wins regardless of recency. Non-DMS sources fill only when DMS is null.
**MOST RECENT**|  Time-sensitive field — most recent DMS record wins (e.g. latest service record for mileage). DMS-only; recency is the tiebreaker.
**PROVIDER AUTH**|  Enrichment provider is the sole authoritative source (BlackBook for equity, RecallMasters for recalls). DMS does not carry this data.
**DERIVED**|  Computed from other golden record fields at ingest time. No direct source column — derived logic must be defined.
**GAP**|  No current DAS source. Requires new provider integration or is deferred to post-v1. No value in CDP until source is confirmed.

## 3\. Per-Field Survivorship Rules — Field Catalog v1

Field source matrix, ETL inventory, session decisions.

**#**| **Field**| **CDP Target Column**| **Sources Available**| **Golden Record Winner**| **Fallback Chain**| **Rule Type**| **Open Questions / Notes**
---|---|---|---|---|---|---|---
**2.1 Vehicle & Owner Info (fields 1–13)**
**1**| **CustomerFirstName**|  consumer.first_name| DMS sales (source_dms_sales)DMS service (source_dms_service)CRM (21+ providers)| **Most recent DMS record (sales or service)**|  CRM if DMS null — acceptable, name is not an identity key| **MOST RECENT**|  Risk: name change after marriage/divorce. Most recent DMS wins; flag when DMS sales vs service conflict on same person.
**2**| **CustomerLastName**|  consumer.last_name| DMS salesDMS serviceCRM (21+ providers)| **Most recent DMS record**|  CRM if DMS null| **MOST RECENT**|  Same as FirstName. Track maiden/married conflicts as a curation queue signal.
**3**| **CustomerEmail**|  consumer.primary_email [identity key]| DMS sales (DMS_Fact_EmailAddresses)DMS serviceCRM| **DMS only — most recent DMS transaction email**|  NO CRM fallback. If DMS null, store as unresolved candidate with low-confidence tag.| **DMS ONLY**|  CRITICAL: CRM email is frequently dirty or stale and will poison identity graph if promoted. If customer updated email in CRM but not in DMS, route to human curation queue — never auto-promote. Decide: what threshold of DMS-null drives escalation vs. blank?
**4**| **CustomerCellPhone**|  consumer.primary_phone [identity key]| DMS sales (sp_update_DMS_Fact_CellPhone)DMS serviceCRM| **DMS only — most recent DMS transaction phone**|  NO CRM fallback. If DMS null, store as candidate only.| **DMS ONLY**|  Same reasoning as email. E.164 normalization required at ingest. Area-code changes (phone-last-7 is a blocking key in the identity strategy) — confirm normalization handles this.
**5**| **VehicleYear**|  vehicle.year| DMS sales (DMS_Fact_Vehicles)DMS serviceCRM| **DMS (either sales or service — consistent field)**|  CRM if DMS null — low risk, year rarely wrong| **HIGHEST TRUST**|
**6**| **VehicleMake**|  vehicle.make| DMS sales (DMS_Fact_Vehicles)DMS serviceCRM| **DMS**|  CRM if DMS null| **HIGHEST TRUST**|
**7**| **VehicleModel**|  vehicle.model| DMS sales (DMS_Fact_Vehicles)DMS serviceCRM| **DMS**|  CRM if DMS null| **HIGHEST TRUST**|
**8**| **TrimLevel**|  vehicle.trim| DMS (CDK 3PA vs Authenticom — reliability varies)CRM| **DMS (if present and non-null)**|  CRM if DMS null — trim is not an identity field| **HIGHEST TRUST**|  To confirm: CDK 3PA delivers trim more reliably than Authenticom in some cases. Need to confirm per-provider trim fill rate before locking rule. Is CRM trim populated from the DMS or independently entered?
**9**| **VehicleVIN**|  vehicle.vin [identity key]| DMS sales (DMS_Fact_Vehicles)DMS serviceCRM| **DMS only**|  NO CRM fallback — never accept a VIN from CRM| **DMS ONLY**|  VIN is a hard identity key and a match signal in the resolution waterfall. CRM VINs are frequently mis-keyed or copied incorrectly. DMS is the only authoritative source (DMS reads directly from deal record). To confirm what should the business case be in case VIN is null in DMS but present in CRM? → store as orphan candidate, do not promote.
**10**| **PurchaseDate**|  consumer_vehicle.acquired_at| DMS sales (ClosedDate / DealBookDate / ContractDate)| **DMS sales — ClosedDate is the authoritative financial close date**|  No fallback — leave null if DMS sales null| **DMS ONLY**|  Three date fields in source (ClosedDate, DealBookDate, ContractDate)
Close Date would be the primary, ContractDate as fallback within DMS sales.
**11**| **VehicleMileage**|  vehicle.mileage| DMS service (updated each service visit)DMS sales (snapshot at sale)| **Most recent DMS service record (highest-observation-date mileage reading)**|  DMS sales snapshot if no service record exists| **MOST RECENT**|  This field is time-sensitive — the golden value is the most recent odometer reading, not the sale mileage.
**12**| **PurchasePrice**|  consumer_vehicle.metadata->>'purchase_price'| DMS sales (FrontGross + BackGross // ROAmount)| **DMS sales only — financial record, single authoritative source**|  No fallback| **DMS ONLY**|  Is FrontGross+BackGross universally accessible across all dealer configurations, or is it gated per dealer agreement?
ROAmount may be the safer field. Cannot be exposed to non-admin roles in the golden record view.
**13**| **VehicleCondition**|  vehicle.vehicle_type (new / used / CPO)| Derived from DMS sales deal type| **Derive from deal type flag in DMS sales (new deal = New, used deal = Used)**|  CPO may need a separate indicator — check DMS source field| **DERIVED**|  No raw source field — derive at ingest.
**2.2 Service & Parts (fields 14–18)**
**14**| **OemMaintenanceSchedule**|  consumer_attribute| NONE — Analytics_BlueSky_LifecyclePosition is a prediction, not a source| **GAP — no raw OEM schedule source**|  N/A| **GAP**|  Current BlueSky lifecycle position is a derived prediction (not raw schedule). True OEM maintenance schedule requires VIN-to-OEM lookup (e.g., ALLDATA, OEM API). Candidate: derive approximate schedule from VehicleYear+Make+Model+Mileage using a lookup table.
**15**| **CompletedServices**|  consumer_attribute| DMS service (source_dms_service → DMS_Fact_Services)[VSS marked unsupported but ETL exists]| **DMS service feed**|  No alternative source| **HIGHEST TRUST**|  VSS data mapping marked this unsupported, but DMS_Fact_Services exists in the ETL.
**16**| **DeclinedServices**|  consumer_attribute| DMS service (sp_insert_staging_DMS_Declined_Services → Declined_Service_Flattened)[ETL flattens declined opcodes from Tekion/manual]| **DMS service — declined service ETL**|  No alternative source| **HIGHEST TRUST**|  ETL exists and flattens declined services, but coverage may be Tekion-specific or manual-entry dependent. This is a high-value field for service marketing
**17**| **OpenRecallsByVIN**|  consumer_attribute| RecallMasters (acceleratordb.leads_recall_data)| **RecallMasters — sole source, provider-authoritative**|  No fallback; leave null if recall data not available for VIN| **PROVIDER AUTH**|  Available via PostgreSQL recall dashboard (leads_recall_mysql).
**18**| **CompletedRecallsByVIN**|  consumer_attribute| NONE — no current source| **GAP**|  N/A| **GAP**|  Completed recall status typically requires DMS service feed with recall opcode matching, or a paid provider (RecallMasters may have a completed-recall feed)..
**2.3 Service History (fields 19–21)**
**19**| **CompletedServicesWithMedia**|  consumer_attribute| NONE — media (photos, videos) not captured| **GAP**|  N/A| **GAP**|  Requires a media capture integration (e.g., MPI/inspection tools like DealerSocket Fixed Ops, Xtime, or dealer-specific apps). No current DAS feed. Possible/Maybe for next sys improvements
**20**| **ServiceCoupons**|  consumer_attribute| NONE — no current source| **GAP**|  N/A| **GAP**|  Would require integration with DMS service marketing module or coupon platform. Not in current ETL. Possible/Maybe for next sys improvements
**21**| **ServicePlanOffering**|  consumer_attribute| COX? | **GAP — provider TBD**|  N/A| **GAP**|  COX Automotive is the suspected provider but unconfirmed.
**2.4 Protect the Vehicle (field 22)**
**22**| **ServiceOrWarrantyPlanOfferings**|  consumer_attribute| COX?| **GAP — provider TBD**|  N/A| **GAP**|  Same as ServicePlanOffering — COX unconfirmed. May overlap or consolidate with field 21..
**2.5 Equity, Trade-In & Insurance (fields 23–27)**
**23**| **EquityAmount**|  consumer_attribute| BlackBook (EDW_staging.stage_Vehicle_Valuation → sp_Calculate_Equity → Vehicle_Valuation)| **BlackBook — sole authoritative source for equity calculation**|  No fallback — leave null if BlackBook unavailable| **PROVIDER AUTH**|  OK — existing pipeline confirmed. Refresh cadence: BlackBook valuations are time-sensitive (market moves).. Does the CDP ingest the raw BlackBook valuation or DAS's calculated equity? Recommend raw + recalculate in CDP for transparency.
**24**| **MarketValue**|  consumer_attribute| BlackBook (stage_Vehicle_Valuation)| **BlackBook — sole authoritative source**|  No fallback| **PROVIDER AUTH**|  OK — same pipeline as EquityAmount. Confirm VIN is the join key (not year/make/model approximation). MarketValue and EquityAmount are tightly coupled — always ingest together.
**25**| **VehicleUpgradeOptions**|  consumer_attribute| ResponseLogix? | **GAP — provider TBD**|  N/A| **GAP**|  ResponseLogix is the suspected source but unconfirmed.
**26**| **InsuranceProvider**|  consumer_attribute| NONE — no current DAS source| **GAP — net-new integration required**|  N/A| **GAP**|  Insurance provider data is not currently captured in any DAS feed. Requires a new integration
**27**| **InsuranceQuoteList**|  consumer_attribute| NONE — no current DAS source| **GAP — net-new integration required**|  N/A| **GAP**|  Same as InsuranceProvider — no source. Likely a product integration (dealer F&I software or third-party quote engine).

## 4\. How This Feeds the Build

Bitemporal schema: Each "winner" field maps to a golden_value column on the observation/provenance table. The fallback chain determines the ingest-time precedence order encoded in the DAG logic. DMS-ONLY fields must be enforced at the API ingestion boundary — the source-registry config will carry a reject_non_dms flag per field.

Identity strategy: DMS-ONLY fields (email, phone, VIN) are the deterministic waterfall keys (Step 1 in the identity-resolution strategy spec). These are the fields where source trust is absolute, not probabilistic. The MOST RECENT rule on mileage confirms the bitemporal model's 'as-of' time-travel is required — not optional.

Golden record view (portal): The fallback chain drives the per-field source attribution display in the portal view. When the winner is a CRM fill (not DMS), the view should surface a lower-confidence badge. GAP fields appear as "Not yet available — [provider TBD]" rather than blank.

Source registry (config-driven onboarding): Each source gets a provenance_class tag (DAS-global / dealer-isolated) and a field_trust_tier. The survivorship rules here are the input to that config.

**Acceptance:** all 27 Field Catalog v1 fields carry an assigned rule type (one of the six in §2) with a named golden-record winner and explicit fallback chain; the global source-trust hierarchy (§1, DMS=ground truth) is encoded as field_trust_tier in the source-registry config; DMS-ONLY identity fields (email, phone, VIN) are enforced at the ingest boundary via a reject_non_dms flag (no CRM value is ever promoted to those golden columns); and GAP fields resolve to "Not yet available — [provider TBD]" rather than a CRM fill.

**References:**
- Decided 2026-06-12 (Dan Aston sync): DMS is ground truth for all consumer and vehicle data (transactional, dollars-attached) — `memory/decisions.md`
- Locked 2026-06-17 (Luis + Alicia): survivorship + source-trust ladder DMS → CRM → engagement → third-party, most-recent-within-tier tie-breaker, per-element provenance retained — `memory/decisions.md#d-107`
- Locked 2026-06-18 (Alicia + Luis): survivorship locked alongside the 15-table data model — `memory/decisions.md#d-107`
- `wiki/Identity-Resolution.md` (§Survivorship & Source Trust) — canonical source-trust ranking and per-field winner logic
- `docs/deliverables/identity-resolution-strategy.md` — deliverable framing of the survivorship ladder and lock dates
