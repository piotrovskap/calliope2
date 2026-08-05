---
source: DAS Confluence + Integration Explorer v5
page_id: 3525541894
title: Microsoft Graph / Outlook API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3525541894
type: confluence-doc
pulled: 2026-06-14 (curated from Confluence + DAS Integration Explorer v5; synthesized from SPIKE research on Outlook integration with Radar)
note: covers OAuth2 integration, email message retrieval, sending capabilities, Radar email ingestion, spike stage development
---

# Microsoft Graph / Outlook API Info

## Background

**Microsoft Graph / Outlook API** is the **email integration layer** for Radar, enabling the system to read from and send emails via Microsoft Outlook / Office 365 mailboxes. This integration is currently in **spike stage**, with foundational work already completed via the RadarMail class in the legacy Radar codebase.

The Microsoft Graph API provides a unified interface to access Outlook mailboxes, making it possible to:
- Read incoming emails and attachments from dealer mailboxes
- Extract customer information and intent from email content
- Send automated responses or notifications
- Track email engagement (opens, replies)
- Archive and organize messages

**Current Status:** Spike in progress (SPIKE — Review Outlook and RADAR Integration, Confluence 3525541894)

**Technology Stack:**
- **API:** Microsoft Graph API v1.0
- **Authentication:** OAuth2 (Mail.ReadWrite, Mail.Send, User.Read scopes)
- **Existing Implementation:** RadarMail class (C#)
- **Language:** C# / .NET (legacy Radar)
- **Hosting:** Azure DevOps / Legacy infrastructure
- **Repository:** dastechnology/Radar (legacy — Azure DevOps)
- **Integration Target:** Radar AI/ML for email intent analysis

## Integration Architecture

```
[Dealer Outlook Mailbox]
    ↓ (OAuth2 auth)
[Microsoft Graph API]
    ↓ (GET /me/messages)
[Radar RadarMail Class]
    ↓ (email ingestion)
[Radar Email Parser]
    ↓ (extract: sender, subject, body, intent)
[Email Analysis Engine]
    ↓ (AI intent detection, classification)
[Radar Email Queue / Lead Matching]
    ↓
[Lead Action / Response Generation]
```

## Primary Integration Points

### 1. Microsoft Graph API (External)

**Role:** Email data source
- **API Endpoint:** `https://graph.microsoft.com/v1.0`
- **Authentication:** OAuth2 with delegated permissions
- **Scopes:** `Mail.ReadWrite`, `Mail.Send`, `User.Read`
- **Usage:** Read emails from dealer mailboxes, send responses

### 2. Radar RadarMail Class (Internal)

**Role:** Email access and parsing
- **Language:** C#
- **Responsibility:** Authenticate to Graph API, fetch emails, parse content
- **Status:** Foundational implementation exists
- **Pending:** Full spike integration with email intent analysis

### 3. Radar AI/ML Pipeline (Internal)

**Role:** Email analysis and intent detection
- **Input:** Raw email text, sender, subject
- **Output:** Classified intent (inquiry, complaint, praise, etc.), extracted entities
- **Model:** OpenAI GPT integration
- **Pending:** Wiring into RadarMail workflow

## API Reference

### Base URL

```
https://graph.microsoft.com/v1.0
```

### Authentication

**Method:** OAuth2 (Delegated Permissions)

**Flow:**
1. User logs in with Outlook credentials
2. App redirects to Microsoft login
3. User grants permissions (Mail.ReadWrite, Mail.Send, User.Read)
4. Microsoft returns authorization code
5. App exchanges code for access token
6. Token used for API calls

**Token Request:**
```
POST https://login.microsoftonline.com/common/oauth2/v2.0/token

Content-Type: application/x-www-form-urlencoded

client_id=YOUR_APP_ID
&scope=Mail.ReadWrite Mail.Send User.Read
&code=AUTHORIZATION_CODE
&redirect_uri=https://yourapp.com/callback
&grant_type=authorization_code
&client_secret=YOUR_CLIENT_SECRET
```

**Token Response:**
```json
{
  "token_type": "Bearer",
  "scope": "Mail.ReadWrite Mail.Send User.Read",
  "expires_in": 3599,
  "access_token": "EwAoA8l6...",
  "refresh_token": "0.ARwA..."
}
```

### Key Endpoints

#### GET Messages (Inbox)

**Endpoint:** `GET /v1.0/me/messages`

**Query Parameters:**
```
?$filter=receivedDateTime gt 2026-06-13T00:00:00Z
&$select=id,from,subject,bodyPreview,receivedDateTime,isRead
&$orderby=receivedDateTime desc
&$top=50
```

**Response:** `200 OK`
```json
{
  "value": [
    {
      "id": "AAMkADAwATZjNmY4ZWRlLWQ4ZDctNDkxOS1iMGEzLTg4ZmYzODM0MDkyNAAuAAAAABVLxHAc...",
      "from": {
        "emailAddress": {
          "name": "John Smith",
          "address": "john@example.com"
        }
      },
      "subject": "Question about 2025 Honda Civic",
      "bodyPreview": "Hi, I'm interested in your 2025 Honda Civic. What's the...",
      "body": {
        "contentType": "html",
        "content": "<html><body><p>Hi, I'm interested in your 2025 Honda Civic. What's the price and availability?</p></body></html>"
      },
      "receivedDateTime": "2026-06-13T14:22:35Z",
      "isRead": false,
      "hasAttachments": false
    }
  ]
}
```

**Key Fields:**
- `from` — Sender email address and name
- `subject` — Email subject (intent indicator)
- `body` — HTML or plain text content
- `receivedDateTime` — When email arrived
- `isRead` — Read status (for filtering)
- `hasAttachments` — Whether email has files

#### GET Message Details

**Endpoint:** `GET /v1.0/me/messages/{messageId}`

**Response:** `200 OK`
```json
{
  "id": "AAMkADAwATZjNmY4ZWRlLWQ4ZDctNDkxOS1iMGEzLTg4ZmYzODM0MDkyNAAuAAAAABVLxHAc...",
  "from": {
    "emailAddress": {
      "name": "John Smith",
      "address": "john@example.com"
    }
  },
  "toRecipients": [
    {
      "emailAddress": {
        "name": "Valley Honda Sales",
        "address": "sales@valleyhonda.com"
      }
    }
  ],
  "subject": "Question about 2025 Honda Civic",
  "body": {
    "contentType": "html",
    "content": "<html><body><p>Hi, I'm interested in your 2025 Honda Civic...</p></body></html>"
  },
  "receivedDateTime": "2026-06-13T14:22:35Z",
  "sender": {
    "emailAddress": {
      "name": "John Smith",
      "address": "john@example.com"
    }
  },
  "replyTo": [
    {
      "emailAddress": {
        "name": "John Smith",
        "address": "john@example.com"
      }
    }
  ],
  "cc": [],
  "bcc": [],
  "isRead": false,
  "isReminderOn": false,
  "hasAttachments": true,
  "attachments": [
    {
      "id": "AAMkADAwATZjNmY4ZWRlLWQ4ZDctNDkxOS1iMGEzLTg4ZmYzODM0MDkyNAAuAAAAABVLxHA...",
      "name": "vehicle-specs.pdf",
      "contentType": "application/pdf",
      "size": 245632
    }
  ]
}
```

#### POST Send Message

**Endpoint:** `POST /v1.0/me/sendMail` ⚠️ **Requires Auth**

**Request Body:**
```json
{
  "message": {
    "subject": "RE: Question about 2025 Honda Civic",
    "body": {
      "contentType": "HTML",
      "content": "<p>Hi John,</p><p>Thanks for your interest! The 2025 Honda Civic is $28,995. We have 3 in stock in Silver and Black. Call us at 602-555-0099 or reply to this email.</p><p>Best regards,<br/>Valley Honda Sales</p>"
    },
    "toRecipients": [
      {
        "emailAddress": {
          "address": "john@example.com"
        }
      }
    ],
    "ccRecipients": [],
    "bccRecipients": [],
    "replyTo": [
      {
        "emailAddress": {
          "address": "sales@valleyhonda.com"
        }
      }
    ]
  },
  "saveToSentItems": "true"
}
```

**Response:** `202 Accepted`
```json
{
  "success": true,
  "timestamp": "2026-06-13T14:25:00Z"
}
```

#### GET Attachments

**Endpoint:** `GET /v1.0/me/messages/{messageId}/attachments/{attachmentId}/$value`

**Response:** Binary file content (PDF, image, etc.)

#### PATCH Mark as Read

**Endpoint:** `PATCH /v1.0/me/messages/{messageId}` ⚠️ **Requires Auth**

**Request Body:**
```json
{
  "isRead": true
}
```

**Response:** `200 OK`

#### POST Move Message to Folder

**Endpoint:** `POST /v1.0/me/messages/{messageId}/move` ⚠️ **Requires Auth**

**Request Body:**
```json
{
  "destinationId": "AQMkADAwATZjNmY4ZWRlLWQ4ZDctNDkxOS1iMGEzLTg4ZmYzODM0MDkyNQAuAAAAABVLxHAcfsjRSL2G3VbPqgEAAAAA3VYzAAA="
}
```

**Response:** `200 OK`

## Data Flow

### Email Ingestion Pipeline

1. **OAuth Trigger:** Radar requests permission to access dealer Outlook mailbox
2. **User Consent:** Dealer admin authorizes access to Mail.ReadWrite, Mail.Send, User.Read
3. **Token Exchange:** Radar exchanges authorization code for access token
4. **Email Retrieval:** RadarMail class calls `GET /v1.0/me/messages`
5. **Filtering:** Query filters for unread emails since last sync
6. **Parsing:** Extract sender, subject, body, attachments
7. **AI Analysis:** Pass email content to OpenAI for intent classification
8. **Lead Matching:** Correlate email intent with existing lead records
9. **Action Generation:** Generate response or escalation based on intent
10. **Archive/Mark:** Mark email as read and move to "Radar Processed" folder

### Email Response Flow

1. **Automated Response:** Radar AI generates contextual reply
2. **Compose:** `POST /v1.0/me/sendMail` with response body
3. **Send:** Email routed through dealer's Outlook account
4. **Archive:** Original email moved to processed folder
5. **Logging:** Response logged with correlation to lead record

## Use Cases in DAS

### Email Lead Capture

**Flow:**
1. Customer emails dealership: "Hi, interested in a black Civic"
2. Email arrives in dealer Outlook inbox
3. Radar fetches unread emails via Graph API
4. RadarMail parses email: sender=john@example.com, subject contains "interested"
5. Radar AI detects intent="vehicle_inquiry"
6. Radar correlates with existing lead or creates new lead
7. Radar generates response: "Thanks for your interest. We have 3 in stock..."
8. `POST /sendMail` sends response via dealer's Outlook
9. Original email marked as read and archived

### Email Complaint Routing

**Flow:**
1. Customer emails: "Your sales staff was rude. Very disappointed."
2. RadarMail fetches and parses email
3. AI detects intent="complaint" with sentiment=negative
4. Escalates to manager queue (not auto-response)
5. Manager notified and reads email in Radar UI
6. Manager manually composes response
7. Response sent via `POST /sendMail`

### Email Follow-Up Automation

**Flow:**
1. Email received 3 days ago, no reply
2. Radar AI detects silence and generates follow-up: "Wanted to circle back..."
3. Follow-up sent via Graph API
4. Original + follow-up logged as conversation thread

## Configuration Management

### OAuth2 Scopes

| Scope | Purpose | Risk Level |
|-------|---------|------------|
| `Mail.Read` | Read emails | Low |
| `Mail.ReadWrite` | Read + mark as read | Medium |
| `Mail.Send` | Send emails on behalf of user | High |
| `User.Read` | Read user profile | Low |

### Account Isolation

- Each dealer gets separate OAuth token
- Tokens stored encrypted in secure vault
- No cross-account email access
- Tokens refresh automatically on expiration (60 min)

### Email Filtering

- Filters applied at API level: `receivedDateTime gt`, `from`, `subject`
- Reduces data transfer and processing load
- Configurable sync frequency (every 5 min, 1 hour, etc.)

## Troubleshooting

### OAuth Token Expired

**Error:** `401 Unauthorized` on API call

**Cause:** Access token expired (60 minute TTL)

**Fix:**
1. Use refresh token to get new access token
2. Retry API call with new token
3. Implement automatic refresh before expiration

### Email Not Retrieved

**Checklist:**
1. OAuth token valid (not expired)
2. `Mail.Read` scope granted
3. Email not filtered by query (check receivedDateTime, isRead)
4. Mailbox not full or suspended
5. Email not in Junk/Spam folder (Graph API doesn't see by default)

**Investigation:**
1. Test Graph API call directly: `GET /v1.0/me` to verify auth
2. Check token scope: `Mail.Read` must be present
3. Adjust filter: remove `isRead eq false` to see all emails
4. Check mailbox health in Outlook admin

### Email Sending Failures

**Causes:**
- `Mail.Send` scope not granted
- Recipient email invalid
- Message size exceeds 25MB limit
- Mailbox storage quota exceeded

**Fix:**
1. Verify scope includes `Mail.Send`
2. Validate recipient email format
3. Compress attachments if present
4. Check mailbox storage quota in Office 365

### Attachment Processing Issues

**Causes:**
- Attachment too large (>25MB)
- File type blocked by Outlook policy
- Attachment corrupted or malformed

**Investigation:**
1. Check `size` in attachments array
2. Verify file type (PDF, image, doc acceptable; .exe blocked)
3. Test attachment download: `GET /$value` endpoint
4. Check Outlook DLP policies blocking file types

### Rate Limiting

**Limit:** 1000 requests per 60 seconds (Microsoft Graph)

**Handling:**
1. Implement exponential backoff
2. Batch requests where possible
3. Cache frequently accessed data
4. Monitor X-RateLimit-Remaining header

## Security Considerations

### Authentication & Authorization

- OAuth2 delegated permissions (not app-only)
- User consent required for mailbox access
- Tokens stored encrypted in secure vault
- Refresh tokens rotated on use
- Token revocation supported (user can disconnect)

### Data Sensitivity

- Email content may contain PII (customer names, contact info)
- Attachments may contain sensitive documents
- Email encryption at rest (Office 365 default)
- Email encryption in transit (HTTPS/TLS)

### Compliance

- GDPR: User consent for data processing
- HIPAA: Not suitable for protected health info
- FERPA: Not suitable for educational records
- SOC2: Microsoft Graph API SOC2 Type II certified

### Access Control

- Per-user OAuth tokens (not shared)
- Separate token per dealer mailbox
- Scopes limited to necessary permissions
- Audit logging of email access (optional, via Office 365)

## Related Documentation

- **Confluence:** [SPIKE — Review Outlook and RADAR Integration](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3525541894)
- **Microsoft:** [Microsoft Graph API Documentation](https://docs.microsoft.com/en-us/graph/api/overview)
- **Microsoft:** [Outlook Mail API Reference](https://docs.microsoft.com/en-us/graph/api/resources/message)
- **Repository:** [dastechnology/Radar (legacy)](https://dev.azure.com/digitalairstrike)

## References

- **Microsoft Graph Base URL:** https://graph.microsoft.com/v1.0
- **OAuth2 Authority:** https://login.microsoftonline.com/common/oauth2/v2.0
- **Outlook Scopes:** Mail.Read, Mail.ReadWrite, Mail.Send, User.Read
- **Rate Limit:** 1000 requests per 60 seconds
- **Token TTL:** 60 minutes (access token)
- **Refresh Token TTL:** 14 days (or until revoked)
