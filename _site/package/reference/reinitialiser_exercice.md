# Réinitialiser un exercice à son état de départ

Restaure le `starter/` d'un exercice (depuis la copie embarquée dans le
paquet) lorsque vous avez cassé vos fichiers. Votre dossier actuel est
**sauvegardé** (jamais supprimé) avant d'être remplacé.

## Utilisation

``` r
reinitialiser_exercice(
  quel = c("01", "02", "00"),
  dossier = "exercices-typst",
  force = FALSE
)
```

## Arguments

- quel:

  Quel exercice réinitialiser : `"01"` (défaut), `"02"` ou `"00"` (le
  test d'installation).

- dossier:

  Dossier où les exercices ont été installés (le `dest` de
  [`installer_exercices()`](https://cderv.github.io/tuto-quarto-typst-rr-2026/package/reference/installer_exercices.md)).
  Par défaut `"exercices-typst"` : dans ce cas, la fonction **retrouve
  automatiquement** le bon dossier à partir du répertoire courant —
  lancée depuis l'intérieur d'un exercice (p. ex. son `starter/`) ou
  depuis la racine d'installation, elle réinitialise le bon dossier sans
  créer d'arborescence imbriquée. Fournir un chemin explicite
  court-circuite cette détection.

- force:

  Logique. Réinitialiser sans confirmation interactive ? Par défaut
  `FALSE` (en mode non-interactif, `force = TRUE` est requis).

## Valeur de retour

Invisiblement, le chemin du dossier réinitialisé, ou `NULL` si
l'opération a été annulée.

## Exemples

``` r
if (FALSE) { # interactive()
reinitialiser_exercice("01")
}
```
