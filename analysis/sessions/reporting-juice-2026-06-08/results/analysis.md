# Conflict AI - Review of Reporting (Juice) 2026-06-08

## Summary

# Summary

This transcript documents a meeting at the start of summer where a team discusses their data reporting infrastructure and tools. The core group includes regular attendees, though some members may join intermittently based on availability. The team acknowledges that their data comes from multiple sources of varying quality, including outdated SSIS jobs that require careful handling to avoid consuming manipulated data.

The discussion centers on **Guice**, a reporting engine similar to Power BI that enables product team members (primarily Jacob) to build client-facing reports through a drag-and-drop interface without engineering involvement. However, Guice has significant limitations—most notably, it cannot perform database joins, requiring the team to consolidate multi-source data in their data warehouse reporting database (DWRPT) at the SQL level before presenting it to Guice.

The team is not committed to Guice long-term and is already exploring alternatives. While Guice itself won't be accessible to new team members, access to the underlying data warehouse reporting database—which contains all tables and views powering the analytics—can be provided. The speaker demonstrates a sample Guice report from their 3Birds/Dash CDXP site, showing how users can filter data by various parameters like campaign methods and communication channels.

## Key Points

- **Core team established for the project**
  A core group of team members identified, with some flexibility for others to join based on availability

- **Data quality issues from multiple sources**
  Reporting data comes from multiple sources with varying quality; some SSIS jobs are outdated and not ideal for CDP consumption

- **Raw data preferred over manipulated data**
  Preference to consume raw data from SSIS processes rather than end results to allow selective use of data pieces

- **Guice is a reporting engine, not a long-term priority**
  Guice functions like Power BI for drag-and-drop report building; not critical for long-term roadmap and alternatives are being explored

- **Guice has technical limitations with joins**
  Guice cannot perform joins across multiple data sources; data must be joined at SQL level in DWRPT before presenting to Guice

- **Data quality improvements implemented**
  Common Client ID implemented to improve table joins; discovered data cleanliness issues

- **Guice reports are client-facing**
  Reports generated in Guice are used for client-facing purposes; built by internal product team (primarily Jacob), non-technical users

- **Data warehouse contains multiple schemas**
  Data organized by application schemas (e.g., SL for Social Logic, ML for MediaLogic) to prevent data conflation

- **Guice embedded via iframe with security controls**
  Guice reports embedded in company portal using iframe with login requirements and specific security rules

- **Power BI available but resource constraints**
  Power BI available but lack of internal Power BI developers; offshore team utilized to avoid taking engineering resources

## Knowledge Graph

```mermaid
graph LR
    Ron["Ron"]:::person
    CDXP["CDXP"]:::technology
    Guice["Guice"]:::technology
    Javis["Javis"]:::technology
    Views["Views"]:::concept
    DWRPT["DWRPT"]:::technology
    Reports["Reports"]:::concept
    AWS["AWS"]:::technology
    Power_BI["Power BI"]:::technology
    SSIS["SSIS"]:::technology
    data_warehouse["data warehouse"]:::technology
    reporting["reporting"]:::concept
    Negative_View_Analysis["Negative View Analysis"]:::technology
    Jarvis["Jarvis"]:::technology
    CIM["CIM"]:::technology
    historical_data["historical data"]:::concept
    iframe["iframe"]:::technology
    Portal["Portal"]:::concept
    Juice["Juice"]:::technology
    ADF["ADF"]:::technology
    AI["AI"]:::concept
    vehicle["vehicle"]:::concept
    service_dates["service dates"]:::concept
    Tables["Tables"]:::concept
    usage_patterns["usage patterns"]:::concept
    Ron -- "can provide information about" --> reporting
    SSIS -- "provides data to" --> reporting
    Guice -- "is similar to" --> Power_BI
    Ron -- "has knowledge of" --> Guice
    DWRPT -- "feeds data to" --> Guice
    Guice -- "generates" --> Reports
    Guice -- "similar functionality to" --> Power_BI
    Reports -- "contains" --> Views
    Portal -- "embeds" --> iframe
    Ron -- "assigned to work on" --> Power_BI
    CDXP -- "hosted in" --> AWS
    SSIS -- "manages data flow for" --> CDXP
    Juice -- "consumes data from" --> Views
    Javis -- "built over" --> AI
    DWRPT -- "feeds data to" --> AI
    Javis -- "technically sits on" --> AWS
    Jarvis -- "related to data migrations in" --> AWS
    Ron -- "has access to/involved with" --> Jarvis
    CDXP -- "tracks" --> vehicle
    reporting -- "has problems originating from" --> CDXP
    vehicle -- "has associated" --> service_dates
    CIM -- "holds" --> historical_data
    Ron -- "makes point about not actively monitoring" --> data_warehouse
    usage_patterns -- "describes traffic on" --> data_warehouse
    classDef person fill:#f9d5e5,stroke:#333,stroke-width:1px
    classDef concept fill:#eeeeee,stroke:#333,stroke-width:1px
    classDef diagram fill:#d5f9e5,stroke:#333,stroke-width:1px
    classDef time fill:#e5d5f9,stroke:#333,stroke-width:1px
```
