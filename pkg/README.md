<!-- README.md is generated; edit this file directly for now. -->

# tutoquartotypst

<!-- badges: start -->
[![r-universe](https://cderv.r-universe.dev/badges/tutoquartotypst)](https://cderv.r-universe.dev/tutoquartotypst)
[![pkg-check](https://github.com/cderv/tuto-quarto-typst-rr-2026/actions/workflows/pkg-check.yml/badge.svg)](https://github.com/cderv/tuto-quarto-typst-rr-2026/actions/workflows/pkg-check.yml)
<!-- badges: end -->

Paquet compagnon du tutoriel **« PDF sans frictions : Typst dans vos projets
Quarto »** (Rencontres R 2026, 16 juin, Nantes).

Installer le paquet **tire automatiquement tous les prérequis R** du tutoriel,
puis fournit des fonctions pour vérifier votre environnement et installer les
exercices.

## Installation

Depuis r-universe (recommandé, binaires sans compilation) :

```r
install.packages(
  "tutoquartotypst",
  repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org")
)
```

Plan B (si l'univers ne répond pas) — une fois le paquet sur la branche `main` :

```r
# install.packages("pak")
pak::pak("github::cderv/tuto-quarto-typst-rr-2026/pkg")
```

> **À installer d'abord** : **Quarto** et **RStudio**. Le paquet les *vérifie*
> mais ne peut pas les installer à votre place.

## Utilisation

```r
# 1. Vérifier que tout est en place (R, Quarto, Typst, paquets, rendu de test)
tutoquartotypst::verifier_installation()

# 2. Installer les exercices dans un dossier de votre choix
tutoquartotypst::installer_exercices()

# En cas de doute, une boussole indique la prochaine étape :
tutoquartotypst::par_ou_commencer()
```

> Le paquet est un **raccourci** pour préparer le tutoriel. La page
> « Préparatifs » du site reste la référence et le chemin manuel de secours.

## Et après ?

Le paquet va au-delà de la préparation :

- **Pendant** : dépannage et confort (`diagnostiquer_rendu()`, `basculer_hors_ligne()`
  sans réseau, `valider_brand()`, `nettoyer_cache()`…).
- **Après le tutoriel** : réutilisez Quarto + Typst chez vous avec
  `creer_projet_typst()`, et explorez les variantes de charte
  (`basculer_charte()`, `comparer_chartes()`).

## Licence

MIT © tutoquartotypst authors
