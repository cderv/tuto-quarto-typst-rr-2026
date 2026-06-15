# Nettoyer les artefacts de rendu d'un projet

Supprime les artefacts de rendu (`_book/`, `*_files/`, `*.typ`) pour
repartir d'un état propre. Ne touche jamais à vos sources ni à
`_fonts/`.

## Utilisation

``` r
nettoyer_cache(projet = ".", polices = FALSE)
```

## Arguments

- projet:

  Dossier de projet à nettoyer. Par défaut le répertoire courant.

- polices:

  Logique. Vider aussi le cache de polices `.quarto/typst/fonts` (force
  le re-téléchargement des polices Google au prochain rendu) ? Par
  défaut `FALSE`.

## Valeur de retour

Invisiblement, le nombre d'éléments supprimés.

## Exemples

``` r
if (FALSE) { # interactive()
nettoyer_cache()
}
```
