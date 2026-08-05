---
source: DAS Confluence + Integration Explorer v5
page_id: 2872344590
title: Experian Conquest API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590
type: confluence-doc
pulled: 2026-06-14 (curated from Confluence + DAS Integration Explorer v5; synthesized from CDXP Conquest ingestion and bulk campaign workflow)
note: covers in-market consumer list ingestion, bulk conquest campaign targeting, lifecycle management, Mautic integration, 90-day purge, file delivery model
---

# Experian Conquest API Info

## Background

**Experian Conquest** is the **in-market consumer list platform** that powers CDXP's bulk conquest campaigns. It provides pre-identified, in-market automotive consumers for targeted outreach to expand dealership customer base beyond existing CRM records.

The integration enables CDXP-Mautic to:
- **Ingest Experian Conquest lists** (buyer intent, demographic filters)
- **Segment conquest prospects** in Mautic campaigns
- **Execute bulk conquest campaigns** (email, SMS, FB ads)
- **Track conversion** from prospect to lead
- **Auto-purge** after 90 days (list freshness, compliance)

**Status:** Production (implemented 2025, Jira CDXP-7471)

**Technology Stack:**
- **Platform:** Experian Conquest consumer list service
- **Integration:** File delivery or REST API
- **Ingestion:** CDXP-Mautic via ETL
- **Pipeline:** 3birds_etl_process (Python)
- **Hosting:** CDXP on-premise / cloud
- **Repository:** 3birdsmarketing/CDXP-Mautic, 3birdsmarketing/3birds_etl_process
- **Consumers:** CDXP-Mautic campaigns, conquest segment targeting

## Integration Architecture

```
[Experian Conquest Service]
    ↓ (in-market consumer list)
[File Delivery / REST API]
    ↓ (contact records + attributes)
[3birds ETL Process]
    ↓ (extract, validate, transform)
[CDXP-Mautic Import]
    ↓ (create contacts, tag=conquest)
[Mautic Segment]
    ↓ (segment=experian_conquest)
[Campaign Execution]
    ├─ Email campaigns
    ├─ SMS campaigns
    └─ Retargeting ads
[Conversion Tracking]
    ↓ (prospect → lead → customer)
[90-Day Purge]
    ↓ (auto-delete aged conquest records)
```

## Primary Integration Points

### 1. Experian Conquest Service (External)

**Role:** In-market consumer list provider
- **Data Source:** Experian's proprietary consumer database
- **List Types:** Buyer intent, demographic filters, geo-targeted
- **Delivery:** File (SFTP, S3) or REST API
- **Format:** CSV with standardized fields (email, phone, name, address, vehicle interest)
- **Update Frequency:** Monthly refreshes (new in-market consumers)

### 2. 3birds ETL Process (Internal)

**Role:** Data extraction and transformation pipeline
- **Language:** Python
- **Repository:** 3birdsmarketing/3birds_etl_process
- **Tasks:**
  - Extract Conquest list from Experian (SFTP/S3)
  - Validate email/phone format
  - Deduplicate against existing Mautic contacts
  - Transform to Mautic contact schema
  - Enrich with LookupID (Experian tracking)

### 3. CDXP-Mautic (Internal)

**Role:** Campaign execution and tracking
- **Contact Import:** Bulk import via ETL
- **Segment:** `segment=experian_conquest`, `c_contact_type=conquest`
- **Fields:** LookupID, vehicle_interest, buyer_intent_score, demographic_data
- **Campaigns:** Email, SMS, form capture
- **Conversion:** Track when prospect becomes lead/customer
- **Purge:** Auto-delete after 90 days (via scheduled command)

## API Reference

### Delivery Methods

#### File Delivery (Primary)

**Method:** SFTP or S3

**File Format:** CSV with headers

```
email,first_name,last_name,phone,street_address,city,state,zip,vehicle_interest,buyer_intent_score,source_date
john@example.com,John,Smith,602-555-0099,123 Main St,Phoenix,AZ,85014,2025 Honda Civic,85,2026-06-01
```

**Key Fields:**
- `email` — Contact email (required for email campaigns)
- `phone` — Phone number (required for SMS)
- `first_name`, `last_name` — Contact name
- `street_address`, `city`, `state`, `zip` — Mailing address
- `vehicle_interest` — Interested vehicle (e.g., "2025 Honda Civic")
- `buyer_intent_score` — Purchase likelihood (0–100)
- `source_date` — When prospect entered buyer intent (for list age tracking)

#### REST API (Optional)

**Endpoint:** Experian Conquest REST API

**Authentication:** API Key (in Authorization header)

**Request:**
```bash
GET https://api.experian.com/conquest/v1/lists/{list_id}/contacts
  ?offset=0
  &limit=1000
  &format=json
```

**Response:** `200 OK`
```json
{
  "contacts": [
    {
      "id": "conquest-001",
      "email": "john@example.com",
      "first_name": "John",
      "last_name": "Smith",
      "phone": "602-555-0099",
      "address": {
        "street": "123 Main St",
        "city": "Phoenix",
        "state": "AZ",
        "zip": "85014"
      },
      "vehicle_interest": {
        "year": 2025,
        "make": "Honda",
        "model": "Civic",
        "body_type": "Sedan"
      },
      "buyer_intent_score": 85,
      "source_date": "2026-06-01T00:00:00Z"
    }
  ],
  "pagination": {
    "total": 5000,
    "offset": 0,
    "limit": 1000
  }
}
```

### Mautic Import API

**Endpoint:** `POST /api/v2/contacts/batch/new`

**Request Body (after ETL transformation):**
```json
{
  "contacts": [
    {
      "email": "john@example.com",
      "firstName": "John",
      "lastName": "Smith",
      "phone": "602-555-0099",
      "address": "123 Main St",
      "city": "Phoenix",
      "state": "AZ",
      "zipcode": "85014",
      "custom_segment": "experian_conquest",
      "custom_contact_type": "conquest",
      "custom_vehicle_interest": "2025 Honda Civic",
      "custom_buyer_intent_score": "85",
      "custom_lookup_id": "conquest-001",
      "custom_source_date": "2026-06-01T00:00:00Z"
    }
  ]
}
```

**Response:** `200 OK`
```json
{
  "contacts": [
    {
      "id": 12345,
      "email": "john@example.com",
      "firstName": "John",
      "isContact": true,
      "dateAdded": "2026-06-14T12:00:00-05:00"
    }
  ]
}
```

### Purge Command

**Endpoint:** Mautic CLI command

**Command:**
```bash
php bin/console mautic:experian:purge-conquest --age-days=90
```

**Behavior:**
1. Query contacts where `segment=experian_conquest`
2. Filter where `source_date < (today - 90 days)`
3. Delete matching contacts
4. Log purged contact count
5. Send notification to compliance team

**Response:**
```
Experian Conquest Purge
Contacts deleted: 547
Purge window: June 1 - Sept 1, 2025
Compliance logged: purge-2026-06-14-001
```

## Data Flow

### Monthly Conquest List Ingestion

1. **Experian Delivery:** Monthly Conquest list published to SFTP
2. **ETL Extract:** 3birds_etl_process runs scheduled job (e.g., 1st of month)
3. **File Download:** ETL downloads list from SFTP
4. **Validation:** 
   - Email format validation
   - Phone number normalization
   - Address parsing
5. **Deduplication:**
   - Query existing Mautic contacts by email
   - Skip contacts already in system
   - Keep only new prospects
6. **Transformation:**
   - Map Experian fields to Mautic schema
   - Add: segment=experian_conquest, contact_type=conquest
   - Generate LookupID for Experian tracking
7. **Mautic Import:** Batch upload via API
8. **Segment Assignment:** All contacts tagged with conquest segment
9. **Notification:** Send import summary (count, duplicates skipped, etc.)

### Campaign Execution Flow

1. **Segment Filter:** Marketer selects segment=experian_conquest in Mautic
2. **List Size:** 500 new prospects identified
3. **Campaign Create:** Email campaign "2025 Honda Interest" created
4. **Send:** Campaign sent to conquest segment
5. **Tracking:** Opens, clicks, form submissions tracked
6. **Lead Conversion:** Form submission converts prospect to lead
7. **CRM Sync:** Lead synced to dealership CRM
8. **Lifecycle:** Prospect marked as "Converted" in Mautic
9. **Purge:** After 90 days, contact auto-deleted (list freshness)

### Buyer Intent Segmentation

1. **Import:** Conquest contacts include buyer_intent_score (0–100)
2. **Segmentation:**
   - High intent: score 80–100 (email priority, SMS allowed)
   - Medium intent: score 50–79 (email only)
   - Low intent: score 0–49 (nurture, no direct outreach)
3. **Campaign Strategy:**
   - High intent: Immediate outreach, dealer contact
   - Medium intent: Nurture sequence, build relationship
   - Low intent: Lead magnet, build awareness
4. **Performance:** Track conversion by intent tier

## Use Cases in DAS

### Monthly Conquest Campaign

**Flow:**
1. June 1: Experian publishes new Conquest list (5,000 prospects)
2. ETL runs: imports 4,500 new prospects (500 duplicates skipped)
3. Mautic tags: all 4,500 with segment=experian_conquest
4. Marketer creates campaign: "2025 Honda Civic Buyers"
5. Campaign targets: buyer_intent_score >= 75, state=AZ
6. 2,300 emails sent to matching prospects
7. Week 1: 15% open rate, 8% click-through
8. Week 2: 47 form submissions convert to leads
9. Leads synced to dealership CRM
10. Sept 14: Remaining 2,253 non-converted prospects auto-deleted (90 days)

### Geographic Targeting

**Flow:**
1. Dealership in Phoenix, AZ requests "AZ-only" conquest list
2. Experian filters Conquest to AZ residents only
3. ETL imports 800 AZ prospects
4. Campaign targets: state=AZ, vehicle_interest contains "Honda"
5. 250 emails sent, 22 lead conversions

### Vehicle Interest Targeting

**Flow:**
1. Dealership has inventory: 2025 Honda Civic, 2025 Toyota Camry
2. Experian list includes vehicle_interest field
3. Campaign 1: Target "2025 Honda Civic" buyers (1,200 prospects)
4. Campaign 2: Target "2025 Toyota Camry" buyers (950 prospects)
5. Separate email sequences for each vehicle
6. Improved relevance, higher conversion rate

## Configuration Management

### Experian Account Setup

- **Account ID:** Provided by Experian (account.experian.com)
- **API Key:** For REST API access (if used instead of file delivery)
- **SFTP Credentials:** For file delivery method
- **List Filters:** Vehicle interest, geography, buyer intent score
- **Update Frequency:** Monthly (1st of month typical)

### Mautic Configuration

- **Conquest Segment:** `segment=experian_conquest` (auto-assigned by ETL)
- **Contact Type:** `c_contact_type=conquest` (field to identify source)
- **Retention:** 90-day lifecycle
- **Purge Job:** Scheduled cron (e.g., monthly, 15th)
- **Deduplication Strategy:** Skip if email exists in Mautic

### ETL Pipeline Configuration

- **Schedule:** Monthly (1st of month)
- **Input:** SFTP or S3 path to Conquest list
- **Validation:** Email format, phone normalization
- **Dedup Query:** Check existing Mautic emails
- **Output:** Mautic batch import API
- **Logging:** Track import metrics (imported, skipped, errors)

### Compliance & Privacy

- **GDPR:** Experian Conquest complies with GDPR
- **CCPA:** Prospects opted into Experian (compliant)
- **CAN-SPAM:** Conquest contacts are pre-consented for email
- **Retention:** 90-day purge enforces list freshness
- **Unsubscribe:** Prospect can unsubscribe; Mautic tracks suppression

## Troubleshooting

### Import Failed (Contacts Not Appearing in Mautic)

**Checklist:**
1. ETL job ran successfully (check job logs)
2. File downloaded from Experian SFTP (verify file size > 0)
3. CSV format valid (check header row)
4. Email addresses valid (check for typos, formatting)
5. Mautic API credentials valid
6. API rate limit not exceeded

**Investigation:**
1. Check 3birds_etl_process logs: `/var/log/etl/conquest-*.log`
2. Query Mautic for import status: `SELECT COUNT(*) FROM contacts WHERE segment='experian_conquest' AND dateAdded >= DATE_SUB(NOW(), INTERVAL 1 DAY);`
3. Test Mautic API manually: `curl -H "Authorization: Bearer $TOKEN" https://mautic.cdxp.com/api/v2/contacts/1`
4. Check deduplication: how many were skipped as duplicates?

### Purge Not Running (Conquest Records Not Deleting)

**Checklist:**
1. Cron job scheduled: `crontab -l | grep experian`
2. Job has execute permission: `ls -l /var/www/mautic/bin/console`
3. Database user has DELETE permission
4. Conquest segment exists and has old contacts
5. 90-day window calculation correct

**Fix:**
1. Manually run purge: `php bin/console mautic:experian:purge-conquest --age-days=90 --verbose`
2. Check MySQL permissions: `SHOW GRANTS FOR 'mautic'@'localhost';`
3. Verify contacts are 90+ days old: `SELECT COUNT(*), MIN(dateAdded) FROM contacts WHERE segment='experian_conquest';`

### Duplicates Not Detected (Same Prospect Imported Twice)

**Causes:**
- Deduplication query didn't run
- Email addresses slightly different (case, whitespace)
- Prospect was previously deleted, re-appeared in new list

**Fix:**
1. Verify deduplication query: `WHERE email = '{email}'`
2. Normalize email before dedup: lowercase, trim whitespace
3. Check if prospect was purged previously (separate table)

### Vehicle Interest Not Showing in Campaign

**Checklist:**
1. `vehicle_interest` field mapped correctly in ETL
2. Mautic custom field created: `custom_vehicle_interest`
3. CSV includes `vehicle_interest` column
4. Campaign filter correctly targets field
5. Contacts actually have vehicle_interest value (not NULL)

**Investigation:**
1. Query Mautic: `SELECT id, email, custom_vehicle_interest FROM contacts WHERE segment='experian_conquest' LIMIT 5;`
2. Verify field exists: `DESCRIBE contacts_fields WHERE name='custom_vehicle_interest';`

## Security Considerations

### Authentication & Authorization

- Experian credentials stored in secure vault (encrypted environment variables)
- SFTP credentials not hardcoded
- API key never logged or exposed in client-side code
- Mautic batch import requires valid API token

### Data Sensitivity

- Conquest contacts contain PII (names, addresses, phone, email)
- Experian data is pre-consented for marketing
- 90-day purge ensures old data not retained
- Address data may reveal home/work location

### Compliance

- **CAN-SPAM:** Conquest contacts pre-consented
- **GDPR:** Experian Conquest complies
- **CCPA:** Contacts can opt-out (Mautic suppression list)
- **TCPA:** Phone numbers can be used for SMS (prior consent)

## Related Documentation

- **Confluence:** [3rd Party Services and App Integrations](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590)
- **Jira:** [CDXP-7471 — Experian Conquest List Ingestion](https://digitalairstrike.atlassian.net/browse/CDXP-7471)
- **Repository:** [3birdsmarketing/CDXP-Mautic](https://github.com/3birdsmarketing/CDXP-Mautic)
- **Repository:** [3birdsmarketing/3birds_etl_process](https://github.com/3birdsmarketing/3birds_etl_process)

## References

- **Experian Conquest:** https://www.experian.com/marketing-services/audience/conquest
- **Conquest List Format:** CSV with email, phone, vehicle interest, buyer intent score
- **Mautic Batch Import:** https://docs.mautic.org/en/contacts#batch-create-contacts
- **Purge Schedule:** Monthly (15th) or manual via CLI command
- **List Age:** 90-day retention (auto-purge on day 91)
