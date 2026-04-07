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
- **Duration:** 2h (1h40 effective content)
- **Language:** French
- **Instructors:** Christophe Dervieux (Posit) & Maëlle Salmon (ROpenSci, Cynkra)
- **Story arc:** `.qmd` → PDF professionnel → livre → personnalisé/pérennisé
- **Dataset:** penguins (palmerpenguins) throughout all exercises
- **Quarto version:** 1.9+ (Typst 0.14.2, Pandoc 3.8.3)

## Directory Conventions

Each bloc follows this pattern:
```
N-name/
  index.qmd          # Website page (embeds slides + exercise links)
  N-name.qmd         # RevealJS slides
  images/             # Slide images/screenshots (if needed)
```

Exercise and correction files are distributed separately as zip archives.

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
institute: "Posit / ROpenSci"
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

**Callout for live demo or exercise:**
```markdown
::: callout
# Faisons ensemble !
Description of the live demo or exercise.
:::
```

**Countdown timer for exercises (using [countdown Quarto extension](https://github.com/gadenbuie/countdown)):**
```markdown
{{< countdown 05:00 >}}
```
Install with: `quarto add gadenbuie/countdown`

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

{{< countdown 05:00 >}}
```

## Exercise File Conventions

- Exercise files use the penguins dataset (palmerpenguins)
- Progressive complexity: each exercise builds on the previous one
- Base file: `rapport-penguins.qmd` — a simple report with penguin data analysis
- Exercise instructions as comments in the YAML or as callout blocks
- Corrections are complete, working versions of the exercises

## Content Topics by Bloc

### Bloc 1 — Quarto & PDF avec Typst (40 min)
- Partie A (15 min): `format: typst` vs `format: pdf`, basic options, `keep-typ: true`
- Partie B (20 min): `_brand.yml` structure, logo, theorem-appearance, brand dictionaries
- Exercise (~5 min): Convert pdf→typst, add brand, inspect .typ file

### Bloc 2 — Projets Quarto & Typst book (25 min)
- Partie A (10 min): Project-level config, conditional content
- Partie B (15 min): `type: book`, orange-book, Marginalia, typst-gather
- Exercise (~5 min): Create book project, apply brand

### Bloc 3 — Aller plus loin avec Typst (25 min)
- Section 1 (5 min): Raw Typst blocks, CSS→Typst translation, beautiful tables
- Section 2 (12 min): Template partials, Pandoc syntax, new 1.9 variables
- Section 3 (8 min): Extensions, sharing, PDF accessibility
- Exercise (optional, ~5 min): Add template partials, modify footer
