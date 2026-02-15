---
name: semantic-pdf
description: >
  Semantic PDF parsing using MinerU. Extracts structured content (text, tables, images, formulas) 
  while preserving document hierarchy and reading order. Outputs LLM-ready markdown or JSON.
  Use when you need to understand PDF content, extract tables/formulas, convert PDFs for AI processing,
  or work with complex multi-column layouts, scientific papers, or scanned documents.
license: Apache-2.0
compatibility: Requires Python 3.10+, ~20GB disk for models. GPU recommended but CPU works.
metadata:
  author: universal-agent-skills
  version: "1.0"
  openclaw:
    emoji: "📄"
    requires:
      bins: ["mineru"]
    install:
      - id: pip
        kind: exec
        command: "uv pip install -U 'mineru[all]'"
        bins: ["mineru"]
        label: "Install MinerU (uv pip)"
---

# Semantic PDF Parsing with MinerU

MinerU transforms complex PDFs into machine-readable markdown/JSON while preserving semantic structure.

## Capabilities

- **Structure Preservation**: Headings, paragraphs, lists, reading order
- **Table Extraction**: Complex tables → HTML/markdown
- **Formula Recognition**: Math equations → LaTeX
- **Image Extraction**: Figures with captions
- **Multi-language OCR**: 109 languages supported
- **Layout Intelligence**: Handles multi-column, complex layouts
- **Noise Removal**: Strips headers, footers, page numbers

## Installation

```bash
# Using uv (recommended)
pip install uv
uv pip install -U "mineru[all]"

# First run downloads ~8GB of models
mineru --help
```

## Quick Usage

### Basic Conversion (PDF → Markdown)

```bash
# Single file
mineru -p document.pdf -o ./output

# Output structure:
# ./output/document/
#   ├── document.md          # Main markdown
#   ├── images/              # Extracted images
#   └── document_content.json # Structured JSON
```

### Backend Selection

```bash
# GPU (high accuracy, requires VRAM)
mineru -p paper.pdf -o ./out -b hybrid-auto-engine

# CPU only (slower but works everywhere)
mineru -p paper.pdf -o ./out -b pipeline

# Remote API (lowest local resources)
mineru -p paper.pdf -o ./out -b vlm-http-client
```

### Batch Processing

```bash
# Process directory of PDFs
mineru -p ./pdfs/ -o ./output

# Process multiple specific files
mineru -p file1.pdf file2.pdf -o ./output
```

## Output Formats

### Markdown (default)
Human-readable, preserves structure:
```markdown
# Chapter 1: Introduction

This paper presents...

## 1.1 Background

| Column A | Column B |
|----------|----------|
| Data 1   | Data 2   |

$$E = mc^2$$
```

### JSON (structured)
Machine-parseable with coordinates:
```json
{
  "pdf_info": [...],
  "pages": [
    {
      "blocks": [
        {"type": "title", "text": "Chapter 1"},
        {"type": "table", "html": "<table>..."},
        {"type": "equation", "latex": "E=mc^2"}
      ]
    }
  ]
}
```

## Common Workflows

### Extract Tables Only
```bash
mineru -p report.pdf -o ./out
# Then parse the JSON for table blocks
cat ./out/report/report_content.json | jq '.pages[].blocks[] | select(.type=="table")'
```

### Scientific Paper Processing
```bash
# Best for papers with equations
mineru -p paper.pdf -o ./out -b hybrid-auto-engine
```

### Scanned Document OCR
```bash
# Specify language for better accuracy
mineru -p scanned.pdf -o ./out --lang en
```

### Quick Text Extraction
```bash
# Just get the markdown text
mineru -p doc.pdf -o ./out && cat ./out/doc/doc.md
```

## Performance Tips

| Backend | Accuracy | Speed | VRAM | Use Case |
|---------|----------|-------|------|----------|
| `hybrid-auto-engine` | 90+ | Medium | 8GB+ | Best quality |
| `vlm-auto-engine` | 90+ | Medium | 10GB+ | Complex docs |
| `pipeline` | 82+ | Fast | 6GB/CPU | Compatibility |
| `vlm-http-client` | 90+ | Varies | 3GB | Remote API |

## Troubleshooting

### Out of Memory
```bash
# Use CPU backend
mineru -p large.pdf -o ./out -b pipeline
```

### Poor OCR Results
```bash
# Specify document language
mineru -p doc.pdf -o ./out --lang zh  # Chinese
mineru -p doc.pdf -o ./out --lang ar  # Arabic
```

### Model Download Issues
```bash
# Models download on first run (~8GB)
# Check: ~/.cache/mineru/ or set MINERU_CACHE_DIR
```

## References

- [MinerU Documentation](https://opendatalab.github.io/MinerU/)
- [GitHub Repository](https://github.com/opendatalab/MinerU)
- [Online Demo](https://mineru.net)
