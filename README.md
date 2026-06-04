# PDF sans frictions : Typst dans vos projets Quarto

> Tutoriel aux [Rencontres R 2026](https://rr2026.sciencesconf.org/) — mardi 16 juin 2026, Nantes Université (10h–12h).

Produire des **documents PDF professionnels** avec Quarto en utilisant **Typst** (à la place de LaTeX) pour fabriquer le PDF, sans rien installer. Personnalisation avec `_brand.yml` et templates Typst, puis passage du document isolé au **livre** multi-chapitres.

**Arc narratif :** `.qmd` → PDF professionnel → livre → personnalisé / pérennisé

- **Instructeurs :** Christophe Dervieux ([Posit](https://posit.co/)) & Maëlle Salmon ([rOpenSci](https://ropensci.org/) / [cynkra](https://cynkra.com/))
- **Durée :** 2h (~1h30 de contenu + pause + Q&A au fil)
- **Prérequis :** Quarto 1.9+, R 4.2+, RStudio / VS Code / Positron — voir [`preparatifs.qmd`](preparatifs.qmd)

🔗 **Site du tutoriel :** <https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26>

## Programme

| | Bloc | Durée |
|---|------|:-----:|
| 1 | [**Un PDF pro en quelques minutes**](1-quarto-typst/index.qmd) — `format: typst`, options, `keep-typ`, `_brand.yml` | ~40 min |
| | _☕ Pause_ | 10 min |
| 2 | [**Passer du document au livre**](2-projets/index.qmd) — projet Quarto, `type: book`, brand au niveau projet | ~40 min |

Chaque bloc suit le rythme **My turn → Our turn → Your turn**. Une [boussole](1-quarto-typst/boussole.qmd) (objectif + étapes + countdown) accompagne chaque exercice. Le bloc 2 est **autonome** : on peut le suivre sans avoir fait le bloc 1.

Le contenu « [Aller plus loin](3-aller-plus-loin/index.qmd) » (raw Typst, template partials, extensions) est une référence pour les curieux, sans créneau dédié.

## Exercices

Tous les exercices utilisent le jeu de données **Star Wars** (`dplyr::starwars`, 87 personnages × 14 variables), en complexité progressive :

| Exercice | Objectif | Difficulté |
|----------|----------|:----------:|
| 1 — [`01-document-typst/`](exercises/01-document-typst/) | `format: typst` + `_brand.yml` + `keep-typ` | ★ |
| 2 — [`02-projet-book/`](exercises/02-projet-book/) | projet `type: book`, brand promu au projet, cross-refs | ★★ |

Chaque exercice fournit un `starter/` (état de départ) et une `correction/`.

## Construire le site

Le build complet est orchestré par [`just`](https://github.com/casey/just) — `quarto render` seul ne suffit pas (il ne rend ni la charte ni les corrections d'exercices) :

```bash
just all        # charte + exercices + paquet R + site (build de référence)
just preview    # ou : quarto preview
```

Nécessite Quarto 1.9+ (pré-release `v1.10.4+` recommandée). Voir les recettes dans le `justfile`.

## Structure du dépôt

```
index.qmd               # Page d'accueil (programme, bios)
preparatifs.qmd         # Instructions d'installation (participants)
1-quarto-typst/         # Bloc 1 — page + slides + boussole
2-projets/              # Bloc 2 — page + slides + boussole
3-aller-plus-loin/      # Topic store complémentaire
4-ressources.qmd        # Liens et ressources externes
exercises/              # Starters + corrections des exercices
pkg/                    # Paquet R compagnon tutoquartotypst
_charte/                # Charte Star Wars (référence palette/typo)
_speaker/               # Docs d'animation (pilotage, démos, notes) — interne
```

## Contexte

- Suit la structure du [tutoriel RR 2023](https://github.com/cderv/tuto-quarto-rr-2023) (website + slides embarquées).
- Prolonge la [présentation `_brand.yml` RR 2025](https://cderv.github.io/rr2025-quarto-brand-yml/).
- Focus **Quarto + Typst** (pas Typst standalone).

## Licence

[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) — Christophe Dervieux & Maëlle Salmon.
