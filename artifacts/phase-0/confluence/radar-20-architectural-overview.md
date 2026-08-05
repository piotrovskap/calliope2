---
source: DAS Confluence
page_id: 2045509692
title: Architectural Overview - Radar 2.0
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2045509692
type: confluence-doc
repulled: 2026-06-09
---

The following article documents how Radar is designed and how to find areas of the software in the codebase.

For complete reference see <a href="https://lucid.app/lucidchart/a6334191-935c-4b4a-b395-e6f5636ff64e/edit?invitationId=inv_50dd13c5-ce3f-48dc-9d1d-46ebe89339db" class="external-link" rel="nofollow">Lucid Chart Diagram</a>.

## **Infrastructure Design**

Radar is designed like a microservice architecture to allow the software to scale fairly easily as it grows. There a several different components that collectively make up Radar system and are categorized by Front End and Back End components. The external resources that Radar depends on are indicated in the External Resources section:

- Reviews Database - A <a href="https://azure.microsoft.com/en-us/services/cosmos-db/" class="external-link" rel="nofollow">Cosmos</a> database resource where all reviews that Digital Air Strike collects from various websites are stored.

- Radar Database - A <a href="https://www.mongodb.com/" class="external-link" rel="nofollow">MongoDB</a> database resource where reviews are stored and managed by the Radar application.

- Account Management API Service - An App Service resource where client account information is managed for all Digital Air Strike customers.

- Reviews API Service - An App Service resource that manages interactions with review data stored in the Reviews Database. It also provides various utility functionality such as: posting reviews to websites, interaction with review ingestion services, etc..

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2045509692/image-20211018-161134.png?api=v2" class="confluence-embedded-image image-left" width="340" /></span>

For detailed information on the actual Azure resources for each of these components please see <a href="https://digitalairstrike.visualstudio.com/Radar/_wiki/wikis/Radar.wiki/11/Radar-Configuration-Settings" class="external-link" rel="nofollow">Radar Configuration Settings - Overview (visualstudio.com)</a> in the Radar project in Azure DevOps.

## **Front End Design**

Radar is separated into several different areas with key responsibilities:

- Configurations - This API manages client account information and how reviews are ingested as well as other various options associated with the account.

- Reviews - The API manages reviews for all client accounts in Radar. This is the main part of Radar that digital reps interact with 90% of the time in Radar.

- Templates - This API manages review and email responses. These are generic templates that apply to various review sentiments.

- Tags - This API manages collections of client accounts associated by name identifier(s). Mainly used to filter reviews collectively instead of individually.

- Review Sites - This API manages review sites for all client accounts in Radar. These sites represent what reviews Radar will ingest and manage per client account.

The following is a diagram of the web application infrastructure that is used by the Digital Reputation Specialist

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2045509692/image-20211015-213744.png?api=v2" class="confluence-embedded-image image-left" width="340" /></span>

All of the data is stored in a document based databased called <a href="https://www.mongodb.com/" class="external-link" rel="nofollow">MongoDB</a> and separated into individual collections by domain.

- reviews - Managed by the Reviews API

- clientConfigurations - Managed by the Configurations API

- reviewSites - Managed by the ReviewSites API

- tags - Managed by the Tags API

- reviewTemplates - Managed by the Templates API

- keywordCategories - Managed by the Configurations API

- keywords - Managed by the Configuratoins API

- metrics - Managed by Reviews API

The Azure Function Apps where each of the APIs are located is the core of how data moves back and forth between the client web application and the database. The API Gateway facilitates how this information is translated, stored, and viewed.

## **Backend Design**

Radar has two main components that pump data into the system in order for it to function: Radar Reviews Importer and Radar Client Configuration Synchronization *(should be called importer)*. These two processes is how reviews and client configuration enter into the Radar application for Digital Reputation Specialists to interact with. The following sections will provide a detail overview of how each process operates and its dependency.

### Radar Client Configuration Synchronization *(Radar.Sync Function App)*

Client accounts are stored in external databases separate from Radar’s system which require reaching out to an external service in which that data can be retrieved. So in order for Radar to know what accounts are signed up for reputation management services it would have to periodically pull this information into it’s own system. Radar synchronization process connects to the Account Management Service API and requests all active client accounts and figures out if any of those accounts exist in Radar and if not adds it to Radar. The following diagram illustrates the process:

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2045509692/image-20211018-171857.png?api=v2" class="confluence-embedded-image image-left" width="340" /></span>

Currently this process runs every hour and creates default client configurations in Radar for those client accounts that currently doesn’t exist in Radar. These accounts have default configuration profile which require someone from CAST to log into Radar and configure the account with the appropriate sites the client has requested to be managed. Also the account will require a Digital Reputation Specialist to further configure the account with other options which determines how reviews are managed for that account. The following is an example of where in Radar this service affects:

<span class="confluence-embedded-file-wrapper image-left-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2045509692/image-20211018-172508.png?api=v2" class="confluence-embedded-image image-left" /></span>

### Radar Reviews Importer *(Radar.Reviews.Importer Function App)*

Reviews are stored in an external database separate from Radar’s system and are managed by a series of processes called Ingestion Services. The Ingestion Services are processes that collect reviews from external websites such as Google for clients that are signed up for Reputation Services and stores this information into a single database. Radar’s importer service subscribes to insert and update events of this database which triggers the importer service to operate on the raw review data whether its to create a new review or update an existing review. The importer service indirectly depends on the client synchronization process for creating new client configurations in order know how to configure reviews once they are imported. The following diagram illustrates this process:

<span class="confluence-embedded-file-wrapper image-left-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2045509692/image-20211018-174122.png?api=v2" class="confluence-embedded-image image-left" width="340" /></span>

Each review is associated with a client account which has a account configuration in Radar and each configuration has properties that determines how and when reviews should be responded to and what features each review may use in the application. For example, if the review can be responded to directly inside the application or if the review requires that the dealership validate the response to a review prior to publishing it on the website. This process is very important to Radar’s system as it is the window into which the Digital Reputation Specialist can respond to reviews. The following is an example of where in Radar this service affects:

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2045509692/image-20211018-174724.png?api=v2" class="confluence-embedded-image image-center" /></span>
