#!/usr/bin/env bash
# Audit les URLs documentation référencées dans les indices doc (pages exo + boussoles + doc mapping).
# Usage: scripts/audit-doc-links.sh
# Sortie: tableau URL → status HTTP, trié par URL. Exit 1 si une URL non-2xx/3xx.

set -euo pipefail

cd "$(dirname "$0")/.."

# Sources à scanner :
# - pages exo (consigne complète + indices doc collapse)
# - boussoles (uniquement leurs liens internes — pas la page d'indices)
# - doc mapping (référence canonique)
URLS=$(grep -hoE 'https?://[A-Za-z0-9./_#?=&-]+' \
  1-quarto-typst/index.qmd \
  1-quarto-typst/boussole.qmd \
  2-projets/index.qmd \
  2-projets/boussole.qmd \
  .claude/plans/2026-05-19-doc-mapping.md \
  2>/dev/null \
  | grep -E '(quarto\.org|posit-dev\.github\.io|tidyverse\.org|rstudio\.com|typst\.app)' \
  | sort -u)

FAIL=0
printf "%-95s %s\n" "URL" "HTTP"
printf '%.0s-' {1..105}; printf '\n'

for url in $URLS; do
  # HEAD d'abord; certains hôtes peuvent répondre 405 → fallback GET.
  code=$(curl -sI -o /dev/null -w "%{http_code}" --max-time 10 "$url" || echo "ERR")
  if [[ "$code" == "405" || "$code" == "000" || "$code" == "ERR" ]]; then
    code=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url" || echo "ERR")
  fi
  printf "%-95s %s\n" "$url" "$code"
  if [[ ! "$code" =~ ^(2|3) ]]; then
    FAIL=1
  fi
done

if [[ $FAIL -eq 1 ]]; then
  echo
  echo "ATTENTION : au moins une URL est non-2xx/3xx. Patcher avant le J16."
  exit 1
fi
echo
echo "OK : toutes les URLs sont accessibles (2xx/3xx)."
