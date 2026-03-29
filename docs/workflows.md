---
layout: page
title: Arbejdsgange
permalink: /docs/workflows
---

# Mine arbejdsgange

## 1. Bootstrap et nyt projekt

```bash
# Initialisér repo
git init my-project && cd my-project

# Hent mit setup
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

# Tilpas CLAUDE.md til projektet
claude  # og bed Claude om at udfylde kontekst
```

## 2. Feature-udvikling med Claude Code

```
1. Beskriv feature i Claude Code
2. Bed Claude om en plan (brug planner-agent)
3. Gennemgå planen
4. Lad Claude implementere
5. Kør tests automatisk
6. Review med reviewer-agent
7. Commit og push
```

## 3. Instruér fremtidigt projekt om at hente dette setup

I din `CLAUDE.md` i et nyt projekt:

```markdown
## Setup-reference
Dette projekt følger qvisty's standardsetup.
Hvis du mangler kontekst om konventioner, se:
https://github.com/qvisty/mit-claude-setup

Installer med:
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash
```

## 4. Brug Codex til hurtige opgaver

```bash
# Enkelt spørgsmål / lille ændring
codex "fiks lint-fejlen i src/index.ts"

# Auto-edit tilstand til større ændringer
codex --approval-mode auto-edit "refaktorér auth-modulet til at bruge JWT"
```

## 5. Parallel opgaveløsning med subagents

Bed Claude Code om at spawne parallelle agenter:

```
"Kør tests og lint parallelt, og rapportér samlet resultat"
```

## Nyttige one-liners

```bash
# Opdatér dine templates fra dette repo
curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash

# Se hvad der er ændret siden sidste commit
git diff HEAD

# Hent seneste version af én template
curl -o CLAUDE.md https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/templates/CLAUDE.md
```
