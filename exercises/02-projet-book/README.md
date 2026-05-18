# Exercice 2 — De la page au livre

> 5 fichiers `.qmd`, un `_quarto.yml`, et le rapport Bloc 1 devient un livre
> Quarto avec couverture, TOC, numérotation automatique et charte cohérente.

## Prérequis

- Quarto 1.9+ (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- Packages R installés : `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales`
- L'extension `orange-book` (livrée avec Quarto 1.9, pas d'install à faire)

## Mise en place

Partez de [`starter/`](starter/) — 5 fichiers `.qmd` sans `_quarto.yml`. Sans
configuration de projet, `quarto render starter/` produit 5 fichiers HTML
séparés (format par défaut de Quarto) : c'est le point de départ. La première
étape ajoute `_quarto.yml` avec `format: typst` pour basculer en PDF.

## 3 étapes principales (12 min)

| # | Action | Vous devriez voir | Concept |
|---|---|---|---|
| 1 | Créez `_quarto.yml` à la racine du starter avec `project: { type: default }` et `format: typst`. Rendez. | 5 PDF séparés (un par fichier) | Le format est défini une fois pour tout le projet, pas dans chaque `.qmd`. |
| 2a | Passez à `type: book` et ajoutez `book: { title, chapters: [...] }`. Le `format: typst` reste — orange-book s'active automatiquement. Rendez. | **PDF unique** avec couverture orange-book, TOC, **Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1 / Table 2.2**, numérotation automatique des chapitres. `annexe-donnees` apparaît comme dernier chapitre numéroté. | Le projet `book` assemble les `.qmd` en un livre relié, avec numérotation et navigation cohérentes. |
| 2b | Ajoutez `appendices: [annexe-donnees.qmd]` au bloc `book:`. Rendez à nouveau. | `annexe-donnees` bascule en « Annexe A » à la fin du livre, hors numérotation des chapitres. | `appendices:` est parallèle à `chapters:` et sort les fichiers du flux principal de numérotation. |
| 3 | Copiez `_brand.yml` (+ `_logo-sw.svg` + `_fonts/`) à la racine. Rendez. | Couverture jaune Star Wars + logo, titres en Star Jedi, corps en Inter, tableaux `gt` re-stylés. | La charte suit le projet — pas besoin de répéter les couleurs/polices dans chaque chapitre. |

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
    # Logo personnalisé : sans cette section, Quarto place le logo
    # `_brand.yml` à 1.5in width / 0.75in padding par défaut, ce qui
    # chevauche les titres dès la 2e page.
    logo:
      path: sw-star
      location: left-top
      width: 0.6in
      padding: 0.4in

execute:
  echo: false
  warning: false
  message: false
```

`chapters:` reçoit les fichiers numérotés normalement. `appendices:`
(parallèle à `chapters:`, pas dedans) reçoit les fichiers qui sortent
du flux principal — ils deviennent A, B, C... et viennent après tous
les chapitres dans le PDF.

::: {.callout-warning collapse="true"}
## Polices brand pas chargées (Quarto < v1.10.4)

Sur **Quarto stable `1.9.x`** ou **pre-release `1.10.0` à `1.10.3`**, les
polices déclarées dans `_brand.yml` ne sont pas passées automatiquement à
Typst en mode `book` (titres en serif au lieu de Star Jedi, warning
`unknown font family: ...` à la compilation). Bug corrigé par
[quarto-dev/quarto-cli#14517](https://github.com/quarto-dev/quarto-cli/pull/14517),
fix livré à partir de la pre-release `v1.10.4`.

Si vous êtes sur une version concernée, ajoutez ce bloc dans `format.typst`
de votre `_quarto.yml` :

```yaml
format:
  typst:
    font-paths:
      - .quarto/typst/fonts   # cache des polices Google (Inter)
      - _fonts                # polices locales `source: file` (Star Jedi)
```

Sur Quarto `v1.10.4+`, ce bloc est inutile (anodin mais redondant).
:::

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

## Bonus 3 — Changer de palette Star Wars

La correction propose 3 variantes de `_brand.yml` clés en main, toutes dans
[`correction/`](correction/) :

| Fichier | Identité | Couleur primaire |
|---|---|---|
| [`_brand-empire.yml`](correction/_brand-empire.yml) (= défaut) | Empire / Sith | Imperial Red `#BC1E22` |
| [`_brand-jedi.yml`](correction/_brand-jedi.yml) | Jedi / R2-D2 | R2-D2 Blue `#2A5A97` |
| [`_brand-mando.yml`](correction/_brand-mando.yml) | Mandalorien | Mando Crimson `#C83444` |

Pour changer de palette sans renommer de fichiers, déclarez la variante
choisie dans `_quarto.yml` :

```yaml
brand: _brand-jedi.yml
```

Quarto utilise cette charte au lieu du `_brand.yml` par défaut. Le logo
SW et les polices Star Jedi / Inter restent identiques entre les
variantes — seule la couleur primaire (couverture, titres, TOC, liens)
change.

> ℹ️ **Pourquoi pas le jaune SW iconique `#FFE81F` comme `primary` ?**
> L'extension `orange-book` (auto-activée en `format: typst` + `type:
> book`) utilise `brand-color.primary` à la fois pour la teinte de
> couverture **et** pour le texte de la TOC / des titres / des liens.
> Un jaune saturé sur fond cream devient illisible. Les 3 variantes
> ci-dessus choisissent un `primary` sombre adapté au corps de texte ;
> le jaune SW reste disponible dans la palette si vous voulez
> l'utiliser ailleurs (graphiques, blocs custom).

## Et après ?

Le dossier [`correction/`](correction/) contient le projet final, charte incluse,
avec les 3 étapes principales ET les 2 bonus appliqués. À comparer avec votre
résultat à la fin de l'exercice.
