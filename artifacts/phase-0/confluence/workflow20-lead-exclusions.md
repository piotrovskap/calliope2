---
source: DAS Confluence
page_id: 346488942
title: Managing Lead Source Exclusions in Workflow 2.0: A Guide to Stored Procedures and Papertrail Tracking
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/346488942
type: confluence-doc
repulled: 2026-06-09
---

In workflow 2.0, most new sources will be created by client advocates, activations, and support personnel using the UI that will be integrated into Extranet.  Initially, however, we will still create sources by manually executing the underlying stored procedures that will eventually power the UI.  This is how to do it.

## Viewing Current Exclusions

If you'd like to see any exclusions currently applied to a franchise (in this example, franchise ID 100000), simply execute the following stored procedure on OLTP:

> <sup>EXEC franchise_excluded_lead_sources_reader @franchise_id = 100000;</sup>

If you want to check out a single exclusion, simply provide the ID (example in this case is 3), execute the following on OLTP:

> <sup>EXEC franchise_excluded_lead_sources_reader @id = 3</sup>

If you want to see **all** exclusions for **all** franchises, execute the following stored procedure on OLTP:

> <sup>EXEC franchise_excluded_lead_sources_reader @pull_all_franchises = 1;</sup>

**NOTE:**  You can also view the date when the exclusion was created, as well as who created it, here as well.

## Creating a New Exclusion

If the dealer (example franchise ID 100000) no longer wants to quote TrueCar, then you would execute an the following upsert stored procedure with the following parameters:

> <sup>EXEC franchise_excluded_lead_sources_upsert @franchise_id = 100000, @lead_source = 'TrueCar', @processing_action = 'Pass Through';</sup>

Available processing actions are "Pass", "Pass Through", and "Ignore".

- **Pass** - SmartFollow but no SmartQuote.  Lead redirected (if applicable).  Appears in lead table.

- **Pass Through** - No SmartQuote or SmartFollow.  Lead redirected (if applicable).  Appears in lead table.

- **Ignore** - No SmartQuote or SmartFollow.  Lead redirected (if applicable).  Does not appear in lead table.

**NOTE: ** If they have multiple franchises, you'd need to run the aforementioned stored procedure once for each franchise ID.

## Changing an Existing Exclusion

If you wanted to update an exclusion, you'd run the same upsert but this time include the ID of the exclusion, as well as any parameters you want to change.  For example, if you wanted to change an exclusion's lead source, you would do something like this (exclusion ID is 3 in this example, and we're changing the lead source to "Edmunds Price Promise":

> <sup>EXEC franchise_excluded_lead_sources_upsert @id = 3, @lead_source = 'Edmunds Price Promise';</sup>

**NOTE:**  Changes are logged in the papertrails.

## Deleting an Exclusion

If you'd like to delete an exclusion, simply provide the ID of the exclusion that you'd like to delete (3 in this example) and set the "delete" tag to 1, like so:

> <sup>EXEC franchise_excluded_lead_sources_upsert @id = 3, @delete = 1;</sup>

**NOTE:**  Deletions are logged in the papertrails.

## Viewing Papertrails for an Exclusion

If you want to see who updated or deleted an exclusion, simply run the following stored procedure on OLTP and provide the ID of the exclusion (3 in this example), like so:

> <sup>EXEC franchise_excluded_lead_sources_papertrail_reader @id = 3;</sup>

## Creating Papertrails for an Exclusion

**Don't do this manually**-- let the "update" upsert handle it.  But if for some reason you *absolutely* have to, here's what you'd need to supply (note that all values are just example values-- you'd need to supply your own correct/pertinent values):

> <sup>EXEC franchise_excluded_lead_sources_papertrail_upsert @id = 3,</sup>\
> <sup>@before_lead_source = 'TrueCar',</sup>\
> <sup>@after_lead_source = 'Edmunds',</sup>\
> <sup>@before_processing_action = 'Pass Through',</sup>\
> <sup>@after_processing_action = 'Pass Through',</sup>\
> <sup>@modification_date = GETDATE(),</sup>\
> <sup>@modifier = 'bdavis';</sup>
