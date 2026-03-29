# Mit Claude & Codex Setup

Et centralt sted for mine konfigurationer, skabeloner og arbejdsgange med [Claude Code](https://claude.ai/code) og [OpenAI Codex](https://openai.com/codex).

## Hurtig start — hent setup til et nyt projekt

```bash
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

Eller manuelt:

```bash
# Kopiér kun CLAUDE.md
curl -o CLAUDE.md https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/templates/CLAUDE.md

# Kopiér agents.md
curl -o .claude/agents.md https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/templates/agents.md
```

## Indhold

| Fil | Formål |
|-----|--------|
| [`templates/CLAUDE.md`](templates/CLAUDE.md) | Skabelon til projektets `CLAUDE.md` |
| [`templates/agents.md`](templates/agents.md) | Skabelon til `.claude/agents.md` |
| [`templates/settings.json`](templates/settings.json) | Skabelon til `.claude/settings.json` |
| [`docs/claude-code.md`](docs/claude-code.md) | Referenceguide: Claude Code |
| [`docs/codex.md`](docs/codex.md) | Referenceguide: OpenAI Codex |
| [`docs/workflows.md`](docs/workflows.md) | Mine arbejdsgange og tips |

## GitHub Pages

Dokumentation er tilgængelig på: **https://qvisty.github.io/mit-claude-setup**
