#!/usr/bin/env python3
"""
todo-github-sync.py
Syncer TODO-kommentarer i koden til GitHub Issues automatisk.
Tildeler nye issues til den aktive milestone (åben, med "Fase" i titlen).

Brug:
  python3 .claude/hooks/todo-github-sync.py

Kræver:
  - gh CLI installeret og autentificeret
  - Git repository med GitHub remote
"""
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path

LABEL = "todo-sync"
LABEL_COLOR = "0075ca"
CACHE_FILE = Path(".claude/todo-issues.json")
TODO_PATTERN = re.compile(r'TODO(?:\([^)]+\))?:\s*(.+)')

SKIP_PATHS = [
    ".claude/", "CLAUDE.md", "AGENTS.md", "RALPH.md",
    "node_modules", ".git", "todo-github-sync.py",
    "sync.sh", "install.sh",
]


def run(cmd, check=True):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    if check and result.returncode != 0:
        raise RuntimeError(f"Kommando fejlede: {cmd}\n{result.stderr}")
    return result.stdout.strip()


def check_prereqs():
    """Returnerer repo-navn eller None hvis ikke klar."""
    try:
        run("gh --version")
        repo = run("gh repo view --json nameWithOwner -q .nameWithOwner")
        return repo
    except Exception:
        return None


def get_active_milestone(repo):
    """Finder den aktive milestone (seneste åbne). Returnerer nummer eller None."""
    try:
        result = run(f"gh api repos/{repo}/milestones?state=open", check=False)
        milestones = json.loads(result) if result else []
    except Exception:
        return None

    if not milestones:
        return None

    # Returnér den senest oprettede åbne milestone
    return max(milestones, key=lambda m: m.get("number", 0)).get("number")


def scan_todos():
    """Finder alle TODOs i tracked filer. Returnerer {hash: {file, line, text}}."""
    todos = {}
    try:
        files = run("git ls-files").splitlines()
    except Exception:
        return todos

    for filepath in files:
        if any(p in filepath for p in SKIP_PATHS):
            continue
        try:
            with open(filepath, encoding="utf-8", errors="ignore") as f:
                for lineno, line in enumerate(f, 1):
                    m = TODO_PATTERN.search(line)
                    if m:
                        text = m.group(1).strip()[:200]
                        # Hash på fil + tekst (ikke linje) så flytning ikke laver nyt issue
                        key = hashlib.md5(f"{filepath}:{text}".encode()).hexdigest()[:12]
                        todos[key] = {"file": filepath, "line": lineno, "text": text}
        except Exception:
            pass
    return todos


def load_cache():
    if CACHE_FILE.exists():
        try:
            return json.loads(CACHE_FILE.read_text())
        except Exception:
            pass
    return {}


def save_cache(cache):
    CACHE_FILE.parent.mkdir(parents=True, exist_ok=True)
    CACHE_FILE.write_text(json.dumps(cache, indent=2, ensure_ascii=False))


def ensure_label():
    run(
        f'gh label create "{LABEL}" --color "{LABEL_COLOR}" '
        f'--description "Auto-synced from code TODOs" 2>/dev/null || true',
        check=False,
    )


def create_issue(todo, milestone_num=None):
    body = (
        "**Auto-oprettet fra kode-TODO**\n\n"
        f"Fil: `{todo['file']}:{todo['line']}`\n\n"
        "Dette issue lukkes automatisk når TODO'en fjernes fra koden.\n\n"
        "---\n"
        "*Synket af [qvisty/mit-claude-setup](https://github.com/qvisty/mit-claude-setup)*"
    )
    title = todo["text"]
    cmd = (
        f"gh issue create "
        f"--title {json.dumps(title)} "
        f"--body {json.dumps(body)} "
        f"--label {json.dumps(LABEL)} "
    )
    if milestone_num:
        cmd += f"--milestone {milestone_num} "
    cmd += "--json number -q .number"

    result = run(cmd, check=False)
    return int(result) if result.isdigit() else None


def close_issue(num):
    run(
        f"gh issue close {num} "
        f"--comment \"Automatisk lukket: TODO er fjernet fra koden\"",
        check=False,
    )


def main():
    repo = check_prereqs()
    if not repo:
        print("[todo-sync] gh CLI mangler eller ikke i et GitHub repo — springer over", file=sys.stderr)
        return

    print(f"[todo-sync] Repo: {repo}")
    ensure_label()

    milestone = get_active_milestone(repo)
    if milestone:
        print(f"[todo-sync] Aktiv milestone: #{milestone}")
    else:
        print("[todo-sync] Ingen aktiv milestone fundet — issues oprettes uden milestone")

    cache = load_cache()
    current = scan_todos()

    # Luk issues for TODOs der er fjernet
    removed = set(cache.keys()) - set(current.keys())
    for key in removed:
        issue_num = cache[key].get("issue")
        if issue_num:
            close_issue(issue_num)
            print(f"[todo-sync] Lukket #{issue_num}: {cache[key].get('text', '')[:60]}")
        del cache[key]

    # Opret issues for nye TODOs
    new_keys = set(current.keys()) - set(cache.keys())
    for key in new_keys:
        todo = current[key]
        issue_num = create_issue(todo, milestone)
        cache[key] = {**todo, "issue": issue_num}
        if issue_num:
            print(f"[todo-sync] Oprettet #{issue_num}: {todo['text'][:60]}")
        else:
            print(f"[todo-sync] Advarsel: kunne ikke oprette issue for: {todo['text'][:60]}")

    # Opdater fil/linje på eksisterende
    for key in set(current.keys()) & set(cache.keys()):
        cache[key] = {**current[key], "issue": cache[key].get("issue")}

    save_cache(cache)

    total = len(current)
    created = len(new_keys)
    closed = len(removed)
    print(f"[todo-sync] Færdig — {total} TODOs, {created} nye issues, {closed} lukkede")


if __name__ == "__main__":
    main()
