---
name: krisp
description: >
  Access Krisp meeting transcripts, summaries, action items, and calendar via MCP.
  Use when searching past meetings, fetching transcripts, reviewing action items,
  or accessing meeting notes and key points from Krisp AI Meeting Assistant.
license: Apache-2.0
compatibility: Requires Krisp account with AI Meeting Assistant. MCP-compatible clients.
metadata:
  author: universal-agent-skills
  version: "1.0"
  openclaw:
    emoji: "🎙️"
    requires:
      bins: ["npx"]
---

# Krisp Meeting Transcripts

Access your Krisp meeting data through the Model Context Protocol (MCP).

## Features

- **Search meetings**: Find past meetings by topic, content, attendees, or date range
- **Read transcripts**: Fetch full transcripts for any meeting
- **Get summaries**: AI-generated meeting summaries and key points
- **Action items**: Track action items and follow-ups from meetings
- **Calendar integration**: View upcoming and past meetings

## MCP Configuration

### For Claude Desktop / Cursor / OpenClaw

Add to your MCP config (`~/.config/claude/claude_desktop_config.json` or equivalent):

```json
{
  "mcpServers": {
    "krisp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.krisp.ai/mcp"]
    }
  }
}
```

### For Claude Code

```bash
claude mcp add krisp -- npx -y mcp-remote https://mcp.krisp.ai/mcp
```

### First-Time Setup

1. Add the MCP configuration above
2. Restart your AI client
3. When you first use a Krisp tool, complete the OAuth flow to connect your workspace
4. Grant access to your Krisp account

## Available Tools

Once connected, the MCP server provides these tools:

| Tool | Description |
|------|-------------|
| `search_meetings` | Find meetings by keyword, attendee, or date |
| `get_meeting` | Get full details for a specific meeting |
| `get_transcript` | Fetch the complete transcript |
| `get_summary` | Get AI-generated summary |
| `get_action_items` | List action items from a meeting |
| `get_key_points` | Get highlighted key points |
| `list_recent_meetings` | List recent meetings |

## Example Usage

### Search for meetings about a topic
```
"Find all meetings about Q4 planning"
→ Uses search_meetings tool
```

### Get transcript from a specific meeting
```
"Get the transcript from my meeting with Sarah yesterday"
→ Uses search_meetings + get_transcript tools
```

### Review action items
```
"What action items came out of the product roadmap meeting?"
→ Uses search_meetings + get_action_items tools
```

### Get meeting summary
```
"Summarize my last 3 meetings"
→ Uses list_recent_meetings + get_summary tools
```

## Non-MCP Access (Browser Automation)

If MCP is not available, you can access Krisp data via browser:

1. Go to https://app.krisp.ai/meetings
2. Use browser automation to navigate and extract data
3. Transcripts are available in the meeting detail view

```bash
# Example: Export meeting via browser
# Navigate to: https://app.krisp.ai/meetings/{meeting_id}
# Click "Export" → "Download Transcript"
```

## Data Sync

Krisp stores meeting data in the cloud. Data is available:
- Immediately after meeting ends (transcript)
- Within minutes (AI summary, action items)
- Searchable by content after indexing (~1 hour)

## Privacy Notes

- Krisp processes audio locally for noise cancellation
- Transcripts are generated from audio sent to Krisp cloud
- MCP access requires explicit OAuth authorization
- You control which workspaces the MCP can access

## References

- [Krisp Help - MCP Setup](https://help.krisp.ai/hc/en-us/articles/25396920405148-Krisp-MCP)
- [Krisp Meetings Dashboard](https://app.krisp.ai/meetings)
- [Model Context Protocol](https://modelcontextprotocol.io)
