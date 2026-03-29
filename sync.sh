#!/usr/bin/env bash
# sync.sh — Validerer at AI-konfigurationsfilerne er korrekt sat op
#
# AGENTS.md er en selvstændig fil med eget indhold.
# Denne fil overskriver IKKE AGENTS.md med indhold fra CLAUDE.md.
#
# Hvad sync.sh gør:
#   1. Validerer at AGENTS.md har alle 9 sektioner
#   2. Validerer at CLAUDE.md indeholder de påkrævede @-direktiver
#   3. Rapporterer status
#
# Brug: bash sync.sh

set -euo pipefail

OK=0
FAIL=0

check() {
  local label="$1"
  local result="$2"  # "ok" eller fejlbesked
  if [ "$result" = "ok" ]; then
    echo "  [ok] $label"
    OK=$((OK + 1))
  else
    echo "  [!!] $label — $result"
    FAIL=$((FAIL + 1))
  fi
}

echo "==> Validerer AI-konfigurationsfiler..."
echo ""

# --- AGENTS.md ---
echo "AGENTS.md:"

if [ ! -f AGENTS.md ]; then
  check "AGENTS.md eksisterer" "filen mangler — kør: curl -o AGENTS.md https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/templates/AGENTS.md"
else
  check "AGENTS.md eksisterer" "ok"

  # Tæl sektioner (^## efterfulgt af et ciffer)
  SECTION_COUNT=$(grep -cE '^## [0-9]+\.' AGENTS.md 2>/dev/null || echo 0)
  if [ "$SECTION_COUNT" -eq 9 ]; then
    check "AGENTS.md har 9 sektioner" "ok"
  else
    check "AGENTS.md har 9 sektioner" "fandt $SECTION_COUNT — forventet 9"
  fi

  # Tjek individuelle sektioner
  for section in \
    "1. SESSION START" \
    "2. TECH STACK" \
    "3. SYSTEMREGLER" \
    "4. KODEKODEKS" \
    "5. GIT OG GITHUB" \
    "6. GITHUB ISSUES" \
    "7. PLANLÆGNINGSPROTOKOL" \
    "8. IMPLEMENTERING" \
    "9. DEFINITION OF DONE"
  do
    if grep -qF "## $section" AGENTS.md 2>/dev/null; then
      check "Sektion: $section" "ok"
    else
      check "Sektion: $section" "mangler i AGENTS.md"
    fi
  done
fi

echo ""
echo "CLAUDE.md:"

if [ ! -f CLAUDE.md ]; then
  check "CLAUDE.md eksisterer" "filen mangler — kør install.sh"
else
  check "CLAUDE.md eksisterer" "ok"

  for directive in "@AGENTS.md" "@.planning/PROJECT.md" "@.planning/STATE.md"; do
    if grep -qF "$directive" CLAUDE.md 2>/dev/null; then
      check "Direktiv $directive" "ok"
    else
      check "Direktiv $directive" "mangler i CLAUDE.md"
    fi
  done
fi

echo ""
echo "RALPH.md:"

if [ ! -f RALPH.md ]; then
  check "RALPH.md eksisterer" "filen mangler (valgfri — bruges kun af Ralphify)"
else
  check "RALPH.md eksisterer" "ok"
  if grep -qF "AGENTS.md" RALPH.md 2>/dev/null; then
    check "RALPH.md refererer til AGENTS.md" "ok"
  else
    check "RALPH.md refererer til AGENTS.md" "krydsreference mangler"
  fi
fi

echo ""
echo ".claude/hooks/:"
for hook in todo-github-sync.py commit-msg post-commit; do
  if [ -f ".claude/hooks/$hook" ]; then
    check "$hook" "ok"
  else
    check "$hook" "mangler — kør install.sh"
  fi
done

echo ""
echo "====================================="
if [ "$FAIL" -eq 0 ]; then
  echo "  Alt OK ($OK tjek bestået)"
else
  echo "  $FAIL fejl fundet ($OK/$((OK + FAIL)) bestået)"
  echo ""
  echo "  Kør install.sh for at rette manglende filer:"
  echo "  curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash"
fi
echo "====================================="

[ "$FAIL" -eq 0 ]
