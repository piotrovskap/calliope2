---
source: DAS Confluence
page_id: 3422191631
title: GA4 integration process
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3422191631
type: confluence-doc
repulled: 2026-06-09
---

1.  

2.  **<span colorid="sehh7gjqu6">Process Conditions</span>**

    1.  <span colorid="knww4b6j1s">What conditions must be met in order for the integration to work properly?</span>

        1.  <span colorid="mvi2mh4xrw">Please provide the requirements that are needed, for example:</span>

            1.  <span colorid="bezk8ue0cg">We need an Analytics ID</span>

            2.  <span colorid="ekwm3ql6v8">It needs to be in Builder</span>

            3.  <span colorid="ugpj4klf4x">Etc.</span>

**<span colorid="pufzt33t8h"> Comment: </span>**

<span class="legacy-color-text-default">Google analytics ID must be entered in builder site for eg.</span>\
<a href="https://admin.3birdsmarketing.com/Builder/Sites/View/7733" class="external-link" rel="nofollow">https://admin.3birdsmarketing.com/Builder/Sites/View/7733</a>

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3422191631/att_1_for_3422191631.png?api=v2" class="confluence-embedded-image image-left" width="634" /></span><span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3422191631/att_3_for_3422191631.png?api=v2" class="confluence-embedded-image image-left" width="578" /></span>

<span colorid="eqo64o7i49"> </span><span class="legacy-color-text-default">And the ID must have to be in the code under script like below:</span>

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3422191631/att_2_for_3422191631.png?api=v2" class="confluence-embedded-image image-left" width="578" /></span>

1.  **<span colorid="bi7yw4k7ct">Onboarding Checklist</span>**

    1.  <span colorid="kv0u85tdmj">When onboarding a client, what should an Activation Specialist verify before adding the GA4 ID to Builder?</span>

**<span colorid="kge0gvilv3"> Comment: </span>**

<span colorid="t9ibh35eqs">Above steps must be taken properly to add GAID in builder site so that the dealer will be associated with that GA ID</span>

1.  **<span colorid="cjylb557hv">Post-ID Placement Steps</span>**

    1.  <span colorid="yyytkd4hpn">Once the GA4 ID is placed in Builder, what are the next steps in the process?</span>

**<span colorid="gbdwm2dvr8">Comment: </span>**

<span colorid="jaynuj84i5">Once GA Id placed in builder, need to add that ID in the code as I have attached screenshot above, that the GAid should be added in code script.</span>

1.  **<span colorid="i9rjyay5id">GA Account Access</span>**

    1.  <span colorid="nlcldw63mx">Which GA accounts does the development team currently have access to for checking GA4 IDs?</span>

**<span colorid="lzz8d9av4t">Comment: </span>**<span colorid="sxd9ogc6h2"> Below mentioned GA ID’s</span>\
\
<span colorid="jadvfd8jk3">1. ga@ad-ez.com</span>

<span colorid="wphgxzaqvl">2. </span><a href="mailto:3birdsadmin@3birdsmarketing.com" class="external-link" rel="nofollow">3birdsadmin@3birdsmarketing.com</a>

<span colorid="ktz877biub">3. </span><a href="mailto:3birdsadmin2@3birdsmarketing.com" class="external-link" rel="nofollow">3birdsadmin2@3birdsmarketing.com</a>

4\. <a href="mailto:3birdsadmin3@3birds.net" class="external-link" rel="nofollow">3birdsadmin3@3birds.net</a>

1.  **<span colorid="ls8annkm4h">Dealer List Criteria</span>**

    1.  <span colorid="bjh1qdarek">What causes a dealer to appear on the alert weekly </span>**<span colorid="eiiua72v98">Dealers Without Google Account Integration </span>**<span colorid="mw7n66e61q">notification?</span>

    2.  <span colorid="f6nvdi7tfb">For example, the list of dealers on the alert that triggered on Sunday, 07/27/2025 (AZ) does not match the dealers on the list provided on 07/28/2025.</span>

**<span colorid="s6nwvquavc">Comment: </span>**We are checking for dealers whose TrackingID is null or not mapped to any Google account. In such cases, we are unable to pull data from Google Analytics for those specific dealers and as an alert we get the notification for the dealers.
