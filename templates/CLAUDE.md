# CLAUDE.md

> **Instruktioner til Claude Code for dette projekt.**
> Tilpas sektionerne nedenfor til det konkrete projekt.

## Projektbeskrivelse

<!-- Beskriv kort hvad projektet gør og dets primære teknologier -->

## Arkitektur

<!-- Beskriv mappestruktur, vigtige moduler, mønstre -->

```
project/
├── src/
├── tests/
└── ...
```

## Kommandoer

```bash
# Installer afhængigheder
npm install

# Kør tests
npm test

# Byg
npm run build

# Lint
npm run lint
```

## Kodestil og konventioner

- Sprog: [TypeScript / Python / andet]
- Formatter: [Prettier / Black / andet] — kør automatisk på ændrede filer
- Linter: [ESLint / Ruff / andet]
- Commit-format: `type(scope): beskrivelse` (Conventional Commits)

## Vigtige filer

| Fil | Beskrivelse |
|-----|-------------|
| `src/index.ts` | Indgangspunkt |
| `...` | `...` |

## Hvad Claude MÅ gøre uden at spørge

- Redigere filer i `src/` og `tests/`
- Køre tests og lint
- Oprette nye filer i eksisterende mapper

## Hvad Claude ALTID skal spørge om

- Slette filer eller mapper
- Pushe til remote
- Ændre afhængigheder i `package.json` / `pyproject.toml`
- Deployment eller infrastrukturændringer

## Eksternt setup-reference

Dette projekt bruger qvisty's standardsetup:
https://github.com/qvisty/mit-claude-setup
