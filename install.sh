#!/usr/bin/env bash
# install.sh — Hent qvisty's Claude/Codex setup til det aktuelle projekt
# Brug: curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

set -euo pipefail

BASE_URL="https://raw.githubusercontent.com/qvisty/mit-claude-setup/main"

echo "==> Henter qvisty's Claude setup..."

# CLAUDE.md i projektets rod
if [ ! -f CLAUDE.md ]; then
  curl -fsSL "$BASE_URL/templates/CLAUDE.md" -o CLAUDE.md
  echo "  [+] CLAUDE.md oprettet"
else
  echo "  [~] CLAUDE.md findes allerede – springer over"
fi

# .claude mappe
mkdir -p .claude

# agents.md
if [ ! -f .claude/agents.md ]; then
  curl -fsSL "$BASE_URL/templates/agents.md" -o .claude/agents.md
  echo "  [+] .claude/agents.md oprettet"
else
  echo "  [~] .claude/agents.md findes allerede – springer over"
fi

# settings.json
if [ ! -f .claude/settings.json ]; then
  curl -fsSL "$BASE_URL/templates/settings.json" -o .claude/settings.json
  echo "  [+] .claude/settings.json oprettet"
else
  echo "  [~] .claude/settings.json findes allerede – springer over"
fi

echo ""
echo "==> Done. Tilpas filerne til dit projekt:"
echo "    - CLAUDE.md              (projektspecifikke instruktioner til Claude)"
echo "    - .claude/agents.md      (specialiserede agent-roller)"
echo "    - .claude/settings.json  (tilladelser og hooks)"
