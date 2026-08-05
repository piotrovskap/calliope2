---
source: DAS Confluence + Integration Explorer v5
page_id: 3141435473
title: MaxMind GeoIP2 API Info
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141435473
type: confluence-doc
pulled: 2026-06-14 (curated from Confluence + DAS Integration Explorer v5; synthesized from Mautic/CDXP GeoIP2 integration and Do Not Sell compliance)
note: covers IP geolocation lookup, location data enrichment, Do Not Sell list compliance, Mautic integration, CCPA compliance purge
---

# MaxMind GeoIP2 API Info

## Background

**MaxMind GeoIP2** is the **geolocation API** that powers IP-based location enrichment in CDXP-Mautic. It enables the system to:

- **Geolocate contacts** based on their IP address at contact creation
- **Enrich contact profiles** with location data (city, region, country, latitude/longitude)
- **Support compliance workflows** via MaxMind Do Not Sell list (CCPA)
- **Purge contacts** matching restricted geographies or compliance lists

The integration is critical for CDXP campaign targeting, regional compliance, and contact data quality.

**Technology Stack:**
- **API:** MaxMind GeoIP2 v2.1
- **Database:** GeoIP2 City + Do Not Sell list
- **Integration:** CDXP-Mautic platform
- **Language:** PHP
- **Hosting:** Mautic instance (self-hosted or cloud)
- **Repository:** 3birdsmarketing/CDXP-Mautic
- **Consumers:** Mautic contact creation, CDXP compliance workflows

## Integration Architecture

```
[Web Form / Lead Submission]
    ↓ (visitor IP captured)
[CDXP-Mautic Contact Creation]
    ↓ (extract IP from request)
[MaxMind GeoIP2 API Lookup]
    ↓ (POST /geoip/v2.1/city/{ip})
[Location Data Response]
    ↓ (city, region, country, lat/lon, ISP)
[Mautic Contact Profile]
    ↓ (fields: location, country, region, coordinates)
[Campaign Targeting / Segmentation]
    ↓
[Do Not Sell List Check]
    ↓ (weekly compliance purge)
[Mautic Custom Command]
    ↓ (DELETE contacts matching DNS list IPs)
```

## Primary Integration Points

### 1. MaxMind GeoIP2 API (External)

**Role:** IP geolocation data source
- **API Endpoint:** `https://geoip.maxmind.com/geoip/v2.1/city`
- **Authentication:** Account ID + License Key (Basic Auth)
- **Database:** City-level geolocation data (not just country)
- **Usage:** Lookup IP on contact creation to enrich profile

### 2. MaxMind Do Not Sell List (External)

**Role:** CCPA compliance list
- **Format:** Downloadable CSV of restricted IPs/ranges
- **Update Frequency:** Weekly updates
- **Usage:** Weekly purge job removes contacts matching list

### 3. CDXP-Mautic (Internal)

**Role:** Contact management + compliance workflows
- **Integration:** Mautic contact plugin + custom command
- **Trigger:** Contact creation → IP lookup
- **Compliance:** Weekly cron job → IP purge
- **Fields Updated:** `mautic_country`, `mautic_region`, `mautic_city`, `mautic_latitude`, `mautic_longitude`

## API Reference

### Base URL

```
https://geoip.maxmind.com/geoip/v2.1
```

### Authentication

**Method:** HTTP Basic Authentication

**Credentials:**
- Username: MaxMind Account ID
- Password: License Key

**Example:**
```bash
curl -u "YOUR_ACCOUNT_ID:YOUR_LICENSE_KEY" \
  https://geoip.maxmind.com/geoip/v2.1/city/203.0.113.45
```

### Key Endpoints

#### GET City Lookup (IP Geolocation)

**Endpoint:** `GET /geoip/v2.1/city/{ip}`

**Path Parameters:**
- `ip` (required) — IPv4 or IPv6 address to lookup

**Response:** `200 OK`
```json
{
  "city": {
    "geoname_id": 5379538,
    "names": {
      "de": "Los Angeles",
      "en": "Los Angeles",
      "es": "Los Ángeles",
      "fr": "Los Angeles",
      "ja": "ロサンゼルス",
      "pt-BR": "Los Angeles",
      "ru": "Лос-Анджелес",
      "zh-CN": "洛杉矶"
    }
  },
  "continent": {
    "code": "NA",
    "geoname_id": 6255149,
    "names": {
      "de": "Nordamerika",
      "en": "North America",
      "es": "Norteamérica",
      "fr": "Amérique du Nord",
      "ja": "北米",
      "pt-BR": "América do Norte",
      "ru": "Северная Америка",
      "zh-CN": "北美洲"
    }
  },
  "country": {
    "geoname_id": 6252001,
    "is_in_european_union": false,
    "iso_code": "US",
    "names": {
      "de": "Vereinigte Staaten",
      "en": "United States",
      "es": "Estados Unidos",
      "fr": "États-Unis",
      "ja": "アメリカ合衆国",
      "pt-BR": "Estados Unidos",
      "ru": "Соединённые Штаты Америки",
      "zh-CN": "美国"
    }
  },
  "location": {
    "accuracy_radius": 20,
    "latitude": 34.0522,
    "longitude": -118.2437,
    "metro_code": 803,
    "time_zone": "America/Los_Angeles"
  },
  "postal": {
    "code": "90001"
  },
  "registered_country": {
    "geoname_id": 6252001,
    "is_in_european_union": false,
    "iso_code": "US",
    "names": {
      "en": "United States"
    }
  },
  "subdivisions": [
    {
      "geoname_id": 5332921,
      "iso_code": "CA",
      "names": {
        "de": "Kalifornien",
        "en": "California",
        "es": "California",
        "fr": "Californie",
        "ja": "カリフォルニア州",
        "pt-BR": "Califórnia",
        "ru": "Калифорния",
        "zh-CN": "加州"
      }
    }
  ],
  "traits": {
    "autonomous_system_number": 15169,
    "autonomous_system_organization": "Google LLC",
    "domain": "google.com",
    "ip_address": "203.0.113.45",
    "is_anycast": true,
    "is_legitimate_proxy": false,
    "is_satellite_provider": false,
    "is_hosting_provider": false,
    "is_mobile_carrier": false,
    "is_residential_proxy": false,
    "is_tor_exit_node": false,
    "is_vpn": false,
    "network": "203.0.113.0/24",
    "static_ip_score": 0.0,
    "user_count": 0,
    "user_type": "business"
  }
}
```

**Key Fields:**
- `city.names` — City name in multiple languages
- `country.iso_code` — 2-letter country code (e.g., "US")
- `location.latitude`, `location.longitude` — Geographic coordinates
- `location.time_zone` — Timezone for location (e.g., "America/Los_Angeles")
- `subdivisions[0].iso_code` — State/province code (e.g., "CA")
- `postal.code` — Zip/postal code
- `traits` — Network/ISP information (ASN, domain, proxy detection)

#### GET Insights Lookup (Premium)

**Endpoint:** `GET /geoip/v2.1/insights/{ip}`

**Note:** Premium service with additional data (confidence scores, proxy detection, user count)

**Key Additional Fields:**
- `location.accuracy_radius` — Confidence radius in kilometers
- `traits.is_vpn` — Whether IP is from a VPN
- `traits.is_proxy` — Whether IP is from a proxy
- `traits.static_ip_score` — Likelihood IP is static (0.0–1.0)

### Error Responses

#### 400 Bad Request
```json
{
  "code": "IP_ADDRESS_INVALID",
  "error": "The value \"invalid_ip\" is not a valid IP address"
}
```

#### 401 Unauthorized
```json
{
  "code": "AUTHORIZATION_INVALID",
  "error": "Invalid authorization header"
}
```

#### 404 Not Found
```json
{
  "code": "IP_ADDRESS_NOT_FOUND",
  "error": "The address \"192.0.2.1\" is not in the database"
}
```

## Data Flow

### Contact Creation with GeoIP Enrichment

1. **Web Form Submission:** Lead submits contact form
2. **IP Capture:** CDXP captures visitor IP from request headers
3. **Mautic Contact Creation:** Contact record created with IP
4. **MaxMind Lookup:** Mautic calls `GET /geoip/v2.1/city/{ip}`
5. **Data Enrichment:** Response fields mapped to Mautic contact:
   - `city.names.en` → `mautic_city`
   - `subdivisions[0].iso_code` → `mautic_region`
   - `country.iso_code` → `mautic_country`
   - `location.latitude` → `mautic_latitude`
   - `location.longitude` → `mautic_longitude`
   - `location.time_zone` → `mautic_timezone`
6. **Profile Complete:** Contact now geo-enriched for targeting

### Do Not Sell List Compliance (Weekly Purge)

1. **Scheduled Job:** Cron runs weekly (e.g., Sunday 2 AM)
2. **Download DNS List:** MaxMind Do Not Sell list downloaded
3. **Parse IPs:** Extract restricted IP ranges from CSV
4. **Query Contacts:** Find all Mautic contacts with IPs in list
5. **Delete Contacts:** Custom Mautic command purges matching contacts
6. **Log Purge:** Record count of deleted contacts for compliance audit
7. **Notification:** Send alert to compliance team with purge summary

## Use Cases in DAS

### Lead Location Targeting

**Flow:**
1. Auto dealer submits lead via web form from Phoenix, AZ
2. IP: 203.0.113.45 captured
3. MaxMind lookup returns: city=Phoenix, region=AZ, country=US
4. Mautic contact enriched with location
5. Campaign segment: "Arizona Dealers" now includes this contact
6. Email campaign targeted to Arizona-based leads

### Regional Compliance (Do Not Sell)

**Flow:**
1. MaxMind Do Not Sell list updated (CCPA restricted IPs)
2. Weekly cron job runs
3. Mautic custom command queries all contacts with IPs in restricted list
4. Finds 47 contacts matching list IPs
5. Deletes those contacts from Mautic
6. Log entry: "CCPA Compliance Purge: 47 contacts removed"
7. Compliance report generated for audit

### Campaign Segmentation by Timezone

**Flow:**
1. Contact created from IP in Los Angeles
2. MaxMind returns: time_zone="America/Los_Angeles"
3. Mautic segment: "Pacific Time Zone" includes this contact
4. Campaign sends email at 9 AM Pacific (not 9 AM ET)
5. Better open rates from timezone-appropriate send time

### Fraud Detection (Proxy/VPN)

**Flow:**
1. Contact created from suspicious IP
2. MaxMind Insights lookup returns: is_vpn=true
3. Mautic flag: "Suspicious Activity" set
4. Contact routed to manual verification queue
5. Sales team reviews before engagement

## Configuration Management

### MaxMind Account Setup

- **Account ID:** Provided by MaxMind (credentials.maxmind.com)
- **License Key:** Per-account key (never exposed in client-side code)
- **Databases:** Subscription tier determines available endpoints:
  - **City:** Basic geolocation (latitude, longitude, city, region, country)
  - **Insights:** Premium (+ confidence scores, proxy detection, ASN)
  - **Do Not Sell:** Compliance list (separate download, CSV format)

### Mautic Configuration

- **MaxMind Plugin:** Install and configure with Account ID + License Key
- **Contact Fields:** Map MaxMind response fields to Mautic contact properties
- **Update Strategy:** On every contact creation (not batch)
- **Caching:** Optional Redis/Memcached for frequently looked-up IPs
- **Timeout:** Set API timeout to prevent contact creation delays (default 5s)

### Privacy & Compliance

- **GDPR:** MaxMind complies with GDPR; IP lookup is lawful for analytics
- **CCPA:** Do Not Sell list honors California opt-out requirements
- **Data Retention:** MaxMind does not store IP lookups (no logs)
- **Accuracy:** 99.5% accuracy for city-level geolocation

## Troubleshooting

### IP Not Found (404 Error)

**Causes:**
- IP is private/reserved (10.0.0.0/8, 192.168.0.0/16, etc.)
- IP is very new and not yet in MaxMind database
- IP is from a less common region (coverage varies by country)

**Fix:**
1. Check if IP is private (starts with 10., 172.16–31., 192.168.)
2. Skip lookup for private IPs
3. For legitimate IPs: wait 24–48 hours for MaxMind database update
4. Verify MaxMind subscription includes target country

### Authorization Failed (401 Error)

**Causes:**
- Account ID invalid
- License Key expired or incorrect
- Credentials not Base64 encoded properly

**Fix:**
1. Verify Account ID and License Key in MaxMind portal
2. Check for copy/paste errors (whitespace, special chars)
3. Ensure credentials are Base64 encoded: `base64("account:key")`
4. Test with curl: `curl -u "account:key" https://geoip.maxmind.com/geoip/v2.1/city/8.8.8.8`

### Contacts Not Enriched

**Checklist:**
1. MaxMind plugin installed in Mautic
2. Account ID and License Key configured correctly
3. Contact fields mapped to MaxMind response fields
4. IP captured correctly from request headers (check request logs)
5. Network connectivity to MaxMind API (no firewall block)
6. API timeout not too short (default 5s)

**Investigation:**
1. Check Mautic plugin logs for MaxMind API calls
2. Verify IP format (must be valid IPv4 or IPv6)
3. Test IP lookup manually: `curl -u "id:key" https://geoip.maxmind.com/geoip/v2.1/city/203.0.113.45`
4. Check contact creation trigger (may be skipping GeoIP step)

### Do Not Sell Purge Not Running

**Causes:**
- Cron job disabled or misconfigured
- Do Not Sell list file not found or corrupted
- Mautic custom command missing or broken
- Database permissions issue (cannot delete contacts)

**Fix:**
1. Verify cron job exists: `crontab -l | grep maxmind`
2. Manually run purge command: `php bin/console maxmind:purge-dns-list`
3. Check cron logs: `/var/log/syslog` or `/var/log/cron`
4. Verify Mautic database user has DELETE permissions
5. Test with small subset: `php bin/console maxmind:purge-dns-list --dry-run`

## Security Considerations

### Authentication & Authorization

- Account ID + License Key sent via HTTP Basic Auth
- Always use HTTPS (MaxMind enforces TLS 1.2+)
- Keys stored in environment variables (not hardcoded)
- Keys never logged or exposed in client-side code

### Data Sensitivity

- IP addresses are PII in some jurisdictions (GDPR)
- MaxMind API does not log IP lookups (no audit trail at MaxMind)
- Location data (lat/lon) may reveal home/work address
- Geolocation accuracy varies (±20 km default)

### Compliance

- **GDPR:** Compliant (lawful basis: legitimate interest for analytics)
- **CCPA:** Supported via Do Not Sell list
- **HIPAA:** Not suitable for protected health info
- **FERPA:** Not suitable for educational records

## Related Documentation

- **Confluence:** [Mautic Deep Dive (MaxMind GeoIP2 dependency)](https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141435473)
- **Repository:** [3birdsmarketing/CDXP-Mautic](https://github.com/3birdsmarketing/CDXP-Mautic)
- **MaxMind Official:** [GeoIP2 Web Services](https://dev.maxmind.com/geoip/geoip2/web-services/)

## References

- **MaxMind GeoIP2 API:** https://geoip.maxmind.com/geoip/v2.1
- **Account Portal:** https://www.maxmind.com/en/account
- **Database Types:** City, Insights, Do Not Sell list
- **Rate Limit:** Depends on subscription tier (typically 200k lookups/month minimum)
- **Accuracy:** ~99.5% for city-level geolocation
