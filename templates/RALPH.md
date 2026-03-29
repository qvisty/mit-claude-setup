# RALPH.md

<!--
  Ralphs operative fil.
  Beholder sin egen TODO-liste og workflow.
  Tilføjer krydsreferencer til den fælles protokol ved faseskift.
  For fulde regler: se AGENTS.md.
-->

## Aktuel opgave

<!-- Beskriv den konkrete opgave Ralph skal løse i denne session -->

## Kontekst

Læs inden du starter:
1. `AGENTS.md` — universal protokol (regler, kodeks, git, DoD)
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

# Push
git push origin main
```

## TODO-liste (denne session)

<!--
  Ralphs lokale task-liste.
  Individuelle tasks spores her — ikke som GitHub Issues.
  GitHub Issues bruges kun på faseniveau (se AGENTS.md sektion 6).
-->

- [ ] <!-- task 1 -->
- [ ] <!-- task 2 -->
- [ ] <!-- task 3 -->

## Prioritering

Ved hver opgave:

1. Læs STATE.md og identificér nuværende fase
2. Opret eller find PLAN.md i fasemappen
3. Skriv fejlende test først (rød fase)
4. Implementér til testen er grøn
5. Refaktorer
6. Commit med **naturlig, forklarende besked** (se AGENTS.md sektion 5 for eksempler)
7. Push til main: `git push origin main` — kun når tests er grønne
8. Opdatér TODO-listen i denne fil

## Definition of Done

En task er færdig når:

- [ ] Funktionen virker og edge cases er håndteret
- [ ] Sikkerhedsaspekt er gennemtænkt
- [ ] ALT brugerinput valideret med Zod
- [ ] Tests grønne: `npm run test -- --run`
- [ ] TypeScript rent: `npx tsc --noEmit`
- [ ] Biome linting rent: `npx biome check .`
- [ ] Kode committet med naturlig, forklarende besked (se AGENTS.md sektion 5)
- [ ] Kode og RALPH.md committet i samme commit
- [ ] Kode er pushet til main: `git push origin main`

## Når en hel fase er færdig

Når alle checkboxes i TODO-listen er markeret:

1. Opdatér `.planning/STATE.md` med ny fasestatus og `Resume file:`
2. Opret `.planning/phases/NN-name/VERIFICATION.md` med dokumentation for succeskriterier
3. Luk GitHub issue for fasen:
   ```bash
   gh issue close <nummer> --comment "Fase N afsluttet. Se VERIFICATION.md for dokumentation."
   ```
4. Tilføj krydsreference i RALPH.md til næste fases kontekstfil

## Begrænsninger

- Spørg altid før du sletter filer
- Push aldrig med `--force`
- Push aldrig midt i en TDD-cyklus (rød fase)
- For usikkerhed om regler: se AGENTS.md
