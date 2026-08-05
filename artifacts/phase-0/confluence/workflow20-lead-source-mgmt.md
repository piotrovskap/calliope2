---
source: DAS Confluence
page_id: 346521637
title: Streamlining Lead Source Management: Transitioning from Parsers to Workflow 2.0
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/346521637
type: confluence-doc
repulled: 2026-06-09
---

## Background

The original way of preventing certain lead sources from getting quoted is by using parsers.  Each "parser" is actually a set of 60 or 70 individual fields containing lead-tailored regular expressions statements relating to bits of information we're looking at capturing (year, make, model, customer name, e-mail address, etc.)  Every parser has an associated "processing action" that determines how the RL system will handle the lead further down the line.  Consider this example:

1.  Dealer makes a request to their CA that we not quote TrueCar leads.

2.  CA puts in a ticket to support.  Support verifies the request.

3.  Support puts in a request to the DPS queue to create a new parser for this lead source.

4.  Development investigates the raw lead and either alters an existing parser for that dealer, or, more probably, creates a completely new parser from scratch tailored to the unique needs and attributes of that dealer.

5.  A processing action is assigned to that parser (usually "pass through") and applied to each of the dealers' franchises.

6.  Testing is done to ensure that the regex was formulated correctly.

7.  Development notifies support, who notifies the CA, who notifies the dealer.

What's happening now with this lead source is this:

1.  A TrueCar lead from this dealer arrives in our inbox.

2.  The system iterates through each parser's "identify document" regex field, checking it against the body of the raw lead, looking for a match.

3.  The system identifies a match between the new TrueCar parser and the raw lead, and uses it to extract the rest of the information from the raw lead (make, model, year, etc.)

4.  The system also identifies that there is an associated processing action of "pass through" on this parser, and marks the lead as such.

5.  The lead enters the "prepare lead" component, where a number of values are set based on what was gleaned from the parser, including processing action.

6.  The lead passes through the logic gate set up to handle "pass through" leads, and it follows the rest of the path from there.

There are a few problems with all of this.  One, there's little to no granularity of control.  Because parsers are based on the customer's domain, it's currently not possible to apply a parsing rule to one franchise but not the other.  All TrueCar leads for this customer will be caught for all of their franchises.  You could, in theory, apply the Pass Through action to only one of the franchises and not the other, but what if they have more than one differing source?  You would, by necessity, need to apply the processing actions to both franchises.  Making a new parser for each franchise won't work because they share a CID.

Two, it leads to an ever-expanding catalog of parsers.  We're currently at around 2500 to 3000 parsers, and the system needs to check each one, one at a time, until it finds a match.  This is both difficult to maintain and extremely inefficient from a processing standpoint.  It's also extremely slow.

Three, the entire process has a lot of overhead, and requires developer intervention, which has a high resource cost associated with it.

In short:  It costs the company a lot of money to do things this way, it takes a long time to do something simple like "shut off" a lead source, and is somewhat clumsy in how it applies workflow gates.  It's also impossible to see who created a parser, and when-- or who modified it.  This sometimes leads to inadvertent development overlap.

## Going Forward

Workflow 2.0 decouples workflow (processing actions) from data matching and extraction (parsing).  A new UI in Extranet allows CA's to "shut off" lead sources right then and there while they're on the phone with the dealer.  Instead of the aforementioned process example, we now have this:

1.  Dealer calls and requests that we not quote TrueCar leads.

2.  CA goes into Extranet, adds TrueCar as a source, selects the processing action, and hits save.

3.  The lead source is now turned off.  The dealer is good to go.

Behind the scenes, this is what's happening:

1.  When the CA hits Save, a new entry in a special table in the OLTP database gets created.  It contains the franchise ID that the CA had selected, the lead source name, the desired processing action, etc.  There's more detailed information on what exactly gets created in the Documentation section.  Records of changes/deletions made to a source are documented in a special "papertrail" table.

2.  When the lead gets to the Prepare Lead section, a new subroutine checks this DB table for any entries for the franchise ID.  If anything pops up, the lead sources in them are checked against the body of the raw lead e-mail.  If any matches are found, the associated processing action is used.  If nothing is found, the system just uses whatever was originally assigned to it by the parsers (which will now almost always be the main CRM parsers, which have "normal" processing actions assigned to them).

3.  The lead gets routed through the appropriate logic gate.

This has a few distinct advantages.  One, the CA can create the workflow item in a matter of seconds with NO intervention by development and the waste of resources that comes with it.  Second, it allows us to remove the thousands of "pass through" parsers we're currently using, leaving essentially just the main CRM parsers.  In this way, every lead will essentially get "read" the same way by the same parser, and we decide what to do with the lead afterwards.  This means we will only have a handful of parsers to maintain (instead of thousands), which, by extension, means leads should sail through the parsing checks much more quickly, as there are only a few parsers to check.  Finally, all changes made to all sources are fully documented in a special papertrail table so we can see who modified what, and when.  This assists greatly in communication between personnel if there was a problem or miscommunication regarding how lead sources should be handled.
