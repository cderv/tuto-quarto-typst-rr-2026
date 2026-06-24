set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

# Lister recipes groupées
default:
    @just --list

# === build ===

[group('build')]
all: charte exos pkg-sync pkg-site site

[group('build')]
[parallel]
parts: charte exo-typst exo-book

[group('build')]
charte:
    quarto render _charte/charte-starwars.qmd

[group('build')]
exos: exo-typst exo-book

[group('build')]
exo-typst:
    quarto render exercises/01-document-typst/correction/rapport-starwars.qmd

[group('build')]
exo-book:
    quarto render exercises/02-projet-book/correction/

# Régénère pkg/inst/ depuis la source de vérité exercises/
[group('build')]
pkg-sync:
    Rscript pkg/data-raw/sync-exercices.R

# Vérifie que pkg/inst/ est à jour (régénère + échoue si diff) — comme la CI
[group('dev')]
pkg-sync-check:
    Rscript pkg/data-raw/sync-exercices.R --check

# Construit le site pkgdown du paquet dans package/ (publié via resources)
[group('build')]
pkg-site:
    Rscript -e "pkgdown::build_site('pkg')"

[group('build')]
site:
    quarto render

[group('build')]
site-pretuto:
    quarto render --profile pretuto

# === dev ===

# Supprime tous les artefacts de rendu (sites, cache, corrections exercices, pkgdown)
[group('dev')]
clean:
    '_site', '_site-pretuto', '.quarto', 'package' | Where-Object { Test-Path $_ } | Remove-Item -Recurse -Force
    if (Test-Path '_charte/charte-starwars.pdf') { Remove-Item -Force '_charte/charte-starwars.pdf' }
    Get-ChildItem exercises -Recurse -File -Include "*.typ","*.pdf","*.html" | Where-Object Name -ne "charte-starwars.pdf" | Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem exercises -Recurse -Directory | Where-Object { $_.Name -eq "_book" -or $_.Name -like "*_files" } | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

[group('dev')]
preview:
    quarto preview

[group('dev')]
audit:
    bash ./scripts/audit-doc-links.sh

# Rafraîchit les packages Typst vendorisés (_typst-packages/) depuis typst-gather.toml
# Workflow : éditer typst-gather.toml → just typst-packages → git add _typst-packages/ && git commit
[group('dev')]
typst-packages:
    quarto call typst-gather

# === publish ===

# Dispatch de cible partagé (recipe privée) : conditionnel natif just, pas de shebang.
# Évite la dépendance à cygpath/bash sur Windows — la commande émise tourne dans windows-shell (pwsh).
_publish target:
    {{ if target == "gh" { "quarto publish gh-pages --no-render" } else if target == "connect" { "quarto publish posit-connect-cloud --no-render" } else { error("Cible inconnue : '" + target + "' — utiliser 'connect' ou 'gh'") } }}

# Publier le site complet : just publish connect  →  Posit Connect Cloud
#                           just publish gh       →  GitHub Pages (remplace pretuto le jour J)
[group('publish')]
[confirm("Publier le site complet ?")]
publish target: all (_publish target)

# Publier sans rebuilder (si just all déjà fait)
[group('publish')]
[confirm("Publier le site complet (sans rebuild) ?")]
publish-only target: (_publish target)

[group('publish')]
[confirm("Publier version pretuto ?")]
publish-pretuto: site-pretuto
    quarto publish gh-pages --profile pretuto
