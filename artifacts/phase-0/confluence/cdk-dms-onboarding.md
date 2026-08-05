---
source: DAS Confluence
page_id: 3475079169
title: CDK Onboarding - DMS
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3475079169
type: confluence-doc
repulled: 2026-06-09
---

# Purpose

The intention of this document is to provide insight and training on how to onboard a client with CDK as their website provider.

### Pre-Requisites

1.  Onboarding Ticket  

2.  3PA ID from Onboarding Team 

3.  ClientID 

4.  FTP Directory 

The team will create a desk ticket whenever we start onboarding a client. In that initial onboarding ticket, the team will list the DMS provider if we have one. You’ll see here whether we have a CDK client. Regardless of a dealer being Authenticom or CDK, you need to create an FTP directory for the client as part of the initial onboarding.  

## Getting CDK DealerID

Once the dealer purchases the catalog and we approve the feed. We will receive a ‘3PA’ number from CDK. The team will always update the initial onboarding ticket with the CDK DealerId and Catalog info.  

Once the team receives the information, they add the info like this into the ticket:   

Example \#1:

- *Dealer ID : 3PA0003684* 

- *Dealer Name : HALL HYUNDAI OF CHESAPEAKE* 

- *CMF Number : 76028921* 

- *C Number : C195341* 

- *Catalog ID : 4433400* 

- *IP : 192.110.95.148* 

- *Group : HHC(HHC-FI,HHC-S,HAM-A)* 

 Example \#2:

- *Dealer ID : 3PA0003684* \
  *Dealer Name : HALL HYUNDAI OF CHESAPEAKE*  \
  *CMF Number : 76028921* \
  *C Number : C195341* \
  *Catalog ID : 4433548* \
  *IP : 192.110.95.148* \
  *Group : HHC(HHC-S)* 

 

### Updating Our System

Updating our System 

1.  Go to Analytics_Clients in ETL01.EDW_Target.  

2.  Update the CdkDealerId column with the DealerID from CDK. You can use the SQL below to set the CdkDealerId based on what you have for the ClientID. Update DMS provider to CDK 

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
UPDATE Analytics_Clients  
SET CdkDealerId = 'DEALERID' 
  DmsProvider = ‘CDK’ 
WHERE CLIENTID = CLIENTID 
```

</div>

</div>

### Getting Historical Data

1.  <span>Go to Zoho Projects – 3Birds Platform Development and create a ticket</span>.  

2.  Name ticket – ‘Get Historical DMS Data for \[ClientID\] – ClientName’ 

3.  Ticket body example below 

*We have 2 new MileOne stores that we started receiving data for* 

- *173032 Hall Hyundai Chesapeake* 

- *152469 Hall Hyundai Elizabeth City* 

*We have a CDK dealer ID for both stores below. Can we make sure to pull historical data for both stores (sales, service, and appointments)* 

- *173032 / Hall Hyundai Chesapeake / 3PA0003684* 

- *152469 / Hall Hyundai Elizabeth City / 3PA87575* 

*Please verify and make sure we are pulling and processing DMS data. Please confirm and provide an update when we receive the 5-year pull and data is in EDW_Target.* 

<div class="panel">

<div class="panelContent">

 **After we enter the CDK Dealer ID, we should see recent transactions start surfacing in EDW_Target and the Data Mining Tool in about 48-72 hours. ** 

</div>

</div>

### To QA

- You can verify data from CDK by using the Data Mining Tool to see whether we have all data.  

- You can also go into DMS_Dim_Transactions to view the number of rows we have for the client. This table also includes the transaction dates.  

### Video Short Walkthrough

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><video src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3475079169/CDK%20Video.mp4?api=v2" class="confluence-embedded-image image-center" width="760" controls=""><a href="https://digitalairstrike.atlassian.net/wiki/download/attachments/3475079169/CDK%20Video.mp4?api=v2">CDK Video.mp4</a></video></span>
