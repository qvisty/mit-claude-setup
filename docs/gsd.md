---
layout: page
title: Get Shit Done (GSD)
permalink: /docs/gsd
---

# Get Shit Done (GSD)

GSD er et skill-baseret workflow-system der kører oven på Claude Code. Det strukturerer arbejdet i faser med planlægning, eksekvering og verificering.

## Hvad er GSD?

GSD er ikke et separat tool — det er et sæt skills der aktiveres inde i Claude Code. GSD tvinger en disciplineret arbejdsgang: du planlægger før du koder, og du verificerer før du går videre.

## Forudsætninger

- Claude Code installeret (`npm install -g @anthropic-ai/claude-code`)
- GSD skills installeret (følger typisk med Claude Code eller installeres via Superpowers)

## GSD-kommandoer

| Kommando | Hvad den gør |
|----------|-------------|
| `/gsd:new-project` | Starter et nyt projekt med fuld struktur |
| `/gsd:plan-phase` | Planlægger næste fase — opretter PLAN.md |
| `/gsd:execute-phase` | Eksekverer den aktuelle plan trin for trin |
| `/gsd:verify-work` | Verificerer at alt i planen er implementeret |
| `/gsd:progress` | Viser overblik over status og fremdrift |
| `/gsd:settings` | Konfigurerer GSD's egen agent-opsætning |

## GSD-workflow

### 1. Planlæg fasen

```
/gsd:plan-phase
```

GSD opretter en `PLAN.md` i den aktuelle fasemappe med:
- Konkrete tasks (maks 2-3 pr. plan)
- Eksakte filstier
- Verifikationstrin for hver task

### 2. Eksekver planen

```
/gsd:execute-phase
```

GSD arbejder sig igennem PLAN.md task for task. Følger TDD: test først, implementér, refaktor.

### 3. Verificér arbejdet

```
/gsd:verify-work
```

GSD kører alle verifikationstrin fra planen og bekræfter at alt er færdigt.

### 4. Tjek status

```
/gsd:progress
```

Giver overblik over nuværende fase, færdige tasks og næste skridt.

## GSD og planlægningsstrukturen

GSD bruger den samme `.planning/`-struktur som resten af setupmet:

```
.planning/
  PROJECT.md          — krav og arkitektur
  STATE.md            — nuværende fase og status
  phases/
    01-setup/
      PLAN.md         — tasks for fase 1
      VERIFICATION.md — dokumentation for færdig fase
    02-feature/
      PLAN.md
```

GSD opdaterer STATE.md automatisk når faser afsluttes.

### GitHub Milestones og Issues

GSD bruger GitHub Milestones til fasesporing (se AGENTS.md sektion 6):

- **Fase-start:** Opret en milestone for fasen + issues for hver task i planen
- **Under fasen:** Issues lukkes efterhånden som tasks færdiggøres — milestone-progress opdateres automatisk
- **Fase-afslutning:** Luk milestone når alle issues er lukkede

TODO-kommentarer i koden oprettes automatisk som issues tildelt den aktive milestone. Se [Filer og sammenhæng](/docs/filer-og-sammenhaeng#synkronisering-med-github) for detaljer.

## GSD i CLAUDE.md

GSD-integrationen er allerede konfigureret i CLAUDE.md-skabelonen:

```markdown
### GSD-integration

Dette projekt understøtter GSD workflow:
- Brug gsd:plan-phase til planlægning (ikke shell-kommandoer)
- Brug gsd:execute-phase til eksekvering
- Brug gsd:verify-work til verificering
- Brug gsd:progress for overblik hvis du er i tvivl om status
```

## Tips

- **Brug altid `/gsd:plan-phase`** frem for at oprette PLAN.md manuelt — GSD sikrer korrekt format
- **Kør `/gsd:verify-work`** inden du markerer en fase som færdig
- **Tjek `/gsd:progress`** hvis du er i tvivl om hvor du er i flowet
- GSD og Superpowers kan bruges sammen — Superpowers håndterer skills, GSD håndterer fasestrukturen
