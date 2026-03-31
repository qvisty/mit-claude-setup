---
layout: page
title: Superpowers
permalink: /docs/superpowers
---

# Superpowers

Superpowers er et skill-system der automatisk aktiverer specialiserede arbejdstilstande i Claude Code baseret på hvad du laver.

## Hvad er Superpowers?

Superpowers er en samling af skills der trigges automatisk af kontekst. Når du beder om et code review, aktiverer Superpowers sin review-skill. Når du starter TDD, aktiverer den sin test-skill. Du behøver ikke manuelt vælge — det sker automatisk.

## Skills og rækkefølge

Superpowers skills har en prioriteret rækkefølge:

| Prioritet | Skill | Hvornår den aktiveres |
|-----------|-------|-----------------------|
| 1 | `brainstorming` | Når du udforsker idéer og muligheder |
| 2 | `writing-plans` | Når du planlægger implementation |
| 3 | `test-driven-development` | Når du skriver kode (TDD-flow) |
| 4 | `requesting-code-review` | Når du beder om review af kode |

Skills med højere prioritet (lavere nummer) har forrang over manuelle instruktioner.

## Superpowers i praksis

### Brainstorming

Aktiveres når du stiller åbne spørgsmål som:

```
Hvordan bør vi strukturere auth-modulet?
Hvad er fordele og ulemper ved Prisma vs. Drizzle?
```

Superpowers guider dig igennem en struktureret brainstorm med trade-offs og anbefalinger.

### Writing Plans

Aktiveres når du beder om en plan:

```
Planlæg implementeringen af betalingsflowet
```

Opretter en struktureret plan med tasks, filstier og verifikationstrin.

### Test-Driven Development

Aktiveres ved al kodeimplementering. Tvinger flowet:

1. **Rød** — skriv en fejlende test
2. **Grøn** — implementér mindst mulig kode for at bestå testen
3. **Refaktor** — ryd op uden at bryde tests

### Code Review

Aktiveres når du beder om review:

```
Gennemgå ændringerne siden sidste commit
```

Checker for OWASP-sikkerhedsrisici, testdækning, edge cases og kompleksitet.

## Superpowers i CLAUDE.md

Integrationen er konfigureret i CLAUDE.md-skabelonen:

```markdown
### Superpowers-integration

Superpowers skills aktiveres automatisk ved behov.
Skills har forrang: brainstorming → writing-plans →
test-driven-development → requesting-code-review
```

## Superpowers vs. GSD

| | Superpowers | GSD |
|---|---|---|
| Aktivering | Automatisk baseret på kontekst | Manuel via slash-kommandoer |
| Fokus | Individuelle aktiviteter (brainstorm, TDD, review) | Fasestruktur og fremdrift |
| Planlægning | `writing-plans` skill | `/gsd:plan-phase` |
| Verificering | `requesting-code-review` skill | `/gsd:verify-work` |

**De komplementerer hinanden:** GSD styrer den overordnede fasestruktur, Superpowers styrer kvaliteten af det arbejde der udføres inden for hver fase.

## Tips

- **Lad Superpowers styre** — undgå at override skills med manuelle instruktioner
- **Brainstorm før du planlægger** — lad `brainstorming`-skill'en udfolde sig før du går til planlægning
- **TDD er ikke valgfrit** — Superpowers tvinger TDD-flowet, og det er med vilje
- Superpowers kører inde i Claude Code — der er ingen separat installation
