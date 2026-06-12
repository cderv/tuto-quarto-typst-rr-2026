# Exporter un diagnostic d'installation dans un fichier

Affiche un résumé de votre environnement (R, Quarto, paquets) dans la
console, à copier-coller si vous demandez de l'aide. Peut aussi l'écrire
dans un fichier.

## Utilisation

``` r
exporter_diagnostic(fichier = NULL)
```

## Arguments

- fichier:

  Chemin d'un fichier où écrire **aussi** le diagnostic. Par défaut
  `NULL` : affichage console uniquement (rien à ouvrir).

## Valeur de retour

Invisiblement, les lignes du diagnostic.

## Exemples

``` r
exporter_diagnostic()
#> Diagnostic tutoquartotypst — 2026-06-08 17:56:31
#> 
#> R      : R version 4.5.3 (2026-03-11 ucrt)
#> OS     : Windows 11 x64 (build 26200)
#> Quarto : 1.10.8
#>   chemin: C:/Users/chris/scoop/shims/quarto.exe
#> 
#> Paquets requis :
#>   - quarto : 1.5.1
#>   - dplyr : 1.2.1
#>   - ggplot2 : 4.0.3
#>   - ggrepel : 0.9.6
#>   - gt : 1.3.0
#>   - scales : 1.4.0
#>   - brand.yml : 0.1.0.9000
#>   - prismatic : 1.1.2
#> 
#> ℹ Copiez-collez le texte ci-dessus pour demander de l'aide.
```
