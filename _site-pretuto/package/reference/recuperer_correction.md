# Récupérer la correction d'un exercice en local

Copie les **sources** de la correction d'un exercice (embarquées dans le
paquet) vers un dossier de travail local, pour la **retravailler** après
coup. Comme
[`ouvrir_correction()`](https://cderv.github.io/tuto-quarto-typst-rr-2026/package/reference/ouvrir_correction.md),
une confirmation est demandée : une correction est plus utile une fois
que vous avez cherché par vous-même.

## Utilisation

``` r
recuperer_correction(
  quel = c("01", "02"),
  dest = "exercices-typst",
  force = FALSE
)
```

## Arguments

- quel:

  `"01"` (défaut) ou `"02"`.

- dest:

  Dossier de travail où poser la correction (créé si besoin). Par défaut
  `"exercices-typst"` — la correction atterrit alors dans
  `exercices-typst/<exercice>/correction/`, à côté du `starter/`.

- force:

  Logique. Passer la confirmation **et** écraser une correction déjà
  copiée et non vide ? Par défaut `FALSE` (en mode non-interactif,
  `force = TRUE` est requis pour confirmer la copie).

## Valeur de retour

Invisiblement, le chemin du dossier de correction copié, ou `NULL` si
annulé.

## Détails

Par défaut, la correction est posée à côté du `starter/` correspondant
(dans `exercices-typst/<exercice>/correction/`), ce qui reproduit
l'arborescence du dépôt. Aucun artefact de rendu n'est embarqué : pour
obtenir le PDF / livre, rendez la correction avec `quarto render`.

## Exemples

``` r
if (FALSE) { # interactive()
recuperer_correction("01")
}
```
