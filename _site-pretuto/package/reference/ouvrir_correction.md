# Ouvrir la correction d'un exercice (en ligne)

Ouvre, **en ligne** sur GitHub, le dossier `correction/` d'un exercice.
Les corrections ne sont volontairement pas posées par
[`installer_exercices()`](https://cderv.github.io/tuto-quarto-typst-rr-2026/package/reference/installer_exercices.md)
: elles sont plus utiles **après** avoir cherché par vous-même. Une
confirmation est demandée. Pour en obtenir une **copie locale à
retravailler**, voir
[`recuperer_correction()`](https://cderv.github.io/tuto-quarto-typst-rr-2026/package/reference/recuperer_correction.md).

## Utilisation

``` r
ouvrir_correction(quel = c("01", "02"), je_confirme = FALSE)
```

## Arguments

- quel:

  `"01"` (défaut) ou `"02"`.

- je_confirme:

  Logique. Passer la confirmation (utile en script). Défaut `FALSE`.

## Valeur de retour

Invisiblement, l'URL de la correction, ou `NULL` si annulé.

## Voir également

[`recuperer_correction()`](https://cderv.github.io/tuto-quarto-typst-rr-2026/package/reference/recuperer_correction.md)
pour copier la correction en local.

## Exemples

``` r
if (FALSE) { # interactive()
ouvrir_correction("01")
}
```
