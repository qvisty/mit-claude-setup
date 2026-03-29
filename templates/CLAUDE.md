# CLAUDE.md

<!--
  MASTER FIL — Single source of truth for alle AI-tools.
  Læses af: Claude Code, GSD, Superpowers, MCP Codex
  Synces til: AGENTS.md (Codex CLI) via `bash sync.sh`
  Opdater KUN denne fil — kør derefter sync.sh
-->

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

# Sync AI-konfigurationsfiler
bash sync.sh

# Sync TODOs til GitHub Issues
python3 .claude/hooks/todo-github-sync.py
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
chore: opdater afhængigheder til nyeste versioner
docs: tilføj setup-vejledning til README
```

**Brug ALDRIG:**
```
fix bug
update files
changes
WIP
feat: implement module  ← for teknisk/vagt
```

Claude committer automatisk i dette format. Én commit pr. logisk ændring.

## GitHub Issues og TODOs

TODO-kommentarer i koden synces automatisk til GitHub Issues via `.claude/hooks/todo-github-sync.py`.

Format der fanges: `// TODO: beskrivelse` eller `# TODO: beskrivelse`

Når en TODO fjernes fra koden, lukkes det tilsvarende issue automatisk.

Kør manuelt: `python3 .claude/hooks/todo-github-sync.py`

## Tilladte handlinger (ingen spørgsmål)

- Redigere filer i `src/` og `tests/`
- Køre tests, lint og build
- Oprette commits og branches
- Oprette nye filer i eksisterende mapper
- Synce TODO-issues

## Kræver altid godkendelse

- Slette filer eller mapper
- Push til remote
- Ændre afhængigheder (`package.json`, `pyproject.toml`)
- Deployment eller infrastrukturændringer
- `git reset --hard` eller andre destruktive git-operationer

## AI-tool setup

Dette projekt bruger qvisty's standardsetup:
- Repo: <https://github.com/qvisty/mit-claude-setup>
- Installer: `curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash`

Konfigurationsfiler i dette projekt:
| Fil | Læses af |
|-----|----------|
| `CLAUDE.md` (denne fil) | Claude Code, GSD, Superpowers, MCP Codex |
| `AGENTS.md` | Codex CLI |
| `RALPH.md` | Ralphify |
| `.claude/agents.md` | Claude Code subagents |
| `.claude/settings.json` | Claude Code hooks og tilladelser |
