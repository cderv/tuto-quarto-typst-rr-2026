---
name: workshop-content
description: >
  Create workshop content (slides, website pages, exercises) for the Quarto+Typst
  RR 2026 workshop. Use when creating RevealJS slides, section index pages, or
  exercise files following the established patterns from RR 2023.
---

# Workshop Content Creator — RR 2026

Create content for the "PDF sans frictions : Typst dans vos projets Quarto" workshop
following the established patterns from RR 2023.

## Workshop Context

- **Event:** Rencontres R 2026, 16 juin 2026, Nantes Université
- **Duration:** 2h (1h30 de contenu effectif + Q&A) — programme : Bloc 1 ~40 min + pause 10 min + Bloc 2 ~40 min
- **Language:** French (vouvoiement uniforme côté participant)
- **Instructors:** Christophe Dervieux (Posit) & Maëlle Salmon (rOpenSci, Cynkra)
- **Story arc:** `.qmd` → PDF professionnel → livre → personnalisé/pérennisé
- **Dataset:** Star Wars (`dplyr::starwars`) throughout all exercises. Tables produced with `gt`.
- **Quarto version:** 1.9+ (Typst 0.14.2, Pandoc 3.8.3)

## Directory Conventions

Each bloc follows this pattern:
```
N-name/
  index.qmd          # Website page (embeds slides + exercise links)
  N-name.qmd         # RevealJS slides
  images/             # Slide images/screenshots (if needed)
```

Exercises live in `exercises/0X-name/{starter,correction}/`. Le `_quarto.yml`
racine exclut `!exercises/` du render website mais garde `exercises/**`
comme `resources:` — téléchargeables via `tree/main/exercises/0X-…/`. Pas
de `.zip` distribué. Un mini-test pré-tutoriel autonome
(`exercises/00-test-install/test-install.qmd`) est référencé dans
`preparatifs.qmd` pour valider la chaîne Typst end-to-end avant le jour J.

## Website Section Page (`index.qmd`) Template

```markdown
---
title: "Section Title"
author: ""
date: ""
format: html
---

## Diapos

{{< fa tv >}} [Ouvrir les diapos en plein écran](SLIDES-FILENAME.html)

` ` `{=html}
<iframe class="slide-deck" src="SLIDES-FILENAME.html" height="420" width="747" style="border: 1px solid #123233;"></iframe>
` ` `

## Exercices

- <a href="LINK">{{< fa download >}} `filename`</a>

## Correction

- <a href="LINK">{{< fa download >}} `correction-filename`</a>
```

**Rules:**
- Set `author: ""` and `date: ""` to suppress those fields on the website page
- Use `{{< fa tv >}}` icon before slide link, `{{< fa download >}}` before download links
- Embed slides as iframe with consistent dimensions (height="420" width="747")
- List each exercise file as a separate download link
- Corrections go in a separate section

## RevealJS Slide File Template

```yaml
---
title: "Slide Deck Title"
subtitle: "PDF sans frictions : Typst dans vos projets Quarto"
institute: "Posit / rOpenSci"
author: "Christophe Dervieux & Maëlle Salmon"
date: "2026-06-16"
format: clean-revealjs
editor: visual
---
```

### Slide Structure Rules

1. **Level 1 headings (`#`)** create section separators (title slides between groups of slides)
2. **Level 2 headings (`##`)** create individual slides
3. **Never use level 3+ headings** for slides — use bold text or styled divs instead

### Slide Formatting Patterns

**Two-column layout:**
```markdown
::: columns
::: {.column width="50%"}
Left content
:::
::: {.column width="50%"}
Right content
:::
:::
```

**Tabset for IDE alternatives (RStudio vs CLI vs Positron):**
```markdown
::: panel-tabset
## RStudio IDE
Content for RStudio
## Quarto CLI
Content for CLI
## Positron
Content for Positron
:::
```

**Code with filename annotation:**
````markdown
```{.yaml filename="_quarto.yml"}
format:
  typst: default
```
````

**Code with line highlighting:**
````markdown
```{.yaml code-line-numbers="2-3"}
format:
  typst:
    keep-typ: true
```
````

**Incremental reveals:**
```markdown
::: incremental
- First point
- Second point
- Third point
:::
```

**Fragment animations:**
```markdown
::: {.fragment .fade-in}
Content that fades in
:::

::: {.fragment .fade-in-then-semi-out}
Content that fades in, then dims
:::
```

**Auto-animate for progressive builds:**
```markdown
## Slide title {auto-animate="true"}
Content v1

## Slide title {auto-animate="true"}
Content v1
Content v2 (added)
```

**Mode markers (cf. `.claude/CLAUDE.md`)** :

- **My turn** : slides H2 normales, pas de callout spécial
- **Our turn** : slide `{background-color="#27ae60"}` + `::: {.callout-tip}` + titre `# Faisons ensemble !`
- **Your turn** : slide `{background-color="#FDC538"}` + `::: callout` (default) + titre `# À vous !` + `{{< countdown 15:00 >}}`
- **Pépites** : `::: {.callout-note}` + titre `# Saviez-vous que...`

**Countdown timer pour exercises (extension [countdown](https://github.com/gadenbuie/countdown), pas le package R)** :
```markdown
{{< countdown 15:00 >}}
```
Install : `quarto add gadenbuie/countdown`. Convention atelier RR 2026 : `15:00` pour Your turn (Exo 1 et Exo 2).

**Speaker notes:**
```markdown
::: notes
Notes visible only to the presenter.
:::
```

**Slide modifiers:**
- `{.smaller}` — smaller text
- `{.scrollable}` — scrollable content
- `{.center}` — vertically centered
- `{visibility="hidden"}` — hidden slide (backup)

**Images with alt text (always provide fig-alt):**
```markdown
![Caption text](images/filename.png){fig-alt="Description for accessibility"}
```

### Content Writing Style

- **French throughout** — natural, pedagogical tone
- Keep slides concise: max 5-7 bullet points per slide
- Use live demos over screenshots when possible
- Show the "before" (problem) then "after" (solution) pattern
- For YAML options: show the YAML block, then explain what it does
- For Typst output: show a screenshot of the rendered PDF when available
- Use `aside` for attribution or source references:
  ```markdown
  ::: aside
  Source: [quarto.org](https://quarto.org)
  :::
  ```

### Exercise Slide Pattern

When introducing an exercise in the slides:

```markdown
## Exercice {background-color="#FDC538"}

::: callout
# À vous !

1. Step one
2. Step two
3. Step three
:::

{{< countdown 15:00 >}}
```

### Page de bloc — section « À la fin de ce bloc, vous saurez »

En miroir de la slide A du wrap-up, ouvrir chaque page `index.qmd` de
bloc avec une section **« À la fin de ce bloc, vous saurez (~N min) »**
(verbes infinitifs, perspective apprenant), pas « Concepts clés » :

```markdown
### À la fin de ce bloc, vous saurez (~7 min)

- Produire un PDF pro avec `format: typst` — alternative à LaTeX…
- Régler les options essentielles : `papersize`, `margin`, `mainfont`…
- Inspecter le pipeline `.qmd` → `.typ` → `.pdf` via `keep-typ: true`
- Personnaliser couleurs, polices et logo via un seul fichier `_brand.yml`
```

### Wrap-up de fin de tutoriel (Bloc 2 only)

Le slide deck du dernier bloc se termine sur **3 slides My turn
terminales** (cf. `2-projets/2-projets.qmd:122-138`) — position absolue
qui survit même si la pépite « Saviez-vous que… » saute pour timing :

1. `## Ce que vous savez faire maintenant` — `::: incremental` 4 bullets
   miroir des objectifs « À la fin de ce bloc » des 2 blocs
2. `## Et maintenant ?` — 3 bullets statiques : « Cette semaine » /
   « Pour creuser » (lien `4-ressources.qmd`) / « Communauté »
3. `## Merci ! Questions ?` — signatures `**CD**` + `**Maëlle**` sur 2
   lignes ; notes presenter avec 2 questions stock pré-préparées pour
   relancer si silence

## Exercise File Conventions

- Exercise files use the Star Wars dataset (`dplyr::starwars`)
- Tables produced with `gt` (CSS → Typst native translation showcased)
- R code is **frozen** dans les starters (chunks invisible via `echo:
  false`) ; participants éditent YAML, `_brand.yml`, raw Typst,
  structure projet. **Exceptions** : (a) `echo: true` sur le chunk
  démo `theme_brand_*()` (pépite Bloc 1 mention orale), (b) les
  helpers `library(brand.yml) + read_brand_yml() + theme_brand_gt() +
  theme_brand_ggplot2()` sont *présents* dans la correction Exo 1
  (non dans le starter — promesse README étape 4 : « pour propager la
  charte aux figures ggplot et tableaux gt, voir correction »)
- Progressive : Exo 2 réutilise/promeut le `_brand.yml` + logo SW
  d'Exo 1 au niveau projet ; `_brand-starter.yml` à la racine d'Exo 2
  pour ceux n'ayant pas fini Exo 1
- Base file Bloc 1 : `rapport-starwars.qmd` (1-2 pages, gt + scatter
  ggplot Jabba labellé). Logo SW (`_logo-sw.svg`) en filigrane
  couverture côté correction
- Exercise instructions dans `README.md` racine de chaque exo (3
  étapes core + 2 bonus pour Exo 2). Corrections = versions
  complètes rendables

## Content Topics by Bloc (état au 2026-05-04)

### Bloc 1 — Un PDF pro en quelques minutes (~40 min)
- **My turn** (~7 min) : intro rythme, `format: typst`, options
  essentielles, `keep-typ: true`, `_brand.yml` — 5 slides
- **Our turn** (~10 min) : démo live add typst / options / brand /
  keep-typ — 1 callout slide
- **Your turn** (~15 min) : Exo 1 (`exercises/01-document-typst/`) — 1
  exercise slide
- **Pépites** (~3 min) : raw Typst (`#highlight()`), CSS→Typst,
  `pdf-standard: ua-1` — 1 note slide

### Bloc 2 — Passer à l'échelle : projet et livre (~40 min)
- **My turn** (~5 min) : `_quarto.yml`, `type: book` + auto-activation
  orange-book — 2 slides
- **Our turn** (~10 min) : démo live create book / apply brand /
  `.content-visible` — 1 callout slide
- **Your turn** (~15 min) : Exo 2 (`exercises/02-projet-book/`, 3 core
  + 2 bonus) — 1 exercise slide
- **Pépites** (~3 min) : template partials (`typst-show.typ` seul
  côté orange-book), extensions, formats communauté — 1 note slide
- **Wrap-up** (~3 min) : 3 slides terminales (cf. ci-dessus)

### Bloc 3 « Aller plus loin » — réduit à un topic store
- Slide deck `3-aller-plus-loin/3-aller-plus-loin.qmd` **supprimé**
  2026-05-04 (claim h1→h2 faux)
- Page web `3-aller-plus-loin/index.qmd` conservée comme topic store
  (résumé « Points couverts »), pas dans la navbar du tutoriel
- Hors programme — non bloquant pour le 16 juin
