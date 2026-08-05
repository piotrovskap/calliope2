---
source: DAS Confluence + Integration Explorer v5
page_id: 3141435473
title: NeverBounce API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141435473
type: confluence-doc
pulled: 2026-06-14 (curated from Confluence + DAS Integration Explorer v5; synthesized from CDXP email validation integration)
note: covers email validation, single/batch checking, suppression list management, Mautic integration, invalid/disposable email filtering
---

# NeverBounce API Info

## Background

**NeverBounce** is the **email validation platform** that ensures CDXP campaign quality by validating email addresses before they're imported into Mautic. It prevents sending to invalid, disposable, or problematic email addresses, protecting sender reputation and improving campaign deliverability.

The integration enables CDXP to:
- **Validate individual emails** at contact creation
- **Batch validate** imported contact lists
- **Identify disposable emails** (temporary/throwaway accounts)
- **Flag catch-all addresses** (generic company emails)
- **Suppress invalid emails** from campaigns
- **Track validation results** for compliance/audit

**Status:** Production (integrated via ThreeBirds.NeverBounceApi)

**Technology Stack:**
- **API:** NeverBounce v4.2
- **Integration:** ThreeBirds.NeverBounceApi (C#)
- **Deployment:** CDXP-Mautic platform
- **Validation Points:** Contact creation, list import, pre-send validation
- **Repository:** 3birdsmarketing/Main (ThreeBirds.NeverBounceApi)
- **Consumers:** CDXP-Mautic campaigns, Conquest list ingestion, form submissions

## Integration Architecture

```
[Contact Input]
    ├─ Form submission
    ├─ List import
    └─ Manual entry
    ↓
[NeverBounce Validation API]
    ├─ Single check: GET /v4.2/single/check
    └─ Batch check: POST /v4.2/jobs/create
    ↓
[Validation Result]
    ├─ Valid (confirmable)
    ├─ Invalid (bad format, syntax error)
    ├─ Disposable (temporary/throwaway)
    ├─ Catch-all (unknown)
    └─ Spamtrap (honeypot)
    ↓
[Mautic Suppression]
    ├─ Add to suppression list (invalid, spamtrap)
    └─ Flag with risk score (disposable, catch-all)
    ↓
[Campaign Filtering]
    ↓
[Higher Deliverability]
```

## Primary Integration Points

### 1. NeverBounce API (External)

**Role:** Email validation service
- **API Endpoint:** `https://api.neverbounce.com/v4.2`
- **Authentication:** API Token (Bearer token)
- **Validation Methods:** Single check, batch jobs
- **Results:** Valid, Invalid, Disposable, Catch-all, Spamtrap
- **Rate Limiting:** Depends on subscription tier

### 2. ThreeBirds.NeverBounceApi (Internal)

**Role:** C# wrapper for NeverBounce API
- **Repository:** 3birdsmarketing/Main
- **Functions:** Single email validation, batch job management
- **Integration Point:** Called during contact creation, list import
- **Caching:** Optional result caching to reduce API calls

### 3. CDXP-Mautic (Internal)

**Role:** Campaign platform with validation integration
- **Contact Import:** Validate emails before adding to Mautic
- **Suppression:** Add invalid/spamtrap emails to do-not-contact list
- **Flag System:** Mark disposable/catch-all with risk score
- **Campaign Filter:** Exclude suppressed emails from sends
- **Pre-Send:** Optional pre-campaign validation sweep

## API Reference

### Base URL

```
https://api.neverbounce.com/v4.2
```

### Authentication

**Method:** Bearer Token

**Header:**
```
Authorization: Bearer YOUR_API_TOKEN
```

### Key Endpoints

#### GET Single Email Check

**Endpoint:** `GET /single/check`

**Query Parameters:**
- `email` (required) — Email address to validate
- `account_id` (required) — NeverBounce account ID
- `api_token` (required) — API token

**Response:** `200 OK`
```json
{
  "success": true,
  "result": {
    "result": 0,
    "explanation": "The address passed all of NeverBounce's checks.",
    "email": "john@example.com",
    "is_disposable": false,
    "has_dns": true,
    "has_dns_mx": true,
    "smtp_check": "valid",
    "result_integer": 0,
    "confidence_level": 0.98
  },
  "timestamp": "2026-06-14T12:00:00Z"
}
```

**Result Codes:**
- `0` — Valid (confirmable)
- `1` — Invalid (bad format, doesn't exist)
- `2` — Disposable (temporary/throwaway address)
- `3` — Catch-all (unknown if valid)
- `4` — Spamtrap (honeypot address)

#### POST Batch Job Create

**Endpoint:** `POST /jobs/create`

**Request Body:**
```json
{
  "account_id": "YOUR_ACCOUNT_ID",
  "api_token": "YOUR_API_TOKEN",
  "input": [
    "john@example.com",
    "sarah@example.com",
    "invalid@",
    "temp@10minutemail.com"
  ],
  "filename": "conquest-list-2026-06",
  "run": true
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "result": {
    "job_id": "12345abcde",
    "created": "2026-06-14T12:00:00Z",
    "filename": "conquest-list-2026-06",
    "total": 4,
    "status": "running"
  }
}
```

#### GET Job Status

**Endpoint:** `GET /jobs/status`

**Query Parameters:**
- `job_id` (required) — Job ID from create
- `account_id` (required)
- `api_token` (required)

**Response:** `200 OK`
```json
{
  "success": true,
  "result": {
    "job_id": "12345abcde",
    "status": "complete",
    "total": 4,
    "processed": 4,
    "results": {
      "0": 2,
      "1": 1,
      "2": 1,
      "3": 0,
      "4": 0
    },
    "percent_complete": 100
  }
}
```

#### GET Job Results

**Endpoint:** `GET /jobs/results`

**Query Parameters:**
- `job_id` (required)
- `account_id` (required)
- `api_token` (required)

**Response:** `200 OK`
```json
{
  "success": true,
  "result": [
    {
      "email": "john@example.com",
      "result": 0,
      "explanation": "Valid",
      "is_disposable": false,
      "confidence_level": 0.98
    },
    {
      "email": "sarah@example.com",
      "result": 0,
      "explanation": "Valid",
      "is_disposable": false,
      "confidence_level": 0.95
    },
    {
      "email": "invalid@",
      "result": 1,
      "explanation": "Invalid — bad format",
      "is_disposable": false,
      "confidence_level": 1.0
    },
    {
      "email": "temp@10minutemail.com",
      "result": 2,
      "explanation": "Disposable",
      "is_disposable": true,
      "confidence_level": 0.99
    }
  ]
}
```

## Data Flow

### Single Email Validation (Contact Creation)

1. **Contact Submitted:** Form submission or manual entry
2. **Extract Email:** Capture email address
3. **NeverBounce Check:** Call `GET /v4.2/single/check`
4. **Evaluate Result:**
   - **Valid (0):** Add contact to Mautic normally
   - **Invalid (1):** Add to suppression list, skip import
   - **Disposable (2):** Flag with risk score, allow import but mark
   - **Catch-all (3):** Allow import, manual review optional
   - **Spamtrap (4):** Add to suppression list, log as risk
5. **Mautic Import:** Add contact with validation metadata
6. **Campaign Readiness:** Contact ready for campaigns (if not suppressed)

### Batch List Validation (Import)

1. **List Received:** Conquest list or bulk import
2. **Create Job:** Call `POST /jobs/create` with email list
3. **Job Running:** NeverBounce processes batch
4. **Monitor Progress:** Poll `GET /jobs/status` until complete
5. **Retrieve Results:** Call `GET /jobs/results` when done
6. **Process Results:**
   - Valid (0) → Import to Mautic
   - Invalid (1) → Skip, log error
   - Disposable (2) → Import with flag
   - Catch-all (3) → Import with note
   - Spamtrap (4) → Add to suppression, alert
7. **Import Summary:** Report validation metrics (valid/invalid/disposable %)

### Pre-Campaign Validation Sweep

1. **Campaign Created:** Marketer creates campaign in Mautic
2. **List Segmented:** Segment selected (e.g., "Conquest Prospects")
3. **Pre-Send Validation:** Optional background job re-validates emails
4. **Update Suppression:** Add newly-invalid emails to do-not-contact
5. **Final List:** Removes emails that became invalid since import
6. **Send:** Campaign sends to remaining valid addresses

## Use Cases in DAS

### Conquest List Quality

**Flow:**
1. Experian Conquest list arrives (5,000 emails)
2. Batch validation job created
3. Results: 4,200 valid, 500 invalid, 200 disposable, 100 catch-all
4. Import: 4,200 valid + 200 disposable (flagged) to Mautic
5. Suppression: 500 invalid + 100 spamtrap added to do-not-contact
6. Campaign ready with 4,400 vetted prospects
7. Higher deliverability vs. unvalidated list

### Form Submission Validation

**Flow:**
1. Lead submits form with email
2. Real-time validation: `GET /single/check`
3. If valid: confirm submission, add to Mautic
4. If invalid: reject with "Please enter a valid email"
5. If disposable: accept but flag for manual review
6. User gets immediate feedback on validity

### Bulk Campaign Pre-Send Validation

**Flow:**
1. Campaign "2025 Honda Conquest" created (4,400 recipients)
2. Marketer requests pre-send validation
3. Batch job re-validates all emails
4. 150 emails now show as invalid (inactive accounts)
5. Pre-send sweep adds them to suppression
6. Final send: 4,250 recipients (higher confidence)

## Configuration Management

### NeverBounce Account Setup

- **Account ID:** Provided by NeverBounce
- **API Token:** Long-lived token (bearer auth)
- **Validation Tier:** Single check, batch, real-time
- **Credit System:** Validates consume credits (per email or unlimited)
- **Rate Limits:** Depends on plan (typically 100 req/sec)

### Mautic Configuration

- **Validation on Create:** Enable/disable single email checks
- **Batch Validation:** Trigger on list import
- **Suppression List:** Auto-add invalid/spamtrap emails
- **Risk Flagging:** Mark disposable/catch-all with score
- **Pre-Send Validation:** Optional campaign pre-send sweep
- **Caching:** Optional result cache (24–48 hr)

### Privacy & Compliance

- **GDPR:** NeverBounce complies with GDPR
- **Data Retention:** NeverBounce may retain validation results (check ToS)
- **Email Privacy:** Results contain email + validation metadata
- **Suppression:** Suppressed emails never receive campaigns

## Troubleshooting

### Single Check Failing (Invalid Token)

**Error:** `{"success": false, "error": "Invalid token"}`

**Fix:**
1. Verify API token is correct
2. Check token not expired (check NeverBounce account)
3. Regenerate token in NeverBounce dashboard if needed
4. Update ThreeBirds.NeverBounceApi config with new token

### Batch Job Stuck (Never Completes)

**Checklist:**
1. Check job status: `GET /jobs/status?job_id=...`
2. Verify account has sufficient credits
3. Check email list size (very large lists take time)
4. Try smaller batch if stuck

**Fix:**
1. Wait for job to complete (can take hours for large lists)
2. Check quota: account may be out of credits
3. Reduce batch size

### High Disposable Rate (>20%)

**Causes:**
- Conquest list has many throwaway addresses
- Form allows fake emails (no confirmation)
- Old list with stale data

**Actions:**
1. Review disposable emails in results
2. Consider requiring email confirmation
3. Increase send frequency (older emails more likely invalid)

### Suppression Not Applied

**Checklist:**
1. Verify invalid emails added to Mautic suppression list
2. Check campaign filter includes suppression list
3. Verify Mautic import actually flagged invalid emails

**Fix:**
1. Manually add suppressed emails to do-not-contact
2. Test campaign send to verify filtering

## Security Considerations

### Authentication & Authorization

- API token stored securely (environment variable, vault)
- Token never logged or exposed
- Rotate token periodically (best practice: quarterly)
- Single token per environment (dev/staging/prod)

### Data Sensitivity

- Email addresses transmitted to NeverBounce (external service)
- Validation results contain emails + metadata
- NeverBounce may retain results per ToS
- No sensitive data (names, phones) in validation call

### Compliance

- **GDPR:** NeverBounce compliant; data transfer agreement required
- **CAN-SPAM:** Suppression list ensures compliance (no invalid addresses)
- **Email Privacy:** Emails shared with third party for validation

## Related Documentation

- **Confluence:** [Mautic Deep Dive (NeverBounce dependency)](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141435473)
- **Repository:** [ThreeBirds.NeverBounceApi](https://github.com/3birdsmarketing/Main)
- **Repository:** [CDXP-Mautic](https://github.com/3birdsmarketing/CDXP-Mautic)
- **NeverBounce Docs:** [API Documentation](https://neverbounce.com/api)

## References

- **NeverBounce API:** https://api.neverbounce.com/v4.2
- **Account Portal:** https://account.neverbounce.com
- **Result Codes:** 0=Valid, 1=Invalid, 2=Disposable, 3=Catch-all, 4=Spamtrap
- **Rate Limit:** Varies by plan (check dashboard)
- **Credits:** Per-email or unlimited (plan-dependent)
