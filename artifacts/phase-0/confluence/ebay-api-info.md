---
source: DAS Confluence + Integration Explorer v5
page_id: 2129526790
title: eBay API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2129526790
type: confluence-doc
pulled: 2026-06-15 (curated from Confluence + DAS Integration Explorer v5; synthesized from LotVantage vehicle listing integration)
note: covers eBay Trading API, vehicle inventory syndication, listing creation, order management, fulfillment integration
---

# eBay API Info

## Background

**eBay Trading API** is the **vehicle inventory marketplace platform** that powers LotVantage's dealer inventory syndication. It enables dealerships to list vehicle inventory on eBay.com Motors, reaching millions of buyers searching for vehicles.

The integration enables LotVantage to:
- **Create vehicle listings** on eBay Motors with dealership inventory
- **Sync pricing and availability** with dealership systems
- **Manage orders** from eBay buyers
- **Process fulfillment** and delivery coordination
- **Track seller performance** (feedback, reputation)
- **Apply seller fees** and billing to dealership accounts

**Status:** Legacy (LotVantage), production integration

**Technology Stack:**
- **API:** eBay Trading API (XML/SOAP-based)
- **Integration:** LotVantage syndication engine
- **Deployment:** Legacy on-premise / cloud
- **Listing Format:** XML vehicle data (make, model, year, price, photos)
- **Authentication:** Token-based (seller authorization)
- **Repository:** LotVantage (legacy Azure DevOps)
- **Consumers:** LotVantage portal, dealer inventory management

## Integration Architecture

```
[Dealership Inventory]
    ├─ Vehicle data (make, model, year, VIN)
    ├─ Pricing (MSRP, dealer discount)
    └─ Media (photos, videos)
    ↓
[LotVantage Engine]
    ├─ Mapping to eBay schema
    ├─ Category assignment (Motors > Vehicles)
    └─ Business rules (price floors, blacklist filters)
    ↓
[eBay Trading API]
    ├─ AddItem (create listing)
    ├─ ReviseItem (update existing)
    ├─ EndItem (delist)
    └─ GetOrder (retrieve order)
    ↓
[eBay Motors Marketplace]
    ├─ Vehicle listing live
    ├─ Buyer inquiry
    └─ Order placed
    ↓
[LotVantage Order Management]
    ├─ Order notification
    ├─ Lead routing
    └─ Fulfillment tracking
```

## Primary Integration Points

### 1. eBay Trading API (External)

**Role:** Vehicle marketplace platform
- **API Endpoint:** `https://api.ebay.com/wsapi` (Production)
- **Protocol:** XML/SOAP
- **Authentication:** Token-based (seller authorization token)
- **Categories:** Motors > Vehicles, Parts & Accessories
- **Listing Lifetime:** 7, 14, or 30 days (dealer configurable)
- **Fees:** eBay insertion fee + final value fee (on sale)

### 2. LotVantage Syndication Engine (Internal)

**Role:** Vehicle data transformation and listing management
- **Repository:** LotVantage (legacy)
- **Functions:**
  - Map dealership inventory to eBay schema
  - Auto-generate item descriptions from vehicle data
  - Calculate eBay category from vehicle type
  - Handle image/video attachment
  - Manage listing lifecycle (create, update, end)
  - Process orders and routing to dealership
- **Deployment:** On-premise or cloud

### 3. Dealership Inventory System (Internal)

**Role:** Source of vehicle inventory data
- **Data Source:** DMS (dealer management system)
- **Fields:** VIN, make, model, year, price, mileage, condition, photos
- **Sync Frequency:** Real-time or batch (daily)
- **Constraints:** Blacklist filters (price floors, sold vehicles)

## API Reference

### Endpoint

**Base URL:**
```
https://api.ebay.com/wsapi
```

**Sandbox (Testing):**
```
https://api.sandbox.ebay.com/wsapi
```

### Authentication

**Method:** Token-based (OAuth or seller authorization token)

**Header:**
```xml
<RequesterCredentials>
  <eBayAuthToken>YOUR_EBAY_TOKEN</eBayAuthToken>
</RequesterCredentials>
```

### Key Operations

#### AddItem (Create Listing)

**Operation:** `AddItem`

**Request (SOAP XML):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<AddItemRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials>
    <eBayAuthToken>YOUR_TOKEN</eBayAuthToken>
  </RequesterCredentials>
  <Item>
    <Title>2024 Honda CR-V EX — Low Mileage, Excellent Condition</Title>
    <Description>
      Well-maintained Honda CR-V with regular service. Automatic transmission,
      AWD, Bluetooth, backup camera, power windows/locks. Clean title.
    </Description>
    <PrimaryCategory>
      <CategoryID>6001</CategoryID> <!-- Vehicles > Cars & Trucks -->
    </PrimaryCategory>
    <StartPrice>24995.00</StartPrice>
    <ListingType>FixedPriceListing</ListingType>
    <ListingDuration>Days_30</ListingDuration>
    <Quantity>1</Quantity>
    <Country>US</Country>
    <Currency>USD</Currency>
    <Location>Phoenix, AZ 85014</Location>
    <ItemSpecifics>
      <NameValueList>
        <Name>Make</Name>
        <Value>Honda</Value>
      </NameValueList>
      <NameValueList>
        <Name>Model</Name>
        <Value>CR-V</Value>
      </NameValueList>
      <NameValueList>
        <Name>Year</Name>
        <Value>2024</Value>
      </NameValueList>
      <NameValueList>
        <Name>Mileage</Name>
        <Value>8500</Value>
      </NameValueList>
      <NameValueList>
        <Name>VIN</Name>
        <Value>2HRCF5H37LH123456</Value>
      </NameValueList>
      <NameValueList>
        <Name>Transmission</Name>
        <Value>Automatic</Value>
      </NameValueList>
    </ItemSpecifics>
    <PictureDetails>
      <PictureURL>https://dealer.example.com/images/car-001-1.jpg</PictureURL>
      <PictureURL>https://dealer.example.com/images/car-001-2.jpg</PictureURL>
    </PictureDetails>
    <ShippingDetails>
      <ShippingType>NotSpecified</ShippingType>
    </ShippingDetails>
  </Item>
</AddItemRequest>
```

**Response (Success):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<AddItemResponse xmlns="urn:ebay:apis:eBLBaseComponents">
  <Ack>Success</Ack>
  <ItemID>234567890123</ItemID>
  <StartTime>2026-06-15T12:00:00.000Z</StartTime>
  <EndTime>2026-07-15T12:00:00.000Z</EndTime>
  <ListingDuration>Days_30</ListingDuration>
  <Fees>
    <Fee>
      <Name>InsertionFee</Name>
      <Fee>2.95</Fee>
    </Fee>
  </Fees>
</AddItemResponse>
```

#### ReviseItem (Update Listing)

**Operation:** `ReviseItem`

**Request (SOAP XML):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ReviseItemRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials>
    <eBayAuthToken>YOUR_TOKEN</eBayAuthToken>
  </RequesterCredentials>
  <Item>
    <ItemID>234567890123</ItemID>
    <Title>2024 Honda CR-V EX — Updated Listing</Title>
    <StartPrice>23995.00</StartPrice> <!-- Price reduction -->
  </Item>
</ReviseItemRequest>
```

#### EndItem (Delist)

**Operation:** `EndItem`

**Request (SOAP XML):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<EndItemRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials>
    <eBayAuthToken>YOUR_TOKEN</eBayAuthToken>
  </RequesterCredentials>
  <ItemID>234567890123</ItemID>
  <EndingReason>Sold</EndingReason>
</EndItemRequest>
```

#### GetOrder (Retrieve Order)

**Operation:** `GetOrder`

**Request (SOAP XML):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<GetOrderRequest xmlns="urn:ebay:apis:eBLBaseComponents">
  <RequesterCredentials>
    <eBayAuthToken>YOUR_TOKEN</eBayAuthToken>
  </RequesterCredentials>
  <OrderID>123456789</OrderID>
</GetOrderRequest>
```

**Response (Success):**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<GetOrderResponse xmlns="urn:ebay:apis:eBLBaseComponents">
  <Order>
    <OrderID>123456789</OrderID>
    <OrderStatus>Completed</OrderStatus>
    <OrderTime>2026-06-15T14:30:00.000Z</OrderTime>
    <ShippingAddress>
      <Name>John Buyer</Name>
      <Street1>456 Main St</Street1>
      <City>Denver</City>
      <StateOrProvince>CO</StateOrProvince>
      <PostalCode>80202</PostalCode>
      <Country>US</Country>
    </ShippingAddress>
    <TransactionArray>
      <Transaction>
        <TransactionID>987654321</TransactionID>
        <Item>
          <ItemID>234567890123</ItemID>
          <Title>2024 Honda CR-V EX</Title>
        </Item>
        <Buyer>
          <UserID>buyer_username</UserID>
        </Buyer>
        <AmountPaid>23995.00</AmountPaid>
        <Status>Complete</Status>
      </Transaction>
    </TransactionArray>
  </Order>
</GetOrderResponse>
```

## Data Flow

### Vehicle Listing Creation

1. **Inventory Input:** Dealership uploads vehicle (DMS or manual entry)
2. **Data Mapping:** LotVantage maps vehicle data to eBay schema
3. **Image Processing:** Download/resize dealer photos for eBay
4. **Category Assignment:** Auto-select eBay Motors category
5. **Business Rules:** Apply price floors, blacklist filters
6. **API Call:** `AddItem` request to eBay Trading API
7. **Listing Live:** Vehicle visible on eBay Motors
8. **Fee Applied:** eBay charges insertion fee to account

### Order Received

1. **eBay Order:** Buyer purchases vehicle on eBay
2. **Notification:** eBay sends order confirmation
3. **API Fetch:** `GetOrder` retrieves buyer details
4. **Lead Creation:** LotVantage creates lead in dealer CRM
5. **Routing:** Route to sales team (phone, email, SMS)
6. **Fulfillment:** Sales team contacts buyer, negotiates delivery
7. **Delivery:** Vehicle shipped or local pickup arranged
8. **Feedback:** Post-sale feedback on eBay

### Listing Update

1. **Price Change:** Dealer updates vehicle price
2. **Inventory Sync:** LotVantage detects change
3. **API Call:** `ReviseItem` updates eBay listing
4. **Live Update:** eBay pricing updated within minutes
5. **Buyer Notification:** Saved searches may notify interested buyers

### Listing Ended

1. **Vehicle Sold:** Dealership marks as sold in DMS
2. **Inventory Sync:** LotVantage detects status
3. **API Call:** `EndItem` (reason: Sold) removes listing
4. **Delisted:** Vehicle no longer visible on eBay
5. **Fee Final:** Final value fee applied to account

## Use Cases in DAS

### Multi-Dealer Inventory Syndication

**Flow:**
1. 50 dealerships use LotVantage
2. Each dealership has 500–2,000 vehicles in inventory
3. Real-time inventory sync to eBay
4. Total: 50,000 vehicles live on eBay at any time
5. Monthly listing fees: ~$150K (insertion + final value)
6. Lead volume: 5,000–10,000 inquiries/month from eBay buyers

### Vehicle Price Optimization

**Flow:**
1. Dealer adjusts inventory pricing strategy
2. LotVantage automatically revises eBay listings
3. Market comparison: underpriced listings sell faster
4. Overpriced listings can be adjusted within hours
5. Real-time repricing improves sell-through rate

### Order Management & Lead Routing

**Flow:**
1. Buyer purchases vehicle on eBay ($25,000 Honda CR-V)
2. eBay notifies LotVantage of order
3. LotVantage retrieves buyer contact info (name, phone, address)
4. Lead created in dealer CRM
5. Sales team receives notification (SMS, email, CRM alert)
6. Sales rep contacts buyer to arrange delivery
7. Vehicle shipped or picked up
8. Post-sale feedback posted on eBay

## Configuration Management

### eBay Account Setup

- **Seller Account:** Registered on eBay.com
- **Authorization Token:** Long-lived token from seller auth
- **API Access:** Enable Trading API in seller account settings
- **Sandbox:** Test account for development
- **Seller Limits:** Monthly item limit, price caps
- **Fees:** Insertion fee per listing, final value fee on sale

### LotVantage Configuration

- **eBay Seller Token:** Stored securely (vault/env var)
- **Listing Duration:** Default 7/14/30 days (dealer choice)
- **Category Mapping:** Vehicle type → eBay category ID
- **Price Floors:** Minimum price per vehicle type
- **Blacklist Filters:** Exclude vehicles below mileage threshold
- **Image Limits:** Max 15 photos per listing
- **Sync Frequency:** Real-time or batch (daily)

### Dealer Constraints

- **Monthly Fee:** eBay seller subscription
- **Insertion Fee:** $2.95–$5.95 per listing
- **Final Value Fee:** 12.9% of sale price (vehicles)
- **Listing Limits:** 500–10,000 active listings (plan-dependent)

## Troubleshooting

### AddItem Fails (Token Expired)

**Error:** `InvalidUserToken`

**Fix:**
1. Regenerate token in eBay seller account
2. Update LotVantage configuration with new token
3. Retry AddItem request

### Listing Not Appearing

**Checklist:**
1. Verify AddItem request succeeded (ItemID returned)
2. Check eBay seller limits (may be at max listings)
3. Verify category is valid for Motors
4. Check listing duration (may have already ended)

**Fix:**
1. Query eBay to confirm listing exists
2. Adjust seller limits or end old listings
3. Verify category mapping in LotVantage config

### Order Not Received

**Checklist:**
1. Confirm order created on eBay (search order by ItemID)
2. Verify order notification sent to LotVantage (check logs)
3. Check API credentials for GetOrder request

**Fix:**
1. Manually retrieve order via `GetOrder` API
2. Create lead manually in dealer CRM
3. Contact buyer directly if no contact info

### Price Not Updating

**Checklist:**
1. Dealer updated price in DMS
2. LotVantage picked up the change (check sync logs)
3. ReviseItem request succeeded
4. eBay listing cache refreshed

**Fix:**
1. Manually revise listing via eBay seller center
2. Force resync in LotVantage (if supported)
3. Wait 5–10 minutes for eBay cache update

## Security Considerations

### Authentication & Authorization

- eBay token stored securely (vault, not hardcoded)
- Token rotated per eBay guidelines
- Seller account restricted to vehicle listings only
- LotVantage backend validates all API requests

### Data Sensitivity

- Vehicle VINs, pricing, photos transmitted to eBay
- Buyer PII (name, address, phone) retrieved from eBay
- No credit card data in API (eBay handles payments)
- Dealership account linked to seller account

### Compliance

- **eBay ToS:** Seller must comply with vehicle listing rules
- **Fraud:** eBay monitors for scams, false listings
- **Buyer Protection:** eBay guarantees delivery, refunds
- **Feedback:** Reputation system holds sellers accountable

## Related Documentation

- **Confluence:** [LotVantage Overview](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2129526790)
- **Confluence:** [Craigslist and eBay Limitations](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2499149825)
- **Confluence:** [LV Billing](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/1585021105)
- **Repository:** [LotVantage (legacy)](https://dev.azure.com/digitalairstrike)
- **eBay Docs:** [Trading API Documentation](https://developer.ebay.com/docs/trading/basics/call-structure/)

## References

- **eBay Trading API:** https://api.ebay.com/wsapi
- **eBay Sandbox:** https://api.sandbox.ebay.com/wsapi
- **Seller Center:** https://sellercentury.ebay.com
- **Category ID:** Motors > Vehicles = 6001
- **Token Scope:** AddItem, ReviseItem, EndItem, GetOrder
- **Fee Model:** Insertion + Final Value (12.9% on sale)
