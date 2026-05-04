# Exercice 2 — De la page au livre

> 5 fichiers `.qmd`, un `_quarto.yml`, et le rapport Bloc 1 devient un livre
> Quarto avec couverture, TOC, numérotation automatique et brand cohérent.

## Pré-requis

- Quarto 1.9+ (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- Packages R installés : `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales`
- L'extension `orange-book` (livrée avec Quarto 1.9, pas d'install à faire)

## Setup

Partez de [`starter/`](starter/) — 5 fichiers `.qmd` sans `_quarto.yml`. Sans
configuration de projet, `quarto render starter/` produit 5 PDF orphelins :
c'est le point de départ.

## 3 étapes core (12 min)

| # | Action | Vous devriez voir | Concept |
|---|---|---|---|
| 1 | Crée `_quarto.yml` à la racine du starter avec `project: { type: default }` et `format: typst`. Render. | 5 PDF séparés (un par fichier) | Le format est défini une fois pour tout le projet, pas dans chaque `.qmd`. |
| 2 | Passe `type: book`, ajoute `book: { title, chapters: [...], appendices: [...] }`. Le `format: typst` reste — orange-book s'active automatiquement. Render. | **PDF unique** avec couverture orange-book, TOC, **Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1**, numérotation automatique des chapitres. | Le projet `book` assemble les `.qmd` en un livre relié, avec numérotation et navigation cohérentes. |
| 3 | Copie `_brand.yml` (+ `_logo-sw.svg`) à la racine. Render. | Couverture jaune Star Wars + logo, headings en Orbitron, corps en Inter, tableaux `gt` re-stylés. | Le brand suit le projet — pas besoin de répéter les couleurs/fontes dans chaque chapitre. |

## 2 bonus (3 min, pour les rapides)

| # | Action | Vous devriez voir | Concept |
|---|---|---|---|
| B1 | Dans `conclusion.qmd`, ajoute une phrase qui référence `@fig-anatomie-mass` et `@sec-origines`. | « Comme l'a montré la **Figure 1.1**… » avec lien actif vers la figure et le chapitre 2. | Cross-refs inter-chapitres avec numérotation automatique. |
| B2 | Toujours dans `conclusion.qmd`, ajoute en fin de fichier :<br>`::: {.content-visible when-format="typst"}`<br>`{{< pagebreak >}}`<br>`:::` | Saut de page entre la conclusion et l'annexe **dans le PDF uniquement** (pas en HTML preview). | Contenu conditionnel par format de sortie. |

## Pas de `_brand.yml` récupéré du Bloc 1 ?

Pas grave. Copiez ces 2 fichiers à la racine de votre projet pour démarrer
l'étape 3 :

- [`_brand-fallback.yml`](_brand-fallback.yml) → renommer en `_brand.yml`
- [`correction/_logo-sw.svg`](correction/_logo-sw.svg) → copier sous le même nom

C'est une copie 1:1 du brand utilisé dans la correction.

## Et après ?

Le dossier [`correction/`](correction/) contient le projet final, brand inclus,
avec les 3 étapes core ET les 2 bonus appliqués. À comparer avec votre
résultat à la fin de l'exercice.
