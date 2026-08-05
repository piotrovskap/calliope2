---
source: DAS Confluence
page_id: 3782279179
title: Lead Engagement Report - Dashboard Details
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3782279179
type: confluence-doc
repulled: 2026-06-09
---

**Lead Engagement Report - Dashboard Details**

**Last Updated: 11/24/2025**

**Data Tables and Fields Summary (only fields in use are noted)**

<div class="table-wrap">

<table class="confluenceTable" data-table-width="760" data-layout="default">
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Table</strong></p></td>
<td class="confluenceTd"><p><strong>Field(s)</strong></p></td>
</tr>
<tr>
<td rowspan="23" class="confluenceTd"><p>dbo.JuiceReporting_LeadPerformance_LeadSourceIndex</p></td>
<td class="confluenceTd"><p>OEMs</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>OwnerName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClientName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadCreateDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadSourceProviderType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleMake</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadIdentifier</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ConvertedLead</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CRMID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastSoldDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadCreateDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>IsOpener</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>IsClicker</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>RecipientID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadSourceProvider</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleModel</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadCreateDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>FirstName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleYear</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClickCount</p></td>
</tr>
</tbody>
</table>

</div>

**Dashboard Views Breakdown**

**Client Filters**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_0_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="564" alt="A screenshot of a website AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Text2

    - “Lead Engagement for @Filters2C”

    - “Identify the most engaged leads by lead provider”

  - Filters2

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections:

      - OEMs: Many as Filters

      - Parent Groups: Up to One as Filters

      - Clients: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Hide counts: On

    - Ingredients –

      - OEMs

        - Formula: OEMs

        - Filter: ClientName != "DAS Technology" AND ClientName != "Ilderton Conversions" AND ClientName != "Ilderton Conversion of Asheville" AND ClientName != "Ilderton Conversion of Charleston" AND ClientName != "Leith Cars" AND ClientName != "Military Auto Source" AND ClientName != "MotorWorld \| MileOne Autogroup" AND ClientName != "MotorWorld Toyota"

      - Parent Groups

        - Formula: OwnerName

      - Clients

        - Formula: ClientName

  - Filters4

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections:

      - Lead Created: Many as Filters

      - Stock Type: Many as Filters

      - Lead Types: Many as Filters

      - Make: Many as Filters

    - Hidden: On

    - Show notes: On

    - Ingredients –

      - Lead Created

        - Formula: LeadCreateDate

        - Time format: %B %-d, %Y

      - Stock Type

        - Formula: DesiredVehicleType

      - Lead Types

        - Formula: LeadSourceProviderType

      - Make

        - Formula: DesiredVehicleMake

**Key metrics**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_1_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a sales report AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Choice5

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Visual style: Default

    - Ingredients –

      - Leads

        - Formula: count_distinct(LeadIdentifier)

        - Number format: ,.0f

      - Sold

        - Formula: count_distinct(if(IsConvertedLead=1 AND CRMID is not null, LeadIdentifier))

        - Number format: ,.0f

      - Vehicle Sale %

        - Formula: count_distinct(if(IsConvertedLead=1 AND CRMID is not null, LeadIdentifier)) / count_distinct(LeadIdentifier)

        - Number format: ,.0%

      - Avg Days to Close

        - Formula: avg(if(IsConvertedLead=1 and LastSoldDate \> LeadCreateDate, datediff(LastSoldDate, LeadCreateDate), if(IsConvertedLead=1 and SaleDate \> LeadCreateDate, datediff(SaleDate, LeadCreateDate))))

        - Number format: ,.0f

      - Email Openers

        - Formula: count_distinct(if(IsOpener = "true", RecipientID, NULL))

        - Number format: ,.0f

      - Email Open %

        - Formula: (count_distinct(if(IsOpener = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

        - Number format: ,.0%

      - Email Clicks

        - Formula: count_distinct(if(IsClicker= "true", RecipientID, NULL))

        - Number format: ,.0f

      - Email Click %

        - Formula: (count_distinct(if(IsClicker = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

        - Number format: ,.0%

**Pie Section**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_2_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a graph AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: No space

- Slices:

  - Pie1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show notes: On

    - Show legend: On

    - Show data as: \# Value

    - Ingredients –

      - Slices –

        - Lead Providers

          - Formula: LeadSourceProvider

      - Measure –

        - Leads

          - Formula: count_distinct(LeadIdentifier)

          - Number format: ,.0f

  - Pie2

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show notes: On

    - Show legend: On

    - Show data as: \# Value

    - Ingredients –

      - Slices –

        - Lead Providers

          - Formula: LeadSourceProvider

      - Measure –

        - Email Opens

          - Formula: count_distinct(if(IsOpener=”true”, RecipientID, NULL))

          - Number format: ,.0f

  - Pie3

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show notes: On

    - Show legend: On

    - Show data as: \# Value

    - Ingredients –

      - Slices –

        - Lead Providers

          - Formula: LeadSourceProvider

      - Measure –

        - Click

          - Formula: count_distinct(if(IsClicker=”true”, RecipientID, NULL))

          - Number format: ,.0f

**Leaderboard Section**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_3_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="496" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Filters1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections:

      - Lead Providers: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Ingredients –

      - Lead Providers

        - Formula: LeadSourceProvider

  - Leaderboard1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filters: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Ranking –

        - Lead Providers

          - Formula: LeadSourceProvider

      - Measures –

        - Lead Count

          - Formula: count_distinct(LeadIdentifier)

          - Number format: ,.0f

        - Email Opens

          - Formula: count_distinct(if(IsOpener = "true", RecipientID, NULL))

          - Number format: ,.0f

        - Open Rate %

          - Formula: (count_distinct(if(IsOpener = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

          - Number format: ,.0%

        - Email Clicks

          - Formula: count_distinct(if(IsClicker= "true", RecipientID, NULL))

          - Number format: ,.0f

        - Email Click %

          - Formula: (count_distinct(if(IsClicker = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

          - Number format: ,.0%

        - Sold

          - Formula: count_distinct(if(IsConvertedLead=1 AND CRMID is not null, LeadIdentifier))

          - Number format: ,.0f

  - Leaderboard2

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filters: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Ranking –

        - Lead Providers

          - Formula: LeadSourceProvider

      - Measures –

        - Lead Count

          - Formula: count_distinct(LeadIdentifier)

          - Number format: ,.0f

        - Open Rate %

          - Formula: (count_distinct(if(IsOpener = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

          - Number format: ,.0%

        - Click Rate %

          - Formula: (count_distinct(if(IsClicker = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

          - Number format: ,.0%

        - Sold

          - Formula: count_distinct(if(IsConvertedLead=1 AND CRMID is not null, LeadIdentifier))

          - Number format: ,.0f

        - Vehicle Sale %

          - Formula: count_distinct(if(IsConvertedLead=1 AND CRMID is not null, LeadIdentifier)) / count_distinct(LeadIdentifier)

          - Number format: ,.0%

**Table Section**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_4_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Table1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Sort column: Lead Providers – A to Z

    - Ingredients –

      - Clients

        - Formula: ClientName

      - Lead Types

        - Formula: LeadSourceProviderType

      - Lead Providers

        - Formula: LeadSourceProvider

      - Leads

        - Formula: count_distinct(LeadIdentifier)

        - Number format: ,.0f

      - Open Rate %

        - Formula: (count_distinct(if(IsOpener = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

        - Number format: ,.0%

      - Email Click %

        - Formula: (count_distinct(if(IsClicker = "true", RecipientID, NULL)) / count_distinct(LeadIdentifier))

        - Number format: ,.0%

      - Sold

        - Formula: count_distinct(if(IsConvertedLead=1 AND CRMID is not null, LeadIdentifier))

        - Number format: ,.0f

**Choosers**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_5_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Choice2

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - Lead Types

        - Formula: LeadSourceProviderType

      - Lead Providers

        - Formula: LeadSourceProvider

      - Model

        - Formula: DesiredVehicleModel

**Bar and Table**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782279179/att_6_for_3782279179.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: No space

- Slices:

  - Bar1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show Legend: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Bars –

        - @Choice2

      - Bar Width –

        - Leads

          - Formula: count_distinct(LeadIdentifier)

          - Number format: ,.0f

  - Table2

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Sort column: \# Leads – High first

    - Ingredients –

      - Lead Providers

        - Formula: LeadSourceProvider

      - Lead Types

        - Formula: LeadSourceProviderType

      - Leads

        - Formula: count_distinct(LeadIdentifier)

        - Number format: ,.0f

      - Email Openers

        - Formula: count_distinct(if(IsOpener = "true", RecipientID, NULL))

        - Number format: ,.0f

      - Email Clicks

        - Formula: count_distinct(if(IsClicker= "true", RecipientID, NULL))

        - Number format: ,.0f

**Details**

- Layout: Columns

- Spacing style: No space

- Slices:

  - Table2

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Hidden: On

    - Sort column: Lead Created – Recent first

    - Ingredients –

      - Lead Created

        - Formula: LeadCreateDate

        - Time format: %B %-d, %Y

      - Full Name

        - Formula: FirstName + “ “ + LastName

      - Lead Types

        - Formula: LeadSourceProviderType

      - Lead Providers

        - Formula: LeadSourceProvider

      - Stock Type

        - Formula: DesiredVehicleType

      - Year

        - Formula: DesiredVehicleYear

      - Make

        - Formula: DesiredVehicleMake

      - Model

        - Formula: DesiredVehicleModel

      - Email Open

        - Formula: IsOpener

      - Email Click

        - Formula: IsClicker

      - Clickcount

        - Formula: ClickCount

        - Number format: ,.0f
