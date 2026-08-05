---
source: DAS Confluence
page_id: 3190816811
title: AI Micro Service API
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3190816811
type: confluence-doc
repulled: 2026-06-09
---

# Das Central AI Services

Das Central AI Services provides a comprehensive suite for managing AI models, tracking API usage, and monitoring inference histories. This API supports operations for creating, updating, deleting, and retrieving models across multiple AI platforms. Additionally, it offers capabilities for prompt management, chat history retrieval, AI-powered search functionalities, and seamless integration with OpenAI and Gemini models for advanced AI solutions.\
\
Postman link\
\
<a href="https://app.getpostman.com/join-team?invite_code=d3551f78292198f839a921a0cae6751994551e0537b8354545bc87941b7bc192&amp;target_code=377e3d89ccfefabd2ccfee98ed737d13" class="external-link" data-card-appearance="inline" rel="nofollow">https://app.getpostman.com/join-team?invite_code=d3551f78292198f839a921a0cae6751994551e0537b8354545bc87941b7bc192&amp;target_code=377e3d89ccfefabd2ccfee98ed737d13</a>

## Setting up the Repo

Follow these steps to set up the repository locally:

Repository location: <a href="https://github.com/dastechnology/shared-svcs-aiservice" class="external-link" data-card-appearance="inline" rel="nofollow">https://github.com/dastechnology/shared-svcs-aiservice</a>

1.  Clone the repository:

    Bash

    <div class="code panel pdl">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
          git clone https://github.com/dastechnology/shared-svcs-aiservice.git
    ```

    </div>

    </div>

2.  Navigate into the repo:

    Bash

    <div class="code panel pdl">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
          cd shared-svcs-aiservice
    ```

    </div>

    </div>

3.  Pull the latest changes:

    Bash

    <div class="code panel pdl">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
          git pull
    ```

    </div>

    </div>

4.  After making changes, commit and push:

    Bash

    <div class="code panel pdl">

    <div class="codeContent panelContent pdl">

    ``` syntaxhighlighter-pre
          git add .
    ```

    </div>

    </div>

    `git commit -m 'Your commit message'`

    `git push origin main`

5.  Establish your local environment as per the documentation.

## Architecture Diagram

For a detailed view of the system architecture, please refer to the <a href="https://lucid.app/lucidchart/6877feba-ece8-45b3-aa88-78a58887a8f8/edit?page=7ezayB~FQlW7&amp;invitationId=inv_17c75674-7718-402c-8791-97eaee686662" class="external-link" rel="nofollow">Lucidchart diagram</a>.

## Repo Structure

The repository is organized into several key components:

├── Configs ├── Data ├── Functions ├── Program.cs ├── Service └── Utilities

- **Configs**: Contains configuration settings like `CustomOpenApiConfigurationOptions.cs` for OpenAPI documentation.

- **Data**: This layer contains data access objects for CosmosDB, such as `CosmosContainerService.cs`, and interfaces for managing models, history, and prompts.

- **Functions**: Defines Azure Function entry points for AI models (`LLMApi.cs`), chat history (`HistoryApi.cs`), model management (`ModelApi.cs`), and tracking requests (`TrackingApi.cs`).

- **Service**: Business logic for AI services, including `AIService` for handling OpenAI and Gemini interactions, as well as `ChatService` for LLM-related operations.

- **Utilities**: Helper utilities, such as `HttpUtilities.cs`, providing shared logic for HTTP operations.

## Azure Resource Link

This project is tightly integrated with Azure infrastructure, including CosmosDB for data persistence and Azure Cognitive Search for search capabilities. The relevant Azure resources are:

- **CosmosDB Account**: The service stores inference history, model information, and prompt data in a CosmosDB instance. The connection string is configured in `local.settings.json` with `CosmosConnectionString`.

- **Azure Cognitive Search**: Used for AI-powered search across models and data. The endpoint and API key are set via the `AzureAISearch` settings in the project configuration.

You can review or manage these resources in the Azure portal by navigating to the respective service (CosmosDB and Azure Cognitive Search).

## Technology Stack Details

The AI microservice is built using a modern stack of technologies to support efficient and scalable AI operations. Below is an overview of the key technologies used:

- **.NET 8 Azure Functions**: The project is built on Azure Functions (version 4, using .NET 8 runtime) in an isolated process, providing an event-driven compute platform that scales based on demand.

- **CosmosDB**: A globally distributed, multi-model NoSQL database service used for high-performance storage of AI inference histories, API usage, and models.

- **OpenAI and Gemini APIs**: The microservice integrates with OpenAI and Google’s Gemini models via API to facilitate advanced AI model operations, such as chat, inference, and content generation.

- **Azure Cognitive Search**: Provides AI-powered search capabilities, allowing fast and efficient querying of AI models and related data.

- **Application Insights**: Utilized for monitoring and logging the health, performance, and telemetry of the service.

- **Microsoft Azure SDKs**: The project makes use of various Azure SDKs for CosmosDB (`Microsoft.Azure.Cosmos`) and Functions (`Microsoft.Azure.Functions.Worker.Extensions.Http`).

Contact Support: Name: GitHub Repository

# **How to Start a Chat Session (Using Merge Dictionaries & Supplemental Tracking)**

You can **reuse** existing **Model** and **Prompt** objects if you already have their IDs. If not, you can create them as needed. This guide also shows how to incorporate **supplemental tracking** (e.g., History Summaries, Refine Searches) and how to merge extra data into your prompt.

------------------------------------------------------------------------

## **1. Obtain or Create a Model Object**

- **If you already have a Model ID**

  - Go to **Step 2**.

- **Otherwise, create a new Model**

  - **Endpoint:** `POST /model`

  - **Required Fields:**

    - `LLMName` (string)

    - `ModelName` (string)

    - `ClientId` (string)

    - `ContextWindow` (string)

------------------------------------------------------------------------

## **2. Obtain or Create a Prompt Object**

- **If you already have a Prompt ID**

  - Go to **Step 3**.

- **Otherwise, create a new Prompt**

  - **Endpoint:** `POST /prompt`

  - **Required Fields:**

    - `Value` (string)

    - `ClientId` (string)

------------------------------------------------------------------------

## **3. (Optional) Create Supplemental Tracking Objects**

If you plan to leverage **History Summaries** or **Refine Searches**, create those tracking objects **first**.

- **Endpoint**: `POST /tracking`

- **Type** could be:

  - `"HistorySummary"` for summarizing chat history.

  - `"RefineSearch"` for preprocessing user input before sending to a search provider.

### **Required Fields**

- `modelId` (string)

- `ClientId` (string)

- `Type` (string): `"HistorySummary"` or `"RefineSearch"`

- `Prompt` (object)

**Save** the **Tracking IDs** for these supplemental objects to reference them in your main Chat tracking.

------------------------------------------------------------------------

## **4. Create or Update the Main Chat Tracking Object**

When you create the main **Chat** tracking object, you can also **merge** additional data into your prompt via the `mergeDictionary`.

### **Endpoint**

Plain Text

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
bashCopyEditPOST /tracking
```

</div>

</div>

### **Required Fields**

- `modelId` (string): The ID of the model you’re using.

- `ClientId` (string)

- `Type` = `"Chat"`

- `prompt`

### **Optional Fields**

- SupplementalAIs

- jsonCopyEdit{ "prompt": { "promptId": "", "mergeDictionary": { "dod61": "", "aute_54": "", "magna_62e": "" } }}

#### **Example Request Body**

Plain Text

<div class="code panel pdl">

<div class="codeContent panelContent pdl">

``` syntaxhighlighter-pre
{
```

</div>

</div>

` "modelId": "MODEL_ID",`

` "ClientId": "CLIENT_ID",`

` "Type": "Chat",`

` "prompt": {`

` "promptId": "PROMPT_ID",`

` "mergeDictionary": {`

` "name": "Gary",`

` "aute_54": "another_value",`

` "magna_62e": "additional_value"`

` }`

` },`

` "SupplementalAIs": {`

` "HistorySummary": {`

` "trackingId": "HISTORY_TRACKING_ID",`

` "data": {}`

` },`

` "RefineSearch": {`

` "trackingId": "REFINE_TRACKING_ID",`

` "data": {}`

` }`

` },`

` "Data": {`

` "IncludeHistory": true,`

` "RequestHistorySize": 25400,`

` "MaxOutputSize": 0,`

` "Temperature": null,`

` "DataSourceId": null,`

` "RequestContextSize": 0,`

` "ContextFilter": null,`

` "SearchParam": null`

` },`

`}`

**Note**:

- If you leave out `id` in the request, a new tracking record is created.

- If you include `id` and it already exists, the system updates that tracking record.

------------------------------------------------------------------------

## **5. Send a Chat Request**

After creating the **Chat** tracking object, use its **Tracking ID** to send user input.

- **Endpoint**: `POST /chat`

- **Required Fields**:

  - `Text` (string): The user’s input

  - `TrackingId` (string): The newly created or updated Chat tracking ID

#### **Behavior**

- **History Summary** (if configured) triggers automatically when chat history grows too large.

- **Refine Search** (if configured) refines user input before forwarding it to the search provider.

**mergeDictionary** merges custom data into the prompt at runtime, allowing additional context or parameters.
