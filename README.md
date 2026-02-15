# Universal Agent Skills

A single source of truth for agent skills that work across multiple platforms:
- **[OpenClaw](https://github.com/openclaw/openclaw)**
- **[Manus](https://manus.im)**
- **[Claude Code](https://docs.anthropic.com/claude/docs/claude-code)**
- **[OpenAI Codex](https://developers.openai.com/codex)**

All skills follow the open [Agent Skills specification](https://agentskills.io).

## Directory Structure

```
skills/
├── 1password/
│   ├── SKILL.md              # Core skill (universal)
│   ├── scripts/              # Shared scripts
│   ├── references/           # Additional docs
│   └── agents/
│       └── openai.yaml       # OpenAI Codex extras (optional)
├── github/
├── slack/
└── ...
```

## Usage

### OpenClaw
```bash
# Copy skill folder to your workspace
cp -r skills/1password ~/.openclaw/workspace/skills/
```

### Manus
Skills can be loaded directly from this repo or imported via Manus UI.

### Claude Code
```bash
# Register as plugin marketplace
/plugin marketplace add youssefelhady/universal-agent-skills

# Or install specific skill
/plugin install 1password@universal-agent-skills
```

### OpenAI Codex
```bash
# Use skill-installer
$skill-installer install the 1password skill from universal-agent-skills
```

## Skills Available

| Skill | Description | Status |
|-------|-------------|--------|
| 1password | 1Password CLI integration for secrets management | ✅ |
| github | GitHub CLI for issues, PRs, CI runs | ✅ |
| slack | Slack control (reactions, pins, messages) | ✅ |
| tldv | tl;dv meeting transcripts and highlights | ✅ |
| weather | Weather forecasts (no API key required) | ✅ |
| coding-agent | Run coding agents (Claude Code, Codex, etc.) | ✅ |
| openai-whisper | Speech-to-text transcription | ✅ |
| video-frames | Extract frames/clips from videos | ✅ |
| nano-pdf | Natural language PDF editing | ✅ |

## Contributing

1. Create a new folder under `skills/`
2. Add a `SKILL.md` following the [specification](https://agentskills.io/specification)
3. Test on at least one platform
4. Submit a PR

## License

Apache 2.0 - See individual skills for any additional licensing.
