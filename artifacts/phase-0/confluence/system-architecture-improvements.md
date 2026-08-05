---
source: DAS Confluence
page_id: 2872246299
title: 07/09/2024 - System Architecture  Improvements
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2872246299
type: confluence-doc
repulled: 2026-06-09
---

<div class="table-wrap">

<table class="confluenceTable" data-table-width="760" data-layout="default" data-local-id="a3bcdac0-a38d-4ddc-b128-cad2920a826c">
<tbody>
<tr>
<td colspan="2" class="confluenceTd"><span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2872246299/att_1_for_2872246299.png?api=v2" class="confluence-embedded-image image-center" width="591" /></span></td>
</tr>
<tr>
<td colspan="2" class="confluenceTd"><p>Solution Release Notes</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>DAS Solution</strong></p></td>
<td class="confluenceTd"><p>MediaLogix</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>Solution Overview</strong></p></td>
<td class="confluenceTd"><p>Leveraging our proprietary inventory merchandising technology, DAS Technology Awareness Solutions enable businesses to attract more leads &amp; customers through targeted messaging and advertising on social media, streaming, search, and 3rd party marketplace platforms.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>Nature of Release</strong></p></td>
<td class="confluenceTd"><p>Backend functionality designed to enhance efficiency and scalability of the Google performance Max Automated System released alongside system architecture improvements aimed to increase reliability and reduce fixed operating costs.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>Go-to-market Support</strong></p></td>
<td class="confluenceTd"><p>Pending training for Media Ops team week of 7/15</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>Release Date</strong></p></td>
<td class="confluenceTd"><p>07.09.24</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>New Features &amp; Enhancements:</strong></p>
<p><strong>Key Benefits to Clients &amp; Consumers</strong></p></td>
<td class="confluenceTd"><p><strong>1. Google Performance Max Automated System: Data Management and Operational Efficiency</strong></p>
<p><strong>Opportunity</strong> – In an effort to enhance our strategic partnership with Google Advertising, DAS Technology is proud to announce the launch of the updated Performance Max Automated System. This system features new integrations between Google platforms and our proprietary advertising technology suite, reinforcing our commitment to innovative digital retail solutions across various industries, including automotive. This marks the debut of an advanced generation of the Performance Max Automated System, aimed at setting new benchmarks in efficiency and integration.</p>
<p><strong>Solution</strong> – Building on the architecture of the initial Google Performance Max Automated System, we have now developed and released two new management tools designed to streamline account creation and activation. Additionally, a new data validation tool preprocesses vehicle data before it is sent to Google, which has reduced activation times, bolstered our partnership with Google, and cut down on vehicle data rejections by over 20% across all clients. Further enhancements include three new features to improve data quality analysis and operational support:</p>
<p>Global Performance Data Analysis: We are now ingesting and analyzing global performance data from Google, using proprietary logic to forecast client campaign performance.</p>
<p>Domain-Based Client Management: To address the challenge of multiple clients sharing a single domain, we have introduced a new capability that uses the domain as a unique identifier, allowing seamless management of data across numerous internal accounts through a single Google Merchant Center Account to individual advertising campaigns.</p>
<p>Error Data Management: A new pipeline has been established to reroute erroneous vehicle data back to our systems for correction, enhancing the reliability and timeliness of the data exchanged between DAS Technology and Google.</p>
<p><strong>Value</strong> – Previously, the outgoing architecture for the Google Performance Max System incurred annual cost savings of $180,000. The introduction of the new Performance Max Automated System underscores our commitment to maintaining/improving these cost savings while enhancing operational efficiency and system effectiveness.</p>
<p><br />
<br />
<strong>2.  System Architecture: Optimization of Various System Components to Enhance Performance, Scalability, and Maintainability</strong><br />
<strong>Opportunity</strong> – In an ongoing effort to modernize our system infrastructure and enhance performance, DAS Technology has embarked on a crucial project to transition our MediaLogix reporting framework from SQL Server 2008 to a more robust and scalable C# environment. This migration not only addresses the end-of-life status of SQL Server 2008 R2 but also aligns with DAS Technology’s strategic goals to improve system scalability, performance, and maintainability across our platforms.</p>
<p><br />
<strong>Solution</strong> – The comprehensive approach to this migration and optimization includes several key initiatives:</p>
<p>Report Migration to C#:</p>
<p>DAS Technology successfully migrated 25 critical dealer reports from SQL Server 2008 to a C# implementation, ensuring functional parity and accuracy with the original SQL-based reports. This transition leverages C#'s robust features to enhance the flexibility and maintainability of our reporting processes.</p>
<p>Note - C# is a standardized computing language that is robust, flexible, and broadly used by the SaaS development community for a wide range of applications</p>
<p>Data Management Enhancements:</p>
<p>Data Scrubbing: DAS Technology conducted a thorough cleansing of unused data within its SQL databases, significantly streamlining data management and improving overall system efficiency.</p>
<p>Data Mapping for PostgreSQL: A complete mapping of data types from SQL Server 2008 to PostgreSQL was executed to facilitate seamless data migration and integration, setting a strong foundation for future scalability.</p>
<p>Performance and Scalability Improvements:</p>
<p>ElasticSearch Integration: By implementing ElasticSearch over our central inventory database, we've enhanced our search capabilities, dramatically improving search performance and user experience within the MediaLogix application.</p>
<p>Crawler Containerization: The migration of DAS Technology’s existing crawler to a containerized environment marks a significant step towards improving scalability and ease of management, aligning with modern DevOps practices.</p>
<p><strong>Value</strong> – This release represents a significant leap forward in DAS Technology’s awareness technology stack, bringing enhanced performance, scalability, and reliability to its systems. The successful migration of reports to C# and integration of advanced technologies like PostgreSQL and ElasticSearch demonstrate DAS Technology’s commitment to leveraging cutting-edge solutions for operational excellence.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>Bugs</strong></p></td>
<td class="confluenceTd"><p><strong>N/A</strong></p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>Product &amp; Technology Team</strong></p></td>
<td class="confluenceTd"><p>Product Owner – Alex McClelland</p>
<p>Software Lead – Tim Chan</p>
<p>Software Developer – Manuel Ochoa</p>
<p>QA Lead – Delia Martinez<br />
QA Engineer – Saul Torres</p></td>
</tr>
<tr>
<td class="confluenceTd"><p><strong>SharePoint Link to Release Library</strong></p></td>
<td class="confluenceTd"><p><a href="https://digitalairstrike.sharepoint.com/:f:/s/DASProductUpdates/EkIi3dZpckNIkl6WcQBbFVoBh7YWv-g4jl5MUnK8Z6gk5A?e=St1yfe" class="external-link" rel="nofollow">Release Notes</a></p></td>
</tr>
<tr>
<td colspan="2" class="confluenceTd"><p><strong><span class="legacy-color-text-default">DAS Technology      </span></strong><span class="legacy-color-text-default"> ©2024 DAS Technology | For internal purposes. Not for distribution. Reproduction Prohibited.</span></p></td>
</tr>
</tbody>
</table>

</div>
