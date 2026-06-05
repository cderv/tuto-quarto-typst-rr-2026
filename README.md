# PDF sans frictions : Typst dans vos projets Quarto

> Tutoriel aux [Rencontres R 2026](https://rr2026.sciencesconf.org/) — mardi 16 juin 2026, Nantes Université (10h–12h).

Atelier de 2 h pour produire des **documents PDF professionnels** avec Quarto en s'appuyant sur **Typst** (à la place de LaTeX) : sans installation lourde, avec des erreurs lisibles. On personnalise avec `_brand.yml` et des templates Typst, puis on passe du document isolé au **livre** multi-chapitres.

**Arc :** `.qmd` → PDF professionnel → livre → personnalisé / pérennisé

- **Instructeur·rices :** Christophe Dervieux ([Posit](https://posit.co/)) & Maëlle Salmon ([rOpenSci](https://ropensci.org/) / [cynkra](https://cynkra.com/))
- **Pour qui :** utilisateur·rices de Quarto / R qui veulent de beaux PDF (aucune connaissance de Typst ni de LaTeX requise)

## 🔗 Le site du tutoriel

Tout le contenu (slides, consignes, ressources) est en ligne :

### **<https://cderv.github.io/tuto-quarto-typst-rr-2026/>**

Ce dépôt en contient le **code source**.

## Se préparer (avant le 16 juin)

L'atelier est **interactif** : venez avec un environnement prêt.

1. Installez **Quarto 1.9+** (pré-release `1.10.4+` recommandée), **R 4.2+** et un éditeur (**RStudio**, **Positron** ou **VS Code**).
2. Le plus simple ensuite : le **paquet R compagnon `tutoquartotypst`**, qui installe les paquets, vérifie votre environnement et pose les exercices :

   ```r
   install.packages("tutoquartotypst",
     repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org"))

   tutoquartotypst::verifier_installation()   # tout en vert = prêt·e
   tutoquartotypst::installer_exercices()     # pose les exercices en local
   ```

👉 **Guide complet** (avec chemin d'installation manuel) : [page Préparatifs](https://cderv.github.io/tuto-quarto-typst-rr-2026/preparatifs.html).

## Programme

| | Bloc | Durée |
|---|------|:-----:|
| 1 | [**Un PDF pro en quelques minutes**](https://cderv.github.io/tuto-quarto-typst-rr-2026/1-quarto-typst/) — `format: typst`, options, `keep-typ`, `_brand.yml` | ~40 min |
| | _☕ Pause_ | 10 min |
| 2 | [**Passer du document au livre**](https://cderv.github.io/tuto-quarto-typst-rr-2026/2-projets/) — projet Quarto, `type: book`, brand au niveau projet | ~40 min |

Chaque bloc suit le rythme **My turn → Our turn → Your turn**, avec une **boussole** (objectif + étapes + countdown) par exercice. Le bloc 2 est **autonome** : suivable sans avoir fait le bloc 1. Le contenu « [Aller plus loin](https://cderv.github.io/tuto-quarto-typst-rr-2026/3-aller-plus-loin/) » est une référence pour les curieux, sans créneau dédié.

## Que contient ce dépôt ?

```
index.qmd · preparatifs.qmd   Page d'accueil et instructions d'installation
1-quarto-typst/               Bloc 1 — page + slides + boussole
2-projets/                    Bloc 2 — page + slides + boussole
3-aller-plus-loin/            Ressources complémentaires (hors créneau)
4-ressources.qmd              Liens et ressources externes
exercises/                    Starters + corrections des exercices (Star Wars)
pkg/                          Paquet R compagnon « tutoquartotypst »
_charte/                      Charte graphique Star Wars (palette / typo)
```

Les exercices utilisent le jeu de données **Star Wars** (`dplyr::starwars`) en difficulté progressive : un PDF stylé (★) puis un livre multi-chapitres (★★). Chacun fournit un `starter/` et une `correction/` — le paquet `tutoquartotypst` les pose pour vous.

> Détails de build et conventions de développement : [`.claude/CLAUDE.md`](.claude/CLAUDE.md) (le site se construit avec [`just`](https://github.com/casey/just) — `just all`).

## Contexte

- Suit la structure du [tutoriel RR 2023](https://github.com/cderv/tuto-quarto-rr-2023) (site web + slides embarquées).
- Prolonge la [présentation `_brand.yml` RR 2025](https://cderv.github.io/rr2025-quarto-brand-yml/).
- Focus **Quarto + Typst** (pas Typst standalone).

## Licence

- **Contenu** (texte, slides, exercices, pages) : [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) — voir [`LICENSE`](LICENSE). © Christophe Dervieux & Maëlle Salmon.
- **Code** du paquet R `pkg/` : licence MIT — voir [`pkg/LICENSE.md`](pkg/LICENSE.md).

Composants tiers redistribués avec leur attribution : extension `clean` (MIT, `_extensions/grantmcdermott/clean/LICENSE`), extension `countdown` (`_extensions/gadenbuie/countdown/NOTICE` — pas de licence déclarée en amont pour l'extension), packages Typst (`_typst-packages/`, voir leurs `LICENSE`), police Inter (OFL 1.1, `LICENSE-Inter.txt`), police Star Jedi (freeware fan-made, `LICENSE-StarJedi.txt`). Contributions soumises au [`CODE_OF_CONDUCT.md`](CODE_OF_CONDUCT.md).

> _Star Wars et les noms associés sont des marques de Lucasfilm Ltd. Ce tutoriel utilise l'univers Star Wars à des seules fins pédagogiques et n'est affilié ni à Lucasfilm ni à Disney._
