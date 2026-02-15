#!/bin/bash
# Sync tldv meetings to local files for QMD indexing

API_KEY="${TLDV_API_KEY:-$(op read "op://OpenClaw/tldv/credential" 2>/dev/null)}"
BASE_URL="https://pasta.tldv.io/v1alpha1"
OUTPUT_DIR="${1:-$HOME/.openclaw/workspace/data/tldv}"

if [[ -z "$API_KEY" ]]; then
  echo "Error: TLDV_API_KEY not set" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# Get recent meetings (last 30 days)
FROM_DATE=$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d '30 days ago' +%Y-%m-%d)
echo "Syncing tldv meetings since $FROM_DATE..."

# Fetch meetings
MEETINGS=$(curl -s "$BASE_URL/meetings?from=$FROM_DATE&limit=100" \
  -H "x-api-key: $API_KEY" -H "Content-Type: application/json")

echo "$MEETINGS" | jq -r '.results[]? | .id' | while read -r ID; do
  if [[ -z "$ID" ]]; then continue; fi
  
  MEETING_DIR="$OUTPUT_DIR/$ID"
  if [[ -d "$MEETING_DIR" ]]; then
    continue  # Skip existing
  fi
  
  mkdir -p "$MEETING_DIR"
  
  # Get meeting info
  curl -s "$BASE_URL/meetings/$ID" -H "x-api-key: $API_KEY" > "$MEETING_DIR/meeting.json"
  
  # Get transcript
  TRANSCRIPT=$(curl -s "$BASE_URL/meetings/$ID/transcript" -H "x-api-key: $API_KEY")
  echo "$TRANSCRIPT" > "$MEETING_DIR/transcript.json"
  
  # Create readable transcript
  echo "$TRANSCRIPT" | jq -r '.data[]? | "[\(.speaker)] \(.text)"' > "$MEETING_DIR/transcript.txt"
  
  # Get highlights
  curl -s "$BASE_URL/meetings/$ID/highlights" -H "x-api-key: $API_KEY" > "$MEETING_DIR/highlights.json"
  
  TITLE=$(cat "$MEETING_DIR/meeting.json" | jq -r '.name // "Unknown"')
  echo "  Synced: $TITLE"
done

echo "Done. Files in $OUTPUT_DIR"
