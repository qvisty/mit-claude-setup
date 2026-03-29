---
layout: page
title: Til mig selv
permalink: /docs/til-mig-selv
---

# Til mig selv — ny projekt-tjekliste

Denne side er min personlige huskeliste. Følg trinene hver gang du starter et nyt projekt.

---

## 1. Opret projekt og hent setup

```bash
mkdir my-project && cd my-project
git init

# Hent alle konfigurationsfiler og hooks
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

Det installerer:
- `CLAUDE.md` — master-konfiguration (Claude Code, GSD, Superpowers, MCP Codex)
- `AGENTS.md` — Codex CLI-konfiguration
- `RALPH.md` — Ralphify-konfiguration
- `.claude/agents.md` — subagent-roller
- `.claude/settings.json` — tilladelser og hooks
- `.claude/hooks/` — TODO-sync, commit-msg og post-commit hooks
- `sync.sh` — validering af setup

---

## 2. Udfyld CLAUDE.md

Åbn `CLAUDE.md` og udfyld de projektspecifikke dele. Brug denne prompt i Claude Code:

```
Læs CLAUDE.md og AGENTS.md. Hjælp mig med at udfylde de tomme felter
(tech stack, systemregler osv.) baseret på dette projekts kode og formål.
Projektet er: [beskriv kort hvad projektet er]
```

**Vigtige felter i AGENTS.md at udfylde:**
- Sektion 2 (TECH STACK) — framework, sprog, database, auth, styling, test
- Sektion 3 (SYSTEMREGLER) — projektspecifikke forretningsregler

---

## 3. Opret planlægningsstruktur

```bash
mkdir -p .planning/phases
```

Opret `.planning/PROJECT.md` med requirements og arkitekturbeslutninger.
Opret `.planning/STATE.md` med nuværende fase og status.

Eller brug denne prompt:

```
Opret .planning/PROJECT.md og .planning/STATE.md for dette projekt.
Projektet er: [beskriv kort]
Vi starter med fase 1: [beskriv første fase]
```

---

## 4. Validér setup

```bash
bash sync.sh
```

Alt skal vise `[ok]`. Ret eventuelle mangler inden du begynder at kode.

---

## 5. Første commit

```bash
git add -A
git commit -m "Initialt setup med qvisty's AI-konfiguration"
```

---

## Prompts jeg bruger ofte

### Start af ny session (første besked)

```
Læs CLAUDE.md, AGENTS.md, .planning/STATE.md og .planning/PROJECT.md.
Hvad er status, og hvad er næste skridt?
```

### Bed Claude om at bruge dette repo som reference

Tilføj dette i dit projekts `CLAUDE.md`:

```markdown
## Setup-reference
Dette projekt bruger qvisty's standardsetup.
Se https://github.com/qvisty/mit-claude-setup for konventioner og skabeloner.
Installer/opdatér med:
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

### Planlægning af ny fase

```
Vi skal starte en ny fase: [beskriv fasen].
Opret en PLAN.md med konkrete tasks, filstier og verifikationstrin.
Maks 2-3 tasks pr. plan.
```

### Kodegennemgang

```
Gennemgå alle ændringer siden sidste commit. Tjek for sikkerhedsrisici,
manglende validering og edge cases. Brug reviewer-agenten.
```

### Opdatér setup fra dette repo

```bash
# Hent seneste version af alle templates (overskriver hooks og sync.sh)
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

---

## Workflow-oversigt

```
Nyt projekt
    │
    ├── install.sh          → henter alle filer
    ├── Udfyld CLAUDE.md    → projektspecifik kontekst
    ├── bash sync.sh        → validér alt er korrekt
    │
    ├── Planlæg fase        → PLAN.md med tasks
    ├── Implementér         → TDD: rød → grøn → refaktor
    ├── Commit + push       → naturlige commit-beskeder
    │
    └── Gentag for næste fase
```

---

## Filer og hvad de styrer

| Fil | Hvem læser den | Hvornår redigere |
|-----|----------------|------------------|
| `CLAUDE.md` | Claude Code, GSD, Superpowers, MCP Codex | Ved projektstart + nye Claude Code-specifikke regler |
| `AGENTS.md` | Codex CLI + alle agenter via `@AGENTS.md` | Ved projektstart + nye universelle regler |
| `RALPH.md` | Ralphify | Kun hvis du bruger Ralphify |
| `.claude/agents.md` | Claude Code (subagents) | Sjældent — roller er generiske |
| `.claude/settings.json` | Claude Code | Sjældent — tilladelser er generiske |
| `.planning/PROJECT.md` | Alle agenter | Ved projektstart |
| `.planning/STATE.md` | Alle agenter | Ved hvert faseskift |
