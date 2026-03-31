---
layout: home
title: Mit Claude & Codex Setup
---

Velkommen til min personlige reference for [Claude Code](https://claude.ai/code) og OpenAI Codex.

## Quick Start — nyt projekt på 60 sekunder

```bash
# 1. Opret projekt og hent setup
mkdir my-project && cd my-project
git init
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

# 2. Start Claude Code og bed ham udfylde konfigurationen
claude
```

Eller brug den [færdige setup-prompt](/docs/setup-prompt) — kopiér den direkte ind i Claude Code og alt sættes op for dig.

Se [Installation](/docs/installation) for den fulde trin-for-trin guide.

---

## Hvad er dette?

Dette repo fungerer som:

- **Opslagsværk** — hurtig reference til kommandoer, flags og konventioner
- **Skabelonbibliotek** — klar-til-brug `CLAUDE.md`, `AGENTS.md`, `agents.md` og `settings.json`
- **Instruktionsbase** — Claude og Codex kan henvises hertil for at forstå mit setup

## Sektioner

- [Installation](/docs/installation) — fra tomt projekt til fuldt setup
- [Setup-prompt](/docs/setup-prompt) — én prompt, klar til copy-paste
- [Filer og sammenhæng](/docs/filer-og-sammenhaeng) — hvordan MD-filerne hænger sammen
- [GSD (Get Shit Done)](/docs/gsd) — fasebaseret workflow-system
- [Superpowers](/docs/superpowers) — automatiske skills i Claude Code
- [Ralph](/docs/ralph) — fire-and-forget agent via Ralphify
- [Claude Code](/docs/claude-code) — arbejde med Claude Code CLI
- [Codex](/docs/codex) — arbejde med OpenAI Codex
- [Arbejdsgange](/docs/workflows) — mine typiske flows og mønstre
