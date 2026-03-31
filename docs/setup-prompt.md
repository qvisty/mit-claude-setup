---
layout: page
title: Setup-prompt
permalink: /docs/setup-prompt
---

# Setup-prompt — klar til copy-paste

Kopiér prompten nedenfor og indsæt som **første besked** i Claude Code i et nyt, tomt projekt.

Udskift de dele der står i `[firkantede parenteser]` med dine egne oplysninger.

---

```
Du er ved at sætte et helt nyt projekt op fra bunden. Følg hvert trin i
rækkefølge. Afvent ikke godkendelse mellem trinene — kør dem alle.

## Trin 1 — Initialisér git og hent setup-filer

Kør i terminalen:

git init
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

## Trin 2 — Udfyld AGENTS.md

Åbn AGENTS.md og udfyld:

Sektion 2 (TECH STACK) — brug disse teknologier:
- Framework: [f.eks. Next.js 15, App Router]
- Sprog: [f.eks. TypeScript 5.7]
- Database: [f.eks. PostgreSQL med Prisma]
- Auth: [f.eks. NextAuth.js v5]
- Styling: [f.eks. Tailwind CSS v4]
- Test: [f.eks. Vitest]
- Linting: [f.eks. Biome]

Sektion 3 (SYSTEMREGLER) — tilføj disse forretningsregler:
- [f.eks. Alle betalinger logges til audit-tabel]
- [f.eks. Brugerdata forlader aldrig EU]
- [f.eks. Priser beregnes altid server-side]

## Trin 3 — Opret planlægningsstruktur

Opret følgende filer:

.planning/PROJECT.md med:
- Projektnavn: [dit projektnavn]
- Beskrivelse: [beskriv projektet, dets formål og målgruppe]
- Tech stack: referér til AGENTS.md sektion 2
- Arkitekturbeslutninger: dokumentér valg og begrundelser

.planning/STATE.md med:
- Nuværende fase: Fase 1
- Status: Ikke startet
- Næste skridt: Opret PLAN.md for fase 1
- Resume file: .planning/phases/01-setup/PLAN.md

Opret også mappen .planning/phases/

## Trin 4 — Opret fase 1 plan

Opret .planning/phases/01-setup/PLAN.md med en plan for:

[beskriv hvad fase 1 skal indeholde, f.eks. "Opsæt projektstruktur,
database-schema og grundlæggende auth-flow"]

Følg formatet fra AGENTS.md sektion 7:
- Maks 2-3 tasks
- Eksakte filstier
- Verifikationstrin for hver task

## Trin 5 — Validér og commit

1. Kør: bash sync.sh
   Bekræft at alt viser [ok].
2. Kør:
   git add -A
   git commit -m "Initialt setup med AI-konfiguration"

## Trin 6 — Opret GitHub repo og issue

gh repo create [projektnavn] --private --source=. --push
gh label create "phase" --color "0075ca" --description "Fasesporing" 2>/dev/null || true
gh issue create --title "Fase 1: [fasenavn]" --body "$(cat .planning/phases/01-setup/PLAN.md)" --label "phase"

## Trin 7 — Begynd implementering

Start på task 1 i PLAN.md.
Følg TDD: skriv fejlende test først, implementér, refaktor, commit.

---

Bekræft at du har forstået alle trin, og gå derefter i gang fra trin 1.
```
