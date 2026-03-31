---
layout: page
title: Ralph (Ralphify)
permalink: /docs/ralph
---

# Ralph (Ralphify)

Ralph er en AI-agent der kører lokalt via `ralph run .` og læser `RALPH.md` som sin operative fil.

## Hvad er Ralph?

Ralph er designet til at løse **én konkret opgave ad gangen**. Hvor Claude Code er en interaktiv samtale, er Ralph en "fire-and-forget"-agent: du beskriver opgaven i `RALPH.md`, kører ham, og han arbejder selvstændigt til han er færdig.

## Installation

```bash
npm install -g ralphify
```

## Konfiguration

Ralph læser `RALPH.md` i projektets rod. Filen er hans operative arbejdsdokument og indeholder:

- **Aktuel opgave** — hvad Ralph skal løse i denne session
- **Kontekst** — links til AGENTS.md, STATE.md og PROJECT.md
- **TODO-liste** — lokale tasks (ikke GitHub Issues)
- **Prioritering** — trin-for-trin arbejdsgang
- **Definition of Done** — hvornår en task er færdig

## Sådan bruges Ralph

### 1. Beskriv opgaven i RALPH.md

Åbn `RALPH.md` og udfyld "Aktuel opgave"-sektionen:

```markdown
## Aktuel opgave

Implementér login-flow med Google OAuth.
Bruger skal redirectes til dashboard efter login.
```

### 2. Opdatér TODO-listen

```markdown
## TODO-liste (denne session)

- [ ] Opsæt Google OAuth credentials
- [ ] Implementér login-endpoint
- [ ] Implementér callback-endpoint
- [ ] Tilføj redirect til dashboard
```

### 3. Kør Ralph

```bash
ralph run .
```

Ralph læser RALPH.md, følger AGENTS.md-reglerne, og arbejder sig igennem TODO-listen.

## Ralphs workflow

Ralph følger AGENTS.md sektion 8 (Implementering):

1. Læs STATE.md og identificér nuværende fase
2. Find eller opret PLAN.md i fasemappen
3. Skriv fejlende test først → implementér → refaktor
4. Commit med naturlig, forklarende besked
5. Opdatér TODO-listen i RALPH.md

For Definition of Done, se AGENTS.md sektion 9.

## Ralphs begrænsninger

Ralph følger begrænsningerne i AGENTS.md sektion 5 (Git og GitHub). Derudover:
- Spørger altid før han sletter filer
- For usikkerhed om regler: se AGENTS.md

## Ralph vs. Claude Code

| | Ralph | Claude Code |
|---|---|---|
| Interaktion | Fire-and-forget | Interaktiv samtale |
| Konfiguration | RALPH.md | CLAUDE.md |
| Subagents | Nej | Ja |
| Hooks | Nej | Ja |
| Bedst til | Konkrete, afgrænsede opgaver | Udforskning, planlægning, komplekse flows |

## RALPH.md-skabelon

Installeres automatisk med `install.sh`. Se [skabelonen på GitHub](https://github.com/qvisty/mit-claude-setup/blob/main/templates/RALPH.md).
