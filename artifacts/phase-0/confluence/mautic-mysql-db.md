---
source: DAS Confluence
page_id: 3141664794
title: Mautic MySQL DB Deep Dive
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3141664794
type: confluence-doc
repulled: 2026-06-09
---

## Security/Compliance

#### *lack of backups has me concerned. However, it is a relatively few databases to consider, so server backups still work.*

Single table Audit_log is 271 GB in size plus another 60 in the index:

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3141664794/image-20231101-063714.png?api=v2" class="confluence-embedded-image image-center" width="760" /></span>

This is too large for MS SQL, much less than MySQL

There is another table that is 121 GB in size as well called email_stats

## Scalability

#### *This database should be able to expand, but only if the audit_log and the emails_stats are brought under control.*

large individual tables will kill databases fairly quickly unless those tables are not accessed regularly.

MySQL has its limits, many built into it on purpose by Oracle. This will be a problem scaling up this application. The use of flat-files to ingest data is also problematic, especially since I can connect directly to MySQL with SQL or ADF

## Supportable

#### *While we have several MySQL servers and can support the database, the use of my SQL on a 400GB database is suspect.*

I think we will quickly run into support issues with MySQL on this database, but that is a personal observation. under the right circumstances it will work fine, just not sure this is it.

## Costs

#### *lets get these two offending tables down in size and keep it there.*

## Recommendations

I do not believe Mautic can go to MS SQL, but if can it should go there unless the data tables are reduced in size. This could be accomplished with some additional archiving or cleanup.

There are a lot of unused tables in the database. I would like to see if they can be leveraged in the application. If not, no worries

I will need to understand the server size. MySQL, especially, is sensitive to memory allocation. If a query on MySQL overruns memory, instead of swapping to disk, MySQL terminates the connection.

Currently, I do not consider this application, in its current configuration, to be scalable. MySQL is an Achille's heel.
