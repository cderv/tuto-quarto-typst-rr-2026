# Lister les exercices du tutoriel

Affiche les exercices disponibles avec, pour chacun, son intention. Sert
à s'orienter ; ne dévoile pas les étapes de résolution.

## Utilisation

``` r
lister_exercices()
```

## Valeur de retour

Invisiblement, les codes des exercices (`character`).

## Exemples

``` r
lister_exercices()
#> 
#> ── Exercices du tutoriel ──
#> 
#> • 00-test-install : Test express : rendre un mini-PDF pour valider la chaîne.
#> • 01-document-typst : Votre premier PDF Typst : convertir un rapport en
#> `format: typst`.
#> • 02-projet-book : Un livre Typst personnalisé avec une charte (`_brand.yml`).
#> ℹ Rappel : n'ouvrez pas les dossiers correction/ (en ligne) avant le tutoriel.
```
