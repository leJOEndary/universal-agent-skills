#!/bin/bash
# Get tldv meeting by ID

API_KEY="${TLDV_API_KEY:-$(op read "op://OpenClaw/tldv/credential" 2>/dev/null)}"
BASE_URL="https://pasta.tldv.io/v1alpha1"

if [[ -z "$API_KEY" ]]; then
  echo '{"error": "TLDV_API_KEY not set and could not read from 1Password"}' >&2
  exit 1
fi

if [[ -z "$1" ]]; then
  echo '{"error": "Usage: get-meeting.sh <meeting_id>"}' >&2
  exit 1
fi

curl -s "$BASE_URL/meetings/$1" -H "x-api-key: $API_KEY" -H "Content-Type: application/json"
