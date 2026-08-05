---
source: DAS Confluence
page_id: 3783262209
title: CDXP Leads - Dashboard Details
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3783262209
type: confluence-doc
repulled: 2026-06-09
---

**CDXP Leads - Dashboard Details**

**Last Updated: 2/11/2026**

**Data Tables and Fields Summary (only fields in use are noted)**

<div class="table-wrap">

<table class="confluenceTable" data-table-width="760" data-layout="default">
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Table</strong></p></td>
<td class="confluenceTd"><p><strong>Field(s)</strong></p></td>
</tr>
<tr>
<td rowspan="19" class="confluenceTd"><p>dbo.JuiceReporting_LeadPerformance_LeadSourceIndex</p></td>
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
<td class="confluenceTd"><p>DesiredVehicleMake</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadIdentifier</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>CRMID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastSoldDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleModel</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>FirstName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleYear</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>IsConvertedLead</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LeadStatus</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EmailAddress</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>PhoneNumber</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ZipCode</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastServiceDate</p></td>
</tr>
</tbody>
</table>

</div>

**Dashboard Views Breakdown**

**Client Filters**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783262209/att_0_for_3783262209.png?api=v2" class="confluence-embedded-image image-left" width="625" /></span>

- Layout: Header/Columns

- Spacing style: Dense

- Slices:

  - Text1

    - “Leads Overview for @Filters2C”

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

      - Parent Groups

        - Formula: OwnerName

      - Clients

        - Formula: ClientName

  - Filters4

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections:

      - Lead Create Dates: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Ingredients –

      - Lead Create Dates

        - Formula: LeadCreateDate

        - Time format: %-m/%-d/%Y

**Leads to Work**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783262209/att_1_for_3783262209.png?api=v2" class="confluence-embedded-image image-center" width="353" /></span>

- Layout: Custom

  - "Text4 Text4"

"Choice4 Choice4"

"Map1 Map1"

"Bar3 Bar1"

"Table1 Table1"

- Spacing style: Dense

- Slices:

  - Text4

    - “Leads to Work”

  - Choice4

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - \# of Leads

        - Formula: count_distinct(LeadIdentifier)

        - Number format: ,.0f

      - \# of Active Leads

        - Formula: count_distinct(if(\[LeadStatus\] = "Open" OR \[LeadStatus\] = "In Progress" OR \[LeadStatus\] = "Service Appointment Scheduled", \[LeadIdentifier\]))

        - Number format: ,.0f

      - Active Lead %

        - Formula: (count_distinct(if(\[LeadStatus\] = "Open" OR \[LeadStatus\] = "In Progress" OR \[LeadStatus\] = "Service Appointment Scheduled", \[LeadIdentifier\]))) / (count_distinct(LeadIdentifier))

        - Number format: .2%

      - Avg. Active Lead Age (Days)

        - Formula: avg(if((\[LeadStatus\] = "Open" OR \[LeadStatus\] = "In Progress" OR \[LeadStatus\] = "Service Appointment Scheduled"), (datediff(date("TODAY"), \[LeadCreateDate\]))))

        - Number format: ,.0f

  - Bar3

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Show Legend: Off

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Working Statuses

          - Formula: LeadStatus

          - Filter: \[LeadStatus\] = "Open" OR \[LeadStatus\] = "In Progress" OR \[LeadStatus\] = "Service Appointment Scheduled"

      - Bars –

        - \# of Leads

          - Formula: count_distinct(\[LeadIdentifier\])

          - Number format: ,.0f

  - Bar1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Show Legend: Off

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Desired Vehicles

          - Formula: DesiredVehicleMake + " " + DesiredVehicleModel

      - Bars –

        - Desired Vehicle Leads

          - Formula: count_distinct(if((\[DesiredVehicleMake\] IS NOT NULL) AND (\[LeadStatus\] = "Open" OR \[LeadStatus\] = "In Progress" OR \[LeadStatus\] = "Service Appointment Scheduled"), \[LeadIdentifier\]))

          - Number format: ,.0f

  - Map1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: On

    - Show Legend: On

    - Show notes: On

    - Visual Style: Standard

    - Ingredients –

      - Places –

      - Color –

  - Table1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Filters applied footnote: On

    - Sort column: Lead Create Dates – Recent first

    - Ingredients –

      - CRM IDs

        - Formula: CRMID

        - Number format: .0f

      - Working Statuses

        - Formula: LeadStatus

        - Filter: \[LeadStatus\] = "Open" OR \[LeadStatus\] = "In Progress" OR \[LeadStatus\] = "Service Appointment Scheduled"

      - Lead Create Dates

        - Formula: LeadCreateDate

        - Time format: %-m/%-d/%Y

      - Lead Age (Days)

        - Formula: datediff(date(“TODAY”), LeadCreateDate)

        - Number format: .3s

      - Lead Names

        - Formula: FirstName + “ “ + LastName

      - Email Addresses

        - Formula: EmailAddress

      - Phone Numbers

        - Formula: PhoneNumber

      - Zip Codes

        - Formula: ZipCode

      - Desired Vehicles

        - Formula: \[DesiredVehicleType\] + " " + \[DesiredVehicleYear\] + " " + \[DesiredVehicleMake\] + " " + \[DesiredVehicleModel\]

**Converted Leads**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783262209/att_2_for_3783262209.png?api=v2" class="confluence-embedded-image image-center" width="414" /></span>

- Layout: Stacked

- Spacing style: Dense

- Slices:

  - Text5

    - “Lead Performance”

  - Choice5

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - \# of Leads

        - Formula: count_distinct(LeadIdentifier)

        - Number format: ,.0f

      - \# of Converted Leads

        - Formula: count_distinct(if(\[IsConvertedLead\] = 1, \[LeadIdentifier\]))

        - Number format: ,.0f

      - Conversion Rate

        - Formula: (count_distinct(if(IsConvertedLead=1, LeadIdentifier))) / (count_distinct(LeadIdentifier))

        - Number format: .2%

  - Choice3

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: as Filters

    - Hidden: On

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - Weekly

        - Formula: week(LeadCreateDate)

        - Time format: %-m/%-d/%Y

      - Daily

        - Formula: LeadCreateDate

        - Time format: %-m/%-d/%Y

      - Monthly

        - Formula: LeadCreateDate

        - Time format: %-m/%Y

  - Trend1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Show Legend: On

    - Ingredients –

      - Dates –

        - @Choice3

      - Y Axis –

        - \# of Converted Leads

          - Formula: count_distinct(if(\[IsConvertedLead\] = 1, \[LeadIdentifier\]))

          - Number format: ,.0f

  - Table3

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Filters applied footnote: On

    - Sort column: Last Sold Date – Recent first

    - Ingredients –

      - CRM IDs

        - Formula: CRMID

        - Number format: .0f

      - Lead Create Dates

        - Formula: LeadCreateDate

        - Time format: %-m/%-d/%Y

      - Lead Names

        - Formula: FirstName + “ “ + LastName

      - Email Addresses

        - Formula: EmailAddress

      - Phone Numbers

        - Formula: PhoneNumber

      - Zip Codes

        - Formula: ZipCode

      - Converted Lead

        - Formula: string(IsConvertedLead)

        - Lookups:

          - “0”: “False”\
            “1”: “True”

        - Filter: \[IsConvertedLead\] = 1

      - Last Sold Date

        - Formula: LastSoldDate

        - Time format: %-m/%-d/%Y

      - Last Service Date

        - Formula: LastServiceDate

        - Time format: %-m/%-d/%Y

      - Days to Convert

        - Formula: avg(if(\[VehicleSoldDate\] \> \[LeadCreateDate\], datediff(day(VehicleSoldDate), day(LeadCreateDate)), 0))

        - Number format: ,.0f

**Inactive / Non-Converted Leads**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783262209/att_3_for_3783262209.png?api=v2" class="confluence-embedded-image image-center" width="455" /></span>

- Layout: Stacked

- Spacing style: Dense

- Slices:

  - Card1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Show notes: On

    - Card Style: Large Measure

    - Ingredients –

      - Title –

        - Inactive Statuses

          - Formula: LeadStatus

          - Filter: (\[LeadStatus\] = "Inactive" OR \[LeadStatus\] = "Other") AND IsConvertedLead = 0

      - Additional data

        - \# of Leads

          - Formula: count_distinct(\[LeadIdentifier\])

          - Number format: ,.0f

  - Table1

    - Data Table: dbo.JuiceReporting_LeadPerformance_LeadSourceIndex

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Filter Pill: Off

    - Filters applied footnote: On

    - Sort column: Lead Create Dates – Recent first

    - Ingredients –

      - CRM IDs

        - Formula: CRMID

        - Number format: .0f

      - Inactive Statuses

        - Formula: LeadStatus

        - Filter: (\[LeadStatus\] = "Inactive" OR \[LeadStatus\] = "Other") AND IsConvertedLead = 0

      - Lead Create Dates

        - Formula: LeadCreateDate

        - Time format: %-m/%-d/%Y

      - Lead Names

        - Formula: FirstName + “ “ + LastName

      - Email Addresses

        - Formula: EmailAddress

      - Phone Numbers

        - Formula: PhoneNumber

      - Zip Codes

        - Formula: ZipCode
