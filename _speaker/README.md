# `_speaker/` — docs d'animation (interne)

Documents de prompteur et de conception pour l'animation du tutoriel. **Non publiés** (Quarto ignore les dossiers préfixés `_`). À avoir sous les yeux le jour J ou en préparation.

| Doc | Quand l'utiliser | Contenu |
|-----|------------------|---------|
| [`pilotage.qmd`](pilotage.qmd) | **Doc-chapeau, en main pendant toute la séance** | Chronogramme minuté 10h–12h, carte de progression (4 bascules), points de vigilance, accueil/clôture, contingences, checklist matériel |
| [`deroule-minute.qmd`](deroule-minute.qmd) | **Antisèche à projeter / imprimer le jour J** | Vue condensée chronologique de `pilotage.qmd` : par créneau, ce que tu fais / dis / montres + vigilances. **Projection** de `pilotage.qmd` (source de vérité) — resynchroniser si un horaire/durée/bascule change. |
| [`demo-bloc1-our-turn.qmd`](demo-bloc1-our-turn.qmd) | Pendant la démo Our turn du bloc 1 | Pas-à-pas écran : `format: typst` → `_brand.yml` (1 couleur), snippets à coller, pièges, fallbacks |
| [`demo-bloc2-our-turn.qmd`](demo-bloc2-our-turn.qmd) | Pendant la démo Our turn du bloc 2 | Pas-à-pas écran : projet → `type: book`, snippets, pièges, fallbacks |
| [`conception-notes.md`](conception-notes.md) | En préparation (pas le jour J) | Décisions d'animation tranchées, questions ouvertes, checklist logistique pré-jour J |

## Comment ça s'articule

- **`pilotage.qmd`** est le point d'entrée : il donne le déroulé global et **appelle** les deux `demo-bloc*.qmd` aux bons créneaux (Our turn). **`deroule-minute.qmd`** en est la version condensée à projeter/imprimer (mêmes horaires et bascules, en télégraphique) — `pilotage.qmd` reste la source de vérité.
- Les **pièges techniques** (bugs de syntaxe) vivent dans les `demo-bloc*.qmd` → aide-mémoire pour Maëlle en 1:1. Les **points de vigilance pédagogiques** (décrochage, rythme, narration de l'arc) vivent dans `pilotage.qmd` → pour CD au tableau.
- **`conception-notes.md`** garde la mémoire des arbitrages et des questions encore ouvertes — à vider avant le jour J.

Voir aussi les supports participants : `../preparatifs.qmd`, les boussoles `../1-quarto-typst/boussole.qmd` et `../2-projets/boussole.qmd`.
