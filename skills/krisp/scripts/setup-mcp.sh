#!/bin/bash
# Setup Krisp MCP for various clients

set -e

echo "🎙️ Krisp MCP Setup"
echo ""

# Detect which client to configure
if command -v claude &> /dev/null; then
    echo "Found Claude Code CLI"
    echo "Adding Krisp MCP server..."
    claude mcp add krisp -- npx -y mcp-remote https://mcp.krisp.ai/mcp
    echo "✅ Done! Restart Claude Code to use Krisp tools."
    exit 0
fi

# Check for Claude Desktop config
CLAUDE_DESKTOP_CONFIG="$HOME/.config/claude/claude_desktop_config.json"
if [[ -f "$CLAUDE_DESKTOP_CONFIG" ]]; then
    echo "Found Claude Desktop config at: $CLAUDE_DESKTOP_CONFIG"
    echo ""
    echo "Add this to your mcpServers section:"
    echo ""
    cat << 'EOF'
{
  "mcpServers": {
    "krisp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.krisp.ai/mcp"]
    }
  }
}
EOF
    exit 0
fi

# Check for Cursor
CURSOR_CONFIG="$HOME/.cursor/mcp.json"
if [[ -d "$HOME/.cursor" ]]; then
    echo "Found Cursor directory"
    echo ""
    echo "Add this to $CURSOR_CONFIG:"
    echo ""
    cat << 'EOF'
{
  "mcpServers": {
    "krisp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.krisp.ai/mcp"]
    }
  }
}
EOF
    exit 0
fi

echo "No supported MCP client detected."
echo ""
echo "Manual setup - add this to your MCP config:"
echo ""
cat << 'EOF'
{
  "mcpServers": {
    "krisp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://mcp.krisp.ai/mcp"]
    }
  }
}
EOF
