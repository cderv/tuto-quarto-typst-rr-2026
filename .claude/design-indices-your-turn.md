# Design — Indices / liens doc dans les Your Turn

> **Statut :** brouillon ouvert. À retravailler en session dédiée.
> **Origine :** échange Chris 2026-05-19, suite scope brand R complet (commits 7ccc43d → 6a62267).

## Idée

Pour chaque **Your Turn** (et bonus avancés) du workshop, remplacer la consigne actuelle ultra-procédurale par :

1. **Consigne courte** — objectif fonctionnel (« stylez vos tableaux et plots depuis le brand »), pas la solution pas-à-pas.
2. **Indices = liens vers docs à lire** pour trouver comment faire.
3. **Fallback explicite** — si bloqué après N minutes, ouvrir `correction/`.

But pédagogique : apprenants adultes développent un skill durable (savoir où chercher) au lieu d'exécuter une recette qui s'oublie en sortant de la salle. Aligne sur principes andragogie.

## Pourquoi maintenant

L'ajout du Bonus 4 (brand R) a introduit un bloc de code copiable de ~50 lignes. Reviewers (pédagogue + débutant) ont noté la marche. Mais le problème n'est pas la difficulté technique — c'est l'asymétrie entre :

- **Y our turn principal** (12 min, 3 étapes, code copiable au bout) → consigne précise, mais aucun lien doc → silo
- **Bonus 4 deep dive** → toute la mécanique brand R livrée dans un bloc, sans détour par la doc upstream

Les participants ne savent ni où aller pour creuser, ni quels concepts cherchent à être travaillés. Refactor avec liens doc = règle le problème pour Bonus 4 ET ouvre la voie pour homogénéiser le reste.

## Scope à arbitrer (session dédiée)

### Étendue

- **(i)** Tous les Your turn existants — restructure B1 + B2 step lists
- **(ii)** Seulement les bonus avancés (B1 cross-ref, B2 pagebreak, B3 palette, B4 brand R)
- **(iii)** Juste B4 comme PoC, on étend si effet positif

**Instinct CD/Claude** : (ii) — étapes principales restent verbeuses (timing serré, débutants Quarto), bonus avancés deviennent doc-driven (apprenants déjà engagés).

### Forme

- **(a) Inline par étape** — colonne « 📖 Doc à lire » dans le tableau d'étapes
- **(b) Bloc « Indices » en pied d'exercice** — section dédiée listant les docs par étape
- **(c) Lien à la consigne** — phrase de tâche + parenthèses avec 2-3 liens

**Instinct CD/Claude** : (b) — section dédiée lisible, ne pollue pas le tableau, scannable.

### Fallback correction

Risque : participant bloqué 10 min sans s'autoriser à ouvrir la correction. Mention explicite : « si après 5 min vous bloquez sur une étape, ouvrez `correction/` et inversez la lecture (du résultat vers la cause) ».

**Instinct CD/Claude** : oui — safety net pédagogique.

## Inventaire des docs à référencer

Construire un mapping étape → docs upstream. Sources canoniques :

| Concept | Doc primaire | Doc secondaire |
|---|---|---|
| `format: typst` | https://quarto.org/docs/output-formats/typst.html | — |
| Options Typst (papersize, margin, mainfont, toc, ...) | https://quarto.org/docs/output-formats/typst.html#format-options | https://quarto.org/docs/reference/formats/typst.html |
| `_brand.yml` (YAML schema, palette, fonts, logo) | https://quarto.org/docs/authoring/brand.html | https://posit-dev.github.io/brand-yml/ |
| `brand-color` en Typst raw | https://quarto.org/docs/authoring/brand.html#typst-1 | — |
| `keep-typ: true` | https://quarto.org/docs/output-formats/typst.html (chercher keep-typ) | — |
| `type: book` (chapters, appendices) | https://quarto.org/docs/books/book-basics.html | https://quarto.org/docs/books/book-structure.html |
| Cross-refs `@fig-` `@sec-` | https://quarto.org/docs/authoring/cross-references.html | — |
| Pagebreak conditionnel `content-visible when-format` | https://quarto.org/docs/authoring/conditional.html | — |
| `brand.yml` R helpers (`theme_brand_gt`, `theme_brand_ggplot2`) | https://posit-dev.github.io/brand-yml/pkg/r/articles/branded-themes.html | — |
| `brand_color_pluck()` | https://posit-dev.github.io/brand-yml/pkg/r/reference/brand_color_pluck.html | — |
| gt API (tab_style, cell_fill, cells_*) | https://gt.rstudio.com/reference/tab_style.html | https://gt.rstudio.com/articles/styling-the-table-body.html |
| ggplot2 scale_color_manual | https://ggplot2.tidyverse.org/reference/scale_manual.html | — |
| Highlight Typst | https://typst.app/docs/reference/text/highlight/ | — |

À compléter quand on s'y remet — vérifier que chaque URL est vivante au jour J.

## Risques identifiés

- **Sur-prescription de docs externes** : participant ouvre 8 onglets et se noie. Limite : max 2-3 docs par étape.
- **Liens cassés** : URLs Quarto / Posit changent. Établir un canonical-link audit la veille du 16 juin.
- **Anglais vs français** : la majorité des docs Quarto sont en anglais. OK pour un atelier Rencontres R (public confirmé), mais à mentionner.
- **Recul timing** : chercher dans la doc prend plus de temps que copier la correction. Si l'animateur est limite, le format « indices » risque de creuser le retard.
- **Fragmentation des Your Turn** : restructurer B1 et B2 simultanément + relier au reste du workshop = scope large. Le faire bloc par bloc avec relecture.

## Plan d'attaque en session dédiée

1. Inventaire doc-mapping complet par étape (étendre le tableau ci-dessus).
2. Décider scope (i/ii/iii) + forme (a/b/c) + fallback.
3. Refactor 1 Your turn comme PoC (proposition : B4 Bonus brand R, plus self-contained).
4. Review pédagogue sur le PoC.
5. Si validé, étendre selon scope choisi.
6. Vérifier liens cassés et tester la « charge » sur un timing chronométré.

## Liens vers le contexte actuel

- Y our Turn Bloc 1 : `1-quarto-typst/1-quarto-typst.qmd:225` (slide « À vous ! ») + `1-quarto-typst/index.qmd:42` (callout exercice)
- Your Turn Bloc 2 : `2-projets/2-projets.qmd` (slide) + `2-projets/index.qmd:38` (callout exercice, tableau étapes ligne 49)
- Bonus 4 actuel : `2-projets/index.qmd:152`
- Page Ressources : `4-ressources.qmd` (cible pour mentionner les bibliographies upstream)

## Décisions à valider avant impl

- Scope : (i) / (ii) / (iii)
- Forme : (a) / (b) / (c)
- Fallback correction : oui / non
- Inventaire doc-mapping complet OK avant refactor ?
- Audit links cassés ajouté au PLAN.md « restes pour CD avant le 16 juin » ?
