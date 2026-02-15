---
name: tldv
description: Access tl;dv meeting recordings, transcripts, and highlights via API. Use when retrieving meeting notes, searching past meetings, getting transcripts, or viewing AI-generated highlights from recorded calls.
---

# tldv

Query tl;dv meeting data via their API.

## Setup

Requires `TLDV_API_KEY` env var. Get your key from: https://tldv.io/app/settings/personal-settings/api-keys

## Scripts

All scripts output JSON. Use `jq` for formatting.

### List meetings

```bash
bash scripts/list-meetings.sh [--query "search term"] [--limit 10] [--page 1] [--from 2024-01-01] [--to 2024-12-31]
```

### Get meeting details

```bash
bash scripts/get-meeting.sh <meeting_id>
```

### Get transcript

```bash
bash scripts/get-transcript.sh <meeting_id>
```

### Get highlights/notes

```bash
bash scripts/get-highlights.sh <meeting_id>
```

## Common workflows

**Find recent meetings:**
```bash
bash scripts/list-meetings.sh --limit 5
```

**Get full context for a meeting:**
```bash
bash scripts/get-meeting.sh <id>
bash scripts/get-transcript.sh <id>
bash scripts/get-highlights.sh <id>
```

**Search for specific topic:**
```bash
bash scripts/list-meetings.sh --query "product roadmap"
```
