---
layout: home
title: Mit Claude & Codex Setup
---

Velkommen til min personlige reference for [Claude Code](https://claude.ai/code) og OpenAI Codex.

## Quick Start — nyt projekt på 60 sekunder

```bash
# 1. Hent setup
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

# 2. Udfyld CLAUDE.md med dit projekts detaljer
claude  # bed Claude om at hjælpe med at udfylde

# 3. Sync til AGENTS.md (til Codex CLI)
bash sync.sh

# 4. Kør dit foretrukne tool
claude          # Claude Code / GSD / Superpowers
codex "opgave"  # Codex CLI
```

Se [Til mig selv](/docs/til-mig-selv) for den fulde tjekliste, eller brug **[Setup-prompt generatoren](/docs/setup-prompt)** til at få én samlet prompt klar til copy-paste.

---

## Hvad er dette?

Dette repo fungerer som:

- **Opslagsværk** — hurtig reference til kommandoer, flags og konventioner
- **Skabelonbibliotek** — klar-til-brug `CLAUDE.md`, `AGENTS.md`, `agents.md` og `settings.json`
- **Instruktionsbase** — Claude og Codex kan henvises hertil for at forstå mit setup

## Sektioner

- [Til mig selv](docs/til-mig-selv) — tjekliste, prompts og workflow til nye projekter
- [Unified Setup](docs/unified-setup) — alle tools, én konfiguration
- [Claude Code guide](docs/claude-code) — arbejde med Claude Code CLI
- [Codex guide](docs/codex) — arbejde med OpenAI Codex
- [Arbejdsgange](docs/workflows) — mine typiske flows og mønstre
