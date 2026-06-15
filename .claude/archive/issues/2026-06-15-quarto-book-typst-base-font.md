# Quarto issue draft — book + typst : police de **corps** (`base`/`mainfont`) non appliquée

> **Statut (2026-06-15)** — Constaté sur Quarto **1.10.11** (dernière pre-release) **et** 1.9.36.
> **Distinct** de `quarto-book-brand-fonts.md` (résolu par #14517) : celui-là portait sur la
> *disponibilité* des polices (`font-paths` non passé → **titres** en serif + warning
> `unknown font family`). **Ici, les titres marchent** (Star Jedi appliqué, aucun warning) ;
> c'est la **police de corps** (`typography.base` / `mainfont`) qui n'est **jamais demandée**
> en mode book → le corps retombe sur la serif par défaut de Typst (Libertinus).
> **Pour CD** : draft pour `quarto-dev/quarto-cli`. Côté workshop : **non corrigé** (paquet
> 1.0.1 gelé) → reporté 1.0.2 ; Q&A speaker ajoutée (`_speaker/demo-bloc2-our-turn.qmd`).

---

## Title

`book + format: typst` : the brand **base** font (`typography.base` / `mainfont`) is not
passed to the orange-book template — body text falls back to Libertinus Serif (headings OK)

## Bug

When rendering a Quarto **book** (`project.type: book`) to **Typst**, the document body font
declared by `_brand.yml` `typography.base` (or by `mainfont`) is **not applied**. The generated
`book.with(...)` call omits the `font:` argument entirely, so orange-book's `font` parameter
stays at its `none` default and Typst uses its default serif (Libertinus). Headings are
unaffected (the brand `headings` font is emitted via a separate `#show heading: set text(...)`).

This is **book-mode specific**: a standalone `format: typst` document with the *same*
`_brand.yml` correctly emits `font: ("Inter",)` and embeds Inter.

## Minimal reproduction (no R, brand only)

```
mybook/
├── _quarto.yml
├── _brand.yml
├── _fonts/Starjedi.ttf      # any local font for headings (optional)
└── index.qmd                # # Préface + un paragraphe
```

`_quarto.yml`
```yaml
project:
  type: book
lang: fr
book:
  title: "Anatomie d'une saga"
  subtitle: "Portrait statistique des personnages de Star Wars"
  author: "Mon Mothma"
  chapters:
    - index.qmd
format:
  typst:
    keep-typ: true
    # mainfont: Inter            # <- testé aussi : IGNORÉ en mode book
    font-paths: [.quarto/typst/fonts, _fonts]
```

`_brand.yml`
```yaml
typography:
  fonts:
    - { family: "Star Jedi", source: file, files: [ { path: _fonts/Starjedi.ttf, weight: 400 } ] }
    - { family: Inter, source: google, weight: [400, 600, 700] }
  base: Inter
  headings: "Star Jedi"
```

`quarto render` → `_book/Anatomie-d-une-saga.pdf`.

## Expected

Body text in **Inter** (the brand `base`). Same as a standalone `format: typst` document.

## Actual

Body text in **Libertinus Serif**. No warning (the font is never requested).

### Control comparison — same `_brand.yml`, single doc vs book

| | generated `.typ` | `pdffonts` (corps) |
|---|---|---|
| `format: typst` (single doc, `type: default`) | `font: ("Inter",)` passed to template | **Inter-Regular** embedded |
| `type: book` (orange-book) | `#show: book.with(title, subtitle, author, lang, main-color, logo, …)` — **no `font:`** | **LibertinusSerif-Regular/Bold/Italic** (no Inter) |

In book mode the string `Inter` never appears in the generated `index.typ`. orange-book's
`book()` *does* expose a `font` parameter (default `none`, applied via `set text(font: font) if
font != none`) — it simply isn't filled. Setting `mainfont: Inter` explicitly does **not** help
in book mode either (still absent from `book.with(...)`).

## Workaround (verified)

Force the body font with raw Typst injected in the header:

```yaml
format:
  typst:
    include-in-header:
      - text: |
          #set text(font: "Inter")
```

After this, `pdffonts` shows **Inter-Regular/Bold** (Libertinus gone), headings still Star Jedi.

## Root-cause hypothesis

The book → orange-book template generation maps brand/format metadata to `book.with(...)`
arguments (title, subtitle, author, lang, main-color, logo, …) but **does not map
`typography.base` / `mainfont` to the `font:` argument**. For standalone typst the default
template path does emit `font: (...)`, so the mapping exists per-file but is dropped on the
book-assembly path (parallel to the earlier `font-paths` book-mode wiring gap of #14517,
which was on the *availability* side).

## Suggested fix

Pass the resolved base/main font to `book.with(font: ...)` (orange-book already supports it),
or emit a document-level `#set text(font: (...))` for books as is done for standalone docs.

## Environment

- Quarto **1.10.11** (reproduces) and 1.9.36 (reproduces)
- Typst bundled, orange-book **0.7.1**
- `_brand.yml typography.base: Inter` (`source: google`), `headings` local file
- Reproduces with `format: typst` (auto orange-book); no R, brand only
- Headings render correctly; only the **body** font is missing → distinct from #14517

## Related

- #14517 — book brand fonts not passed as `--font-path` (RESOLVED, headings/availability)
- Our prior draft : `.claude/archive/issues/quarto-book-brand-fonts.md`
