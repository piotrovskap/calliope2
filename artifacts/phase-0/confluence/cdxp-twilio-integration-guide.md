---
source: DAS Confluence
page_id: 2981232673
title: CDXP Twilio Integration Guide
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2981232673
type: confluence-doc
repulled: 2026-06-09
---

**<u>Twilio SMS Gateway Integration (CDXP)</u>**

This document is a step-by-step guide to configure and leverage SMS service using Twilio in CDXP at dealership level.

**<u>Configure Twilio</u>:**

**STEP 1: Create Twilio account and get credentials**

1.  Go to <a href="https://www.twilio.com/login" class="external-link" rel="nofollow">https://www.twilio.com/login</a> and create an account or login if account is already created.

2.  After login, Please collect the credentials required for sending SMS from CDXP.

<span class="confluence-embedded-file-wrapper image-left-wrap-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2981232673/att_2_for_2981232673.png?api=v2" class="confluence-embedded-image image-wrap-left" width="591" /></span>

3.  In CDXP, Edit the company you want to enable SMS sending using Twilio. Fill details for company’s Twilio SID token and sending phone number fields respectively.

<span class="confluence-embedded-file-wrapper image-left-wrap-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2981232673/att_1_for_2981232673.png?api=v2" class="confluence-embedded-image image-wrap-left" width="598" /></span>

4.  Also make sure to set **d_is_sms_la, d_is_sms_sa** and **d_is_sms_ea** field values to “yes” in order to start sending SMS

5.  Once above changes are done, Then SMS can be sent same way Emails are being sent via campaign or directly from Contact view page.

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

Note: Send SMS button on contact view page will only be visible when contact has phone number and Twilio SMS plugin is enabled.

</div>

</div>
