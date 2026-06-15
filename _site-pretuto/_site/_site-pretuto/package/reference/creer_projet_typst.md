# Créer un projet Quarto + Typst réutilisable

Génère un squelette de projet Typst prêt à l'emploi (hors thème Star
Wars), pour réutiliser ce que vous avez appris **après** le tutoriel :
un document ou un livre, avec une charte `_brand.yml` à adapter. Sur
Quarto \< 1.10.4, le contournement `font-paths` est ajouté
automatiquement aux projets livre.

## Utilisation

``` r
creer_projet_typst(
  dest,
  type = c("document", "livre"),
  brand = TRUE,
  offline = FALSE
)
```

## Arguments

- dest:

  Dossier à créer pour le projet.

- type:

  `"document"` (défaut) pour un `.qmd` unique, ou `"livre"` pour un
  projet livre multi-chapitres.

- brand:

  Logique. Inclure une charte `_brand.yml` à adapter ? Défaut `TRUE`.

- offline:

  Logique. Inclure les polices Inter en local (`source: file`) ? Défaut
  `FALSE`.

## Valeur de retour

Invisiblement, le chemin absolu du projet créé.

## Exemples

``` r
if (FALSE) { # interactive()
creer_projet_typst("mon-rapport")
creer_projet_typst("mon-livre", type = "livre")
}
```
