---
source: DAS Confluence
page_id: 3150675973
title: How to Connect to AWS VPN
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3150675973
type: confluence-doc
repulled: 2026-06-09
---

## Overview

As part of an ongoing effort to further DAS security posture, all access to database resources of CDXP and DDE will be accessible only through a VPN connection established on individual machines.

## Prerequisites

A developer will need access to the following services:

- AWS OpenVPN Client application is installed - <a href="https://aws.amazon.com/vpn/client-vpn-download/" class="external-link" data-card-appearance="inline" data-local-id="2bfda790-fc27-475d-818a-da202e1b881b" rel="nofollow">https://aws.amazon.com/vpn/client-vpn-download/</a>

## Local Computer Configuration

###  AWS OpenVPN Client Configuration

1.  Install the OpenVPN client application

2.  Open the application

3.  Add a new profile using File → Manage Profiles, name it `CDXP`

4.  Download this file into your local system\
    [<span>cdxp-client-config.ovpn</span>](/wiki/spaces/Technology/pages/3150675973/How+to+Connect+to+AWS+VPN?preview=%2F3150675973%2F3151364101%2Fcdxp-client-config.ovpn)

5.  Use the file named `cdxp-client-config.ovpn` at the bottom of this section for the configuration:

6.  <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3150675973/image-20250110-154528.png?api=v2" class="confluence-embedded-image image-center" width="466" alt="image-20250110-154528.png" /></span>

7.  After completing the profile, click Connect on the main ClientVPN client window.

8.   

    <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3150675973/image-20250110-154626.png?api=v2" class="confluence-embedded-image image-center" width="344" alt="image-20250110-154626.png" /></span>

9.   This will open a browser window to the AWS Login screen if you are **not** in an active session

10. <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3150675973/image-20250110-154713.png?api=v2" class="confluence-embedded-image image-center" width="453" alt="image-20250110-154713.png" /></span>

11.  If you **are** in an active session you will see a window from the VPN client that should look like this:

12.  

    <span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3150675973/image-20250110-154816.png?api=v2" class="confluence-embedded-image image-center" width="386" alt="image-20250110-154816.png" /></span>
