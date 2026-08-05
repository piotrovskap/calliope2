---
source: DAS Confluence
page_id: 3210477575
title: Creating GA Measurement ID for CDXP
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3210477575
type: confluence-doc
repulled: 2026-06-09
---

**Overview**

This walkthrough guides the Activations Team through the process of creating a Google Analytics (GA) Measurement ID to track client website activity within the CDXP platform. The goal is to ensure accurate analytics setup for performance monitoring and campaign optimization.

------------------------------------------------------------------------

**1. Sign into Google Analytics**

- Use the provided credentials: `ga@ad-ez.com`

- Complete two-part verification (information is in Clerk).

- URL: <a href="https://analytics.google.com/" class="external-link" rel="nofollow">https://analytics.google.com/</a>

#### **2. Search for Client Access**

- Verify if the client uses GA4 or Universal Analytics, noting that GA4 replaced Universal Analytics as of July 2023. Use GA4 exclusively unless otherwise specified.

- Search for the client’s account to confirm access.

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_7_for_3210477575.png?api=v2" class="confluence-embedded-image image-left" width="760" /></span>

#### **3. Select Client and Access Admin Settings**

- Select the client from the search results.

- Click on the gear icon (Settings) at the bottom-left corner of the page

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_6_for_3210477575.png?api=v2" class="confluence-embedded-image image-center" width="805" /></span>

#### **4. Check and Add Data Stream**

- Click on **Data Streams**.

- Select **Add Stream**.

  - *If the 'Add Stream' button is grayed out, it means there is no admin access.*

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_2_for_3210477575.png?api=v2" class="confluence-embedded-image image-left" width="760" /></span><span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_4_for_3210477575.png?api=v2" class="confluence-embedded-image image-left" width="760" /></span>

#### **5. Configure the Data Stream**

- Select **Web**.

- Approve the pop-up confirmation by selecting **YES**.

- Enter the client’s website URL.

- Name the stream using the format: `Dealer Name CDXP`

- Ensure **Enhanced Measurement** is enabled.

- Click **Create Stream**.

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_3_for_3210477575.png?api=v2" class="confluence-embedded-image image-left" width="760" /></span><span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_1_for_3210477575.png?api=v2" class="confluence-embedded-image image-left" width="760" /></span>

#### **6. Final Steps**

- Close the installation instructions tab

- Copy the **Measurement ID** from the **Web Stream Details** page (found under Admin \> Data Streams \> \[Web Stream Name\] in the Google Analytics interface).

<div class="panel">

<div class="panelContent">

Copy the full Measurement ID, which typically starts with 'G-'.

</div>

</div>

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210477575/att_5_for_3210477575.png?api=v2" class="confluence-embedded-image image-center" width="760" /></span>
