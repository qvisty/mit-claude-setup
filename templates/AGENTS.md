# AGENTS.md

<!--
  UNIVERSAL PROTOKOL — læses af ALLE agenter ved sessionstart.
  Autoritativ kilde for regler, kodeks og workflow på tværs af:
  Claude Code + Superpowers (primær), Codex CLI (fallback), plain Claude Code, Ralph.

  CLAUDE.md importerer denne fil via @AGENTS.md
  RALPH.md refererer til denne fil ved faseskift.
  Rediger AGENTS.md direkte — den er IKKE auto-genereret fra CLAUDE.md.
-->

---

## 1. SESSION START

Alle agenter læser ved sessionstart i denne rækkefølge:

1. `.planning/STATE.md` — nuværende fase, status, blokere, næste skridt
2. `.planning/PROJECT.md` — requirements, constraints, arkitektoniske beslutninger
3. Fase-kontekstfilen angivet under `Resume file:` i STATE.md

Ingen kode skrives eller planlægges før disse tre filer er læst.

---

## 2. TECH STACK

<!-- Udfyld med projektets faktiske stack -->

| Lag | Teknologi | Version |
|-----|-----------|--------|
| Framework | Next.js | `<!-- udfyld -->` |
| Sprog | TypeScript | `<!-- udfyld -->` |
| Database | `<!-- udfyld -->` | `<!-- udfyld -->` |
| Auth | `<!-- udfyld -->` | `<!-- udfyld -->` |
| Styling | `<!-- udfyld -->` | `<!-- udfyld -->` |
| Test | `<!-- udfyld -->` | `<!-- udfyld -->` |
| Linting | Biome | `<!-- udfyld -->` |

**Next.js-advarsel:** Stol ikke på træningsdata om Next.js API-syntaks.
Læs `node_modules/next/dist/docs/` eller brug `mcp__77cd43a5__query-docs` før du skriver kode.

---

## 3. SYSTEMREGLER

<!--
  Forretningsinvarianter der aldrig brydes.
  Tilpas til projektet — eksempler nedenfor.
-->

- [ ] `<!-- Eksempel: Alle betalingstransaktioner logges til audit-tabel -->` 
- [ ] `<!-- Eksempel: Brugerdata forlader aldrig EU-region -->` 
- [ ] `<!-- Eksempel: Priser beregnes altid server-side, aldrig client-side -->` 

---

## 4. KODEKODEKS

Regler der gælder for AL kode i projektet:

- **Sprog:** Al kildekode og kommentarer skrives på **engelsk**
- **Docstrings:** Rør aldrig en funktion uden at opdatere dens JSDoc/docstring
- **Placeholders:** Ingen `// TODO: implement later` eller `// placeholder` i kildekode — enten implementér det eller opret et GitHub Issue
- **Mutations:** Brug Server Actions til alle data-mutationer (ikke API routes)
- **Validering:** Zod på ALT brugerinput — ingen undtagelser
- **Tilfældighed:** `crypto.randomBytes()` til tokens og secrets, aldrig `Math.random()`
- **Fejlhåndtering:** Fejl håndteres eksplicit, ingen tomme catch-blokke
- **Typer:** Ingen `any` uden eksplicit kommentar om hvorfor

---

## 5. GIT OG GITHUB

### Branch-strategi

Direkte på `main`. Ingen feature-branches. Ingen pull requests.

### Commit-beskeder

Skriv naturligt og forklar **hvad** og **hvorfor** i almindeligt sprog.

**Dårlige eksempler** (brug aldrig):
```
fix bug
refactor auth logic
update files
WIP
changes
```

**Gode eksempler:**
```
Gjort login-flowet mere robust og fjernet fejl ved timeout
Tilføjet validering på betalingsformular så ugyldige kort afvises tidligt
Opdateret afhængigheder — patchede en sikkerhedssårbarhed i axios
Rettet race condition i checkout når bruger klikker hurtigt
```

### Push-regler

- Push til main **umiddelbart efter commit** — men KUN når tests er grønne
- Push **aldrig** midt i en TDD-cyklus (rød fase)
- Push **aldrig** med `--force` uden eksplicit aftale

---

## 6. GITHUB ISSUES — FASESPORING

Issues bruges **kun** på faseniveau — én issue pr. fase. Individuelle tasks spores ikke som issues.

### Ved fase-start

```bash
# Opret label hvis den ikke eksisterer
gh label create "phase" --color "0075ca" --description "Fasesporing" 2>/dev/null || true

# Opret issue for fasen
gh issue create \
  --title "Fase N: [Fasenavn]" \
  --body "$(cat .planning/phases/NN-name/PLAN.md)" \
  --label "phase"
```

### Ved fase-afslutning

```bash
gh issue close <nummer> --comment "Fase N afsluttet. Se VERIFICATION.md for dokumentation."
```

---

## 7. PLANLÆGNINGSPROTOKOL

Ingen kode skrives uden en `PLAN.md` i den aktuelle fasemappe.

### Claude Code + GSD (primær)

Brug `gsd:plan-phase` skill — ikke en shell-kommando. GSD håndterer strukturen.

### Codex CLI / plain Claude Code (fallback)

Opret `PLAN.md` manuelt med:

```markdown
# Plan: [Fasenavn]

## Opgaver

### Task 1: [Navn]
- **Fil:** `src/lib/foo.ts`
- **Handling:** [præcis beskrivelse]
- **Verifikation:** `npm run test -- --run src/lib/foo.test.ts`

### Task 2: ...
```

Regler:
- Maksimalt 2-3 tasks pr. plan
- Eksakte filstier — ingen vage "update the auth module"
- Hvert task har et konkret verifikationstrin

---

## 8. IMPLEMENTERING

### Claude Code + Superpowers (primær)

Superpowers skills tager over og styrer flowet:
`brainstorming` → `writing-plans` → `test-driven-development` → `requesting-code-review`

Disse skills har forrang over manuelle instruktioner.

### Alle andre agenter (fallback)

1. Følg PLAN.md trin for trin
2. Skriv **fejlende test først** (rød fase)
3. Implementér så testen bliver grøn
4. Refaktorer
5. Commit atomart pr. task

### Testplacering

Testfiler placeres ved siden af kildefiler:
```
src/lib/foo.ts        ← kilde
src/lib/foo.test.ts   ← test
```

---

## 9. DEFINITION OF DONE

En feature er **kun** færdig når alle punkter er opfyldt:

- [ ] Funktionen virker og edge cases er håndteret
- [ ] Sikkerhedsaspekt er gennemtænkt (auth, input, OWASP)
- [ ] ALT brugerinput valideret med Zod
- [ ] Tests grønne: `npm run test -- --run`
- [ ] TypeScript rent: `npx tsc --noEmit`
- [ ] Biome linting rent: `npx biome check .`
- [ ] Kode committet med naturlig, forklarende besked
- [ ] Kode pushet til main: `git push origin main`

### Ved faseskift

1. Opdatér `.planning/STATE.md` med ny fasestatus og `Resume file:`
2. Opret `.planning/phases/NN-name/VERIFICATION.md` med dokumentation for succeskriterier
3. Luk GitHub issue for fasen med opsummerende kommentar
