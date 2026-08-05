---
source: DAS Confluence
page_id: 3141533737
title: MS SQL .32 DB Deep Dive
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141533737
type: confluence-doc
repulled: 2026-06-09
---

## Security/Compliance

There are several red flags in terms of compliance.

First, the password for the primary admin account (helium) is NOT secure.

Second, I am not seeing individual application or system accounts with the exception of juice_analytics. These means a potential lock of an account from a hack attempt has the potential to stop all application access (assuming there are a lot of different applications connecting to the database).

Server is SQL 2019 and appears to be relatively compliant

Server does NOT have a dev environment, and the “production” .32 server has test databases loaded to it. It has also been noted that the dev application servers point to the production databases, which is a terrible idea.

## Scalability

#### Currently this is a SQL2019 server with about 700 GB on disk for EDW_staging and 300GB in EDW_Target. The databases themselves are fairly granular, and while not normalized, it is well structured and extendable. Largest issue will be disk space on hand, the two databases are large and we can expect the database to grow by 5-fold in the current structure. 5TB on disk is within easy limits for SQL2019 except for Disk performance. However, we can adjust for this if we are spinning up new servers in Azure for this platform.

The server requires some significant work to bring up its ability to scale. Most issues with this current server are VM related and not database related (everything on a single drive, lack of tempdb files, parallelism) and can be easily corrected with a new build.

The majority of the SSIS packages run on this machine. The SSIS ETL process consists of ingesting flat-files from various CRM systems, processing the data from pre-stage to stage to production before eventually creating another flat-file to upload to Mautic. These flat-file processing steps are slow and prone to failure. ADF is a far better tool for this kind of processing, as is Databricks. If we were to double the load on these flat-file processes they would most likely collapse, and we already have indications the system is stressed.

## Supportable

#### This is an AWS server running Windows server with MS SQL2019. The sever and MS SQL2019 fall within our support stack, but it will need to be moved off the AWS environment to avoid the need for AWS dev ops.

This server is utilizing SSIS packages for a lot of data processing, we currently do not support SSIS packages in DAS, and would need to migrate these processes to ADF. There is an extensive amount of flat-file processing and movement. In some cases this cannot be avoided, as the data sources are external to the company, however, using flat-file data transfers to Mautic are counter productive and slow.

ADF tools need to be leveraged to clean-up processing and streamline database-to-database direct connections.

## Innovatable

*These databases are now legacy for 3Birds, so ultimately they are used for data processing and not much else. This makes the database fully adaptable as we have no front end to break.*

## Costs

#### *This is a big database that will require a fairly robust VM or machine to run. I currently cannot see the perfmon on this server, so I cannot determine the current load and size. As a rough estimate I would conclude that the server would need 16 vCPU and 128 GB ram, minimum. We currently would need two 1 TB drives for Data and Log and another 256 GB tempDB on a disk pool.*

The server is currently 32vCPU and 256 GB of RAM, single E:drive that may/or may not, be a drive pool, supporting Data, Logs, and tempdb. These should be separated.

## Recommendations

SSIS needs to be taken out of the server processing and moved to ADF. However, there are some structural elements to the stored procs that prosses data that will not work with ADF (such as the use of temp tables.).

I would like to see a change capture or archival function for this data stream. Currently there is no data warehouse available, meaning historical data is either being lost, or is retained on the server, bloating its size.

DR is provided by backups. If this is acceptable then nothing needs to be done, but this should be evaluated by management

This environments is Production, but there are a lot of Dev applications that appear to point to this database server. This is a critical failure and absolutely needs to be corrected. A dev and QA environment, even if small B2 servers, would be far more secure and reliable.

Split the TempDB, Data and Log drives. Currently everything is pointing to the E: Drive, putting an unusual load on the single drive bank.

TempDB should have 8 file groups to take advantage of parallel processing. Currently TempDB is a single file.

Re-evaluate the data server size. It is a large database, but the size of the server is pretty massive for the load I would expect to see. I suspect more horse-power was thrown at it for ETL processing, not realizing the slowdown in data processing is probably caused by the extensive use of flat-file data transfers.
