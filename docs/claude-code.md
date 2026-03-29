---
layout: page
title: Claude Code — Referenceguide
permalink: /docs/claude-code
---

# Claude Code

Claude Code er Anthropics officielle CLI til AI-assisteret softwareudvikling.

## Installation

```bash
npm install -g @anthropic-ai/claude-code
claude
```

## Centrale koncepter

### CLAUDE.md
Filen `CLAUDE.md` i projektets rod læses automatisk af Claude Code ved opstart. Den indeholder:
- Projektbeskrivelse og arkitektur
- Tilladte og forbudte handlinger
- Kodestandarder og konventioner
- Nøglekommandoer

**Skabelon:** [`templates/CLAUDE.md`](https://github.com/qvisty/mit-claude-setup/blob/main/templates/CLAUDE.md)

### settings.json
`.claude/settings.json` styrer tilladelser og hooks:
```json
{
  "permissions": {
    "allow": ["Bash(npm test*)"],
    "deny": ["Bash(rm -rf*)"]
  }
}
```

**Skabelon:** [`templates/settings.json`](https://github.com/qvisty/mit-claude-setup/blob/main/templates/settings.json)

### Agents / Subagents
Claude Code kan spawne specialiserede subagents med `Agent`-toolet. Definer roller i `.claude/agents.md`.

**Skabelon:** [`templates/agents.md`](https://github.com/qvisty/mit-claude-setup/blob/main/templates/agents.md)

## Nyttige slash-kommandoer

| Kommando | Beskrivelse |
|----------|-------------|
| `/help` | Vis hjælp |
| `/clear` | Ryd kontekst |
| `/compact` | Komprimér samtalehistorik |
| `/cost` | Vis token-forbrug |
| `/review` | Review ændringer |
| `/commit` | Lav et commit |
| `/fast` | Skift til hurtig tilstand |

## Tilladelsesstyring

Tre niveauer:
1. **Auto-allow** — tilladte uden prompt (konfigureres i `settings.json`)
2. **Prompt** — brugeren godkender ved kørsel (standard)
3. **Deny** — altid afvist

## Hooks

Hooks eksekverer shell-kommandoer som reaktion på hændelser:

```json
{
  "hooks": {
    "PreToolUse": [{ "matcher": "Bash", "hooks": [{"type": "command", "command": "echo 'kører bash'"}] }],
    "PostToolUse": [...],
    "SessionStart": [...]
  }
}
```

## Tips og mønstre

- **Vær specifik i CLAUDE.md** — jo mere kontekst, jo bedre resultater
- **Brug `--dangerously-skip-permissions`** kun i isolerede miljøer (CI, Docker)
- **Komprimér jævnligt** med `/compact` ved lange sessioner
- **Subagents til parallelisering** — delegér uafhængige opgaver til subagents
- **Referer dette repo** i CLAUDE.md så Claude kender dit standardsetup
