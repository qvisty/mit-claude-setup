---
layout: page
title: Setup-prompt generator
permalink: /docs/setup-prompt
---

# Setup-prompt generator

Udfyld felterne nedenfor og kopiér prompten direkte ind i Claude Code i dit nye projekt.

<div id="generator">

<label for="project-name"><strong>Projektnavn</strong></label>
<input type="text" id="project-name" placeholder="f.eks. my-saas-app" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">

<label for="project-desc"><strong>Kort beskrivelse af projektet</strong></label>
<textarea id="project-desc" rows="2" placeholder="f.eks. En SaaS-platform til fakturering med Stripe-integration" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;"></textarea>

<label for="framework"><strong>Framework</strong></label>
<select id="framework" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">
  <option value="Next.js (App Router)">Next.js (App Router)</option>
  <option value="Next.js (Pages Router)">Next.js (Pages Router)</option>
  <option value="React + Vite">React + Vite</option>
  <option value="Astro">Astro</option>
  <option value="Remix">Remix</option>
  <option value="Express.js">Express.js</option>
  <option value="FastAPI (Python)">FastAPI (Python)</option>
  <option value="Django">Django</option>
  <option value="Flask">Flask</option>
  <option value="Andet">Andet (skriv i feltet nedenfor)</option>
</select>

<input type="text" id="framework-custom" placeholder="Andet framework..." style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;display:none;">

<label for="language"><strong>Sprog</strong></label>
<select id="language" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">
  <option value="TypeScript">TypeScript</option>
  <option value="JavaScript">JavaScript</option>
  <option value="Python">Python</option>
  <option value="Go">Go</option>
  <option value="Rust">Rust</option>
</select>

<label for="database"><strong>Database</strong></label>
<select id="database" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">
  <option value="PostgreSQL (Prisma)">PostgreSQL (Prisma)</option>
  <option value="PostgreSQL (Drizzle)">PostgreSQL (Drizzle)</option>
  <option value="Supabase">Supabase</option>
  <option value="SQLite">SQLite</option>
  <option value="MongoDB">MongoDB</option>
  <option value="Ingen">Ingen</option>
  <option value="Andet">Andet</option>
</select>

<input type="text" id="database-custom" placeholder="Anden database..." style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;display:none;">

<label for="auth"><strong>Auth</strong></label>
<select id="auth" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">
  <option value="NextAuth.js / Auth.js">NextAuth.js / Auth.js</option>
  <option value="Clerk">Clerk</option>
  <option value="Supabase Auth">Supabase Auth</option>
  <option value="Lucia">Lucia</option>
  <option value="Custom JWT">Custom JWT</option>
  <option value="Ingen">Ingen endnu</option>
  <option value="Andet">Andet</option>
</select>

<input type="text" id="auth-custom" placeholder="Anden auth..." style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;display:none;">

<label for="styling"><strong>Styling</strong></label>
<select id="styling" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">
  <option value="Tailwind CSS">Tailwind CSS</option>
  <option value="CSS Modules">CSS Modules</option>
  <option value="styled-components">styled-components</option>
  <option value="Vanilla CSS">Vanilla CSS</option>
  <option value="Andet">Andet</option>
</select>

<input type="text" id="styling-custom" placeholder="Anden styling..." style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;display:none;">

<label for="testing"><strong>Testframework</strong></label>
<select id="testing" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;">
  <option value="Vitest">Vitest</option>
  <option value="Jest">Jest</option>
  <option value="Playwright">Playwright</option>
  <option value="pytest">pytest</option>
  <option value="Ingen">Ingen endnu</option>
</select>

<label for="phase1"><strong>Fase 1 — hvad skal bygges først?</strong></label>
<textarea id="phase1" rows="2" placeholder="f.eks. Grundlæggende projektstruktur, auth og database-schema" style="width:100%;padding:8px;margin-bottom:12px;font-size:14px;"></textarea>

<label for="systemregler"><strong>Systemregler (forretningsinvarianter)</strong></label>
<textarea id="systemregler" rows="3" placeholder="f.eks. Alle betalinger logges til audit-tabel&#10;Brugerdata forlader aldrig EU&#10;Priser beregnes altid server-side" style="width:100%;padding:8px;margin-bottom:16px;font-size:14px;"></textarea>

<button onclick="generatePrompt()" style="padding:12px 24px;font-size:16px;background:#0075ca;color:white;border:none;border-radius:6px;cursor:pointer;margin-bottom:16px;">Generér prompt</button>

<div id="output-wrapper" style="display:none;">

<h2>Din prompt — klar til copy-paste</h2>

<p>Kopiér hele teksten nedenfor og indsæt som første besked i Claude Code i dit nye projekt.</p>

<button onclick="copyPrompt()" style="padding:8px 16px;font-size:14px;background:#28a745;color:white;border:none;border-radius:6px;cursor:pointer;margin-bottom:8px;" id="copy-btn">Kopiér til udklipsholder</button>

<pre><code id="prompt-output" style="white-space:pre-wrap;word-wrap:break-word;"></code></pre>

</div>
</div>

<script>
// Show custom field when "Andet" is selected
['framework', 'database', 'auth', 'styling'].forEach(function(id) {
  document.getElementById(id).addEventListener('change', function() {
    var custom = document.getElementById(id + '-custom');
    custom.style.display = this.value === 'Andet' ? 'block' : 'none';
  });
});

function getVal(id) {
  var select = document.getElementById(id);
  if (select.value === 'Andet') {
    var custom = document.getElementById(id + '-custom');
    return custom && custom.value ? custom.value : select.value;
  }
  return select.value;
}

function generatePrompt() {
  var name = document.getElementById('project-name').value || 'my-project';
  var desc = document.getElementById('project-desc').value || '[beskriv projektet]';
  var framework = getVal('framework');
  var language = document.getElementById('language').value;
  var database = getVal('database');
  var auth = getVal('auth');
  var styling = getVal('styling');
  var testing = document.getElementById('testing').value;
  var phase1 = document.getElementById('phase1').value || '[beskriv fase 1]';
  var systemregler = document.getElementById('systemregler').value;

  var regler = '';
  if (systemregler) {
    regler = systemregler.split('\n').filter(function(l) { return l.trim(); }).map(function(l) {
      return '- ' + l.trim();
    }).join('\n');
  } else {
    regler = '- [udfyld med projektspecifikke forretningsregler]';
  }

  var prompt = 'Du er ved at sætte et helt nyt projekt op fra bunden. Følg hvert trin i rækkefølge og afvent ikke godkendelse mellem trinene.\n'
    + '\n'
    + '## Trin 1 — Hent setup-filer\n'
    + '\n'
    + 'Kør dette i terminalen:\n'
    + '\n'
    + '```bash\n'
    + 'curl -fsSL https://raw.githubusercontent.com/qvisty/mit-claude-setup/main/install.sh | bash\n'
    + '```\n'
    + '\n'
    + 'Det henter CLAUDE.md, AGENTS.md, RALPH.md, .claude/agents.md, .claude/settings.json, hooks og sync.sh.\n'
    + '\n'
    + '## Trin 2 — Udfyld AGENTS.md med tech stack\n'
    + '\n'
    + 'Åbn AGENTS.md og udfyld sektion 2 (TECH STACK) med:\n'
    + '\n'
    + '| Lag | Teknologi |\n'
    + '|-----|----------|\n'
    + '| Framework | ' + framework + ' |\n'
    + '| Sprog | ' + language + ' |\n'
    + '| Database | ' + database + ' |\n'
    + '| Auth | ' + auth + ' |\n'
    + '| Styling | ' + styling + ' |\n'
    + '| Test | ' + testing + ' |\n'
    + '\n'
    + 'Udfyld også sektion 3 (SYSTEMREGLER) med:\n'
    + '\n'
    + regler + '\n'
    + '\n'
    + '## Trin 3 — Opret planlægningsstruktur\n'
    + '\n'
    + 'Opret mapperne og filerne:\n'
    + '\n'
    + '```\n'
    + '.planning/\n'
    + '  PROJECT.md\n'
    + '  STATE.md\n'
    + '  phases/\n'
    + '```\n'
    + '\n'
    + '### .planning/PROJECT.md\n'
    + '\n'
    + 'Udfyld med:\n'
    + '- **Projektnavn:** ' + name + '\n'
    + '- **Beskrivelse:** ' + desc + '\n'
    + '- **Tech stack:** (referér til AGENTS.md sektion 2)\n'
    + '- **Arkitekturbeslutninger:** Dokumentér valg og begrundelser\n'
    + '\n'
    + '### .planning/STATE.md\n'
    + '\n'
    + 'Sæt indhold til:\n'
    + '- **Nuværende fase:** Fase 1\n'
    + '- **Status:** Ikke startet\n'
    + '- **Næste skridt:** Opret PLAN.md for fase 1\n'
    + '- **Resume file:** `.planning/phases/01-setup/PLAN.md`\n'
    + '\n'
    + '## Trin 4 — Opret fase 1 plan\n'
    + '\n'
    + 'Opret `.planning/phases/01-setup/PLAN.md` med en plan for:\n'
    + '\n'
    + phase1 + '\n'
    + '\n'
    + 'Følg formatet fra AGENTS.md sektion 7: maks 2-3 tasks, eksakte filstier, verifikationstrin.\n'
    + '\n'
    + '## Trin 5 — Validér og commit\n'
    + '\n'
    + '1. Kør `bash sync.sh` og bekræft at alt viser [ok]\n'
    + '2. Lav initial commit:\n'
    + '   ```bash\n'
    + '   git add -A\n'
    + '   git commit -m "Initialt setup med AI-konfiguration for ' + name + '"\n'
    + '   ```\n'
    + '\n'
    + '## Trin 6 — Opret GitHub issue for fase 1\n'
    + '\n'
    + '```bash\n'
    + 'gh label create "phase" --color "0075ca" --description "Fasesporing" 2>/dev/null || true\n'
    + 'gh issue create --title "Fase 1: ' + (phase1.substring(0, 50) || 'Setup') + '" --body "$(cat .planning/phases/01-setup/PLAN.md)" --label "phase"\n'
    + '```\n'
    + '\n'
    + '## Trin 7 — Begynd implementering\n'
    + '\n'
    + 'Start på task 1 i PLAN.md. Følg TDD: skriv fejlende test først, implementér, refaktor, commit.\n'
    + '\n'
    + '---\n'
    + '\n'
    + 'Bekræft at du har forstået alle trin, og gå derefter i gang fra trin 1.';

  document.getElementById('prompt-output').textContent = prompt;
  document.getElementById('output-wrapper').style.display = 'block';
  document.getElementById('output-wrapper').scrollIntoView({ behavior: 'smooth' });
}

function copyPrompt() {
  var text = document.getElementById('prompt-output').textContent;
  navigator.clipboard.writeText(text).then(function() {
    var btn = document.getElementById('copy-btn');
    btn.textContent = 'Kopieret!';
    setTimeout(function() { btn.textContent = 'Kopiér til udklipsholder'; }, 2000);
  });
}
</script>
