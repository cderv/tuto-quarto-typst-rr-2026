<!-- README.md is generated; edit this file directly for now. -->

# tutoquartotypst

<!-- badges: start -->
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

Plan B (si l'univers ne répond pas) :

```r
# install.packages("pak")
pak::pak("github::cderv/cderv-tuto-quarto-typst-rr-2026/pkg")
```

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

## Licence

MIT © tutoquartotypst authors
