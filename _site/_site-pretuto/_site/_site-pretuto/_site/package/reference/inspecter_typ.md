# Inspecter le code Typst intermédiaire d'un document

Rend un `.qmd` `format: typst` en conservant le `.typ` intermédiaire
(`keep-typ`), pour comprendre la couche Typst générée par Quarto. Pensé
pour un **document** simple (l'exercice 1) ; pour un livre, le
comportement est moins prévisible.

## Utilisation

``` r
inspecter_typ(qmd, ouvrir = TRUE)
```

## Arguments

- qmd:

  Chemin du fichier `.qmd` à rendre.

- ouvrir:

  Logique. Ouvrir le `.typ` produit dans l'éditeur ? Par défaut `TRUE`.

## Valeur de retour

Invisiblement, le chemin du `.typ` produit, ou `NULL` en cas d'échec.

## Détails

À utiliser **après** avoir produit votre propre PDF : c'est un outil
pour comprendre la couche Typst, pas un raccourci vers la solution de
l'exercice.

## Exemples

``` r
if (FALSE) { # interactive()
inspecter_typ("rapport-starwars.qmd")
}
```
