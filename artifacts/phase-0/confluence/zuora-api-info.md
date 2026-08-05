---
source: DAS Confluence + Integration Explorer v5
page_id: 3522428937
title: Zuora API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3522428937
type: confluence-doc
pulled: 2026-06-15 (curated from Confluence + DAS Integration Explorer v5; synthesized from LotVantage subscription billing integration)
note: covers Zuora subscription billing, recurring revenue (MRR), subscription management, invoice generation, billing automation
---

# Zuora API Info

## Background

**Zuora API** is the **subscription billing platform** that powers LotVantage's recurring revenue management and billing automation. It manages dealership subscriptions, monthly recurring invoices (MRR), and provides a single source of truth for billing state.

The integration enables LotVantage to:
- **Create and manage subscriptions** for dealerships
- **Track monthly recurring revenue (MRR)** per dealership
- **Auto-generate invoices** based on subscription plans
- **Manage billing cycles** (monthly, quarterly, annual)
- **Apply usage-based charges** (overages, add-ons)
- **Track billing state** (active, suspended, cancelled)
- **Retrieve invoice data** for accounting and reporting

**Status:** Legacy (LotVantage), production integration

**Technology Stack:**
- **API:** Zuora REST API (v2)
- **Integration:** LotVantage billing engine
- **Deployment:** Legacy on-premise / cloud
- **Data Format:** JSON
- **Authentication:** OAuth 2.0 or API key
- **Repository:** LotVantage (legacy Azure DevOps)
- **Consumers:** LotVantage billing portal, dealership accounting

## Integration Architecture

```
[LotVantage Dealership Data]
    ├─ Subscription plan (basic, premium, enterprise)
    ├─ Service level (tier, features, limits)
    └─ Billing contact
    ↓
[LotVantage Subscription Engine]
    ├─ Create subscription in Zuora
    ├─ Map plan to Zuora product
    └─ Set billing schedule
    ↓
[Zuora Subscription Billing Platform]
    ├─ Subscription management
    ├─ Invoice generation (monthly)
    ├─ Payment processing
    └─ Revenue recognition
    ↓
[Zuora Analytics]
    ├─ MRR tracking
    ├─ Churn rate
    ├─ Lifetime value (LTV)
    └─ Billing reports
    ↓
[LotVantage Billing Dashboard]
    ├─ Subscription status
    ├─ Invoice data
    └─ Revenue reporting
```

## Primary Integration Points

### 1. Zuora API (External)

**Role:** Subscription billing and revenue management platform
- **API Endpoint:** `https://api.zuora.com/v1` (Production)
- **Protocol:** REST JSON
- **Authentication:** OAuth 2.0 or API key (bearer token)
- **Rate Limiting:** 1,000 requests per minute
- **Key Resources:** Subscriptions, Accounts, Invoices, Products, Plans, Rates
- **Webhooks:** Subscription events (created, updated, cancelled, renewed)

### 2. LotVantage Subscription Engine (Internal)

**Role:** Dealership subscription and billing orchestration
- **Repository:** LotVantage (legacy)
- **Functions:**
  - Create dealership account in Zuora
  - Create subscription from plan selection
  - Manage subscription lifecycle (active → suspended → cancelled)
  - Apply usage-based charges (overages)
  - Retrieve invoices and payment status
  - Sync subscription state back to LotVantage
  - Webhook handlers for Zuora events
- **Deployment:** On-premise or cloud

### 3. Dealership Billing System (Internal)

**Role:** Dealership subscription selection and billing management
- **Subscription Plans:** Basic, Premium, Enterprise
- **Billing Cycles:** Monthly, quarterly, annual
- **Features:** Number of vehicle listings, integrations, user seats
- **Usage Tracking:** API calls, storage, data transfers (for overages)

## API Reference

### Endpoint

**Base URL:**
```
https://api.zuora.com/v1
Sandbox: https://apisandbox.zuora.com/v1
```

### Authentication

**Method:** OAuth 2.0 or API Key

**Header (OAuth):**
```
Authorization: Bearer YOUR_ACCESS_TOKEN
```

**Header (API Key):**
```
Authorization: ApiKey YOUR_API_KEY
```

### Key Operations

#### Create Account

**Operation:** `POST /accounts`

**Request Body (JSON):**
```json
{
  "name": "Phoenix Luxury Motors",
  "account_number": "ACC-00012345",
  "currency": "USD",
  "auto_pay": true,
  "billing_document_delivery_prefs": [
    {
      "delivery_preference": "Email",
      "is_default": true
    }
  ],
  "bill_to": {
    "first_name": "John",
    "last_name": "Smith",
    "street1": "123 Main St",
    "city": "Phoenix",
    "state": "AZ",
    "postal_code": "85001",
    "country": "US",
    "email": "billing@phoenixluxury.com",
    "phone": "602-555-0100"
  },
  "sold_to": {
    "first_name": "John",
    "last_name": "Smith",
    "street1": "123 Main St",
    "city": "Phoenix",
    "state": "AZ",
    "postal_code": "85001",
    "country": "US",
    "email": "info@phoenixluxury.com",
    "phone": "602-555-0100"
  }
}
```

**Response (Success):**
```json
{
  "account_id": "4028e4994f45b3b3014f45b86a370002",
  "account_number": "ACC-00012345",
  "name": "Phoenix Luxury Motors",
  "currency": "USD",
  "status": "Active",
  "created_date": "2026-06-15T12:00:00Z",
  "updated_date": "2026-06-15T12:00:00Z"
}
```

#### Create Subscription

**Operation:** `POST /subscriptions`

**Request Body (JSON):**
```json
{
  "account_id": "4028e4994f45b3b3014f45b86a370002",
  "subscription_number": "SUB-2026-001",
  "contract_effective_date": "2026-06-15",
  "service_activation_date": "2026-06-15",
  "customer_acceptance_date": "2026-06-15",
  "term_type": "EVERGREEN",
  "initial_term_period_type": "Month",
  "initial_term": 1,
  "renewal_term_period_type": "Month",
  "renewal_term": 1,
  "auto_renew": true,
  "notes": "LotVantage Premium Plan - Billed Monthly",
  "subscribe_to_rates": [
    {
      "product_id": "2c92a0ff4f45b3b3014f45b86a370001",
      "product_name": "LotVantage Premium",
      "quantity": 1,
      "billing_cycle_day": 1
    }
  ]
}
```

**Response (Success):**
```json
{
  "subscription_id": "2c92a0ff4f45b3b3014f45b88a370005",
  "subscription_number": "SUB-2026-001",
  "account_id": "4028e4994f45b3b3014f45b86a370002",
  "status": "Active",
  "contract_effective_date": "2026-06-15",
  "service_activation_date": "2026-06-15",
  "term_end_date": "2026-07-15",
  "auto_renew": true,
  "created_date": "2026-06-15T12:00:00Z"
}
```

#### Get Subscription

**Operation:** `GET /subscriptions/{subscriptionNumber}`

**Response (Success):**
```json
{
  "subscription_id": "2c92a0ff4f45b3b3014f45b88a370005",
  "subscription_number": "SUB-2026-001",
  "account_id": "4028e4994f45b3b3014f45b86a370002",
  "status": "Active",
  "contract_effective_date": "2026-06-15",
  "term_end_date": "2026-07-15",
  "auto_renew": true,
  "term_start_date": "2026-06-15",
  "current_term_period_type": "Month",
  "term_type": "EVERGREEN",
  "rates": [
    {
      "product_name": "LotVantage Premium",
      "amount": 2500.00,
      "unit_of_measure": "Month",
      "billing_period": "Monthly"
    }
  ]
}
```

#### Update Subscription

**Operation:** `PUT /subscriptions/{subscriptionNumber}`

**Request Body (JSON):**
```json
{
  "current_term_period_type": "Month",
  "notes": "Upgraded to Enterprise plan",
  "subscribe_to_rate_updates": [
    {
      "product_id": "2c92a0ff4f45b3b3014f45b86a370003",
      "product_name": "LotVantage Enterprise",
      "quantity": 1,
      "effective_date": "2026-07-01"
    }
  ]
}
```

#### Get Invoices for Account

**Operation:** `GET /accounts/{accountId}/invoices`

**Query Parameters:**
- `limit` — Number of invoices (default: 20, max: 100)
- `offset` — Pagination offset
- `status` — Filter by status (Draft, Posted, Cancelled)
- `sort` — Sort field (invoice_date)

**Response (Success):**
```json
{
  "invoices": [
    {
      "id": "2c92a0ff4f45b3b3014f45b88a370010",
      "invoice_number": "INV-2026-000123",
      "account_id": "4028e4994f45b3b3014f45b86a370002",
      "status": "Posted",
      "invoice_date": "2026-06-01",
      "due_date": "2026-06-15",
      "amount": 2500.00,
      "balance": 2500.00,
      "invoice_items": [
        {
          "id": "2c92a0ff4f45b3b3014f45b88a370011",
          "description": "LotVantage Premium — June 2026",
          "charge_name": "Monthly Subscription Fee",
          "amount": 2500.00,
          "unit_of_measure": "Month",
          "quantity": 1
        }
      ]
    }
  ],
  "page_size": 20,
  "page": 1
}
```

#### Cancel Subscription

**Operation:** `PUT /subscriptions/{subscriptionNumber}/cancel`

**Request Body (JSON):**
```json
{
  "cancellation_policy": "EffectiveAfterLastBillingCycle",
  "cancellation_effective_date": "2026-07-15",
  "notes": "Dealership cancelled LotVantage service"
}
```

**Response (Success):**
```json
{
  "subscription_id": "2c92a0ff4f45b3b3014f45b88a370005",
  "subscription_number": "SUB-2026-001",
  "status": "Cancelled",
  "cancellation_effective_date": "2026-07-15",
  "term_end_date": "2026-07-15"
}
```

## Data Flow

### New Dealership Onboarding

1. **Dealership Signs Up:** Selects subscription plan (Basic, Premium, Enterprise)
2. **Create Zuora Account:** Call `POST /accounts` with dealer contact info
3. **Create Subscription:** Call `POST /subscriptions` with plan and billing cycle
4. **Subscription Activated:** Zuora status = "Active", billing begins
5. **First Invoice:** Generated at billing cycle start (monthly)
6. **Payment:** Auto-charged if payment method on file

### Monthly Billing Cycle

1. **Cycle Start:** First of month (configurable)
2. **Invoice Generation:** Zuora auto-generates invoice for subscription charges
3. **Invoice Posted:** Status = "Posted", visible to dealership
4. **Payment Due:** Dealership has 15 days to pay (configurable)
5. **Payment Processing:** Payment collected (auto-pay if enabled)
6. **Renewal:** Subscription renews for next month (auto_renew = true)

### Subscription Upgrade/Downgrade

1. **Dealership Upgrades:** From Premium ($2,500) to Enterprise ($5,000)
2. **Effective Date:** Change effective next billing cycle or immediately
3. **Update Subscription:** Call `PUT /subscriptions` with new product
4. **Pro-rata Charge:** If mid-cycle, add pro-rata amount to next invoice
5. **Invoice Updated:** New invoice reflects Enterprise rate
6. **Next Billing:** Enterprise rate applied to all future invoices

### Subscription Cancellation

1. **Dealership Cancels:** Requests cancellation
2. **Cancellation Policy:** EffectiveAfterLastBillingCycle (completes current month)
3. **Call Cancel:** `PUT /subscriptions/.../cancel` with effective date
4. **Subscription Status:** Changed to "Cancelled"
5. **Final Invoice:** Any remaining balance invoiced
6. **Churn Tracking:** Recorded in analytics (MRR impact)

## Use Cases in DAS

### Multi-Dealership Billing Platform

**Flow:**
1. 50 dealerships on LotVantage platform
2. Plans: Basic ($1,000), Premium ($2,500), Enterprise ($5,000)
3. Average: 35 Premium, 10 Enterprise, 5 Basic
4. Monthly MRR: (35 × $2,500) + (10 × $5,000) + (5 × $1,000) = $137,500
5. Zuora tracks MRR, churn, expansion revenue
6. Dashboards show: new ARR, churn rate, LTV

### Dealership Upgrade Mid-Cycle

**Flow:**
1. Premium dealership ($2,500) upgrades to Enterprise ($5,000)
2. Upgrade effective immediately (June 15, mid-month)
3. Pro-rata: ($5,000 - $2,500) × (16 days / 30 days) = $1,333
4. Next invoice (July 1): $5,000 (Enterprise rate) + $1,333 (June upgrade) = $6,333
5. Dealership sees upgrade reflected in next bill

### Dealership Churn / Cancellation

**Flow:**
1. Dealership cancels subscription (low usage, cost concerns)
2. Cancellation effective: end of June (EffectiveAfterLastBillingCycle)
3. Final invoice: any remaining balance
4. Churn recorded: MRR impact = -$2,500
5. Zuora analytics: churn rate updated, LTV recalculated

## Configuration Management

### Zuora Account Setup

- **API Key / OAuth Token:** Stored securely (vault)
- **Tenant:** Zuora production tenant
- **Currency:** USD (or per-region)
- **Timezone:** America/Phoenix (for billing cycles)
- **Products:** LotVantage Basic, Premium, Enterprise (one per plan)
- **Rate Plans:** Monthly, quarterly, annual (one per billing cycle)
- **Payment Methods:** ACH, credit card (auto-pay enabled)

### LotVantage Configuration

- **Zuora Credentials:** OAuth token or API key in vault
- **Product Mapping:** DAS subscription plans → Zuora products
- **Plan Mapping:** Monthly / quarterly / annual → Zuora rate plans
- **Billing Cycle Day:** First of month (day 1)
- **Auto-Pay:** Enabled (auto-charge payment method)
- **Invoice Delivery:** Email to billing contact
- **Webhook Handlers:** Listen for Zuora events (subscription.updated, invoice.created, etc.)

### Billing Parameters

- **Basic Plan:** $1,000/month, 20 listings limit
- **Premium Plan:** $2,500/month, 100 listings, all integrations
- **Enterprise Plan:** $5,000/month, unlimited listings, priority support
- **Usage Overages:** $0.50 per extra listing per month (if over limit)

## Troubleshooting

### Create Account Fails (Invalid Address)

**Error:** `400 Bad Request — invalid_address`

**Fix:**
1. Validate address format (street, city, state, zip)
2. Use USPS address validation if available
3. Retry with corrected address

### Create Subscription Fails (Product Not Found)

**Error:** `404 Not Found — product_id not valid`

**Cause:** Product ID doesn't exist in Zuora

**Fix:**
1. Verify product exists in Zuora tenant
2. Check product is active (not archived)
3. Use correct product ID from Zuora

### Subscription Status Not Syncing

**Checklist:**
1. Webhook handler configured in Zuora
2. LotVantage listening for subscription.updated events
3. Check logs for missed webhook calls
4. Manually retrieve subscription: `GET /subscriptions/{subNumber}`

**Fix:**
1. Re-subscribe to webhooks in Zuora dashboard
2. Manually fetch subscription state
3. Sync to LotVantage database

### Invoice Not Generated at Billing Cycle

**Checklist:**
1. Subscription status = "Active"
2. Billing cycle day has passed
3. Auto-generate invoices enabled in Zuora
4. Payment method on file (if auto-pay enabled)

**Fix:**
1. Manually trigger invoice generation in Zuora
2. Check subscription renewal dates
3. Verify billing cycle configuration

### Payment Declined (Auto-Pay Failed)

**Error:** Payment method declined on auto-charge

**Fix:**
1. Notify dealership: update payment method
2. Manually charge once payment method updated
3. Email invoice with payment link
4. Offer alternate payment methods (ACH, wire)

## Security Considerations

### Authentication & Authorization

- API tokens stored securely (vault)
- OAuth refresh tokens managed (auto-refresh)
- Dealership-scoped: Can only access own subscription data
- LotVantage backend validates all Zuora requests

### Data Sensitivity

- Subscription data contains dealership name, contact info
- Invoice amounts (pricing sensitive)
- Payment method info (PCI compliance required)
- Zuora credentials in vault (never logged or exposed)

### Compliance

- **PCI DSS:** Payment processing (Zuora handles, not LotVantage)
- **GAAP:** Revenue recognition (Zuora calculates, SaaS ASC 606)
- **Tax Compliance:** Sales tax tracking (jurisdiction-based)
- **Data Privacy:** Dealership billing data access restricted

## Related Documentation

- **Confluence:** [LV Billing Discovery Executive Summary](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3522428937)
- **Confluence:** [3rd Party Services and App Integrations](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872344590)
- **Repository:** [LotVantage (legacy)](https://dev.azure.com/digitalairstrike)
- **Zuora Docs:** [REST API Documentation](https://www.zuora.com/developer/api-reference/)

## References

- **Zuora API:** https://api.zuora.com/v1
- **Zuora Sandbox:** https://apisandbox.zuora.com/v1
- **Rate Limit:** 1,000 requests per minute
- **OAuth Endpoint:** https://oauth.zuora.com/oauth/token
- **Webhook Events:** subscription.created, subscription.updated, subscription.cancelled, invoice.created, invoice.payment_succeeded
