---
source: DAS Confluence + Integration Explorer v5
page_id: 3168960514
title: ETS Facebook Messenger + SMS Proxy API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3168960514
type: confluence-doc
pulled: 2026-06-14 (curated from Confluence + DAS Integration Explorer v5; synthesized from Facebook/SMS channel documentation and BCProxy configuration)
note: covers Facebook Messenger channel routing, SMS inbound/outbound, BCProxy database integration, Animator tool configuration, multi-tenant channel management
---

# ETS Facebook Messenger + SMS Proxy API Info

## Background

**ETS Facebook Messenger + SMS Proxy** is the **multi-channel gateway** that routes inbound messages from Facebook Messenger and SMS into Engage To Sell's Rocket.Chat omnichannel system. It manages the technical bridge between external messaging platforms (Facebook, Twilio SMS) and the internal live chat engine, enabling dealers to receive and respond to customer messages across all channels through a single Rocket.Chat interface.

The proxy operates via BCProxy (a dedicated MySQL database) and the Animator configuration tool, allowing dealership administrators to configure which channels are active per account.

**Technology Stack:**
- **Platform:** BCProxy (multi-channel proxy database)
- **Database:** MySQL (livejoin.engagetosell.com:3306)
- **Configuration Tool:** Animator (UI for channel management)
- **External Integrations:** Facebook Messenger API, Twilio SMS API
- **Hosting:** AWS (integrated with ETS Dashboard)
- **Repository:** EngageToSellLLC/Dashboard
- **Consumers:** Rocket.Chat omnichannel, LiveJoin3, ETS Dashboard, Dealers

## Integration Architecture

```
[Facebook Messenger Customer]
    ↓ (customer message)
[Facebook Messenger API]
    ↓ (webhook)
[ETS Proxy / BCProxy]
    ↓ (route to dealer account)
[Rocket.Chat Omnichannel Room]
    ↓ (agent sees message)
[Agent types response]
    ↓
[Proxy relays to Facebook]
    ↓
[Customer receives message]

[SMS Customer (Twilio)]
    ↓ (inbound SMS)
[Twilio Webhook]
    ↓
[ETS Proxy / BCProxy]
    ↓ (route to omnichannel)
[Rocket.Chat Omnichannel Room]
    ↓ (agent sees SMS)
[Agent responds]
    ↓ (Twilio sends SMS back)
```

## Primary Integration Points

### 1. Facebook Messenger API (External)

**Role:** Inbound and outbound message routing
- **Webhook:** Facebook sends customer messages to proxy endpoint
- **API Calls:** Proxy posts responses back to Facebook
- **Authentication:** Facebook page access tokens (stored in BCProxy)
- **Usage:** Customer messages from Facebook pages connected to ETS account

### 2. Twilio SMS API (External)

**Role:** Inbound and outbound SMS routing
- **Webhook:** Twilio sends inbound SMS to proxy endpoint
- **API Calls:** Proxy calls Twilio API to send outbound SMS
- **Authentication:** Twilio account SID and auth token (per dealer account)
- **Usage:** Customer SMS messages routed to Rocket.Chat omnichannel

### 3. BCProxy Database (Internal)

**Role:** Channel configuration and message routing database
- **Tables:** `facebook_pages`, `sms_channels`, `account_channels`, `message_log`
- **Usage:** Maps customer accounts to active channels, stores message history
- **Access:** Via Animator UI or direct database queries

### 4. ETS Dashboard (Configuration)

**Role:** Account-level channel enablement
- **Features:** Enable/disable SMS, enable/disable Facebook per account
- **Configuration:** STOP message customization, Twilio number assignment
- **Usage:** Dealers toggle channels on/off via Dashboard UI

### 5. Rocket.Chat Omnichannel (Internal)

**Role:** Central chat interface for all channels
- **Integration:** Inbound messages appear as omnichannel rooms
- **Features:** Multi-channel conversations in single room
- **API:** Proxy uses Rocket.Chat API to create rooms, send messages

## API Reference

### Webhook Endpoints

#### Facebook Messenger Webhook (Inbound)

**Endpoint:** `POST https://api.engagetosell.com/webhook/facebook`

**Request Body (from Facebook):**
```json
{
  "object": "page",
  "entry": [
    {
      "id": "page_id_123",
      "time": 1623456789000,
      "messaging": [
        {
          "sender": {
            "id": "sender_id_456"
          },
          "recipient": {
            "id": "page_id_123"
          },
          "timestamp": 1623456789000,
          "message": {
            "mid": "mid_789",
            "text": "Hi, I'm interested in your 2025 Honda Civic",
            "attachments": [
              {
                "type": "image",
                "payload": {
                  "url": "https://platform-lookaside.fbsbx.com/..."
                }
              }
            ]
          }
        }
      ]
    }
  ]
}
```

**Processing Flow:**
1. Proxy receives Facebook webhook
2. Extracts customer info (sender_id, page_id)
3. Looks up account in BCProxy via `facebook_pages` table
4. Identifies dealer account and Rocket.Chat department
5. Creates/finds omnichannel room in Rocket.Chat
6. Inserts message into room
7. Returns `200 OK` to Facebook (webhook acknowledgment)

**Response:** `200 OK`
```json
{
  "success": true,
  "roomId": "GENERAL",
  "customerId": "ETS-004521"
}
```

#### SMS Webhook (Inbound via Twilio)

**Endpoint:** `POST https://api.engagetosell.com/webhook/sms`

**Request Body (from Twilio):**
```json
{
  "MessageSid": "SM12345abcde",
  "AccountSid": "ACxxxxx",
  "From": "+16025551234",
  "To": "+16025550099",
  "Body": "Hi, what's the price of the black Honda Civic?",
  "NumMedia": "0",
  "SmsStatus": "received",
  "FromCity": "Phoenix",
  "FromState": "AZ",
  "FromZip": "85014",
  "FromCountry": "US"
}
```

**Processing Flow:**
1. Proxy receives Twilio webhook
2. Extracts customer phone (From), dealer number (To)
3. Looks up account in BCProxy via `sms_channels` table
4. Matches incoming number to dealer account
5. Checks SMS enabled for that account (feature flag)
6. Creates/finds omnichannel room in Rocket.Chat
7. Inserts message as SMS (tagged with phone number)
8. Returns `200 OK` to Twilio

**Response:** `200 OK`
```json
{
  "success": true,
  "roomId": "GENERAL",
  "customerId": "ETS-004521",
  "visitorPhone": "+16025551234"
}
```

### REST Endpoints

#### GET Facebook Pages (ETS Dashboard API)

**Endpoint:** `GET /api/v1/proxy/getFacebookPages?customerId=ETS-004521`

**Query Parameters:**
- `customerId` (required) — Account ID

**Response:** `200 OK`
```json
{
  "pages": [
    {
      "pageId": "123456789012345",
      "pageName": "Valley Honda",
      "pageUrl": "https://www.facebook.com/valleyhonda",
      "accessToken": "EAAxxxxxx...",
      "enabled": true,
      "webhookUrl": "https://api.engagetosell.com/webhook/facebook",
      "subscribedFields": ["messages", "messaging_postbacks"],
      "lastSyncTime": "2025-06-13T14:00:00Z"
    }
  ]
}
```

**Key Fields:**
- `pageId` — Facebook Page ID
- `accessToken` — Page access token (used for outbound messages)
- `webhookUrl` — Where Facebook sends messages
- `subscribedFields` — Events Facebook notifies proxy about

#### GET SMS Channels

**Endpoint:** `GET /api/v1/proxy/getSmsChannels?customerId=ETS-004521`

**Response:** `200 OK`
```json
{
  "channels": [
    {
      "channelId": "sms-004521-001",
      "twilioPhoneNumber": "+16025550099",
      "accountSid": "ACxxxxx",
      "enabled": true,
      "stopMessage": "Reply STOP to opt out",
      "department": "Sales",
      "webhookUrl": "https://api.engagetosell.com/webhook/sms",
      "rateLimit": "1 SMS/second",
      "lastSyncTime": "2025-06-13T14:00:00Z"
    }
  ]
}
```

**Key Fields:**
- `twilioPhoneNumber` — Dealer's Twilio number
- `stopMessage` — Custom STOP opt-out message
- `rateLimit` — SMS sending rate limit per Twilio SLA
- `department` — Routes SMS to this RC department

#### POST Send Facebook Message (Outbound)

**Endpoint:** `POST /api/v1/proxy/sendFacebookMessage` ⚠️ **Internal Use**

**Request Body (from Rocket.Chat Agent):**
```json
{
  "roomId": "GENERAL",
  "customerId": "ETS-004521",
  "message": "Hi! Thanks for your interest. Our best price for that model is $28,995.",
  "recipientFacebookId": "sender_id_456",
  "pageId": "123456789012345"
}
```

**Processing Flow:**
1. Proxy receives message from RC
2. Retrieves Facebook page access token from BCProxy
3. Calls Facebook API: `POST /me/messages`
4. Facebook delivers message to customer
5. Proxy logs message to BCProxy message_log table
6. Returns status to Rocket.Chat

**Response:** `200 OK`
```json
{
  "success": true,
  "messageId": "m-123456",
  "recipient_id": "sender_id_456",
  "timestamp": "2025-06-13T14:22:35Z"
}
```

#### POST Send SMS (Outbound)

**Endpoint:** `POST /api/v1/proxy/sendSms` ⚠️ **Internal Use**

**Request Body (from Rocket.Chat Agent):**
```json
{
  "roomId": "GENERAL",
  "customerId": "ETS-004521",
  "message": "Hi! Your Honda Civic is ready. Price: $28,995. Call us: 602-555-0099",
  "recipientPhone": "+16025551234",
  "twilioPhoneNumber": "+16025550099"
}
```

**Processing Flow:**
1. Proxy receives message from RC
2. Retrieves Twilio account SID/auth token
3. Calls Twilio API: `POST /Accounts/{AccountSid}/Messages.json`
4. Twilio sends SMS to customer
5. Proxy logs message to BCProxy
6. Returns Twilio message SID to RC

**Response:** `200 OK`
```json
{
  "success": true,
  "messageSid": "SM12345abcde",
  "to": "+16025551234",
  "from": "+16025550099",
  "status": "queued",
  "dateCreated": "2025-06-13T14:22:35Z"
}
```

#### GET Message History

**Endpoint:** `GET /api/v1/proxy/messages?customerId=ETS-004521&roomId=GENERAL&limit=50`

**Query Parameters:**
- `customerId` (required) — Account ID
- `roomId` (optional) — Filter to room
- `channel` (optional) — "facebook" | "sms" | "all"
- `startTime` (optional) — ISO 8601 timestamp
- `limit` (optional) — Max results (default: 50)

**Response:** `200 OK`
```json
{
  "messages": [
    {
      "messageId": "m-123456",
      "channel": "facebook",
      "direction": "inbound",
      "sender": "Customer",
      "senderPhone": "+16025551234",
      "senderFacebookId": "sender_id_456",
      "text": "Hi, I'm interested in your 2025 Honda Civic",
      "timestamp": "2025-06-13T14:22:35Z",
      "roomId": "GENERAL",
      "read": true
    },
    {
      "messageId": "m-123457",
      "channel": "facebook",
      "direction": "outbound",
      "sender": "Agent",
      "agentName": "John",
      "text": "Great! That model is $28,995",
      "timestamp": "2025-06-13T14:23:00Z",
      "roomId": "GENERAL",
      "deliveryStatus": "delivered"
    }
  ],
  "totalCount": 2
}
```

## BCProxy Database Schema

### facebook_pages Table

```sql
CREATE TABLE facebook_pages (
  id INT PRIMARY KEY,
  account_id VARCHAR(50),
  page_id VARCHAR(50),
  page_name VARCHAR(255),
  access_token VARCHAR(500),
  enabled BOOLEAN,
  webhook_url VARCHAR(255),
  subscribed_fields JSON,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- Example row
-- (1, 'ETS-004521', '123456789012345', 'Valley Honda', 'EAAxxxxxx...', true, 'https://api.engagetosell.com/webhook/facebook', '["messages", "messaging_postbacks"]', '2025-01-15 10:00:00', '2026-06-13 14:00:00')
```

### sms_channels Table

```sql
CREATE TABLE sms_channels (
  id INT PRIMARY KEY,
  account_id VARCHAR(50),
  twilio_phone VARCHAR(20),
  twilio_account_sid VARCHAR(100),
  twilio_auth_token VARCHAR(200),
  enabled BOOLEAN,
  stop_message TEXT,
  webhook_url VARCHAR(255),
  department VARCHAR(50),
  rate_limit VARCHAR(50),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- Example row
-- (1, 'ETS-004521', '+16025550099', 'ACxxxxx', 'token...', true, 'Reply STOP to opt out', 'https://api.engagetosell.com/webhook/sms', 'Sales', '1 SMS/second', '2025-02-01 10:00:00', '2026-06-13 14:00:00')
```

### message_log Table

```sql
CREATE TABLE message_log (
  id INT PRIMARY KEY,
  account_id VARCHAR(50),
  room_id VARCHAR(100),
  channel VARCHAR(20),  -- 'facebook' or 'sms'
  direction VARCHAR(10),  -- 'inbound' or 'outbound'
  sender VARCHAR(255),
  recipient VARCHAR(255),
  message_text TEXT,
  message_id VARCHAR(100),
  status VARCHAR(50),  -- 'received', 'delivered', 'read', 'failed'
  external_id VARCHAR(100),
  timestamp TIMESTAMP,
  created_at TIMESTAMP
);
```

## Data Flow

### Inbound Facebook Message

1. **Customer Action:** Customer sends message via Facebook Messenger
2. **Facebook Webhook:** Facebook sends POST to proxy webhook
3. **Proxy Processing:** 
   - Extracts sender ID and page ID
   - Looks up account in BCProxy
   - Identifies RC department and room
4. **Rocket.Chat:** Message inserted into omnichannel room
5. **Agent Notification:** Agent sees message and responds
6. **Outbound:** Agent types response in RC → proxy sends via Facebook API
7. **Logging:** Message and response logged to message_log table

### Inbound SMS Message

1. **Customer Action:** Customer sends SMS to dealer number
2. **Twilio Webhook:** Twilio sends webhook to proxy
3. **Proxy Processing:**
   - Extracts customer phone and dealer number
   - Looks up SMS channel in BCProxy
   - Checks if SMS enabled for account
4. **Rocket.Chat:** SMS inserted as omnichannel message (tagged with phone)
5. **Agent Response:** Agent types response in RC
6. **Outbound SMS:** Proxy calls Twilio API with response
7. **Twilio:** Delivers SMS to customer
8. **Logging:** Message and response logged

### Channel Configuration (Animator)

1. **Dealer Admin:** Opens ETS Dashboard → Settings → Channels
2. **Facebook Setup:** 
   - Connects Facebook Business Manager account
   - Selects Facebook page to enable
   - Dashboard stores page ID and access token in BCProxy
3. **SMS Setup:**
   - Enters Twilio phone number
   - Specifies custom STOP message
   - Selects routing department
   - Dashboard stores config in BCProxy
4. **Feature Toggle:** Admin enables/disables SMS or Facebook for account
5. **Real-Time Update:** Proxy checks BCProxy on message receipt to determine active channels

## Use Cases in DAS

### Facebook Messenger Inbound

**Flow:**
1. Customer messages "Hi, interested in a black Civic" via Facebook
2. Facebook webhook → ETS Proxy
3. Proxy routes to Valley Honda account's Sales department
4. Message appears in Rocket.Chat omnichannel room
5. Agent responds "We have several in stock!"
6. Agent's message sent back via Facebook Messenger API
7. Customer receives response on Facebook

### SMS Inbound with STOP Handling

**Flow:**
1. Customer texts "+16025550099" with "What's the price of the new Civic?"
2. Twilio webhook → ETS Proxy
3. Proxy routes to dealer SMS channel (Sales dept)
4. Message appears in Rocket.Chat omnichannel room
5. Agent responds with price
6. Proxy sends SMS via Twilio API
7. If customer later texts "STOP", Twilio webhook triggered
8. Proxy adds customer to suppression list, logs opt-out

### Multi-Channel Conversation

**Flow:**
1. Customer initially messages on Facebook
2. Conversation in RC omnichannel room
3. Agent asks "Can I call you?" and requests phone number
4. Customer provides phone
5. Agent sends SMS to customer's phone (same RC room)
6. Conversation continues via SMS in same omnichannel interface
7. Both Facebook and SMS messages logged in single message_log

### Disabling Channel for Account

**Flow:**
1. Dealer admin disables SMS in Dashboard (compliance requirement)
2. Dashboard updates `sms_channels.enabled = false` for account
3. On next inbound SMS, proxy checks enabled flag
4. SMS rejected/not routed
5. Alternative: proxy can return error to Twilio

## Configuration Management

### Multi-Tenant Isolation

- Each Facebook page linked to one ETS account
- Each SMS channel linked to one account
- BCProxy tables have `account_id` foreign key
- No cross-account message leakage

### Feature Flags

- `facebook_enabled` — Enable/disable Facebook Messenger per account
- `sms_enabled` — Enable/disable SMS per account
- Stored in ETS Dashboard account config
- Checked by proxy before routing message

### Customization

- **STOP Message:** Per account, customizable in Dashboard
- **Twilio Phone:** Per account, can have multiple SMS channels
- **Facebook Pages:** Per account, can have multiple pages
- **Department Routing:** SMS/Facebook routes to specific RC department

## Troubleshooting

### Messages Not Appearing in Rocket.Chat

**Checklist:**
1. Channel enabled for account (check Dashboard Settings)
2. Facebook webhook URL configured correctly
3. Twilio webhook URL configured correctly
4. BCProxy database has account entry for channel
5. Rocket.Chat omnichannel enabled
6. Agent in correct department subscribed to room

**Investigation:**
1. Check BCProxy message_log table for message arrival
2. Verify webhook HTTP 200 response from proxy
3. Check proxy logs for account lookup failure
4. Verify RC API connectivity from proxy

### Outbound Messages Not Sending

**Checklist:**
1. Agent has permission to send messages
2. Facebook page access token valid and stored in BCProxy
3. Twilio account credentials valid
4. Customer not on suppression list
5. Rate limits not exceeded (1 SMS/sec, 10,000 msgs/min for email)

**Investigation:**
1. Check message_log for status="failed" entries
2. Query Facebook page access token expiration
3. Verify Twilio account balance > $0
4. Check Twilio/Facebook API response in proxy logs

### SMS Delivery Issues

**Causes:**
- Invalid phone number (customer typo)
- Customer on STOP list
- Twilio account issue (balance, rate limit, configuration)
- Network connectivity

**Fix:**
1. Verify customer phone in message_log
2. Check suppression list (Twilio account)
3. Check Twilio balance and rate limit usage
4. Test SMS via Twilio dashboard directly

### Facebook Messenger Issues

**Causes:**
- Page access token expired (Facebook expires quarterly)
- Webhook URL unreachable
- Facebook page not associated with Business Manager
- Proxy IP blocked by Facebook

**Fix:**
1. Regenerate page access token in Facebook Business Manager
2. Verify webhook URL is publicly accessible (HTTPS)
3. Verify page in Business Manager account
4. Check firewall/proxy IP allowlist with Facebook

## Security Considerations

### Authentication & Authorization

- Facebook page access tokens stored encrypted in BCProxy
- Twilio account credentials stored encrypted in BCProxy
- All inbound webhooks validated (signature verification recommended)
- Outbound API calls use stored credentials

### Data Sensitivity

- Customer phone numbers in message_log
- Facebook user IDs and names in messages
- Message content may contain PII
- Suppression/STOP lists contain sensitive customer data

### Multi-Tenant Isolation

- BCProxy queries always filtered by `account_id`
- Webhook endpoints verify account ownership
- No cross-account access to message history
- Credentials stored per account, not shared

### Compliance

- STOP message logging (SMS opt-out compliance)
- Message retention policies (per dealer requirements)
- PII handling (message encryption at rest recommended)
- GDPR/CCPA data deletion (must clean message_log)

## Related Documentation

- **Confluence:** [Configuring Account for FB Messenger on ETS APP](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3168960514)
- **Confluence:** [Enabling Facebook and SMS Channels in RocketChat](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3393355779)
- **Confluence:** [How to Update the SMS Stop Message in Engage To Sell](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3577217031)
- **Confluence:** [Permissions and Admin Access for EngageToSell Facebook Setup](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3168534582)
- **Repository:** [EngageToSellLLC/Dashboard (BCProxy)](https://github.com/EngageToSellLLC)
- **API Integration:** [Rocket.Chat Omnichannel](https://developer.rocket.chat/reference/api-rest-api#omnichannel)

## References

- **BCProxy Database:** livejoin.engagetosell.com:3306
- **ETS Proxy Webhooks:** https://api.engagetosell.com/webhook/{facebook|sms}
- **Facebook Messenger API:** https://developers.facebook.com/docs/messenger-platform
- **Twilio SMS API:** https://www.twilio.com/en-us/sms
- **ETS Dashboard:** https://dashboard.engagetosell.com
