# Mit Claude & Codex Setup

Et centralt sted for mine konfigurationer med [Claude Code](https://claude.ai/code) og OpenAI Codex.
Undersøtter friktionsfri skift mellem alle AI-tools.

## Understøttede tools

| Tool | Konfigurationsfil | Bemærkninger |
|------|------------------|---------------|
| Claude Code | `CLAUDE.md` | Master-fil |
| GSD (Get Shit Done) | `CLAUDE.md` + `.planning/` | Arver fra CLAUDE.md |
| Superpowers | `CLAUDE.md` + `skills/` | Arver fra CLAUDE.md |
| MCP Server Codex | `CLAUDE.md` | Kører inde i Claude Code |
| Codex CLI | `AGENTS.md` | Auto-synces fra CLAUDE.md |
| Ralphify | `RALPH.md` | Separat, refererer til CLAUDE.md |

## Hurtig start

```bash
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

Installerer alle filer og git hooks. Udfyld derefter `CLAUDE.md` og kør:

```bash
bash sync.sh   # syncer CLAUDE.md → AGENTS.md
```

## Workflow

```
 CLAUDE.md   (rediger kun denne)
     │
     ├─── Claude Code / GSD / Superpowers / MCP Codex  (læser direkte)
     │
     └─── bash sync.sh ───►  AGENTS.md  (Codex CLI)

 RALPH.md   (rediger separat til Ralphify-tasks)
```

## Automatisk TODO → GitHub Issues

TODO-kommentarer i koden synces automatisk til GitHub Issues.

```bash
python3 .claude/hooks/todo-github-sync.py
```

- `// TODO: implement auth` → opretter GitHub Issue
- Fjern TODO fra koden → issue lukkes automatisk
- Kører automatisk efter hvert git commit (via post-commit hook)

## Commit-konvention

Alle AI-tools får besked om at skrive menneskelig læselige commits:

```
feat: tilføj login med Google OAuth
fix: ret crash når kurven er tom
refactor: opdel stor komponent i tre dele
```

En `commit-msg` git hook blokerer vage beskeder som `fix`, `update`, `WIP`.

## Indhold

```
mit-claude-setup/
├── install.sh                    # Bootstrap-script
├── sync.sh                       # Syncer CLAUDE.md → AGENTS.md
├── templates/
│   ├── CLAUDE.md                 # Master-skabelon
│   ├── AGENTS.md                 # Codex-skabelon (auto-synced)
│   ├── RALPH.md                  # Ralphify-skabelon
│   ├── agents.md                 # Subagent-roller til .claude/
│   ├── settings.json             # Tilladelser og hooks
│   └── hooks/
│       ├── todo-github-sync.py   # TODO → GitHub Issues
│       ├── commit-msg             # Git hook: valider commit-tekst
│       └── post-commit            # Git hook: kør todo-sync
└── docs/
    ├── claude-code.md
    ├── codex.md
    ├── workflows.md
    └── unified-setup.md
```

## GitHub Pages

Dokumentation: **https://qvisty.github.io/mit-claude-setup**
