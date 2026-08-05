---
source: DAS Confluence + Integration Explorer v5
page_id: 3240493061
title: Rocket.Chat (ETS Instance) API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3240493061
type: confluence-doc
pulled: 2026-06-13 (curated from Confluence + DAS Integration Explorer v5; synthesized from LiveJoin System Architecture and Rocket.Chat Lead Plugin documentation)
note: covers Lead Plugin event API, omnichannel integration, Facebook/SMS channel management, department routing
---

# Rocket.Chat (ETS Instance) API Info

## Background

**Rocket.Chat (ETS Instance)** is the **live chat engine and message routing core** for Engage To Sell (ETS), hosting the Lead Plugin that detects qualifying chat events and coordinates real-time joiner invitations. It manages:

- **Omnichannel event detection** (visitor messages, agent assignments, department routing)
- **Lead Plugin logic** (forwards events to LiveJoin3, receives joiner invites)
- **Multi-channel routing** (web chat, Facebook Messenger, SMS via BC Proxy)
- **Department management** (queue assignment, load balancing)
- **Message mirroring** (joiner messages appear as agent responses in chat)
- **Whisper functionality** (private agent ↔ joiner communication)

The Rocket.Chat instance serves as the event hub for LiveJoin, connecting the ETS Dashboard configuration layer with the LiveJoin3 processing engine and external notification systems.

**Technology Stack:**
- **Platform:** Rocket.Chat Community Edition (self-hosted)
- **Database:** MongoDB
- **Custom Plugin:** RocketChat-LeadPlugin
- **Hosting:** AWS (chatapi.engagetosell.com)
- **Repository:** EngageToSellLLC/RocketChat-LeadPlugin
- **Consumers:** ETS Dashboard, LiveJoin3 Service, Response Path, AI Engage

## Integration Architecture

```
[Visitor Chat / Agent Messages]
    ↓
[Rocket.Chat Omnichannel Layer]
    ↓
[Rocket.Chat Lead Plugin]
    ↓ (Event API: POST /api/v1/lead/event)
[LiveJoin3 Service]
    ↓ (Rule evaluation)
[SendGrid + Twilio dispatch]
    ↓
[Joiner SMS/Email invites]
    ↓
[Joiner joins chat via WebSocket]
    ↓
[Messages mirrored in Rocket.Chat]
```

## Primary Integration Points

### 1. Omnichannel Events (Internal)

**Role:** Channel registration and event propagation
- **Triggers:** Visitor message, agent joined, department set, lead injected, visitor first response
- **Features:** Event queuing, department routing, agent assignment
- **Connection:** WebSocket + REST API

### 2. LiveJoin3 Service (External)

**Role:** Consumes events, evaluates rules, returns invite data
- **API Calls:** 
  - `POST /api/v1/lead/event` (plugin → LiveJoin3)
  - `GET /api/v1/departments` (fetch department config)
  - `GET /api/v1/joinRule` (fetch rule updates)
- **Usage:** On chat event, plugin forwards to LiveJoin3 for rule evaluation; LiveJoin3 sends joiner invites back to Rocket.Chat via socket

### 3. ETS Dashboard (Configuration)

**Role:** Provides joiner rules and account settings
- **API Calls:** `GET /api/v1/account/getAccount`, `GET /api/v1/lead/getJoinRule`
- **Usage:** Plugin syncs rules on startup and periodic intervals

### 4. Facebook / SMS Channel Proxies

**Role:** External message channels
- **Integration:** BC Proxy (SMS/Facebook), Facebook Messenger API
- **Usage:** Inbound messages converted to Rocket.Chat omnichannel format; outbound agent messages relayed to channels

## API Reference

### Base URL

```
https://chatapi.engagetosell.com/api
```

### Authentication

- **Method:** OAuth 2.0 (user token) or API Key (service-to-service)
- **Headers:** `Authorization: Bearer {auth_token}` or `X-Auth-Token` + `X-User-Id`
- **Scope:** Plugin operations are typically authenticated as system bot account

### Key Endpoints (Lead Plugin)

#### POST Event Trigger

**Endpoint:** `POST /api/v1/lead/event` ⚠️ **Requires Auth**

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
  "roomId": "GENERAL",
  "forwardedToLiveJoin3": true,
  "timestamp": "2025-06-10T14:22:35Z"
}
```

**Key Fields:**
- `event` — Event type that triggered (determines joiner rule matching)
- `customerId` — Account scope (ETS account ID)
- `department` — Department for rule filtering
- `metadata` — Custom data passed through to LiveJoin3 for invite tracking

#### GET Omnichannel Departments

**Endpoint:** `GET /api/v1/omnichannel/departments`

**Query Parameters:**
- `customerId` (optional) — Filter to account

**Response:**
```json
{
  "departments": [
    {
      "departmentId": "rc-dept-004521",
      "name": "Sales",
      "enabled": true,
      "description": "Sales team for Valley Honda",
      "numAgents": 3,
      "numOpenChats": 5,
      "chatQueueLimit": 10,
      "priority": 1
    },
    {
      "departmentId": "rc-dept-004522",
      "name": "Service",
      "enabled": true,
      "description": "Service team for Valley Honda",
      "numAgents": 2,
      "numOpenChats": 3,
      "chatQueueLimit": 8,
      "priority": 2
    }
  ]
}
```

#### GET Room/Chat Info

**Endpoint:** `GET /api/v1/channels.info` or `GET /api/v1/rooms.get`

**Query Parameters:**
- `roomId` (required) — Rocket.Chat room ID
- `roomName` (optional alternative) — Room name

**Response:**
```json
{
  "channel": {
    "roomId": "GENERAL",
    "name": "general",
    "fname": "General",
    "type": "p|c|d",
    "teamMain": false,
    "topic": "Live chat room for ETS-004521",
    "announcement": null,
    "tags": ["live-chat", "ets"],
    "customFields": {
      "customerId": "ETS-004521",
      "dealerId": "DLR-004521",
      "department": "Sales",
      "visitorId": "vis-001"
    },
    "usernames": ["visitor-name", "agent-1"],
    "messages": 42,
    "ts": "2025-06-01T10:00:00Z",
    "lastMessage": {
      "text": "Thanks for your help!",
      "username": "visitor-name",
      "ts": "2025-06-10T14:22:35Z"
    },
    "ro": false,
    "teamPermissions": ["createRoom"],
    "statusLivechat": "open|closed|on-hold"
  }
}
```

#### POST Send Message (Agent/System)

**Endpoint:** `POST /api/v1/chat.sendMessage` ⚠️ **Requires Auth**

**Request Body:**
```json
{
  "roomId": "GENERAL",
  "text": "Hello! A specialist is joining to assist you.",
  "attachments": [
    {
      "text": "Click here to view vehicle details",
      "actionUrl": "https://example.com/vehicle/123"
    }
  ],
  "emoji": ":wave:",
  "avatar": "https://avatars.example.com/agent.png"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": {
    "roomId": "GENERAL",
    "text": "Hello! A specialist is joining to assist you.",
    "ts": "2025-06-10T14:22:35Z",
    "_id": "msg-88291",
    "u": {
      "username": "system-bot",
      "name": "ETS System Bot"
    }
  }
}
```

#### POST Update Room Custom Fields

**Endpoint:** `POST /api/v1/rooms.update` ⚠️ **Requires Auth**

**Request Body:**
```json
{
  "roomId": "GENERAL",
  "customFields": {
    "customerId": "ETS-004521",
    "dealerId": "DLR-004521",
    "department": "Sales",
    "visitorPhone": "+16025551234",
    "visitorEmail": "john@example.com",
    "vehicleInterest": "2025 Toyota Camry",
    "leadSource": "web-form"
  }
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "room": {
    "roomId": "GENERAL",
    "customFields": { ... }
  }
}
```

#### POST Add User to Room (Joiner Join)

**Endpoint:** `POST /api/v1/channels.invite` or `POST /api/v1/rooms.addMember` ⚠️ **Requires Auth**

**Request Body:**
```json
{
  "roomId": "GENERAL",
  "userId": "joiner-12345"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "message": {
    "text": "joiner-name joined the room"
  }
}
```

#### POST Update User Presence/Status

**Endpoint:** `POST /api/v1/users.setStatus`

**Request Body:**
```json
{
  "userId": "joiner-12345",
  "status": "online|busy|away|offline",
  "statusText": "Assisting customer"
}
```

**Response:** `200 OK`
```json
{
  "success": true,
  "status": "online"
}
```

#### WebSocket Connection (Real-Time)

**Endpoint:** `wss://chatapi.engagetosell.com/websocket`

**Connection Types:**
- **Joiner Real-Time Updates:** Socket subscriptions to room messages, joiner status
- **Agent Updates:** Real-time notification of joiner joins, whispers
- **Plugin Updates:** Receive rule changes from LiveJoin3, ETS Dashboard config sync

**Subscribe to Room Messages:**
```json
{
  "msg": "sub",
  "id": "1",
  "name": "room-messages",
  "params": [
    "GENERAL",
    false
  ]
}
```

## Data Flow

### Event Detection & LiveJoin Trigger

1. **Visitor Action:** Visitor sends first message, agent sets department, or lead injected
2. **Omnichannel Layer:** Rocket.Chat detects and logs event
3. **Lead Plugin:** Captures event details (customer, department, agent, visitor info)
4. **LiveJoin API Call:** `POST /api/v1/lead/event` with event payload
5. **LiveJoin3 Processing:** Evaluates joiner rules, determines matching joiners
6. **Joiner Invite:** LiveJoin3 sends SMS/email via Twilio/SendGrid
7. **WebSocket Notification:** LiveJoin3 notifies Rocket.Chat to add joiner to room
8. **Room Update:** Plugin adds joiner user ID to room; joiner appears in chat

### Message Mirroring (Joiner ↔ Agent)

1. **Joiner Sends Message:** Via joiner app/browser (WebSocket)
2. **Joiner Message Received:** Rocket.Chat captures message from joiner user
3. **Message Formatting:** Plugin impersonates joiner as agent for chat visibility
4. **Agent Chat View:** Agent sees joiner message as "@Joiner Name: [message]" in chat
5. **Message Persistence:** Stored in Rocket.Chat and synced to LiveJoin3 logs

### Whisper Flow (Agent → Joiner)

1. **Agent Types Whisper:** `/whisper [text]` in chat
2. **Plugin Detects:** Captures whisper command
3. **LiveJoin3 Forward:** Sends whisper to joiner app via WebSocket
4. **Joiner Notification:** Whisper appears as private message to joiner
5. **No Persistence in Chat:** Whisper not visible in main chat history or future agent views

## Use Cases in DAS

### New Lead Arrival with Joiner Notification

**Flow:**
1. Visitor submits lead via web form → Response Path captures it
2. Lead routed to dealer account (ETS-004521)
3. Response Path or ETS Dashboard injects lead into Rocket.Chat room
4. Lead Plugin receives `lead_injected` event
5. Plugin calls `POST /api/v1/lead/event` with customer/department/vehicle details
6. LiveJoin3 evaluates rules: Sales department joiners match trigger condition
7. LiveJoin3 sends SMS invites to matching joiners (Mike, Sarah)
8. Joiner joins via Rocket.Chat app; room user list updated
9. Agent sees joiner in sidebar and messages are visible in chat

### Agent Department Assignment Trigger

**Flow:**
1. Agent assigns visitor to Sales department (via Rocket.Chat UI)
2. Omnichannel layer detects department change
3. Lead Plugin fires `department_set` event
4. Plugin calls `POST /api/v1/lead/event` with department="Sales"
5. LiveJoin3 re-evaluates rules with new department
6. If sales-specific joiners apply, invites sent
7. New joiners added to room

### Multi-Channel Message Inbound (Facebook/SMS)

**Flow:**
1. Customer messages dealer via Facebook Messenger
2. BC Proxy receives message, converts to Rocket.Chat omnichannel format
3. Message appears in Rocket.Chat room as visitor message
4. Lead Plugin detects incoming message event
5. Triggers joiner rule evaluation (if configured)
6. Joiner invites sent if conditions match

### Agent Response to Customer

**Flow:**
1. Agent types response in Rocket.Chat
2. Message sent via `POST /api/v1/chat.sendMessage`
3. Agent message appears in room
4. Message simultaneously relayed to Facebook/SMS via BC Proxy
5. Customer receives response on original channel

## Configuration Management

### Multi-Tenant Isolation

- Every room/chat scoped to `customerId` (ETS account)
- Department-level filtering supported
- Custom fields track dealer ID, lead source, vehicle info
- No cross-account visibility

### Department Structure

- Each dealer has departments (Sales, Service, Finance)
- Department maps to joiner rule
- Determines which staff receive invites
- Queue limits and priorities configurable

### Feature Flags (Per-Account)

- `smsEnabled` — Enable SMS channel
- `facebookEnabled` — Enable Facebook Messenger
- `leadPluginEnabled` — Enable/disable Live Plugin event forwarding
- `whisperEnabled` — Enable/disable whisper functionality

## Troubleshooting

### Joiner Not Joining Room

**Checklist:**
1. Joiner invited via SMS/email (check LiveJoin3 logs)
2. Joiner user account created in Rocket.Chat
3. WebSocket connection established (browser console)
4. Plugin successfully called `POST /api/v1/rooms.addMember`
5. Room custom fields have correct `customerId`

**Investigation:**
1. Query room info: `GET /api/v1/channels.info?roomId=GENERAL`
2. Check user list in response
3. Search LiveJoin3 logs for invite delivery status
4. Verify joiner app/browser not blocked by firewall

### Messages Not Mirroring

**Possible Causes:**
- Plugin not subscribed to room (restart plugin)
- WebSocket disconnected (check browser Network tab)
- Message formatting error (check plugin logs)

**Fix:**
1. Verify plugin is running (check Rocket.Chat admin panel)
2. Restart Lead Plugin
3. Retry message from joiner
4. Check Rocket.Chat logs for plugin errors

### Event Not Triggering LiveJoin3 Invites

**Checklist:**
1. Lead Plugin received event: `POST /api/v1/lead/event` (check plugin logs)
2. Event payload has correct `customerId` and `department`
3. LiveJoin3 API endpoint reachable (test via curl)
4. Room custom fields updated with visitor info
5. Rule matches event trigger condition

**Investigation:**
1. Manually send test event via API
2. Check LiveJoin3 logs for rule evaluation
3. Verify API authentication not expired

### Room Custom Fields Not Updating

**Checklist:**
1. Authentication token valid for `POST /api/v1/rooms.update`
2. Room ID correct
3. Custom field names match schema
4. Plugin has write permissions

**Fix:**
1. Verify plugin bot account has admin role
2. Query room to see current custom fields
3. Update via REST API directly if plugin call fails

## Security Considerations

### Authentication & Authorization

- Lead Plugin runs as system bot account (elevated privileges)
- API calls require valid OAuth token or API key
- WebSocket connections authenticated with user token
- Rate limiting applies to API endpoints

### Data Sensitivity

- Custom fields may contain PII (phone, email, vehicle details)
- Messages stored in MongoDB (encrypted at rest recommended)
- WebSocket communications over HTTPS/WSS
- Audit logging recommended for admin/plugin actions

### Multi-Tenant Isolation

- Room-level access control via custom fields
- No bulk queries across accounts
- Lead Plugin scoped to event room only
- Department filtering prevents cross-department visibility

## Related Documentation

- **Confluence:** [LiveJoin System Architecture](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3510730771)
- **Confluence:** [Rocket.Chat and Response Path — Front-end Activation](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3490054151)
- **Confluence:** [AI Messaging Hybrid — FAQ](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3677913089)
- **Confluence:** [Enabling Facebook and SMS Channels in RocketChat](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3393355779)
- **Repository:** [EngageToSellLLC/RocketChat-LeadPlugin](https://github.com/EngageToSellLLC)
- **Repository:** [EngageToSellLLC/Dashboard](https://github.com/EngageToSellLLC)

## References

- **Rocket.Chat API Docs:** https://developer.rocket.chat/reference/api-rest-api
- **Rocket.Chat WebSocket:** https://developer.rocket.chat/reference/api-realtime-api
- **ETS Chat Instance:** https://chatapi.engagetosell.com
- **LiveJoin System Architecture:** See related documentation above
