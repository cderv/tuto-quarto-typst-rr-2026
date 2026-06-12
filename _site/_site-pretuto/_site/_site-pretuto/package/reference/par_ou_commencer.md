# Par où commencer ?

Boussole : détecte l'état de votre préparation (paquets, Quarto,
exercices installés) et indique la prochaine action à effectuer. En cas
de doute, c'est la fonction à lancer.

## Utilisation

``` r
par_ou_commencer(dossier = "exercices-typst")
```

## Arguments

- dossier:

  Dossier où chercher les exercices installés. Par défaut
  `"exercices-typst"`.

## Valeur de retour

Invisiblement, un mot-clé de l'étape courante (`character`).

## Exemples

``` r
par_ou_commencer()
#> 
#> ── Par où commencer ? ──
#> 
#> ✔ Environnement prêt.
#> ℹ Prochaine étape : `tutoquartotypst::installer_exercices()`.
```
