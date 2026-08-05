---
source: DAS Confluence
page_id: 2290548746
title: Radar
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/2290548746
type: confluence-doc
repulled: 2026-06-09
---

<div class="toc-macro rbtoc1781043460136">

- [Automation Coverage](#Radar-AutomationCoverage)
  - [Radar UI Smoke Test Cases](#Radar-RadarUISmokeTestCases)
  - [Radar API Integration Test Cases](#Radar-RadarAPIIntegrationTestCases)
  - [Radar Test Plans](#Radar-RadarTestPlans)
- [Automation Cadency](#Radar-AutomationCadency)
- [Radar CI/CD process](#Radar-RadarCI/CDprocess)
- [Radar Jenkins Jobs](#Radar-RadarJenkinsJobs)

</div>

# Automation Coverage

<div class="table-wrap">

|                 |                      |                          |
|-----------------|----------------------|--------------------------|
| **Environment** | **UI Smoke Test**    | **Integration API Test** |
| QA(UAT)         | **60** Automated TCs | **36** Automated TCs     |
| Test            | **60** Automated TCs | **36** Automated TCs     |
| Dev             | NA                   | NA                       |
| Production      | **30** Automated TCs | NA                       |

</div>

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2290548746/image-20220923-171021.png?api=v2" class="confluence-embedded-image image-center" /></span>

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2290548746/image-20220923-172321.png?api=v2" class="confluence-embedded-image image-center" /></span>

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2290548746/image-20221004-212945.png?api=v2" class="confluence-embedded-image image-center" /></span>

## Radar UI Smoke Test Cases

| Key | Summary | Type | Priority | Status | Resolution |
|-----|---------|------|----------|--------|------------|

## Radar API Integration Test Cases

| Key | Summary | Type | Priority | Status | Resolution |
|-----|---------|------|----------|--------|------------|

## Radar Test Plans

<style>
    .jira-issue {
        padding: 0 0 0 2px;
        line-height: 20px;
    }

    .jira-issue img {
        padding-right: 5px;
    }
    .jira-issue .aui-lozenge {
        line-height: 18px;
        vertical-align: top;
    }

    .jira-issue .icon {
        background-position: left center;
        background-repeat: no-repeat;
        display: inline-block;
        font-size: 0;
        max-height: 16px;
        text-align: left;
        text-indent: -9999em;
        vertical-align: text-bottom;
    }
</style> <span class="confluence-jim-macro jira-issue" jira-key="RAD-1978" client-id="SINGLE_7364e5fd-dbfb-32d2-92ce-6bd602666849_2290548746_557058:2f5d7ce5-3896-40b4-b932-940b647ab2f8"> <a href="https://digitalairstrike.atlassian.net/browse/RAD-1978" class="jira-issue-key"><span class="aui-icon aui-icon-wait issue-placeholder"></span>RAD-1978</a> - <span class="summary">Getting issue details...</span> <span class="aui-lozenge aui-lozenge-subtle aui-lozenge-default issue-placeholder">STATUS</span> </span>

<style>
    .jira-issue {
        padding: 0 0 0 2px;
        line-height: 20px;
    }

    .jira-issue img {
        padding-right: 5px;
    }
    .jira-issue .aui-lozenge {
        line-height: 18px;
        vertical-align: top;
    }

    .jira-issue .icon {
        background-position: left center;
        background-repeat: no-repeat;
        display: inline-block;
        font-size: 0;
        max-height: 16px;
        text-align: left;
        text-indent: -9999em;
        vertical-align: text-bottom;
    }
</style> <span class="confluence-jim-macro jira-issue" jira-key="RAD-1965" client-id="SINGLE_7364e5fd-dbfb-32d2-92ce-6bd602666849_2290548746_557058:2f5d7ce5-3896-40b4-b932-940b647ab2f8"> <a href="https://digitalairstrike.atlassian.net/browse/RAD-1965" class="jira-issue-key"><span class="aui-icon aui-icon-wait issue-placeholder"></span>RAD-1965</a> - <span class="summary">Getting issue details...</span> <span class="aui-lozenge aui-lozenge-subtle aui-lozenge-default issue-placeholder">STATUS</span> </span>

# Automation Cadency

Radar has 3 Test cycles:

- Radar-Integration

It contains 36 E2E **API** test cases that help us to test the integration between the DB and the backend, as well as the endpoint interactions.

- Radar-smoke

It hold UI tests that help us to determine whether the deployment software build is stable or not, It consists of a minimal set of tests to verify if the important features are working and there are no showstoppers in the build.

- Radar-nightly

This job runs every night all the test (API integration and UI smoke) to ensure the application is stable and it has not being corrupted or damage by a wrong configuration or a DevOps issue.

<div class="table-wrap">

|  |  |  |  |  |
|----|----|----|----|----|
| **Job** | **Number of TCs (QA & Test)** | **Number of TCs (Prod)** | **Duration** | **Cadency** |
| Radar-Integration | **36** | **NA** | 2 min | Every Deployment |
| Radar-nightly | **96** | **NA** | 24 min | Every Night |
| Radar-smoke | **60** | **30** | 24 min - 15 min(prod) | Every Deployment |

</div>

# Radar CI/CD process

**TestProject-smoke Job** 

- Jenkins job to run smoke cycles 

- It’s triggered automatically after every Radar (QA, Test & Prod) deployment

- It reports results in Allure and Xray (Jira) 

- It notifies failures or success in Microsoft Teams 

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2290548746/image-20221004-232257.png?api=v2" class="confluence-embedded-image image-center" /></span>

**Report and Notification Examples**

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2290548746/image-20221006-015821.png?api=v2" class="confluence-embedded-image image-center" /></span>

<span class="confluence-embedded-file-wrapper image-center-wrapper"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/2290548746/image-20221006-015142.png?api=v2" class="confluence-embedded-image image-center" /></span>

# Radar Jenkins Jobs

<a href="http://jenkinsdas.westus2.cloudapp.azure.com:8080/job/TestProject/view/Radar/" class="external-link" rel="nofollow">http://jenkinsdas.westus2.cloudapp.azure.com:8080/job/TestProject/view/Radar/</a>
