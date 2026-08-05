---
source: DAS Confluence
page_id: 3141173321
title: Data Processing
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141173321
type: confluence-doc
repulled: 2026-06-09
---

### Lucid Diagrams: 

Illustrates both *<u>SSIS Process/Timing and a Contact Sync Overview</u>* of how data moves thru the system.

<a href="https://lucid.app/lucidchart/15490db6-87ea-4336-afb3-979aa98552c8/edit?viewport_loc=-2616%2C38%2C5829%2C2250%2C0_0&amp;invitationId=inv_464d2bd2-1d78-45bf-9611-d5c278b7e485" class="external-link" rel="nofollow">https://lucid.app/lucidchart/15490db6-87ea-4336-afb3-979aa98552c8/edit?viewport_loc=-2616%2C38%2C5829%2C2250%2C0_0&amp;invitationId=inv_464d2bd2-1d78-45bf-9611-d5c278b7e485</a>  

### Data Process

- DMS – Authenticom , FTP/SFTP , CDK  (comes first via ftp) 

  - Source – Pre-stage , Stage, Target \> DMS Appt SSIS 

- CRM – Vin Solutions , Eleads , R&R  

  - Source – Pre-stage , Stage, Target \> CRM SSIS 

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3141173321/SSIS%20Process%20Simple.png?api=v2" class="confluence-embedded-image image-center" width="1033" /></span>

 

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

**All processes truncate the table then add new process  **\
*They get 10 days of data so it expects duplicates  *

</div>

</div>

 

### SSIS Process 

Import source CRM \> Insert Pre Staging  (clean) \> Lookup CRM Lead \> Lookup Status \> Insert Stage (cleaned) \> Insert to Target Table 

Does Validation on data / cleansing 

Only selecting distinct records  

 

Blackbook API = Stage Vehicle Valuation  \> Calculate Equity via API\>  Move to Target \> Update Analytics BlueSky Recommendation Table 

 

***CVH --\> CVH SSIS  (Contact Verification and Hashing) ***

CVH is merging data together to CRM an appointment data 

Once it's in the CVH tool, it will show in Data Mining Tool  

*User Identification / Merging / Deduping? *

- CVH is base table to legacy system  

  - Its used as a reference for CDXP 

  - Main ID is the Mautic contactID 

  - Customer HASH

    - DealerID + Customer Email  

<div class="confluence-information-macro confluence-information-macro-note">

<span class="aui-icon aui-icon-small aui-iconfont-warning confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

Cant handle multiple email address.\
*(This means there will be a separate contact per dealer, per email address)*

</div>

</div>

### SSIS Timings

Original doc: <a href="https://sheet.zoho.com/sheet/open/g7atu37af197322a64ed398b30cf3c4b2790a?sheetid=0&amp;range=G11" class="external-link" rel="nofollow">https://sheet.zoho.com/sheet/open/g7atu37af197322a64ed398b30cf3c4b2790a?sheetid=0&amp;range=G11</a> 

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3141173321/SSIS%20Timings.png?api=v2" class="confluence-embedded-image image-center" width="1800" /></span>

### Daily Contact Sync Process

Daily there is a contact sync process – recipient list is not related to CVH (MS SQL) process, contacts are synced daily to Mautic MySQL` `\
The SQL Tbl has a copy of the mautic_contact_mapping and that is what's used to check if it needs to be synced to MySQL 

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

Does them in batches of 500 and calls the Mautic api (1 contact at a time) 

</div>

</div>

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3141173321/Contact%20Sync%20.png?api=v2" class="confluence-embedded-image image-center" width="1558" /></span>
