---
source: DAS Confluence + Integration Explorer v5
page_id: 3509878789
title: LiveJoin3 Service API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3509878789
type: confluence-doc
pulled: 2026-06-13 (curated from Confluence + DAS Integration Explorer v5; synthesized from LiveJoin System Architecture and LiveJoin Troubleshooting documentation)
note: covers event processing API, rule evaluation, joiner socket management, SMS/email coordination, logging endpoints
---

# LiveJoin3 Service API Info

## Background

**LiveJoin3 Service** is the **processing and orchestration engine** for Engage To Sell's joiner invitation system. It acts as the central hub that evaluates joiner rules, manages real-time socket connections to joiners, coordinates SMS/email notifications via Twilio and SendGrid, and logs all invitation events for debugging.

LiveJoin3 is the critical middleware that connects the Rocket.Chat Lead Plugin (which detects events) with the notification systems and joiners (who receive invites).

**Architecture Role:**
- Receives events from Rocket.Chat Lead Plugin
- Queries joiner rules from ETS Dashboard API
- Evaluates rule conditions in memory
- Sends SMS invites via Twilio
- Sends email invites via SendGrid
- Manages joiner WebSocket connections
- Logs all transactions for troubleshooting

**Technology Stack:**
- **Language:** Node.js / JavaScript
- **Hosting:** AWS (livejoin3.engagetosell.com)
- **Database:** In-memory rule cache + log persistence
- **Sockets:** WebSocket for real-time joiner updates
- **Repository:** EngageToSellLLC/LiveJoin3
- **Consumers:** Rocket.Chat Lead Plugin, Joiner App/Browser, SendGrid, Twilio, ETS Dashboard, Response Path

## Integration Architecture

```
[Rocket.Chat Lead Plugin]
    ↓ (POST /api/v1/lead/event)
[LiveJoin3 Service]
    ↓ (Query rules)
[ETS Dashboard API]
    ↓
[Rule evaluation + Socket management]
    ├─→ [Twilio SMS dispatch]
    ├─→ [SendGrid email dispatch]
    └─→ [Joiner WebSocket broadcast]
    ↓
[Joiner App / Browser]
    ↓
[Joiner joins Rocket.Chat room]
```

## Primary Integration Points

### 1. Rocket.Chat Lead Plugin (Event Source)

**Role:** Sends qualifying chat events to LiveJoin3 for processing
- **API Call:** `POST /api/v1/lead/event`
- **Usage:** Plugin detects visitor message, agent assignment, lead injection
- **Frequency:** Real-time (immediate on event)

### 2. ETS Dashboard API (Rule Configuration)

**Role:** Provides joiner rules and account settings
- **API Calls:** 
  - `GET /api/v1/lead/getJoinRule` (fetch rules for account)
  - `GET /api/v1/account/getAccount` (fetch account config)
- **Usage:** Syncs rules on startup and periodic intervals (every 5-10 minutes)
- **Caching:** LiveJoin3 caches rules in memory; polls for updates

### 3. Twilio (SMS Notification)

**Role:** Sends SMS invites to joiners
- **API Call:** `POST https://api.twilio.com/2010-04-01/Accounts/{AccountSid}/Messages`
- **Usage:** When joiner has SMS notification enabled
- **Frequency:** Per joiner invite (< 1 second after rule evaluation)

### 4. SendGrid (Email Notification)

**Role:** Sends email invites to joiners
- **API Call:** `POST https://api.sendgrid.com/v3/mail/send`
- **Usage:** When joiner has email notification enabled
- **Frequency:** Per joiner invite (< 1 second after rule evaluation)

### 5. Joiner WebSocket (Real-Time Updates)

**Role:** Delivers real-time notifications to joined joiners
- **Connection:** `wss://livejoin3.engagetosell.com/joiner`
- **Usage:** Broadcast joiner invites, new messages, chat updates
- **Frequency:** Continuous (persistent WebSocket)

## API Reference

### Base URL

```
https://livejoin3.engagetosell.com/api
```

### Authentication

- **Method:** JWT (service-to-service)
- **Headers:** `Authorization: Bearer {jwt_token}`
- **Scope:** Internal services only (Rocket.Chat plugin, ETS Dashboard)

### Key Endpoints

#### POST Process Lead Event

**Endpoint:** `POST /api/v1/lead/event` ⚠️ **Requires Auth (JWT)**

**Request Body:**
```json
{
  "event": "lead_injected|visitor_first_response|agent_joined|department_set",
  "roomId": "GENERAL",
  "customerId": "ETS-004521",
  "dealerId": "DLR-004521",
  "department": "Sales",
  "visitorName": "John Smith",
  "visitorEmail": "john@example.com",
  "visitorPhone": "+16025551234",
  "vehicleYear": "2025",
  "vehicleMake": "Toyota",
  "vehicleModel": "Camry",
  "leadSource": "web-form",
  "assignedAgentId": "user-12345",
  "metadata": {
    "responsePathLeadId": "RP-88291",
    "sourceSystem": "response-path"
  }
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "eventId": "evt-004521-001",
  "joinersInvited": 2,
  "inviteDetails": [
    {
      "joinerId": "joiner-001",
      "joinername": "Mike Rodriguez",
      "notificationMethods": ["sms", "email"],
      "smsStatus": "queued",
      "emailStatus": "queued",
      "timestamp": "2025-06-10T14:22:35Z"
    },
    {
      "joinerId": "joiner-002",
      "joinername": "Sarah Johnson",
      "notificationMethods": ["email"],
      "emailStatus": "queued",
      "timestamp": "2025-06-10T14:22:35Z"
    }
  ],
  "ruleUsed": "rule-004521-001",
  "evaluationTimeMs": 45,
  "deliveryTimeMs": 1203
}
```

**Key Fields:**
- `event` — Event type that triggered evaluation
- `customerId` — Account scope
- `department` — Department for rule filtering
- `metadata` — Custom data for invite correlation
- **Response:** Includes joiner count, individual invite statuses, rule used, evaluation metrics

#### GET Joiner Rules

**Endpoint:** `GET /api/v1/lead/joinRule?customerId=ETS-004521[&department=Sales]`

**Query Parameters:**
- `customerId` (required) — Account ID
- `department` (optional) — Filter to department

**Response:** `200 OK`
```json
{
  "customerId": "ETS-004521",
  "rules": [
    {
      "ruleId": "rule-004521-001",
      "department": "Sales",
      "joiners": [
        {
          "joinerId": "joiner-001",
          "name": "Mike Rodriguez",
          "email": "mrodriguez@valleyhonda.com",
          "phone": "+16025551234",
          "notifyBySms": true,
          "notifyByEmail": true,
          "active": true
        }
      ],
      "triggerOnFirstVisitorResponse": true,
      "triggerOnLeadInjected": true,
      "inviteMethod": ["sms", "email"],
      "updatedAt": "2025-06-10T14:22:35Z"
    }
  ],
  "cacheStatus": "fresh",
  "lastSyncTime": "2025-06-10T14:15:00Z"
}
```

**Key Fields:**
- `cacheStatus` — "fresh" (just synced) or "stale" (using cached rules)
- `lastSyncTime` — When rules were last fetched from ETS Dashboard

#### GET Account Configuration

**Endpoint:** `GET /api/v1/account/config?customerId=ETS-004521`

**Response:** `200 OK`
```json
{
  "customerId": "ETS-004521",
  "accountId": "ETS-004521",
  "dealerName": "Valley Honda",
  "smsEnabled": true,
  "facebookEnabled": true,
  "twilioPhoneNumber": "+16025550099",
  "leadCap": 50,
  "features": {
    "joinInvitesEnabled": true,
    "socketNotificationsEnabled": true,
    "smsDeliveryEnabled": true,
    "emailDeliveryEnabled": true
  }
}
```

#### POST Register Joiner Socket Connection

**Endpoint:** `POST /api/v1/joiner/register` ⚠️ **Requires Auth (JWT)**

**Request Body:**
```json
{
  "joinerId": "joiner-001",
  "customerId": "ETS-004521",
  "socketId": "socket-uuid-12345",
  "joinerAppVersion": "2.1.4",
  "deviceType": "mobile|web",
  "timezone": "America/Phoenix"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "joinerId": "joiner-001",
  "socketId": "socket-uuid-12345",
  "connectionStatus": "active",
  "pendingInvites": 0,
  "timestamp": "2025-06-10T14:22:35Z"
}
```

#### GET Activity Logs (Admin/Debug)

**Endpoint:** `GET /api/v1/logs/events?customerId=ETS-004521&eventId=evt-004521-001`

**Query Parameters:**
- `customerId` (required) — Account ID
- `eventId` (optional) — Filter to specific event
- `startTime` (optional) — ISO 8601 timestamp
- `endTime` (optional) — ISO 8601 timestamp
- `limit` (optional) — Max results (default: 100)

**Response:** `200 OK`
```json
{
  "events": [
    {
      "eventId": "evt-004521-001",
      "timestamp": "2025-06-10T14:22:35Z",
      "eventType": "lead_injected",
      "customerId": "ETS-004521",
      "department": "Sales",
      "visitorName": "John Smith",
      "ruleEvaluationResult": "matched",
      "joinersInvited": 2,
      "joiners": [
        {
          "joinerId": "joiner-001",
          "smsStatus": "delivered",
          "emailStatus": "delivered",
          "smsTimestamp": "2025-06-10T14:22:36Z",
          "emailTimestamp": "2025-06-10T14:22:37Z"
        }
      ],
      "metrics": {
        "evaluationTimeMs": 45,
        "smsDeliveryTimeMs": 1200,
        "emailDeliveryTimeMs": 1500
      }
    }
  ],
  "totalCount": 1,
  "pageInfo": {
    "currentPage": 1,
    "pageSize": 100,
    "totalPages": 1
  }
}
```

#### GET Health Check

**Endpoint:** `GET /api/v1/health`

**Response:** `200 OK`
```json
{
  "status": "ok",
  "uptime": 864000000,
  "version": "3.2.1",
  "services": {
    "twilioConnectivity": "ok",
    "sendgridConnectivity": "ok",
    "dbConnectivity": "ok",
    "cacheStatus": "warm"
  }
}
```

#### WebSocket Connection (Joiner Real-Time)

**Endpoint:** `wss://livejoin3.engagetosell.com/joiner`

**Connection Flow:**
```json
// Client → Server: Connect
{
  "type": "connect",
  "joinerId": "joiner-001",
  "customerId": "ETS-004521",
  "sessionToken": "session-uuid"
}

// Server → Client: Connected
{
  "type": "connected",
  "status": "ok"
}

// Server → Client: Invite Notification
{
  "type": "invite",
  "eventId": "evt-004521-001",
  "visitorName": "John Smith",
  "vehicleInterest": "2025 Toyota Camry",
  "agentName": "Agent Sarah",
  "roomId": "GENERAL",
  "joinUrl": "https://chatapi.engagetosell.com/room/GENERAL?joiner=joiner-001"
}

// Client → Server: Invite Accepted
{
  "type": "invite_accepted",
  "inviteId": "inv-001",
  "joinerId": "joiner-001"
}

// Server → Client: Chat Update
{
  "type": "message_update",
  "roomId": "GENERAL",
  "message": "Customer: Thank you for joining!",
  "timestamp": "2025-06-10T14:22:35Z"
}
```

## Data Flow

### Event Reception & Rule Evaluation

1. **Rocket.Chat Plugin:** Detects qualifying event (visitor message, dept set, lead injected)
2. **Plugin → LiveJoin3:** Posts event via `POST /api/v1/lead/event`
3. **LiveJoin3 Receives:** Parses event, extracts customer/department
4. **Rule Lookup:** Queries cached rules for account/department match
5. **Rule Evaluation:** Evaluates trigger conditions (first response? lead injected? correct dept?)
6. **Joiner Matching:** Identifies joiners who match rule (active, department, notification prefs)

### Invitation Dispatch

1. **SMS Invites:** For each joiner with SMS enabled → `POST Twilio /Messages`
2. **Email Invites:** For each joiner with email enabled → `POST SendGrid /mail/send`
3. **Status Tracking:** Logs SMS/email status (queued → delivered/bounced)
4. **Response:** Returns to plugin with invite summary + joiner list

### Joiner Socket Notification (If Online)

1. **Joiner Socket Connected:** Joiner app/browser listening on `wss://livejoin3.engagetosell.com/joiner`
2. **Invite Broadcast:** LiveJoin3 sends `type: invite` message over socket
3. **Joiner Notification:** Shows popup/notification to joiner on their device
4. **Joiner Accepts:** Clicks join link → navigates to Rocket.Chat room

### Post-Invitation

1. **Rocket.Chat:** Adds joiner user to room
2. **Room Sync:** Joiner sees chat history, agents see joiner joined
3. **Message Mirroring:** Joiner messages appear in chat
4. **Log Entry:** LiveJoin3 records joiner joined timestamp

## Use Cases in DAS

### Real-Time Lead Alert (< 5 Seconds)

**Flow:**
1. New lead captured → Response Path injects into Rocket.Chat
2. Lead Plugin detects `lead_injected` event
3. Plugin calls `POST /api/v1/lead/event` with customer/vehicle/lead source
4. LiveJoin3 evaluates rules: "Sales team for this dealer"
5. Matches 2 joiners (Mike, Sarah both active in Sales)
6. SMS to Mike (if online, also WebSocket notification)
7. Email to Sarah
8. Within 5 seconds, Mike receives SMS or sees app notification
9. Mike clicks join link → appears in Rocket.Chat room

### Department-Based Routing

**Flow:**
1. Visitor asks about Service (transmission issue)
2. Agent assigns chat to Service department
3. Lead Plugin detects `department_set` event
4. LiveJoin3 queries rules: "Service department joiners for this account"
5. Matches Service team (different from Sales team)
6. Service team receives invites (not Sales team)

### Visitor Engagement Trigger

**Flow:**
1. Visitor doesn't respond to initial agent message
2. Visitor sends first response → qualifies
3. Lead Plugin detects `visitor_first_response` event
4. Rule condition: `triggerOnFirstVisitorResponse: true`
5. LiveJoin3 evaluates and sends invites only at this point
6. Ensures joiners invited only when customer is actively engaged

### High-Volume Event Handling

**Flow:**
1. Multiple leads arrive simultaneously
2. Each generates event → LiveJoin3 queue
3. Rules cached in memory (fast lookup)
4. SMS/email batched to Twilio/SendGrid
5. Socket broadcasts sent asynchronously
6. Metrics logged: 45ms rule eval, 1200ms SMS deliver per joiner

## Configuration Management

### Multi-Tenant Isolation

- Every event scoped to `customerId`
- Rules cached per account
- No cross-account data leakage
- Department-level filtering supported

### Feature Flags (Per-Account)

- `joinInvitesEnabled` — Enable/disable entire joiner system
- `smsDeliveryEnabled` — Enable/disable SMS invites
- `emailDeliveryEnabled` — Enable/disable email invites
- `socketNotificationsEnabled` — Enable/disable WebSocket real-time

### Performance Tuning

- Rule cache TTL: 5-10 minutes (configurable)
- Max concurrent WebSocket connections per account
- SMS rate limit: ~1000/sec per Twilio account
- Email rate limit: ~10,000/min per SendGrid account

## Troubleshooting

### Joiners Not Receiving Invites

**Checklist:**
1. Event received by LiveJoin3: Check `/api/v1/logs/events` for event ID
2. Rule evaluation succeeded: Check `ruleEvaluationResult` in logs
3. Joiner active in rule: Verify `joiner.active == true` in matched rule
4. Notification method enabled: Check `notifyBySms` and `notifyByEmail` preferences
5. SMS/Email delivery status: Check `smsStatus`, `emailStatus` in logs

**Investigation Steps:**
```bash
# 1. Query event logs for specific event
GET /api/v1/logs/events?eventId=evt-004521-001

# 2. Check joiner rule
GET /api/v1/lead/joinRule?customerId=ETS-004521&department=Sales

# 3. Verify account config
GET /api/v1/account/config?customerId=ETS-004521

# 4. Check health
GET /api/v1/health
```

### High Evaluation Time

**Possible Causes:**
- Large rule set (many joiners per department)
- Network latency fetching rules from Dashboard
- Concurrent event processing overload

**Fix:**
- Check rule cache status (`cacheStatus` in response)
- If stale, manually trigger rule refresh
- Monitor concurrent event queue depth

### SMS/Email Delivery Failures

**Causes:**
- Invalid joiner phone/email address
- Twilio/SendGrid API key expired or rate limited
- Network connectivity issues

**Fix:**
1. Verify contact info in ETS Dashboard
2. Check Twilio/SendGrid account status (API key, rate limits)
3. Query logs: `GET /api/v1/logs/events?customerId=ETS-004521&startTime=...`
4. Check delivery status for each joiner

### Joiner Socket Connection Issues

**Causes:**
- Browser firewall blocking WebSocket
- Network issue (WiFi drop)
- App version mismatch

**Fix:**
1. Verify joiner registered: `POST /api/v1/joiner/register`
2. Check connection status returned
3. Verify WebSocket endpoint reachable
4. Restart joiner app if necessary

### Rule Changes Not Applied

**Causes:**
- LiveJoin3 rule cache still has old rules
- ETS Dashboard API down or returning error

**Fix:**
1. Wait for cache TTL (5-10 min) or restart service
2. Query rules directly: `GET /api/v1/lead/joinRule`
3. Verify ETS Dashboard API available
4. Manual cache invalidation via admin endpoint (if available)

## Security Considerations

### Authentication & Authorization

- Lead Plugin authenticated via JWT (service-to-service)
- Joiner WebSocket authenticated via session token
- All API calls over HTTPS
- Rate limiting on event endpoint (prevent abuse)

### Data Sensitivity

- Event payloads contain PII (visitor name, phone, email)
- Joiner names and contact info in rule responses
- SMS/email sent to external services (Twilio, SendGrid)
- Logs contain PII (searchable by customerId)

### Multi-Tenant Isolation

- Every event/rule query scoped to account
- Joiner socket authenticated per joiner
- No bulk operations across accounts
- Audit logging for data access

## Related Documentation

- **Confluence:** [LiveJoin System Architecture and Components](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3510730771)
- **Confluence:** [LiveJoin Invite Troubleshooting — Engage To Sell](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3509878789)
- **Confluence:** [RCAppDebugLog — LiveJoin3 Admin Logs](https://livejoin3.engagetosell.com/RCAppDebugLog)
- **Repository:** [EngageToSellLLC/LiveJoin3](https://github.com/EngageToSellLLC)
- **Repository:** [EngageToSellLLC/RocketChat-LeadPlugin](https://github.com/EngageToSellLLC)

## References

- **LiveJoin3 API Base:** https://livejoin3.engagetosell.com/api
- **LiveJoin3 Admin Logs:** https://livejoin3.engagetosell.com/RCAppDebugLog
- **Joiner WebSocket:** wss://livejoin3.engagetosell.com/joiner
- **Repository:** https://github.com/EngageToSellLLC/LiveJoin3
