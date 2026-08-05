---
source: DAS Confluence
page_id: 369950721
title: Application Domain Solutions Overview
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/369950721
type: confluence-doc
repulled: 2026-06-09
---

Below is a listing of approved 3rd party solutions for various infrastructure problem domains

<div class="table-wrap">

<table class="confluenceTable" data-table-width="1800" data-layout="full-width" data-local-id="267047fd-9321-4b4c-8e3f-a597f893707a">
<tbody>
<tr>
<th class="confluenceTh"><p><strong>Domain</strong></p></th>
<th class="confluenceTh"><p><strong>Referred To As</strong></p></th>
<th class="confluenceTh"><p><strong>Approved Solution</strong></p></th>
<th class="confluenceTh"><p><strong>Host</strong></p></th>
<th class="confluenceTh"><p><strong>Compare to</strong></p></th>
<th class="confluenceTh"><p><strong>Notes</strong></p></th>
</tr>
&#10;<tr>
<td class="confluenceTd"><p>Authentication/Authorization</p></td>
<td class="confluenceTd"><p>Auth</p></td>
<td class="confluenceTd"><p><a href="https://auth0.com/" class="external-link" rel="nofollow">Auth0</a></p></td>
<td class="confluenceTd"><p>Auth0</p></td>
<td class="confluenceTd"><p>Okta</p></td>
<td class="confluenceTd"><p>Does not include identity.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Application Gateway</p></td>
<td class="confluenceTd"><p>Gateway</p></td>
<td class="confluenceTd"><p><a href="https://konghq.com/solutions/gateway/" class="external-link" rel="nofollow">Kong</a></p></td>
<td class="confluenceTd"><p>Kubernetes (GCP) / Aptible (AWS)</p></td>
<td class="confluenceTd"><p>Azure Application Gateway, Kraken, Apigee</p></td>
<td class="confluenceTd"><p>Used for application endpoint routing, security, and other L7 concerns.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Service Discovery</p></td>
<td class="confluenceTd"></td>
<td class="confluenceTd"><p><a href="https://konghq.com/solutions/gateway/" class="external-link" rel="nofollow">Kong</a></p></td>
<td class="confluenceTd"><p>Kubernetes (GCP) / Aptible (AWS)</p></td>
<td class="confluenceTd"><p>etcd, consul</p></td>
<td class="confluenceTd"><p>Services/containers can register themselves with Kong on startup.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Code Repository</p></td>
<td class="confluenceTd"><p>Source Control or VCS</p></td>
<td class="confluenceTd"><p><a href="https://www.bitbucket.org" class="external-link" rel="nofollow">BitBucket</a></p></td>
<td class="confluenceTd"><p>Atlassian (AWS)</p></td>
<td class="confluenceTd"><p>GitHub, GitLabs</p></td>
<td class="confluenceTd"></td>
</tr>
<tr>
<td class="confluenceTd"><p>Build/Deploy (CICD)</p></td>
<td class="confluenceTd"><p>Build Server or CICD</p></td>
<td class="confluenceTd"><p><a href="https://bitbucket.org/product/features/pipelines" class="external-link" rel="nofollow">BitBucket Pipelines</a></p></td>
<td class="confluenceTd"><p>Atlassian (AWS)</p></td>
<td class="confluenceTd"><p>Jenkins, Bamboo, CircleCI, Travis</p></td>
<td class="confluenceTd"></td>
</tr>
<tr>
<td class="confluenceTd"><p>Static Code Analysis</p></td>
<td class="confluenceTd"><p>Code Quality</p></td>
<td class="confluenceTd"><p><a href="https://www.sonarqube.org/" class="external-link" rel="nofollow">SonarQube</a></p></td>
<td class="confluenceTd"><p>GCP</p></td>
<td class="confluenceTd"><p>NDepend, TeamCity</p></td>
<td class="confluenceTd"><p><a href="https://code-analysis.dasdev.io/sessions/new?return_to=%2F" class="external-link" rel="nofollow">https://code-analysis.dasdev.io/</a></p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Endpoint documentation and client code generation</p></td>
<td class="confluenceTd"><p>Docs</p></td>
<td class="confluenceTd"><p><a href="https://swagger.io/" class="external-link" rel="nofollow">Swagger</a> and/or <a href="https://cloud.google.com/endpoints/" class="external-link" rel="nofollow">Cloud Endpoints</a></p></td>
<td class="confluenceTd"><p>Per application</p></td>
<td class="confluenceTd"></td>
<td class="confluenceTd"><p>Used for automatic documentation and code generation of web endpoints to/from OpenAPI specs. Swagger is needed at the application level, but Cloud Endpoints provides a central location for many APIs.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Caching</p></td>
<td class="confluenceTd"><p>Caching</p></td>
<td class="confluenceTd"><p><a href="https://redis.io/" class="external-link" rel="nofollow">Redis</a></p></td>
<td class="confluenceTd"><p>GCP/Azure/Aptible</p></td>
<td class="confluenceTd"><p>Memcached</p></td>
<td class="confluenceTd"></td>
</tr>
<tr>
<td class="confluenceTd"><p>Service Bus</p></td>
<td class="confluenceTd"><p>Service Bus</p></td>
<td class="confluenceTd"><p><a href="https://www.rabbitmq.com/" class="external-link" rel="nofollow">RabbitMQ</a></p></td>
<td class="confluenceTd"><p>CloudAMQP (GCP) / Azure</p></td>
<td class="confluenceTd"><p>MSMQ, Azure Service Bus, SQS, Redis Pub/Sub</p></td>
<td class="confluenceTd"><p>RMQ is the approved transport layer. Any management library may be used with it, but keep message framing in close consideration to ensure we are enabling communication between all of our components. Production systems are running on CloudAMQP while dev/test systems are running in private instance on Azure.</p>
<p>Legacy is currently using Azure Queues which we need to deprecate. Continued use of this service for new development is not approved.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>RPC</p></td>
<td class="confluenceTd"><p>RPC or Service Bus</p></td>
<td class="confluenceTd"><p><a href="https://grpc.io/" class="external-link" rel="nofollow">gRPC</a></p></td>
<td class="confluenceTd"><p>Per application</p></td>
<td class="confluenceTd"><p>SOAP</p></td>
<td class="confluenceTd"><p>Use as an alternative to HTTP/REST for more direct communication between internal services when queue transport is unacceptable. </p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Event Sourcing</p></td>
<td class="confluenceTd"><p>Event Sourcing</p></td>
<td class="confluenceTd"><p><a href="https://eventstore.org/" class="external-link" rel="nofollow">EventStore</a></p></td>
<td class="confluenceTd"><p>Azure</p></td>
<td class="confluenceTd"></td>
<td class="confluenceTd"><p>Use when state must be projected from a log stream. Replaces OLTP database in DDD projects.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Logging</p></td>
<td class="confluenceTd"><p>Logging</p></td>
<td class="confluenceTd"><p><a href="https://www.loggly.com/" class="external-link" rel="nofollow">Loggly</a></p></td>
<td class="confluenceTd"><p>Loggly</p></td>
<td class="confluenceTd"><p>Splunk, ELK, Seq, etc.</p></td>
<td class="confluenceTd"><p>See <a href="https://airstrike.loggly.org" class="external-link" rel="nofollow">https://airstrike.loggly.org</a></p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Package Management (npm, nuget, maven, visx)</p></td>
<td class="confluenceTd"><p>Package Management</p></td>
<td class="confluenceTd"><p><a href="https://www.myget.org/" class="external-link" rel="nofollow">MyGet</a></p></td>
<td class="confluenceTd"><p>MyGet</p></td>
<td class="confluenceTd"><p>Nuget.org, npmjs.org, etc.</p></td>
<td class="confluenceTd"><p>Private package server for various package types such as nuget, npm, bower, maven, visx, php comp. See <a href="https://airstrike.myget.org" class="external-link" rel="nofollow">https://airstrike.myget.org</a></p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Docker Image Registry</p></td>
<td class="confluenceTd"><p>Docker Hub or Container Registry</p></td>
<td class="confluenceTd"><p><a href="https://cloud.google.com/container-registry/" class="external-link" rel="nofollow">Google Container Registry</a> (GCR)</p></td>
<td class="confluenceTd"><p>GCP</p></td>
<td class="confluenceTd"><p>Docker Hub</p></td>
<td class="confluenceTd"><p>gcr.io/dasplatform-production/...</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Data Streaming</p></td>
<td class="confluenceTd"><p>Streaming</p></td>
<td class="confluenceTd"><p><a href="https://azure.microsoft.com/en-us/services/event-hubs/" class="external-link" rel="nofollow">Event Hubs</a></p></td>
<td class="confluenceTd"><p>Azure</p></td>
<td class="confluenceTd"><p>Kafka, Kinesis</p></td>
<td class="confluenceTd"><p>Use for high volume data ingestion or event ingestion such as streaming analytics. We will use this primarily as a streaming endpoint into our data tier. </p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Serverless/Lambda</p></td>
<td class="confluenceTd"><p>Functions or Lambda</p></td>
<td class="confluenceTd"><p><a href="https://azure.microsoft.com/en-us/services/functions/" class="external-link" rel="nofollow">Azure Functions</a></p></td>
<td class="confluenceTd"><p>Azure</p></td>
<td class="confluenceTd"><p>AWS Lamda, Google Cloud Functions</p></td>
<td class="confluenceTd"><p>Use for one-off scenarios or as thin integration points between systems. Take care to consider whether or not your functionality would be better lived in another, existing service. Prefer that for maintenance reasons.</p></td>
</tr>
<tr>
<td class="confluenceTd"><p>Blob Storage</p></td>
<td class="confluenceTd"><p>Blobs</p></td>
<td class="confluenceTd"><p><a href="https://azure.microsoft.com/en-us/services/storage/" class="external-link" rel="nofollow">Azure Storage</a> / <a href="https://cloud.google.com/storage/" class="external-link" rel="nofollow">Google Cloud Storage</a></p></td>
<td class="confluenceTd"><p>Azure/GCP</p></td>
<td class="confluenceTd"><p>S3</p></td>
<td class="confluenceTd"><p>Prefer Azure storage when staging files to be ingested into our data tier, otherwise keep the data in the same cloud where it is being used (e.g. GCP for Arsenal).</p></td>
</tr>
</tbody>
</table>

</div>
