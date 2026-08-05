---
source: DAS Confluence
page_id: 718340097
title: Integrations Description
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/718340097
type: confluence-doc
repulled: 2026-06-09
---

The page contains gathered info on the integrations used in the project. Most of the Integrations are described in separate pages with the functions descriptions (the links are provided).

<div class="table-wrap">

<table class="confluenceTable" data-layout="default">
<colgroup>
<col />
<col />
<col />
</colgroup>
<tbody>
<tr>
<th class="confluenceTh"><p>Integration Name</p></th>
<th class="confluenceTh"><p>What used for</p></th>
<th class="confluenceTh"><p>How to Test</p></th>
</tr>
&#10;<tr>
<td class="confluenceTd"><p>Google</p></td>
<td rowspan="2" class="confluenceTd"><p>Calendar sync for appointments</p></td>
<td rowspan="2" class="confluenceTd"><p>Connect in UI<br />
Check that appts are sent to calendar<br />
Check that calendar events influence time available<br />
Token refresh check in the DB</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Outlook</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Facebook</p></td>
<td class="confluenceTd"><p>Receive leads contacted from FB pages. Chatting via Facebook messenger.</p></td>
<td class="confluenceTd"><p>See the <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/686948537/FB+SMS+Chatting" rel="nofollow">FB, SMS chatting</a> page</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Zapier</p></td>
<td rowspan="3" class="confluenceTd"><p>Send Leads from RP to CRM</p></td>
<td rowspan="3" class="confluenceTd"><p>See the <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/686489765/Integrations+leads+delivering" rel="nofollow">Integrations (leads' delivering)</a> page</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>InfusionSoft</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>General Motors</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Credit Logix</p></td>
<td class="confluenceTd"><p>Verify a credit line of a Lead and decide on their buying potential;</p>
<p>and show those Cars that are available for a Lead according to their potential.</p></td>
<td class="confluenceTd"><p>Read path 10 <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/608632933/Bot+Builder" rel="nofollow"><u>here</u></a></p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Review Serge</p></td>
<td class="confluenceTd"><p>RP is responsible for sending Review SMS's to the numbers received from RS</p></td>
<td class="confluenceTd"><p>Use the following request:  <a href="http://paralect.atlassian.net/wiki/download/attachments/1984955210/RS%20Integration.postman_collection.json?version=1&amp;modificationDate=1586872015661&amp;cacheVersion=1&amp;api=v2" class="external-link" rel="nofollow">RS Integration.postman_collection.json</a></p>
<p>Verify the report in Admin. See <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/688422973/Analytics" rel="nofollow">Review Serge Report</a> page</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Twillio</p></td>
<td class="confluenceTd"><p>Send and Receive SMS's to/from Leads </p></td>
<td class="confluenceTd"><p>Trigger SMS sending: See the <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/686948537/FB+SMS+Chatting" rel="nofollow">FB, SMS chatting</a> and <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/686948556/Notification+Templates" rel="nofollow">Notifications templates</a> pages</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Mandrill</p></td>
<td class="confluenceTd"><p>Send Emails to the Users and Leads</p></td>
<td class="confluenceTd"><p>Trigger Email sending: See the <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/686948556/Notification+Templates" rel="nofollow">Notifications templates</a> page</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Inventory Data Service</p></td>
<td class="confluenceTd"><p>Show the Vehicles that are currently available by car dealers</p></td>
<td class="confluenceTd"><p>See the <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/686457101/Inventory" rel="nofollow">Inventory</a> page</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Reviews Service</p></td>
<td class="confluenceTd"><p>Showing of real-time reviews</p></td>
<td class="confluenceTd"><p>Check in UI: add Reviews card to the dashhboard and open EP as a Visitor (see point 7 <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/608665659/Desks%2C+views%2C+cards" rel="nofollow">here</a>)</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Kelley Blue Book</p></td>
<td class="confluenceTd"><p>Calculate trade-in vehicle price</p></td>
<td class="confluenceTd"><p>Check in UI: add Trade-In card to the dashboard and as a Visitor fill out the data. (see point 6 <a href="https://digitalairstrike.atlassian.net/wiki/spaces/DPD/pages/608665659/Desks%2C+views%2C+cards" rel="nofollow">here</a>)</p>
<p>To check via api: run the collection – <a href="http://paralect.atlassian.net/wiki/download/attachments/1984955210/Path-%20KBB.postman_collection.json?version=1&amp;modificationDate=1586866722458&amp;cacheVersion=1&amp;api=v2" class="external-link" rel="nofollow">Path- KBB.postman_collection.json</a></p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Amazon S3</p></td>
<td class="confluenceTd"><p>Cloud storage</p></td>
<td class="confluenceTd"><p>Check in UI the media is correctly displayed (users avatars, file attachments) </p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Mixpanel</p></td>
<td class="confluenceTd"><p>Analyze Users behavior</p></td>
<td class="confluenceTd"><p>–</p></td>
</tr>
</tbody>
</table>

</div>

\
