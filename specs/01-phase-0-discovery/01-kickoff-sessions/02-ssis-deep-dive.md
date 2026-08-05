---
title: "SSIS Infrastructure Deep Dive"
type: story
status: done
priority: high
estimate: M
labels: [ssis, infrastructure, phase-0]
date: "2026-06-08"
artifacts:
  - "SSIS review debrief | /analysis/sessions/ssis-review-2026-06-08/results/analysis.html"
  - "ETL/SSIS inventory | docs/etl-data-inventory.md"
---

Reviewed the existing SSIS data integration landscape: 13 SSIS jobs, the monitoring dashboard, failure modes, and the underlying AWS EC2/RDS infrastructure.

**With:** Rick Sorich and the DAS engineering team.

**Outcome:** Captured job inventory and infrastructure topology. Rick committed to DWRPT access and to sourcing verified job descriptions from the engineers. Surfaced the Mileone_reward_member failure and tightly coupled job dependencies as risks for ETL modernization.
