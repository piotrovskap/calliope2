---
source: DAS Confluence
page_id: 686489765
title: Integrations (leads' delivering)
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/686489765
type: confluence-doc
repulled: 2026-06-09
---

<div class="toc-macro rbtoc1781043445155">

- [Infusionsoft](#Integrations(leads'delivering)-Infusionsoft)
- [Zapier](#Integrations(leads'delivering)-Zapier)
- [Integrations (Automotive)](#Integrations(leads'delivering)-Integrations(Automotive))

</div>

------------------------------------------------------------------------

# Infusionsoft

It's CRM, where leads from RP are delivered.

How to set up Integration:

- Login <a href="https://signin.infusionsoft.com/login" class="external-link" rel="nofollow">Infusionsoft</a>. For testing needs you can find credentials here: <a href="http://paralect.atlassian.net/wiki/spaces/AG/pages/45416470" class="external-link" rel="nofollow">Third-Party Tools &amp; Passwords</a> 

- Settings → Integrations: Click \[Connect\] in "Infusionsoft" section

New contacts are created in Infusionsoft, if:

- a new visitor comes to EP. He submits Contact form with Phone / Email; conv becomes closed

- user fills in Phone / Email in Lead Profile for a visitor (conv is closed)

- visitor has / doesn't have conv; passes "Trade-in" card (conv is closed)

New contacts are not created, if:

- a visitor books Appt, but doesn't start conv

One visitor is not sent to Infusionsoft several times. If visitor / provider makes changes in visitor's First name, Last name, Email, Phone, Inquiry type, then all info will be updated for the Contact. New Contact won't be created. 

------------------------------------------------------------------------

How to check Infusionsoft integration: 

- Login Infusionsoft 

- Click \[Contacts\] in the header → Redirect to the page with all contacts 

- Click \[New Search\]

- Select any search criteria, click \[Search\] → Redirect to the page with search results

- Click contact's name → Redirect to the contact profile

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://paralect.atlassian.net/wiki/download/thumbnails/958399360/infusionsoft.png?version=1&amp;modificationDate=1556293593028&amp;cacheVersion=1&amp;api=v2&amp;height=250" class="confluence-embedded-image confluence-external-resource image-center" data-image-src="https://paralect.atlassian.net/wiki/download/thumbnails/958399360/infusionsoft.png?version=1&amp;modificationDate=1556293593028&amp;cacheVersion=1&amp;api=v2&amp;height=250" loading="lazy" /></span>

Contact profile:

- "General" tab - "First name", "Last name", "Phone", "Email" have lead's values; "Lead Source" has "Path" value; two Tags - "Path - Source" tag and "{Lead Inquiry type} - Prospect}" tag  

- "Personal Notes" tab - "Person Notes" has conv transcript of the lead

- "Custom Fields" tab - if visitor has some fields besides "First name", "Last name", "Phone", "Email", then the field name and its values will be send to Infusionsoft

------------------------------------------------------------------------

# Zapier

It is a powerful integration connector that allows to send Path Leads and Appointments to 500+ of the most popular tools on the web.

How to set up Integration:

- Login <a href="https://zapier.com" class="external-link" rel="nofollow">Zapier</a> account. Create your own account, if you don't have it yet

- Settings → Integrations: Click \[Connect\] in "Zapier" section. → Redirect to the page of Zap creation

- Choose a trigger, on which zap should fire – on New Appt or New Lead

- Select RP Path account; test this step

- Click \[Add step\] → Many applications, to which a lead will be sent, are suggested

- Choose any app, select the action type (e.g. create draft / send email in Gmail)

- On "Set Up Template" step specify which lead values should be inserted into template (e.g. "First Name" and "Last name" in "To" field of email)

- Test the step

Read instruction in details here: <a href="https://zapier.com/help/features/" class="external-link" rel="nofollow">https://zapier.com/help/features/</a> 

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://paralect.atlassian.net/wiki/download/thumbnails/958399360/zapier.png?version=1&amp;modificationDate=1556700345150&amp;cacheVersion=1&amp;api=v2&amp;height=250" class="confluence-embedded-image confluence-external-resource image-center" data-image-src="https://paralect.atlassian.net/wiki/download/thumbnails/958399360/zapier.png?version=1&amp;modificationDate=1556700345150&amp;cacheVersion=1&amp;api=v2&amp;height=250" loading="lazy" /></span>

On "My zaps" page all created zaps are displayed, you can turn it on / off. Zapier is free, but it can run only 100 tasks (leads in our case) per month. So, it's better to turn OFF a zap, if you don't test the integration.

Zapier checks new leads every 15 min and sends them to proper applications in the following cases: 

- "New Appt" trigger - visitor schedules Appt and user confirms it. So, Appt status is "Upcoming"

- "New Lead" trigger:

  - a new visitor comes to EP; he submits Contact form with Email / Phone; conv becomes closes

  - user fills in Phone / Email in Lead Profile for a visitor (conv is closed)

  - visitor has / doesn't have conv; passes "Trade-in" card (conv is closed)

Lead is sent only one time. If any changes occurs in a lead, it's NOT updated / sent again in Zapier.

We send all lead's info to Zapier - Lead Profile, conv transcript, etc.

------------------------------------------------------------------------

# Integrations (Automotive)

This integrations include ADF-XML and STAR-XML format and are available only for companies with Automotive type.

ADF (Auto-lead Data Format) and STAR (Standarts for Technology in Automotive Retail) are industry standards for sharing lead information between tools that help manufacturers and dealers sell more cars. 

When a new lead comes, we send XML, which contain all lead's info. There're two ways to send leads: via BAC code or via email.

BAC code is currently used for integration with General Motors. It's a unique dealer's code assigned by GM.

How to set up integration **via email**: 

- Go to "Settings → Auto → Integration" page

- Click \[Add destination email\]

- Type an email (it can be any email, even if if doesn't belong to any user in the company); select Inquiry types

- Click \[Save\]

- Click \[Edit Fields\] in the second section

- Updates fields, if needed; click \[Submit\]

How to set up integration **via BAC code**: 

- Go to "Settings → Auto → Integration" page

- Click \[Save\]

- Click \[Edit Fields\] in the second section

- Set BAC code (DAS code is 246435)

- Click \[Submit\]

*Note: One Inquiry Type can be used only once per BAC and Email.*

So, if the following events occur, then email will be sent to recipient(s) set in "Destination" email; or XML is sent to the GM:

- a new visitor comes to EP. He submits Contact form with Phone / Email; conv becomes closed

- user fills in Phone / Email in Lead Profile for a visitor (conv is closed)

- visitor has / doesn't have conv; passes "Trade-in" card (conv is closed, if it was)

Lead is sent in 1 minute after conv closing. If lead starts a new conv (and doesn't even changed his contact info), then one more XML will be sent in 1 hour after conv closing on prod and in 5 min on staging. If user wants to send a lead immediately, then they can click \[Push Lead to CRM\] button on Inbox page.\

There're 5 Lead Types used in GM. Each of the Lead Types has their own Campaign Code which is sent in XML and Method used:

<div class="table-wrap">

|               |                                            |             |
|---------------|--------------------------------------------|-------------|
| Campaign Code | Name                                       | Method Used |
| 561145        | Dealer Chat - Digital Air Strike - New     | ADF         |
| 561146        | Dealer Chat - Digital Air Strike - Used    | ADF         |
| 561147        | Dealer Chat - Digital Air Strike - CPO     | ADF         |
| 561148        | Dealer Chat - Digital Air Strike - Service | STAR        |
| 561149        | Dealer Chat - Digital Air Strike - Parts   | ADF         |

</div>

ADF-XML consists of three parts: prospect, vendor and provider. Prospect contains all info about a lead; Vendor - "Vendor name" value from "Auto Dealer Format Fields"; Provider - "Prospect source", "Provider ID", "Provider Name", "Provider Service" values from "Auto Dealer Format Fields". 

Template for ADF-XML (blue: differs for BAC): 

<div class="table-wrap">

<table class="confluenceTable" data-layout="default">
<colgroup>
<col />
</colgroup>
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Email title:</strong> New lead from Digital Air Strike: {{Inquiry type}}</p>
<p><strong>Body:</strong></p>
<p><br />
</p>
<p>&lt;?xml version="1.0"?&gt;</p>
<p>&lt;?adf version="1.0"?&gt;</p>
<p>&lt;adf&gt;</p>
<p>&lt;prospect&gt;</p>
<p>&lt;id sequence="1" source="{{prospectSource}}"&gt;{{lead._id}}&lt;/id&gt;</p>
<p>&lt;requestdate&gt;{{2018-04-02T16:36:19-07:00}}&lt;/requestdate&gt;</p>
<p>&lt;vehicle interest="buy" status="new"&gt;</p>
<p>&lt;year&gt;{{vehicle.year}}&lt;/year&gt;</p>
<p>&lt;make&gt;{{vehicle.make}}&lt;/make&gt;</p>
<p>&lt;model&gt;{{vehicle.model}}&lt;/model&gt;</p>
<p>&lt;vin&gt;{{vehicle.vin}}&lt;/vin&gt;</p>
<p>&lt;/vehicle&gt;</p>
<p>&lt;customer&gt;</p>
<p>&lt;contact&gt;</p>
<p>&lt;name part="first"&gt;{{lead.firstName}}&lt;/name&gt;</p>
<p>&lt;name part="last"&gt;{{lead.lastName}}&lt;/name&gt;</p>
<p>&lt;email&gt;{{lead.email}}&lt;/email&gt;</p>
<p>&lt;phone type="voice" preferredcontact="1"&gt;{{lead.phone - format 123-123-1234}}&lt;/phone&gt;</p>
<p>&lt;/contact&gt;</p>
<p>&lt;leadtype&gt;{{Inquiry type}}&lt;/leadtype&gt;</p>
<p>&lt;comments&gt;</p>
<p>Conversation on {{Date}}, {{Time (timezone)}}</p>
<p>::</p>
<p>{{name of visitor}} (visitor):</p>
<p>{{message of visitor}}</p>
<p>::</p>
<p>{{name of provider}} (bot):</p>
<p>{{message of provider}}</p>
<p>&lt;/comments&gt;</p>
<p>&lt;messages&gt;</p>
<p>   &lt;message&gt;<br />
     &lt;timestamp&gt;{{time of message}}&lt;/timestamp&gt;<br />
     &lt;name&gt;{{name of visitor}}&lt;/name&gt;<br />
     &lt;text&gt;{{message text}}&lt;/text&gt;<br />
   &lt;/message&gt;<br />
   &lt;message&gt;<br />
     &lt;timestamp&gt;{{time of message}}&lt;/timestamp&gt;<br />
     &lt;name&gt;{{name of provider}}&lt;/name&gt;<br />
     &lt;text&gt;{{message text}}&lt;/text&gt;<br />
   &lt;/message&gt;</p>
<p>&lt;/messages&gt;</p>
<p>&lt;/customer&gt;</p>
<p>&lt;vendor&gt;</p>
<p>&lt;vendorname&gt;{{vendorName}}&lt;/vendorname&gt;</p>
<p>&lt;/vendor&gt;</p>
<p>&lt;provider&gt;</p>
<p>&lt;id sequence="1"&gt;{{providerId}}&lt;/id&gt; // &lt;id sequence="1" source="GM"&gt; {{Company Code}} &lt;/id&gt;</p>
<p>&lt;name part="full"&gt;{{providerName}}&lt;/name&gt;</p>
<p>&lt;service&gt;{{providerService}}&lt;/service&gt;</p>
<p>&lt;/provider&gt;</p>
<p>&lt;/prospect&gt;</p>
<p>&lt;/adf&gt;</p></td>
</tr>
</tbody>
</table>

</div>

Example of ADF-XML: 

<div class="table-wrap">

<table class="confluenceTable" data-layout="default">
<colgroup>
<col />
</colgroup>
<tbody>
<tr>
<td class="confluenceTd"><p><strong>Email title:</strong> "New lead from Digital Air Strike: Sales - Pre-Owned"</p>
<p><strong>Body:</strong></p>
<p>&lt;?xml version="1.0"?&gt;<br />
&lt;?adf version="1.0"?&gt;<br />
&lt;adf&gt;<br />
    &lt;prospect&gt;<br />
        &lt;id sequence="1" source="DAS"&gt;5d5c0283edaf9a0006f149af&lt;/id&gt;<br />
        &lt;requestdate&gt;2019-08-20T14:26:00.043Z&lt;/requestdate&gt;<br />
        &lt;vehicle interest="buy" status="new"/&gt;<br />
        &lt;customer&gt;<br />
            &lt;contact&gt;<br />
                &lt;name part="first"&gt;Victor&lt;/name&gt;<br />
                &lt;name part="last"&gt;McNeely&lt;/name&gt;<br />
                &lt;email&gt;<a href="mailto:Victor_McNeely@gmail.com" class="external-link" rel="nofollow">Victor_McNeely@gmail.com</a>&lt;/email&gt;<br />
                &lt;phone type="voice" preferredcontact="1"&gt;4437539516&lt;/phone&gt;<br />
            &lt;/contact&gt;<br />
            &lt;leadtype&gt;Sales - Pre-Owned&lt;/leadtype&gt;<br />
            &lt;comments&gt;<br />
Conversation on August 20th 2019, 04:24PM (EET) <br />
:: <br />
Victor (visitor): <br />
Ask a Question <br />
:: <br />
chatbot (bot): <br />
Ask us any questions and our team will get back to you right away. <br />
:: <br />
Victor (visitor): <br />
help me! <br />
:: <br />
chatbot (bot): <br />
Thanks - please leave your details below and your message will be sent to our team. <br />
:: <br />
chatbot (bot): <br />
Form card (Form 1-1)  <br />
:: <br />
chatbot (bot): <br />
Great! Your message has been sent and we'll be in touch soon. <br />
:: <br />
chatbot (bot): <br />
You can also schedule an appointment by selecting the button below:&lt;/comments&gt;<br />
            &lt;messages&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:03+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;Victor McNeely&lt;/name&gt;<br />
                    &lt;text&gt;Ask a Question&lt;/text&gt;<br />
                &lt;/message&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:05+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;chatbot (bot)&lt;/name&gt;<br />
                    &lt;text&gt;Ask us any questions and our team will get back to you right away.&lt;/text&gt;<br />
                &lt;/message&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:13+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;Victor McNeely&lt;/name&gt;<br />
                    &lt;text&gt;help me!&lt;/text&gt;<br />
                &lt;/message&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:20+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;chatbot (bot)&lt;/name&gt;<br />
                    &lt;text&gt;Thanks - please leave your details below and your message will be sent to our team.&lt;/text&gt;<br />
                &lt;/message&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:20+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;chatbot (bot)&lt;/name&gt;<br />
                    &lt;text&gt;Form card (Form 1-1) &lt;/text&gt;<br />
                &lt;/message&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:45+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;chatbot (bot)&lt;/name&gt;<br />
                    &lt;text&gt;Great! Your message has been sent and we'll be in touch soon.&lt;/text&gt;<br />
                &lt;/message&gt;<br />
                &lt;message&gt;<br />
                    &lt;timestamp&gt;2019-08-20T16:24:47+02:00&lt;/timestamp&gt;<br />
                    &lt;name&gt;chatbot (bot)&lt;/name&gt;<br />
                    &lt;text&gt;You can also schedule an appointment by selecting the button below:&lt;/text&gt;<br />
                &lt;/message&gt;<br />
            &lt;/messages&gt;<br />
        &lt;/customer&gt;<br />
        &lt;vendor&gt;<br />
            &lt;vendorname&gt;DAS Motors&lt;/vendorname&gt;<br />
        &lt;/vendor&gt;<br />
        &lt;provider&gt;<br />
            &lt;id sequence="1"&gt;DAS&lt;/id&gt; //&lt;id sequence="1" source="GM"&gt; 561146 &lt;/id&gt;<br />
            &lt;name part="full"&gt;Digital Air Strike&lt;/name&gt;<br />
            &lt;service&gt;DAS Response Path&lt;/service&gt;<br />
        &lt;/provider&gt;<br />
    &lt;/prospect&gt;<br />
&lt;/adf&gt;</p></td>
</tr>
</tbody>
</table>

</div>

Template of STAR-XML:

<div class="table-wrap">

<table class="confluenceTable" data-layout="default">
<colgroup>
<col />
</colgroup>
<tbody>
<tr>
<td class="confluenceTd"><p>&lt;?xml version="1.0" encoding="UTF-8"?&gt;</p>
<p>&lt;soapenv:Envelope</p>
<p>xmlns:soapenv = "<a href="http://schemas.xmlsoap.org/soap/envelope/" class="external-link" rel="nofollow">http://schemas.xmlsoap.org/soap/envelope/</a>"&gt;</p>
<p>&lt;soapenv:Header&gt;</p>
<p>&lt;wsse:Security xmlns:wsse="<a href="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" class="external-link" rel="nofollow">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd</a>"&gt;</p>
<p>&lt;wsse:UsernameToken wsu:Id="UsernameToken-85" xmlns:wsu="<a href="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-" class="external-link" rel="nofollow">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-</a></p>
<p>wssecurity-utility-1.0.xsd"&gt;</p>
<p>&lt;wsse:Username&gt;{{GMIT provided_user_name}}&lt;/wsse:Username&gt;</p>
<p>&lt;wsse:Password Type = "<a href="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText" class="external-link" rel="nofollow">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText</a>"&gt;</p>
<p>{{GMIT provided password}}&lt;/wsse:Password&gt;</p>
<p>&lt;/wsse:UsernameToken&gt;</p>
<p>&lt;/wsse:Security&gt;</p>
<p>&lt;/soapenv:Header&gt;</p>
<p>&lt;soapenv:Body&gt;</p>
<p>&lt;star:ProcessServiceAppointment</p>
<p>xmlns:star="<a href="http://www.starstandard.org/STAR/5" class="external-link" rel="nofollow">http://www.starstandard.org/STAR/5</a>"</p>
<p>xmlns:oagis="<a href="http://www.openapplications.org/oagis/9" class="external-link" rel="nofollow">http://www.openapplications.org/oagis/9</a>"</p>
<p>languageCode = "en-US"</p>
<p>systemEnvironmentCode = "Prod/Test"</p>
<p>releaseID = "5.0.4"&gt;</p>
<p>&lt;star:ApplicationArea&gt;</p>
<p>&lt;star:CreationDateTime&gt; 2020-04-02T15:09:00.084Z &lt;/star:CreationDateTime&gt;</p>
<p>&lt;star:Sender&gt;</p>
<p>&lt;star:SenderNameCode&gt; {{Provider Name}} &lt;/star:SenderNameCode&gt;</p>
<p>&lt;star:CreatorNameCode&gt; {{Provider Name}} &lt;/star:CreatorNameCode&gt;</p>
<p>&lt;star:DealerNumberID&gt; {{BAC Code}} &lt;/star:DealerNumberID&gt;</p>
<p>&lt;star:AuthorizationID&gt; {{Campaign Code}} &lt;/star:AuthorizationID&gt;</p>
<p>&lt;star:ServiceID&gt; {{Provider Service}} &lt;/star:ServiceID&gt;</p>
<p>&lt;/star:Sender&gt;</p>
<p>&lt;star:BODID&gt; {{Lead ID}} &lt;/star:BODID&gt;</p>
<p>&lt;star:Destination/&gt;</p>
<p>&lt;/star:ApplicationArea&gt;</p>
<p>&lt;star:ProcessServiceAppointmentDataArea&gt;</p>
<p>&lt;star:Process/&gt;</p>
<p>&lt;star:ServiceAppointment&gt;</p>
<p>&lt;star:ServiceAppointmentHeader&gt;</p>
<p>&lt;star:DocumentIdentificationGroup&gt;</p>
<p>&lt;star:DocumentIdentification&gt;</p>
<p>&lt;star:DocumentID&gt; {{Lead ID}}&lt;/star:DocumentID&gt;</p>
<p>&lt;/star:DocumentIdentification&gt;</p>
<p>&lt;/star:DocumentIdentificationGroup&gt;</p>
<p>&lt;star:OwnerParty&gt;</p>
<p>&lt;star:SpecifiedPerson&gt;</p>
<p>&lt;star:GivenName&gt; {{firstName}} &lt;/star:GivenName&gt;</p>
<p>&lt;star:FamilyName&gt; {{lastName}} &lt;/star:FamilyName&gt;</p>
<p>&lt;star:TelephoneCommunication&gt;</p>
<p>&lt;star:ChannelCode&gt; W &lt;/star:ChannelCode&gt;</p>
<p>&lt;star:LocalNumber&gt; {{phone}} &lt;/star:LocalNumber&gt;</p>
<p>&lt;/star:TelephoneCommunication&gt;</p>
<p>&lt;star:URICommunication&gt;</p>
<p>&lt;star:URIID&gt; {{email}} &lt;/star:URIID&gt;</p>
<p>&lt;/star:URICommunication&gt;</p>
<p>&lt;/star:SpecifiedPerson&gt;</p>
<p>&lt;/star:OwnerParty&gt;</p>
<p>&lt;star:ServiceAppointmentVehicleLineItem&gt;</p>
<p>&lt;star:ServiceVehicle&gt;</p>
<p>&lt;star:ModelYear&gt; {{Vehicle Year}}&lt;/star:ModelYear&gt;</p>
<p>&lt;star:ModelDescription&gt; {{Vehicle Model}} &lt;/star:ModelDescription&gt;</p>
<p>&lt;star:MakeString&gt; {{Vehicle Make}} &lt;/star:MakeString&gt;</p>
<p>&lt;star:VehicleID&gt; {{Vehicle VIN}} &lt;/star:VehicleID&gt;</p>
<p>&lt;/star:ServiceVehicle&gt;</p>
<p>&lt;/star:ServiceAppointmentVehicleLineItem&gt;</p>
<p>&lt;/star:ServiceAppointmentHeader&gt;</p>
<p>&lt;/star:ServiceAppointment&gt;</p>
<p>&lt;/star:ProcessServiceAppointmentDataArea&gt;</p>
<p>&lt;/star:ProcessServiceAppointment&gt;</p>
<p>&lt;/soapenv:Body&gt;</p>
<p>&lt;/soapenv:Envelope&gt;</p></td>
</tr>
</tbody>
</table>

</div>

Example of the STAR-XML:

<div class="table-wrap">

<table class="confluenceTable" data-layout="default">
<colgroup>
<col />
</colgroup>
<tbody>
<tr>
<td class="confluenceTd"><p>&lt;?xml version="1.0" encoding="UTF-8"?&gt;<br />
&lt;soapenv:Envelope xmlns:soapenv="<a href="http://schemas.xmlsoap.org/soap/envelope/" class="external-link" rel="nofollow">http://schemas.xmlsoap.org/soap/envelope/</a>"&gt;<br />
&lt;soapenv:Header&gt;<br />
&lt;wsse:Security xmlns:wsse="<a href="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd" class="external-link" rel="nofollow">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd</a>"&gt;<br />
&lt;wsse:UsernameToken wsu:Id="UsernameToken-85" xmlns:wsu="<a href="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd" class="external-link" rel="nofollow">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd</a>"&gt;<br />
&lt;wsse:Username&gt;a45735_pp_digitalair&lt;/wsse:Username&gt;<br />
&lt;wsse:Password Type="<a href="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText" class="external-link" rel="nofollow">http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText</a>"&gt;&amp;amp;quiljdhovxvoWwsfpjhauoczqjxf5ex&lt;/wsse:Password&gt;<br />
&lt;/wsse:UsernameToken&gt;<br />
&lt;/wsse:Security&gt;<br />
&lt;/soapenv:Header&gt;<br />
&lt;soapenv:Body&gt;<br />
&lt;star:ProcessServiceAppointment xmlns:star="<a href="http://www.starstandard.org/STAR/5" class="external-link" rel="nofollow">http://www.starstandard.org/STAR/5</a>" xmlns:oagis="<a href="http://www.openapplications.org/oagis/9" class="external-link" rel="nofollow">http://www.openapplications.org/oagis/9</a>" languageCode="en-US" releaseID="5.0.4" systemEnvironmentCode="Prod/Test"&gt;<br />
&lt;star:ApplicationArea&gt;<br />
&lt;star:CreationDateTime&gt;2020-03-31T22:35:00.159Z&lt;/star:CreationDateTime&gt;<br />
&lt;star:Sender&gt;<br />
&lt;star:SenderNameCode&gt;Digital Air Strike&lt;/star:SenderNameCode&gt;<br />
&lt;star:CreatorNameCode&gt;Digital Air Strike&lt;/star:CreatorNameCode&gt;<br />
&lt;star:DealerNumberID&gt;246435&lt;/star:DealerNumberID&gt;<br />
&lt;star:AuthorizationID&gt;561148&lt;/star:AuthorizationID&gt;<br />
&lt;star:ServiceID&gt;DAS Response Path&lt;/star:ServiceID&gt;<br />
&lt;/star:Sender&gt;<br />
&lt;star:BODID&gt;5e838b4105e2030007b9502f&lt;/star:BODID&gt;<br />
&lt;star:Destination/&gt;<br />
&lt;/star:ApplicationArea&gt;<br />
&lt;star:ProcessServiceAppointmentDataArea&gt;<br />
&lt;star:Process/&gt;<br />
&lt;star:ServiceAppointment&gt;<br />
&lt;star:ServiceAppointmentHeader&gt;<br />
&lt;star:DocumentIdentificationGroup&gt;<br />
&lt;star:DocumentIdentification&gt;<br />
&lt;star:DocumentID&gt;5e838b4105e2030007b9502f&lt;/star:DocumentID&gt;<br />
&lt;/star:DocumentIdentification&gt;<br />
&lt;/star:DocumentIdentificationGroup&gt;<br />
&lt;star:OwnerParty&gt;<br />
&lt;star:SpecifiedPerson&gt;<br />
&lt;star:GivenName&gt;STAR&lt;/star:GivenName&gt;<br />
&lt;star:FamilyName&gt;Service 2&lt;/star:FamilyName&gt;<br />
&lt;star:TelephoneCommunication&gt;<br />
&lt;star:ChannelCode&gt;W&lt;/star:ChannelCode&gt;<br />
&lt;star:LocalNumber&gt;1113335656&lt;/star:LocalNumber&gt;<br />
&lt;/star:TelephoneCommunication&gt;<br />
&lt;star:URICommunication&gt;<br />
&lt;star:URIID&gt;<a href="mailto:servicelead@leads.com" class="external-link" rel="nofollow">servicelead@leads.com</a>&lt;/star:URIID&gt;<br />
&lt;/star:URICommunication&gt;<br />
&lt;/star:SpecifiedPerson&gt;<br />
&lt;/star:OwnerParty&gt;<br />
&lt;star:ServiceAppointmentVehicleLineItem&gt;<br />
&lt;star:ServiceVehicle&gt;<br />
&lt;star:ModelYear&gt;2019&lt;/star:ModelYear&gt;<br />
&lt;star:ModelDescription&gt;Camaro&lt;/star:ModelDescription&gt;<br />
&lt;star:MakeString&gt;Chevrolet&lt;/star:MakeString&gt;<br />
&lt;star:VehicleID/&gt;<br />
&lt;/star:ServiceVehicle&gt;<br />
&lt;/star:ServiceAppointmentVehicleLineItem&gt;<br />
&lt;/star:ServiceAppointmentHeader&gt;<br />
&lt;/star:ServiceAppointment&gt;<br />
&lt;/star:ProcessServiceAppointmentDataArea&gt;<br />
&lt;/star:ProcessServiceAppointment&gt;<br />
&lt;/soapenv:Body&gt;<br />
&lt;/soapenv:Envelope&gt;</p></td>
</tr>
</tbody>
</table>

</div>

To Test on a ADF-XML (via Email) in CRM on production **(please do it only in the most inevitable cases, as it's CRM of a real company)**:

Go to <a href="https://www.eleadcrm.com/" class="external-link" rel="nofollow">https://www.eleadcrm.com/</a> (use VPN, because it's unavailable in Belarus), and sign in with these credentials for Brown’s Fairfax Nissan (p1615):

username: nissanrhh\
password: Nissan1212

Send a test email with the new generated adf-xml to the company’s email and view it on the eLead site. Please use “test” in the name and email so Brown’s knows not to view the leads. Search for the test email in the top left corner of eLeads, find the lead, click the name, scroll down in the history and click on “View” on the row for the Internet Lead to view how the conversation history renders.

Messages from provider should be blue and in the left, from visitor - green and in the right.

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://paralect.atlassian.net/wiki/download/thumbnails/958399360/adf-xml%20in%20crm.png?version=1&amp;modificationDate=1563194674755&amp;cacheVersion=1&amp;api=v2&amp;height=250" class="confluence-embedded-image confluence-external-resource image-center" data-image-src="https://paralect.atlassian.net/wiki/download/thumbnails/958399360/adf-xml%20in%20crm.png?version=1&amp;modificationDate=1563194674755&amp;cacheVersion=1&amp;api=v2&amp;height=250" loading="lazy" /></span>

------------------------------------------------------------------------

Leads from all channels (Web, SMS, FB) are sent to all integration services.
