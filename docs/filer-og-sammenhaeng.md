---
layout: page
title: Filer og sammenhæng
permalink: /docs/filer-og-sammenhaeng
---

# Hvordan filerne hænger sammen

Dit projekt indeholder en række MD-filer og konfigurationsfiler der refererer til hinanden. Denne side forklarer hierarkiet, hvem der læser hvad, og hvordan du sikrer at det hele er konsistent.

## Filhierarkiet

```
CLAUDE.md                          ← master-konfiguration
  │
  ├── @AGENTS.md                   ← importerer den universelle protokol
  ├── @.planning/PROJECT.md        ← importerer projektkrav
  └── @.planning/STATE.md          ← importerer nuværende status

AGENTS.md                          ← universelle regler for ALLE agenter

RALPH.md                           ← Ralphs operative fil (refererer til AGENTS.md)

.claude/
  ├── agents.md                    ← subagent-roller (planner, reviewer, tester, git-helper)
  └── settings.json                ← tilladelser og hooks

.planning/
  ├── PROJECT.md                   ← krav, arkitektur, beslutninger
  ├── STATE.md                     ← nuværende fase og status
  └── phases/
      └── NN-name/
          ├── PLAN.md              ← tasks for denne fase
          └── VERIFICATION.md      ← dokumentation for færdig fase
```

## Hvem læser hvad?

| Fil | Claude Code | GSD | Superpowers | Codex CLI | Ralph |
|-----|:-----------:|:---:|:-----------:|:---------:|:-----:|
| CLAUDE.md | direkte | direkte | direkte | — | — |
| AGENTS.md | via @import | via @import | via @import | direkte | refererer |
| RALPH.md | — | — | — | — | direkte |
| .planning/PROJECT.md | via @import | direkte | via @import | — | refererer |
| .planning/STATE.md | via @import | direkte | via @import | — | refererer |
| .claude/agents.md | direkte | — | — | — | — |
| .claude/settings.json | direkte | — | — | — | — |

## @import-systemet

CLAUDE.md bruger `@`-direktiver til at importere andre filer. Når Claude Code læser CLAUDE.md, henter den automatisk indholdet af:

```markdown
@AGENTS.md
@.planning/PROJECT.md
@.planning/STATE.md
```

Det betyder at Claude Code ser alt indhold fra alle tre filer som én samlet kontekst.

## De vigtigste filer forklaret

### AGENTS.md — den universelle protokol

AGENTS.md er den autoritative kilde for regler der gælder **alle** agenter. Den har 9 sektioner:

1. **Session Start** — hvilke filer der læses ved start
2. **Tech Stack** — framework, sprog, database osv.
3. **Systemregler** — forretningsinvarianter der aldrig brydes
4. **Kodekodeks** — kodestandarder (engelsk, docstrings, Zod, ingen `any`)
5. **Git og GitHub** — branch-strategi, commit-format, push-regler
6. **GitHub Issues** — fasesporing med issues
7. **Planlægningsprotokol** — PLAN.md-format og regler
8. **Implementering** — TDD-workflow
9. **Definition of Done** — tjekliste for færdige features

**Regel:** Hvis en regel gælder alle tools, hører den hjemme i AGENTS.md. Hvis den kun gælder Claude Code, hører den i CLAUDE.md.

### CLAUDE.md — Claude Code-specifik konfiguration

CLAUDE.md importerer AGENTS.md og tilføjer Claude Code-specifikke indstillinger:

- Tilladte handlinger (uden godkendelse)
- Handlinger der kræver godkendelse
- GSD-integration
- Superpowers-integration
- Subagent-referencer

### .planning/STATE.md — nuværende tilstand

STATE.md er den fil agenter læser for at vide **hvor vi er** i projektet:

```markdown
## Nuværende fase
Fase 2: Betalingsintegration

## Status
I gang — task 1 af 3 færdig

## Næste skridt
Implementér Stripe webhook-handler

## Resume file
.planning/phases/02-payments/PLAN.md
```

**Regel:** STATE.md opdateres ved hvert faseskift.

### .planning/PROJECT.md — projektkrav

PROJECT.md beskriver **hvad** projektet er:

- Projektnavn og formål
- Målgruppe
- Tech stack (refererer til AGENTS.md sektion 2)
- Arkitekturbeslutninger med begrundelser
- Constraints og begrænsninger

**Regel:** PROJECT.md skrives ved projektstart og opdateres sjældent.

## Sådan sikrer du konsistens

### 1. Kør sync.sh

```bash
bash sync.sh
```

`sync.sh` validerer at:
- AGENTS.md eksisterer og har alle 9 sektioner
- CLAUDE.md eksisterer og har de rette @-direktiver
- RALPH.md refererer til AGENTS.md
- Hooks er på plads

Alt skal vise `[ok]`. Ret fejl inden du begynder at kode.

### 2. Tommelfingerregler

- **Rediger AGENTS.md** for regler der gælder alle tools
- **Rediger CLAUDE.md** kun for Claude Code-specifikke ting
- **Rediger RALPH.md** kun for Ralphs aktuelle opgave
- **Opdatér STATE.md** ved hvert faseskift
- **Rør sjældent** PROJECT.md, agents.md og settings.json
- Kør **altid** `bash sync.sh` efter ændringer i MD-filer

### 3. Typiske fejl

| Problem | Årsag | Løsning |
|---------|-------|---------|
| Claude kender ikke reglerne | AGENTS.md mangler @import i CLAUDE.md | Tilføj `@AGENTS.md` i toppen af CLAUDE.md |
| Claude ved ikke hvilken fase vi er i | STATE.md er ikke opdateret | Opdatér STATE.md med nuværende fase |
| Codex CLI følger ikke reglerne | AGENTS.md er ikke synced | Kør `bash sync.sh` |
| Ralph gør noget uventet | RALPH.md mangler kontekst | Tilføj link til AGENTS.md og STATE.md i RALPH.md |
| sync.sh fejler | En sektion mangler i AGENTS.md | Tjek at alle 9 sektioner er til stede |
