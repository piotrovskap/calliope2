---
source: DAS Confluence
page_id: 3210051587
title: Google Analytics (GA4) Access and CDXP Integration Guide
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3210051587
type: confluence-doc
repulled: 2026-06-09
---

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

### **CDXP Product Data Needs:**

- The GA4 Measurement ID powers CDXP dashboard reporting.

- See: <a href="https://digitalairstrike-my.sharepoint.com/:x:/g/personal/tiffany_dastechnology_com/EbdK2deKoixDpaaj6aKjbzoBzhy3TGxSBrOT64tsH8xmww?e=lqVtwp" class="external-link" rel="nofollow">CDXP Products - Data Needs</a> for how GA data fuels CDXP features.

</div>

</div>

### **1. Client Instructions for READ/ANALYZE Access:**

- If a GA4 Measurement ID already exists:

  - Provide **READ/ANALYZE** access to <a href="mailto:ga@ad-ez.com" class="external-link" rel="nofollow"><strong>ga@ad-ez.com</strong></a> for ID retrieval.

<div class="panel">

<div class="panelContent">

- READ/ANALYZE access is sufficient for copying the ID.

</div>

</div>

### **2. Granting Google Analytics Access:**

- **Admin Access:** Provide **ADMIN** access to <a href="mailto:ga@ad-ez.com" class="external-link" rel="nofollow"><strong>ga@ad-ez.com</strong></a> to enable GA4 data stream creation and obtain the GA4 Measurement ID for CDXP reporting.

  - *Tip:* ADMIN access is mandatory for new data stream creation.

<div class="panel">

<div class="panelContent">

- No additional GA iterations are required on the dealer’s site.

</div>

</div>

### **3.** Finding the GA4 Measurement ID in Google Analytics:

- Log in to your Google Analytics account at <a href="https://analytics.google.com" class="external-link" rel="nofollow">analytics.google.com</a>.

- In the left-hand menu, click on **Admin**.

- Under the **Property** column, select **Data Streams**.

- Choose the appropriate data stream (usually titled with the website name).

- The GA4 Measurement ID will appear at the top-right of the Data Stream details page (formatted as **G-XXXXXXXXX**)

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210051587/2025-02-14_09-38-20.png?api=v2" class="confluence-embedded-image image-center" width="760" alt="2025-02-14_09-38-20.png" /></span>

<div class="confluence-information-macro confluence-information-macro-note">

<span class="aui-icon aui-icon-small aui-iconfont-warning confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

If there is no ID, then proceed to step 4 to create a GA4 ID to use.

</div>

</div>

### **4. Creating a GA4 Measurement ID:**

- Follow this guide: <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3210477575/Creating+GA+Measurement+ID+for+CDXP" data-linked-resource-id="3210477575" data-linked-resource-version="7" data-linked-resource-type="page">How to Create a GA4 Measurement ID</a>

- Copy the unique GA4 Measurement ID.

- Enter the Measurement ID in the Builder Site under **Settings \> Tracking** (*Include the "G-" prefix*).

### **5. DAS Team Internal Steps:**

- Once READ/ANALYZE access is obtained:

  - Copy the GA4 Measurement ID.

  - Enter it into the <a href="https://admin.3birdsmarketing.com/Builder/Sites" class="external-link" rel="nofollow">Client’s Builder Site</a> under **Settings \> Tracking** (*Ensure the "G-" prefix is included*).

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3210051587/image-20230906-175930.png?api=v2" class="confluence-embedded-image image-center" width="753" alt="image-20230906-175930.png" /></span>

This Confluence guide outlines the streamlined process for integrating GA4 with CDXP dashboard reporting.
