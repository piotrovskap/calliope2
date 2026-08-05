---
source: DAS Confluence + Integration Explorer v5
page_id: 3514073090
title: ETS Dashboard API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3514073090
type: confluence-doc
pulled: 2026-06-13 (curated from Confluence + DAS Integration Explorer v5)
note: content synthesized from ETS Dashboard and LiveJoin System Architecture documentation; covers dealer account configuration, joiner rules, department management
---

# ETS Dashboard API Info

## Background

The **ETS Dashboard API** is the central control plane for Engage To Sell (ETS), a live chat + joiner coordination platform built on Rocket.Chat. It manages:

- **Dealer account configuration** (Twilio phone numbers, Facebook page integration, SMS/chat settings)
- **Joiner rules** (who gets invited when, which departments, SMS vs email preferences)
- **Department management** (sales, service, finance, etc.)
- **Feature flags** (SMS enabled, Facebook Messenger enabled, SMS/email joiner notifications)

The Dashboard API serves the ETS Dashboard UI (configuration interface) and is queried by LiveJoin3 and Rocket.Chat Lead Plugin to synchronize rules and settings in real-time.

**Technology Stack:**
- **Language:** PHP / Phalcon MVC
- **Hosting:** AWS (dashboardapi.engagetosell.com)
- **Repository:** EngageToSellLLC/Dashboard
- **Consumers:** ETS Dashboard UI, LiveJoin3 Service, Rocket.Chat Lead Plugin, Response Path / AI Engage

## Integration Architecture

```
[ETS Dashboard (UI)]
    ↓ (user configures account)
[ETS Dashboard API: REST endpoints]
    ↓ (stores config)
[MySQL backend]
    ↓ (query rules on demand)
[Rocket.Chat Lead Plugin] [LiveJoin3 Service]
    ↓ (sync on startup, websocket updates)
[Real-time joiner rule evaluation]
    ↓
[SendGrid + Twilio dispatch]
```

## Primary Integration Points

### 1. ETS Dashboard UI
- **Role:** Configuration interface for dealers
- **Calls:** GET account, GET join rules, POST account updates
- **Features:** Account setup, joiner management, department management

### 2. LiveJoin3 Service
- **Role:** Evaluates joiner rules in real-time
- **Calls:** GET join rules on startup, periodic syncs
- **Usage:** When lead event triggers, LiveJoin3 queries current rules to find matching joiners

### 3. Rocket.Chat Lead Plugin
- **Role:** Detects qualifying chat events (visitor message, lead injected)
- **Calls:** GET join rules from Dashboard
- **Usage:** Filters which events should trigger LiveJoin invite

### 4. Response Path / AI Engage
- **Role:** May query account settings for AI Engage Messaging product
- **Calls:** GET account configuration
- **Usage:** Retrieve SMS/chat feature flags, Twilio numbers

## API Reference

### Base URL
```
https://dashboardapi.engagetosell.com/api
```

### Authentication
- **Method:** API Key (header-based) or session-based auth
- **Headers:** `Authorization: Bearer {api_key}` or session cookie

### Key Endpoints

#### GET Account Configuration

**Endpoint:** `GET /api/v1/account/getAccount`

**Query Parameters:**
- `accountId` (required) — Account ID (e.g., `ETS-004521`)
- `dealerId` (optional) — Dealer ID (e.g., `DLR-004521`)

**Response:**
```json
{
  "accountId": "ETS-004521",
  "dealerId": "DLR-004521",
  "dealerName": "Valley Honda",
  "websiteUrl": "https://www.valleyhonda.com",
  "rocketchatDepartmentId": "rc-dept-004521",
  "status": "active",
  "smsEnabled": true,
  "facebookEnabled": true,
  "facebookPageId": "123456789012345",
  "twilioPhoneNumber": "+16025550099",
  "leadCap": 50,
  "package": "AI Engage Messaging",
  "responsePathLeadId": "RP-88291"
}
```

**Key Fields:**
- `accountId` — Unique ETS account identifier
- `dealerName` — Dealer display name
- `smsEnabled` — Is SMS communication enabled?
- `facebookEnabled` — Is Facebook Messenger integration enabled?
- `twilioPhoneNumber` — Dealer's Twilio number for SMS joiner invites
- `facebookPageId` — Integrated Facebook page ID
- `leadCap` — Max concurrent leads allowed
- `package` — ETS subscription tier (e.g., "AI Engage Messaging")

#### GET Joiner Rules

**Endpoint:** `GET /api/v1/lead/getJoinRule`

**Query Parameters:**
- `customerId` (required) — Account ID (e.g., `ETS-004521`)
- `department` (optional) — Filter by department (e.g., `Sales`, `Service`)

**Response:**
```json
{
  "ruleId": "rule-004521-001",
  "customerId": "ETS-004521",
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
    },
    {
      "joinerId": "joiner-002",
      "name": "Sarah Johnson",
      "email": "sjohnson@valleyhonda.com",
      "phone": "+16025551235",
      "notifyBySms": false,
      "notifyByEmail": true,
      "active": true
    }
  ],
  "triggerOnFirstVisitorResponse": true,
  "triggerOnLeadInjected": true,
  "inviteMethod": ["sms", "email"],
  "createdAt": "2025-06-01T10:00:00Z",
  "updatedAt": "2025-06-10T14:22:35Z"
}
```

**Key Fields:**
- `joiners[]` — Array of department staff who receive invites
- `triggerOnFirstVisitorResponse` — Invite on visitor's first message?
- `triggerOnLeadInjected` — Invite when lead manually injected?
- `inviteMethod` — How to notify: `["sms"]`, `["email"]`, or both
- `notifyBySms` — Per-joiner SMS preference
- `notifyByEmail` — Per-joiner email preference

#### GET All ETS Customers

**Endpoint:** `GET /api/v1/lead/getETSCustomers`

**Response:**
```json
{
  "customers": [
    {
      "accountId": "ETS-004521",
      "dealerName": "Valley Honda",
      "status": "active"
    },
    {
      "accountId": "ETS-004522",
      "dealerName": "Prestige BMW",
      "status": "active"
    }
  ],
  "total": 2
}
```

#### POST Update Account Settings

**Endpoint:** `POST /api/v1/account/setAccount` ⚠️ **Requires Authentication**

**Request Body:**
```json
{
  "accountId": "ETS-004521",
  "smsEnabled": true,
  "facebookEnabled": true,
  "facebookPageId": "123456789012345",
  "twilioPhoneNumber": "+16025550099",
  "leadCap": 75,
  "package": "AI Engage Messaging Plus"
}
```

**Response:**
```json
{
  "success": true,
  "accountId": "ETS-004521",
  "updatedAt": "2025-06-10T14:22:35Z"
}
```

#### GET Facebook Pages (for SMS/FB Proxy)

**Endpoint:** `GET /api/v1/proxy/getFacebookPages`

**Query Parameters:**
- `accountId` (required)

**Response:**
```json
{
  "pages": [
    {
      "pageId": "123456789012345",
      "pageName": "Valley Honda",
      "pageUrl": "https://www.facebook.com/valleyhonda",
      "accessToken": "EAAxxxxxx..." // obfuscated
    }
  ]
}
```

## Data Flow

### Joiner Rule Synchronization

1. **Dashboard UI:** Dealer configures joiner rules (add/remove joiners, update departments)
2. **ETS Dashboard API:** Stores rule changes to MySQL
3. **LiveJoin3 Startup:** Queries `GET /api/v1/lead/getJoinRule` to load current rules
4. **Rocket.Chat Lead Plugin:** Also queries rules on initialization
5. **Real-Time Events:** When chat event occurs, LiveJoin3 evaluates stored rules in memory
6. **Invite Dispatch:** Sends SMS/email to matching joiners via Twilio/SendGrid

### Account Setting Propagation

1. **Dashboard UI:** Dealer updates SMS/Facebook settings
2. **ETS Dashboard API:** `POST /api/v1/account/setAccount` updates config
3. **Rocket.Chat Lead Plugin:** May poll account settings periodically
4. **LiveJoin3:** Reads settings (SMS enabled?) when dispatching invites

## Use Cases

### New Joiner Addition (via Dashboard)

**Flow:**
1. Dealer adds new staff member to Sales department
2. Dashboard UI calls `POST /api/v1/account/setAccount` with new joiner
3. API stores rule change
4. On next chat event, LiveJoin3 queries rules and includes new joiner
5. New joiner receives SMS/email for qualifying leads

### Joiner Notification Preference Change

**Flow:**
1. Joiner (e.g., Mike) updates preferences (disable SMS, keep email)
2. Dashboard UI updates joiner object in rule
3. API persists change
4. On next invite, LiveJoin3 reads updated preferences
5. Only sends email to Mike (no SMS)

### SMS/Facebook Feature Toggle

**Flow:**
1. Dealer disables SMS communication (e.g., compliance requirement)
2. Dashboard UI calls `POST /api/v1/account/setAccount` with `smsEnabled: false`
3. API stores change
4. On next invite, LiveJoin3 checks feature flag
5. Only sends email invites, no SMS

## Configuration Management

### Multi-Tenant Isolation

- Every API call scoped to `accountId` or `customerId`
- No cross-account data leakage
- Department-level filtering supported

### Feature Flags

- `smsEnabled` — Enable/disable SMS joiner invites
- `facebookEnabled` — Enable/disable Facebook Messenger
- `leadCap` — Concurrent lead limit per account

### Joiner Preferences

Per joiner:
- `notifyBySms` — Receive SMS invites
- `notifyByEmail` — Receive email invites
- `active` — Is joiner enabled

## Troubleshooting

### Joiner Not Receiving Invites

**Checklist:**

1. **Joiner Active** — Check `joiner.active == true` in rule
2. **Notification Method Enabled** — Verify `notifyBySms` or `notifyByEmail` is true
3. **Feature Enabled** — Check account's `smsEnabled` or `facebookEnabled`
4. **Rule Trigger Match** — Does chat event match rule trigger (`triggerOnFirstVisitorResponse`, `triggerOnLeadInjected`)?
5. **Joiner Email/Phone Valid** — Verify contact info is correct (no typos)

### Rule Changes Not Applied

**Possible Causes:**
- LiveJoin3 hasn't synced rules since change (restart LiveJoin3)
- Rocket.Chat Lead Plugin using stale cache (restart plugin)
- API returned error silently

**Investigation:**
1. Query `GET /api/v1/lead/getJoinRule` directly
2. Verify returned rule has your change
3. Restart LiveJoin3 and Rocket.Chat if necessary

### Account Configuration Not Updating

**Checklist:**
1. **Authentication Valid** — API key or session not expired
2. **Account ID Correct** — Using correct ETS account ID
3. **API Response Success** — Check for error in response
4. **Write Permissions** — User account has admin role

## Security Considerations

### Authentication

- API keys should be stored securely (environment variables, secrets manager)
- Session-based auth uses secure cookies (HttpOnly, Secure flags)
- All requests over HTTPS

### Multi-Tenant Isolation

- Every call must be scoped to account/customer
- No bulk operations across accounts
- Privilege escalation checks at endpoint level

### Data Sensitivity

- Phone numbers and emails in responses
- Facebook page access tokens obfuscated in most responses
- Audit logging recommended for account changes

## Related Documentation

- **Confluence:** [LiveJoin System Architecture](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3510730771)
- **Confluence:** [Configuring Hoppscotch for ETS](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3514073090)
- **Confluence:** [ETS Troubleshooting Guide](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3514793992)
- **Repository:** [EngageToSellLLC/Dashboard](https://github.com/EngageToSellLLC)
- **Repository:** [EngageToSellLLC/LiveJoin3](https://github.com/EngageToSellLLC)

## References

- **ETS Dashboard:** https://dashboard.engagetosell.com
- **ETS API Base:** https://dashboardapi.engagetosell.com/api
- **LiveJoin Documentation:** See LiveJoin System Architecture page
- **Rocket.Chat Lead Plugin:** Part of ETS deployment

