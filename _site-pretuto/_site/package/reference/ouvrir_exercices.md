# Retrouver et ouvrir le dossier des exercices installés

Filet de sécurité quand on a perdu le message de
[`installer_exercices()`](https://cderv.github.io/tuto-quarto-typst-rr-2026/package/reference/installer_exercices.md)
: ré-affiche le chemin absolu et ouvre le dossier.

## Utilisation

``` r
ouvrir_exercices(dossier = "exercices-typst")
```

## Arguments

- dossier:

  Dossier où les exercices ont été installés. Par défaut
  `"exercices-typst"`.

## Valeur de retour

Invisiblement, le chemin absolu du dossier.

## Exemples

``` r
if (FALSE) { # interactive()
ouvrir_exercices()
}
```
