# AGENTS.md

<!--
  Codex CLI-konfiguration.
  AUTO-SYNCED fra CLAUDE.md via `bash sync.sh` — rediger ikke manuelt.
  Indeholder samme indhold som CLAUDE.md + Codex-specifikke tilføjelser.
-->

## Codex-specifikke indstillinger

**Anbefalet tilstand:** `--approval-mode auto-edit` for fileredigeringer, manuel godkendelse af shell-kommandoer.

```bash
# Normal brug
codex "beskriv opgaven her"

# Auto-edit tilstand (redigeringer godkendes automatisk)
codex --approval-mode auto-edit "refaktorér auth-modulet"

# Fuld auto (kun i sandbox/Docker)
codex --approval-mode full-auto "kør alle tests og fix fejl"
```

**Shell-kommandoer der altid kræver godkendelse:**
- `git push`
- `rm -rf`
- `git reset --hard`
- Deployment-kommandoer

---

<!-- SYNCED CONTENT BELOW — do not edit manually, run: bash sync.sh -->

## Projekt

<!-- Beskriv projektet i 2-3 sætninger -->
**Navn:** 
**Formål:** 
**Stack:** 

## Arkitektur

<!-- Kort beskrivelse af mappestruktur og nøglemoduler -->
```
project/
├── src/
├── tests/
└── ...
```

## Nøglekommandoer

```bash
# Installer
npm install

# Test
npm test

# Byg
npm run build

# Lint
npm run lint
```

## Kodestil og konventioner

- **Sprog:** TypeScript / Python / andet
- **Formatter:** Prettier / Black — kør automatisk
- **Linter:** ESLint / Ruff
- **Testframework:** Jest / pytest
- **Sprog i kode og kommentarer:** Engelsk

## Commit-beskeder (VIGTIGT)

Skriv ALTID commit-beskeder i naturligt, forståeligt sprog der forklarer hvad og hvorfor.
Format: `type: kort beskrivelse der giver mening for et menneske`

**Gode eksempler:**
```
feat: tilføj login med Google OAuth
fix: ret crash når kurven er tom ved checkout
refactor: opdel 400-linje komponent i tre dele
```

## Tilladte handlinger

- Redigere filer i `src/` og `tests/`
- Køre tests, lint og build
- Oprette commits og branches

## Kræver altid godkendelse

- Slette filer eller mapper
- Push til remote
- Ændre afhængigheder
- Deployment
