---
layout: page
title: Unified Setup — alle tools, én konfiguration
permalink: /docs/unified-setup
---

# Unified AI Setup

Guide til at bruge Claude Code, GSD, Superpowers, Codex og Ralphify med samme konfigurationsfiler.

## Princip: Single Source of Truth

`CLAUDE.md` er master-filen. Alle andre filer enten læser den direkte eller synces fra den.

```
CLAUDE.md  (rediger KUN denne)
    │
    ├── Claude Code         →  læses direkte
    ├── GSD                 →  læses direkte + .planning/
    ├── Superpowers         →  læses direkte + skills/
    ├── MCP Server Codex    →  læses direkte (kører i Claude Code)
    │
    └── bash sync.sh ───► AGENTS.md  (Codex CLI)

RALPH.md  (separat — Ralphify-specifikke opgaver)
```

## Skift mellem tools

Alle tools er klar når `install.sh` er kørt:

```bash
# Claude Code
claude

# GSD
claude  # og brug /gsd:new-project, /gsd:execute-phase etc.

# Superpowers
claude  # skills triggers automatisk ved behov

# Codex CLI
codex "beskriv opgaven"

# Ralphify
ralph run .  # læser RALPH.md
```

## Når du opdaterer CLAUDE.md

```bash
# 1. Rediger CLAUDE.md
vim CLAUDE.md

# 2. Sync til AGENTS.md
bash sync.sh

# 3. Tilpas RALPH.md hvis nødvendigt
vim RALPH.md
```

## TODO → GitHub Issues

TODO-kommentarer i koden synces til GitHub Issues:

```python
# TODO: implement user authentication
# TODO(auth): add refresh token support
```

Hver TODO opretter et GitHub Issue med label `todo-sync`.
Når TODO'en fjernes fra koden, lukkes issue automatisk.

Sync kører automatisk via `post-commit` git hook, eller manuelt:

```bash
python3 .claude/hooks/todo-github-sync.py
```

## Commit-konvention

Fortsat på tværs af alle tools:

```
feat: tilføj login med Google OAuth
fix: ret crash når kurven er tom
refactor: opdel 400-linje komponent
chore: opdater afhængigheder
docs: tilføj setup-vejledning
```

`commit-msg` git hook blokerer vage beskeder som `fix`, `update`, `WIP`.

## MCP Server Codex

Hvis du bruger Codex som MCP server inde i Claude Code, tilføj til `.claude/settings.json`:

```json
{
  "mcpServers": {
    "codex": {
      "command": "codex",
      "args": ["--mcp"]
    }
  }
}
```

MCP Codex-sessionen arver Claude Codes kontekst, så den læser også `CLAUDE.md` automatisk.
