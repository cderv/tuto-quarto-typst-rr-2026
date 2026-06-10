# tutoquartotypst

Paquet compagnon du tutoriel **« PDF sans frictions : Typst dans vos
projets Quarto »** (Rencontres R 2026, 16 juin, Nantes).

Installer le paquet **tire automatiquement tous les prérequis R** du
tutoriel, puis fournit des fonctions pour vérifier votre environnement
et installer les exercices.

## Installation

Depuis r-universe (recommandé, binaires sans compilation) :

``` r

install.packages(
  "tutoquartotypst",
  repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org")
)
```

Plan B (si l’univers ne répond pas) — une fois le paquet sur la branche
`main` :

``` r

# install.packages("pak")
pak::pak("github::cderv/tuto-quarto-typst-rr-2026/pkg")
```

> **À installer d’abord** : **Quarto** et **RStudio**. Le paquet les
> *vérifie* mais ne peut pas les installer à votre place.

## Utilisation

``` r

# 1. Vérifier que tout est en place (R, Quarto, Typst, paquets, rendu de test)
tutoquartotypst::verifier_installation()

# 2. Installer les exercices dans un dossier de votre choix
tutoquartotypst::installer_exercices()

# En cas de doute, une boussole indique la prochaine étape :
tutoquartotypst::par_ou_commencer()
```

> Le paquet est un **raccourci** pour préparer le tutoriel. La page «
> Préparatifs » du site reste la référence et le chemin manuel de
> secours.

## Et après ?

Le paquet va au-delà de la préparation :

- **Pendant** : dépannage et confort
  ([`diagnostiquer_rendu()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/diagnostiquer_rendu.md),
  [`basculer_hors_ligne()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/basculer_hors_ligne.md)
  sans réseau,
  [`valider_brand()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/valider_brand.md),
  [`nettoyer_cache()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/nettoyer_cache.md)…).
- **Après le tutoriel** : réutilisez Quarto + Typst chez vous avec
  [`creer_projet_typst()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/creer_projet_typst.md),
  et explorez les variantes de charte
  ([`basculer_charte()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/basculer_charte.md),
  [`comparer_chartes()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/comparer_chartes.md)).

## Licence

MIT © tutoquartotypst authors
