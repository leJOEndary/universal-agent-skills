#!/bin/bash
# List tldv meetings with optional filters

# Get API key from 1Password if not set
API_KEY="${TLDV_API_KEY:-$(op read "op://OpenClaw/tldv/credential" 2>/dev/null)}"
BASE_URL="https://pasta.tldv.io/v1alpha1"

if [[ -z "$API_KEY" ]]; then
  echo '{"error": "TLDV_API_KEY not set and could not read from 1Password"}' >&2
  exit 1
fi

# Parse args
QUERY="" LIMIT="20" PAGE="1" FROM="" TO=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --query) QUERY="$2"; shift 2 ;;
    --limit) LIMIT="$2"; shift 2 ;;
    --page) PAGE="$2"; shift 2 ;;
    --from) FROM="$2"; shift 2 ;;
    --to) TO="$2"; shift 2 ;;
    *) shift ;;
  esac
done

# Build query string
QS="page=$PAGE&limit=$LIMIT"
[[ -n "$QUERY" ]] && QS="$QS&query=$(printf %s "$QUERY" | jq -sRr @uri)"
[[ -n "$FROM" ]] && QS="$QS&from=$FROM"
[[ -n "$TO" ]] && QS="$QS&to=$TO"

curl -s "$BASE_URL/meetings?$QS" -H "x-api-key: $API_KEY" -H "Content-Type: application/json"
