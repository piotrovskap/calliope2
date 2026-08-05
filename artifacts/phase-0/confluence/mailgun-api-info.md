---
source: DAS Confluence + Integration Explorer v5
page_id: multiple (2981232673, 2872344590)
title: MailGun API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590
type: confluence-doc
pulled: 2026-06-13 (curated from Confluence + DAS Integration Explorer v5)
note: content synthesized from CDXP integration documentation and Integration Explorer research; covers bulk campaign email delivery via Mautic plugin
---

# MailGun API Info

## Background

MailGun is DAS's **bulk campaign email delivery platform** for CDXP, responsible for high-volume email campaigns (retention, service reminders, engagement). Unlike SendGrid (transactional) and Mandrill (lead alerts), MailGun handles **bulk campaign mail** through the CDXP-Mautic integration.

Primary use case:
- **CDXP-Mautic** — Bulk campaign email delivery (service reminders, retention campaigns, engagement campaigns)

MailGun provides:
- Domain-based sending (dealer-branded `@mg.valleyhonda.com` subdomains)
- Event webhooks (delivered, opened, clicked, failed, unsubscribed)
- Custom tags and user variables for campaign tracking
- High throughput for bulk sends (1000+ messages per second)
- Suppression list management (bounces, unsubscribes)

## Integration Architecture

```
[CDXP-Mautic Campaign Engine]
    ↓
[MailGun API: POST /v3/{domain}/messages]
    ↓
[Bulk Email Routing]
    ↓
[SMTP Relay to Mail Servers]
    ↓
[Customer Inbox]

[Event Webhooks: delivered, opened, clicked, failed, bounced, unsubscribed]
    ↓
[Webhook Handler → Update Mautic Contact]
```

## Primary Integration Point

### CDXP-Mautic (3birdsmarketing)

Direct Mautic plugin integration for bulk campaigns:
- **Plugin:** Built-in Mautic email channel with MailGun connector
- **Domain Configuration:** Per-dealer MailGun domain (e.g., `mg.valleyhonda.com`)
- **API Key:** Stored in Mautic configuration (MailGun account API key)
- **Campaign Flow:**
  1. Mautic campaign triggers (scheduled, behavioral, scoring threshold)
  2. Campaign email action sends via MailGun API
  3. MailGun delivers email to recipients
  4. Webhooks fire on events (delivered, open, click, bounce, unsubscribe)
  5. Mautic webhook handler updates contact engagement

**Use Cases:**
- Service reminders (scheduled: "oil changes due", "tire rotation", etc.)
- Retention campaigns (inactive customer re-engagement)
- Engagement campaigns (personalized service offers)
- Seasonal campaigns (holiday specials, year-end service offers)

## API Reference

### Send Email

**Endpoint:** `POST https://api.mailgun.net/v3/{domain}/messages`

**Authentication:** HTTP Basic Auth with `api:{api_key}`

**Request (Form-encoded):**
```
from=Valley+Honda+%3Cnoreply%40mg.valleyhonda.com%3E
&to=john.doe%40example.com
&subject=John%2C+Your+Accord+Is+Due+for+Service
&html=%3Cp%3EHi+John%2C+your+2022+Honda+Accord+is+due+for+its+30%2C000-mile+service...%3C%2Fp%3E
&o:tracking=true
&o:tag=cdxp-service-reminder
&o:tag=retention-accelerator
&v:dealer_id=DLR-004521
&v:campaign_id=CDXP-SVC-REMINDER-2025
```

**Request (JSON):**
```json
{
  "from": "Valley Honda <noreply@mg.valleyhonda.com>",
  "to": ["john.doe@example.com"],
  "subject": "John, Your Accord Is Due for Service",
  "html": "<p>Hi John, your 2022 Honda Accord is due for its 30,000-mile service...</p>",
  "o:tracking": true,
  "o:tag": ["cdxp-service-reminder", "retention-accelerator"],
  "v:dealer_id": "DLR-004521",
  "v:campaign_id": "CDXP-SVC-REMINDER-2025"
}
```

**Response:** `200 OK`
```json
{
  "id": "<20130513192312.51.590109F88F8@mg.valleyhonda.com>",
  "message": "Queued. Thank you."
}
```

**Key Parameters:**
- `from` — Sender address (dealer-branded email)
- `to` — Recipient email or list of recipients
- `subject` — Email subject line
- `html` — HTML body (or `text` for plain text)
- `o:tracking` — Enable click/open tracking (true/false)
- `o:tag` — Tags for organizing/filtering messages (array)
- `v:*` — Custom user variables (prefixed with `v:`) for webhook correlation

### Event Webhooks

**Endpoint:** DAS webhook handler receives delivery events

**Example Webhook Payload:**
```json
{
  "event-data": {
    "event": "delivered",
    "recipient": "john.doe@example.com",
    "timestamp": 1717200045,
    "tags": ["cdxp-service-reminder", "retention-accelerator"],
    "user-variables": {
      "dealer_id": "DLR-004521",
      "campaign_id": "CDXP-SVC-REMINDER-2025"
    },
    "delivery-status": {
      "code": 250,
      "message": "OK"
    }
  }
}
```

**Event Types:**

| Event | Meaning | DAS Action |
|-------|---------|-----------|
| `delivered` | Email successfully delivered to recipient mail server | Update `c_last_email_delivered` timestamp in Mautic |
| `opened` | Recipient opened email (pixel-based tracking) | Update `c_last_email_open` timestamp; increment engagement score |
| `clicked` | Recipient clicked link in email | Update `c_last_email_click` timestamp; identify which link; increment engagement |
| `failed` | Email failed to send (permanent error) | Log failure; may retry or skip recipient in future campaigns |
| `unsubscribed` | Recipient clicked unsubscribe link | Add to suppression list; prevent future sends to address |
| `complained` | Recipient marked as spam (complaint) | Add to suppression list; flag account for review |
| `bounced` | Email rejected by recipient mail server | Log bounce type (hard/soft); add to suppression if permanent |

## Domain Configuration

### Sender Domain Setup

Each dealer has a dedicated or shared MailGun domain:

**Example:** `mg.valleyhonda.com`

**Configuration Required:**
1. **SPF Record** — Authorizes MailGun to send from domain
   ```
   v=spf1 include:mailgun.org ~all
   ```

2. **DKIM Record** — Signs emails for authentication
   ```
   k=rsa; p=<public-key>
   ```

3. **MX Record** — Routes replies back to dealer (optional, for inbound)
   ```
   priority 5 mxa.mailgun.org
   priority 10 mxb.mailgun.org
   ```

**Verification:** MailGun dashboard shows domain status (active, pending, failed)

### Webhook Configuration

**Webhook URL:** Must be HTTPS, publicly accessible

**Webhook Events:** Select which events to receive:
- `delivered`
- `opened`
- `clicked`
- `failed`
- `unsubscribed`
- `complained`
- `bounced`

**Verification:** MailGun signs webhook requests; DAS handler should verify signature to prevent spoofing

## Bulk Campaign Patterns

### Service Reminder Campaign

**Flow:**
1. Mautic automation rule triggers: "Vehicle service due (based on odometer threshold)"
2. Campaign sends email via MailGun with service reminder
3. Email includes:
   - Vehicle make/model/year
   - Service type recommended
   - Special offer (discount, free inspection, etc.)
   - Schedule link (dealer website booking)
4. Webhooks track:
   - `delivered` — Email reached recipient's mail server
   - `opened` — Customer opened email (engagement signal)
   - `clicked` — Customer clicked schedule link (intent signal)
5. Mautic updates contact:
   - `c_last_email_open` timestamp
   - `c_last_email_click` timestamp
   - Engagement score increases
6. Automation adjusts: "If not clicked in 3 days, send SMS reminder"

### Retention Campaign

**Flow:**
1. Mautic rule triggers: "Contact inactive >90 days"
2. Campaign sends re-engagement email via MailGun
3. Email includes:
   - "We miss you" messaging
   - Exclusive retention offer (free service, loyalty bonus)
   - Link to customer portal
4. Webhooks track opens/clicks
5. Contact engagement restored if they click
6. If unsubscribe: add to suppression, flag account

## Suppression & Compliance

### Bounce Management

**Hard Bounce (Permanent):**
- Reason: Invalid address, domain doesn't exist, recipient rejected
- Action: Add to suppression list; prevent future sends
- Recovery: Requires manual address correction

**Soft Bounce (Transient):**
- Reason: Mailbox full, server temporarily down
- Action: Retry in next campaign (within 24 hours)
- Recovery: Automatic, no user action needed

### Unsubscribe Handling

**Standard Unsubscribe Link:**
- MailGun automatically includes in email footer (required by CAN-SPAM)
- Format: `https://mg.valleyhonda.com/unsubscribe/...`
- Clicking unsubscribe triggers `unsubscribed` webhook

**DAS Response:**
1. Webhook received with `unsubscribed` event
2. Mautic handler checks custom variables (`campaign_id`, `dealer_id`)
3. Contact's suppression flag set (prevents future sends)
4. Log stored for compliance audit

### CAN-SPAM Compliance

MailGun enforces CAN-SPAM requirements:
- ✅ Unsubscribe link in every email
- ✅ Physical address (dealer address) required
- ✅ Subject line must not mislead
- ✅ Opt-out honored within 10 business days
- ✅ Accurate From/Reply-To headers

## Tagging & Custom Variables

### Tags (for Organization)

Tags help filter/organize messages in MailGun dashboard and webhooks:

```
o:tag=cdxp-service-reminder
o:tag=retention-accelerator
o:tag=may-2025
```

**Dashboard Filtering:** View messages by tag, identify which campaigns performed best

**Webhook Tags:** Tags included in webhook payload, helps Mautic route to correct automation

### Custom Variables (for Tracking)

User variables (`v:*` prefix) carry dealer/campaign context through the delivery lifecycle:

```
v:dealer_id=DLR-004521
v:campaign_id=CDXP-SVC-REMINDER-2025
v:vehicle_make=Honda
v:customer_segment=vip
```

**Webhook Correlation:** When webhook fires, Mautic reads `dealer_id` and `campaign_id` from user-variables to update correct contact in correct dealer account

**Example:** 
- Event: `opened`
- Variables: `dealer_id=DLR-004521`, `campaign_id=CDXP-SVC-REMINDER-2025`
- Action: Find contact in Mautic for Valley Honda; mark that they opened the May service reminder

## Troubleshooting

### Campaign Emails Not Sending

**Checklist:**

1. **Domain Verified** — MailGun dashboard shows domain status (Active, not Failed/Pending)
   - If Pending: Wait for DNS verification to complete
   - If Failed: Check SPF/DKIM records

2. **API Key Valid** — Mautic MailGun plugin has correct API key configured
   - Test: `curl -s https://api.mailgun.net/v3/domains -u api:<key>`
   - Should return domain list

3. **Campaign Recipient List** — Contacts in Mautic campaign segment
   - Check: Do they have email addresses?
   - Check: Are they suppressed? (c_is_email_suppressed flag)

4. **Send Time** — Campaign scheduled to send in future?
   - Mautic campaigns must have send date/time configured
   - Automation rules must have trigger conditions set

5. **Email Content** — HTML/subject valid?
   - Check Mautic logs for validation errors
   - MailGun rejects emails > 25 MB

### High Bounce Rate

**Common Causes:**
- **Invalid email addresses** — Contact data contains typos
- **Stale contact lists** — Addresses from 2+ years ago no longer active
- **Missing SPF/DKIM** — Domain not authenticated; carriers reject

**Investigation:**
1. Download bounce report from MailGun (by date/bounce type)
2. Cross-reference with Mautic contact records
3. Identify pattern (e.g., all bounces from one ISP?)
4. Review domain authentication (SPF/DKIM in MailGun console)

### Webhooks Not Received

**Checklist:**

1. **Webhook URL Configured** — Mautic MailGun settings has webhook URL
   - Must be HTTPS (not HTTP)
   - Must be publicly accessible
   - Mautic must respond with HTTP 200 within 3 seconds

2. **Webhook Events Enabled** — MailGun console shows webhooks enabled for:
   - `delivered`, `opened`, `clicked`, `bounced`, `unsubscribed`, etc.

3. **Webhook Signature Verification** — Mautic handler should verify MailGun signature:
   - Header: `X-Mailgun-Signature`
   - Prevents spoofed webhooks

4. **HTTP Response** — Mautic webhook handler returns 200 OK
   - If error or timeout → MailGun retries; may cause duplicates

## Rate Limiting & Throughput

### MailGun Limits

- **Sending Rate:** 1,000 emails/second per account
- **API Calls:** 100 requests/second
- **Domain Throughput:** Carrier-dependent (typical 1-10 emails/sec per domain for new senders)

### DAS Best Practices

- **Batch Campaigns** — Send to large lists in batches (e.g., 5k contacts per hour)
- **Gradual Ramp** — New domains may be rate-limited; ramp gradually to full throughput
- **Monitor Bounce Rate** — If >5% bounces, pause campaign and fix list quality
- **Retry Failed Sends** — MailGun retries for 24 hours; monitor failure logs

## Security Considerations

### API Key Management

- **Storage** — Mautic configuration (encrypted in database)
- **Access** — Restrict to backend Mautic instance only
- **Rotation** — Generate new key periodically (MailGun console)
- **Audit** — Review API key access logs in MailGun

### Webhook Verification

MailGun signs webhook requests with HMAC-SHA256:
- **Header:** `X-Mailgun-Signature`
- **Verification:** Compute HMAC using timestamp + token + API key; compare to header
- **Implementation:** Mautic webhook handler should verify before processing

### Compliance & Data Privacy

- **Message Content** — Don't store sensitive data in email body
- **CAN-SPAM** — Include unsubscribe link, physical address, accurate sender
- **GDPR** — If serving EU customers, ensure MailGun data processing agreement
- **Retention** — MailGun retains message logs; review retention policy

## Related Documentation

- **Confluence:** [CDXP Twilio Integration Guide](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2981232673) (contains MailGun references)
- **Confluence:** [3rd Party Services and App Integrations](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590)
- **On-Disk Artifact:** [MailGun API Info](https://github.com/ConflictHQ/das-tech/blob/main/artifacts/phase-0/confluence/mailgun-api-info.md)
- **Repository:** [CDXP-Mautic](https://github.com/3birdsmarketing/CDXP-Mautic)

## References

- **MailGun API Docs:** https://documentation.mailgun.com/en/latest/user_manual.html
- **MailGun Domain Setup:** https://documentation.mailgun.com/en/latest/user_manual.html#verifying-your-domain
- **MailGun Events:** https://documentation.mailgun.com/en/latest/user_manual.html#webhooks
- **MailGun Webhooks:** https://documentation.mailgun.com/en/latest/user_manual.html#webhooks
- **CAN-SPAM Requirements:** https://www.ftc.gov/business-guidance/resources/can-spam-act-compliance-guide-business
- **MailGun Console:** https://app.mailgun.com

