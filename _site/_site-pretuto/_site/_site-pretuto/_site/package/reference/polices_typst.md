# Lister les polices vues par Typst

Appelle `quarto typst fonts` pour lister les familles de polices
visibles par Typst, et vérifie la présence d'Inter et de Star Jedi.

## Utilisation

``` r
polices_typst(projet = NULL)
```

## Arguments

- projet:

  Dossier de projet. Si fourni, son sous-dossier `_fonts/` est ajouté au
  chemin de recherche (`--font-path`).

## Valeur de retour

Invisiblement, le vecteur des familles de polices.

## Détails

Une police déclarée `source: google` dans `_brand.yml` (Inter par
défaut) n'apparaît **pas** ici tant qu'un premier rendu ne l'a pas
téléchargée dans le cache. Seules les polices `source: file` (et
système) sont visibles d'emblée.

## Exemples

``` r
if (FALSE) { # interactive()
polices_typst()
}
```
