---
source: DAS Confluence
page_id: 2048360479
title: Codebase Overview - Radar 2.0
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2048360479
type: confluence-doc
repulled: 2026-06-09
---

This guide will provide and overview of the code in each of the projects to help you understand where everything is located and how they work together.

<div class="toc-macro rbtoc1781043456268">

- [Prerequisites](#CodebaseOverview-Radar2.0-Prerequisites)
- [Project Structure](#CodebaseOverview-Radar2.0-ProjectStructure)
- [Radar Project](#CodebaseOverview-Radar2.0-RadarProject)
  - [Backend](#CodebaseOverview-Radar2.0-Backend)
  - [Frontend](#CodebaseOverview-Radar2.0-Frontend)
- [Radar.Reviews Project](#CodebaseOverview-Radar2.0-Radar.ReviewsProject)
- [Radar.Configurations Project](#CodebaseOverview-Radar2.0-Radar.ConfigurationsProject)
- [Radar.Templates Project](#CodebaseOverview-Radar2.0-Radar.TemplatesProject)
- [Radar.Tags Project](#CodebaseOverview-Radar2.0-Radar.TagsProject)
- [Radar.ReviewSites Project](#CodebaseOverview-Radar2.0-Radar.ReviewSitesProject)
- [Radar.Reviews.Importer Project](#CodebaseOverview-Radar2.0-Radar.Reviews.ImporterProject)
- [Radar.Sync Project](#CodebaseOverview-Radar2.0-Radar.SyncProject)
- [Radar.Shared Project](#CodebaseOverview-Radar2.0-Radar.SharedProject)
- [Radar.Data Project](#CodebaseOverview-Radar2.0-Radar.DataProject)

</div>

## **Prerequisites**

The following requisites are required before we get started:

- That you have a working dev environment (see: <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2045181965/Getting+Started+-+Radar+2.0" data-linked-resource-id="2045181965" data-linked-resource-version="19" data-linked-resource-type="page">Getting Started</a> and <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2045345807/Debugging+Radar+2.0" data-linked-resource-id="2045345807" data-linked-resource-version="15" data-linked-resource-type="page">Debugging Radar</a>)

- That you have working knowledge of Radar’s architecture (see: <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2045509692/Architectural+Overview+-+Radar+2.0" data-linked-resource-id="2045509692" data-linked-resource-version="10" data-linked-resource-type="page">Architectural Overview</a>)

## **Project Structure**

Radar is organized into multiple projects in a directory tree each with its own configurations. The following is the folder structure

- /docker - *External component configurations for docker container*

- /src/Radar - *The code to the user interface (web)*

- /src/Radar.Configurations - *Configurations API Azure Function App*

- /src/Radar.Configurations.Test - *Configurations API Test Suite*

- /src/Radar.Data - *Radar’s Data functionality*

- /src/Radar.Data.Test - *Radar’s Data Test Suite*

- /src/Radar.Reviews - *Reviews API Azure Function App*

- /src/Radar.Reviews.Test - *Reviews API Test Suite*

- /src/Radar.Reviews.Importer - *Reviews Importer Azure Function App*

- /src/Radar.Reviews.Importer.Test - *Reviews Importer Test Suite*

- /src/Radar.ReviewSites - *Review Sites API Azure Function App*

- /src/Radar.ReviewSites.Test - *Review Sites Test Suite*

- /src/Radar.Shared - *Radar’s common components and functionality*

- /src/Radar.Shared.Test - *Radar’s common components Test Suite*

- /src/Radar.Sync - *Radar’s Client Configuration Synchronization Azure Function App*

- /src/Radar.Tags - *Tags API Azure Function App*

- /src/Radar.Tags.Test - *Tags API Test Suite*

- /src/Radar.Templates - *Templates API Azure Function App*

- /src/Radar.Templates.Test - *Templates API Test Suite*

- /src/Build.sln - *Main Visual Studio solution for all the projects*

- /src/Radar.code-workspace - *Main Visual Studio Code workspace for all the projects*

Depending on what IDE you are using each of these projects will be loaded into one workspace. See the following:

**Visual Studio Code**

<span class="confluence-embedded-file-wrapper image-left-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-181957.png?api=v2" class="confluence-embedded-image image-left" /></span>

**Visual Studio Professional**

<span class="confluence-embedded-file-wrapper image-left-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-182256.png?api=v2" class="confluence-embedded-image image-left" /></span>

## **Radar Project**

The Radar project is the client facing web application that the Digital Reputation Specialists interact with and contains all the web interaction code. Many of the new features and updates will take place here. The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- ClientApp - *The SPA portion of the application*

- Configurations - *The configuration elements used in the appSettings.json file*

- Controllers - *The API endpoints for the application*

- Exceptions - *The exception handling types used in the application*

- Extensions - *The extension classes used for various components in the application*

- Helpers - *The partial classes for the API controllers (The meat of the API endpoints)*

- Middleware - *Components used for identity and logging*

- Models - *The models that are used on the client app (SPA)*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- Policies - *The Active Directory Roles implementation (Unused as of this writing)*

- Utils - *Helper class components for various things*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

<span class="confluence-embedded-file-wrapper image-left-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-184608.png?api=v2" class="confluence-embedded-image image-left" /></span>

### Backend

The API controllers are used to interface with the various function apps that govern certain areas of the application. Each of the controllers are name appropriately to match the domain area its responsible for:

- AuthController.cs - The endpoints here manage the Active Directory configurations used by the app.

  - /api/v1/auth

- ConfigurationController.cs - These endpoints manage client account configurations

  - ConfigurationsControllerHelper.cs - The implementation portion of the endpoints

  - /api/v1/configurations

  - Interacts with: **Radar.Configurations**

- KeywordsController.cs - These endpoints manage what keywords are used for all reviews on a client by client bases

  - KeywordsControllerHelper.cs - The implementation portion of the endpoints

  - /api/v1/keywords

  - Interacts with: **Radar.Configurations**

- ReviewsController.cs - These endpoints manage all things related to reviews in the app

  - ReviewsControllerHelper.cs - The implementation portion of the endpoints

  - /api/v1/reviews

  - Interacts with: **Radar.Reviews, Reviews API, Account Management Service API**

- ReviewSitesController.cs - These endpoints manages the review sites in the app. (Currently creating, updating, and deleting has to be done manually)

  - ReviewSitesControllerHelper.cs - The implementation portion of the endpoints

  - /api/v1/reviewsites

  - Interacts with: **Radar.ReviewSites**

- TagsController.cs - These endpoints manage tags in the app

  - TagsControllerHelper.cs - The implementation portion of the endpoints

  - /api/v1/tags

  - Interacts with: **Radar.Tags**

- TemplatesController.cs - These endpoints manage all the response and email templates in the app

  - TemplatesControllerHelper.cs - The implementation portion of the endpoints

  - /api/v1/templates

  - Interacts with: **Radar.Templates**

<span class="confluence-embedded-file-wrapper image-left-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-190329.png?api=v2" class="confluence-embedded-image image-left" /></span>

### Frontend

The frontend of Radar is managed in the ClientApp folder of the project it is a <a href="https://reactjs.org" class="external-link" rel="nofollow">React</a> application and its organized like the following *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- src/assets - *images*

- src/components - *The main directory for all the components for the application*

  - common - *All of the shared components used in the app*

  - login - *The login view of the app*

  - manager - *The manager view of the app for searching reviews*

  - navbar - *The navigation area at the top of the screen*

  - queue - *Manages the queue, filter, folders, and review workspace of the app*

  - settings - *Manages the client accounts, templates, and keywords area of the app*

  - themes - *The theme configuration for the app*

- src/css - *The main stylesheet for the app*

- src/lib - *Shared components used in the app*

  - auth.js - *Manages the Active Directory user authentication*

  - idgenerator.js - *Random id generator*

  - mail.js - *Provides email functionality from within the app*

  - msgraph.js - *Provides functionality for interacting with Active Directory identity*

  - redux.js - *Provides access to Radar’s state data*

  - session.js - *Manages user sessions*

- src/services - *The main directory used to interact with the the various backend API endpoints*

- src/store - *The Redux state management code*

- src/translations - *Static information displayed in different areas of the app. (ie. Navbar labels, Legends, etc..)*

  - ***Note**: Was suppose to be for different languages but … yeah that never happened.*

- src/App.jsx - *Main app view*

- src/index.js - *Entry point into the app*

<span class="confluence-embedded-file-wrapper image-left-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-201628.png?api=v2" class="confluence-embedded-image image-left" /></span>

## **Radar.Reviews Project**

The Radar.Reviews project is the function app that contains all the code for managing reviews. The Radar project API interacts with this function app when dealing with reviews. Generally when changes are made to any parts of review management in the frontend those changes trickle down into this project. Radar Reviews API provides the following functionality:

- Provides review response modifications

- Fetch reviews to be displayed in the review workspace

- Populates the Folder count in the navbar above the queue

- Populates the Queue list with reviews using the Queue Filter

- Provides review search functionality for the Manager section of the app

- Updates and fetches user KPI metrics for publishing reviews

- Provides review comment management for internal users

- Provides review timeline history information

- These areas:

- <span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-205536.png?api=v2" class="confluence-embedded-image image-center" /></span>

Dependencies: **Radar.Shared**, **Radar.Data** projects

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Functions - *Where all of the http endpoints live*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

- host.docker.json - *The host configuration that is copied into the docker container in order for the function to work*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.Configurations Project**

The Radar.Configurations project is the function app that contains all the code for managing client account configurations. The Radar project API interacts with this function app when dealing with account configurations. This API is heavily used by the Settings section of the application. Radar Configurations API provides the following functionality:

- Client account manipulation (ie. Enabling account, updating signatures and contacts, etc..)

- Managing keyword escalation configurations

- These areas:\

  <span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-205416.png?api=v2" class="confluence-embedded-image image-center" /></span>

Dependencies: **Radar.Shared**, **Radar.Data** projects

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Functions - *Where all of the http endpoints live*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

- host.docker.json - *The host configuration that is copied into the docker container in order for the function to work*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.Templates Project**

The Radar.Templates project is the function app that contains all the code for managing email and response templates. The Radar project interacts with this function app when dealing with the management of templates. This API is heavily used by the Queue and Settings sections of the application. Radar Templates API provides the following functionality:

- CRUD functionality for email and response templates

- Fetching and displaying a list of templates in the review workspace

- These areas\

  <span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-210045.png?api=v2" class="confluence-embedded-image image-center" /></span>

Dependencies: **Radar.Shared**, **Radar.Data** projects

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Functions - *Where all of the http endpoints live*

  - Email - *For managing email templates*

  - Responses - *For managing response templates*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

- host.docker.json - *The host configuration that is copied into the docker container in order for the function to work*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.Tags Project**

The Radar.Tags project is the function app that contains all the code for managing tags. Tags is a concept that is used to take a collection of client accounts and represent them as a single name/identifier. Then they are used to filter a set of reviews by the list of clients represented by a name/identifier. The Radar project interacts with this function app when dealing with the management of tags. This API is heavily used by the Queue and Settings sections of the application. Radar Tags API provides the following functionality:

- CRUD functionality for managing tags

- Filtering capabilities for grouping multiple accounts

- These areas\

  <span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-211249.png?api=v2" class="confluence-embedded-image image-center" /></span>

Dependencies: **Radar.Shared**, **Radar.Data** projects

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Functions - *Where all of the http endpoints live*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

- host.docker.json - *The host configuration that is copied into the docker container in order for the function to work*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.ReviewSites Project**

The Radar.ReviewSites project is the function app that contains all the code for managing review sites. The review sites are specific websites that Radar currently supports for collecting reviews. This API currently supports a single functionality which is to retrieve a list of all supported sites. This API is used by the Queue, Manager, and Settings sections of the application. Radar ReviewSites API provides the following functionality:

- Retrieve a list of all support review sites

- These areas\

  <span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2048360479/image-20211018-215100.png?api=v2" class="confluence-embedded-image image-center" /></span>

Dependencies: **Radar.Shared**, **Radar.Data** projects

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Functions - *Where all of the http endpoints live*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

- host.docker.json - *The host configuration that is copied into the docker container in order for the function to work*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.Reviews.Importer Project**

The Radar.Reviews.Importer project is the function app that contains all the code for creating and updating reviews in Radar’s database. This is the source for how reviews are added to Radar. Radar Reviews Importer provides the following functionality:

- Imports and updates existing reviews in Radar database

- On-demand importing of missing reviews via a \*secret\* API call

Dependencies: **Radar.Shared**, **Radar.Data** projects, **Account Management Service API**

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Activities - *The import process broken into individual tasks*

- Functions - *The entry point for the import process*

- Models - *The data models that represent the review data structures from each website*

- Providers - *The individual importers that import specific reviews*

- Utils - *Utility classes*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- docker-deploy.ps1 - *Powershell script for building and deploying Radar locally into docker container*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.Sync Project**

The Radar.Sync project is the function app that contains all the code for creating new client account configurations. This is the source for how client accounts are added to Radar. Radar Sync provides the following functionality:

- Periodically adds new active client accounts to Radar

Dependencies: **Radar.Shared**, **Radar.Data** projects, **Account Management Service API**

The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Entities - *The access token represented as a persisted object*

- Functions - *The entry point for the synchronization process*

- Models - *The data models that represent client settings*

- Utils - *Utility classes*

- pipelines - *The CI/CD configurations for Azure DevOps build environment*

- docker-compose.yml - *Docker container instructions for deploying Radar*

- local.settings-dev.json - *The default local.settings.json configurations for the dev environment*

## **Radar.Shared Project**

The Radar.Shared project contains code used in all of the projects for shared functionality. The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- .vscode - *The settings for the project for Visual Studio Code IDE*

- Extensions - *All purpose classes for manipulating data types*

- Filters - *A list of data types used to transport filter requests between Radar’s Gateway API and the function apps*

- Models - *A list of domain like data types that transport common data across boundaries*

- Requests - *A list of data types used to transport requests between Radar’s Gateway API and the function apps*

- Utils - *Utility classes*

## **Radar.Data Project**

The Radar.Data project contains code used in all of the projects that require domain and database access functionality. The following is the folder structure for this project *(**Note:** I’ve intentionally left out certain files and folders that shouldn’t require explanation in favor of keeping the list short)*:

- vscode - *The settings for the project for Visual Studio Code IDE*

- Domain - *Business objects*

- Exceptions - *Exception objects*

- Extensions - *Dependency injected components and MongoDB registration configurations*

- MongDB - *MongDB specific functionality required to manage data model components*

- Repositories - *The components used to interact with Radar’s database*

- Utils - *Utility classes*
