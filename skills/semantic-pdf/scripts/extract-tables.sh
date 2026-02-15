#!/bin/bash
# Extract only tables from PDF using MinerU
# Usage: ./extract-tables.sh <input.pdf> [output_dir]

set -e

INPUT="${1:?Usage: $0 <input.pdf> [output_dir]}"
OUTPUT="${2:-./output}"

if ! command -v mineru &> /dev/null; then
    echo "Error: mineru not found. Install with: uv pip install -U 'mineru[all]'"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "Error: jq not found. Install with: brew install jq"
    exit 1
fi

echo "📄 Extracting tables from: $INPUT"

# Run MinerU
mineru -p "$INPUT" -o "$OUTPUT" -b pipeline 2>/dev/null

# Find JSON output
BASENAME=$(basename "$INPUT" .pdf)
JSON_FILE="$OUTPUT/$BASENAME/${BASENAME}_content.json"

if [[ ! -f "$JSON_FILE" ]]; then
    echo "Error: JSON output not found"
    exit 1
fi

# Extract tables
echo ""
echo "📊 Tables found:"
echo ""

jq -r '
  .pages[] | 
  .blocks[] | 
  select(.type == "table") | 
  .html // .text // "Table content unavailable"
' "$JSON_FILE"
