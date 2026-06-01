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

# Régénère pkg/inst/exercices/ depuis la source de vérité exercises/
[group('build')]
pkg-sync:
    Rscript pkg/data-raw/sync-exercices.R

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

[group('publish')]
[confirm("Publier version pretuto ?")]
publish-pretuto: charte exos site-pretuto
    quarto publish posit-connect-cloud --profile pretuto
