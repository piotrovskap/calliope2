---
source: DAS Confluence
page_id: 2749661212
title: "04/11/2024 - Direct Integration with Google for Performance Max Campaigns"
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2749661212
type: confluence-doc
pulled: 2026-06-11 (manual paste — API token unavailable on this workstation; re-pull via scripts/repull-confluence.py when credentials restored)
note: authored April 2024; documents PMAX automation system, Ad-Ez booking integration, Merchant Center account auto-creation, ~$180k/yr savings from direct management vs. partner; authored by Matthew Hinman
---

# 04/11/2024 - Direct Integration with Google for Performance Max Campaigns

By Matthew Hinman

---

## Solution Release Notes

**DAS Solution:** MediaLogix

### Solution Overview

Leveraging our proprietary inventory merchandising technology, DAS Technology Awareness Solutions enable businesses to attract more leads & customers through targeted messaging and advertising on social media, streaming, search, and 3rd party marketplace platforms.

### Nature of Release

The DAS Technology Automated Google Performance Max Management System is crafted to boost the efficiency of the DAS Technology Team. Its primary goal is to enhance the scalability of our Google Performance Max services and support our strategic objective of strengthening our independent management skills. This launch marks the beginning of our pilot program. During this phase, we will evaluate the system's robustness and train the team on maximizing the benefits of this new automation tool.

### Release Date

4/11/24

---

## New Features & Enhancements

### Key Benefits to Clients & Consumers

#### Direct Integration with Google for Performance Max Campaigns: Automated System and Management Tools

**Opportunity:**
Google Vehicle Ads (GVA) were originally designed for automotive-specific campaigns, whereas Google Performance Max (PMAX) allows DAS Technology to integrate a broader range of Google's advertising capabilities into its vehicle advertisements, harnessing more advanced machine learning to target consumers. In transitioning our campaigns from GVA to PMAX, DAS Technology recognized a significant opportunity. Establishing a direct integration with Google for account and campaign creation with PMAX would notably decrease costs and enhance efficiency. Through this integration, we were able to develop an automated system with supporting tools to address the complexities of large-scale management of Google platforms post-Ad-Ez booking and capitalize on the advanced analytics provided by the new Google platform.

**Solution:**
Introducing DAS Technology's enhanced integration with Google for Performance Max Campaigns, revolutionizing the inventory merchandising suite and how the DAS Technology Team engages with Google. This system retains the familiar booking process of Ad-Ez, yet introduces an automated option, reducing the need for manual transitions between different Google platforms during account and campaign setups. The automation covers several critical areas:

**Campaign Booking in Ad-Ez:**
To support this automated system, we've refined the Ad-Ez booking interface. Users can now select 'Automated Campaign' to activate the automation or choose to maintain traditional processes. This enhancement simplifies the workflow and empowers our team to manage campaigns more effectively.

**Google Ads and Merchant Center Account Creation:** Accounts are automatically configured and linked, ensuring seamless integration and setup.

**Performance Max Management Dashboard:** This new tool grants users complete control over their Google campaigns, with features including:

- **Google My Business Status Tracking:** This feature allows for easy monitoring of the status of an account's Google Merchant Center linkage and website approvals, which is imperative in successfully launching a Google Performance Max campaign.
- **Vehicle Ads Management:** Automated updates on the status of the 'Vehicle Ad Onboarding Form' and adjacent verification processes.
- **Onboarding Progress Tracker:** Users can check the completion and approval status of 'Vehicle Ads On-boarding Contact Us Form' with automatic updates being pushed to the dashboard.

**Rollout Plan:**
The transition to in-house management of Performance Max Campaigns will commence with a phased approach. Initially, a portion of our campaigns will be transitioned from our partnered management process to our all-new internal process. During this first phase, key members of the DAS Technology team will be familiarized with the new system to support training efforts as we prepare for full integration. The gradual shift will ensure a smooth transition while we reposition our partnership to focus on other strategic areas.

**Value:**
The enhanced Google integration for Performance Campaigns significantly improves operational efficiency and campaign management. By reducing manual intervention and streamlining processes, DAS Technology not only cuts costs but also improves campaign performance and reporting accuracy. With the planned transition and realignment of our partnership objectives, DAS Technology will realize approximately $15,000 in monthly savings, amounting to $180,000 saved annually. This advancement is a testament to our commitment to innovation and excellence in digital campaign management.

**Expected Outcomes:**
With these enhancements, we anticipate more precise campaign executions, reduced operational delays, and a more robust digital advertising framework. This initiative is set to enhance the strategic impact of the inventory merchandising suite and strengthen our market position by leveraging cutting-edge technology to meet the evolving needs of our clients.

---

## Bugs

### Display Auto Campaigns Stuck in 'Planned'

**Problem:** There was an issue where campaigns scheduled for automatic renewal were instead remaining in the 'Planned' status. This problem arose after an API, which supported the renewal process, was deprecated on February 21, 2024.

**Solution:** To address this, the MediaLogix Team developed an updated integration utilizing the new API. This solution was successfully implemented, as evidenced by the automatic renewal of campaigns in April without any issues.

### Undesired Merging of Ad-Ez Accounts

**Problem:** An unintended merge of Ad-Ez accounts occurred when the inventory team attempted to address an existing issue. This merge was brought to the attention of the MediaLogix Team.

**Solution:** The MediaLogix Team Lead took initiative by directly accessing the database to rectify the merging error. He provided detailed documentation on the location of the issue and the specific steps taken to resolve it, enabling the inventory team to handle similar problems in the future independently, without needing further assistance from the MediaLogix Team.

---

## Product & Technology Team

- Product Manager – Jane Zhang
- Product Owner – Alex McClelland
- Software Engineers – Tim Chan, Manuel Ochoa
- QA Engineer – Delia Martinez, Saul Torres

---

SharePoint Link to Release Library: Release Notes

DAS Technology
©2024 DAS Technology | For internal purposes. Not for distribution. Reproduction Prohibited.
