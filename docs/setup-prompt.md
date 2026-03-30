---
layout: page
title: Setup-prompt
permalink: /docs/setup-prompt
---

# Setup-prompt

Kopiér prompten nedenfor og indsæt som **første besked** i Claude Code i et nyt projekt.
Udskift kun de dele der står i `[firkantede parenteser]`.

---

```
Du er ved at sætte et helt nyt projekt op fra bunden. Følg hvert trin i rækkefølge og afvent ikke godkendelse mellem trinene.

## Trin 1 — Hent setup-filer

Kør dette i terminalen:

curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

Det henter CLAUDE.md, AGENTS.md, RALPH.md, .claude/agents.md, .claude/settings.json, hooks og sync.sh.

## Trin 2 — Udfyld AGENTS.md med tech stack

Åbn AGENTS.md og udfyld sektion 2 (TECH STACK) med projektets faktiske teknologier.
Udfyld også sektion 3 (SYSTEMREGLER) med projektspecifikke forretningsinvarianter.

Projektet er: [beskriv kort hvad projektet er og hvilken tech stack det bruger]

## Trin 3 — Opret planlægningsstruktur

Opret disse mapper og filer:

.planning/
  PROJECT.md    — projektnavn, beskrivelse, tech stack, arkitekturbeslutninger
  STATE.md      — nuværende fase: "Fase 1", status: "Ikke startet"
  phases/

Basér PROJECT.md på denne beskrivelse: [beskriv projektet, dets formål og målgruppe]

STATE.md skal have:
- Nuværende fase: Fase 1
- Status: Ikke startet
- Næste skridt: Opret PLAN.md for fase 1
- Resume file: .planning/phases/01-setup/PLAN.md

## Trin 4 — Opret fase 1 plan

Opret .planning/phases/01-setup/PLAN.md med en plan for:

[beskriv hvad fase 1 skal indeholde, f.eks. "Grundlæggende projektstruktur, auth og database-schema"]

Følg formatet fra AGENTS.md sektion 7: maks 2-3 tasks, eksakte filstier, verifikationstrin.

## Trin 5 — Validér og commit

1. Kør bash sync.sh og bekræft at alt viser [ok]
2. Lav initial commit:
   git add -A
   git commit -m "Initialt setup med AI-konfiguration"

## Trin 6 — Opret GitHub issue for fase 1

gh label create "phase" --color "0075ca" --description "Fasesporing" 2>/dev/null || true
gh issue create --title "Fase 1: [fasenavn]" --body "$(cat .planning/phases/01-setup/PLAN.md)" --label "phase"

## Trin 7 — Begynd implementering

Start på task 1 i PLAN.md. Følg TDD: skriv fejlende test først, implementér, refaktor, commit.

---

Bekræft at du har forstået alle trin, og gå derefter i gang fra trin 1.
```
