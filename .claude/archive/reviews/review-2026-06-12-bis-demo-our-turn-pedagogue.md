# Review pédagogue (bis) — Démo Our turn Exo 1 (couleur qui ne « prend » pas)

> Date : 2026-06-12 · Reviewer : pédagogue (design andragogique) · **instantané `bis`**
> **Divergence assumée avec la review pédagogue du même jour (sans suffixe) sur Q1.**
> Elle tranche Q1 → *colorer les titres* ; **moi je tranche l'inverse : NE PAS colorer les titres**, préserver l'arc Bloc 1→Bloc 2, et rendre la démo visible en posant `primary` sur un **vrai lien** ajouté au starter.
> (Rédigée par l'agent pédagogue bis, reportée sur disque par l'orchestrateur — l'agent n'avait pas le droit Write.)

Verdict : corrigeable avant le 16 juin. **1 P0, 2 P1, 2 P2.**

## Le fait décisif (que l'autre review n'utilise pas)

`correction/_brand.yml:23` = `headings: "Star Jedi"` — **une famille de police, pas de `headings.color`.** La cible de l'exercice stylise les titres **par la POLICE** (Star Jedi), pas par la couleur. Donc colorer les titres en rouge dans la démo Our turn montrerait un effet que **l'exercice ne reproduit jamais** : dans l'exo, les titres deviennent Star Jedi **noirs**, pas rouges. → **mismatch démo → exo**, pédagogiquement pire que le bug actuel (le participant cherche des titres rouges qui n'arriveront pas).

Coloriser les titres dans la démo n'est cohérent que si on ajoute aussi `headings.color` à la correction — c.-à-d. **redessiner la charte de l'exo**, ce que CD a explicitement exclu.

## P0-1 — Promesse Our turn fausse et invisible (`1-quarto-typst.qmd:283`, `index.qmd:37`)

`primary` ne colore que les liens ; ni le starter (`starter/rapport-starwars.qmd` : `dplyr::starwars` en backticks l.21, conclusion l.78, **aucun lien**) ni la correction (`correction/rapport-starwars.qmd` : aucun `](` ni `http`) n'a de lien à colorer. Effet live = zéro.

## Réponses §6

- **Q1 → NON, garder les titres noirs.** Cf. fait décisif. L'arc « titres noirs Bloc 1 → titres Star Jedi Bloc 2 » est porté matériellement (`1-quarto-typst.qmd:365` : Bloc 2 repart du `_brand.yml`). `primary`→liens enseigne exactement le concept de **rôle** dont l'étape 3 a besoin.
- **Q2 → `primary` reste dans la démo ET l'étape 3 ; rien ajouté à la boussole.** Le « réflexe de base » (étape 1 seule, `index.qmd:54`) inchangé.
- **Q3 → LE correctif : ajouter UN lien** (`dplyr::starwars` → réf. tidyverse) au **starter + correction + `pkg/inst/`** via `just pkg-sync`. Tout-ou-rien sur les trois copies.
- **Q4 → wording centré sur le lien** : « le lien passe en rouge imperial : `primary` colore les liens ».
- **Q5 → sans objet** : c'est le **lien rouge** (`#BC1E22`, franc) qui porte la démo, pas le fond crème subtil. (On peut garder `background`+`foreground` en complément « ambiance charte », mais la preuve visible = le lien.)

## P1 / P2

- **P1-1 (`1-quarto-typst.qmd:295-311`)** : le snippet étape 2 reste `primary`-only (pas de désync deck/notes), mais ajouter une note **piège anticipé** pour Maëlle : vérifier qu'il y a bien un lien, et que `primary` ne colore **que** les liens (les titres passent en Star Jedi à l'étape 4, non colorés).
- **P1-2 (`1-quarto-typst.qmd:310`)** : réénoncer la marche restante vers Your turn ; ne pas promettre de titres colorés.
- **P2-1 (`index.qmd:62`)** : scinder la cellule Action dense de l'étape 3 en puces.
- **P2-2** : countdown 12 min cohérent boussole/index/deck — RAS.

## Forces confirmées

Rythme M/O/Y respecté, scaffolding `echo: false`, boucle d'autonomie, cliffhanger Bloc 2 planté matériellement, méta-cohérence, **correction cohérente en interne (pas de `headings.color`)** — précisément ce qui rend la coloration de titres en démo incohérente.
