# Appliquer une variante de charte Star Wars

Dépose l'une des chartes thématiques (`empire`, `jedi`, `mando`) comme
`_brand.yml` du projet, pour illustrer qu'**un même projet change
d'identité en changeant simplement de charte**. À utiliser **après**
l'exercice. Votre `_brand.yml` est sauvegardé avant remplacement.

## Utilisation

``` r
basculer_charte(variante = c("empire", "jedi", "mando"), projet = ".")
```

## Arguments

- variante:

  `"empire"` (défaut), `"jedi"` ou `"mando"`.

- projet:

  Dossier du projet. Par défaut le répertoire courant.

## Valeur de retour

Invisiblement, le chemin du `_brand.yml`.

## Exemples

``` r
if (FALSE) { # interactive()
basculer_charte("jedi")
}
```
