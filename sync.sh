#!/usr/bin/env bash
# sync.sh — Hold alle AI-konfigurationsfiler synkroniserede
#
# Syncer CLAUDE.md-indhold til AGENTS.md (Codex) og verificerer RALPH.md.
# Kør efter du har redigeret CLAUDE.md.
#
# Brug: bash sync.sh

set -euo pipefail

echo "==> Syncer AI-konfigurationsfiler..."

# --- AGENTS.md (Codex CLI) ---
if [ ! -f CLAUDE.md ]; then
  echo "  [!] CLAUDE.md ikke fundet — springer AGENTS.md over"
else
  # Behold Codex-headeren (øverste sektion til og med den første ---)
  if [ -f AGENTS.md ]; then
    CODEX_HEADER=$(awk '/^---$/{found++} found==1{print; next} found<1{print}' AGENTS.md)
  else
    CODEX_HEADER="# AGENTS.md\n\n<!-- AUTO-SYNCED fra CLAUDE.md via sync.sh -->\n"
  fi

  # Udtræk synced-sektion fra CLAUDE.md (alt efter ## Projekt)
  SHARED=$(awk '/^## Projekt/{found=1} found{print}' CLAUDE.md)

  # Skriv AGENTS.md
  {
    echo "# AGENTS.md"
    echo ""
    echo "<!--"
    echo "  Codex CLI-konfiguration."
    echo "  AUTO-SYNCED fra CLAUDE.md via \`bash sync.sh\` \u2014 rediger ikke manuelt."
    echo "-->"
    echo ""
    echo "## Codex-specifikke indstillinger"
    echo ""
    echo "Anbefalet kørsel: \`codex --approval-mode auto-edit\`"
    echo "Fuld auto (kun sandbox): \`codex --approval-mode full-auto\`"
    echo ""
    echo "Shell-kommandoer der altid kræver godkendelse: \`git push\`, \`rm -rf\`, deployment."
    echo ""
    echo "---"
    echo ""
    echo "<!-- SYNCED CONTENT — do not edit manually -->"
    echo ""
    echo "$SHARED"
  } > AGENTS.md

  echo "  [+] AGENTS.md opdateret fra CLAUDE.md"
fi

# --- RALPH.md tjek ---
if [ ! -f RALPH.md ]; then
  echo "  [~] RALPH.md ikke fundet — springer over (bruges kun af Ralphify)"
else
  echo "  [ok] RALPH.md findes (rediger manuelt efter behov)"
fi

# --- .claude/hooks/ tjek ---
if [ ! -f .claude/hooks/todo-github-sync.py ]; then
  echo "  [!] .claude/hooks/todo-github-sync.py mangler — kør install.sh"
fi

echo ""
echo "==> Sync færdig."
echo "    Rediger kun CLAUDE.md — kør derefter: bash sync.sh"
