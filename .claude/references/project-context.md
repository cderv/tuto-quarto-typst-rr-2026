# Project Context — RR 2026 Workshop

Read this file when working on content, slides, or project configuration.

## Technical Stack

- Quarto 1.9.36 (Typst 0.14.2, Pandoc 3.8.3)
- Slides: `clean-revealjs` extension (`grantmcdermott/quarto-revealjs-clean`)
- Theme: `reveal-style.scss` (Atkinson Hyperlegible + Source Code Pro, from RR 2023)
- Extensions: countdown (`gadenbuie/countdown`), fontawesome (`quarto-ext/fontawesome`)

## Repository Structure

```
_quarto.yml                 # Project config (website + clean-revealjs format)
reveal-style.scss           # RevealJS custom theme
index.qmd                   # Home page
preparatifs.qmd             # Setup instructions
1-quarto-typst/
  index.qmd                 # Block 1 page (iframe + exercises)
  1-quarto-typst.qmd        # Block 1 slides
2-projets/
  index.qmd                 # Block 2 page
  2-projets.qmd             # Block 2 slides
3-aller-plus-loin/
  index.qmd                 # Block 3 page
  3-aller-plus-loin.qmd     # Block 3 slides
4-ressources.qmd            # External resources
```

## Content Patterns (from RR 2023)

### Website pages (`index.qmd`)
- `format: html` + `author: ""` + `date: ""`
- Embed slides: `<iframe class="slide-deck" src="SLIDES.html" height="420" width="747">`
- Icons: `{{< fa tv >}}` for slides, `{{< fa download >}}` for downloads

### Slides (`N-name.qmd`)
- `format: clean-revealjs` (inherits from `_quarto.yml`)
- `#` = section separator, `##` = slide, never `###`
- Exercise slide: `{background-color="#FDC538"}` + `{{< countdown 05:00 >}}`
- Speaker notes: `::: notes`
- Code: `{.yaml filename="file.yml"}`, `code-line-numbers="2-3"`

### Exercises
- All use penguins (palmerpenguins), progressive complexity
- Distributed as zip files (not in this repo)

## Workshop Content by Block

### Block 1 — Quarto & PDF avec Typst (40 min)
- **Partie A (15 min):** `format: typst` vs `format: pdf`, basic options, `keep-typ: true`
- **Partie B (20 min):** `_brand.yml` (color/typography/logo), theorem-appearance, brand dictionaries, brand-mode: dark, `quarto use brand`
- **Exercise (~5 min):** Convert pdf→typst, add brand, inspect .typ

### Block 2 — Projets & Typst book (25 min)
- **Partie A (10 min):** `_quarto.yml` project config, brand at project level, conditional content
- **Partie B (15 min):** `type: book`, orange-book (auto in 1.9), Marginalia, `typst-gather`
- **Exercise (~5 min):** Create book, apply brand

### Block 3 — Aller plus loin (25 min)
- **Section 1 (5 min):** Raw Typst blocks, brand variables, CSS→Typst, styled tables
- **Section 2 (12 min):** Template partials (`typst-show.typ`, `typst-template.typ`), Pandoc syntax, heading level shift
- **Section 3 (8 min):** Extensions, sharing, PDF accessibility (ua-1)
- **Exercise (optional, ~5 min):** Add partials, modify footer

## Key Reference URLs

- Quarto Typst docs: <https://quarto.org/docs/output-formats/typst.html>
- Brand YAML docs: <https://quarto.org/docs/authoring/brand.html>
- Custom Typst formats: <https://quarto.org/docs/output-formats/typst-custom.html>
- Typst templates: <https://github.com/quarto-ext/typst-templates>
- Typst in Production: <https://typst-in-production.com>
- Mastering Quarto CLI (sessions 4-5): <https://m.canouil.dev/mastering-quarto-cli/>
- RR 2023 workshop (model): <https://github.com/cderv/tuto-quarto-rr-2023>
- RR 2025 brand.yml slides: <https://cderv.github.io/rr2025-quarto-brand-yml/>

## Prior Art

This workshop follows the same structural pattern as [RR 2023](https://github.com/cderv/tuto-quarto-rr-2023) and builds on the [RR 2025 brand.yml talk](https://cderv.github.io/rr2025-quarto-brand-yml/).
