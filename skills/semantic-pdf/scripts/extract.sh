#!/bin/bash
# Semantic PDF extraction using MinerU
# Usage: ./extract.sh <input.pdf> [output_dir] [backend]

set -e

INPUT="${1:?Usage: $0 <input.pdf> [output_dir] [backend]}"
OUTPUT="${2:-./output}"
BACKEND="${3:-hybrid-auto-engine}"

if ! command -v mineru &> /dev/null; then
    echo "Error: mineru not found. Install with: uv pip install -U 'mineru[all]'"
    exit 1
fi

echo "📄 Processing: $INPUT"
echo "📁 Output: $OUTPUT"
echo "⚙️  Backend: $BACKEND"

mineru -p "$INPUT" -o "$OUTPUT" -b "$BACKEND"

# Find the output markdown
BASENAME=$(basename "$INPUT" .pdf)
MD_FILE="$OUTPUT/$BASENAME/$BASENAME.md"

if [[ -f "$MD_FILE" ]]; then
    echo ""
    echo "✅ Done! Output at: $MD_FILE"
    echo ""
    echo "--- Preview (first 50 lines) ---"
    head -50 "$MD_FILE"
else
    echo "⚠️  Markdown not found at expected location"
    find "$OUTPUT" -name "*.md" -type f
fi
