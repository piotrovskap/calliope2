---
source: DAS Confluence
page_id: 3243343876
title: Architecture Review Action Items:
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3243343876
type: confluence-doc
repulled: 2026-06-09
---

# Diagram:

URL: <a href="https://s.icepanel.io/KgawmUGcNSj2XN/whVI" class="external-link" data-card-appearance="inline" rel="nofollow">https://s.icepanel.io/KgawmUGcNSj2XN/whVI</a>

Pass: dasRL2.0

# Action Items from Meeting:

- Document Index Database should be renamed to RDBMS / NoSql DB

  - This means that you're still trying to figure out if it should be relational or NoSql (Document) DB.

- ALL DBs (NoSql and Relational) should have input from Ron Mulder on the schema, and indexes.

  - Decisions should be documented in Confluence

- ALL DBs should use some schema generation tool so that the schema is defined as part of your code.

- For all API connections

  - please define how auth is done.

  - please call out if its internal or external.

- Answer RL Re-Write Questions - <a href="https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3243442178/Architecture+Diagram+Questions" data-linked-resource-id="3243442178" data-linked-resource-version="5" data-linked-resource-type="page">here</a>

- Adjust any API call to ideally go through the DAS APIM as opposed to going directly to the service

- <span class="inline-comment-marker" ref="7d91b1d6-bea2-4c79-9889-f8f6291bce86">SSO - lets create/determine/buy a SSO solution that we can use for Client Management UI and all other apps</span>
