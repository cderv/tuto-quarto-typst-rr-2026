# Refonte Your Turn — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal :** Appliquer la refonte Your Turn validée le 2026-05-19 (cf. `.claude/design-your-turn-refonte.md`) — Exo 1 d'abord en PoC, review, puis Exo 2.

**Architecture :** 4 surfaces avec rôles stricts (site / slide / page boussole / starter README), gabarit unifié 3 colonnes + collapse "💡 Indices doc", escalier autonomie 3 marches. Source unique via `{{< include >}}` README starter dans le site.

**Tech Stack :** Quarto site (`format: html`) + RevealJS slides (`format: clean-revealjs`) + countdown shortcode + brand.yml. Pas de R/JS supplémentaire — éditorial pur.

**Référence design :** `.claude/design-your-turn-refonte.md` (gabarits, rationale, hors scope, risques).

---

## File Structure

### Phase 1 (PoC Exo 1)

| Fichier | Action | Rôle |
|---|---|---|
| `exercises/01-document-typst/starter/README.md` | **Créer** | Quick-ref opérationnel, includable site |
| `exercises/01-document-typst/correction/README.md` | **Créer** | 3 lignes minimal — filet |
| `1-quarto-typst/index.qmd` | **Refactoriser** | Site exo : objectif + tableau 3 cols + collapse indices + include README |
| `1-quarto-typst/boussole.qmd` | **Créer** | Page projetée pendant les 12 min |
| `1-quarto-typst/1-quarto-typst.qmd` | **Modifier slide 223-235** | Slide "À vous !" → titre + URL boussole minimaliste |
| `.claude/plans/2026-05-19-doc-mapping.md` | **Créer** | Doc mapping étape → URL (référence pour les indices) |

### Phase 3 (Extension Exo 2)

| Fichier | Action | Rôle |
|---|---|---|
| `exercises/02-projet-book/starter/README.md` | **Refactoriser** | Aujourd'hui pointe vers `../README.md` — devient quick-ref auto-suffisant |
| `exercises/02-projet-book/correction/README.md` | **Créer** | 3 lignes minimal |
| `2-projets/index.qmd` | **Refactoriser** | Ajouter collapse "💡 Indices doc", aligner libellés, include starter README |
| `2-projets/boussole.qmd` | **Créer** | Page projetée |
| `2-projets/2-projets.qmd` | **Modifier slide 91-112** | Slide "À vous !" → titre + URL boussole minimaliste |
| `exercises/02-projet-book/README.md` | **Auditer** | Aujourd'hui duplique le contenu site — clarifier rôle (probable suppression de la duplication des étapes) |

### Phase 4 (Doc mapping + audit liens)

| Fichier | Action | Rôle |
|---|---|---|
| `.claude/plans/2026-05-19-doc-mapping.md` | **Compléter** | Toutes les étapes Exo 1 + Exo 2 finalisées |
| `scripts/audit-doc-links.sh` | **Créer** | Script `curl -sI` sur chaque URL du mapping, rapport non-2xx |

---

## Convention de "test" pour ce plan

Pas de TDD au sens code — le plan est éditorial. Chaque tâche de modification de contenu suit ce mini-cycle :

1. **Édition** : produire le contenu attendu (la "step" donne le squelette ou contenu complet).
2. **Render check** : `quarto render <fichier>` ou `quarto preview` doit passer sans erreur.
3. **Visual check** : vérifier dans le navigateur que le rendu correspond aux attentes décrites.
4. **Commit** : commit atomique nommé selon convention `feat: ...` / `refactor: ...` / `docs: ...`.

Le "fail first" se réduit ici à vérifier l'état actuel avant édition (lecture du fichier, observation du rendu actuel) — déjà fait en brainstorming et capturé dans le design.

---

## Phase 1 — PoC Exo 1

### Task 1.0: Setup branche WIP

**Files:**
- Branche git : `refonte-your-turn`

- [ ] **Step 1: Vérifier état git propre**

```bash
git status
```

Expected: tree contient `_publish.yml` modifié + `star_jedi/` et `star_jedi.zip` untracked (état d'entrée connu). Pas d'autres surprises.

- [ ] **Step 2: Créer branche WIP**

```bash
git checkout -b refonte-your-turn
```

- [ ] **Step 3: Commit séparé des artefacts pré-existants si non liés**

`star_jedi.zip` + `star_jedi/` = font extraction temp, à ne pas embarquer dans le commit refonte. Soit `.gitignore` add, soit move out. Vérifier avec Chris avant de toucher.

### Task 1.1: Doc mapping Exo 1

**Files:**
- Create: `.claude/plans/2026-05-19-doc-mapping.md`

- [ ] **Step 1: Écrire le mapping étape → docs URL**

Reprend table lignes 51-67 de `.claude/design-indices-your-turn.md`, restreinte aux concepts d'Exo 1, max 2 URLs par étape.

```markdown
# Doc mapping — Indices "💡 Indices doc" par étape

> Référence : `.claude/design-your-turn-refonte.md` § Inventaire doc → étapes.
> Règle : max 2-3 docs par étape (cf. risque "8 onglets noyé").
> Audit liens : `scripts/audit-doc-links.sh` à exécuter pré-J16.

## Exercice 1 — Document Typst stylé

| Étape | Action condensée | Doc primaire | Doc secondaire |
|---|---|---|---|
| 1 | `format: typst` + render | https://quarto.org/docs/output-formats/typst.html | — |
| 2 | Options Typst (`papersize`, `toc`, `mainfont`) | https://quarto.org/docs/output-formats/typst.html#format-options | https://quarto.org/docs/reference/formats/typst.html |
| 3 | `_brand.yml` couleurs + police Google | https://quarto.org/docs/authoring/brand.html | https://posit-dev.github.io/brand-yml/ |
| 4 | Police locale via `source: file` | https://posit-dev.github.io/brand-yml/reference/typography/ | — |
| 5 | `keep-typ: true` et exploration `.typ` | https://quarto.org/docs/output-formats/typst.html (chercher keep-typ) | — |

## Exercice 2 — Voir Task 3.1

Sera complété en Phase 3.
```

- [ ] **Step 2: Vérifier URLs (smoke check rapide, pas l'audit complet)**

```bash
for url in \
  "https://quarto.org/docs/output-formats/typst.html" \
  "https://quarto.org/docs/output-formats/typst.html#format-options" \
  "https://quarto.org/docs/reference/formats/typst.html" \
  "https://quarto.org/docs/authoring/brand.html" \
  "https://posit-dev.github.io/brand-yml/" \
  "https://posit-dev.github.io/brand-yml/reference/typography/"; do
  printf "%-90s %s\n" "$url" "$(curl -sI -o /dev/null -w "%{http_code}" "$url")"
done
```

Expected: tous 200 / 301 / 302. Si une URL renvoie 404, chercher l'équivalent canonique avant de poursuivre — sinon les indices pointeront vers du vide.

- [ ] **Step 3: Commit**

```bash
git add .claude/plans/2026-05-19-doc-mapping.md
git commit -m "docs(plan): doc mapping initial pour Exo 1 (refonte Your Turn)"
```

### Task 1.2: Créer le README starter Exo 1

**Files:**
- Create: `exercises/01-document-typst/starter/README.md`

- [ ] **Step 1: Écrire le quick-ref**

Rôle : self-contained sur Github browse **et** includable dans `1-quarto-typst/index.qmd`. Pas de redondance pédagogique avec le site — uniquement opérationnel.

```markdown
# Exercice 1 — Starter

> Quick-ref opérationnel. La consigne complète est sur le site :
> [Bloc 1 — PDF avec Typst](https://cderv.github.io/cderv-tuto-quarto-typst-rr-2026/1-quarto-typst/).

## Contenu du dossier

| Fichier | Rôle |
|---|---|
| `rapport-starwars.qmd` | **Fichier à éditer** — point de départ HTML, à transformer en PDF Typst |
| `_fonts/Starjedi.ttf` | Police locale (étape 4) |

## Rendu

Depuis ce dossier :

```bash
quarto render rapport-starwars.qmd
```

Sortie initiale : `rapport-starwars.html` (format par défaut).
Après ajout de `format: typst` : `rapport-starwars.pdf`.

## Bloqué ?

Cf. l'escalier d'autonomie sur le site (page exo) ou la
[`correction/`](../correction/) en dernier recours.
```

- [ ] **Step 2: Render check (le README n'est pas rendu seul mais doit être parsable par `{{< include >}}`)**

Le check réel intervient à Task 1.3 quand `index.qmd` l'inclut. Ici : vérifier syntaxiquement (pas de YAML frontmatter, pas de shortcodes invalides — un README pur markdown).

```bash
head -20 exercises/01-document-typst/starter/README.md
```

Expected: pas de `---` frontmatter, pas de `{{< include >}}` récursif, pas de chunk R.

- [ ] **Step 3: Commit**

```bash
git add exercises/01-document-typst/starter/README.md
git commit -m "docs(exo1): add starter README quick-ref"
```

### Task 1.3: Créer le README correction Exo 1

**Files:**
- Create: `exercises/01-document-typst/correction/README.md`

- [ ] **Step 1: Écrire les 3 lignes minimales**

```markdown
# Exercice 1 — Correction

Solution complète de l'exercice — à ouvrir en dernier recours.
Énoncé : [Bloc 1 — PDF avec Typst](https://cderv.github.io/cderv-tuto-quarto-typst-rr-2026/1-quarto-typst/).
Render : `quarto render rapport-starwars.qmd`.
```

- [ ] **Step 2: Commit**

```bash
git add exercises/01-document-typst/correction/README.md
git commit -m "docs(exo1): add correction README (3-line marker)"
```

### Task 1.4: Restructurer `1-quarto-typst/index.qmd`

**Files:**
- Modify: `1-quarto-typst/index.qmd` (toute la section "Exercice 1" lignes 42-60)

- [ ] **Step 1: Lire l'état actuel**

```bash
sed -n '40,60p' 1-quarto-typst/index.qmd
```

Expected: liste plate 1-5 dans callout-tip, callout-warning correction collapse.

- [ ] **Step 2: Réécrire la section "Exercice 1" au gabarit unifié**

Contenu complet à insérer (remplace lignes 42-60 actuelles) :

````markdown
## Exercice 1

::: callout-tip
## À vous !

🎯 **Objectif :** transformer un rapport `.qmd` HTML en PDF Typst stylé via `_brand.yml`.

**5 étapes principales (12 min) — attendues de tous :**

| # | Action | Vous devriez voir |
|---|--------|-------------------|
| 1 | Ouvrir `rapport-starwars.qmd`, ajouter `format: typst`, rendre. | PDF généré à la place du HTML, polices et marges par défaut Typst. |
| 2 | Personnaliser avec des options : `papersize`, `toc`, `mainfont`... | TOC en tête, marges/format adaptés, police corps modifiée. |
| 3 | Créer `_brand.yml` avec vos couleurs (`color:`) et une police Google sur `base:`. | Couleurs primary/secondary visibles (titres, liens), police corps Google appliquée. |
| 4 | Ajouter la police locale Star Jedi (`_fonts/Starjedi.ttf`, `source: file`) sur `headings:`. | Titres de section en lettres décoratives Star Jedi. |
| 5 | Activer `keep-typ: true`, ouvrir le `.typ` généré. | Fichier `.typ` à côté du PDF, syntaxe Typst lisible (`= titre`, `#strong[...]`, etc.). |

:::

::: {.callout-tip collapse="true"}
## 💡 Indices doc

- **Étape 1** ([`format: typst`](https://quarto.org/docs/output-formats/typst.html)) — section "Overview".
- **Étape 2** ([options Typst](https://quarto.org/docs/output-formats/typst.html#format-options)) — section "Format Options". Référence complète : [reference/formats/typst](https://quarto.org/docs/reference/formats/typst.html).
- **Étape 3** ([`_brand.yml`](https://quarto.org/docs/authoring/brand.html)) — section "Color" et "Typography" ; spec complète sur [brand-yml](https://posit-dev.github.io/brand-yml/).
- **Étape 4** ([typography → fonts](https://posit-dev.github.io/brand-yml/reference/typography/)) — chercher `source: file`.
- **Étape 5** ([`keep-typ`](https://quarto.org/docs/output-formats/typst.html)) — chercher "keep-typ" dans la page.
:::

::: {.callout-tip appearance="minimal"}
**🆘 Si vous bloquez après ~5 min sur une étape :**

1. Relisez l'objectif + le "Vous devriez voir" de l'étape.
2. Ouvrez le collapse **💡 Indices doc** ci-dessus.
3. Ouvrez `exercises/01-document-typst/correction/` (filet final).
:::

### Quick-ref starter

{{< include ../exercises/01-document-typst/starter/README.md >}}

::: {.callout-warning collapse="true"}
## Correction

{{< fa download >}} [Voir la correction](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026/tree/main/exercises/01-document-typst/correction)
:::
````

- [ ] **Step 3: Render check**

```bash
quarto render 1-quarto-typst/index.qmd
```

Expected: rendu OK, pas de warning sur l'include. Si l'include échoue (path ou shortcode), corriger avant de continuer.

- [ ] **Step 4: Visual check**

Ouvrir `_site/1-quarto-typst/index.html` dans un navigateur. Vérifier :
- Tableau 3 colonnes lisible.
- Collapse "💡 Indices doc" replié par défaut, déplié au clic, liens cliquables.
- Section "Quick-ref starter" contient le contenu du README starter (pas de balise `{{< include >}}` visible).
- Pas de doublon avec le tableau du dessus.

- [ ] **Step 5: Commit**

```bash
git add 1-quarto-typst/index.qmd
git commit -m "refactor(exo1): nouveau gabarit Your Turn (3 cols + indices + include README)"
```

### Task 1.5: Créer la page boussole Exo 1

**Files:**
- Create: `1-quarto-typst/boussole.qmd`

- [ ] **Step 1: Écrire la page**

```markdown
---
title: "🧭 Boussole — Exercice 1"
subtitle: "PDF stylé avec Typst + _brand.yml"
format: html
author: ""
date: ""
toc: false
sidebar: false
---

::: {.callout-warning appearance="simple"}
## ⏱ {{< countdown 12:00 >}}
:::

## 🎯 Objectif

Transformer un rapport `.qmd` HTML en PDF Typst stylé via `_brand.yml`.

## 📋 Étapes

1. Ajouter `format: typst` et rendre
2. Régler les options (`papersize`, `toc`, `mainfont`)
3. Créer `_brand.yml` (couleurs + police Google)
4. Ajouter Star Jedi en police locale (`source: file`)
5. Activer `keep-typ: true` et ouvrir le `.typ`

## 🆘 Si vous bloquez

1. Relire l'objectif + le "Vous devriez voir" de l'étape
2. Ouvrir le collapse **💡 Indices doc** sous le tableau
3. Ouvrir `exercises/01-document-typst/correction/`

## 📖 Consigne complète

[Page Exercice 1](index.qmd) — tableau, indices doc, correction.
```

- [ ] **Step 2: Vérifier que `sidebar: false` masque bien la sidebar projet**

`sidebar: false` côté page doit court-circuiter le sidebar global. Si ça ne marche pas, fallback : déclarer la page dans un side panel masqué via `_quarto-tuto.yml` ou ajouter `format: html: { sidebar: false }`.

- [ ] **Step 3: Render check**

```bash
quarto render 1-quarto-typst/boussole.qmd
```

Expected: rendu OK, countdown shortcode reconnu (pas de warning).

- [ ] **Step 4: Visual check projeté**

```bash
quarto preview 1-quarto-typst/boussole.qmd
```

Ouvrir l'URL servie, agrandir la fenêtre, simuler une projection (zoom navigateur 150%). Vérifier :
- Countdown lisible depuis le fond d'une salle (typo grosse).
- Sidebar absente.
- Tout tient en un écran sans scroll (sinon ajuster la taille des sections).
- Lien "Page Exercice 1" cliquable.

- [ ] **Step 5: Commit**

```bash
git add 1-quarto-typst/boussole.qmd
git commit -m "feat(exo1): page boussole projetée pendant le Your Turn"
```

### Task 1.6: Adapter la slide "À vous !" du deck Exo 1

**Files:**
- Modify: `1-quarto-typst/1-quarto-typst.qmd:223-235` (slide "Exercice 1")

- [ ] **Step 1: Réécrire la slide en mode minimaliste**

Remplace les lignes 223-235 actuelles (callout-warning avec 5 étapes + countdown) par :

````markdown
## Exercice 1 {.wide-list}

::: callout-warning
## À vous !

🎯 Transformer un `.qmd` HTML en PDF Typst stylé via `_brand.yml`.

⏱ **12 minutes** — page boussole projetée à côté.

📖 Consigne complète : [`1-quarto-typst/index.html`](index.qmd)
:::

::: notes
12 minutes. Ouvrir la page boussole `1-quarto-typst/boussole.html` dans un onglet à projeter à côté (countdown autonome). Passer dans les rangs pour aider les bloqués.

Les problèmes fréquents : oubli des guillemets sur les couleurs hex dans brand.yml, nom de police Google mal orthographié, indentation YAML, et **espacement parasite des chiffres dans le tableau gt** (bug `gt → Typst` côté Windows/macOS, workaround `gt::opt_table_font("Inter")` visible dans la correction).

**Étape 4 (Star Jedi)** : pour les participants bloqués sur la syntaxe `source: file` + `files:`, montrer rapidement le bloc dans `correction/_brand.yml` au tableau. Ne pas paniquer si certains zappent l'étape — le rendu reste correct sans (titres en police Google par défaut). C'est l'étape la plus « visuelle » de l'exo : tous les titres de section passent en lettres décoratives Star Jedi, effet immédiat.

**Cue rapide pour les participants qui finissent vite** : leur dire « ouvrez `correction/rapport-starwars.qmd` et regardez les 3 derniers blocs `tab_style()` du tableau gt — les couleurs viennent de votre `_brand.yml` via `brand_color_pluck()` ». Ancre le message de la pépite "Une charte, partout" sur du code concret.
:::
````

- [ ] **Step 2: Vérifier suppression du countdown de la slide (il vit désormais sur la boussole)**

```bash
grep -n "countdown" 1-quarto-typst/1-quarto-typst.qmd
```

Expected: 0 occurrence. Si le shortcode reste, le countdown va démarrer dans le deck quand on arrive sur la slide, et le countdown de la boussole partira en parallèle = double timer désynchronisé.

- [ ] **Step 3: Render check**

```bash
quarto render 1-quarto-typst/1-quarto-typst.qmd
```

- [ ] **Step 4: Visual check**

`quarto preview` puis ouvrir `1-quarto-typst.html`, naviguer jusqu'à la slide "Exercice 1". Vérifier :
- Texte lisible du fond de salle.
- URL visible, cliquable.
- Pas de countdown sur la slide.

- [ ] **Step 5: Commit**

```bash
git add 1-quarto-typst/1-quarto-typst.qmd
git commit -m "refactor(exo1): slide 'À vous !' minimaliste (countdown migré sur boussole)"
```

### Task 1.7: Render complet + smoke check Phase 1

**Files:** —

- [ ] **Step 1: Rendu complet du site**

```bash
quarto render
```

Expected: pas d'erreur. Site `_site/` à jour. Si l'include README starter échoue, retour Task 1.4.

- [ ] **Step 2: Smoke check des 4 surfaces Exo 1**

Ouvrir dans le navigateur :
1. `_site/1-quarto-typst/index.html` — tableau 3 cols + collapse indices + include README + escalier autonomie visibles.
2. `_site/1-quarto-typst/boussole.html` — countdown + objectif + étapes condensées + escalier + URL retour.
3. `_site/1-quarto-typst/1-quarto-typst.html` (slide deck, naviguer à la slide "Exercice 1") — titre + URL boussole + objectif court.
4. Vue github du fichier `exercises/01-document-typst/starter/README.md` (préview local : ouvrir le `.md` brut dans VSCode preview).

Aucune des 4 surfaces ne doit re-narrer la pédagogie de l'autre (= contrat de rôles tient).

- [ ] **Step 3: Commit final Phase 1**

Si tout passe, pas de commit additionnel — les commits par tâche suffisent. Sinon, commit de fix puis re-check.

---

## Phase 2 — Review checkpoint

### Task 2.1: Lancer reviewers pédagogue + débutant en parallèle

**Files:**
- Création attendue : `.claude/reviews/review-2026-05-19-pedagogue.md` + `.claude/reviews/review-2026-05-19-eleve-debutant.md`

- [ ] **Step 1: Dispatch 2 reviewers en parallèle (un seul message, 2 outils Agent)**

Prompt pédagogue :

> Tu es `workshop-reviewer-pedagogue`. Review la refonte Your Turn appliquée à l'Exercice 1 uniquement. Fichiers à lire :
> - `1-quarto-typst/index.qmd` (page exo refondue)
> - `1-quarto-typst/boussole.qmd` (page projetée)
> - `1-quarto-typst/1-quarto-typst.qmd` slide "Exercice 1" lignes ~223+ (slide minimaliste)
> - `exercises/01-document-typst/starter/README.md` (quick-ref)
> - `exercises/01-document-typst/correction/README.md`
> - Design de référence : `.claude/design-your-turn-refonte.md` (lire en entier)
>
> Critique le format pédagogique : escalier autonomie suffisant ? Tableau lisible ? Indices doc adaptés au public débutant Quarto ? Boussole projection-ready ? Risque cognitif à 50/1 ?
> Sortie : `.claude/reviews/review-2026-05-19-pedagogue.md`.

Prompt débutant :

> Tu es `workshop-reviewer-debutant`. Joue un·e participant·e niveau débutant Quarto qui review l'Exercice 1 refondu. Mêmes fichiers que le pédagogue.
> Pour chaque étape du tableau, dis honnêtement si tu sais quoi faire / où chercher / quand abandonner et ouvrir la correction. Signale les angles morts : libellé ambigu, lien doc trop générique, manque de signal "tu es au bon endroit".
> Sortie : `.claude/reviews/review-2026-05-19-eleve-debutant.md`.

- [ ] **Step 2: Lire les 2 reviews, triager les findings**

Catégoriser chaque finding : Fix / Already handled / By design / False positive / Out of scope (à reporter Exo 2 ou post-RR).

- [ ] **Step 3: Décider go / no-go avant Phase 3**

Si findings majeurs sur le gabarit (ex : "le tableau 3 cols n'est pas lisible", "l'escalier autonomie sature les débutants") → re-brainstorming partiel. Pas d'extension Exo 2 avec un PoC cassé.

Si findings mineurs (libellés, indices ajustés) → patcher dans Task 2.2 puis Phase 3.

### Task 2.2: Patcher les findings reviewers

**Files:** dépend des findings.

- [ ] **Step 1: Pour chaque finding "Fix", éditer le fichier concerné**

Patch ciblé, un commit par finding ou groupe cohérent.

- [ ] **Step 2: Render + visual check après chaque batch**

```bash
quarto render
```

- [ ] **Step 3: Commit avec référence aux findings**

```bash
git commit -m "fix(exo1): <résumé finding> (review pédagogue/débutant 2026-05-19)"
```

---

## Phase 3 — Extension Exo 2

### Task 3.1: Doc mapping Exo 2

**Files:**
- Modify: `.claude/plans/2026-05-19-doc-mapping.md`

- [ ] **Step 1: Ajouter le tableau Exo 2**

Insérer après le tableau Exo 1, en remplaçant la ligne "Sera complété en Phase 3" :

```markdown
## Exercice 2 — Projet & book

| Étape | Action condensée | Doc primaire | Doc secondaire |
|---|---|---|---|
| 1 | `_quarto.yml` avec `project.type: default` + `format: typst` | https://quarto.org/docs/projects/quarto-projects.html | https://quarto.org/docs/output-formats/typst.html |
| 2a | Passer à `type: book` + `chapters:` | https://quarto.org/docs/books/book-basics.html | https://quarto.org/docs/books/book-structure.html |
| 2b | Ajouter `appendices:` | https://quarto.org/docs/books/book-structure.html#appendices | — |
| 3 | Copier `_brand.yml` + logo + `_fonts/` à la racine | https://quarto.org/docs/authoring/brand.html | https://posit-dev.github.io/brand-yml/ |
| B1 | Cross-refs `@fig-` `@sec-` | https://quarto.org/docs/authoring/cross-references.html | — |
| B2 | Pagebreak conditionnel `content-visible` | https://quarto.org/docs/authoring/conditional.html | https://quarto.org/docs/authoring/markdown-basics.html#page-breaks |
| B3 | Variante palette via `brand: _brand-jedi.yml` | https://quarto.org/docs/authoring/brand.html | — |
| B4 | `brand.yml` R + `theme_brand_gt` / `theme_brand_ggplot2` | https://posit-dev.github.io/brand-yml/pkg/r/articles/branded-themes.html | https://posit-dev.github.io/brand-yml/pkg/r/reference/brand_color_pluck.html |
```

- [ ] **Step 2: Smoke URL check (mêmes commandes que Task 1.1 Step 2)**

- [ ] **Step 3: Commit**

```bash
git add .claude/plans/2026-05-19-doc-mapping.md
git commit -m "docs(plan): doc mapping Exo 2 (refonte Your Turn)"
```

### Task 3.2: Refactoriser le README starter Exo 2

**Files:**
- Modify: `exercises/02-projet-book/starter/README.md` (aujourd'hui pointe vers `../README.md`)

- [ ] **Step 1: Réécrire en quick-ref auto-suffisant (même format que Exo 1)**

```markdown
# Exercice 2 — Starter

> Quick-ref opérationnel. La consigne complète est sur le site :
> [Bloc 2 — Projets & book](https://cderv.github.io/cderv-tuto-quarto-typst-rr-2026/2-projets/).

## Contenu du dossier

| Fichier | Rôle |
|---|---|
| `index.qmd` | Préface du livre (à garder) |
| `01-anatomie.qmd` | Chapitre 1 (à garder) |
| `02-origines.qmd` | Chapitre 2 (à garder) |
| `conclusion.qmd` | Conclusion (à garder) |
| `annexe-donnees.qmd` | Sera basculé en annexe à l'étape 2b |
| _(pas de `_quarto.yml`)_ | **À créer à l'étape 1** |
| _(pas de `_brand.yml`)_ | **À copier à l'étape 3** |

## Rendu

Depuis ce dossier :

```bash
quarto render
```

Sortie initiale (sans `_quarto.yml`) : 5 fichiers HTML séparés.
Après les 3 étapes : un livre PDF Typst unique, brandé.

## Pas de `_brand.yml` du Bloc 1 ?

Copiez à la racine du projet :
- [`_brand-fallback.yml`](../_brand-fallback.yml) → renommer en `_brand.yml`
- [`../correction/_logo-sw.svg`](../correction/_logo-sw.svg)

## Bloqué ?

Cf. l'escalier d'autonomie sur le site (page exo) ou la
[`correction/`](../correction/) en dernier recours.
```

- [ ] **Step 2: Auditer `exercises/02-projet-book/README.md`**

Aujourd'hui ce fichier duplique les étapes du site (drift garanti). Décision attendue (cf. design § "Contrat des 4 surfaces") : **supprimer la section "3 étapes principales (12 min)" et "2 bonus" et "Bonus 3"** du `README.md` parent, ne garder que prérequis + mise en place + pointeur vers le site. La duplication étapes vit côté site (`2-projets/index.qmd`) et starter (quick-ref).

```bash
sed -n '20,160p' exercises/02-projet-book/README.md
```

Lire pour confirmer ce qu'il faut retirer. Ensuite, réécrire le README parent réduit :

```markdown
# Exercice 2 — De la page au livre

> 5 fichiers `.qmd`, un `_quarto.yml`, et le rapport Bloc 1 devient un livre
> Quarto avec couverture, TOC, numérotation automatique et charte cohérente.

## Prérequis

- Quarto 1.9+ (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- Packages R installés : `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales`
- Pour le Bonus 4 (optionnel, brand styling avancé) : `brand.yml` (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- L'extension `orange-book` (livrée avec Quarto 1.9, pas d'install à faire)

## Mise en place

Partez de [`starter/`](starter/) — voir le [README starter](starter/README.md) pour le quick-ref opérationnel.

## Consigne complète

Sur le site : [Bloc 2 — Projets & book](https://cderv.github.io/cderv-tuto-quarto-typst-rr-2026/2-projets/) — étapes, indices doc, deep dives, correction.

## Pas de `_brand.yml` récupéré du Bloc 1 ?

Pas grave. Copiez ces 2 fichiers à la racine de votre projet :

- [`_brand-fallback.yml`](_brand-fallback.yml) → renommer en `_brand.yml`
- [`correction/_logo-sw.svg`](correction/_logo-sw.svg) → copier sous le même nom

## Et après ?

Le dossier [`correction/`](correction/) contient le projet final, charte incluse,
avec les 3 étapes principales ET les 2 bonus appliqués.
```

- [ ] **Step 3: Render check (le README starter sera includé en Task 3.3)**

```bash
head -30 exercises/02-projet-book/starter/README.md
head -30 exercises/02-projet-book/README.md
```

Expected: structure parsable, pas de YAML frontmatter, pas de shortcodes invalides.

- [ ] **Step 4: Commit**

```bash
git add exercises/02-projet-book/starter/README.md exercises/02-projet-book/README.md
git commit -m "refactor(exo2): READMEs quick-ref + dédup site (refonte Your Turn)"
```

### Task 3.3: Créer le README correction Exo 2

**Files:**
- Create: `exercises/02-projet-book/correction/README.md`

- [ ] **Step 1: Écrire les 3 lignes**

```markdown
# Exercice 2 — Correction

Projet livre final — à ouvrir en dernier recours.
Énoncé : [Bloc 2 — Projets & book](https://cderv.github.io/cderv-tuto-quarto-typst-rr-2026/2-projets/).
Render : `quarto render` depuis ce dossier.
```

- [ ] **Step 2: Commit**

```bash
git add exercises/02-projet-book/correction/README.md
git commit -m "docs(exo2): add correction README (3-line marker)"
```

### Task 3.4: Restructurer `2-projets/index.qmd`

**Files:**
- Modify: `2-projets/index.qmd` (section "Exercice 2", lignes 38-230)

- [ ] **Step 1: Diff entre l'état actuel et le gabarit cible**

Différences attendues :
- Ajouter collapse "💡 Indices doc" sous le tableau étapes principales.
- Ajouter callout "🆘 Si vous bloquez" (escalier 3 marches).
- Inclure le README starter via `{{< include >}}`.
- Ne PAS dupliquer les pièges (déjà bien placés en callout-warning collapse).
- Conserver le modèle `_quarto.yml` (utile au public) et les 2 deep dives B3/B4.
- Aligner le préambule "Objectif" pour parler comme Exo 1 (🎯 + 1 phrase).

- [ ] **Step 2: Réécrire la section Exercice 2**

Remplace les lignes ~38-230 actuelles (à partir de `## Exercice 2` jusqu'à la dernière `:::` fermante du callout-warning Correction). Conserve les autres sections (Diapos, My turn, Our turn) au-dessus.

````markdown
## Exercice 2

::: {.callout-note appearance="minimal"}
L'Exercice 2 est **autonome vis-à-vis de l'Exercice 1** : si vous n'avez pas terminé le Bloc 1, partez directement du dossier `starter/`.
:::

::: callout-tip
## À vous !

🎯 **Objectif :** transformer 5 `.qmd` en un livre PDF Typst brandé via `_quarto.yml` + `_brand.yml`.

**3 étapes principales (12 min) — attendues de tous :**

| # | Action | Vous devriez voir |
|---|--------|-------------------|
| 1 | Créer `_quarto.yml` à la racine du starter avec `project: { type: default }` et `format: typst`. | 5 PDF séparés (un par fichier). |
| 2a | Passer à `type: book` et ajouter `book: { title, chapters: [...] }`. | **PDF unique** + couverture orange-book + Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1 + TOC. `annexe-donnees` apparaît comme dernier chapitre numéroté. |
| 2b | Ajouter `appendices: [annexe-donnees.qmd]` au bloc `book:`. | `annexe-donnees` bascule en « Annexe A » à la fin du livre, hors numérotation des chapitres. |
| 3 | Copier `_brand.yml` (+ `_logo-sw.svg` + `_fonts/`) à la racine. | Couverture jaune Star Wars + logo, titres Star Jedi, corps Inter, tableaux `gt` re-stylés. |

**+ 2 bonus (3 min, pour les rapides) :**

| # | Action | Vous devriez voir |
|---|--------|-------------------|
| B1 | Dans `conclusion.qmd`, référencer `@fig-anatomie-mass` et `@sec-origines`. | « Comme l'a montré la **Figure 1.1**… » avec lien actif. |
| B2 | Saut de page conditionnel à la fin de `conclusion.qmd` (bloc ci-dessous). | Saut de page entre conclusion et annexe **dans le PDF uniquement**. |

**B2 — bloc à coller en fin de `conclusion.qmd`** :

``` markdown
::: {.content-visible when-format="typst"}
{{</* pagebreak */>}}
:::
```
:::

::: {.callout-tip collapse="true"}
## 💡 Indices doc

- **Étape 1** ([projets Quarto](https://quarto.org/docs/projects/quarto-projects.html)) — section "Project Metadata".
- **Étape 2a** ([books — basics](https://quarto.org/docs/books/book-basics.html)) — structure minimale. Détails : [book structure](https://quarto.org/docs/books/book-structure.html).
- **Étape 2b** ([book structure → appendices](https://quarto.org/docs/books/book-structure.html#appendices)).
- **Étape 3** ([`_brand.yml`](https://quarto.org/docs/authoring/brand.html)) — section "Project-level brand".
- **Bonus B1** ([cross-references](https://quarto.org/docs/authoring/cross-references.html)) — sections "Figures" et "Sections".
- **Bonus B2** ([conditional content](https://quarto.org/docs/authoring/conditional.html)) — `content-visible when-format`.
:::

::: {.callout-tip appearance="minimal"}
**🆘 Si vous bloquez après ~5 min sur une étape :**

1. Relisez l'objectif + le "Vous devriez voir" de l'étape.
2. Ouvrez le collapse **💡 Indices doc** ci-dessus.
3. Ouvrez `exercises/02-projet-book/correction/` (filet final).
:::

### Quick-ref starter

{{< include ../exercises/02-projet-book/starter/README.md >}}

### Modèle `_quarto.yml` pour l'étape 2

Si vous bloquez sur la syntaxe, voici un patron complet à adapter :

``` {.yaml filename="_quarto.yml"}
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

`chapters:` reçoit les fichiers numérotés normalement. `appendices:` (parallèle à `chapters:`, pas dedans) reçoit les fichiers qui sortent du flux principal — ils deviennent A, B, C... après tous les chapitres.

::: {.callout-warning collapse="true"}
## Polices brand pas chargées (Quarto < v1.10.4)

Sur **Quarto stable `1.9.x`** ou **pre-release `1.10.0` à `1.10.3`**, les polices déclarées dans `_brand.yml` ne sont pas passées automatiquement à Typst en mode `book` (titres en serif au lieu de Star Jedi, warning `unknown font family: ...` à la compilation). Bug corrigé par [quarto-dev/quarto-cli#14517](https://github.com/quarto-dev/quarto-cli/pull/14517), fix livré à partir de la pre-release `v1.10.4`.

Si vous êtes sur une version concernée, ajoutez ce bloc dans `format.typst` de votre `_quarto.yml` :

``` yaml
format:
  typst:
    font-paths:
      - .quarto/typst/fonts   # cache des polices Google (Inter)
      - _fonts                # polices locales `source: file` (Star Jedi)
```

Sur Quarto `v1.10.4+`, ce bloc est inutile (anodin mais redondant).
:::

::: {.callout-warning collapse="true"}
## Bug `gt` à connaître (étape 3)

Si vous voyez « 1 7 5 » au lieu de « 175 » dans les tableaux après avoir copié `_brand.yml` (typique sur Windows/macOS), c'est un bug connu de `gt` → Typst quand les polices de remplacement du tableau s'appliquent. **Correction** : ajoutez `|> opt_table_font(font = "Inter")` à la fin de votre pipeline `gt`. Non bloquant — vous pouvez continuer sans.
:::

::: {.callout-warning appearance="minimal"}
Pas de `_brand.yml` ? Copiez les fichiers fournis : [`exercises/02-projet-book/_brand-fallback.yml`](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026/blob/main/exercises/02-projet-book/_brand-fallback.yml) (à renommer en `_brand.yml`) et [`exercises/02-projet-book/correction/_logo-sw.svg`](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026/blob/main/exercises/02-projet-book/correction/_logo-sw.svg).
:::

::: callout-note
**Les Bonus 3 et 4 ci-dessous sont des « deep dives »** — à explorer après l'atelier si vous manquez de temps en séance.
:::

::: {.callout-tip collapse="true"}
## Bonus 3 — Changer de palette Star Wars

La correction propose 3 variantes de `_brand.yml` clés en main : Empire / Sith (rouge), Jedi / R2-D2 (bleu), Mandalorien (crimson). Pour swapper sans renommer de fichier, ajoutez dans `_quarto.yml` :

``` yaml
brand: _brand-jedi.yml
```

Détails et explication du choix de couleur (pourquoi pas le jaune SW iconique en `primary`) dans le [README de l'exercice](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026/blob/main/exercises/02-projet-book/README.md#bonus-3--changer-de-palette-star-wars).
:::

::: {.callout-tip collapse="true"}
## Bonus 4 — Brander tableaux et graphiques avec votre `_brand.yml`

Le package R [`brand.yml`](https://posit-dev.github.io/brand-yml/pkg/r/) lit votre charte depuis R. Couplé à `gt::tab_style()` et `theme_brand_ggplot2()`, vous appliquez vos couleurs Star Wars à tous les tableaux et graphiques du livre sans dupliquer aucun hex.

**L'effet wow** : combinez ce bonus avec le Bonus 3 (swap palette). Une seule ligne YAML modifiée fait suivre les lignes 1 des tableaux, les barres du graphique espèces, et les annotations Jabba/Yoda du nuage taille-masse — la charte pilote le PDF *et* tous les outputs R depuis un seul fichier.

**Étape 1 — Setup.** Dans le chunk `setup-*` de chaque chapitre, ajoutez :

``` r
library(brand.yml)
brand <- read_brand_yml()
```

**Étape 2 — Tableaux `gt`.** Les 3 `tab_style()` ci-dessous appliquent le même pattern (couleur → emplacement) : bandeau titre, en-têtes colonnes, ligne 1. Utilisable tel quel sur les 3 tableaux du livre (`01-anatomie.qmd` + `02-origines.qmd`) :

``` r
... |>
  theme_brand_gt(brand) |>
  opt_table_font(font = "Inter") |>
  tab_style(
    style = list(
      cell_fill(color = brand_color_pluck(brand, "sw_yellow")),
      cell_text(weight = "bold",
                color  = brand_color_pluck(brand, "foreground"))
    ),
    locations = cells_title()
  ) |>
  tab_style(
    style = list(
      cell_fill(color = brand_color_pluck(brand, "foreground")),
      cell_text(color  = brand_color_pluck(brand, "background"),
                weight = "bold")
    ),
    locations = cells_column_labels()
  ) |>
  tab_style(
    style = list(
      cell_fill(color = brand_color_pluck(brand, "primary")),
      cell_text(color  = brand_color_pluck(brand, "background"),
                weight = "bold")
    ),
    locations = cells_body(rows = 1)
  )
```

**Étape 3 — Graphiques `ggplot2`.** Ajoutez `theme_brand_ggplot2(brand)` à la fin de chaque pipeline `ggplot()`. Remplacez les couleurs en dur par `brand_color_pluck(brand, "primary")` (utile pour le `geom_col` des espèces dans `02-origines.qmd`).

Pour une **légende à deux couleurs** (ex. Cas remarquables / Autres dans `01-anatomie.qmd`), le même principe s'applique via `scale_color_manual(values = c(...))` — voir la correction.

``` r
ggplot(...) +
  geom_col(fill = brand_color_pluck(brand, "primary")) +
  ... +
  theme_minimal(base_size = 11) +
  theme_brand_ggplot2(brand)
```

Vous devriez voir : bandeau titre jaune SW + en-têtes noir/crème + ligne 1 rouge impérial dans tous les tableaux, et fond crème + axes noirs sur les graphiques.

![Aperçu du tableau « Les colosses de la galaxie » dans la correction : bandeau titre jaune SW (Star Jedi) au-dessus, sous-titre jaune également, en-têtes de colonnes en noir SW sur fond crème, ligne 1 (Jabba Desilijic Tiure) sur fond rouge impérial avec texte crème en gras, lignes suivantes en crème/noir.](2-gt.png){fig-alt="Tableau gt « Les colosses de la galaxie » rendu en PDF Typst avec le styling brand : bandeau titre jaune Star Wars, en-têtes noir SW, ligne Jabba surlignée en rouge impérial."}

::: callout-note
## Piège silencieux à connaître

`brand.yml` normalise les clés palette `tiret-séparé` en `tiret_souligné` au read. Donc dans votre code R : `brand_color_pluck(brand, "sw_yellow")` (pas `"sw-yellow"`). En cas de typo, la fonction renvoie la chaîne d'entrée verbatim sans erreur — votre styling disparaît silencieusement du PDF.
:::

:::

::: {.callout-warning collapse="true"}
## Correction

{{< fa download >}} [Voir la correction](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026/tree/main/exercises/02-projet-book/correction)
:::
````

- [ ] **Step 3: Render check**

```bash
quarto render 2-projets/index.qmd
```

- [ ] **Step 4: Visual check**

Ouvrir `_site/2-projets/index.html`. Vérifier que :
- Le tableau 3 cols + le tableau bonus 3 cols sont visuellement cohérents avec Exo 1.
- Le collapse "💡 Indices doc" affiche tous les liens étape + bonus.
- L'escalier autonomie est présent.
- L'include README starter rend sans warning.
- Les deep dives B3 et B4 restent en collapse.

- [ ] **Step 5: Commit**

```bash
git add 2-projets/index.qmd
git commit -m "refactor(exo2): aligner sur gabarit unifié Your Turn (indices + escalier + include)"
```

### Task 3.5: Créer la page boussole Exo 2

**Files:**
- Create: `2-projets/boussole.qmd`

- [ ] **Step 1: Écrire la page**

```markdown
---
title: "🧭 Boussole — Exercice 2"
subtitle: "Du document au livre PDF Typst brandé"
format: html
author: ""
date: ""
toc: false
sidebar: false
---

::: {.callout-warning appearance="simple"}
## ⏱ {{< countdown 12:00 >}}
:::

## 🎯 Objectif

Transformer 5 `.qmd` en un livre PDF Typst brandé via `_quarto.yml` + `_brand.yml`.

## 📋 Étapes

1. `_quarto.yml` avec `type: default` + `format: typst`
2. Passer à `type: book` (orange-book s'active auto)
3. Copier `_brand.yml` (+ logo + `_fonts/`) à la racine

**Bonus** (pour les rapides) :

- B1. Cross-refs `@fig-anatomie-mass` + `@sec-origines`
- B2. Pagebreak conditionnel `content-visible when-format="typst"`

## 🆘 Si vous bloquez

1. Relire l'objectif + le "Vous devriez voir" de l'étape
2. Ouvrir le collapse **💡 Indices doc** sous le tableau
3. Ouvrir `exercises/02-projet-book/correction/`

## 📖 Consigne complète

[Page Exercice 2](index.qmd) — tableau, indices doc, modèle `_quarto.yml`, deep dives B3/B4, correction.
```

- [ ] **Step 2: Render check**

```bash
quarto render 2-projets/boussole.qmd
```

- [ ] **Step 3: Visual check projeté (même protocole que Task 1.5 Step 4)**

- [ ] **Step 4: Commit**

```bash
git add 2-projets/boussole.qmd
git commit -m "feat(exo2): page boussole projetée pendant le Your Turn"
```

### Task 3.6: Adapter la slide "À vous !" du deck Exo 2

**Files:**
- Modify: `2-projets/2-projets.qmd:91-112` (slide "Exercice 2")

- [ ] **Step 1: Réécrire la slide en mode minimaliste**

Remplace les lignes 91-112 actuelles par :

````markdown
## Exercice 2 {.wide-list}

::: callout-warning
## À vous !

🎯 Transformer 5 `.qmd` en livre PDF Typst brandé.

⏱ **12 minutes** — page boussole projetée à côté.

📖 Consigne complète : [`2-projets/index.html`](index.qmd)

> Pas de `_brand.yml` ? `_brand-fallback.yml` + `_logo-sw.svg` dispo dans le dossier exo.
:::

::: notes
15 minutes total : 12 min sur les 3 core + 3 min de bonus pour les rapides. Ouvrir la page boussole `2-projets/boussole.html` dans un onglet à projeter à côté.

Le fallback `_brand-fallback.yml` (+ `correction/_logo-sw.svg`) est important : ceux qui n'ont pas fini Bloc 1 peuvent les copier. Passer dans les rangs, repérer ceux qui peinent à l'étape 1 — souvent un underscore manquant.

Pour ceux qui finissent vite : pousser le bonus B1 (références croisées) en premier — c'est le plus visuel et ça utilise les labels qui sont déjà dans le starter (`tbl-anatomie-mass`, `fig-anatomie-mass`, `#sec-origines`). Le bonus B2 (pagebreak) demande de connaître la syntaxe `.content-visible` — l'avoir montrée à la fin de Our turn aide.
:::
````

- [ ] **Step 2: Vérifier suppression du countdown de la slide**

```bash
grep -n "countdown" 2-projets/2-projets.qmd
```

Expected: 0 occurrence.

- [ ] **Step 3: Render check**

```bash
quarto render 2-projets/2-projets.qmd
```

- [ ] **Step 4: Visual check (slide "Exercice 2" dans le deck rendu)**

- [ ] **Step 5: Commit**

```bash
git add 2-projets/2-projets.qmd
git commit -m "refactor(exo2): slide 'À vous !' minimaliste (countdown migré sur boussole)"
```

### Task 3.7: Render complet + smoke check Phase 3

**Files:** —

- [ ] **Step 1: Rendu complet**

```bash
quarto render
```

Expected: pas d'erreur. Les 2 nouvelles pages `boussole.qmd` apparaissent dans `_site/`.

- [ ] **Step 2: Vérifier que les 2 boussoles n'apparaissent PAS dans la sidebar projet**

Ouvrir `_site/index.html`. Sidebar doit lister uniquement Accueil / Préparatifs / Bloc 1 / Bloc 2 / Pour aller plus loin / Ressources — **pas** "Boussole Exercice 1" / "Boussole Exercice 2".

Si elles apparaissent, ajouter à `_quarto-tuto.yml` (ou via attribut page) `sidebar: false` sur le YAML de chaque boussole, OU les exclure explicitement de la liste `sidebar.contents`.

- [ ] **Step 3: Smoke check Exo 2 (mêmes 4 surfaces que Task 1.7 Step 2)**

---

## Phase 4 — Audit liens cassés

### Task 4.1: Script audit doc links

**Files:**
- Create: `scripts/audit-doc-links.sh`

- [ ] **Step 1: Écrire le script**

```bash
#!/usr/bin/env bash
# Audit les URLs documentation référencées dans les indices doc.
# Usage: scripts/audit-doc-links.sh
# Sortie: tableau URL → status HTTP. Exit 1 si une URL non-2xx.

set -euo pipefail

# Source: extraire toutes les URLs https://...  des pages exo + du doc mapping.
URLS=$(grep -hoE 'https?://[A-Za-z0-9./_#?=&-]+' \
  1-quarto-typst/index.qmd \
  2-projets/index.qmd \
  .claude/plans/2026-05-19-doc-mapping.md \
  | grep -E '(quarto\.org|posit-dev\.github\.io|tidyverse\.org|rstudio\.com)' \
  | sort -u)

FAIL=0
printf "%-90s %s\n" "URL" "HTTP"
for url in $URLS; do
  # HEAD d'abord; certains hôtes (AUR, github raw) répondent 405 → fallback GET.
  code=$(curl -sI -o /dev/null -w "%{http_code}" "$url" || echo "ERR")
  if [[ "$code" == "405" || "$code" == "000" || "$code" == "ERR" ]]; then
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url" || echo "ERR")
  fi
  printf "%-90s %s\n" "$url" "$code"
  if [[ ! "$code" =~ ^(2|3) ]]; then
    FAIL=1
  fi
done

if [[ $FAIL -eq 1 ]]; then
  echo
  echo "⚠ Au moins une URL est non-2xx/3xx. Patcher avant le J16."
  exit 1
fi
```

- [ ] **Step 2: Rendre exécutable + lancer**

```bash
chmod +x scripts/audit-doc-links.sh
scripts/audit-doc-links.sh
```

Expected: toutes URLs 200/301/302. Si non-2xx, patcher l'URL dans le fichier source (mapping + page exo concernée) et re-lancer.

- [ ] **Step 3: Commit**

```bash
git add scripts/audit-doc-links.sh
git commit -m "feat(scripts): audit-doc-links.sh pour valider URLs indices doc"
```

### Task 4.2: Patcher liens cassés (s'il y en a)

**Files:** dépend du rapport.

- [ ] **Step 1: Pour chaque URL non-2xx, chercher l'URL canonique récente**

Soit via `curl -sI <url>` (suivre les redirects), soit en explorant manuellement le site doc.

- [ ] **Step 2: Patcher dans tous les fichiers qui référencent l'URL**

```bash
grep -rn "<old-url>" 1-quarto-typst/ 2-projets/ .claude/plans/
# Édite chaque fichier remonté
```

- [ ] **Step 3: Re-lancer le script**

```bash
scripts/audit-doc-links.sh
```

Expected: exit 0.

- [ ] **Step 4: Commit**

```bash
git commit -m "fix(docs): URLs indices doc cassées (audit pré-J16)"
```

---

## Phase 5 — PR & handoff

### Task 5.1: PR draft

**Files:** —

- [ ] **Step 1: Vérifier l'historique**

```bash
git log main..refonte-your-turn --oneline
```

Expected: ~15-20 commits cohérents (un par tâche). Pas de WIP, pas de "fix typo" parasites — squash si besoin.

- [ ] **Step 2: Push branche**

```bash
git push -u origin refonte-your-turn
```

- [ ] **Step 3: STOP — Chris review diff localement avant PR**

```bash
git diff main..refonte-your-turn --stat
```

Communiquer à Chris : "Branche `refonte-your-turn` pushée, diff stat ci-dessus. Prêt pour PR quand tu veux."

Ne pas créer la PR automatiquement.

---

## Self-review checklist (à exécuter avant handoff)

- [ ] **Spec coverage** : chaque décision du design (`.claude/design-your-turn-refonte.md` § "Décisions tranchées en brainstorming") a au moins une tâche associée. Vérifier ligne par ligne.
- [ ] **Placeholder scan** : aucun "TBD" / "TODO" / "à compléter" dans le plan (sauf rétro-références volontaires aux outputs de review en Task 2.2).
- [ ] **Surface contract** : pour chaque artifact, vérifier qu'il ne re-narre pas la pédagogie d'une autre surface (site fait pédagogie, slide fait ancre, boussole fait projection, README fait quick-ref opérationnel).
- [ ] **Include cohérence** : `{{< include >}}` path relatif à `index.qmd` qui inclut (Task 1.4 et Task 3.4) — vérifier `../exercises/.../starter/README.md` depuis `1-quarto-typst/` et `2-projets/`.
- [ ] **URL cohérence** : toutes les URLs de la forme `cderv.github.io/cderv-tuto-quarto-typst-rr-2026` pointent bien vers l'URL réelle du site déployé.

---

## Hors scope de ce plan (rappel design)

- Captures d'écran "résultat attendu" par étape pivot (post-2026)
- Sous-correction par étape (`correction/etape-N.qmd`)
- Page Exercices centralisée
- Slack/chat live de salle

Le test à blanc timing chronométré (cf. design § "Ordre d'impl" point 6) est **hors plan** — Chris le fait sur cobaye humain (Maëlle ou autre) hors de cette session d'implémentation. Le format `audit-doc-links.sh` reste le seul contrôle automatique.
