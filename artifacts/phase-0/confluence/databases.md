---
source: DAS Confluence
page_id: 3141304360
title: Databases
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141304360
type: confluence-doc
repulled: 2026-06-09
---

### **MS SQL **

#### 10.254.210

- **.32 **

  - EDW staging db – used for source, staging, and pre-stage data  

  - EDW target db – data is loaded into here once cleaned 

  - DDE is using this in the BSD 

- **.28 **

  - Vehicle Inventory Data 

- **.10 **

  - ClientDB and Lift DB (required for Legacy) *(Client Module)* 

    - Most Used DBs 

  - Client: All information on a client, recipients (used with DDE)  *(List Management)* 

    - RecipientList /ListMembers – grouping of leads (person value) 

  - Lift:  For Sending Emails (campaign details)  

    - Stored Email content, settings, templates, events, images, etc.  

### **MySQL **

- **Mautic Accelerator **

  - 99% Mautic structure, 1 or 2 custom tables 

  - All tables have a ClientID linkage \

### **Postgress **

- **Analytics \> 3B-CDXP \> marketing** 

  - Running campaigns from Mautic or Legacy uses MailGun 

  - Mailgun calls AWS Webhook, this DB stores the events (clicks, opens, touch base etc.) 

  - Only for Mautic Events  

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

Reporting uses .32 EDW target, .10 ClientDB , and Postgress,

</div>

</div>

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

d\_ means this field is for dealer` `\
c\_ means this field is belong to contact 

</div>

</div>

## Simform Database Details

Simform Team Provided some insight into each database here:

<a href="https://digitalairstrike-my.sharepoint.com/:w:/p/daston/EZKfFBRambZLujXOPpG6-4EBrpklw9h_uIUipDhW6adabQ?e=CT0sEN" class="external-link" rel="nofollow">3Birds Databases</a>
