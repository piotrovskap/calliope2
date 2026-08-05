# /das-bot — DAS CDP Slack Assistant

Slack utility for the DAS CDP engagement. Three commands: **pull** (surface insights from a channel), **nudge** (DM a team member), **broadcast** (post a status update).

## Setup

**Token:** `SLACK_BOT_TOKEN` — same Conflict workspace bot used by other repo skills. Read from `.env` at repo root or the shell environment:

```bash
grep SLACK_BOT_TOKEN .env 2>/dev/null || echo $SLACK_BOT_TOKEN
```

If not set, tell the user to add `SLACK_BOT_TOKEN=<token>` to `.env` and stop.

**User map:** `.claude/skills/das-bot/slack-users.json` — Conflict team IDs are pre-filled. DAS contact IDs (Dan, Alex, Mike) need to be filled in: open Slack → click their name → "Copy member ID".

Load user map:
```bash
cat .claude/skills/das-bot/slack-users.json
```

---

## Command: pull

**Usage:** `/das-bot pull [#channel] [--limit N]`

Default channel: `#das-digital` (ID: `C0B5H2QEFC3`). Default limit: 50 messages.

### Steps

1. Resolve channel name to ID:
```bash
curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  "https://slack.com/api/conversations.list?types=public_channel,private_channel&limit=200" | \
  python3 -c "import json,sys; d=json.load(sys.stdin); [print(c['id'], c['name']) for c in d.get('channels',[]) if c['name']=='CHANNEL_NAME']"
```

2. Fetch recent messages:
```bash
curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  "https://slack.com/api/conversations.history?channel=CHANNEL_ID&limit=50" | \
  python3 -c "
import json, sys
d = json.load(sys.stdin)
for m in d.get('messages', []):
    if m.get('type') == 'message' and not m.get('bot_id') and m.get('text'):
        print(m.get('ts'), m.get('user','?'), m['text'][:300])
"
```

3. Resolve user IDs to names using the user map.

4. Classify each signal into one of four buckets:
   - **Decision** — a call was made ("we're going with...", "agreed on...", "Dan confirmed...")
   - **Action item** — something needs to happen ("Leo to...", "we need to...", "someone should...")
   - **Open question** — unresolved ("still not sure about...", "do we know...?", "TBD")
   - **FYI** — useful context, no action needed

5. Present a summary:
```
DAS CDP Slack — #channel-name (last N messages)

DECISIONS
• Dan confirmed Azure AKS is the deployment target — affects architecture recommendation
• Agreed to defer event streaming to Phase 2

ACTION ITEMS
• Leo: schedule follow-up with Dan on infra inventory (Q11)
• Alicia: pull CDK field list from Confluence by EOW

OPEN QUESTIONS
• Authenticom contract — can CDP tap it directly? (unanswered since kickoff)
• Who owns JuiceReporting tables on the DAS side?

FYI
• Mike is back in SLC — available for deep-dives next week
```

6. For each bucket, offer to act:
   - **Decisions** → offer to append to `memory/decisions.md`
   - **Open questions** → offer to update `memory/open-questions.md`
   - **Action items** → offer to post to Jira or note in wiki (ask which)

When writing to memory files, append under the appropriate section. For decisions, follow the existing format: one-liner + **Why:** + **How to apply:**. For open questions, add to the "Still open:" list.

---

## Command: nudge

**Usage:** `/das-bot nudge <name> [message]`

Send a friendly Slack DM to a team member. Works for both Conflict team and DAS contacts (once their Slack IDs are filled in).

### Steps

1. Resolve the name — fuzzy match against the user map (both `conflict` and `das` sections). Handle first name, last name, email prefix, or key (e.g. "Dan", "daston", "Dan Aston" all resolve to the same entry).

2. Check that `slack_id` is not null. If it is, tell the user: "No Slack ID for [name] yet — add it to `.claude/skills/das-bot/slack-users.json`."

3. Compose a brief, human message. If no custom message provided, write a warm check-in. Keep it short — one or two sentences.

4. Open DM and send:
```bash
CHANNEL=$(curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"users": "SLACK_USER_ID"}' \
  "https://slack.com/api/conversations.open" | \
  python3 -c "import json,sys; print(json.load(sys.stdin)['channel']['id'])")

curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"channel\": \"$CHANNEL\", \"text\": \"MESSAGE_HERE\"}" \
  "https://slack.com/api/chat.postMessage"
```

5. Confirm: "Sent to [Name] in Slack."

**Always show the message to the user before sending and ask for confirmation.**

---

## Command: broadcast

**Usage:** `/das-bot broadcast [#channel] [message]`

Post a Phase 0 status update to a DAS channel. Default: `#das-digital` (`C0B5H2QEFC3`).

### Steps

1. Pull current Phase 0 status:
   - Read `memory/open-questions.md` for unresolved questions
   - Read `memory/decisions.md` for recent decisions
   - Check `wiki/Phase-0.md` for deliverable status if available

2. Resolve channel ID (see pull step 1).

3. Format as clean Slack mrkdwn:
```
*DAS CDP — Phase 0 Update*

*Recent Decisions*
• Azure AKS confirmed as deployment target
• Airflow replacing SSIS for batch pipeline

*Deliverables Status*
• Executive Summary — in progress
• Revised Architecture Plan — pending infra inventory (Q11)
• DAS CDP Roadmap — not started

*Open Questions (priority)*
• Q16: What does "good enough" look like for Phase 1 go-ahead?
• Q11: Full cloud footprint / AKS maturity
• Q14: DAS's actual position on TypeScript/Azure stack

*Next*
• [next session focus]
```

4. If the user provided a custom message, prepend it.

5. Show preview and ask for confirmation before posting.

6. Post to channel:
```bash
curl -s -H "Authorization: Bearer $SLACK_BOT_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"channel\": \"CHANNEL_ID\", \"text\": \"MESSAGE\", \"mrkdwn\": true}" \
  "https://slack.com/api/chat.postMessage"
```

7. Confirm: "Posted to #channel-name."

---

## Notes

- Always confirm before sending any message or writing to memory files
- Nudge messages should sound like Leo wrote them, not a bot
- When writing to memory files, match the existing format exactly — don't invent new sections
- If the bot token is missing or the API returns `ok: false`, show the raw error so the user can diagnose
- Slack is internal to Conflict — DAS contacts (Dan, Alex, Mike) are not on this workspace; reach them via Teams or email instead
- **Never document Slack message content** — pull is for in-session situational awareness only. Summarize themes and action items in your response but do not write any Slack message text, quotes, or attribution into memory files, wiki pages, or any committed artifact.
