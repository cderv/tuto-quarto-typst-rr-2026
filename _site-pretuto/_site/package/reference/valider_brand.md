# Valider un fichier `_brand.yml`

Vérifie qu'un `_brand.yml` est cohérent : schéma valide (via le paquet
`brand.yml`), références croisées (couleurs, polices, logo) et existence
des fichiers de polices `source: file`.

## Utilisation

``` r
valider_brand(chemin = "_brand.yml")
```

## Arguments

- chemin:

  Chemin du fichier `_brand.yml`. Par défaut `"_brand.yml"`.

## Valeur de retour

Invisiblement, `TRUE` si tout est cohérent, `FALSE` sinon.

## Exemples

``` r
if (FALSE) { # interactive()
valider_brand()
}
```
