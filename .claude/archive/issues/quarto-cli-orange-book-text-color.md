# Issue draft — quarto-cli: `orange-book` conflates accent color and body text color via single `main-color`

> **Statut (2026-06-16) — DÉJÀ OUVERTE** : suivie sous
> [#14510](https://github.com/quarto-dev/quarto-cli/issues/14510) (par CD, *open*, labels
> `enhancement`, `books`, `typst`, `themes`, sans milestone). Non résolue à ce jour.

**Repo cible :** [`quarto-dev/quarto-cli`](https://github.com/quarto-dev/quarto-cli)
**À ouvrir par :** Christophe (CD)
**Note interne :** orange-book est livré comme subtree dans `quarto-cli` (`src/resources/extension-subtrees/orange-book/_extensions/orange-book/`). Fix en un seul PR côté `quarto-cli`. Repro construit sur le tuto Quarto+Typst pour Rencontres R 2026 (book avec `_brand.yml` Star Wars).

---

## Title

`orange-book-typst`: `main-color` is used for both cover accent AND body text (TOC, headings) — bright `brand-color.primary` becomes unreadable on `background`

## Summary

When a Quarto book renders to Typst with the bundled `orange-book` extension (auto-activated on `format: typst` + `type: book` since 1.9), the extension reads `brand-color.primary` and uses it as `main-color` everywhere :

- **Cover background** : `cover-fill-color = main-color.lighten(70%)` → pale tint, fine for cover.
- **TOC entries (level 1)** : `textColor: main-color` → text in raw `main-color` over the page background.
- **Chapter headings (H1/H2/H3)** : `fill: main-color` over `background`.
- **Links, citations, theorem boxes** : same.

If `brand-color.primary` is a bright/saturated brand color (typical for brand identity — e.g. Star Wars yellow `#FFE81F`, BBC red, Posit Blue), the cover looks correct but TOC, headings, and links are unreadable on the background.

There is **no way for the user to separate « cover/accent color » from « body text color »** without forking the extension : orange-book exposes only `main-color`.

## Reproduction

Minimal book project. Tested with Quarto 1.9.36 + Typst 0.14.2 bundled.

```
correction/
├── _quarto.yml
├── _brand.yml
└── index.qmd
```

```yaml
# _quarto.yml
project:
  type: book

book:
  title: "Demo"
  chapters: [index.qmd]

format:
  typst: default
```

```yaml
# _brand.yml — bright brand color, classic case
color:
  palette:
    sw-yellow: "#FFE81F"
    sw-black:  "#0B0B0F"
    sw-cream:  "#F5F0E1"
  primary:    sw-yellow
  foreground: sw-black
  background: sw-cream
```

```qmd
# index.qmd
# Préface {.unnumbered}

Sample text.

# Chapter one

Some content with [a link](https://example.com).
```

```bash
quarto render
```

**Observed** : cover-page accent OK (pale yellow), but TOC entries, chapter heading text, and links all rendered in `#FFE81F` over `#F5F0E1` → unreadable.

**Expected** : a way to keep `brand-color.primary` as accent (cover, decorative lines, exercise box strokes) while having body text (TOC, headings, links) use a high-contrast color (`foreground`, `dark`, or a dedicated `text-color`).

## Root cause (verified against HEAD `quarto-dev/quarto-cli` `main` via local clone)

Subtree `src/resources/extension-subtrees/orange-book/_extensions/orange-book/` :

### `typst-show.typ:19` — single entry point

```typst
#show: book.with(
  ...
  main-color: brand-color.at("primary", default: blue),
  ...
)
```

A single `main-color` is piped from `brand-color.primary` to the book function.

### `typst/packages/preview/orange-book/0.7.1/lib.typ:311` — `book()` signature

```typst
#let book(title: "", ..., main-color: blue, cover-background: auto, ...) = { ... }
```

`book()` already accepts `cover-background: auto` as a separate parameter (lines 573-578) :

```typst
if cover-background == auto {
  cover-fill-color = main-color.lighten(70%)
} else {
  cover-fill-color = cover-background
}
```

So the cover can already be decoupled from `main-color` — but `typst-show.typ` never sets `cover-background`. And **there is no `text-color` parameter** : `main-color` is used directly for TOC/headings/links text :

- `my-outline.typ:49, 58, 68` : `textColor: main-color` for outline entries.
- `lib.typ:441, 463, 484, 506, 517, 537` : heading `fill` / stroke uses `main-color`.
- `lib.typ:638` : `show link: set text(fill: main-color)`.

### Why this is more than a user config problem

The user *could* fork the extension. But :

1. The orange-book extension is **bundled** with Quarto and auto-activated by `type: book` + `format: typst`. Users who pick `book + typst` get this template by default — they don't add it explicitly.
2. `brand-color.primary` is the **canonical brand identity color** : the design intent is that it's a bright/saturated color (links, accents, calls-to-action). Brand systems (Bootstrap, Material, Quarto HTML) all expect `primary` to be a brand accent — not body-text-safe.
3. There is **no per-format brand color override** in Quarto (`format.typst.brand.color.primary: xxx` does not work). The brand is resolved once at project level.
4. `include-in-header` is injected **before** the brand-color Lua filter declaration (verified : `index.typ:418-421` user `include-in-header` lands at lines preceding the `#let brand-color = (...)` at line 422). Users can't redefine `brand-color` to override before orange-book reads it.

The only practical workaround today : edit the bundled `_extensions/orange-book/typst-show.typ` locally and pass a different key (e.g. `brand-color.at("dark", default: black)`) as `main-color` plus `cover-background: brand-color.at("primary", ...)` explicitly. This works (verified : `_book/Anatomie-d-une-saga.pdf` renders with black text + yellow cover), but it requires the user to know about pandoc template syntax and patch a shipped extension file. Not realistic for a typical user.

## Proposed fix

### Option A — minimal, additive (preferred)

Add a `text-color` parameter to `book()` in `lib.typ`, defaulting to `main-color` for backward compatibility. Use it (instead of `main-color`) wherever the color is applied to **body text** :

- TOC entry text (`my-outline.typ` level-1 entries).
- Chapter heading text (`lib.typ` level-1/2/3 heading show rules).
- Theorem box title text.
- Link text.

Keep `main-color` for **decorative / accent** uses :
- Cover background tint.
- Lines and stroke borders.
- Exercise box left-stroke.

Then in `typst-show.typ`, pipe :

```typst
#show: book.with(
  ...
  main-color: brand-color.at("primary", default: blue),
  text-color: brand-color.at("foreground", default: black),
  ...
)
```

This:
- Is backward-compatible (defaults preserve current behavior if `text-color` isn't passed, or extension consumers can opt in).
- Uses `brand-color.foreground` (already defined as the body text color in brand semantics) for body text — automatically consistent with the rest of the document.
- Lets brands pick a saturated `primary` and not regret it.

### Option B — alternative semantic key

Read `brand-color.dark` (or `brand-color.text-color`, or `brand-color.heading-color`) and fall back to `main-color`. Less elegant : adds an undocumented brand-key convention that other Typst extensions wouldn't follow.

Option A is preferred because `foreground` is already the canonical body-text key in brand.yml and is already auto-applied by Quarto via `#set text(fill: brand-color.foreground)`.

### Option C — document `cover-background` in `typst-show.typ`

Always pipe `cover-background: brand-color.at("primary", ...)` and have `main-color` default to `foreground`. This is a behavior change (currently `main-color` defaults to `primary`), so would need a release-note callout. Less safe than Option A.

## Related issues

- [#14092](https://github.com/quarto-dev/quarto-cli/issues/14092) — Callout colours inconsistent between HTML and Typst when using `brand.yml`. Same family of issue (brand semantic colors mapped naively to Typst UI elements). This issue here is the H1/TOC/link sibling of #14092.

No existing issue covers the orange-book / Typst extension text-vs-accent split specifically.

## Workshop context (not part of the issue body, internal note)

Discovered while preparing the Quarto+Typst workshop for Rencontres R 2026 (Nantes, 16 June). Repro available at `exercises/02-projet-book/correction/` of the workshop repo. The workshop currently dodges the issue by recommending a darker `primary` color, but it would be cleaner if `brand-color.primary` could stay bright for the cover while keeping TOC readable.
