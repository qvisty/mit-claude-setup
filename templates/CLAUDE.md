# CLAUDE.md

<!--
  Claude Code-specifik konfiguration.
  Importerer den universelle protokol via @-direktiver.
  Rediger AGENTS.md for regler der gælder alle agenter.
  Rediger denne fil KUN for Claude Code-specifikke indstillinger.
-->

@AGENTS.md
@.planning/PROJECT.md
@.planning/STATE.md

---

## Claude Code — specifikke indstillinger

### Tilladte handlinger (ingen spørgsmål)

- Redigere filer i `src/` og `tests/`
- Køre tests, lint og build
- Oprette commits og branches
- Oprette nye filer i eksisterende mapper
- Synce TODO-issues: `python3 .claude/hooks/todo-github-sync.py`
- Køre validering: `bash sync.sh`

### Kræver altid godkendelse

- Slette filer eller mapper
- `git push` (medmindre tests er grønne og vi ikke er i rød TDD-fase)
- Ændre afhængigheder (`package.json`, `pyproject.toml`)
- Deployment eller infrastrukturændringer
- `git reset --hard` eller andre destruktive git-operationer

### GSD-integration

Dette projekt understøtter GSD workflow:
- Brug `gsd:plan-phase` til planlægning (ikke shell-kommandoer)
- Brug `gsd:execute-phase` til eksekvering
- Brug `gsd:verify-work` til verificering
- Brug `gsd:progress` for overblik hvis du er i tvivl om status

### Superpowers-integration

Superpowers skills aktiveres automatisk ved behov.
Skills har forrang: `brainstorming` → `writing-plans` → `test-driven-development` → `requesting-code-review`

### Subagents

Se `.claude/agents.md` for tilgængelige subagent-roller.

---

## Setup-reference

- Repo: <https://github.com/qvisty/mit-claude-setup>
- Installer: `curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash`
- Valider setup: `bash sync.sh`
