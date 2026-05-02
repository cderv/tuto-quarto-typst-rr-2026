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
index.qmd                   # Home page (programme 2 blocs)
preparatifs.qmd             # Setup instructions
1-quarto-typst/
  index.qmd                 # Block 1 page (iframe + exercises)
  1-quarto-typst.qmd        # Block 1 slides (8 slides)
2-projets/
  index.qmd                 # Block 2 page
  2-projets.qmd             # Block 2 slides (5 slides)
3-aller-plus-loin/          # ARCHIVED — content disseminated into Blocs 1 & 2
  index.qmd                 # No longer in navigation
  3-aller-plus-loin.qmd     # Kept as reference
4-ressources.qmd            # Resources (enriched with STORE topics + ex-Bloc 3)
```

## Content Patterns

### Website pages (`index.qmd`)
- `format: html` + `author: ""` + `date: ""`
- Embed slides: `<iframe class="slide-deck" src="SLIDES.html" height="420" width="747">`
- Icons: `{{< fa tv >}}` for slides, `{{< fa download >}}` for downloads

### Slides (`N-name.qmd`)
- `format: clean-revealjs` (inherits from `_quarto.yml`)
- `#` = section separator, `##` = slide, never `###`
- Speaker notes: `::: notes`
- Code: `{.yaml filename="file.yml"}`, `code-line-numbers="2-3"`

### Mode markers (callouts)
- **Our turn:** `.callout-tip` + `{background-color="#27ae60"}`
- **Your turn:** `callout` (default) + `{background-color="#FDC538"}` + `{{< countdown 15:00 >}}`
- **Pépites:** `.callout-note` with "Saviez-vous que..."

### Exercises
- All use Star Wars (`dplyr::starwars`), progressive complexity. Tables: `gt` everywhere.
- Distributed as zip files (not in this repo)
- Exercise 2 includes fallback `_brand.yml` for participants who didn't finish Exercise 1

## Workshop Content by Block

### Block 1 — Un PDF pro en quelques minutes (~40 min)
- **My turn (~7 min):** intro rythme, format:typst, options essentielles, keep-typ:true, _brand.yml — 5 slides
- **Our turn (~10 min):** add format:typst, options, create brand, keep-typ — 1 callout slide
- **Your turn (~15 min):** Exercise 1 (convert to typst, create brand, keep-typ) — 1 exercise slide
- **Pépites (~3 min):** raw Typst, CSS→Typst, pdf-standard:ua-1 — 1 note slide

### Block 2 — Passer à l'échelle : projet et livre (~40 min)
- **My turn (~5 min):** _quarto.yml, type:book + orange-book — 2 slides
- **Our turn (~10 min):** create book, apply brand, content-visible — 1 callout slide
- **Your turn (~15 min):** Exercise 2 (create book, apply brand) — 1 exercise slide
- **Pépites (~3 min):** template partials, extensions, community formats — 1 note slide

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
