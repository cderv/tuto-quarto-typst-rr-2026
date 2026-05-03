# Plan — Exo 2 : projet Quarto book Star Wars (P1)

## Context

**Pourquoi.** Le workshop *« PDF sans frictions : Typst dans vos projets Quarto »* (Rencontres R 2026, Nantes, 16 juin, 2 h) suit l'arc `.qmd → PDF pro → livre → personnalisé`. Le Bloc 1 livre un rapport Star Wars standalone branded (Exo 1, livré). Le Bloc 2 doit fournir l'Exo 2 (« passer à l'échelle : projet et livre ») — actuellement **manquant**, ce qui produit un lien 404 dans `2-projets/index.qmd:48` et bloque le support pédagogique des concepts core du Bloc 2 (`_quarto.yml`, `type: book`, orange-book, brand promu, cross-refs, conditional content).

**Décisions tranchées** (réponses CD ce 2026-05-03) :
1. **5 étapes** : config → book → brand (étape 3, le wow) → bonus cross-ref → bonus pagebreak. Met à jour les slides Bloc 2 pour annoncer ces 5 étapes.
2. **`_brand.yml` Exo 2 = variante book-spécifique** : ajout `logo` (clin d'œil — étoile jaune SW en SVG) en plus de la palette/fonts d'Exo 1.
3. **Auteur book** : nom Star Wars inventé. Default proposé : **Mon Mothma** (sénatrice, ton sérieux qui colle à un livre statistique) ; alternative ludique : **C-3PO**. À trancher au moment de l'écriture.
4. **`conclusion.qmd` numéroté** (chapitre 3) — pas de `{.unnumbered}`.

**Caveats Quarto vérifiés via context7** (à respecter) :
- `appendices:` sous `book:`, parallèle à `chapters:` ✅
- `{.unnumbered}` sur le H1 du chapitre — préface OK, conclusion en chapitre numéroté ✅
- `.content-visible when-format="typst"` syntaxe div confirmée ✅
- `{{< pagebreak >}}` shortcode Quarto natif (HTML/PDF/Typst) ✅
- Cross-refs `@fig-`/`@tbl-`/`@sec-` (tirets) ; numérotation chapitre auto en projet book (Fig 1.1) ✅
- ⚠️ « cross-referencing figures or tables within unnumbered chapters is not supported » → on n'en définit pas dans la préface ; conclusion reste numérotée pour autoriser tout pattern.

**Résultat attendu.** Un dossier `exercises/02-projet-book/` avec `correction/` rendable, `starter/` cohérent, `_brand-fallback.yml`, `README.md`, slides Bloc 2 mises à jour pour refléter les 5 étapes, lien 404 résolu.

## Arborescence cible

```
exercises/02-projet-book/
├── README.md                                      # consigne, 5 étapes, fallback brand
├── _brand-fallback.yml                            # copie 1:1 de correction/_brand.yml
├── starter/
│   ├── README.md                                  # 4 lignes : « créer _quarto.yml d'abord »
│   ├── index.qmd                                  # préface unnumbered
│   ├── 01-anatomie.qmd                            # SANS opt_table_font (bug visible péda)
│   ├── 02-origines.qmd                            # nouveau contenu R figé
│   ├── conclusion.qmd                             # SANS cross-refs SANS pagebreak
│   └── annexe-donnees.qmd
└── correction/
    ├── _quarto.yml                                # type:book + appendices + format:typst
    ├── _brand.yml                                 # palette SW + fonts + logo SVG
    ├── _logo-sw.svg                               # étoile jaune minimale
    ├── index.qmd
    ├── 01-anatomie.qmd                            # AVEC opt_table_font
    ├── 02-origines.qmd
    ├── conclusion.qmd                             # AVEC cross-refs + pagebreak typst
    └── annexe-donnees.qmd
```

## Spec contenu — correction

### `correction/_quarto.yml`

```yaml
project:
  type: book

book:
  title: "Anatomie d'une saga"
  subtitle: "Portrait statistique des personnages de Star Wars"
  author: "Mon Mothma"        # ou "C-3PO" — décision au moment de l'écriture
  date: "2026-06-16"
  chapters:
    - index.qmd
    - 01-anatomie.qmd
    - 02-origines.qmd
    - conclusion.qmd
  appendices:
    - annexe-donnees.qmd

format:
  typst:
    extend: orange-book

execute:
  echo: false
  warning: false
  message: false
```

`extend: orange-book` **explicite** — la review technique a relevé que l'application auto pour `type: book` + `format: typst` n'est pas formellement documentée. À expliciter pour robustesse (Quarto 1.9+ blog post 2026-03-31). Pas de `keep-typ` (mode production). Pas de `papersize`/`mainfont` per-fichier (orange-book + `_brand.yml` pilotent).

### `correction/_brand.yml` (variante book avec logo)

Copie de `01-document-typst/correction/_brand.yml` + ajout (syntaxe `images:` nommée, documentée pour books — blog post Quarto 2026-03-31) :

```yaml
logo:
  images:
    sw-star:
      path: _logo-sw.svg
      alt: "Étoile jaune Star Wars"
  medium: sw-star
```

⚠️ **À vérifier au render (commit 1)** : (a) le logo apparaît bien sur la couverture orange-book, (b) la syntaxe `logo: { images: ... }` est lue par le pipeline Typst (pas seulement HTML). Si non supporté → fallback sur `_brand.yml` strict copie (sans `logo:`) + mention orale (« logo lu en HTML, pas encore en orange-book — limite actuelle »).

### `correction/_logo-sw.svg`

Étoile jaune SW minimale (SVG inline, pas de dépendance externe). ~20 lignes max. Couleur `#FFE81F`.

### `correction/index.qmd` (préface)

```yaml
---
title: "Préface"
---

# Préface {.unnumbered}
```

5 lignes prose : (1) le dataset `dplyr::starwars`, (2) le fil rouge anatomie/origines, (3) clin d'œil droïdes. **Aucune cross-ref définie ni référencée** (caveat unnumbered).

### `correction/01-anatomie.qmd` (chapitre 1, réutilise rapport Bloc 1)

YAML : `title: "Anatomie"` seul (pas d'options Typst, héritées via `_quarto.yml`).

Structure :
- `# Anatomie`
- chunk `setup` : `library(dplyr); library(ggplot2); library(ggrepel); library(gt)`
- `## Top 5 des personnages les plus massifs`
- chunk **`tbl-anatomie-mass`** (renommé depuis `tbl-mass`) : code identique à Exo 1 lignes 38-64, **avec** `opt_table_font(font = "Inter")`. Pas de `tbl-cap` (titre via `tab_header()`).
- prose punchline droïdes + raw inline `` `#highlight(fill: rgb("#FFE81F"))[droïdes]`{=typst} `` (repris d'Exo 1 lignes 66-68)
- `## Taille vs masse`
- chunk **`fig-anatomie-mass`** (renommé) : code identique à Exo 1 lignes 72-92, `fig-cap` + `fig-alt` repris.

### `correction/02-origines.qmd` (chapitre 2, NOUVEAU)

```yaml
---
title: "Origines"
---

# Origines {#sec-origines}
```

Structure :
- chunk `setup-origines` : `library(dplyr); library(ggplot2); library(gt)`
- `## D'où viennent-ils ?`
- chunk **`tbl-origines-homeworlds`** :
  ```r
  starwars |>
    filter(!is.na(homeworld)) |>
    count(homeworld, sort = TRUE) |>
    slice_head(n = 10) |>
    gt() |>
    tab_header(
      title = "Top 10 des mondes natals",
      subtitle = "Personnages par planete d'origine"
    ) |>
    cols_label(homeworld = "Planete", n = "Personnages") |>
    opt_table_font(font = "Inter")
  ```
- prose 2 lignes : Tatooine en tête (à confirmer au render), saga très centrée sur quelques planètes.
- `## Espèces dominantes`
- chunk **`fig-origines-especes`** : barplot horizontal (varie de la scatter du chap 1)
  ```r
  starwars |>
    filter(!is.na(species)) |>
    count(species, sort = TRUE) |>
    slice_head(n = 8) |>
    ggplot(aes(reorder(species, n), n)) +
    geom_col(fill = "#0B0B0F") +
    coord_flip() +
    theme_minimal(base_size = 11) +
    labs(x = NULL, y = "Personnages", title = "Top 8 des especes representees")
  ```
  `fig-cap`, `fig-alt` obligatoires (pattern `.claude/skills/quarto-alt-text.md` : type + axes + insight = barplot horizontal des 8 espèces les plus représentées ; humains majoritaires ; droïdes en n°2 — clin d'œil punchline chap 1).

### `correction/conclusion.qmd` (chapitre 3, numéroté)

```yaml
---
title: "Conclusion"
---

# Conclusion
```

Structure :
- 2 lignes punchline droïdes
- phrase avec cross-ref : « Comme l'a montré la @fig-anatomie-mass, Jabba domine la masse, mais les humains dominent en nombre dans le @sec-origines. »
- bloc bonus pagebreak conditionnel :
  ```markdown
  ::: {.content-visible when-format="typst"}
  {{< pagebreak >}}
  :::
  ```

### `correction/annexe-donnees.qmd` (appendice A)

```yaml
---
title: "Le dataset starwars"
---

# Le dataset starwars
```

5-7 lignes texte, pas de chunk R :
- 87 lignes × 14 variables, source `dplyr::starwars`
- copyright SWAPI
- colonnes utilisées : `name`, `height`, `mass`, `species`, `homeworld`
- mention NA présents (chiffres à confirmer au render — env R 4.6.0)

## Spec contenu — starter (dérivation)

Identique à correction sauf :
- **Pas** de `_quarto.yml`, `_brand.yml`, `_logo-sw.svg`
- `starter/01-anatomie.qmd` : `opt_table_font(font = "Inter")` **retiré** → bug espacement chiffres visible à l'étape 3 (moment péda explicite, mention orale formateur)
- `starter/conclusion.qmd` : phrase cross-ref **absente** (juste les 2 lignes punchline) ; bloc `.content-visible` **absent**
- Labels `tbl-anatomie-mass`, `fig-anatomie-mass`, `tbl-origines-homeworlds`, `fig-origines-especes`, ancre `#sec-origines` : **présents** dans le starter pour que le bonus cross-ref ait des cibles

## 3 étapes core (12 min) + 2 bonus (extra time)

Cadrage explicite (review pédagogique : 5 étapes en 15 min trop serré, ~50 % du public n'atteindrait pas étape 3). Reformulation : **3 étapes core obligatoires** ; **2 bonus** annoncés clairement comme « pour les rapides », pas comme étapes à faire.

**Core (12 min, attendu de tous) :**

| # | Action | Wow visuel | Concept |
|---|---|---|---|
| 1 | Crée `_quarto.yml` `type: default` + `format: typst`, render | 4 PDF séparés | config projet, format une seule fois |
| 2 | Passe à `type: book` (+ `extend: orange-book`), render | **PDF unique + couverture orange-book + Fig 1.1, Fig 2.1, Tab 1.1, Tab 2.1 + TOC** | LA fenêtre orange-book |
| 3 | Copie `_brand.yml` (+ `_logo-sw.svg`) à racine, render | Couverture jaune SW + logo, headings Orbitron, corps Inter, gt re-stylé (bug espacement apparaît si starter sans `opt_table_font`) | brand suit le projet |

**Bonus (3 min, pour les rapides) :**

| # | Action | Wow visuel | Concept |
|---|---|---|---|
| B1 | Ajoute `@fig-anatomie-mass` + `@sec-origines` dans conclusion | « Comme l'a montré la **Fig 1.1**, … » + lien actif | cross-ref inter-chapitre numérotée |
| B2 | Ajoute `.content-visible when-format="typst"` + `{{< pagebreak >}}` | Saut de page dans le PDF uniquement | contenu conditionnel multi-format |

Pic émotionnel = étape 2. Étape 3 = confirmation (le brand de Bloc 1 ressuscite). Countdown atelier reste `{{< countdown 15:00 >}}` (3 min de marge entre les 3 core et le wrap-up).

## README Exo 2 (`exercises/02-projet-book/README.md`)

Structure :
- Titre « Exercice 2 — De la page au livre »
- Pitch 1 ligne
- Pré-requis (Quarto 1.9+, packages déjà installés cf. `preparatifs.qmd`)
- **3 étapes core + 2 bonus** (tableaux ci-dessus, ton sobre — pas de « wow moment » dans le texte participant)
- Bloc « Pas de `_brand.yml` ? » → `_brand-fallback.yml`
- Bloc « Et après ? » → pointer `correction/`

## README minimal dans `starter/` (UX safety net)

`exercises/02-projet-book/starter/README.md` — 4 lignes max :

> Ce dossier ne se rend pas seul. Vous devez créer un `_quarto.yml` à sa racine pour assembler ces fichiers en un livre Quarto. Sans `_quarto.yml`, `quarto render` produit 5 PDF séparés. Voir `../README.md` pour les étapes.

Évite la confusion du participant qui render avant l'étape 1 (review pédagogique #9).

## Slides Bloc 2 — mise à jour

`2-projets/index.qmd` : remplacer le bloc Exercice (lignes 45-58) par le nouveau pattern **3 core + 2 bonus**. Garder `{{< countdown 15:00 >}}` (à ajouter si manquant).

`2-projets/2-projets.qmd` : ajuster la slide « Your turn » pour mentionner les 3 étapes core (brand explicitement à l'étape 3) et annoncer les 2 bonus comme « extra time ».

**Notes presenter à ajouter** (review pédagogique #2 + #11) :
- Slide « Our turn » Bloc 2 : « Si vous voyez des chiffres mal espacés (« 1 7 5 » au lieu de « 175 ») dans les tableaux à l'étape 3, c'est normal — bug `gt` → Typst sur fallback de fonts. Workaround `opt_table_font(font = "Inter")` montré dans la correction. »
- Slide « Your turn » Bloc 2 : « Le lien Exercice 2 sera 404 jusqu'au push final — téléchargez au moment de l'exo. »

## Plan de validation

```bash
# Render correction
cd /home/user/cderv-tuto-quarto-typst-rr-2026
quarto render exercises/02-projet-book/correction/

# Inspect
ls exercises/02-projet-book/correction/_book/
```

Checklist visuelle PDF (correction) :
- [ ] Couverture orange-book : titre, sous-titre, auteur, date, fond crème, accent jaune, **logo SVG visible**
- [ ] TOC : Préface (sans n°), 1 Anatomie, 2 Origines, 3 Conclusion, A Le dataset starwars
- [ ] Tab 1.1 « Les colosses de la galaxie » + Fig 1.1 scatter Jabba labellé
- [ ] Tab 2.1 top 10 mondes (Tatooine en haut) + Fig 2.1 barplot horizontal espèces
- [ ] Conclusion : phrase « Comme l'a montré la Fig 1.1 … » + lien actif
- [ ] Saut de page Conclusion → Annexe (PDF only ; HTML preview = pas de saut)
- [ ] Annexe A « Le dataset starwars »
- [ ] Police Orbitron (titres) + Inter (corps)
- [ ] gt sans bug espacement chiffres

Render starter brut (négatif) :
```bash
quarto render exercises/02-projet-book/starter/    # doit produire 5 PDF orphelins
```
→ confirme que `_quarto.yml` est requis pour assembler le book.

Vérification factuelle data (pendant render) :
- `homeworld` distincts ≈ 49, NA ≈ 10, Tatooine top 1
- `species` distincts ≈ 38, NA ≈ 4, Human top 1, Droid top 2

## Risques et mitigations

| Risque | Mitigation |
|---|---|
| `_brand.yml logo:` syntaxe `images:` non supportée par orange-book Typst | **Tester au commit 1** (point critique #1 review tech). Syntaxe `logo: { images: { name: { path } }, medium: name }` documentée pour books (blog 2026-03-31) mais effet sur couverture orange-book non confirmé en doc. Fallback : retirer entièrement `logo:`, mentionner en pépite notes presenter |
| `extend: orange-book` auto vs explicite | Plan choisit l'**explicite** (review tech #11) pour éviter qu'un défaut futur change le rendu. Sécurité même si auto applicable |
| Bug gt → Typst (« 1 7 5 ») | `opt_table_font("Inter")` dans correction. Bug **volontairement visible** dans starter étape 3 (moment péda). Pré-briefer en notes presenter Bloc 2 « Our turn » |
| Timing 5 étapes en 15 min trop serré | **Reframé en 3 core (12 min) + 2 bonus** dans plan + slides. Bonus annoncés comme « extra time », pas comme étapes obligatoires |
| Réseau Nantes pour `source: google` | **Pas de duplication `_fonts/`** dans Exo 2. Mention `preparatifs.qmd` : « préchargez en testant Exo 1 chez vous ». Risque résiduel acceptable (quelques centaines de KB) |
| `{.unnumbered}` casse-t-il « Fig 1.1 » sur 01-anatomie ? | Comportement Quarto book standard : non (review tech #3 confirmé). À vérifier au commit 1. Repli : retirer `{.unnumbered}` |
| Quarto < 1.9 chez participant | Mentionner « Quarto 1.9+ requis » dans README Exo 2 (déjà dans `preparatifs.qmd`) |
| Cross-refs depuis préface unnumbered | **Aucune cross-ref dans préface** — règle stricte (caveat doc) |
| Lien Exo 2 404 jusqu'au push | Note presenter Bloc 2 « Your turn » : « lien actualisé après live coding Our turn » |
| Participant render starter avant étape 1 | `starter/README.md` 4 lignes d'avertissement (UX safety net) |

## Étapes de livraison ordonnées (commits granulaires)

Tous sur la branche `claude/add-missing-content-4CdHE`.

0. **Persistance plan dans PLAN.md** — ajouter dans `.claude/PLAN.md` (section Phase 3 ou Reste à faire) une ligne :
   > Plan détaillé Exo 2 : `/root/.claude/plans/oui-p1-planifions-sp-cialement-sprightly-micali.md` (sandbox-local, à recopier dans le repo si besoin de pérennité hors session).
   
   Note : le path `/root/.claude/plans/` est local à la sandbox Claude Code on the web ; pour pérennité git, copier le plan dans le repo (ex. `.claude/plans/exo2-book.md`) lors du commit 0. Permet de récupérer le plan si la session expire avant la fin de l'exécution.

1. **Squelette correction sans contenu R** — créer `02-projet-book/correction/` avec `_quarto.yml` (`extend: orange-book` explicite), `_brand.yml` (avec `logo: { images, medium }`), `_logo-sw.svg`, 5 `.qmd` aux YAML headers + H1 corrects + textes lipsum. Render → **3 vérifs critiques** : (a) orange-book appliqué (couverture, TOC stylisé), (b) logo SW visible sur la couverture, (c) numérotation `01-anatomie` = chapitre **1** (pas 2) malgré préface unnumbered. **Si (b) échoue : retirer `logo:` du brand, mentionner en pépite.**
2. **Contenu R 01-anatomie + 02-origines** — porter le code Bloc 1 + ajouter `02-origines.qmd` (gt + barplot). Render → vérifier figures, tableaux, vérification factuelle homeworlds/species (Tatooine top, Human + Droid top espèces).
3. **Cross-refs + content-visible + annexe finale** — ajouter dans conclusion les 2 cross-refs et le bloc pagebreak ; finaliser annexe. Render → vérifier liens actifs et saut de page Typst-only.
4. **Starter dérivé + fallback brand + READMEs** — dupliquer correction → starter, retirer ce qui doit l'être (cf. spec). Créer `_brand-fallback.yml` (copie 1:1), `README.md` racine Exo 2, **et `starter/README.md`** (4 lignes safety net). Pas de render attendu.
5. **Mise à jour slides Bloc 2 (3 core + 2 bonus) + notes presenter + fix lien 404** — réécrire bloc Exercice de `2-projets/index.qmd` (3 core + 2 bonus, brand étape 3) ; ajuster `2-projets/2-projets.qmd` slide « Your turn » ; **ajouter notes presenter** sur (a) le bug gt à anticiper, (b) le lien Exo 2 actualisé après Our turn ; vérifier que le lien 404 résout. `quarto render` racine pour smoke test final.
6. **PLAN.md** — cocher les items Phase 3 réalisés, mettre à jour decision log avec choix CD du 2026-05-03 (3 core + 2 bonus, brand variant logo syntaxe `images:`, `extend: orange-book` explicite, conclusion numérotée, auteur Mon Mothma).

Push à la fin sur `claude/add-missing-content-4CdHE` (`git push -u origin claude/add-missing-content-4CdHE`). **Pas de PR** sauf demande explicite.

## Critical files

À créer :
- `exercises/02-projet-book/README.md`
- `exercises/02-projet-book/_brand-fallback.yml`
- `exercises/02-projet-book/correction/_quarto.yml`
- `exercises/02-projet-book/correction/_brand.yml`
- `exercises/02-projet-book/correction/_logo-sw.svg`
- `exercises/02-projet-book/correction/{index,01-anatomie,02-origines,conclusion,annexe-donnees}.qmd`
- `exercises/02-projet-book/starter/README.md`
- `exercises/02-projet-book/starter/{index,01-anatomie,02-origines,conclusion,annexe-donnees}.qmd`

À modifier :
- `2-projets/index.qmd` (bloc Exercice — 3 core + 2 bonus, lien 404 résout naturellement)
- `2-projets/2-projets.qmd` (slide Your turn — refléter 3 core + 2 bonus, ajouter notes presenter)
- `.claude/PLAN.md` (cocher Phase 3, ajouter decisions log 2026-05-03)

## Sources et patterns réutilisés

- `exercises/01-document-typst/correction/rapport-starwars.qmd:38-92` — code R figé à porter dans `01-anatomie.qmd`
- `exercises/01-document-typst/correction/_brand.yml` — base à étendre avec `logo:`
- `.claude/skills/workshop-content.md` — pattern README exo + 5 étapes
- `.claude/skills/quarto-alt-text.md` — formule `fig-alt` 3-parties (type + axes/données + insight)
- `.claude/skills/brand-yml.md` — syntaxe `logo:` (small/medium/large)
- `.claude/skills/quarto-authoring.md` — règles cross-refs (`@fig-`, `@tbl-`, `@sec-`)
- `.claude/PLAN.md` Phase 3 — structure book, 5 étapes participants
