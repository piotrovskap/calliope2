---
source: DAS Confluence
page_id: 3327590404
title: VinSolutions - CDXP
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3327590404
type: confluence-doc
repulled: 2026-06-09
---

# Prerequisites:

1.  Operations (CAST) will work with the client for a unique DAS user to be provisioned with the permissions to **Create Report.**

2.  Once the user is created, CAST will store the credentials in the **Shared-CRM Credentials** LastPass Folder.

    1.  CAST will also ensure the MFA number is set to **Clerk\*:**

        1.  +1 628 276 0029

3.  Development will use those credentials to login, configure the report with the columns required for CDXP and then download the historical data.

<div class="confluence-information-macro confluence-information-macro-information">

<span class="aui-icon aui-icon-small aui-iconfont-info confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

\*Application Support can provide access to the Clerk application, which is a 3rd party application integrated with Microsoft Teams. From within that app, users can view incoming MFA messages.

</div>

</div>

## Login Process for Development

In order to login into the VinSolutions portal, firstly, development needs working credentials.

<div class="confluence-information-macro confluence-information-macro-note">

<span class="aui-icon aui-icon-small aui-iconfont-warning confluence-information-macro-icon"></span>

<div class="confluence-information-macro-body">

If provided credentials do not work, please reach out to Application Support in the Onboarding Jira Ticket, who will then work with CAST to amend.

</div>

</div>

1.  Development must first login:

    1.  **VinSolutions:** <a href="https://vinsolutions.app.coxautoinc.com/vinconnect/" class="external-link" rel="nofollow">https://vinsolutions.app.coxautoinc.com/vinconnect/</a> 

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3327590404/image-20250507-173354.png?api=v2" class="confluence-embedded-image image-center" width="487" alt="image-20250507-173354.png" /></span>

2.  Then the two-factor authentication should have set-up with the clerks’ app number:  

    1.  (+1 628 276 0029) 

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3327590404/image-20250507-174421.png?api=v2" class="confluence-embedded-image image-center" width="499" alt="image-20250507-174421.png" /></span>

3.  Then the DAS specific user needs to have permission to **Create Report**:

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3327590404/image-20250507-174510.png?api=v2" class="confluence-embedded-image image-center" width="507" alt="image-20250507-174510.png" /></span>
