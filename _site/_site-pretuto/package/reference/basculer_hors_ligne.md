# Basculer un exercice en mode hors-ligne (polices Inter locales)

Quand le réseau manque, Inter (déclarée `source: google` dans
`_brand.yml`) ne peut pas être téléchargée. Cette fonction dépose les
fichiers Inter embarqués dans `_fonts/` et bascule l'entrée Inter de
`_brand.yml` en `source: file` — **sans toucher** au reste de votre
charte (couleurs, etc.). Votre `_brand.yml` est sauvegardé avant
modification.

## Utilisation

``` r
basculer_hors_ligne(projet = ".", retour = FALSE)
```

## Arguments

- projet:

  Dossier de l'exercice (contenant `_brand.yml`). Par défaut le
  répertoire courant.

- retour:

  Logique. Restaurer le `_brand.yml` d'origine (revenir en ligne) ? Par
  défaut `FALSE`.

## Valeur de retour

Invisiblement, le chemin du `_brand.yml`, ou `NULL` si rien n'a été
modifié.

## Exemples

``` r
if (FALSE) { # interactive()
basculer_hors_ligne()
basculer_hors_ligne(retour = TRUE)
}
```
