---
source: DAS Confluence
page_id: 3371663364
title: CDXP - Company Sync Process
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3371663364
type: confluence-doc
repulled: 2026-06-09
---

Project is Located at GitHub Repository <a href="https://github.com/3birdsmarketing/CSharp-Lambda" class="external-link" rel="nofollow">CSharp-Lambda</a>\
Website is located under this URL e.g.: <a href="https://admin.3birdsmarketing.com/Builder/Sites/View/7708" class="external-link" rel="nofollow">https://admin.3birdsmarketing.com/Builder/Sites/View/7708</a>\
Choose the `Text Override` Option:

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3371663364/image-20250618-145837.png?api=v2" class="confluence-embedded-image image-left" width="340" alt="image-20250618-145837.png" /></span>

Below are the steps in order to implement a new field for Company Sync Process:

- Add New field in the Text Override Feature

- Add the new parameter into the Model Class (For example`CreateCompanyField.cs)`

- Update the respective `stored procedure` in the DB (That depends on what data the new field will get, because this ticket does not specify what the field will be about)

  - Contact <a href="https://digitalairstrike.atlassian.net/wiki/people/712020:e22fc719-ee5d-4bb1-8848-beb20c9dc7b3?ref=confluence" class="confluence-userlink user-mention" data-account-id="712020:e22fc719-ee5d-4bb1-8848-beb20c9dc7b3" target="_blank" data-linked-resource-id="2666070255" data-linked-resource-version="1" data-linked-resource-type="userinfo" data-base-url="https://digitalairstrike.atlassian.net/wiki">Krunal Suthar</a> in case of any issues.

- Testing

  - Contact <a href="https://digitalairstrike.atlassian.net/wiki/people/712020:b56bbdc9-a079-425e-8ba8-99a3b1fc8c88?ref=confluence" class="confluence-userlink user-mention" data-account-id="712020:b56bbdc9-a079-425e-8ba8-99a3b1fc8c88" target="_blank" data-linked-resource-id="2730917934" data-linked-resource-version="1" data-linked-resource-type="userinfo" data-base-url="https://digitalairstrike.atlassian.net/wiki">Mihir Someshwara</a>
