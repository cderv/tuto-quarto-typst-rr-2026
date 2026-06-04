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

# === publish ===

[group('publish')]
[confirm("Publier sur Posit Connect Cloud ?")]
publish: all
    quarto publish posit-connect-cloud

# Publier sans rebuilder (si just all déjà fait)
[group('publish')]
[confirm("Publier sur Posit Connect Cloud ?")]
publish-only:
    quarto publish posit-connect-cloud

[group('publish')]
[confirm("Publier version pretuto ?")]
publish-pretuto: charte exos site-pretuto
    quarto publish posit-connect-cloud --profile pretuto

# Publier pretuto sans rebuilder (si déjà buildé)
[group('publish')]
[confirm("Publier version pretuto ?")]
publish-pretuto-only:
    quarto publish posit-connect-cloud --profile pretuto
