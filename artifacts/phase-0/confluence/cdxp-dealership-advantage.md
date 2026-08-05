---
source: DAS Confluence
page_id: 3699048472
title: CDXP Dealership Advantage (Retention Accelerator)
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3699048472
type: confluence-doc
repulled: 2026-06-09
---

**CDXP Dealership Advantage (Retention Accelerator)**

**Core Logic Behind Every Mautic Accelerator Stream**

Here’s the example of workflow with the Retention Accelerator communication stream.

1.  Client Flag:

    - Every active client has ***d_is_ra*** flag value set to true

    - This is the main identifier of the client for which the retention accelerator streams are enabled

2.  Segment Filtration

    - We have different segments designed based on different caadence, like

    - d_is_ra = True - client flag is used as main filter for the customers & clients

    - c_purchase_condition = ‘New’ – This filter is used to pull specific type of customers only

    - c_last_purchase = ‘Specific Date’ (like 1 month ago, 6 months ago): This filter is used to distribute the contacts based on their purchase date and help us manage the cadence of the stream

3.  Campaign Assignment

    - There are different campaigns created and assigned to the different segments

    - Each campaign has specific email attached to it

    - These campaigns trigger different type of email communication on the eligible customers

4.  Email Template (Twig) Assembly

    - Each email template has different twigs added in it

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3699048472/att_0_for_3699048472.png?api=v2" class="confluence-embedded-image image-left" width="387" /></span>

- These twig template gets rendered based on the different customer related fields (e.g. Name, Client Name, Amenities etc)

  - Each Twig template contains a separate code snippet. These templates help improve reusability by allowing the same code to be easily used across multiple email bodies.

  - For example – <a href="https://accelerator.3birds.marketing/s/twigTemplates/edit/2" class="external-link" rel="nofollow">Twig 2</a> contains the email header content (Dealer Logo)

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3699048472/att_1_for_3699048472.png?api=v2" class="confluence-embedded-image image-left" width="340" /></span>

- Along with the twig templates, the email template itself also has some static & dynamic content in it. This content varies based on the email communication. Here’s the <a href="https://accelerator.3birds.marketing/s/emails/edit/69" class="external-link" rel="nofollow">example</a> -

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3699048472/att_2_for_3699048472.png?api=v2" class="confluence-embedded-image image-left" width="469" /></span>

- 

- CTA Logic

  - Each email template has different hyperlinks in different text, buttons, action items

  - Here’s the sample URL image

  - <span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3699048472/att_3_for_3699048472.png?api=v2" class="confluence-embedded-image image-left" width="530" /></span>

  - All the links contains *d_link\_\** field as the actual URL of the client page

    - These fields come from the Builder Site **Text-Overrides**

    - These links will either redirect to the actual client website or our lift sites

    - Example links for Jack Daniels Kia

      1.  d_link_contact = <a href="https://news.jackdanielskia.com/contact-us" class="external-link" rel="nofollow">https://news.jackdanielskia.com/contact-us</a>

      2.  d_link_directions - <a href="https://www.jackdanielskia.com/dealership/directions.htm" class="external-link" rel="nofollow">https://www.jackdanielskia.com/dealership/directions.htm</a>

  - Every hyperlink also contains set of UTM parameters. These UTM parameters helps us identifying the different page visits of the Landing Page. Below is the list of different UTM parameters currently being used

    - **utm_source = das.cdxp**: Source of the page visit (Mautic Accelerator in this case

    - **utm_medium = email/sms**: Type of communication from which the user redirected to the landing page

    - **utm_campaign = campaign-name**: Name of the campaign from which the communication was made

    - **utm_content = cta-text-title:** Title of the CTA text for which the hyperlink is created

    - **utm_term = c_hashkey:** Unique identifier value of the Mautic contact

1.  Landing Page Flow

    - As mentioned in the CTA logic, all the email clicks would either redirect to the LIFT site or the actual client website.

    - Both the pages (Lift & client page) have Google Analytics (GA4) script tracking all the page hits

    - We regularly pull these google analytics data into the account and show the respective data in the reports

<!-- -->

1.  Ownership & Touchpoints

    - Content updates

      - Every email and twig template is created/designed on Mautic Accelerator platform

      - If anything needs to be modified/any cosmetic changes, it needs to be performed in the Mautic platform

    - CTA changes

      - All the CTA text, can be modified from Mautic platform only

      - All the CTA link, can be modified from either the Builder Site

    - Landing page updates

      - Landing page content/url can be modified from the Lift Site of that particular client

**In-Depth Template Exploration**

Let’s take email template: <a href="https://accelerator.3birds.marketing/s/emails/view/69" class="external-link" rel="nofollow">RA - TG - Dealership Advantage</a>

Segment - <a href="https://accelerator.3birds.marketing/s/segments/view/65" class="external-link" rel="nofollow">Retention Accelerator - Dealership Advantage</a>

Campaign - <a href="https://accelerator.3birds.marketing/s/campaigns/view/54" class="external-link" rel="nofollow">Retention Accelerator - Dealership Advantage</a>

- **Content Sources:**

This template includes different twigs and dynamic content in it. Let’s explore the included twigs in it.

1.  **Twig Template Integration**

Different twig templates can be embedded in the email body by using the syntax - **{twigtemplate=*****id}***

Here’s the example - {twigtemplate=1}

This email template has below twigs included in it

1.  {twigtemplate=2}: **LA - Dealer Top Logo**

2.  {twigtemplate=41}: **Full Address or Service Address**

3.  {twigtemplate=6}: **Amenities Widget**

Let’s understand these widgets in detail

1.  <a href="https://accelerator.3birds.marketing/s/twigTemplates/edit/2" class="external-link" rel="nofollow">{twigtemplate=2}</a>: **LA - Dealer Top Logo**

    1.  **Purpose** – This template is used to create the header section of the email body.

    2.  **Content** – This twig contains main header image of the client.

    3.  **Dynamic Fields:**

        1.  **d_page_bgcolor**

            - **Use:** denotes the background color for the email body

            - **Source:** Builder Site -\> Text-Override -\> \[d_page_bgcolor\]

        2.  **d_link_website**

            - **Use:** denotes the background color for the email body

            - **Source:** Builder Site -\> Text-Override -\> \[home-link\] / \[dealer-website\]

        3.  **d_header_image**

            - **Use:** denotes the background color for the email body

            - **Source:** Builder Site -\> Text-Override -\> \[d_header_image\]

2.  <a href="https://accelerator.3birds.marketing/s/twigTemplates/edit/41" class="external-link" rel="nofollow">{twigtemplate=41}</a>: **Full Address or Service Address**

    1.  **Purpose** – This template is used to put the dealership address in the email.

    2.  **Content** – This twig contains condition for using either the service address or the sales address (full address)

    3.  **Dynamic Fields:**

        1.  **d_is_separate_service_address**

            - **Use:** denotes if the dealer has separate service address

            - **Source:** Builder Site -\> Text-Override -\> \[d_is_separate_service_address\]

        2.  **d_full_service_address**

            - **<span class="legacy-color-text-default">Use:</span>**<span class="legacy-color-text-default"> Contains the client’s full service address</span>

            - **<span class="legacy-color-text-default">Source:</span>**<span class="legacy-color-text-default"> Builder Site -\> Text-Override -\> \[d_page_bgcolor\]</span>

        3.  **d_full_address**

            - **Use:** denotes the background color for the email body

            - **Source:** Database table

              - DB – ClientDB

              - Table – ClientDetails

                1.  Columns: streetaddress1, city, PostalCode

              - Table - States

                1.  Columns: StateName

3.  <a href="https://accelerator.3birds.marketing/s/twigTemplates/edit/6" class="external-link" rel="nofollow">{twigtemplate=6}</a>: **Amenities Widget**

    1.  **Purpose** – This template is used to list out the amenities offered by the dealer.

    2.  **Content** – This twig traverse through one amenities JSON and lists down all the amenities.

    3.  **Dynamic Fields:**

        1.  **d_amenities_json**

            - **Use:** A JSON field that contains all the amenities items

            - **Source:** Builder Site -\> Text-Override -\> \[Amenity1\], \[Amenity2\], \[Amenity3\], \[Amenity4\]

<!-- -->

1.  **Email Template Dynamic Fields Usage Summary**

Email body itself also has the dynamic fields put into it. Here’s the list of all the dynamic fields used in the email body.

**Background Color Fields:**

- d_page_bgcolor - Sets the background color for the entire email page/body

  - Source: Builder Site -\> Text-Override -\> \[d_page_bgcolor\]

- d_preheader_bgcolor - Sets the background color for the preheader section at the top of the email

  - Source: Builder Site -\> Text-Override -\> \[d_preheader_bgcolor\]

- d_body_bgcolor - Sets the background color for main content sections/containers

  - Source: Builder Site -\> Text-Override -\> \[d_body_bgcolor\]

- d_btn_bgcolor - Sets the background color for button/CTA sections

  - Source: Builder Site -\> Text-Override -\> \[d_btn_bgcolor\]

**Text Color Fields:**

- d_preheader_color - Sets the text color for the preheader section

  - Source: Builder Site -\> Text-Override -\> \[d_preheader_color\]

- d_body_color - Sets the primary text color for main body content

  - Source: Builder Site -\> Text-Override -\> \[d_body_color\]

- d_btn_color - Sets the text color for button/CTA content

  - Source: Builder Site -\> Text-Override -\> \[d_btn_color\]

**Typography Fields:**

- d_font_family - Defines the font family used throughout the email content

  - Source: Builder Site -\> Text-Override -\> \[d_font_family\]

**Content Fields:**

- d_client - Displays the dealership/client name in email content

  - Source: Builder Site -\> Text-Override -\> \[client\]

- d_oem - Displays the vehicle manufacturer/OEM name (e.g., Ford, Toyota)

  - Source: Builder Site -\> Text-Override -\> \[oem\]

- d_service_phone - Displays the dealership's service phone number as a clickable link

  - Source: Builder Site -\> Text-Override -\> \[service-phone\]

**URL/Link Fields:**

- d_link_directions - URL link for directions to the dealership location

  - Source: Builder Site -\> Text-Override -\> \[directions-link\]

- d_link_schedule - URL for service scheduling page

  - Source: Builder Site -\> Text-Override -\> \[schedule-link\]

- d_link_service_specials - URL for service specials/popular services page

  - Source: Builder Site -\> Text-Override -\> \[service-specials\]

- d_site_domain – LIFT site URL for the particular client

  - Source: Database -

    - Column: HostName

    - Table: lift_sites

    - DB: Lift

    - Server: 10

**Customer Contact Fields:**

- **c_hashkey** - Unique customer identifier used in UTM tracking parameters across all links

- **email** - Displays the recipient's email address in footer section

- **firstname** - Customer's first name with fallback "Valued Customer" for personalized greeting

**Customer Preference Fields:**

- **c_desired_condition** - Customer's preferred vehicle condition (new/used)

- **c_desired_make** - Customer's preferred vehicle manufacturer/brand

- **c_desired_model** - Customer's preferred vehicle model

- **c_last_lead** - Date of customer's last inquiry or lead activity

<!-- -->

- **CTA & Landing Page Logic**

Here's the details of each CTA link and UTM parameters applied in those links.

**Main CTA Button Texts:**

- **SCHEDULE YOUR NEXT SERVICE** - Primary service scheduling call-to-action

- **POPULAR SERVICES** - Secondary service offerings call-to-action

- **READ MORE** - Article engagement call-to-action

**Links with UTM tracking details**:

1.  **Dealer Logo/Header Link (Twig Template 2):**

Base URL: {contactfield=d_link_website}

UTM Source: das.cdxp

UTM Medium: email

UTM Campaign: accelerator

UTM Content: dealer-logo-header

UTM Term: {contactfield=c_hashkey}

1.  **Dealer Location/Directions Link:**

Base URL: {contactfield=d_link_directions}

UTM Source: das.cdxp

UTM Medium: email

UTM Campaign: retention-accelerator-tg-dealership-advantage

UTM Content: dealer-location-header

UTM Term: {contactfield=c_hashkey}

1.  **Service Scheduling Link:**

Base URL: {contactfield=d_link_schedule}

UTM Source: das.cdxp

UTM Medium: email

UTM Campaign: retention-accelerator-tg-dealership-advantage

UTM Content: schedule-service-cta

UTM Term: {contactfield=c_hashkey}

1.  **Popular Services Link:**

Base URL: {contactfield=d_link_service_specials}

UTM Source: das.cdxp

UTM Medium: email

UTM Campaign: retention-accelerator-tg-dealership-advantage

UTM Content: service-offers-cta

UTM Term: {contactfield=c_hashkey}

1.  **Article Link (Image):**

Base URL: {contactfield=d_site_domain}/article/dealership-mechanic-auto-repair

UTM Source: das.cdxp

UTM Medium: email

UTM Campaign: retention-accelerator-tg-dealership-advantage

UTM Content: article-1-cta

UTM Term: {contactfield=c_hashkey}

1.  **Article Link (Read More Button):**

Base URL: {contactfield=d_site_domain}/article/dealership-mechanic-auto-repair

UTM Source: das.cdxp

UTM Medium: email

UTM Campaign: retention-accelerator-tg-dealership-advantage

UTM Content: article-1-cta

UTM Term: {contactfield=c_hashkey}

**Footer Links (No UTM Tracking):**

1.  **Privacy Policy Link:**

Base URL: {contactfield=d_site_domain}/privacy

1.  **Disclaimer Link:**

Base URL: {contactfield=d_site_domain}/disclaimer

1.  **Unsubscribe Link:**

Base URL: {unsubscribe_url}

1.  **View in Browser Link:**

Base URL: {webview_url}

1.  **Phone Link:**

Service Phone: tel:{contactfield=d_service_phone}
