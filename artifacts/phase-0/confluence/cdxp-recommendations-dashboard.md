---
source: DAS Confluence
page_id: 3783065609
title: CDXP Recommendations - Dashboard Details
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3783065609
type: confluence-doc
repulled: 2026-06-09
---

**CDXP Recommendations - Dashboard Details**

**Last Updated: 11/9/2025**

**Data Tables and Fields Summary (only fields in use are noted)**

<div class="table-wrap">

<table class="confluenceTable" data-table-width="760" data-layout="default">
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Table</strong></p></td>
<td class="confluenceTd"><p><strong>Field(s)</strong></p></td>
</tr>
<tr>
<td rowspan="44" class="confluenceTd"><p>dbo.JuiceReporting_BlueSkyRecommendations</p></td>
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
<td class="confluenceTd"><p>ContactType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EDW_DMS_Customer_ID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EDW_DMS_Vehicle_ID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>HasEmail</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>HasAddress</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>HasPhone</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Est_Lease_Penalty</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EquityValueRough</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedServiceDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ScheduledServiceDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Last_Open</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>RecipientID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Opener</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Last_Click</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Clicker</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Last_Page_Visit</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Latest_Inventory_Visit</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Lease_End</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Warranty_End</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Contract_End</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Upcoming_Service_Appointment</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Declined_Service_T_F</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>FirstName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EmailAddress</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>PhoneNumber</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>VehicleYear</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>VehicleMake</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>VehicleModel</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EstimatedMileage</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastServiceDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SoldDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleYear3Birds</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleMake3Birds</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DesiredVehicleModel3Birds</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedService1Code</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedService2Code</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedService3Code</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedService4Code</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedService5Code</p></td>
</tr>
</tbody>
</table>

</div>

**Dashboard Views Breakdown**

**Overview**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_0_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a website AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: Dense

- Shadows: Off

- Slices:

  - Text4

    - “CDXP Recommendations”

    - “Find customers who are motivated for a purchase or service”

  - Filters6

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Filters: On

    - Selections:

      - OEMS: Many as Filters

      - Parent Groups: Up to One as Filters

      - Clients: Many as Filters

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

  - Card13

    - Data Table: JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Chart: Off

    - Show Filter Pill: Off

    - Show note: On

    - Show button to load more: On

    - Selections: Many as Filters

    - Card style: Large measure

    - Ingredients –

      - Title –

        - Contact Types

          - Formula: ContactType

          - Buckets:

            - label: Prospects\
              condition: in(“Prospects”, “Prospect”)

            - label: Sold\
              condition: in(“Sold”, “Sales”)

            - label: Service\
              condition: = “Service”

            - label: Retention\
              condition: in(“Retention”, “Sales and Service”)

            - default label: Other

      - Secondary Data –

        - Count

          - Formula: count_distinct(if(ContactType = “Retention”, string(EDW_DMS_Customer_ID) + string(EDW_DMS_Vehicle_ID), string(EDW_DMS_Customer_ID)))

          - Number format: ,.0f

**Contact Title**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_1_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A close up of a sign AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Text1

    - “Contact Information Quality”

**Contact Bars**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_2_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A blue rectangular object with black text AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: No space

- Slices:

  - Bar5

    - Data Table: JuiceReporting_BlueSkyRecommendations

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show legend: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Bars

        - Email

          - Formula: HasEmail

          - Buckets:

            - label: Have email address\
              condition: = “True”

            - Default label: Missing email address

      - Bar width

        - Leads

          - Formula: count_distinct(EDW_DMS_Customer_ID)

          - Number format: ,.0f

  - Bar3

    - Data Table: JuiceReporting_BlueSkyRecommendations

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show legend: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Bars

        - Postal Address

          - Formula: HasAddress

          - Buckets:

            - label: Have address\
              condition: = “True”

            - Default label: Missing address

      - Bar width

        - Leads

          - Formula: count_distinct(EDW_DMS_Customer_ID)

          - Number format: ,.0f

  - Bar4

    - Data Table: JuiceReporting_BlueSkyRecommendations

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show legend: On

    - Show controls: On

    - Show notes: On

    - Ingredients –

      - Bars

        - Postal Address

          - Formula: HasPhone

          - Buckets:

            - label: Have phone number\
              condition: = “True”

            - Default label: Missing phone number

      - Bar width

        - Leads

          - Formula: count_distinct(EDW_DMS_Customer_ID)

          - Number format: ,.0f

**Text Section**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_3_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A close up of a sign AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Text7

    - “Drill Down”

**Hidden Filters**

- Layout: Columns

- Spacing style: No space

- Slices:

  - Table4

    - Data Table: Date Filter Options (Excel)

    - Hidden: On

    - Selections: One as Variables

    - Enable download: No

    - Sort column: Engaged Within

    - Ingredients –

      - Engaged within

        - field: Date_Filter_Label

        - filter: Engagement_Flag = 1

        - id_field: Date_Filter

        - order_by_field: Engagement_Order

  - Table5

    - Data Table: Date Filter Options (Excel)

    - Hidden: On

    - Selections: One as Variables

    - Enable download: No

    - Sort column: Lease expiring in

    - Ingredients –

      - Lease expiring in

        - field: Date_Filter_Label

        - filter: Lease_Expiration_Flag = 1

        - id_field: Date_Filter

  - Table6

    - Data Table: Date Filter Options (Excel)

    - Hidden: On

    - Selections: One as Variables

    - Enable download: No

    - Sort column: Warranty expiring in

    - Ingredients –

      - Warranty expiring in

        - field: Date_Filter_Label

        - filter: Warranty_Expiration_Flag = 1

        - id_field: Date_Filter

  - Table7

    - Data Table: Date Filter Options (Excel)

    - Hidden: On

    - Selections: One as Variables

    - Enable download: No

    - Sort column: Contract expiring in

    - Ingredients –

      - Contract ending in

        - field: Date_Filter_Label

        - filter: Contract_Ends_Flag = 1

        - id_field: Date_Filter

  - Filters11

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Hidden: On

    - Selections:

      - Estimated Lease Penalty: Many as Variables

      - Estimated Equity: Many as Variables

      - Declined Service Dates: Many as Variables

    - Show notes: On

    - Hide counts: Off

    - Ingredients –

      - Estimated Lease Penalty

        - Formula: Est_Lease_Penalty

        - Number format: \$,.0f

        - Id Field: Est_Lease_Penalty

      - Estimated Equity

        - Formula: int(if(EquityValueRough \> 0, EquityValueRough))

        - Number format: \$,.0f

        - Id Field: int(if(EquityValueRough \> 0, EquityValueRough))

      - Declined Service Dates

        - Formula: DeclinedServiceDate

        - Time format: %b %-d %Y

**“OR” Measures**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_4_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a chat AI-generated content may be incorrect." /></span>

- Layout: Columns

- Spacing style: No space

- Slices:

  - Choice1

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Chart: On

    - Selections: as Filters

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - Openers

        - Formula: count_distinct(if(Last_Open BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID)) + avg(coalesce(opener, 0))

        - Number format: ,.0f

      - Clickers

        - Formula: count_distinct(if(Last_Click BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID)) + avg(coalesce(clicker, 0))

        - Number format: ,.0f

      - Website Visitors

        - Formula: count_distinct(if(Last_Page_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID))

        - Number format: ,.0f

      - Inventory Visitors

        - Formula: count_distinct(if(Latest_Inventory_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID))

        - Number format: ,.0f

  - Choice3

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Chart: On

    - Selections: as Filters

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - Lease Expiring

        - Formula: count_distinct(if(Lease_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb}}", EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - At-Risk Lease Penalty

        - Formula: count_distinct(if(datediff(date("TODAY"), Lease_End, MONTH) \< 12 and datediff(date("TODAY"), Lease_End, DAY) \> 0 and Est_Lease_Penalty between {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}}, EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - Warranty Expiring

        - Formula: count_distinct(if(Warranty_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j}}", EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - Contract Ending

        - Formula: count_distinct(if(Contract_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j_a9thjxuw}}", EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - Upcoming Service Appointment

        - Formula: coalesce(count_distinct(if(Upcoming_Service_Appointment = "True", EDW_DMS_Customer_ID)), 0)

        - Number format: ,.0f

      - Declined Service

        - Formula: coalesce(count_distinct(if(Declined_Service_T_F = "True" and DeclinedServiceDate between date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2000-01-01T00:00:00'}\], true)\|first).id}}") and date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2100-12-31T00:00:00'}\], true)\|last).id}}"), EDW_DMS_Customer_ID)), 0)

        - Number format: ,.0f

      - Positive Equity

        - Formula: coalesce(count_distinct(if(EquityValueRough between {{(EquityValueRough\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(EquityValueRough\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}} and datediff(date(SoldDate), date("TODAY"), month) \> 12, EDW_DMS_Customer_ID)), 0)

        - Number format: ,.0f

**New Filters**

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Filters10

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Filters: On

    - Selections: Many as Filters

    - Show notes: On

    - Hide counts: On

    - Ingredients –

      - Opened

        - Formula: if(Last_Open BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Opened", "Did not open")

        - Id Field: if(Last_Open BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Opened", "Did not open")

      - Clicked

        - Formula: if(Last_Click BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Clicked", "Did not click")

        - Id Field: if(Last_Click BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Clicked", "Did not click")

      - Visited Website

        - Formula: if(Last_Page_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Visited website", "Did not visit website")

        - Id Field: if(Last_Page_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Visited website", "Did not visit website")

      - Visited Inventory

        - Formula: if(Latest_Inventory_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Visited inventory", "Did not visit inventory")

        - Id Field: if(Latest_Inventory_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", "Visited inventory", "Did not visit inventory")

      - Lease Expiring

        - Formula: if(Lease_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb}}", "Lease expiring", "Lease not expiring")

        - Id Field: if(Lease_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb}}", "Lease expiring", "Lease not expiring")

      - Lease Penalty

        - Formula: if(datediff(date("TODAY"), Lease_End, MONTH) \< 12 and datediff(date("TODAY"), Lease_End, DAY) \> 0 and Est_Lease_Penalty between {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}}, "At risk", "Not at risk")

        - Id Field: if(datediff(date("TODAY"), Lease_End, MONTH) \< 12 and datediff(date("TODAY"), Lease_End, DAY) \> 0 and Est_Lease_Penalty between {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}}, "At risk", "Not at risk")

      - Warranty Expiring

        - Formula: if(Warranty_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j}}", "Warranty expiring", "Warranty not expiring")

        - Id Field: if(Warranty_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j}}", "Warranty expiring", "Warranty not expiring")

      - Contract Ending

        - Formula: if(Contract_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j_a9thjxuw}}", "Contract ending", "Contract not ending")

        - Id Field: if(Contract_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j_a9thjxuw}}", "Contract ending", "Contract not ending")

      - Upcoming Service Appointment

        - Formula: if(Upcoming_Service_Appointment = "True", "Upcoming appointment", "No upcoming appointment")

        - Id Field: if(Upcoming_Service_Appointment = "True", "Upcoming appointment", "No upcoming appointment")

      - Declined Service

        - Formula: if(Declined_Service_T_F = "True" and DeclinedServiceDate between date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2000-01-01T00:00:00'}\], true)\|first).id}}") and date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2100-12-31T00:00:00'}\], true)\|last).id}}"), "Declined service", "Did not decline service")

        - Id Field: if(Declined_Service_T_F = "True" and DeclinedServiceDate between date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2000-01-01T00:00:00'}\], true)\|first).id}}") and date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2100-12-31T00:00:00'}\], true)\|last).id}}"), "Declined service", "Did not decline service")

      - Positive Equity

        - Formula: if(EquityValueRough between {{(EquityValueRough\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(EquityValueRough\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}} and datediff(date(SoldDate), date("TODAY"), month) \> 12, "Positive equity", "No positive equity")

        - Id Field: if(EquityValueRough between {{(EquityValueRough\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(EquityValueRough\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}} and datediff(date(SoldDate), date("TODAY"), month) \> 12, "Positive equity", "No positive equity")

**“AND” Measures**

- Layout: Columns

- Spacing style: No space

- Slices:

  - Choice5

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Chart: On

    - Selections: as Filters

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - Openers

        - Formula: count_distinct(if(Last_Open BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID)) + avg(coalesce(opener, 0))

        - Number format: ,.0f

      - Clickers

        - Formula: count_distinct(if(Last_Click BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID)) + avg(coalesce(clicker, 0))

        - Number format: ,.0f

      - Website Visitors

        - Formula: count_distinct(if(Last_Page_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID))

        - Number format: ,.0f

      - Inventory Visitors

        - Formula: count_distinct(if(Latest_Inventory_Visit BETWEEN "{{Date_Filter_Label_bybkewnn}}" and "TODAY", RecipientID))

        - Number format: ,.0f

  - Choice6

    - Data Table: dbo.JuiceReporting_BlueSkyRecommendations

    - Show Title: On

    - Show Chart: On

    - Selections: as Filters

    - Show notes: On

    - Visual style: Default

    - Ingredients –

      - Lease Expiring

        - Formula: count_distinct(if(Lease_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb}}", EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - At-Risk Lease Penalty

        - Formula: count_distinct(if(datediff(date("TODAY"), Lease_End, MONTH) \< 12 and datediff(date("TODAY"), Lease_End, DAY) \> 0 and Est_Lease_Penalty between {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(Est_Lease_Penalty\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}}, EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - Warranty Expiring

        - Formula: count_distinct(if(Warranty_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j}}", EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - Contract Ending

        - Formula: count_distinct(if(Contract_End BETWEEN "TODAY" and "{{Date_Filter_Label_bybkewnn_eblsljsb_gz8my88j_a9thjxuw}}", EDW_DMS_Customer_ID))

        - Number format: ,.0f

      - Upcoming Service Appointment

        - Formula: coalesce(count_distinct(if(Upcoming_Service_Appointment = "True", EDW_DMS_Customer_ID)), 0)

        - Number format: ,.0f

      - Declined Service

        - Formula: coalesce(count_distinct(if(Declined_Service_T_F = "True" and DeclinedServiceDate between date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2000-01-01T00:00:00'}\], true)\|first).id}}") and date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2100-12-31T00:00:00'}\], true)\|last).id}}"), EDW_DMS_Customer_ID)), 0)

        - Number format: ,.0f

      - Positive Equity

        - Formula: coalesce(count_distinct(if(EquityValueRough between {{(EquityValueRough\_\_between_raw\|default(\[{'id':0.01}\], true)\|first).id}} and {{(EquityValueRough\_\_between_raw\|default(\[{'id':999999}\], true)\|last).id}} and datediff(date(SoldDate), date("TODAY"), month) \> 12, EDW_DMS_Customer_ID)), 0)

        - Number format: ,.0f

**Contact Details Banner**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_5_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A close-up of a sign AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Text9

    - “Contact Details”

**Contact Details 1**

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783065609/att_6_for_3783065609.png?api=v2" class="confluence-embedded-image image-left" width="625" alt="A screenshot of a computer AI-generated content may be incorrect." /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Table3

    - Data table: JuiceReporting_BlueSkyRecommendations

    - Enable download: On as Excel

    - Selections: One as Filters

    - Show Title: On

    - Show Chart: On

    - Sort Column: Names – A to Z

    - Ingredients –

      - Names

        - Formula: LastName + “, “ + FirstName

      - Contact Types

        - Formula: ContactType

      - EmailAddress

        - Formula: EmailAddress

      - PhoneNumber

        - Formula: PhoneNumber

      - Owned Vehicles

        - Formula: VehicleYear + “ “ + VehicleMake + “ “ + VehicleModel

      - Estimated Mileage

        - Formula: EstimatedMileage

        - Number format: ,.0f

      - Last Service Dates

        - Formula: LastServiceDate

        - Time format: %b %-d %Y

      - ScheduledServiceDate

        - Formula: ScheduledServiceDate

        - Time format: %B %-d, %Y

      - Sold Dates

        - Formula: SoldDate

        - Time format: %b %-d %Y

      - Warranty End

        - Formula: Warranty_End

        - Time format: %b %-d %Y

      - Contract End

        - Formula: Contract_End

        - Time format: %b %-d %Y

      - Lease End

        - Formula: Lease_End

        - Time format: %b %-d %Y

      - Estimated Lease Penalty

        - Formula: Est_Lease_Penalty

        - Number format: \$,.0f

      - Estimated Equity

        - Formula: int(if(EquityValueRough \> 0, EquityValueRough))

        - Number format: \$,.0f

      - Desired Vehicles

        - Formula: string(DesiredVehicleYear3Birds) + “ “ + DesiredVehicleMake3Birds + “ “ + DesiredVehicleModel3Birds

      - Declined Service Dates

        - Formula: DeclinedServiceDate

        - Time format: %b %-d %Y

      - Declined Service

        - Formula: if(Declined_Service_T_F = "True" and DeclinedServiceDate between date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2000-01-01T00:00:00'}\], true)\|first).id}}") and date("{{(DeclinedServiceDate\_\_between_raw\|default(\[{'id':'2100-12-31T00:00:00'}\], true)\|last).id}}"), "Declined service", "Did not decline service")

      - Declined Service Code 1

        - Formula: DeclinedService1Code

      - Declinedservice2Code

        - Formula: DeclinedService2Code

      - Declinedservice3Code

        - Formula: DeclinedService3Code

      - Declinedservice4Code

        - Formula: DeclinedService4Code

      - Declinedservice5Code

        - Formula: DeclinedService5Code
