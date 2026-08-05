---
source: DAS Confluence
page_id: 3141402685
title: MS SQL .10 DB Deep Dive
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141402685
type: confluence-doc
repulled: 2026-06-09
---

## Security/Compliance

#### *This server was created on 6/26/2023.*

Barring a few exceptions, the databases were restored to this server on 6/26/2023, and was also the last time any database was backed-up. This is a significant issue.

## Scalability

#### *This server is 16 vCPU and 64GB of RAM.*

The largest database is 491GB in size, which would lead to a rough estimate of 120GB server RAM (25% of the size of the largest database):

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3141402685/image-20231025-222544.png?api=v2" class="confluence-embedded-image image-center" width="605" /></span>

## Supportable

#### *This is a SQL 2019 server and is fully supportable by our staff. It is in the AWS environment and will have to be moved to Azure.*

We can use the move to Azure to build a better server template. Again, all data and logs (and temptdb) are pointing to the E Drive. The tempDB drive has a single file, the server is over computational and does not have enough memory for the databases attached.

The environment lacks Dev and QA, Backups have not been completed since 7/5/2023 (The server was created on 6/26/2023). We need to evaluate for possible DR as the ClientDB seems to be critical for operations.

## Innovatable

#### *The database server will integrate with DAS operations fairly smoothly by using ADF instead of SSIS for data processing and ETL functions.*

## Costs

#### *Unfortunately, this server is already pared down to the lowest possible operational cost*
