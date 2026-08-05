---
source: DAS Confluence
page_id: 3783032834
title: CDXP Overview - Dashboard Details
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3783032834
type: confluence-doc
repulled: 2026-06-09
---

**CDXP Overview - Dashboard Details**

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
<td rowspan="14" class="confluenceTd"><p>dbo.JuiceReporting_BlueSkyOverview</p></td>
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
<td class="confluenceTd"><p>LeadCreateDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ContactType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>IsFirstSubmittedLead</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CRMID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>IsOwnedVehicle</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CustomerType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EDW_DMS_Customer_ID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EDW_DMS_Vehicle_ID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadStatusType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadSourceType</p></td>
</tr>
<tr>
<td rowspan="3" class="confluenceTd"><p>dbo.DMS_Dim_Transactions</p></td>
<td class="confluenceTd"><p>TransactionTypeID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TransactionDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EDW_DMS_Transaction_ID</p></td>
</tr>
<tr>
<td rowspan="3" class="confluenceTd"><p>dbo.JuiceReporting_BlueSkyOverview_v2</p></td>
<td class="confluenceTd"><p>TransactionTypeID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>TransactionDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ROAmount</p></td>
</tr>
</tbody>
</table>

</div>

**Dashboard Views Breakdown**

**Filters**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783032834/att_0_for_3783032834.png?api=v2" class="confluence-embedded-image image-left" width="544" alt="A screenshot of a website AI-generated content may be incorrect." /></span>

- Layout: Custom

  - “Text2 Text2”\
    “Filters2 Filters4”\
    “Choice4 Choice4”

- Spacing style: No space

- Slices:

  - Text2

    - “CDXP Overview for @Filters2C”

  - Filters2

    - Data Table: dbo.JuiceReporting_BlueSkyOverview

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

        - Formula: ClientName + " (" + string(ClientID) + ")"

  - Filters4

    - Data Table: dbo.JuiceReporting_BlueSkyOverview

    - Selections:

      - Lead Create Dates: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Ingredients –

      - Lead Create Dates

        - Formula: LeadCreateDate

        - Time format: %b %-d, %Y

  - Choice4

    - Data Table: dbo.JuiceReporting_BlueSkyOverview

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Visual style: 2 Columns

    - Ingredients –

      - Leads

        - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead, string(CRMID), if(ContactType != "Prospects" and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

        - Number format: ,.0f

      - Sales

        - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead and LeadStatusType = "Sold", string(CRMID), if(ContactType in ("Sold", "Retention") and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

        - Number format: ,.0f

      - Conversion Rate

        - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead and LeadStatusType = "Sold", string(CRMID), if(ContactType in ("Sold", "Retention") and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID)))) / count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead, string(CRMID), if(ContactType != "Prospects" and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

        - Number format: ,.0%

**Leads**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783032834/att_1_for_3783032834.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: Dense

- Shadows: On

- Slices:

  - Bar2

    - Data Table: dbo.JuiceReporting_BlueSkyOverview

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show Legend: On

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Lead Source Types

          - Formula: LeadSourceType

          - Filter: LeadSourceType != “\*Other/Unknown”

      - Bars

        - Leads

          - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead, string(CRMID), if(ContactType != "Prospects" and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

          - Number format: ,.0f

        - Sales

          - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead and LeadStatusType = "Sold", string(CRMID), if(ContactType in ("Sold", "Retention") and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

          - Number format: ,.0f

  - Trend4

    - Data Table: dbo.JuiceReporting_BlueSkyOverview

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show Legend: On

    - Ingredients –

      - Dates –

        - Lead Create Dates

          - Formula: LeadCreateDate

          - Time format: %B %Y

      - Y Axis –

        - Leads

          - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead, string(CRMID), if(ContactType != "Prospects" and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

          - Number format: ,.0f

      - Second Y Axis –

        - Conversion Rate

          - Formula: count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead and LeadStatusType = "Sold", string(CRMID), if(ContactType in ("Sold", "Retention") and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID)))) / count_distinct(if(ContactType = "Prospects" and IsFirstSubmittedLead, string(CRMID), if(ContactType != "Prospects" and IsOwnedVehicle and CustomerType = "Individual", string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID))))

          - Number format: ,.0%

**Sales**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783032834/att_2_for_3783032834.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: Dense

- Shadows: On

- Slices:

  - Choice5

    - Data Table: dbo.DMS_Dim_Transactions

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Visual style: Comparisons

    - Ingredients –

      - Sales MTD

        - Formula: sum(if(TransactionTypeID = 1 and TransactionDate IS THIS MTD, 1))

        - Number format: ,.0f

      - Sales YTD

        - Formula: sum(if(TransactionTypeID = 1 and TransactionDate IS THIS YTD, 1))

        - Number format: ,.0f

  - Trend5

    - Data Table: dbo.DMS_Dim_Transactions

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show Legend: On

    - Ingredients –

      - Dates –

        - Transaction Dates

          - Formula: TransactionDate

          - Filter: TransactionDate BETWEEN “2 YEARS AGO” and “TODAY”

          - Time format: %B %Y

      - Y Axis –

        - Sales

          - Formula: count_distinct(if(TransactionTypeID = 1, EDW_DMS_Transaction_ID))

          - Number format: ,.0f

**Service**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783032834/att_3_for_3783032834.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: Dense

- Shadows: On

- Slices:

  - Choice6

    - Data Table: dbo.JuiceReporting_BlueSkyOverview_v2

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Visual style: Comparisons

    - Ingredients –

      - Service MTD

        - Formula: sum(if(TransactionTypeID = 2 and TransactionDate IS THIS MTD, ROAmount))

        - Number format: \$,.0f

      - Service YTD

        - Formula: sum(if(TransactionTypeID = 2 and TransactionDate IS THIS YTD, ROAmount))

        - Number format: \$,.0f

  - Trend6

    - Data Table: dbo.JuiceReporting_BlueSkyOverview_v2

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show Legend: On

    - Ingredients –

      - Dates –

        - Transaction Dates

          - Formula: TransactionDate

          - Time format: %B %Y

      - Y Axis –

        - Service

          - Formula: sum(if(TransactionTypeID = 2, ROAmount))

          - Number format: \$,.0f
