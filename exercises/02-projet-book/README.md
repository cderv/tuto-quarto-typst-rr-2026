# Exercice 2 — De la page au livre

> 5 fichiers `.qmd`, un `_quarto.yml`, et le rapport Bloc 1 devient un livre
> Quarto avec couverture, TOC, numérotation automatique et charte cohérente.

## Prérequis

- Quarto 1.9+ (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- Packages R installés : `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales`
- L'extension `orange-book` (livrée avec Quarto 1.9, pas d'install à faire)

## Mise en place

Partez de [`starter/`](starter/) — 5 fichiers `.qmd` sans `_quarto.yml`. Sans
configuration de projet, `quarto render starter/` produit 5 PDF orphelins :
c'est le point de départ.

## 3 étapes principales (12 min)

| # | Action | Vous devriez voir | Concept |
|---|---|---|---|
| 1 | Créez `_quarto.yml` à la racine du starter avec `project: { type: default }` et `format: typst`. Rendez. | 5 PDF séparés (un par fichier) | Le format est défini une fois pour tout le projet, pas dans chaque `.qmd`. |
| 2a | Passez à `type: book` et ajoutez `book: { title, chapters: [...] }`. Le `format: typst` reste — orange-book s'active automatiquement. Rendez. | **PDF unique** avec couverture orange-book, TOC, **Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1**, numérotation automatique des chapitres. `annexe-donnees` apparaît comme dernier chapitre numéroté. | Le projet `book` assemble les `.qmd` en un livre relié, avec numérotation et navigation cohérentes. |
| 2b | Ajoutez `appendices: [annexe-donnees.qmd]` au bloc `book:`. Rendez à nouveau. | `annexe-donnees` bascule en « Annexe A » à la fin du livre, hors numérotation des chapitres. | `appendices:` est parallèle à `chapters:` et sort les fichiers du flux principal de numérotation. |
| 3 | Copiez `_brand.yml` (+ `_logo-sw.svg`) à la racine. Rendez. | Couverture jaune Star Wars + logo, titres en Orbitron, corps en Inter, tableaux `gt` re-stylés. | La charte suit le projet — pas besoin de répéter les couleurs/polices dans chaque chapitre. |

### Modèle `_quarto.yml` pour l'étape 2

Si vous bloquez sur la syntaxe, voici un patron complet à adapter :

```yaml
project:
  type: book

book:
  title: "Anatomie d'une saga"
  author: "Mon Mothma"
  chapters:
    - index.qmd
    - 01-anatomie.qmd
    - 02-origines.qmd
    - conclusion.qmd
  appendices:
    - annexe-donnees.qmd

format:
  typst:
    # Workaround Quarto book : les polices téléchargées par _brand.yml
    # (.quarto/typst/fonts/) ne sont pas passées automatiquement à typst
    # en mode book. À retirer quand le bug upstream est fixé.
    font-paths:
      - .quarto/typst/fonts

execute:
  echo: false
  warning: false
  message: false
```

`chapters:` reçoit les fichiers numérotés normalement. `appendices:`
(parallèle à `chapters:`, pas dedans) reçoit les fichiers qui sortent
du flux principal — ils deviennent A, B, C... et viennent après tous
les chapitres dans le PDF.

> ⚠️ **Bug `gt` à connaître (étape 3)** : si vous voyez « 1 7 5 » au lieu de
> « 175 » dans les tableaux après avoir copié `_brand.yml` (typique sur
> Windows/macOS), c'est un bug connu de `gt` → Typst quand les polices
> de remplacement du tableau s'appliquent. **Correction** : ajoutez `|>
> opt_table_font(font = "Inter")` à la fin de votre pipeline `gt`. Non
> bloquant — vous pouvez continuer sans.

## 2 bonus (3 min, pour les rapides)

| # | Action | Vous devriez voir | Concept |
|---|---|---|---|
| B1 | Dans `conclusion.qmd`, ajoutez une phrase qui référence `@fig-anatomie-mass` et `@sec-origines`. | « Comme l'a montré la **Figure 1.1**… » avec lien actif vers la figure et le chapitre 2. | Références croisées inter-chapitres avec numérotation automatique. |
| B2 | Saut de page conditionnel à la fin de `conclusion.qmd` (voir bloc ci-dessous). | Saut de page entre la conclusion et l'annexe **dans le PDF uniquement** (pas en HTML preview). | Contenu conditionnel par format de sortie. |

**B2 — bloc à coller en fin de `conclusion.qmd`** :

````markdown
::: {.content-visible when-format="typst"}
{{< pagebreak >}}
:::
````

## Pas de `_brand.yml` récupéré du Bloc 1 ?

Pas grave. Copiez ces 2 fichiers à la racine de votre projet pour démarrer
l'étape 3 :

- [`_brand-fallback.yml`](_brand-fallback.yml) → renommer en `_brand.yml`
- [`correction/_logo-sw.svg`](correction/_logo-sw.svg) → copier sous le même nom

C'est une copie 1:1 de la charte utilisée dans la correction.

## Et après ?

Le dossier [`correction/`](correction/) contient le projet final, charte incluse,
avec les 3 étapes principales ET les 2 bonus appliqués. À comparer avec votre
résultat à la fin de l'exercice.
