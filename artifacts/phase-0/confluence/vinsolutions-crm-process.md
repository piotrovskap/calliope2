---
source: DAS Confluence
page_id: 3465871362
title: VinSolutions| CRM Process
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3465871362
type: confluence-doc
repulled: 2026-06-09
---

# Overview

This article describes how to complete the onboarding for a VinSolutions Dealer

<div class="panel">

<div class="panelContent">

We must have CRM credentials in order to complete the data pull. The Client Activation and Support team (CAST) will work with the client to have our user and our credentials provisioned.

</div>

</div>

**Table of Contents**

<div class="toc-macro rbtoc1781043473682">

- [Navigate to Report](#VinSolutions%7CCRMProcess-NavigatetoReport)
  - [Sales Report](#VinSolutions%7CCRMProcess-SalesReport)
  - [Service Report](#VinSolutions%7CCRMProcess-ServiceReport)
  - [Scheduler](#VinSolutions%7CCRMProcess-Scheduler)
  - [Historical Data Pull](#VinSolutions%7CCRMProcess-HistoricalDataPull)
  - [Where to Put the Data](#VinSolutions%7CCRMProcess-WheretoPuttheData)
  - [Video Walkthrough](#VinSolutions%7CCRMProcess-VideoWalkthrough)

</div>

## Navigate to Report

1.  Login to VinSolutions: <a href="https://www.vinsolutions.com/" class="external-link" rel="nofollow"><strong><u>https://www.vinsolutions.com/</u></strong></a>

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-220332.png?api=v2" class="confluence-embedded-image image-center" width="703" alt="image-20250903-220332.png" /></span>

2.    Once logged in, navigate to **Insights:**

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-220439.png?api=v2" class="confluence-embedded-image image-center" width="712" alt="image-20250903-220439.png" /></span>

3.  **Click on the 3-dot icon in the right-hand corner of the Reports and Dashboards section. ​**

    1.  Click on ‘Create Report’

    2.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-220547.png?api=v2" class="confluence-embedded-image image-center" width="712" alt="image-20250903-220547.png" /></span>

4.  Click on the **Gear** icon. You’ll now be able to change the name of the report. ​

    1.  Typically name the report:

        1.  \[CLIENTID\]-Sales

        2.  \[ClientID\] - Service

    2.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-220710.png?api=v2" class="confluence-embedded-image image-center" width="565" alt="image-20250903-220710.png" /></span>

### Sales Report

5.  To select which sets of data to use for the report, you’ll go to the ‘Select Data’ dropdown. ​

    1.  Click on ‘Customers’ first. Then ‘Add Leads to Customers’ and then ‘CRM Sales to Customers’​

    2.  You will then need to click on each check box as shown above.

        1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221203.png?api=v2" class="confluence-embedded-image image-center" width="578" alt="image-20250903-221203.png" /></span>
        2.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221213.png?api=v2" class="confluence-embedded-image image-center" width="451" alt="image-20250903-221213.png" /></span>

6.  Click on ‘Formula’ to add a new custom column. ​

    1.  Name the column ‘ClientID’ then add the ClientID into the formula box. ​

    2.  Data Type = text.

    3.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221328.png?api=v2" class="confluence-embedded-image image-center" width="601" alt="image-20250903-221328.png" /></span>

### Service Report

7.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221433.png?api=v2" class="confluence-embedded-image image-center" width="472" alt="image-20250903-221433.png" /></span>

### Scheduler

8.  When scheduling and trying to get data from VinSolutions, getting very large datasets out of VinSolutions almost never work. ​

    1.  If trying to get historical data, please pull them out in 90-day segments. ​

    2.  If doing a net difference each day, please do 10 days ago to today like in the screenshot.

    3.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221519.png?api=v2" class="confluence-embedded-image image-center" width="629" alt="image-20250903-221519.png" /></span>

9.  Click on the dot icons as shown above, and then click on schedule.

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221756.png?api=v2" class="confluence-embedded-image image-center" width="712" alt="image-20250903-221756.png" /></span>

10. When scheduling the report, enter the email address to send the report. ​

    1.  You can use ‘Analytics@3birdsmarketing.com’ and subject as VS2-CLIENTID-Sales​

    2.  Enter a send time. Once you have your time saved, you’ll click ‘Save’.

    3.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221842.png?api=v2" class="confluence-embedded-image image-center" width="694" alt="image-20250903-221842.png" /></span>

### Historical Data Pull

11. If you’re wanting to do a historical data pull, you’ll need to follow the same steps as previously listed.​ You’ll want to pull your data in 90-day segments since very large segments tend to have issues when sending and exporting.​

    1.  When you’re ready to send the data, you can click on ‘Run Now’. Be sure to save the file in the same format but give it a different date than any previous file. We cannot process a file if the file name already exists in the CRM directory.

    2.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-221946.png?api=v2" class="confluence-embedded-image image-center" width="694" alt="image-20250903-221946.png" /></span>

12. **There are situations where a client shares CRM data across several clients and we just need to pull a specific dataset based on make.** ​**To do that, you’ll need to click on ‘Filter’ and then select a filter column like ‘Make’ and then enter the specific value you want. For instance, you might select ‘Make’ and then select ‘Honda’ if I only wanted to see data for Honda cars from the CRM. After you click on ‘Add’ the data will filter.**

    1.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/image-20250903-222042.png?api=v2" class="confluence-embedded-image image-center" width="615" alt="image-20250903-222042.png" /></span>

### Where to Put the Data

13. **Once you have the data, you’ll need to put the data into 3BHSETL01. In .32 (ETL01), you should place your files in the directory above. ​**

    1.  **e/data/crm/3_source**

### Video Walkthrough

The recording below will show a video walkthrough of the process

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><video src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/VinSolutions_video.mp4?api=v2" class="confluence-embedded-image image-center" width="760" controls=""><a href="https://digitalairstrike.atlassian.net/wiki/download/attachments/3465871362/VinSolutions_video.mp4?api=v2">VinSolutions_video.mp4</a></video></span>
