---
source: DAS Confluence
page_id: 3204087814
title: CRM Data Onboarding & Offboarding Process
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3204087814
type: confluence-doc
repulled: 2026-06-09
---

# Overview

This article, and those nested within it, was written to provide context on the following:

- Information on how the development team is made aware of new onboarding or offboarding requests.

- The required permission level or features the DAS user created within each CRM needs for the data team to be able to extract the initial historical (and ongoing) data pull.

- Information on the historical data pull.

## Onboarding & Offboarding Awareness

- **📨 Request Initiation**

  - Onboarding and offboarding requests are submitted via the Planner app by CAST team members, which is embedded within Microsoft Teams.

  - Each request includes the client name, client ID, CRM provider, and relevant details (e.g., splitting logic).

- **🎟️ Ticket Creation**

  - Nikhil or another database engineer manually creates a JIRA ticket in the CDXP project.

  - Tasks are assigned based on request type (onboarding/offboarding).

### Historical Pull

**📊 Historical Data Pull**

- A one-time export is performed for historical data (range varies by CRM).

- Required fields are selected to match CDXP schema.

- Data is exported (usually as CSV), processed via SSIS, and loaded into CDXP systems.

### CRM Requirements

The child pages below have specific information on the requirements for each CRM.

- <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3204743173/Tekion+CDXP" data-linked-resource-id="3204743173" data-linked-resource-version="6" data-linked-resource-type="page">Tekion (CDXP)</a>
- <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3205496847/eLeads+CDXP" data-linked-resource-id="3205496847" data-linked-resource-version="2" data-linked-resource-type="page">eLeads (CDXP)</a>
- <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3327590404/VinSolutions+-+CDXP" data-linked-resource-id="3327590404" data-linked-resource-version="1" data-linked-resource-type="page">VinSolutions - CDXP</a>

#### Originally provided documentation:

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.sharepoint.com/:w:/s/ApplicationSupport/EbDAzYkN585Fij3-P3SKmQMBx8e9889cJfYwzGjojvFrKw?e=jeuAZI" class="confluence-embedded-image confluence-external-resource image-center" data-image-src="https://digitalairstrike.sharepoint.com/:w:/s/ApplicationSupport/EbDAzYkN585Fij3-P3SKmQMBx8e9889cJfYwzGjojvFrKw?e=jeuAZI" loading="lazy" width="250" /></span>
