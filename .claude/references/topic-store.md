# Topic Store — Quarto+Typst Workshop RR 2026

All topics from the current slide decks, triaged by priority for a 2h hands-on workshop.
Priority reflects the "My turn / Our turn / Your turn" format where slides are short,
live demos carry the teaching, and exercises dominate.

## Priority Levels

- **CORE** — Must be in the live session (slides + demo + exercise)
- **DEMO** — Worth showing live but no dedicated exercise (Our turn only)
- **MENTION** — One slide or verbal mention, link to resources page
- **STORE** — Cut from live session, keep on resources page or appendix slides

---

## Bloc 1 — Du `.qmd` au PDF avec Typst

### Framing (updated)

NOT "LaTeX bad, switch to Typst." Instead: "You have a Quarto doc, you want a PDF version.
`format: typst` gets you there — no install, fast, professional."

### CORE — In slides + demo + exercise

| Topic | What to show | Notes |
|-------|-------------|-------|
| `format: typst` | Add it to an existing .qmd, render, get PDF | The entry point. One YAML line. |
| Basic options: `papersize`, `margin`, `mainfont` | Quick YAML tweaks in the demo | Keep it to 3-4 options, not all 9 |
| `keep-typ: true` | Show what Quarto generates under the hood | Key "aha" moment — demystifies the pipeline |
| `_brand.yml` basics | Create a minimal brand (2 colors + 1 font), render | The payoff: professional PDF from minimal config |
| `_brand.yml` auto-application | Change brand, all docs change | Show in demo, no dedicated slide needed |

**Exercise 1:** Open `rapport-penguins.qmd` (HTML doc). Add `format: typst`, render PDF.
Create a `_brand.yml` with colors and font. Enable `keep-typ: true`, inspect the `.typ`.

### DEMO — Show live, no dedicated exercise

| Topic | Notes |
|-------|-------|
| `toc: true`, `number-sections: true` | Quick YAML addition during demo |
| `linestretch` | One line in demo |
| Quarto 1.9 options: `linkcolor`, `codefont` | Mention during demo, don't enumerate all |

### MENTION — One slide or verbal

| Topic | Notes |
|-------|-------|
| Compilation pipeline (.qmd → .typ → .pdf) | One diagram slide, explains keep-typ |
| `font-paths` for bundling fonts | "If you need portable fonts, there's `font-paths`" |
| `mathfont` | Niche, just mention it exists |

### STORE — Cut from live, keep as reference

| Topic | Why cut |
|-------|---------|
| LaTeX pain points (5-bullet slide) | New framing doesn't need "LaTeX is bad" pitch |
| Typst version note (0.14.2) | Implementation detail |
| Full options recap table | Reference material, not teaching |
| `theorem-appearance` (4 styles) | Cool but not essential for the exercise |
| Brand dictionaries (`brand-color`, `brand-logo-images`) in Typst | Advanced, needs raw Typst knowledge |
| `brand-mode: dark` | Novelty feature, not core workflow |
| `quarto use brand` from GitHub | Team workflow, not individual learning |
| `logo` placement options (width, location, padding, alt) | Detail overload for a 10-min slide block |
| Full `_brand.yml` recap table | Reference material |

---

## Bloc 2 — Projets Quarto & Typst book

### CORE — In slides + demo + exercise

| Topic | What to show | Notes |
|-------|-------------|-------|
| `_quarto.yml` as project config | Create one, set `format: typst` project-wide | Foundation for the book exercise |
| `_brand.yml` at project level | Move brand to root, affects all docs | Quick demo, reuses Bloc 1 brand |
| `type: book` + chapter list | Create a book project, render | The main deliverable of this bloc |
| orange-book auto-activation | Render book, see the result | Wow moment — zero config professional book |

**Exercise 2:** Take the Bloc 1 document, restructure into a 2-3 chapter book project.
Add `_quarto.yml` with `type: book` and `format: typst`. Render. Apply brand.

### DEMO — Show live, no dedicated exercise

| Topic | Notes |
|-------|-------|
| Cross-references between chapters | Quick mention during book demo |
| Chapter-prefixed numbering (Fig 2.1) | Visible in the rendered output |
| Conditional content (`.content-visible`) | Show one example: pagebreak in PDF only |

### MENTION — One slide or verbal

| Topic | Notes |
|-------|-------|
| `_brand.yml` + book = branded cover page | Visible in demo output, point it out |
| Per-file YAML override | "You can still override per file" |

### STORE — Cut from live, keep as reference

| Topic | Why cut |
|-------|---------|
| Marginalia format | Different format entirely, confuses the book narrative |
| `typst-gather` for offline | Operational concern, not learning |
| Detailed conditional content syntax | One example in demo is enough |
| Bloc 2 recap table | Reference material |

---

## Bloc 3 — Aller plus loin

This bloc is the most at risk for time. In the hands-on format, it becomes a
"taste of what's possible" rather than a deep dive. The exercise is optional.

### CORE — In slides + demo

| Topic | What to show | Notes |
|-------|-------------|-------|
| Raw Typst blocks (`{=typst}`) | One example: custom element Quarto can't do | The escape hatch concept |
| Template partials concept | What `typst-show.typ` and `typst-template.typ` do | Understanding, not memorizing syntax |
| Declaring `template-partials:` in YAML | Add partials, render | The "how" |

**Exercise 3 (optional):** Copy provided partials, declare them, modify the footer.

### DEMO — Show live, no dedicated exercise

| Topic | Notes |
|-------|-------|
| One partial modification (e.g. footer) | Live edit of `typst-template.typ` |
| Heading level offset (+1) | Mention while editing partial — common gotcha |
| `quarto create extension format:typst` | Show the scaffold, explain purpose |

### MENTION — One slide or verbal

| Topic | Notes |
|-------|-------|
| CSS→Typst translation | "Quarto translates CSS to Typst automatically" |
| `gt` tables render in PDF | "Your styled tables just work" |
| `pdf-standard: ua-1` | "One YAML line for accessible PDF" |
| Community extensions gallery | Link to quarto-ext/typst-templates |

### STORE — Cut from live, keep as reference

| Topic | Why cut |
|-------|---------|
| Accessing brand variables from raw Typst | Needs raw Typst + brand knowledge |
| Full Pandoc template syntax table | Reference, not teaching |
| New Quarto 1.9 variables in partials | Detail for extension authors |
| `quarto use brand` (repeated from Bloc 1) | Already stored |
| `quarto add` for community templates | Can be on resources page |
| Detailed `typst-show.typ` code walkthrough | Too deep for 10 min |
| Detailed `typst-template.typ` code walkthrough | Too deep for 10 min |

---

## Proposed Time Budget (110 min effective)

| Time | Phase | Mode | Topics |
|------|-------|------|--------|
| 0-5 | Welcome, setup check | My turn | — |
| 5-15 | Bloc 1 slides: format typst, basic options, pipeline | My turn | ~6 slides |
| 15-30 | Live demo: add typst to a doc, brand.yml, keep-typ | Our turn | Participants follow |
| 30-45 | Exercise 1 | Your turn | pdf→typst, brand, keep-typ |
| 45-55 | Pause | | |
| 55-62 | Bloc 2 slides: projects, book, orange-book | My turn | ~5 slides |
| 62-77 | Live demo: create book project, apply brand | Our turn | Participants follow |
| 77-90 | Exercise 2 | Your turn | Build a book |
| 90-100 | Bloc 3 slides: raw Typst, partials, extensions | My turn | ~5 slides |
| 100-110 | Demo + optional Exercise 3 | Our turn / Your turn | Partials |
| 110-120 | Wrap-up, resources, Q&A | My turn | Resources page |

**Ratio:** ~30 min slides + ~30 min live demo + ~45 min exercises + 15 min other = ~1.5:1 hands-on to talk
