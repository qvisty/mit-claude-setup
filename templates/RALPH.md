# RALPH.md

<!--
  Ralphify-konfiguration.
  Se også CLAUDE.md for fuld projektbeskrivelse.
-->

## Hvad skal du gøre?

<!-- Beskriv den agent-opgave Ralphify skal løse -->

## Kontekst

Se `CLAUDE.md` for:
- Projektbeskrivelse og arkitektur
- Nøglekommandoer
- Kodestil og konventioner
- Hvad der kræver godkendelse

## Kommandoer til rådighed

```bash
# Kør tests
npm test

# Lint
npm run lint

# Byg
npm run build
```

## Begrænsninger

- Spørg altid før du sletter filer
- Spørg altid før du pusher til remote
- Følg commit-format fra CLAUDE.md

## Loop-instruktioner

<!-- Beskriv hvad agenten skal gøre i løkken -->
1. Kig på opgaven
2. Lav en plan
3. Implementér
4. Kør tests
5. Commit med beskrivende besked
