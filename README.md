# Mit Claude & Codex Setup

Et centralt sted for mine konfigurationer med [Claude Code](https://claude.ai/code) og OpenAI Codex.
Understøtter friktionsfri skift mellem alle AI-tools.

## Understøttede tools

| Tool | Konfigurationsfil | Bemærkninger |
|------|------------------|---------------|
| Claude Code | `CLAUDE.md` | Master-fil (importerer AGENTS.md via @-direktiv) |
| GSD (Get Shit Done) | `CLAUDE.md` + `.planning/` | Fasebaseret workflow |
| Superpowers | `CLAUDE.md` | Automatiske skills i Claude Code |
| Codex CLI | `AGENTS.md` | Selvstændig fil — udfyldes manuelt |
| Ralphify | `RALPH.md` | Separat, refererer til AGENTS.md |

## Hurtig start

```bash
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

Installerer alle filer og git hooks. Udfyld derefter `AGENTS.md` (tech stack + systemregler) og kør:

```bash
bash sync.sh   # validerer at alle filer er korrekt konfigureret
```

## Filstruktur

```
mit-claude-setup/
├── install.sh                    # Bootstrap-script
├── sync.sh                       # Validerer setup (overskriver intet)
├── templates/
│   ├── CLAUDE.md                 # Master-skabelon
│   ├── AGENTS.md                 # Universel protokol (selvstændig)
│   ├── RALPH.md                  # Ralphify-skabelon
│   ├── agents.md                 # Subagent-roller til .claude/
│   ├── settings.json             # Tilladelser og hooks
│   └── hooks/
│       ├── todo-github-sync.py   # TODO → GitHub Issues
│       ├── commit-msg            # Git hook: valider commit-tekst
│       └── post-commit           # Git hook: kør todo-sync
└── docs/
    ├── installation.md           # Fuld installationsguide
    ├── setup-prompt.md           # Copy-paste prompt til nyt projekt
    ├── filer-og-sammenhaeng.md   # Hvordan filerne hænger sammen
    ├── gsd.md                    # Get Shit Done workflow
    ├── superpowers.md            # Automatiske skills
    ├── ralph.md                  # Ralphify-agenten
    ├── claude-code.md            # Claude Code reference
    └── codex.md                  # Codex CLI reference
```

## Automatisk TODO → GitHub Issues

TODO-kommentarer i koden synces automatisk til GitHub Issues.

```bash
python3 .claude/hooks/todo-github-sync.py
```

- `// TODO: implement auth` → opretter GitHub Issue
- Fjern TODO fra koden → issue lukkes automatisk
- Kører automatisk efter hvert git commit (via post-commit hook)

## GitHub Pages

Dokumentation: **https://qvisty.github.io/mit-claude-setup**
