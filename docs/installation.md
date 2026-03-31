---
layout: page
title: Installation
permalink: /docs/installation
---

# Installation fra start til slut

Denne guide tager dig fra et tomt projekt til et fuldt konfigureret AI-setup hvor Claude Code, GSD, Superpowers, Codex og Ralph alle er klar til brug.

## Forudsætninger

Sørg for at disse tools er installeret:

```bash
# Claude Code (påkrævet)
npm install -g @anthropic-ai/claude-code

# GitHub CLI (påkrævet for TODO-sync og issue-tracking)
brew install gh   # macOS
# eller: sudo apt install gh   # Ubuntu/Debian
gh auth login

# Valgfrit
npm install -g @openai/codex     # Codex CLI
npm install -g ralphify          # Ralph
```

## Trin 1 — Opret projekt

```bash
mkdir my-project && cd my-project
git init
```

## Trin 2 — Hent setup-filer

```bash
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

Dette installerer:

| Fil | Formål |
|-----|--------|
| `CLAUDE.md` | Master-konfiguration for Claude Code, GSD, Superpowers |
| `AGENTS.md` | Universel protokol for alle agenter (9 sektioner) |
| `RALPH.md` | Ralphs operative arbejdsfil |
| `.claude/agents.md` | Subagent-roller (planner, reviewer, tester, git-helper) |
| `.claude/settings.json` | Tilladelser og hooks for Claude Code |
| `.claude/hooks/commit-msg` | Git hook: validerer commit-beskeder |
| `.claude/hooks/post-commit` | Git hook: syncer TODOs til GitHub Issues |
| `.claude/hooks/todo-github-sync.py` | Python-script til TODO-sync |
| `sync.sh` | Validerer at alle filer er korrekt konfigureret |

Git hooks installeres automatisk i `.git/hooks/` hvis `.git/` eksisterer.

## Trin 3 — Udfyld AGENTS.md

Åbn `AGENTS.md` og udfyld de projektspecifikke dele:

### Sektion 2: Tech Stack

Erstat placeholders med dit projekts faktiske teknologier:

```markdown
| Lag | Teknologi | Version |
|-----|-----------|--------|
| Framework | Next.js | 15.1 |
| Sprog | TypeScript | 5.7 |
| Database | PostgreSQL (Prisma) | 16 |
| Auth | NextAuth.js | 5.0 |
| Styling | Tailwind CSS | 4.0 |
| Test | Vitest | 3.0 |
| Linting | Biome | 1.9 |
```

### Sektion 3: Systemregler

Tilføj projektets forretningsinvarianter:

```markdown
- [ ] Alle betalingstransaktioner logges til audit-tabel
- [ ] Brugerdata forlader aldrig EU-region
- [ ] Priser beregnes altid server-side, aldrig client-side
```

## Trin 4 — Opret planlægningsstruktur

```bash
mkdir -p .planning/phases
```

Opret `.planning/PROJECT.md`:

```markdown
# Projektnavn

## Beskrivelse
[Hvad projektet er og hvem det er til]

## Tech Stack
Se AGENTS.md sektion 2.

## Arkitekturbeslutninger
- [Beslutning 1]: [Begrundelse]
- [Beslutning 2]: [Begrundelse]

## Constraints
- [Begrænsninger og krav]
```

Opret `.planning/STATE.md`:

```markdown
## Nuværende fase
Fase 1: [Fasenavn]

## Status
Ikke startet

## Næste skridt
Opret PLAN.md for fase 1

## Resume file
.planning/phases/01-setup/PLAN.md
```

## Trin 5 — Validér

```bash
bash sync.sh
```

Alt skal vise `[ok]`:

```
[ok] AGENTS.md findes
[ok] AGENTS.md har 9 sektioner
[ok] CLAUDE.md findes
[ok] CLAUDE.md importerer @AGENTS.md
...
Alt OK (N tjek bestået)
```

Ret eventuelle `[!!]` inden du går videre.

## Trin 6 — Første commit

```bash
git add -A
git commit -m "Initialt setup med AI-konfiguration"
```

## Trin 7 — Opret GitHub repo og push

```bash
gh repo create my-project --private --source=. --push
```

## Trin 8 — Start Claude Code

```bash
claude
```

Første besked:

```
Læs CLAUDE.md, AGENTS.md, .planning/STATE.md og .planning/PROJECT.md.
Hvad er status, og hvad er næste skridt?
```

Claude Code læser nu hele din konfiguration og er klar til at arbejde.

## Opdatér setup senere

Hooks og sync.sh overskives altid med nyeste version. CLAUDE.md, AGENTS.md og RALPH.md beholdes som de er:

```bash
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

## Fejlfinding

| Problem | Løsning |
|---------|---------|
| `sync.sh` fejler | Tjek at AGENTS.md har alle 9 nummererede sektioner |
| Hooks virker ikke | Kør `install.sh` igen — den geninstallerer hooks |
| Claude kender ikke reglerne | Tjek at `@AGENTS.md` står i toppen af CLAUDE.md |
| TODO-sync fejler | Tjek at `gh` er installeret og autentificeret |
| commit-msg hook afviser commit | Skriv en mere beskrivende commit-besked (min. 10 tegn, ingen vage ord) |
