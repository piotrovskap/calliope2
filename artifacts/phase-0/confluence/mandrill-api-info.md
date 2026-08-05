---
source: DAS Confluence + Integration Explorer v5
page_id: 2872344590
title: Mandrill API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590
type: confluence-doc
pulled: 2026-06-13 (curated from Confluence + DAS Integration Explorer v5)
note: content synthesized from Response Path / Response Logix documentation and Integration Explorer research; covers transactional lead alert emails
---

# Mandrill API Info

## Background

Mandrill (now Mailchimp Transactional) is DAS's **transactional email service** for lead alerts in Response Path / Response Logix. Unlike bulk campaign tools (MailGun, Mautic), Mandrill sends **single, high-priority emails** triggered by real-time lead events.

Primary use case:
- **Response Path / Response Logix** — Real-time lead alert emails to dealer staff when new leads arrive

Mandrill provides:
- Transactional email delivery (single emails triggered by events)
- Lead tracking and metadata (dealer_id, lead_id, vehicle details)
- Tagging and filtering for lead alerts
- Webhook support for delivery status
- High deliverability (optimized for urgent business emails)

## Integration Architecture

```
[Response Path / Response Logix]
    ↓ (Lead received event)
[Communication API or direct Mandrill call]
    ↓
[Mandrill API: POST /api/1.0/messages/send]
    ↓
[SMTP Relay to Dealer Email]
    ↓
[Dealer Staff Inbox]

[Webhooks: Send status, opens, clicks]
    ↓
[Update Response Path contact/lead record]
```

## Primary Integration Point

### Response Path / Response Logix (dastechnology)

Direct Mandrill integration for real-time lead alerts:
- **Trigger:** New lead arrives (via inbound source: web form, phone, CRM, etc.)
- **Action:** Immediately sends alert email to assigned dealer staff
- **Integration:** Via `shared-svcs-communication-api` or direct Mandrill API call
- **Metadata:** Includes lead_id, dealer_id, vehicle details, customer info

**Alert Flow:**
1. New lead captured in Response Path
2. Lead routed to assigned dealer/user
3. Alert email triggered via Mandrill API
4. Dealer staff receives email with:
   - Customer name, contact info
   - Vehicle make/model/year (if provided)
   - Lead source (web form, phone, SMS, etc.)
   - Quick action link (claim lead, schedule appointment)
5. Webhook tracks delivery and opens
6. Lead record updated with alert status

## API Reference

### Send Email

**Endpoint:** `POST https://mandrillapp.com/api/1.0/messages/send`

**Authentication:** API Key in request body (`key` parameter)

**Request (JSON):**
```json
{
  "key": "YOUR_MANDRILL_API_KEY",
  "message": {
    "subject": "New Lead Alert: 2025 Toyota Camry",
    "from_email": "leads@responsepath.dastech.app",
    "from_name": "Response Path Lead Alerts",
    "to": [
      {
        "email": "sarah@dealer.com",
        "name": "Sarah Johnson",
        "type": "to"
      }
    ],
    "html": "<p>Hi Sarah, a customer submitted a lead for a 2025 Toyota Camry.</p><p><strong>Customer:</strong> John Doe<br><strong>Phone:</strong> (555) 000-1234<br><strong>Email:</strong> john@example.com</p><p><a href='https://responsepath.dastech.app/leads/LEAD-88291'>View Lead</a></p>",
    "text": "Hi Sarah, a customer submitted a lead for a 2025 Toyota Camry. Customer: John Doe, Phone: (555) 000-1234. View Lead: https://responsepath.dastech.app/leads/LEAD-88291",
    "tags": ["lead-alert", "response-path", "auto-urgent"],
    "metadata": {
      "dealer_id": "DLR-004521",
      "lead_id": "LEAD-88291",
      "vehicle_year": "2025",
      "vehicle_make": "Toyota",
      "vehicle_model": "Camry"
    },
    "track_opens": true,
    "track_clicks": true,
    "auto_text": true
  }
}
```

**Response:** `200 OK`
```json
{
  "status": "sent",
  "email": "sarah@dealer.com",
  "_id": "abc123def456",
  "reject_reason": null
}
```

**Key Parameters:**
- `subject` — Email subject line (lead summary)
- `from_email` — Sender address (Response Path alerts address)
- `to` — Recipient (dealer staff email)
- `html` / `text` — Email body (lead details, action link)
- `tags` — Tags for filtering (lead-alert, urgency level, source)
- `metadata` — Custom data (dealer_id, lead_id, vehicle details)
- `track_opens` / `track_clicks` — Enable engagement tracking

### Webhooks

**Endpoint:** DAS webhook handler receives delivery events

**Example Event:**
```json
{
  "type": "send",
  "ts": 1717200045,
  "email": "sarah@dealer.com",
  "tags": ["lead-alert", "response-path"],
  "metadata": {
    "dealer_id": "DLR-004521",
    "lead_id": "LEAD-88291"
  },
  "msg": {
    "ts": 1717200045,
    "subject": "New Lead Alert: 2025 Toyota Camry",
    "email": "sarah@dealer.com",
    "tags": ["lead-alert", "response-path"],
    "opens": 0,
    "clicks": 0,
    "_id": "abc123def456"
  }
}
```

**Event Types:**

| Event | Meaning | DAS Action |
|-------|---------|-----------|
| `send` | Email sent to recipient | Log delivery attempt |
| `hardbounce` | Email rejected (invalid address, no relay) | Add to suppression; flag lead |
| `softbounce` | Temporary rejection (server down, mailbox full) | Retry later; log attempt |
| `open` | Recipient opened email | Update lead record; track engagement |
| `click` | Recipient clicked link (likely viewed lead) | Update lead; sync engagement metric |
| `spam` | Recipient marked as spam | Add to suppression; flag account |
| `unsub` | Recipient unsubscribed | Add to suppression; update user preferences |

## Use Cases in DAS

### Real-Time Lead Alert to Dealer Staff

**Flow:**
1. New lead arrives via web form, phone, or API
2. Lead captured in Response Path system
3. Lead assigned to dealer and primary sales rep
4. Mandrill alert triggered with lead details
5. Sales rep receives email with:
   - Customer name, contact info, vehicle interest
   - Quick action buttons (claim, schedule, call)
6. Email opens tracked (engagement signal)
7. Click on "View Lead" or "Schedule" tracked
8. Lead record updated with alert delivery status
9. Follow-up automation adjusts based on response

### High-Priority Lead Notifications

**Characteristics:**
- **Latency:** < 5 seconds from lead capture to email send
- **Subject Line:** "New Lead Alert: [Vehicle/Action]" (catches attention)
- **Content:** Minimal, scannable (name, phone, vehicle, action link)
- **Tracking:** Opens and clicks monitored for engagement
- **Urgency:** Often sent outside business hours (nights, weekends)

## Metadata & Tagging

### Tags (for Filtering)

Tags help organize alerts and identify lead type:

```json
"tags": [
  "lead-alert",        // Alert type
  "response-path",     // Source system
  "auto-urgent",       // Urgency level
  "web-form",          // Lead source
  "trade-in"           // Vehicle category
]
```

**Dashboard Use:**
- Filter alerts by type/urgency
- Track which alert sources generate engagement
- Bulk unsub by tag (e.g., all "promo" alerts)

### Custom Metadata

Metadata carries context through delivery pipeline:

```json
"metadata": {
  "dealer_id": "DLR-004521",
  "lead_id": "LEAD-88291",
  "vehicle_year": "2025",
  "vehicle_make": "Toyota",
  "vehicle_model": "Camry",
  "lead_source": "web-form",
  "assigned_rep": "sarah@dealer.com"
}
```

**Webhook Correlation:** When alert is opened/clicked, metadata identifies which dealer and lead; allows Response Path to update lead record with engagement signal.

## Authentication & API Keys

### API Key Management

**Storage:**
- Typically in `shared-svcs-communication-api` config
- Environment variable: `MANDRILL_API_KEY`
- Secrets manager (never hardcoded)

**Scope:**
- Full message sending access
- Webhook management
- Activity reporting

**Security:**
- Generate new key if compromised
- Rotate periodically (best practice: quarterly)
- Audit API key usage in Mandrill dashboard

### Rate Limiting

**Mandrill Limits:**
- **Sending Rate:** 10,000 messages/minute per account
- **API Calls:** No explicit limit (rate-based)
- **Concurrent Connections:** 10 connections per account

**DAS Best Practices:**
- Lead alerts are typically low-volume (< 100/hour per dealer)
- No rate limiting needed for normal operation
- Monitor for abuse (bulk alert triggers)

## Troubleshooting

### Alert Emails Not Sending

**Checklist:**

1. **API Key Valid** — Verify in Mandrill console or config
   ```bash
   # Test API key by calling /users/info
   curl -X POST https://mandrillapp.com/api/1.0/users/info \
     -d '{"key":"YOUR_KEY"}'
   ```

2. **Recipient Email Valid** — Must be properly formatted
   - Invalid: `sarah@dealer` (no TLD)
   - Invalid: `sarah @ dealer.com` (spaces)
   - Valid: `sarah@dealer.com`

3. **From Address Valid** — Mandrill requires SPF/DKIM setup for domain
   - Check: `leads@responsepath.dastech.app` is verified in Mandrill

4. **HTML Content Valid** — Malformed HTML may cause rejection
   - Check email body for syntax errors
   - Test with simple text first

5. **Webhook Configured** — If using webhooks, verify URL is reachable
   - Must be HTTPS
   - Must return 200 OK within 3 seconds

### High Bounce Rate

**Common Causes:**
- **Invalid email addresses** — Typos in dealer staff emails
- **Domain authentication missing** — SPF/DKIM not configured for sender domain
- **List stale** — Old email addresses no longer active

**Investigation:**
1. Check Mandrill Activity dashboard (filter by bounce)
2. Review bounce classification (hard vs. soft)
3. Verify domain SPF/DKIM in Mandrill settings
4. Update dealer staff contact list

### Opens/Clicks Not Tracked

**Checklist:**

1. **Tracking Enabled** — Verify `track_opens: true` and `track_clicks: true` in request

2. **Recipient Allows Tracking** — Some email clients block pixel tracking
   - Gmail: May block opens tracking
   - Outlook: May block opens tracking
   - No bypass available

3. **Click Tracking Domain** — Configure click tracking domain in Mandrill
   - Required for click tracking
   - Must match sender domain authentication

## Compliance & Best Practices

### CAN-SPAM Compliance

Transactional alerts are exempt from CAN-SPAM if:
- ✅ Email is triggered by user action (lead submission)
- ✅ Primarily contains information related to transaction
- ✅ Not primarily promotional

**Still Required:**
- ✅ Accurate From/Reply-To
- ✅ Clear subject line
- ✅ Physical address in footer (optional for transactional)

### Deliverability Tips

1. **SPF/DKIM Setup** — Authenticate sender domain
   - Improves reputation and delivery rate
   - Required for click tracking

2. **Bounce Handling** — Suppress hard bounces immediately
   - Prevents reputation damage
   - Improves future deliverability

3. **Complaint Handling** — Monitor spam complaints
   - High complaint rate flags domain
   - May affect all outbound email

4. **Subject Line** — Avoid spam trigger words
   - Instead of: "URGENT: Claim Your Lead NOW!!!"
   - Use: "New Lead Alert: 2025 Toyota Camry"

## Integration with Communications API

### Via shared-svcs-communication-api

Communications API wraps Mandrill for unified email handling:

```
Request: {
  to: "sarah@dealer.com",
  template: "lead-alert",
  data: { lead_id, dealer_id, vehicle_make, ... }
}
  ↓
Communication API translates to Mandrill format:
  {
    message: {
      to: [{ email: "sarah@dealer.com" }],
      subject: "New Lead Alert: 2025 Toyota Camry",
      html: <rendered template>,
      metadata: { lead_id, dealer_id, ... }
    }
  }
  ↓
Mandrill sends email
```

**Benefits:**
- Unified email config (SendGrid, MailGun, Mandrill in one API)
- Templating engine (single source of truth for alert layouts)
- Standardized webhook handling
- Retries and fallbacks

## Related Documentation

- **Confluence:** [3rd Party Services and App Integrations](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590)
- **On-Disk Artifact:** [Mandrill API Info](https://github.com/ConflictHQ/das-tech/blob/main/artifacts/phase-0/confluence/mandrill-api-info.md)
- **Repository:** [shared-svcs-communication-api](https://github.com/dastechnology/shared-svcs-communication-api)

## References

- **Mandrill API Docs:** https://mandrillapp.com/api/docs/
- **Mandrill Authentication:** https://mandrillapp.com/api/docs/messages.JSON#method=send
- **Mandrill Webhooks:** https://mandrillapp.com/api/docs/messages.JSON#webhooks
- **Mandrill Activity Dashboard:** https://mandrillapp.com/activity
- **CAN-SPAM Requirements:** https://www.ftc.gov/business-guidance/resources/can-spam-act-compliance-guide-business
- **Mailchimp Transactional (Mandrill):** https://mailchimp.com/products/transactional-email/

