#!/usr/bin/env bash
# Create the four GitHub repositories and wire the three project repos into this umbrella repo as submodules.
#
# Usage:  scripts/publish_to_github.sh <github-username> [--public]
#
# Before running: log the GitHub CLI in to the target account, and make it the active account:
#   gh auth login          (choose GitHub.com, HTTPS, log in with the browser)
#   gh auth switch --user <github-username>   (only needed if more than one account is logged in)
# Repositories are created PRIVATE unless --public is given.
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <github-username> [--public]" >&2
  exit 1
fi
GH_USER="$1"
VISIBILITY="--private"
if [ "${2:-}" = "--public" ]; then VISIBILITY="--public"; fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CO_AUTHOR="Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
SUBS="soc-new-home-prices ntd-transit-ridership ipeds-faculty-salary"

describe() {
  case "$1" in
    soc-new-home-prices)   echo "STA302 candidate 1: does the marginal price of floor area in new U.S. homes differ across Census divisions? (Census SOC 2025, R)";;
    ntd-transit-ridership) echo "STA302 candidate 2: ridership elasticity to service for fixed-route vs demand-response-only transit agencies (NTD 2024, R)";;
    ipeds-faculty-salary)  echo "STA302 candidate 3: endowment wealth and faculty pay at public vs private nonprofit colleges (IPEDS 2023, R)";;
  esac
}

active="$(gh api user --jq .login)"
if [ "$active" != "$GH_USER" ]; then
  echo "The GitHub CLI is currently logged in as '$active', not '$GH_USER'." >&2
  echo "Run: gh auth login   (then, if needed)   gh auth switch --user $GH_USER" >&2
  exit 1
fi
gh auth setup-git

# 1. Project repositories
for s in $SUBS; do
  repo="sta302-$s"
  dir="$ROOT/projects/$s"
  if [ ! -d "$dir/.git" ]; then echo "Missing local repo: $dir" >&2; exit 1; fi
  if gh repo view "$GH_USER/$repo" >/dev/null 2>&1; then
    echo "== $repo already exists on GitHub; pushing"
    git -C "$dir" remote get-url origin >/dev/null 2>&1 || git -C "$dir" remote add origin "https://github.com/$GH_USER/$repo.git"
    git -C "$dir" push -u origin main
  else
    echo "== creating $GH_USER/$repo"
    (cd "$dir" && gh repo create "$GH_USER/$repo" $VISIBILITY --description "$(describe "$s")" --source . --remote origin --push)
  fi
done

# 2. Register the project repos as submodules of the umbrella repo
cd "$ROOT"
if grep -qx 'projects/' .gitignore; then
  sed -i '' '/^projects\/$/d' .gitignore
  sed -i '' '/^# Sub-repos are added as git submodules/d; /^# Until then they are ignored here/d' .gitignore
fi
for s in $SUBS; do
  if ! git config -f .gitmodules --get "submodule.projects/$s.url" >/dev/null 2>&1; then
    git submodule add "https://github.com/$GH_USER/sta302-$s.git" "projects/$s"
  fi
done
git add .gitignore .gitmodules projects
if ! git diff --cached --quiet; then
  git commit -m "Add the three candidate project repositories as submodules" -m "$CO_AUTHOR"
fi

# 3. Umbrella repository
if gh repo view "$GH_USER/sta302-research-project" >/dev/null 2>&1; then
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/$GH_USER/sta302-research-project.git"
  git push -u origin main
else
  gh repo create "$GH_USER/sta302-research-project" $VISIBILITY \
    --description "STA302H1 Fall 2026 final project: topic search log and three candidate regression studies (submodules)" \
    --source . --remote origin --push
fi

echo
echo "Done. https://github.com/$GH_USER/sta302-research-project"
