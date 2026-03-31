# RALPH.md

<!--
  Ralphs operative fil.
  Beholder sin egen TODO-liste og workflow.
  For fulde regler: se AGENTS.md.
-->

## Aktuel opgave

<!-- Beskriv den konkrete opgave Ralph skal løse i denne session -->

## Kontekst

Læs inden du starter:
1. `AGENTS.md` — universal protokol (regler, kodeks, git, Definition of Done)
2. `.planning/STATE.md` — nuværende fase og næste skridt
3. `.planning/PROJECT.md` — requirements og beslutninger

## Kommandoer

```bash
# Test
npm run test -- --run

# TypeScript-tjek
npx tsc --noEmit

# Lint
npx biome check .
```

## TODO-liste (denne session)

<!--
  Ralphs lokale task-liste.
  Tasks spores også som GitHub Issues tilknyttet fasens milestone.
  Se AGENTS.md sektion 6 for milestones og issues.
-->

- [ ] <!-- task 1 -->
- [ ] <!-- task 2 -->
- [ ] <!-- task 3 -->

## Prioritering

Ved hver opgave følges AGENTS.md sektion 8 (Implementering):

1. Læs STATE.md og identificér nuværende fase
2. Find eller opret PLAN.md i fasemappen
3. Skriv fejlende test først → implementér → refaktor
4. Commit med naturlig, forklarende besked (se AGENTS.md sektion 5)
5. Opdatér TODO-listen i denne fil

## Når en hel fase er færdig

Se AGENTS.md sektion 9 (Definition of Done) for den fulde tjekliste.

Derudover:
1. Opdatér `.planning/STATE.md` med ny fasestatus og `Resume file:`
2. Opret `.planning/phases/NN-name/VERIFICATION.md` med dokumentation
3. Luk fasens milestone:
   ```bash
   gh api repos/{owner}/{repo}/milestones/{nummer} -X PATCH -f state=closed
   ```
