---
source: DAS Confluence + Integration Explorer v5
page_id: multiple (3179642911, 3242328102, 3510730771, 2981232673, 3179970629, 3426025479)
title: Twilio API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3179642911
type: confluence-doc
pulled: 2026-06-11 (curated from multiple Confluence pages + DAS Integration Explorer v5)
note: content synthesized from Communications API, LiveJoin System Architecture, CDXP Twilio integration, and Integration Explorer research; covers SMS delivery, inbound webhooks, account configuration
---

# Twilio API Info

## Background

Twilio is DAS's **primary SMS delivery platform**, responsible for text message delivery across multiple products and services. Twilio handles both **outbound SMS** (campaigns, alerts, invitations) and **inbound SMS** (customer replies, message routing).

Core use cases:
- **Communications API** (`shared-svcs-communication-api`) — unified SMS delivery interface
- **CDXP** (`CDXP-Mautic`) — campaign SMS via MauticCustomSmsBundle plugin
- **Mobile Review Surge** — text-based review invitations to customers
- **LiveJoin3** — SMS joiner invitations (alternative to email)
- **AI Engage Messaging** — conversational SMS responses

Twilio provides reliability, delivery tracking, inbound webhook handling, and opt-out compliance (STOP command).

## What is Twilio?

Twilio is a **cloud-based SMS platform** that provides:

- **SMS API** — Send and receive text messages via REST API
- **Messaging Services** — Phone number pooling, alphanumeric sender IDs, message queuing
- **Webhooks** — Real-time status callbacks (sent, delivered, failed) and inbound message notifications
- **Account SID & Auth Token** — Account-level credentials for API authentication
- **Phone Numbers** — Dedicated numbers for DAS dealers (or shared short codes)
- **Compliance** — Automatic STOP/UNSTOP/HELP command handling

Twilio's role in DAS is **asynchronous SMS delivery** — our services queue messages to Twilio and receive confirmation; Twilio handles routing to mobile carriers.

## Integration Architecture

```
[DAS Applications]
    ↓
[shared-svcs-communication-api]  [CDXP-Mautic]  [LiveJoin3]  [Mobile Review Surge]
    ↓                                  ↓                ↓              ↓
[Twilio API: POST /Accounts/{SID}/Messages.json]
    ↓
[SMS Routing to Mobile Carriers]
    ↓
[Customer Phone]

[Customer Inbound SMS]
    ↓
[Twilio Inbound Webhook → DAS Webhook Handler]
    ↓
[Message Routing: AI Engage, CDXP update, etc.]
```

### Primary Integration Points

#### 1. **Communications API** (shared-svcs-communication-api)

Central SMS orchestration service (shared with SendGrid for email):
- **Validates** SMS requests (recipient phone, message body, variables)
- **Enqueues** to Twilio via `POST /Accounts/{SID}/Messages.json`
- **Returns** message SID for tracking
- **Handles** inbound webhook callbacks (message received, delivery status)
- **Implements** retry logic for failed sends
- **Manages** CDXP opt-out updates (STOP command handling)

**Used By:**
- CDXP campaign SMS (scheduled + behavioral)
- Mobile Review Surge (text invitations)
- LiveJoin3 SMS invites (alternative to email)

#### 2. **CDXP-Mautic** (3birdsmarketing)

CDXP's native SMS plugin integration:
- **MauticCustomSmsBundle** — Custom Mautic plugin for SMS campaign sending
- **Twilio Account Config** — Per-dealer Twilio credentials (Account SID, Auth Token, phone number)
- **Company-level Settings:**
  - `d_twilio_account_sid` — Twilio Account SID for dealer
  - `d_twilio_auth_token` — Twilio Auth Token for dealer
  - `d_twilio_phone_number` — Dealer's sending phone number
  - `d_is_sms_la`, `d_is_sms_sa`, `d_is_sms_ea` — Feature flags (SMS for lead alerts, survey alerts, engagement alerts)

**Campaign Flow:**
1. Mautic campaign condition triggers (new lead, scoring threshold, time-based)
2. Campaign SMS action calls Twilio API directly (or via Communications API)
3. Twilio delivers SMS to customer phone
4. Customer receives SMS with opt-out message ("Reply STOP to unsubscribe")
5. Inbound webhook triggered on customer reply (STOP, UNSTOP, HELP, or custom reply)

#### 3. **LiveJoin3 Service** (EngageToSellLLC)

Direct Twilio integration for real-time SMS joiner invites:
- **Triggers** on join rule evaluation (customer injected, department set)
- **Calls** Twilio API directly with joiner phone + SMS message
- **Tracks** delivery status via webhook callbacks
- **Fallback** — SMS invite sent when joiner email not available

#### 4. **Mobile Review Surge**

Text-based review invitation workflow:
- **Triggers** post-purchase or post-service (via transaction data)
- **Sends** SMS invitation with review link (shortened URL)
- **Tracks** link clicks via webhook inbound messages or click tracking
- **Rate limit** — Twilio carrier restrictions (typically 1 SMS per second per number)

## API Reference

### Send SMS

**Endpoint:** `POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages.json`

**Authentication:** HTTP Basic Auth with `AccountSid:AuthToken`

**Request Body (form-encoded):**
```
To=%2B15550001234
&From=%2B15551234567
&MessagingServiceSid=MGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
&Body=Hi+John!+Your+service+is+ready+for+pickup.+Reply+STOP+to+opt+out.
```

Or with JSON body:
```json
{
  "To": "+15550001234",
  "From": "+15551234567",
  "MessagingServiceSid": "MGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "Body": "Hi John! Your service is ready for pickup. Reply STOP to opt out."
}
```

**Response:** `201 Created`
```json
{
  "sid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "status": "queued",
  "to": "+15550001234",
  "from": "+15551234567",
  "body": "Hi John! Your service is ready...",
  "direction": "outbound-api",
  "price_unit": "USD",
  "error_code": null,
  "error_message": null
}
```

**Key Fields:**
- `sid` — Message ID for tracking and webhook correlation
- `status` — Initial status; evolves to sent → delivered → failed via webhook
- `error_code` — Delivery error if message rejected immediately:
  - `30003` — Invalid phone number (invalid format or doesn't exist)
  - `30006` — Landline number (can't receive SMS); triggers DAS opt-out logic
  - `30007` — Country/carrier restriction (phone number in blocked region)

### Inbound SMS Webhook

**Endpoint:** DAS webhook handler receives inbound messages

**Example Webhook Payload (form-encoded):**
```
MessageSid=SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
&AccountSid=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
&MessagingServiceSid=MGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
&From=%2B15550001234
&To=%2B15551234567
&Body=Yes%2C+I%27m+interested+in+scheduling+service
&NumMedia=0
&SmsStatus=received
```

**Parsed JSON equivalent:**
```json
{
  "MessageSid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "AccountSid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "MessagingServiceSid": "MGxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "From": "+15550001234",
  "To": "+15551234567",
  "Body": "Yes, I'm interested in scheduling service",
  "NumMedia": "0",
  "SmsStatus": "received"
}
```

### Delivery Status Webhooks

Twilio sends status updates via separate webhook endpoint:

```json
{
  "MessageSid": "SMxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "AccountSid": "ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "From": "+15551234567",
  "To": "+15550001234",
  "SmsStatus": "delivered",
  "MessageStatus": "delivered"
}
```

**Status Values:**
- `queued` — Message accepted by Twilio, waiting for carrier
- `sent` — Message sent to carrier
- `delivered` — Confirmed delivered to phone
- `undelivered` — Failed to deliver (carrier rejection, invalid number, etc.)
- `failed` — Not sent due to account/API error

## Use Cases in DAS

### CDXP Campaign SMS

**Flow:**
1. Mautic campaign triggers (new lead, scoring threshold, time-based)
2. Campaign SMS action queues to Twilio via Communications API or MauticCustomSmsBundle
3. Twilio delivers SMS to customer phone number
4. Customer receives message with opt-out footer ("Reply STOP to unsubscribe")
5. Customer replies with STOP, UNSTOP, HELP, or custom message
6. Twilio webhook fires with inbound message
7. DAS webhook handler processes:
   - **STOP** → Set `c_is_sms_suppressed = true` in CDXP; suppress future SMS sends
   - **UNSTOP** → Clear suppression flag; re-enable SMS
   - **HELP** → Auto-reply with help text (optional, configured in Twilio)
   - **Custom reply** → Route to AI Engage for response generation or save as contact note

**Engagement Tracking:**
- Inbound message webhook updates `c_last_sms_received` timestamp in CDXP
- Inbound messages increment contact engagement score
- Opt-out rate monitored (STOP count); high rate triggers compliance review

### Mobile Review Surge Text Invitations

**Flow:**
1. Transaction data received (purchase, service completion)
2. Mobile Review Surge triggers SMS review invitation
3. SMS sent via Twilio with shortened review link (e.g., "Click to review: http://bit.ly/valley-honda-review")
4. Customer receives SMS; may click link or reply
5. If link clicked → review page opened; tracking recorded
6. If SMS reply → webhook fires; message saved to contact record
7. Campaign adjusts: re-send to non-clickers after 3 days; thank clickers with follow-up offer

### LiveJoin3 SMS Invitations

**Flow:**
1. Rocket.Chat Lead Plugin detects trigger (customer injected, department set)
2. LiveJoin3 evaluates join rules; finds matching joiners
3. For each joiner with phone number (SMS opt-in), calls Twilio API
4. SMS sent to joiner: "New chat: [Customer Name]. Reply to join or text STOP."
5. Joiner receives SMS; may reply to join or text STOP to opt-out
6. Reply webhook → LiveJoin3 matches joiner ID; adds joiner to Rocket.Chat
7. Joiner appears in chat as "joined"

**Opt-out Handling:**
- STOP message → LiveJoin3 sets joiner SMS opt-out flag; prevents future SMS invites
- Per-joiner setting persists across sessions

## Account Configuration

### Credentials & Auth

**Per-Dealer Setup (CDXP):**
- `Account SID` — Unique account identifier (starts with AC)
- `Auth Token` — Secret key for API authentication (never expose in client code)
- `Phone Number` — Dedicated number for dealer (e.g., +15551234567) or shared messaging service

**Storage in DAS:**
- Stored in CDXP company record: `d_twilio_account_sid`, `d_twilio_auth_token`, `d_twilio_phone_number`
- Environment variables for Communications API: `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN`
- Never stored in client-side code or config files

### Messaging Services vs. Dedicated Numbers

**Messaging Services (Recommended):**
- Shared phone number pool across dealers
- Automatic number rotation for throughput
- Twilio handles carrier opt-out compliance at pool level
- Less cost per message

**Dedicated Numbers:**
- One phone number per dealer
- More recognizable to customers
- Higher cost
- Better for high-volume campaigns with branding requirements

DAS typically uses **Messaging Services** for multi-tenant flexibility.

## Opt-Out & Compliance

### STOP Command Handling

When customer texts STOP:
1. Twilio automatically blocks future messages from that sender (Twilio-side suppression)
2. Twilio webhook fires with inbound message "STOP"
3. DAS webhook handler **must**:
   - Parse message body for "STOP", "UNSTOP", "HELP" keywords
   - Update CDXP suppression flag: `c_is_sms_suppressed = true`
   - Log opt-out in contact record with timestamp
   - Return HTTP 200 to Twilio (acknowledge receipt)

**Failure Impact:**
- If DAS doesn't set suppression flag, Communication API may retry sending to suppressed number
- Twilio will reject (carrier-level), but wastes API quota and money
- Best practice: Check CDXP suppression flag before queuing to Twilio

### UNSTOP / RE-OPT-IN

Customer can text UNSTOP to re-enable SMS:
1. Twilio webhook fires with "UNSTOP"
2. DAS webhook handler sets `c_is_sms_suppressed = false`
3. Future campaigns can send SMS again (explicit re-opt-in per carrier requirements)

### Legal Compliance

- **Message Footer** — Must include opt-out instructions: "Reply STOP to unsubscribe"
- **Frequency** — Don't exceed ~1 SMS per contact per day (varies by campaign type)
- **Content** — Don't send promotional SMS without prior opt-in (TCPA compliance)
- **CTIA Standards** — Follow Cellular Telecommunications Industry Association guidelines

## Troubleshooting

### SMS Not Sending

**Diagnostic Checklist:**

1. **Verify Twilio Credentials** — Account SID and Auth Token valid?
   ```bash
   curl -u AccountSid:AuthToken https://api.twilio.com/2010-04-01/Accounts
   ```
   Should return account info.

2. **Check Phone Number Format** — Must be E.164 format: `+1XXXYYYZZZZ`
   - Invalid: `5550001234` (missing +1)
   - Invalid: `(555) 000-1234` (formatted)
   - Valid: `+15550001234`

3. **Verify Recipient Not Suppressed** — Check CDXP `c_is_sms_suppressed` flag
   - If true, SMS rejected at application layer (best practice)

4. **Check Twilio Activity Log** — Twilio console → Messages → filter by recipient
   - Look for `error_code` (30003, 30006, etc.)
   - Check `status` (failed, undelivered, etc.)

5. **Verify Messaging Service Active** — If using Messaging Service (recommended):
   - Confirm service is active and has phone numbers configured
   - Check service has inbound/outbound webhooks configured

### High Failure Rate

**Common Causes:**
- **Invalid phone numbers** — CDXP contact data contains typos or incomplete numbers
- **Landline numbers** — CDXP includes landlines (can't receive SMS); returns `error_code: 30006`
- **International numbers** — Country/carrier restrictions; Twilio rejects based on number prefix
- **Rate limiting** — Twilio limits ~1 SMS per second per phone number; excess messages queue/fail
- **Account restrictions** — New account may have reduced throughput; Twilio enforces warm-up period

**Investigation:**
1. Download message log from Twilio (by date/status)
2. Cross-reference error codes with CDXP contact records
3. Identify pattern: all failures landline? All same area code? All to one carrier?
4. Remediation: update contact data, implement validation, request carrier whitelisting

### Inbound Messages Not Received

**Checklist:**

1. **Webhook URL Configured** — Twilio console → Phone Numbers → Select number → Messaging → Inbound URL
   - Must be publicly accessible HTTPS endpoint
   - Twilio must reach URL within 15 seconds; timeout = message lost

2. **Webhook Signature Verification** — DAS handler should verify request signature:
   - Header: `X-Twilio-Signature` (HMAC-SHA1)
   - Prevents spoofed webhooks

3. **HTTP Response** — DAS handler must return HTTP 200 within 15 seconds
   - Slow response or error → Twilio retries up to 3 times; causes duplicate processing

4. **Message Routing** — After webhook, message must be routed correctly:
   - Match customer phone to CDXP contact: `c_cellphone` or `c_Lead_SMS` fields
   - Route to AI Engage, save to contact note, update campaign, etc.

### Carrier Delays

**Cause:** Carrier processing time (not Twilio issue)
- SMS may take 5-60 seconds to deliver even if Twilio shows `sent`
- Occasional delays normal; investigate if consistent pattern emerges

**Monitor:** Check `delivered` webhook timestamp vs. send time; calculate median delay

## Rate Limiting & Throughput

### Twilio Limits (per account)

- **SMS per second** — Typically 1 SMS/sec per phone number; contact Twilio for increases
- **API calls per second** — 100 requests/sec per account
- **Concurrent connections** — 10 connections
- **Message body size** — 160 chars (1 SMS); 153 chars (1 SMS with encoding); longer messages auto-split (160 char segments)

### DAS Best Practices

- **Batch queuing** — Don't send SMS synchronously; queue to Communications API and let background job handle delivery
- **Rate limiting** — Implement per-number rate limit in Communications API (1 SMS per 5 seconds per phone)
- **Retry logic** — If send fails (Twilio error), retry with exponential backoff (5s, 10s, 30s)
- **Monitoring** — Track sent/delivered/failed rates; alert if >5% failure rate

## Security Considerations

### Auth Token Management

- **Storage** — Environment variables or secure vault (never in code/config)
- **Rotation** — Generate new token periodically (Twilio console → Generate new token)
- **Access** — Restrict to backend services only; never expose to client code
- **Audit** — Review token access logs in Twilio console

### Webhook Signature Verification

Twilio signs inbound webhooks with HMAC-SHA1:
- **Header:** `X-Twilio-Signature`
- **Verification:** Compute HMAC using Auth Token and request body; compare to header
- **Implementation:** DAS webhook handler should verify before processing (prevents spoofed requests)

### Compliance & Data Privacy

- **Message Content** — Don't store sensitive data in SMS body (PII, passwords, account numbers)
- **TCPA** — Comply with Telephone Consumer Protection Act (prior opt-in for marketing SMS)
- **GDPR** — If serving EU customers, ensure Twilio processing agreement in place
- **Call Logs** — Twilio retains message logs; review retention policy

## Related Documentation

- **Confluence:** [Twilio and SendGrid — Introduction](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3179642911)
- **Confluence:** [Communications API — Application Support](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3242328102)
- **Confluence:** [Twilio — Account Information Essentials](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3179970629)
- **Confluence:** [CDXP Twilio Integration Guide](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2981232673)
- **Confluence:** [Setting Up TwiML Bins for Custom SMS Responses](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3426025479)
- **Confluence:** [LiveJoin System Architecture](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3510730771)
- **On-Disk Artifact:** [Twilio API Info](https://github.com/ConflictHQ/das-tech/blob/main/artifacts/phase-0/confluence/twilio-api-info.md)
- **Repository:** [shared-svcs-communication-api](https://github.com/dastechnology/shared-svcs-communication-api)
- **Repository:** [CDXP-Mautic](https://github.com/3birdsmarketing/CDXP-Mautic)
- **Repository:** [LiveJoin3 Service](https://github.com/EngageToSellLLC/LiveJoin3)

## References

- **Twilio API Docs:** https://www.twilio.com/docs/sms/api
- **Twilio Messaging Services:** https://www.twilio.com/docs/sms/services
- **Twilio Webhooks:** https://www.twilio.com/docs/sms/twiml-behavior
- **Status Callbacks:** https://www.twilio.com/docs/sms/api/message-resource#status-callback
- **Error Codes:** https://www.twilio.com/docs/sms/api/message-resource#error-codes
- **Number Capabilities:** https://www.twilio.com/docs/lookup/api
- **TCPA Compliance:** https://www.twilio.com/docs/compliance/us-regulations/twilio-guidelines
- **Twilio Console:** https://www.twilio.com/console

