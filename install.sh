#!/usr/bin/env bash
# install.sh — Bootstrap qvisty's AI-setup i et nyt projekt
#
# Opretter:
#   CLAUDE.md              → master-konfiguration (Claude Code, GSD, Superpowers, MCP Codex)
#   AGENTS.md              → Codex CLI-konfiguration (synces fra CLAUDE.md)
#   RALPH.md               → Ralphify-konfiguration
#   .claude/agents.md      → Subagent-roller
#   .claude/settings.json  → Tilladelser og hooks
#   .claude/hooks/         → TODO-sync og session-start
#   sync.sh                → Sync CLAUDE.md → AGENTS.md
#
# Brug:
#   curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

set -euo pipefail

BASE="https://raw.githubusercontent.com/qvisty/mit-claude-setup/main"

fetch() {
  local src="$1" dst="$2"
  if [ -f "$dst" ]; then
    echo "  [~] $dst findes allerede — springer over"
  else
    mkdir -p "$(dirname "$dst")"
    curl -fsSL "$BASE/$src" -o "$dst"
    echo "  [+] $dst oprettet"
  fi
}

fetch_force() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  curl -fsSL "$BASE/$src" -o "$dst"
  echo "  [+] $dst opdateret"
}

echo "==> Henter qvisty's AI-setup..."
echo ""

# Rodfilerne
fetch "templates/CLAUDE.md"  "CLAUDE.md"
fetch "templates/AGENTS.md"  "AGENTS.md"
fetch "templates/RALPH.md"   "RALPH.md"

# .claude mappe
fetch "templates/agents.md"      ".claude/agents.md"
fetch "templates/settings.json"  ".claude/settings.json"

# Hooks
fetch_force "templates/hooks/todo-github-sync.py"  ".claude/hooks/todo-github-sync.py"
fetch_force "templates/hooks/post-commit"           ".claude/hooks/post-commit"
fetch_force "templates/hooks/commit-msg"            ".claude/hooks/commit-msg"
chmod +x .claude/hooks/post-commit .claude/hooks/commit-msg 2>/dev/null || true

# sync.sh i roden
fetch_force "sync.sh" "sync.sh"
chmod +x sync.sh

# Installer git hooks hvis .git findes
if [ -d .git ]; then
  echo ""
  echo "==> Installerer git hooks..."
  cp .claude/hooks/commit-msg .git/hooks/commit-msg
  chmod +x .git/hooks/commit-msg
  echo "  [+] .git/hooks/commit-msg installeret"

  cp .claude/hooks/post-commit .git/hooks/post-commit
  chmod +x .git/hooks/post-commit
  echo "  [+] .git/hooks/post-commit installeret"
fi

echo ""
echo "====================================="
echo "  Setup færdig!"
echo "====================================="
echo ""
echo "Næste skridt:"
echo "  1. Udfyld CLAUDE.md med dit projekts detaljer"
echo "  2. Kør 'bash sync.sh' for at synce til AGENTS.md"
echo "  3. Tilpas RALPH.md hvis du bruger Ralphify"
echo ""
echo "Tools og hvilken fil de læser:"
echo "  Claude Code, GSD, Superpowers, MCP Codex  →  CLAUDE.md"
echo "  Codex CLI                                  →  AGENTS.md"
echo "  Ralphify                                   →  RALPH.md"
echo ""
echo "TODO → GitHub Issues:"
echo "  python3 .claude/hooks/todo-github-sync.py"
echo ""
echo "Docs: https://github.com/qvisty/mit-claude-setup"
