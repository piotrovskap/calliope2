---
source: DAS Confluence + Integration Explorer v5
page_id: 3282173959
title: QuickBooks API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3282173959
type: confluence-doc
pulled: 2026-06-15 (curated from Confluence + DAS Integration Explorer v5; synthesized from LotVantage billing integration)
note: covers QuickBooks invoice sync, dealership billing, accounting integration, edit sequence tracking, invoice creation and updates
---

# QuickBooks API Info

## Background

**QuickBooks API** is the **dealership accounting platform integration** that powers LotVantage's invoice synchronization and billing management. It enables automated invoice creation, tracking, and sync with dealership accounting systems for transparent dealer billing.

The integration enables LotVantage to:
- **Create invoices** in QuickBooks from dealership transactions
- **Sync billing data** between LotVantage and accounting system
- **Track invoice lifecycle** (created, sent, paid, past due)
- **Manage line items** (subscription fees, additional charges)
- **Update pricing** and billing adjustments in real-time
- **Report** billing metrics for dealership accounting

**Status:** Legacy (LotVantage), production integration

**Technology Stack:**
- **API:** QuickBooks Online API (REST) or QuickBooks Desktop SDK
- **Integration:** LotVantage billing engine
- **Deployment:** Legacy on-premise / cloud
- **Data Format:** JSON (Online) or XML (Desktop)
- **Authentication:** OAuth 2.0 (Online) or API token (Desktop)
- **Repository:** LotVantage (legacy Azure DevOps)
- **Consumers:** LotVantage billing portal, dealership accounting

## Integration Architecture

```
[LotVantage Transactions]
    ├─ Subscription charges
    ├─ Additional service fees
    └─ Adjustments/credits
    ↓
[LotVantage Billing Engine]
    ├─ Calculate invoice total
    ├─ Map to QB line items
    └─ Track edit sequence
    ↓
[QuickBooks API]
    ├─ CreateInvoice (new invoice)
    ├─ UpdateInvoice (billing changes)
    ├─ GetInvoice (retrieve status)
    └─ QueryInvoice (list invoices)
    ↓
[QuickBooks Accounting]
    ├─ Invoice created/updated
    ├─ Accounts receivable tracked
    └─ Billing audit trail
    ↓
[Dealership Accounting]
    ├─ Invoice reconciliation
    ├─ Payment collection
    └─ Financial reporting
```

## Primary Integration Points

### 1. QuickBooks API (External)

**Role:** Dealership accounting platform
- **API Endpoint:** `https://api.quickbooks.com` (Online) or SDK (Desktop)
- **Protocol:** REST JSON (Online) or SOAP/SDK (Desktop)
- **Authentication:** OAuth 2.0 (Online) or bearer token (Desktop)
- **Operations:** CreateInvoice, UpdateInvoice, GetInvoice, QueryInvoice
- **Entities:** Invoice, Customer, LineItem, Account, Class
- **Rate Limiting:** 500 requests per minute (Online)

### 2. LotVantage Billing Engine (Internal)

**Role:** Transaction-to-invoice transformation and sync
- **Repository:** LotVantage (legacy)
- **Functions:**
  - Calculate invoice totals from subscription + add-ons
  - Map LotVantage charges to QuickBooks line items
  - Track `quickbooks_edit_sequence` (concurrency control)
  - Track `quickbooks_ignored` (skip sync flag)
  - Manage invoice lifecycle (draft → sent → paid)
  - Handle billing adjustments and credits
- **Deployment:** On-premise or cloud

### 3. Dealership QuickBooks Account (External)

**Role:** Source and destination for invoice data
- **Data Source:** LotVantage transaction records
- **QuickBooks Entities:**
  - `Customer` — Dealership (parent or per-location)
  - `Invoice` — Monthly or transaction-based billing
  - `LineItem` — Subscription fee, add-on charge, credit
  - `Account` — Accounts receivable (AR)
  - `Class` — Department/cost center tagging
- **Sync Strategy:** Daily or event-driven batches

## API Reference

### Endpoint (Online)

**Base URL:**
```
https://api.quickbooks.com/v2/company/{realmID}
```

**Sandbox (Testing):**
```
https://quickbooks.api.intuit.com/v2/company/{realmID}
```

### Authentication

**Method:** OAuth 2.0

**Header:**
```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

### Key Operations

#### CreateInvoice

**Operation:** `POST /invoices`

**Request Body (JSON):**
```json
{
  "docNumber": "LV-2026-06-001",
  "txnDate": "2026-06-15",
  "dueDate": "2026-07-15",
  "customer": {
    "value": "123456789"
  },
  "customerMemo": {
    "value": "June 2026 LotVantage billing — vehicle inventory syndication"
  },
  "line": [
    {
      "detailType": "SalesItemLineDetail",
      "description": "LotVantage Vehicle Inventory Listing — Monthly subscription",
      "amount": 2500.00,
      "salesItemLineDetail": {
        "itemRef": {
          "value": "1",
          "name": "Service Revenue"
        },
        "taxCodeRef": {
          "value": "TAX"
        }
      }
    },
    {
      "detailType": "SalesItemLineDetail",
      "description": "eBay Motors Integration Fee (50 listings × $0.50)",
      "amount": 25.00,
      "salesItemLineDetail": {
        "itemRef": {
          "value": "2",
          "name": "Integration Fee"
        }
      }
    },
    {
      "detailType": "SalesItemLineDetail",
      "description": "Credit — Service outage June 1–3",
      "amount": -125.00,
      "salesItemLineDetail": {
        "itemRef": {
          "value": "3",
          "name": "Credit"
        }
      }
    }
  ],
  "txnTaxDetail": {
    "totalTax": 0
  }
}
```

**Response (Success):**
```json
{
  "invoice": {
    "id": "987654321",
    "docNumber": "LV-2026-06-001",
    "txnDate": "2026-06-15",
    "dueDate": "2026-07-15",
    "balance": 2400.00,
    "totalAmt": 2400.00,
    "status": "OPEN",
    "customer": {
      "value": "123456789"
    },
    "line": [
      {
        "id": "1",
        "lineNum": 1,
        "description": "LotVantage Vehicle Inventory Listing",
        "amount": 2500.00
      },
      {
        "id": "2",
        "lineNum": 2,
        "description": "eBay Motors Integration Fee",
        "amount": 25.00
      },
      {
        "id": "3",
        "lineNum": 3,
        "description": "Credit — Service outage",
        "amount": -125.00
      }
    ],
    "metaData": {
      "createTime": "2026-06-15T12:00:00Z",
      "updateTime": "2026-06-15T12:00:00Z"
    }
  }
}
```

#### UpdateInvoice

**Operation:** `POST /invoices`

**Request Body (JSON):**
```json
{
  "id": "987654321",
  "syncToken": "0",
  "docNumber": "LV-2026-06-001",
  "txnDate": "2026-06-15",
  "dueDate": "2026-07-15",
  "customer": {
    "value": "123456789"
  },
  "line": [
    {
      "id": "1",
      "lineNum": 1,
      "detailType": "SalesItemLineDetail",
      "description": "LotVantage Vehicle Inventory Listing — Updated",
      "amount": 2600.00,
      "salesItemLineDetail": {
        "itemRef": {
          "value": "1"
        }
      }
    }
  ]
}
```

**Response (Success):**
```json
{
  "invoice": {
    "id": "987654321",
    "syncToken": "1",
    "balance": 2500.00,
    "totalAmt": 2500.00,
    "status": "OPEN",
    "metaData": {
      "updateTime": "2026-06-15T13:30:00Z"
    }
  }
}
```

#### GetInvoice

**Operation:** `GET /invoices/{invoiceID}`

**Response (Success):**
```json
{
  "invoice": {
    "id": "987654321",
    "docNumber": "LV-2026-06-001",
    "txnDate": "2026-06-15",
    "dueDate": "2026-07-15",
    "balance": 2400.00,
    "totalAmt": 2400.00,
    "status": "OPEN",
    "metaData": {
      "createTime": "2026-06-15T12:00:00Z",
      "updateTime": "2026-06-15T13:30:00Z"
    }
  }
}
```

#### QueryInvoice (List)

**Operation:** `GET /query` (with QUERY language)

**Request:**
```
GET /query?query=select * from Invoice where docNumber = 'LV-2026-06-001'
```

**Response (Success):**
```json
{
  "queryResponse": [
    {
      "invoice": [
        {
          "id": "987654321",
          "docNumber": "LV-2026-06-001",
          "txnDate": "2026-06-15",
          "balance": 2400.00,
          "status": "OPEN"
        }
      ]
    }
  ]
}
```

## Data Flow

### Monthly Invoice Creation

1. **Period End:** End of billing month (e.g., June 30)
2. **Calculate Charges:**
   - Base subscription fee: $2,500
   - eBay integration (50 listings × $0.50): $25
   - Add-on services: (variable)
   - Subtotal before adjustments
3. **Apply Adjustments:**
   - Proration for mid-month starts
   - Service credits (outages, issues)
   - Loyalty discounts
   - Final invoice total
4. **Create Invoice:**
   - Call `CreateInvoice` with line items
   - QB returns invoice ID
   - Store QB invoice ID in LotVantage (link tracking)
5. **Sync Status:** Mark as sent in QB, notify dealership

### Invoice Update (Price Change / Credit)

1. **Event Triggered:** Dealership adjusts service level or LotVantage applies credit
2. **Calculate Delta:** Change in billing amount
3. **Retrieve Invoice:** `GetInvoice` to fetch current state
4. **Prepare Update:** Add credit line or update existing line
5. **Update Invoice:** Call `UpdateInvoice` with new line items
6. **Track Sequence:** Update `quickbooks_edit_sequence` (concurrency)
7. **Audit Trail:** Log adjustment reason in invoice memo

### Invoice Status Tracking

1. **Created:** Invoice created in QB (status: OPEN)
2. **Sent:** QB marks as sent to customer email
3. **Viewed:** Customer receives and views invoice
4. **Partially Paid:** Customer payment received (partial)
5. **Paid:** Invoice paid in full, status = CLOSED
6. **Overdue:** Due date passed, no payment
7. **Past Due:** Payment significantly overdue

## Use Cases in DAS

### Dealer Billing Reconciliation

**Flow:**
1. End of month: LotVantage calculates dealer billing
2. Base subscription: $2,500/month
3. eBay integration: 50 listings × $0.50 = $25
4. Total monthly: $2,525
5. CreateInvoice in QB with memo "June 2026 LotVantage billing"
6. QB invoice synced to dealership accounting
7. Dealership receives invoice, pays via ACH/credit card
8. Payment recorded in QB, reconciles with LotVantage

### Mid-Month Service Credit

**Flow:**
1. June 1–3: LotVantage service outage (platform down)
2. Dealership affected: no inventory listings, no leads
3. LotVantage applies credit: $125 (3 days × ~$42/day)
4. Retrieve June invoice (QB ID: 987654321)
5. UpdateInvoice: add credit line item (-$125)
6. New total: $2,400 (was $2,525)
7. QB invoice updated, dealership sees credit applied
8. Revised due date or payment schedule

### Subscription Upgrade Mid-Term

**Flow:**
1. Dealership upgrades: from basic ($2,500) to premium ($3,500)
2. Effective: June 15 (mid-month)
3. Proration: $1,000 × (15 days / 30 days) = $500
4. June invoice updated: add $500 line item
5. New total: $3,025 (was $2,525)
6. UpdateInvoice in QB with memo "Upgrade to Premium — effective June 15"
7. QB updates invoice balance, dealership notified
8. Payment adjusted accordingly

## Configuration Management

### QuickBooks Account Setup

- **Company ID (RealmID):** From QB account (OAuth step)
- **Access Token:** OAuth token (typically 1-hour expiry)
- **Refresh Token:** Long-lived token for auto-refresh
- **Customer ID:** Dealership entity ID in QB (one per dealership)
- **Chart of Accounts:** Define revenue / AR accounts
- **Line Item Classes:** Subscription, Add-on, Credit, Refund

### LotVantage Configuration

- **QB OAuth Credentials:** Stored securely (vault)
- **Dealership Mapping:** Link each dealership to QB customer ID
- **Billing Schedule:** Monthly, semi-annual, annual
- **Base Subscription Fee:** Per dealership or per-service
- **Integration Fees:** Add-on charges (eBay, Facebook, etc.)
- **Credit Policies:** What triggers automatic credits
- **Edit Sequence Tracking:** `quickbooks_edit_sequence` field (concurrency)
- **Ignore Flag:** `quickbooks_ignored` (skip sync if set)

### QB Sync Settings

- **Frequency:** Daily batch or event-driven
- **Retry Policy:** Failed syncs retry with exponential backoff
- **Audit Trail:** Log all QB API calls (for troubleshooting)
- **Reconciliation:** Monthly review of QB vs. LotVantage totals

## Troubleshooting

### CreateInvoice Fails (OAuth Token Expired)

**Error:** `401 Unauthorized`

**Fix:**
1. Refresh OAuth token (use refresh token)
2. Update stored access token in LotVantage
3. Retry CreateInvoice request

### UpdateInvoice Fails (SyncToken Mismatch)

**Error:** `409 Conflict — syncToken invalid`

**Cause:** Concurrent update (someone modified invoice in QB while LotVantage was preparing update)

**Fix:**
1. Retrieve latest invoice (`GetInvoice`)
2. Use new syncToken in update request
3. Retry UpdateInvoice

### Invoice Not Found in QB

**Checklist:**
1. Verify invoice created successfully (CreateInvoice returned ID)
2. Check QB customer ID correct for dealership
3. Query invoice by docNumber in QB (`QueryInvoice`)
4. Verify QB realm ID (company ID) matches config

**Fix:**
1. Manually create invoice in QB or LotVantage UI
2. Link QB invoice ID to LotVantage
3. Resync billing data

### Billing Totals Mismatch (QB vs. LotVantage)

**Checklist:**
1. LotVantage shows $2,525, QB shows $2,400
2. Check for unapplied credits in LotVantage
3. Check QB for partial payments or adjustments
4. Review edit sequence (concurrent updates)

**Fix:**
1. Retrieve invoice from QB (`GetInvoice`)
2. Compare line items with LotVantage
3. Identify discrepancy (missing line item, wrong amount)
4. Update QB or LotVantage accordingly

## Security Considerations

### Authentication & Authorization

- OAuth tokens stored securely (vault)
- Access token refreshed periodically (avoid expiry)
- Refresh token protected (longer TTL)
- Dealership-scoped: QB customer ID restricted to that dealership
- LotVantage backend validates all QB requests

### Data Sensitivity

- Invoice data contains dealership name, billing address
- Line item amounts (pricing sensitive)
- QB account credentials in vault (never logged)
- PCI compliance: no payment card data in QB integration

### Compliance

- **SOX:** Invoice audit trail for accounting controls
- **GAAP:** Invoice matching with revenue recognition
- **Tax Compliance:** State sales tax tracking per jurisdiction
- **Data Privacy:** Dealership billing data access restricted

## Related Documentation

- **Confluence:** [LotVantage Fields and Functions (QuickBooks fields)](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3282173959)
- **Confluence:** [LV Billing Discovery Executive Summary](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3522428937)
- **Repository:** [LotVantage (legacy)](https://dev.azure.com/digitalairstrike)
- **QuickBooks Docs:** [Invoice API Documentation](https://developer.intuit.com/app/developer/qbo/docs/api/accounting-api/invoices)

## References

- **QuickBooks Online API:** https://api.quickbooks.com/v2/company/{realmID}
- **QuickBooks Sandbox:** https://quickbooks.api.intuit.com/v2/company/{realmID}
- **OAuth Endpoints:** https://accounts.intuit.com/oauth
- **Rate Limit:** 500 requests per minute
- **Token Expiry:** 1 hour (access token), 100 days (refresh token)
- **QB QUERY Language:** SELECT from Invoice, Customer, LineItem, etc.
