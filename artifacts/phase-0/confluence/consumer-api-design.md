---
source: DAS Confluence
page_id: 1780613121
title: Consumer API Design
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/1780613121
type: confluence-doc
repulled: 2026-06-09
---

<div class="panel">

<div class="panelContent">

## Goals

- Build a prototype of an API that will centralize customer information

</div>

</div>

## What is Consumer API?

The Consumer API is an interface that will provide a way to link various information about a customer into a single profile that <span class="inline-comment-marker" ref="e2ba31bd-d74d-4910-a522-b347a2b7fd7e">describes customer journey (purchase, service, sale, trade in, etc..) .</span>

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/1f4d0.png" class="emoticon emoticon-blue-star" data-emoji-id="1f4d0" data-emoji-shortname=":triangular_ruler:" data-emoji-fallback="📐" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> Requirements and Goals of the System

------------------------------------------------------------------------

We'll focus on the following set of requirements while designing the Consumer API:\

**Functional Requirements**

1.  API consumers should be able to <span class="inline-comment-marker" ref="5f766a66-89a1-4cd2-8831-33e68930fd12">send consumer information</span>

2.  API consumers should be able to query on various criteria to lookup a consumer

3.  There should be a user interface to display consumers with joined data points

4.  There should be a user interface to manage unmatched consumers

\
**Non-Functional Requirements**

1.  The ability  to match accurately should take priority over the time it takes to process a request\

**Not in scope**: <span class="inline-comment-marker" ref="cac55a11-0ec0-4ada-b3ae-5d1a01ab6487">Security, Scale, Reliability and Redundancy, Monitoring</span>

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/1f4d0.png" class="emoticon emoticon-blue-star" data-emoji-id="1f4d0" data-emoji-shortname=":triangular_ruler:" data-emoji-fallback="📐" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> Design Considerations

------------------------------------------------------------------------

The system will be write-heavy so we will focus on building a system that can write consumer information quickly.

1.  API consumers should be able to write quickly and return status that provide a means track the progress of the data uploaded

2.  Data should be 100% reliable, the system will guarantee that <span class="inline-comment-marker" ref="b931b6c7-e47d-454c-9d3f-de4ea5282499">data </span>will never be lost.

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/1f4d0.png" class="emoticon emoticon-blue-star" data-emoji-id="1f4d0" data-emoji-shortname=":triangular_ruler:" data-emoji-fallback="📐" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> High Level System Design

------------------------------------------------------------------------

At a high level, we need to support two scenarios, one to write consumer information and the other to review/search consumer information. For consumer information being stored there should be a database server to store information and a queuing mechanism to manage the amount of resources used to process each request.

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/2328.png" class="emoticon emoticon-blue-star" data-emoji-id="2328" data-emoji-shortname=":keyboard:" data-emoji-fallback="⌨" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> Rest API Design

The following could be the definitions of the APIs to create/retrieve data:\

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
POST /api/v1/consumer
addCustomer ([FromBody] ConsumerInfo consumerInfo) 
```

</div>

</div>

**Parameters**:\
consumerInfo (object): object graph describing the consumer\
\
**Returns:** (string)\
Adds the lead information to a queue to be processed. A successful insertion returns a status token which can be used to <span class="inline-comment-marker" ref="521cea60-fea9-4d83-9069-64f7c4d47895">monitor the progress of the consumer being processed</span>.

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
GET /api/v1/consumer?page=0&count=100
getConsumers (int page, int count) 
```

</div>

</div>

**Parameters:**\
page - the page to which to return a list of consumers\
count - the maximum number of consumers to return\
 \
**Returns:** (List)\
An object graph list of consumers

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
GET /api/v1/consumer/search?.....
searchConsumers([FromQuery] ConsumerSearchRequest request)
```

</div>

</div>

**<span class="inline-comment-marker" ref="20dab095-8765-42f1-a6a9-14c15b65a62a">Parameters</span>:**\
request (object):  object graph describing the search criteria\
 \
**Returns:** (List)\
An object graph list of consumer

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
PUT /api/v1/consumer/merge?consumerId=some_id
mergeConsumer(string consumerId, [FromBody] ConsumerInfo consumerInfo)
```

</div>

</div>

**Parameters:**\
consumerId- the consumer to associate the information with\
consumerInfo (object) - object graph <span class="inline-comment-marker" ref="b1d5a926-1171-4294-b911-93505df03246">describing the </span>consumer\
\
**Returns:** (status code)\
Copies the consumer information to the consumer profile. A successful merge returns a success status code (200).

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
GET /api/v1/consumer/status?id=token_id
getStatus(string Id)
```

</div>

</div>

**Parameters:**\
Id - the token id that identifies the consumer in the queue 

**Returns:** (object graph)\
An object with a description of state of the consumer information being processed. Will contain a profile identifier if the consumer is new/existing.

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
GET /api/v1/statistics
getMetrics()
```

</div>

</div>

**Parameters:**\
None

**Returns:** (Object graph)\
An object that describing various aggregated data about the customers (matched vs unmatched)

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/1f4d0.png" class="emoticon emoticon-blue-star" data-emoji-id="1f4d0" data-emoji-shortname=":triangular_ruler:" data-emoji-fallback="📐" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> Database Design

------------------------------------------------------------------------

We need to store data about the customer's journey which will be various data points aggregated from different inputs feeding the system. The following is a list of information will need to generate a complete picture of a customer journey:

- Consumer - descriptive information that uniquely identifies a customer

- Activity - describes how the customer was interacting online/offline and also how DAS services were interacting with the customer.

- Sundry - information about a customer that match to more than one customer

- Status - information about a <span class="inline-comment-marker" ref="55e7923d-8907-460c-ba62-7e3036f32b35">consumer </span>being processed\

Going with a NoSQL database (MongoDB) allows for flexibility to define extended information about the customer's journey that is unique to the system that submitted the information. The raw information associated with the customer is never lost and traceable back to the system that submitted it.

 

**<span class="inline-comment-marker" ref="7cce4013-c5b1-43b5-b9ac-fb31f572608f">Consumer</span>**

- Id (guid): unique id

- Name (string):  first, middle, and last name

- <span class="inline-comment-marker" ref="fd08c13c-0f52-4b0e-ab4d-3ebc20d8da5d">FirstName (string): first name</span>

- MiddleName (string): middle name

- <span class="inline-comment-marker" ref="fd08c13c-0f52-4b0e-ab4d-3ebc20d8da5d">LastName (string): last name</span>

- <span class="inline-comment-marker" ref="1e80087b-0fca-4578-9a10-799a284457d4">Phonenumbers (array): contact number</span>

- <span class="inline-comment-marker" ref="1e80087b-0fca-4578-9a10-799a284457d4">Email (array): email address</span>

- <span class="inline-comment-marker" ref="1e80087b-0fca-4578-9a10-799a284457d4">Address (array): street address</span>

- Activities (array): activities associated with the customer

 

**Activity**

- Id (guid): unique id

- CreateDate (datetime): date the activity was created

- ActivityDate (datetime): date the activity took place

- Summary (string): information about the activity

- Metadata (object) : extended information about the activity

 

**Sundry**

- Id (guid): unique id

- CreateDate (datetime): date the entry was created

- ConsumerInfo (object): consumer information

 

**<span class="inline-comment-marker" ref="17825ca8-4cfd-4427-b0b6-5e86b548103b">Status</span>**

- queueId (guid) - value that identifies the message in the queue

- consumerId (guid) - unique identifier of a consumer associated

- webhookUrl (string) - callback web hook url

- messages (array) - timestamp and description of the state of lead being processed

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/1f4d0.png" class="emoticon emoticon-blue-star" data-emoji-id="1f4d0" data-emoji-shortname=":triangular_ruler:" data-emoji-fallback="📐" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> Component Design

------------------------------------------------------------------------

At a high level, we need an application layer that will serve all the read and write requests.\

**How to handle a write request?**

All of the write API calls for consumers will fall into a queue and wait until a resource comes available to process the information. When a message is received from the queue a process will begin to identify an existing consumer in the database and merge that information. If the information cannot be matched it will automatically generate a new consumer profile and add it to the database. If the information happens to match more than one consumer the information is stored in the database to later be matched manually. In the meantime a token will be returned to the caller that identifies the consumer in the queue that can be used to monitor the status of the information being processed. This way time is given for the matching process to run with higher levels of accuracy without the concern of a time constraint.\

**How to handle a read request?**

Upon receiving a read request the application layer contacts the datastore directly and returns the requested information.

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/1780613121/LHwz4.T1mWLy%3Fa=504&amp;x=28&amp;y=165&amp;w=1772&amp;h=770&amp;store=1&amp;accept=image%2F*&amp;auth=LCA%2083354e84b61a8673b95553539fa58c76270ca257-ts%3D1621290573?api=v2" class="confluence-embedded-image image-center" /></span>

## <img src="https://digitalairstrike.atlassian.net/wiki/s/-1142484374/6452/ad5455d6bf94fe815abb715723034fb59b4ac436/_/images/icons/emoticons/72/2705.png" class="emoticon emoticon-blue-star" data-emoji-id="2705" data-emoji-shortname=":white_check_mark:" data-emoji-fallback="✅" data-emoticon-name="blue-star" width="16" height="16" alt="(blue star)" /> Action Items

<div class="table-wrap">

|  |  |  |  |
|----|----|----|----|
|  | **Description** | **Owner** | **Jira ticket** |
| 1 | Investigate and Provide Plan to Set Up Consumer API and Database | <a href="https://digitalairstrike.atlassian.net/wiki/people/5e4c39345a495e0c91a82693?ref=confluence" class="confluence-userlink user-mention" data-account-id="5e4c39345a495e0c91a82693" target="_blank" data-base-url="https://digitalairstrike.atlassian.net/wiki">Donelle Sanders (Unlicensed)</a> | <a href="https://digitalairstrike.atlassian.net/browse/CA-174" class="external-link" data-card-appearance="inline" rel="nofollow">https://digitalairstrike.atlassian.net/browse/CA-174</a> |
| 2 |  |  |  |

</div>
