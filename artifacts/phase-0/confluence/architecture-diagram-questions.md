---
source: DAS Confluence
page_id: 3243442178
title: Architecture Diagram Questions
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3243442178
type: confluence-doc
repulled: 2026-06-09
---

- DAS Acceptor :: SMTP (MTA) - 

  - <span class="inline-comment-marker" ref="70e21323-b6a4-40a1-a4f1-9b42645f3322">How long are the emails kept for?</span>

  - How do you differentiate between leads/spam/unknown?

  - <span class="inline-comment-marker" ref="6c1d07ae-9a95-4e9a-b9df-486e7b2abdf0">Do you allow attachments to emails ? </span>

    - <span class="inline-comment-marker" ref="0399c0da-7541-4ff3-966d-02d509ac2f8a">For what purpose? and what do you do with the attachments? If you save them, do you scan them for viruses?</span>

  - <span class="inline-comment-marker" ref="07b0694e-de36-45f3-866e-35f0b8a9f1e3">How do you know its spam?</span>

  - <span class="inline-comment-marker" ref="2faf5318-9373-45c2-8fbc-23a06ab5106c">How do you auth to the Email Lead Provider Api.</span>

- DAS Acceptor :: Email Lead Provider

  - <span class="inline-comment-marker" ref="b0d7fc3e-6611-4b94-9c80-577304f5ec37">Why does this write the email to the db if its already in the MTA box?</span>

  - <span class="inline-comment-marker" ref="d370d8c6-4d01-40b3-a3e1-9f8f4041b5aa">What details of the email are sent to the Mailbox Database?</span>

- DAS Acceptor :: MailBox Database

  - <span class="inline-comment-marker" ref="9f05cd19-bdde-42ce-9916-8f2409a21c6a">Identify the collections (tables) that are necessary ?</span>

  - <span class="inline-comment-marker" ref="0509c0ca-41e3-4b6c-8941-847a43e8f7f8">Identify any indexes that are necessary ?</span>

  - <span class="inline-comment-marker" ref="6e5af3fb-49ab-4b95-9f1f-f111eead876f">Identify metrics / reports that are needed form this db if any?</span>

  - <span class="inline-comment-marker" ref="70b5a2c4-a06c-4862-957e-89871d1fc619">Per the diagram, nothing is reading from this db so we are writing and forgetting?</span>

- DAS Acceptor :: API

  - <span class="inline-comment-marker" ref="8e6497a2-4fa0-449a-bd96-7a168da81514">Per the diagram, does this write data to the Reporting DB ?</span>

- Responder Service :: DB

  - <span class="inline-comment-marker" ref="a81b5769-ee20-47dd-a6b0-39d44bde8f9c">Identify the collections (tables) that are necessary ?</span>

  - <span class="inline-comment-marker" ref="b35e057c-3483-48fa-9351-ce5529c68d8f">Identify any indexes that are necessary ?</span>

  - <span class="inline-comment-marker" ref="cfa51f74-7a9b-4f18-9eab-5c507edb8d16">Identify metrics / reports that are needed form this db if any?</span>

  - <span class="inline-comment-marker" ref="eb259aa9-7350-42de-916f-2104ff183c8a">Per the diagram, nothing is reading from this db so we are writing and forgetting?</span>

- Inventory Service :: DB

  - <span class="inline-comment-marker" ref="14672d70-822d-495d-aac5-cc5b15a23256">Identify the RDBMS type - mysql ? </span>

  - <span class="inline-comment-marker" ref="0c1824b7-5d5d-406d-9762-2b5e90e73f99">Identify if its heavy read/write</span>

  - <span class="inline-comment-marker" ref="70a20af9-e3ea-4094-9a2c-3227068f28f7">Identify indexes</span>

- Template Service :: DB

  - same as above.

  - <span class="inline-comment-marker" ref="34bd8884-b882-4018-b214-a7c8ea254146">do you really need a db for this? It sounds like these are flat files that you inject data into.</span>

- Central Reporting

  - I'm not seeing what ADF is connected too.

- Lead Database

  - <span class="inline-comment-marker" ref="3c503a65-b63c-4261-9a98-e5ee3971d487">What type of SQL DB is this? Mysql? </span>

- Azure Event Grid

  - <span class="inline-comment-marker" ref="de5898bd-2895-4dcc-9858-ec3f7f804cb8">Lead Events</span> - A picture indicating if its a container in aks or a function in Azure functions

    - <span class="inline-comment-marker" ref="90dba09a-68ae-45a7-b65c-ae7ba766dc33">Are the components containers running in AKS?</span>

    - <span class="inline-comment-marker" ref="16f49928-5c77-4ca2-b243-8db0e030594f">Are the components azure functions that are tied to these events?</span>

  - <span class="inline-comment-marker" ref="24f7cb83-c970-42a0-bdc2-82e080816799">What requirements does the business have around these events? Will they want to know how many of event x are created in some timespan?</span>

- Client Management Service

  - UI will need to be a container running on AKS

- Client Management Service :: API

  - <span class="inline-comment-marker" ref="97c4c85e-95c9-4cc9-aeec-a2902d1bbbc1">I do not see any caching. How will you handle performance issues?</span>

- Client Management Service :: Database

  - <span class="inline-comment-marker" ref="f9001938-3cc2-4903-8511-db616918f65f">Identify the RDBMS type - mysql ? </span>

  - <span class="inline-comment-marker" ref="dba36319-2791-482e-b856-c9e53e86dba6">Identify if its heavy read/write</span>

  - <span class="inline-comment-marker" ref="19e2e40d-77cf-4f10-9a80-60b6580825d8">Identify indexes</span>
