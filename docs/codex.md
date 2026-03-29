---
layout: page
title: OpenAI Codex — Referenceguide
permalink: /docs/codex
---

# OpenAI Codex CLI

OpenAI Codex CLI er OpenAIs terminalbaserede AI-kodningsassistent.

## Installation

```bash
npm install -g @openai/codex
codex
```

## AGENTS.md

Svarende til Claude Codes `CLAUDE.md` kan Codex konfigureres med en `AGENTS.md` fil:
- Projektspecifikke instruktioner
 approval-politikker for shell-kommandoer
- Kontekst om arkitektur og konventioner

## Tilladelsestilstande

| Tilstand | Flag | Beskrivelse |
|----------|------|-------------|
| Foreslå | (standard) | Foreslår; brugeren godkender |
| Auto-redigér | `--approval-mode auto-edit` | Fileredigeringer auto-godkendes, shell kræver godkendelse |
| Fuld auto | `--approval-mode full-auto` | Alt auto-godkendes (brug i sandbox) |

## Sammenligning: Claude Code vs. Codex

| Funktion | Claude Code | Codex |
|----------|-------------|-------|
| Konfigurationsfil | `CLAUDE.md` | `AGENTS.md` |
| Indstillinger | `.claude/settings.json` | CLI-flags |
| Subagents | Ja (Agent-tool) | Nej |
| Hooks | Ja | Nej |
| Slash-kommandoer | Ja | Begrænsede |
| Model | Claude (Anthropic) | GPT-4o / o3 |

## Tips

- Brug `--model o3` til komplekse ræsonneringsopgaver
- Kør Codex i Docker for fuld auto-tilstand uden risiko
- `AGENTS.md` kan inkludere `curl`-referencer til dette repo
