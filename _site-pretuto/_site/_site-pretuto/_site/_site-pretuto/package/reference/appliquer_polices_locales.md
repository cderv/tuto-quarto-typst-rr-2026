# Appliquer le contournement `font-paths` (livre, Quarto \< 1.10.4)

Sur Quarto antérieur à 1.10.4, un projet livre avec `_brand.yml` a
besoin de l'option `font-paths` dans `_quarto.yml` pour trouver les
polices. Cette fonction l'ajoute si nécessaire (et ne fait rien si votre
Quarto est assez récent ou si l'option est déjà présente). Le
`_quarto.yml` est sauvegardé.

## Utilisation

``` r
appliquer_polices_locales(projet = ".")
```

## Arguments

- projet:

  Dossier du projet livre (contenant `_quarto.yml`). Par défaut le
  répertoire courant.

## Valeur de retour

Invisiblement, `TRUE` si le fichier a été modifié, `FALSE` sinon.

## Exemples

``` r
if (FALSE) { # interactive()
appliquer_polices_locales()
}
```
