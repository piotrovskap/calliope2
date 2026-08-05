---
source: DAS Confluence
page_id: 3510730771
title: LiveJoin System Architecture and Component Responsibilities
url: https://digitalairstrike.atlassian.net/wiki/spaces/Technology/pages/3510730771
type: confluence-doc
repulled: 2026-06-09
---

## 📘 Purpose

This document provides a **developer-level overview** of the architecture, functionality, and responsibilities of each component that powers the **LiveJoin** feature in Engage To Sell (ETS).\
It explains how configuration changes, chat events, and backend services work together to deliver real-time joiner invitations and communication.

------------------------------------------------------------------------

## 🧠 Overview

The **LiveJoin** feature allows dealership staff (“joiners”) to receive **real-time chat invitations** when specific rules are met — typically when a visitor engages with an agent on a dealership website.

LiveJoin operates across multiple components, each performing a unique function:

<div class="table-wrap">

|  |  |
|----|----|
| Layer | Description |
| **ETS Dashboard** | Configuration and administrative UI |
| **Rocket.Chat Lead Plugin** | Real-time event and trigger logic |
| **LiveJoin3 Service (Server)** | Backend processing, rule evaluation, and invite distribution |
| **SendGrid** | Email delivery |
| **Twilio** | SMS delivery (if configured) |

</div>

Each component integrates via REST APIs and socket connections to provide a seamless real-time experience.

------------------------------------------------------------------------

## 🧩 Component Breakdown

### 1️⃣ ETS Dashboard (Configuration Layer)

**Primary Function:**\
The **Dashboard** provides the configuration interface for joiners, rules, and departments.

**Technical Details:**

- Built on **PHP / Phalcon MVC architecture**.

- Does **not** provide real-time socket communication.

- Pushes configuration updates (join rules, customer mappings, joiner assignments) to the **Rocket.Chat Lead Plugin**.

- Stores and displays administrative data only — it does not send or manage real-time events.

**Developer Note:**

> Think of the Dashboard as the “control panel” — it defines the rules, but real-time execution happens elsewhere.

------------------------------------------------------------------------

### 2️⃣ Rocket.Chat Lead Plugin (Logic Layer)

**Primary Function:**\
Executes **real-time LiveJoin logic** inside Rocket.Chat whenever specific chat events occur.

**Technical Details:**

- Operates in a **sandboxed environment** inside Rocket.Chat (no dynamic code or native sockets).

- Filters chat events (like *agent joined*, *department set*, *lead injected*) that <span class="inline-comment-marker" ref="8fef3054-7707-4cb7-95d2-6dd949661085">may</span> qualify for a LiveJoin trigger.

- Sends **lead and message events** to the **LiveJoin Server** via API calls.

- Cannot perform rule evaluation directly — instead, it delegates full logic to LiveJoin3 Service.

**Developer Note:**

> The plugin acts as the “event listener” — it detects when to trigger a join invite, but relies on LiveJoin for processing and distribution.

------------------------------------------------------------------------

### 3️⃣ LiveJoin3 Service (Processing Layer)

**Primary Function:**\
Acts as the **orchestrator** between the plugin, joiners, and external notification systems.

**Technical Details:**

- Performs **join rule evaluation** upon receiving trigger events from the Lead Plugin.

- Synchronizes updates to join rules from the **ETS Dashboard**.

- Manages **socket connections** with joiners for real-time communication.

- Sends invites via **SendGrid** (email) and **Twilio** (SMS).

- Logs invite creation, evaluation, and delivery results.

**Developer Note:**

> The LiveJoin3 Server is the “engine.” It takes plugin triggers and turns them into join invitations, socket updates, and backend logs.

------------------------------------------------------------------------

### 4️⃣ SendGrid (Email Delivery Layer)

**Primary Function:**\
Handles **delivery of invitation emails** to joiners when a qualifying chat occurs.

**Technical Details:**

- Integrates via the LiveJoin3 API using SendGrid’s transactional email endpoint.

- Tracks **processed, delivered, bounced, and opened** statuses.

- Enables developers to confirm whether an invitation email was successfully sent.

**Developer Note:**

> SendGrid is the “postal service” for LiveJoin — it ensures every invite is logged and traceable.

------------------------------------------------------------------------

### 5️⃣ Twilio (SMS Layer)

**Primary Function:**\
Sends **SMS-based join invitations** when joiners are configured to receive them.

**Technical Details:**

- Called directly by LiveJoin3 Service.

- Uses standard REST SMS delivery endpoints.

- Primarily used by mobile-based joiners or backup contacts.

------------------------------------------------------------------------

## 🧭 Process Flow Overview

According to Paul’s latest technical summary, there are **four major processes** within LiveJoin, each represented by a color in the architecture diagram.

<div class="table-wrap">

|  |  |  |
|----|----|----|
| Color | Process | Description |
| 🔵 **Configuration Updates** | From ETS Dashboard → Lead Plugin | Configuration changes and join rule updates are synced to Rocket.Chat for real-time use. |
| 🟣 **Normal Chat Communications** | Agent ↔ Visitor | Standard Rocket.Chat conversation flow. Once a joiner is invited, messages are mirrored to joiners via LiveJoin. |
| 🟢 **Agent Lead Updates** | Trigger Invites | Lead updates (e.g., setting customer, department, or contact info) cause LiveJoin3 to evaluate rules and send invitations. |
| 🔴 **Joiner Messages** | Joiner ↔ Agent | Messages from joiners flow through LiveJoin3, then back into Rocket.Chat, appearing as impersonated agent messages. |

</div>

------------------------------------------------------------------------

## 💬 Additional Invite Trigger

In addition to agent-initiated events, LiveJoin can also trigger a join invitation when:

> A **visitor sends their first response** to an agent message.

This ensures joiners are notified only once the visitor is actively engaged.

------------------------------------------------------------------------

## 👁️ Whisper Functionality (FYI)

Though not part of the primary workflow, **whispers** allow private agent ↔ joiner communication:

**Agent → Joiner**

1.  Agent sends `/whisper` via Rocket.Chat.

2.  Lead Plugin forwards whisper to LiveJoin3.

3.  LiveJoin3 pushes the whisper to joiners in real time.

**Joiner → Agent**

1.  Joiner sends whisper via the **Whisper button**.

2.  LiveJoin3 queries chat and agent info from Rocket.Chat.

3.  Whisper notification is injected into the chat for the active agent(s).\
    ⚠️ Future agents or admins will not see whispers in Rocket.Chat — they’re visible only in transcripts.

------------------------------------------------------------------------

## 🧾 Log Review: Identifying Successful LiveJoin Events

**Access Point:**\
🔗 <a href="https://livejoin3.engagetosell.com/RCAppDebugLog" class="external-link" rel="nofollow">LiveJoin3 Admin Logs</a>

**Plugin:** `LeadGen`\
**Key Search Term:** `executeBlockActionHandler`\
**Recommended Range:** ±5 minutes around event time.

### Common Log Indicators

<div class="table-wrap">

|  |  |
|----|----|
| Log Message | Meaning |
| `Adding first customer to invites` | First-time invite sent for a customer. |
| `Adding department to invites for customer` | A new department triggered new invites. |
| `Injecting first department for customer` | Department newly added after initial no-department invite. |
| `Setting no department invites for customer` | Department unset; new no-department invites sent. |
| `Injecting customer for invites` | Customer changed; invites reissued to new joiners. |

</div>

A `Response: success:true` message confirms the invitation was accepted and delivered to SendGrid/Twilio.

------------------------------------------------------------------------

## 📊 System Diagram

**Diagram Name:** `LiveJoin_Architecture_Diagram.png`\
🔵 Configuration \| 🟣 Chat \| 🟢 Lead Updates \| 🔴 Joiner Messages

<span class="confluence-embedded-file-wrapper image-center-wrapper confluence-embedded-manual-size"><img src="https://digitalairstrike.atlassian.net/wiki/download/attachments/3510730771/undefined.png?api=v2" class="confluence-embedded-image image-center" width="3028" alt="undefined.png" /></span>

------------------------------------------------------------------------

## 🧰 Verification Workflow for Developers

<div class="table-wrap">

|  |  |
|----|----|
| Step | Validation |
| 1️⃣ | Verify `success:true` in LiveJoin logs after `Sending chat info changed`. |
| 2️⃣ | Check **SendGrid Activity Feed** for the invite email (recipient + status). |
| 3️⃣ | Confirm joiner appears in Rocket.Chat as “joined.” |
| 4️⃣ | Verify correct **customer** and **department** values were used. |
| 5️⃣ | Optionally check **Twilio logs** for matching SMS invites. |

</div>

------------------------------------------------------------------------

## 📁 Suggested Screenshot Placement

<div class="table-wrap">

|  |  |  |
|----|----|----|
| File Name | Description | Placement |
| `LiveJoin_Architecture_Diagram.png` | Paul’s diagram with color-coded message flows. | **System Diagram** section |
| `LiveJoin_Admin_LogView.png` | Screenshot of the RCAppDebugLog with example LeadGen query. | **Log Review** section |
| `SendGrid_ActivityFeed.png` | Example showing successful invite email delivery. | **Verification Workflow** section |

</div>

------------------------------------------------------------------------

## 🎯 Summary

The **LiveJoin system** is a multi-service architecture designed for modularity, stability, and traceability.

<div class="table-wrap">

|                             |                                             |
|-----------------------------|---------------------------------------------|
| Layer                       | Responsibility                              |
| **ETS Dashboard**           | Configuration and administration            |
| **Rocket.Chat Lead Plugin** | Event detection and trigger                 |
| **LiveJoin3 Service**       | Rule evaluation, sockets, and notifications |
| **SendGrid/Twilio**         | Invitation delivery                         |

</div>

Understanding where each responsibility resides ensures that developers and Application Support can **pinpoint where an issue originates**, trace event flow, and verify resolution at every step.
