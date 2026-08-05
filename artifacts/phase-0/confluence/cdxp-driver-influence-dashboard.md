---
source: DAS Confluence
page_id: 3782836230
title: CDXP Driver Influence - Dashboard Details
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3782836230
type: confluence-doc
repulled: 2026-06-09
---

**CDXP Driver Influence - Dashboard Details**

**Last Updated: 11/17/2025**

**Data Tables and Fields Summary (only fields in use are noted)**

<div class="table-wrap">

<table class="confluenceTable" data-table-width="760" data-layout="default">
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Table</strong></p></td>
<td class="confluenceTd"><p><strong>Field(s)</strong></p></td>
</tr>
<tr>
<td rowspan="24" class="confluenceTd"><p>dbo.JuiceReporting_NEW_RECIPIENTS</p></td>
<td class="confluenceTd"><p>OEMs</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>OwnerName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClientName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClientID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SentDateTime</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ProductName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SendType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TotalDelivered</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TotalOpens</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>UniqueOpens</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>UniqueClicks</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TotalClicks</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SalesInfluences</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ServiceInfluences</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TotalVistiors</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TotalPageViews</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Service_RO_Sum</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CPROTotal_Sum</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>WPROTotal_Sum</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>BackGrossSum</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>FrontGrossSum</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SendName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CampaignStartDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CampaignEndDate</p></td>
</tr>
<tr>
<td rowspan="4" class="confluenceTd"><p>dbo.JuiceReporting_TRANSACTION_SUMMARY</p></td>
<td class="confluenceTd"><p>TransactionType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TransactionDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Gross</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Total_Transactions</p></td>
</tr>
<tr>
<td rowspan="17" class="confluenceTd"><p>dbo.JuiceReporting_MatchBacks</p></td>
<td class="confluenceTd"><p>EmailAddress</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>FirstName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ProductName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CampaignName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SendType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SendSubject</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TransactionType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SentDateTime</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TransactionDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DaysToClose</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClientID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>VehicleVIN</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>VehicleType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClientName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SalesRevenue</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ServiceRevenue</p></td>
</tr>
</tbody>
</table>

</div>

**Dashboard Views Breakdown**

**Select Client**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_0_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="462" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No Space

- Shadows: Off

- Slices:

  - Text4

    - “CDXP Driver Influence”

    - “Sales and Service Revenue Influenced and Website Traffic Driven by Emails”

  - Filters2

    - Data Table: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections:

      - OEMS: Many as Filters

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

        - Formula: ClientName + “ (“ + string(ClientID) + “)”

        - Id Field: ClientID

  - Filters6

    - Data Table: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections:

      - OEMS: Many as Filters/Variables

      - Parent Groups: Many as Filters/Variables

      - Clients: Many as Filters/Variables

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Ingredients –

      - Send Dates

        - Formula: SentDateTime

        - Time format: %b %-d %Y

      - Product Names

        - Formula: ProductName

      - Types

        - Formula: SendType

  - Choice7

    - Data Table: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections: as Variables

    - Hidden: On

    - Show notes: On

    - Ingredients –

      - Min Filter Date

        - Formula: min(“{{SentDateTime_between_raw\[0\]\[‘id’\]}}”)

        - Number format: .3s

  - Choice8

    - Data Table: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections: as Variables

    - Hidden: On

    - Show notes: On

    - Ingredients –

      - Max Filter Date

        - Formula: max(“{{SentDateTime_between_raw\[1\]\[‘id’\]}}”)

        - Number format: .3s

**Hidden Tables**

- Layout: Stacked

- Spacing style: No Space

- Shadows: Off

- Slices:

  - Table5

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: Many as Filters

    - Hidden: On

    - Sort Column: Min Send Date – Low First

    - Ingredients –

      - Min Filter Date

        - Formula: min(“{{SentDateTime_between_raw\[0\]\[‘id’\]}}”)

        - Number format: .3s

      - Max Filter Date

        - Formula: max(“{{SentDateTime_between_raw\[1\]\[‘id’\]}}”)

        - Number format: .3s

      - Min Send Date

        - Formula: min(SentDateTime)

        - Number format: %b %-d, %Y

      - Max Send Date

        - Formula: max(SentDateTime)

        - Number format: %b %-d, %Y

      - Total Delivered

        - Formula: sum(TotalDelivered)

        - Number format: ,.0f

      - Total Opens

        - Formula: sum(TotalOpens)

        - Number format: .3s

      - Total Open Rate

        - Formula: sum(TotalOpens) / sum(TotalDelivered)

        - Number format: ,.1%

      - Opened

        - Formula: sum(UniqueOpens) / sum(TotalDelivered)

        - Number format: ,.1%

      - Clicked

        - Formula: sum(UniqueClicks) / sum(UniqueOpens)

        - Number format: ,.1%

      - CTO Rate

        - Formula: sum(TotalClicks) / sum(TotalOpens)

        - Number format: ,.1%

      - Converted

        - Formula: (sum(if(SalesInfluences is null, 0, SalesInfluences)) + sum(if(ServiceInfluences is null, 0, ServiceInfluences))) / sum(TotalDelivered)

        - Number format: ,.1%

      - Unique Clicks

        - Formula: sum(UniqueClicks)

        - Number format: ,.0f

      - Unique Opens

        - Formula: sum(UniqueOpens)

        - Number format: ,.0f

      - Website Visitors

        - Formula: sum(TotalVistiors)

        - Number format: ,.0f

      - Total Page Views

        - Formula: sum(TotalPageViews)

        - Number format: ,.0f

      - Converted

        - Formula: sum(if(SalesInfluences is null, 0, SalesInfluences)) + sum(if(ServiceInfluences is null, 0, ServiceInfluences))

        - Number format: ,.0f

  - Table7

    - Data Table: JuiceReporting_TRANSACTION_SUMMARY

    - Selections: Off

    - Hidden: On

    - Sort Column: Service Gross – Low First

    - Ingredients –

      - Service Gross

        - Formula: sum(if(TransactionType = "Service" and date(TransactionDate) \>= "{{Choice7_raw\[0\]\['value'\]}}" and date(TransactionDate) \<= "{{Choice8_raw\[0\]\['value'\]}}", gross))

        - Number format: \$,.0f

      - Tota Service Transactions

        - Formula: sum(if(TransactionType = "Service" and date(TransactionDate) \>= "{{Choice7_raw\[0\]\['value'\]}}" and date(TransactionDate) \<= "{{Choice8_raw\[0\]\['value'\]}}", Total_Transactions))

        - Number format: ,.0f

      - Sales Gross

        - Formula: sum(if(TransactionType = "Sales" and date(TransactionDate) \>= "{{Choice7_raw\[0\]\['value'\]}}" and date(TransactionDate) \<= "{{Choice8_raw\[0\]\['value'\]}}", gross))

        - Number format: \$,.0f

      - Tota Sales Transactions

        - Formula: sum(if(TransactionType = "Sales" and date(TransactionDate) \>= "{{Choice7_raw\[0\]\['value'\]}}" and date(TransactionDate) \<= "{{Choice8_raw\[0\]\['value'\]}}", Total_Transactions))

        - Number format: ,.0f

  - Table8

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: Many as Filters

    - Hidden: On

    - Sort Column: Min Send Date – Low First

    - Ingredients –

      - Min Filter Date

        - Formula: min(“{{SentDateTime_between_raw\[0\]\[‘id’\]}}”)

        - Number format: .3s

      - Max Filter Date

        - Formula: max(“{{SentDateTime_between_raw\[1\]\[‘id’\]}}”)

        - Number format: .3s

      - Min Send Date

        - Formula: min(SentDateTime)

        - Number format: %b %-d, %Y

      - Max Send Date

        - Formula: max(SentDateTime)

        - Number format: %b %-d, %Y

      - Service Ros

        - Formula: sum(ServiceInfluences)

        - Number format: ,.0f

      - Service Revenue

        - Formula: sum(Service_RO_Sum)

        - Number format: \$,.0f

      - CPRO Revenue

        - Formula: sum(CPROTotal_Sum)

        - Number format: \$,.0f

      - WPRO Revenue

        - Formula: sum(WPROTotal_Sum)

        - Number format: \$,.0f

      - Sales

        - Formula: sum(SalesInfluences)

        - Number format: ,.0f

      - Sales Revenue

        - Formula: sum(BackGrossSum + FrontGrossSum)

        - Number format: \$,.0f

      - BackGrossSum

        - Formula: sum(BackGrossSum)

        - Number format: .3s

      - FrontGrossSum

        - Formula: sum(FrontGrossSum)

        - Number format: .3s

      - Total Rows

        - Formula: sum(1)

        - Number format: ,.0f

**Measures**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_1_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="625" /></span>

- Layout: Stacked

- Spacing style: No Space

- Shadows: Off

- Slices:

  - Choice2

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Ingredients –

      - Service ROs

        - Formula: sum(ServiceInfluences)

        - Number format: ,.0f

      - Service Revenue

        - Formula: sum(Service_RO_Sum)

        - Number format: \$,.0f

  - Choice4

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Ingredients –

      - Sales

        - Formula: sum(SalesInfluences)

        - Number format: ,.0f

      - Sales Revenue

        - Formula: sum(BackGrossSum + FrontGrossSum)

        - Number format: \$,.0f

  - Choice5

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Ingredients –

      - Website Visitors

        - Formula: sum(TotalVistiors)

        - Number format: ,.0f

      - Total Delivered

        - Formula: sum(TotalDelivered)

        - Number format: ,.0f

**Measure Text**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_2_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A close-up of a computer screen AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: Dense

- Shadows: On

- Slices:

  - Text2

    - Custom setup

  - Text 3

    - Custom setup

  - Text4

    - Custom setup

**Bar Charts**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_3_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: Dense

- Shadows: On

- Slices:

  - Bar1

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show legend: On

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Send Months

          - Formula: SentDateTime

          - Time format: %B %Y

      - Bars –

        - Service Revenue

          - Formula: sum(Service_RO_Sum)

          - Number format: \$,.0f

        - Sales Revenue

          - Formula: sum(BackGrossSum + FrontGrossSum)

          - Number format: \$,.0f

  - Bar2

    - Data Table: JuiceReporting_NEW_RECIPIENTS

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show legend: On

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Product Names

          - Formula: ProductName

          - Time format: %B %Y

      - Bars –

        - Service Revenue

          - Formula: sum(Service_RO_Sum)

          - Number format: \$,.0f

        - Sales Revenue

          - Formula: sum(BackGrossSum + FrontGrossSum)

          - Number format: \$,.0f

**Insights**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_4_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="496" alt="A screenshot of a computer screen AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Choice6

    - Data Table: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections: as Filters

    - Hidden: On

    - Show notes: On

    - Ingredients –

      - Product Names

        - Formula: ProductName

      - Types

        - Formula: SendType

  - Leaderboard2

    - DataTable: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Ranking –

        - @Choice6

      - Measures –

        - Total Revenue

          - Formula: sum(Service_RO_Sum + BackGrossSum + FrontGrossSum)

          - Number format: \$,.0f

        - Converted

          - Formula: (sum(if(SalesInfluences is null, 0, SalesInfluences)) + sum(if(ServiceInfluences is null, 0, ServiceInfluences))) / sum(TotalDelivered)

          - Number format: ,.1%

**Top Communications**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_5_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="421" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Leaderboard1

    - DataTable: dbo.JuiceReporting_NEW_RECIPIENTS

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Ranking –

        - Send Names

          - Formula: SendName

      - Measures –

        - Total Delivered

          - Formula: sum(TotalDelivered)

          - Number format: ,.0f

        - Sales

          - Formula: sum(SalesInfluences)

          - Number format: ,.0f

        - Sales Revenue

          - Formula: sum(BackGrossSum + FrontGrossSum)

          - Number format: \$,.0f

        - Service ROs

          - Formula: sum(ServiceInfluences)

          - Number format: ,.0f

        - Service Revenue

          - Formula: sum(Service_RO_Sum)

          - Number format: \$,.0f

        - Website Visitors

          - Formula: sum(TotalVistiors)

          - Number format: ,.0f

**Campaign Details Banner**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_6_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="469" alt="A close-up of a sign AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Text7

    - “Campaign Details”

**Campaign Details**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3782836230/att_7_for_3782836230.png?api=v2" class="confluence-embedded-image image-left" width="510" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Table3

    - Data table: dbo.JuiceReporting_NEW_RECIPIENTS

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Sort column: CampaignStartDate – Recent first

    - Ingredients –

      - CampaignStartDate

        - Formula: CampaignStartDate

        - Time format: %B %-d, %Y

      - CampaignEndDate

        - Formula: CampaignEndDate

        - Time format: %B %-d, %Y

      - Product Names

        - Formula: ProductName

      - Types

        - Formula: SendType

      - ClientName

        - Formula: ClientName

      - Send Names

        - Formula: SendName

      - Send Dates

        - Formula: SentDateTime

        - Time format: %b %-d %Y

      - Total Delivered

        - Formula: sum(TotalDelivered)

        - Number format: ,.0f

      - Sales

        - Formula: sum(SalesInfluences)

        - Number format: ,.0f

      - Sales Revenue

        - Formula: sum(BackGrossSum + FrontGrossSum)

        - Number format: \$,.0f

      - Service ROs

        - Formula: sum(ServiceInfluences)

        - Number format: ,.0f

      - Service Revenue

        - Formula: sum(Service_RO_Sum)

        - Number format: \$,.0f

      - Website Visitors

        - Formula: sum(TotalVistiors)

        - Number format: ,.0f

**Hidden Matchback Table**

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Table10

    - Data table: dbo.JuiceReporting_MatchBacks

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Hidden: On

    - Sort column: TransactionType – A to Z

    - Ingredients –

      - EmailAddress

        - Formula: EmailAddress

      - FirstName

        - Formula: FirstName

      - LastName

        - Formula: LastName

      - ProductName

        - Formula: ProductName

      - Campaign

        - Formula: CampaignName

      - Type

        - Formula: SendType

      - SendSubject

        - Formula: SendSubject

      - TransactionType

        - Formula: TransactionType

      - SentDateTime

        - Formula: SentDateTime

        - Time format: %B %-d, %Y

      - TransactionDate

        - Formula: TransactionDate

        - Time format: %B %-d, %Y

      - DaysToClose

        - Formula: DaysToClose

        - Number format: .3s

      - ClientID

        - Formula: Clientid

        - Number format: .0f

      - Vehicle VIN

        - Formula: VehicleVIN

      - Vehicle Types

        - Formula: VehicleTypes

      - Clientname

        - Formula: Clientname

      - Salesrevenue

        - Formula: SalesRevenue

        - Number format: .3s

      - Servicerevenue

        - Formula: ServiceRevenue

        - Number format: .3s
