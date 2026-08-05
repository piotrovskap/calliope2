---
source: DAS Confluence
page_id: 3482320904
title: Mautic Custom Events API
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3482320904
type: confluence-doc
repulled: 2026-06-09
---

# Mautic Custom Events API – Developer Documentation

This feature implements a new Custom Events Bundle for Mautic that allows external systems to send custom events actions via API, which can be used to trigger campaigns and manage lead points. The bundle provides a secure API endpoint that integrates with Mautic's native OAuth2 authentication system.

**Key Features:**

- Custom API endpoint: `POST /api/custom-events/events`

- OAuth2 authentication using Mautic's built-in API security

- Points management: Automatically add/subtract points from leads

- Campaign integration: Custom events can trigger campaign actions

- Lead/Company lookup: Find leads by email and common client ID

- Event logging: Track all custom events with points change logs

------------------------------------------------------------------------

## 1. Creating Client ID and Client Secret in Mautic

To authenticate via OAuth2, you must first create API credentials in the Mautic dashboard.

1.  Log in to **Mautic Admin**.

2.  <span class="inline-comment-marker" ref="6bb72231-6b9e-4882-ae91-9b3fae32b43e">Go to </span>**Settings** (gear icon, top right) → **API Credentials**.

3.  Click **+ New** in the top right corner.

4.  Fill in the details:

    - **Name**: e.g., `Custom Events API`

    - **Redirect URI**: For client credentials, you can enter your Mautic base URL (not used here).

    - **Authorization Protocol**: Select **OAuth 2**.

5.  Save the credentials.

6.  Copy the generated **Client ID** and **Client Secret** → use them in your environment variables.

------------------------------------------------------------------------

## 2. Environment Variables

Before starting, define your environment variables.

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
export MAUTIC_URL="MAUTIC_PRODUCTION_URL"
export CLIENT_ID="MY_CLIENT_ID"
export CLIENT_SECRET="MY_CLIENT_SECRET"
export COMPANY_COMMON_CLIENT_ID="COMPANY_COMMON_CLIENT_ID"
```

</div>

</div>

------------------------------------------------------------------------

## 3. Authentication – Get Access Token

Request a **Bearer Token** using the credentials:

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
curl --location "$MAUTIC_URL/oauth/v2/token" \
  --header "Content-Type: application/x-www-form-urlencoded" \
  --data-urlencode "grant_type=client_credentials" \
  --data-urlencode "client_id=$CLIENT_ID" \
  --data-urlencode "client_secret=$CLIENT_SECRET"
```

</div>

</div>

**Response Example**:

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
{
  "access_token": "YOUR_ACCESS_TOKEN",
  "expires_in": 3600,
  "token_type": "bearer"
}
```

</div>

</div>

The `access_token` will be required for sending events.

------------------------------------------------------------------------

## 4. Send a Custom Event

Use the token to send a custom event to Mautic:

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
curl --location "$MAUTIC_URL/api/custom-events/events" \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  --data-raw '{
    "email": "CUSTOMER_EMAIL",
    "common_client_id": "'"$COMPANY_COMMON_CLIENT_ID"'",
    "event_name": "EVENT_NAME"
  }'
```

</div>

</div>

### Parameters

- **email** *(string, required)*: The customer’s email (must already exist in Mautic).

- **common_client_id** *(string, required)*: Identifier for the company.

- **event_name** *(string, required)*: The name of the custom event as configured in Mautic.

------------------------------------------------------------------------

## 5. Postman Collection (Ready-to-Import)

Here’s a Postman Collection JSON with **automatic token handling** (no manual copy/paste required).

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
{
  "info": {
    "name": "Mautic Custom Events API",
    "_postman_id": "2a6f8a3c-45b3-47b1-8c11-abcdef123456",
    "description": "Postman collection for authenticating and sending events to the Mautic Custom Events API with automatic token handling.",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Get Access Token",
      "event": [
        {
          "listen": "test",
          "script": {
            "exec": [
              "let jsonData = pm.response.json();",
              "if (jsonData.access_token) {",
              "    pm.collectionVariables.set(\"access_token\", jsonData.access_token);",
              "    console.log(\"Access token set: \" + jsonData.access_token);",
              "} else {",
              "    console.warn(\"No access token found in response\");",
              "}"
            ],
            "type": "text/javascript"
          }
        }
      ],
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/x-www-form-urlencoded"
          }
        ],
        "body": {
          "mode": "urlencoded",
          "urlencoded": [
            {
              "key": "grant_type",
              "value": "client_credentials",
              "type": "text"
            },
            {
              "key": "client_id",
              "value": "{{client_id}}",
              "type": "text"
            },
            {
              "key": "client_secret",
              "value": "{{client_secret}}",
              "type": "text"
            }
          ]
        },
        "url": {
          "raw": "{{mautic_url}}/oauth/v2/token",
          "host": ["{{mautic_url}}"],
          "path": ["oauth", "v2", "token"]
        }
      },
      "response": []
    },
    {
      "name": "Send Custom Event",
      "event": [
        {
          "listen": "prerequest",
          "script": {
            "exec": [
              "if (!pm.collectionVariables.get(\"access_token\")) {",
              "    pm.sendRequest({",
              "        url: pm.collectionVariables.get(\"mautic_url\") + \"/oauth/v2/token\",",
              "        method: 'POST',",
              "        header: { 'Content-Type': 'application/x-www-form-urlencoded' },",
              "        body: {",
              "            mode: 'urlencoded',",
              "            urlencoded: [",
              "                { key: 'grant_type', value: 'client_credentials' },",
              "                { key: 'client_id', value: pm.collectionVariables.get(\"client_id\") },",
              "                { key: 'client_secret', value: pm.collectionVariables.get(\"client_secret\") }",
              "            ]",
              "        }",
              "    }, function (err, res) {",
              "        if (!err && res.json().access_token) {",
              "            pm.collectionVariables.set(\"access_token\", res.json().access_token);",
              "            console.log(\"New access token automatically set\");",
              "        } else {",
              "            console.error(\"Failed to auto-refresh token\", err || res.text());",
              "        }",
              "    });",
              "}"
            ],
            "type": "text/javascript"
          }
        }
      ],
      "request": {
        "method": "POST",
        "header": [
          {
            "key": "Content-Type",
            "value": "application/json"
          },
          {
            "key": "Authorization",
            "value": "Bearer {{access_token}}"
          }
        ],
        "body": {
          "mode": "raw",
          "raw": "{\n    \"email\": \"{{customer_email}}\",\n    \"common_client_id\": \"{{company_common_client_id}}\",\n    \"event_name\": \"{{event_name}}\"\n}"
        },
        "url": {
          "raw": "{{mautic_url}}/api/custom-events/events",
          "host": ["{{mautic_url}}"],
          "path": ["api", "custom-events", "events"]
        }
      },
      "response": []
    }
  ],
  "variable": [
    {
      "key": "mautic_url",
      "value": "http://devadmin.3birdsmarketing.com:8080"
    },
    {
      "key": "client_id",
      "value": "MY_CLIENT_ID"
    },
    {
      "key": "client_secret",
      "value": "MY_CLIENT_SECRET"
    },
    {
      "key": "access_token",
      "value": ""
    },
    {
      "key": "customer_email",
      "value": "CUSTOMER_EMAIL"
    },
    {
      "key": "company_common_client_id",
      "value": "COMPANY_COMMON_CLIENT_ID"
    },
    {
      "key": "event_name",
      "value": "EVENT_NAME"
    }
  ]
}
```

</div>

</div>

------------------------------------------------------------------------

## 6. How to Use in Postman

1.  Open **Postman**.

2.  Click **Import** → **Raw Text** → paste the JSON above.

3.  Open the collection and go to **Variables**. Update the values for:

    - `mautic_url`

    - `client_id`

    - `client_secret`

    - `company_common_client_id`

    - `customer_email`

    - `event_name`

4.  Run **Send Custom Event** directly — if the token is missing or expired, the Pre-request Script will **fetch a new one automatically**.
