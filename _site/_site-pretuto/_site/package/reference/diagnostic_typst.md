# Diagnostic détaillé de la chaîne Quarto / Typst

Agrège les informations utiles au dépannage : chemin et version de
Quarto, version de Typst embarqué, présence du cache de polices, et
verdict sur le besoin du contournement `font-paths` (Quarto \< 1.10.4).

## Utilisation

``` r
diagnostic_typst(projet = ".")
```

## Arguments

- projet:

  Dossier de projet où chercher le cache de polices
  `.quarto/typst/fonts`. Par défaut le répertoire courant.

## Valeur de retour

Invisiblement, une liste des informations collectées.

## Exemples

``` r
if (FALSE) { # interactive()
diagnostic_typst()
}
```
