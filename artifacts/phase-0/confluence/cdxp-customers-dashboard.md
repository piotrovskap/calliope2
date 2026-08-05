---
source: DAS Confluence
page_id: 3783196674
title: CDXP Customers - Dashboard Details
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3783196674
type: confluence-doc
repulled: 2026-06-09
---

**CDXP Customers - Dashboard Details**

**Last Updated: 2/12/2026**

**Data Tables and Fields Summary (only fields in use are noted)**

<div class="table-wrap">

<table class="confluenceTable" data-table-width="760" data-layout="default">
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Table</strong></p></td>
<td class="confluenceTd"><p><strong>Field(s)</strong></p></td>
</tr>
<tr>
<td rowspan="32" class="confluenceTd"><p>dbo.JuiceReporting_CDXPCustomers</p></td>
<td class="confluenceTd"><p>OEMs</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>OwnerName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ClientName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>EmailAddress</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>PhoneNumber</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Address</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ContactType</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>RecipientID</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Lease_End</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Contract_End</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Warranty_End</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Est_Lease_Penalty</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>DeclinedServiceDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Upcoming_Service_Appointment</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Last_Open</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Last_Click</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Last_Page_Visit</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Latest_Inventory_Visit</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>FirstName</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastName</p></td>
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
<td class="confluenceTd"><p>SoldDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>LastServiceDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ScheduledServiceDate</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SentDateTime</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>SendSubject</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>PagePath</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>ViewDateTime</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>InteractionNumber</p></td>
</tr>
</tbody>
</table>

</div>

**Dashboard Views Breakdown**

**Overview / Dealer Filter**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783196674/att_0_for_3783196674.png?api=v2" class="confluence-embedded-image image-center" width="516" /></span>

- Layout: Stacked

- Spacing style: No space

- Slices:

  - Filters4

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections:

      - OEMs: Many as Filters

      - Parent Groups: Up to One as Filters

      - Clients: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Ingredients –

      - OEMs

        - Formula: OEMs

      - Parent Groups

        - Formula: OwnerName

      - Clients

        - Formula: ClientName

**Customer Overview**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783196674/att_1_for_3783196674.png?api=v2" class="confluence-embedded-image image-center" width="530" /></span>

- Layout: Custom

  - "Text1 Text1 Text1 Text1"

"Filters6 Filters6 Filters6 Filters6"

"Card5 Card5 Card5 Card5"

"Text2 Text3 Text4 Text7"

- Spacing style: Dense

- Slices:

  - Text1

    - “Dealership Customers Overview”

    - “*Customers within the dealership's DMS are categorized by their status at the dealership and placed into one of the four buckets listed below. Note that a customer may be included within one of the listed buckets multiple times if multiple vehicles have been purchased/serviced at the dealership.*

*Filters are available below to view only customer records that include specific methods of contact. Additionally, each of the tiles below work as filters for the remainder of the dashboard, i.e. if you only want to review data for service customers, clicking the 'Service' tile below will filter the remainder of the dashboard to do so.”*

- Filters6

  - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections:

      - Email Address: Many as Filters

      - Phone Number: Up to One as Filters

      - Address: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Hide counts: On

    - Ingredients –

      - Email Address

        - Formula: EmailAddress

        - Buckets –

          - label: Have Email Address\
            condition: EmailAddress IS NOT NULL

          - Buckets default label: No Email Address

      - Phone Number

        - Formula: PhoneNumber

        - Buckets –

          - label: Have Phone Number\
            condition: PhoneNumber IS NOT NULL

          - Buckets default label: No Phone Number

      - Email Address

        - Formula: Address

        - Buckets –

          - label: Have Address\
            condition: Address IS NOT NULL

          - Buckets default label: No Address

  - Card5

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Contact Types

          - Formula: ContactType

          - Buckets –

            - label: Prospects\
              condition: IN(“Prospects”, “Prospect”)

            - label: Sold\
              condition: IN(“Sold”, “Sales”)

            - label: Service\
              condition: = “Service”

            - label: Retention\
              condition: IN(“Retention”, “Sales and Service”)

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

  - Text2

    - “Prospects are customers that have not yet completed a sales or service transaction at the dealership.”

  - Text3

    - “Sold customers are those that have purchased a vehicle but have not had it serviced at the dealership.”

  - Text4

    - “Service customers are those that have had a vehicle serviced at the dealership but did not complete a vehicle purchase.”

  - Text7

    - “Retention customers are those that purchased a vehicle at the dealership and later returned to have it serviced.”

**Data Mining**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783196674/att_2_for_3783196674.png?api=v2" class="confluence-embedded-image image-center" width="469" /></span>

- Layout: Custom

  - "Text5 Text5"

"Card6 Card7"

"Card8 Card9"

"Card10 Card11"

- Spacing style: Dense

- Slices:

  - Text5

    - “Data Mining Drill Down”

    - “*The tiles below display the total count of customers within each bucket of the noted attribute. These tiles also work as filters for the tables below this section, which include full details of dealership customers. Note that multiple tiles can be selected at once - for example, if wishing to generate a list of all customers with a lease expiring within the next 90 days, both the 'Within 30 Days' and the 'In 31-90 Days' tiles can be selected in the 'Customers with Expiring Leases' section. Note also that while selecting specific tiles will cause the sections below to filter accordingly, the sections above will not be filtered by the selection(s).”*

  - Card6

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Hide if no data: On

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Lease End

          - Formula: Lease_End

          - Buckets –

            - label: Within 30 Days\
              condition: (datediff(Lease_End, date(“TODAY”), DAY) \<= 30 and (datediff(Lease_End, date(“TODAY”), DAY) \>= 0)

            - label: In 31-90 Days\
              condition: (datediff(Lease_End, date(“TODAY”), DAY) \<= 90 and (datediff(Lease_End, date(“TODAY”), DAY) \>= 31)

            - label: In Over 90 Days\
              condition: datediff(Lease_End, date(“TODAY”), DAY) \>= 91

          - Filter: datediff(Lease_End, date("TODAY"), DAY) \>= 0

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

  - Card7

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Hide if no data: On

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Contract End

          - Formula: Contract_End

          - Buckets –

            - label: Within 30 Days\
              condition: (datediff(Contract_End, date(“TODAY”), DAY) \<= 30 and (datediff(Contract_End, date(“TODAY”), DAY) \>= 0)

            - label: In 31-90 Days\
              condition: (datediff(Contract_End, date(“TODAY”), DAY) \<= 90 and (datediff(Contract_End, date(“TODAY”), DAY) \>= 31)

            - label: In Over 90 Days\
              condition: datediff(Contract_End, date(“TODAY”), DAY) \>= 91

          - Filter: datediff(Contract_End, date("TODAY"), DAY) \>= 0

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

  - Card8

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Hide if no data: On

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Warranty End

          - Formula: Warranty_End

          - Buckets –

            - label: Within 30 Days\
              condition: (datediff(Warranty_End, date(“TODAY”), DAY) \<= 30 and (datediff(Warranty_End, date(“TODAY”), DAY) \>= 0)

            - label: In 31-90 Days\
              condition: (datediff(Warranty_End, date(“TODAY”), DAY) \<= 90 and (datediff(Warranty_End, date(“TODAY”), DAY) \>= 31)

            - label: In Over 90 Days\
              condition: datediff(Warranty_End, date(“TODAY”), DAY) \>= 91

          - Filter: datediff(Warranty_End, date("TODAY"), DAY) \>= 0

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

  - Card9

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Hide if no data: On

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Estimated Lease Penalty

          - Formula: Est_Lease_Penalty

          - Buckets –

            - label: \$0-\$5,000\
              condition: Est_Lease_Penalty \<= 5000

            - label: \$5,001-\$10,000\
              condition: Est_Lease_Penalty \<= 10000 AND Est_Lease_Penalty \>= 5001

            - label: \$10,000+\
              condition: Est_Lease_Penalty \>= 10001

            - Buckets default label: No Estimated Lease Penalty

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

  - Card10

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Hide if no data: On

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Declined Service

          - Formula: DeclinedServiceDate

          - Buckets –

            - label: Within 30 Days\
              condition: (datediff(date("TODAY"), date(DeclinedServiceDate), DAY) \<= 30) and (datediff(date("TODAY"), date(DeclinedServiceDate), DAY) \>= 0)

            - label: In 31-90 Days\
              condition: (datediff(date("TODAY"), date(DeclinedServiceDate), DAY) \<= 90) and(datediff(date("TODAY"), date(DeclinedServiceDate), DAY) \>= 31)

            - label: In Over 90 Days\
              condition: datediff(date("TODAY"), date(DeclinedServiceDate), DAY) \>= 91

          - Filter: Declined_Service_T_F = "True" AND datediff(date("TODAY"), date(DeclinedServiceDate), DAY) \>= 0

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

  - Card11

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Hide if no data: On

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Card style: Large Measure

    - Ingredients –

      - Title

        - Upcoming Service Appointment

          - Formula: Upcoming_Service_Appointment

          - Buckets –

            - label: Upcoming Appointment\
              condition: Upcoming_Service_Appointment = “true”

            - label: No Upcoming Appointment\
              condition: Upcoming_Service_Appointment = “false”

      - Additional data

        - Customers

          - Formula: count_distinct(RecipientID)

          - Number format: ,.0f

**Full Customer Details**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783196674/att_3_for_3783196674.png?api=v2" class="confluence-embedded-image image-center" width="496" /></span>

- Layout: Custom

  - "Text8 Text8 Text8"

"Filters2 Filters2 Filters2"

"Table2 Table3 Table5"

- Spacing style: Dense

- Slices:

  - Text8

    - “Customer Detail Exports”

    - “*Select specific tiles in the Data Mining Drill Down section, or use the campaign engagement filters below to download specific segments of the customer base.*

*For example, to download a list of all Sales Customers that have a lease expiring within the next 30 days, you can select the 'Within 30 Days' tile in the 'Customers with Expiring Leases' section of Data Mining Drill Down and use the Sales Customer Details download function below.”*

- Filters2

  - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections:

      - Opened: Many as Filters

      - Clicked: Up to One as Filters

      - Website Visited: Many as Filters

      - Inventory Visited: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Hide counts: On

    - Ingredients –

      - Opened

        - Formula: Last_Open

        - Buckets –

          - label: Email Opened\
            condition: Last_Open IS NOT NULL

          - label: Email Not Opened\
            condition: Last_Open IS NULL

      - Clicked

        - Formula: Last_Click

        - Buckets –

          - label: Email Clicked\
            condition: Last_Click IS NOT NULL

          - label: Email Not Clicked\
            condition: Last_Click IS NULL

      - Website Visited

        - Formula: Last_Page_Visit

        - Buckets –

          - label: User Visited Website\
            condition: Last_Page_Visit IS NOT NULL

          - label: User Did Not Visit Website\
            condition: Last_Page_Visit IS NULL

      - Inventory Visited

        - Formula: Latest_Inventory_Visit

        - Buckets –

          - label: User Viewed Dealership Inventory\
            condition: Latest_Inventory_Visit IS NOT NULL

          - label: User Did Not View Dealership Inventory\
            condition: Latest_Inventory_Visit IS NULL

  - Table2

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show as Download Button: On

    - Filters applied footnote: On

    - Sort column: Email Open Dates – Recent first

    - Ingredients –

      - Customer Names

        - Formula: FirstName + “ “ + LastName

      - Email Addresses

        - Formula: EmailAddress

      - Phone Numbers

        - Formula: PhoneNumber

      - Email Open Dates

        - Formula: Last_Open

        - Time format: %-m/%-d/%Y

      - Email Click Dates

        - Formula: Last_Click

        - Time format: %-m/%-d/%Y

      - Website Visit Dates

        - Formula: Last_Page_Visit

        - Time format: %-m/%-d/%Y

      - Inventory Visit Dates

        - Formula: Latest_Inventory_Visit

        - Time format: %-m/%-d/%Y

  - Table3

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show as Download Button: On

    - Filters applied footnote: On

    - Sort column: Sold Dates – Recent first

    - Ingredients –

      - Sales Contact Types

        - Formula: ContactType

        - Filter: ContactType != "Service" AND ContactType != "Prospect" AND ContactType != "Prospects"

      - Customer Names

        - Formula: FirstName + “ “ + LastName

      - Email Addresses

        - Formula: EmailAddress

      - Phone Numbers

        - Formula: PhoneNumber

      - Owned Vehicles

        - Formula: VehicleYear + " " + VehicleMake + " " + VehicleModel

      - Estimated Mileage

        - Formula: EstimatedMileage

        - Number format: .3s

      - Sold Dates

        - Formula: SoldDate

        - Time format: %-m/%-d/%Y

      - Contract End Dates

        - Formula: Contract_End

        - Time format: %-m/%-d/%Y

      - Days Remaining in Contract

        - Formula: if((datediff(date(Contract_End), date("TODAY"))) \< 0, 0, (datediff(date(Contract_End), date("TODAY"))))

        - Number format: .3s

      - Lease End Dates

        - Formula: Lease_End

        - Time format: %-m/%-d/%Y

      - Days Remaining in Lease

        - Formula: if((datediff((Lease_End), date("TODAY"))) \< 0, 0, (datediff((Lease_End), date("TODAY"))))

        - Number format: .3s

      - Estimated Lease Penalty

        - Formula: Est_Lease_Penalty

        - Number format: \$,.0f

  - Table5

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show as Download Button: On

    - Filters applied footnote: On

    - Ingredients –

      - Service Contact Types

        - Formula: ContactType

        - Filter: ContactType = "Service" OR ContactType = "Retention" OR ContactType = "Sales and Service"

      - Customer Names

        - Formula: FirstName + “ “ + LastName

      - Email Addresses

        - Formula: EmailAddress

      - Phone Numbers

        - Formula: PhoneNumber

      - Owned Vehicles

        - Formula: VehicleYear + " " + VehicleMake + " " + VehicleModel

      - Last Service Dates

        - Formula: LastServiceDate

        - Time format: %-m/%-d/%Y

      - Upcoming Service Appointment

        - Formula: Upcoming_Service_Appointment

      - Scheduled Service Dates

        - Formula: ScheduledServiceDate

        - Time format: %-m/%-d/%Y

**Customer Journey**

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3783196674/att_4_for_3783196674.png?api=v2" class="confluence-embedded-image image-center" width="401" /></span>

- Layout: Custom

  - "Filters1 Filters1"

"Bar1 Table1"

"Pie1 Bar3"

“Table4 Table4”

- Spacing style: Dense

- Slices:

  - Filters1

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections:

      - Send Dates: Many as Filters

    - Show Title: On

    - Show Filters: On

    - Show notes: On

    - Ingredients –

      - Send Dates

        - Formula: SentDateTime

        - Time format: %-m/%-d/%Y

  - Bar1

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show Legend: On

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Message Subjects

          - Formula: SendSubject

      - Bars –

        - Tracked Clickers

          - Formula: count_distinct(if(PagePath IS NOT NULL, EmailAddress))

          - Number format: ,.0f

  - Table1

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Sort columns: Messages Clicked – High first

    - Ingredients –

      - Tracked Campaign Clickers

        - Formula: EmailAddress

      - Messages Clicked

        - Formula: count_distinct(if(PagePath IS NOT NULL,\[SendSubject\]))

        - Number format: ,.0f

  - Pie1

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show notes: On

    - Show Legend: On

    - Show data as: \# Value

    - Ingredients –

      - Slices –

        - Page Categories

          - Formula: PagePath

          - Buckets –

            - label: Website Homepage

condition: PathPath = “/”

- label: Sales Page

condition: PagePath ILIKE "%new%" OR PagePath ILIKE "%used%" OR PagePath ILIKE "%inventory%" OR PagePath ILIKE "%express%" OR PagePath ILIKE "%certified%" OR PagePath ILIKE "%pre-owned%" OR PagePath ILIKE "%Preowned%"

- label: Service Page

condition: PagePath ILIKE "%service%" OR PagePath ILIKE "%parts%" OR PagePath ILIKE "%tire%" OR PagePath ILIKE "%oil%" OR PagePath ILIKE "%brake%"

- label: Trade-In Page

condition: PagePath ILIKE "%trade%" OR PagePath ILIKE "%sell%"

- label: Finance Page

condition: PagePath ILIKE "%finance%" OR PagePath ILIKE "%credit%"

- label: Dealer Information Page

condition: PagePath ILIKE "%contact%" OR PagePath ILIKE "%hours%" OR PagePath ILIKE "%about%" OR PagePath ILIKE "%direction%"

- Filter: \[PagePath\] != "/home/unsubscribe-confirmation"

  - Measure –

    - Tracked Clickers

      - Formula: count_distinct(if(PagePath IS NOT NULL, EmailAddress))

        - Number format: ,.0f

  - Bar3

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Show data as: \# Value

    - Ingredients –

      - Label –

        - Page Paths

          - Formula: PagePath

          - Filter: \[PagePath\] != "/home/unsubscribe-confirmation"

      - Bars –

        - Tracked Clickers

          - Formula: count_distinct(if(PagePath IS NOT NULL, EmailAddress))

          - Number format: ,.0f

  - Table4

    - Data Table: dbo.JuiceReporting_CDXPCustomers

    - Enable download: Yes as Excel

    - Selections: Many as Filters

    - Show Title: On

    - Show Chart: On

    - Filters applied footnote: On

    - Sort columns: Email Addresses – A to Z

    - Ingredients –

      - Email Addresses

        - Formula: EmailAddress

      - Customer Names

        - Formula: FirstName + “ “ + LastName

      - Phone Numbers

        - Formula: PhoneNumber

      - Message Subjects

        - Formula: SendSubject

      - Send Dates

        - Formula: SentDateTime

        - Time format: %-m/%-d/%Y

      - View Dates

        - Formula: ViewDateTime

        - Time format: %-m/%-d/%Y

      - Customer Journey Steps

        - Formula: InteractionNumber

        - Number format: ,.0f

      - Page Paths

        - Formula: PagePath

        - Filter: \[PagePath\] != "/home/unsubscribe-confirmation"
