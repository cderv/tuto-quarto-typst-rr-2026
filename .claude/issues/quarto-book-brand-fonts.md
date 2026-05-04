# Quarto issue draft — book + brand fonts not passed to typst compile

> **Pour CD** : draft pour `quarto-dev/quarto-cli` issues. Reproduit dans une sandbox Linux propre (Quarto 1.9.36 + Typst 0.14.2 bundled). Logs et inspection de `quarto.js` ci-dessous.
> Branche workshop où le repro existe : `claude/quarto-book-skeleton-qeDNI` — `exercises/02-projet-book/correction/`. Avant de filer, retirer la ligne `font-paths` pour reproduire (commit pré-workaround : `1b39468`).

---

## Title

`book + format: typst + _brand.yml fonts: source: google` — brand fonts downloaded but not passed as `--font-path` to `typst compile` (orbitron unknown font family warning, headings fall back to serif)

## Bug

When rendering a Quarto **book** (`project.type: book`) to **Typst** with **brand fonts** declared in `_brand.yml` via `source: google`:

- Quarto **does** download the requested fonts to `.quarto/typst/fonts/fonts.gstatic.com/s/<family>/...` (Inter and Orbitron in the repro, both TTF static)
- Quarto **does not** pass that directory to `typst compile` via `--font-path`
- Typst emits `warning: unknown font family: orbitron` (and `: inter` for body if used by template)
- Headings fall back to the Typst default (Libertinus Serif) instead of the brand `headings` font

## Reproduction

Minimal book project. No R chunks, no R packages, lipsum content only.

```
correction/
├── _quarto.yml
├── _brand.yml
├── _logo-sw.svg          # any SVG, irrelevant to the bug
├── index.qmd             # # Préface {.unnumbered}
├── 01-anatomie.qmd       # # Anatomie + lipsum
├── 02-origines.qmd       # # Origines {#sec-origines} + lipsum
├── conclusion.qmd        # # Conclusion + lipsum
└── annexe-donnees.qmd    # # Le dataset starwars + lipsum
```

`_quarto.yml`:

```yaml
project:
  type: book

book:
  title: "Anatomie d'une saga"
  author: "Mon Mothma"
  date: "2026-06-16"
  chapters:
    - index.qmd
    - 01-anatomie.qmd
    - 02-origines.qmd
    - conclusion.qmd
  appendices:
    - annexe-donnees.qmd

format: typst   # orange-book extension auto-activated; same bug with `format: orange-book-typst`
```

`_brand.yml`:

```yaml
color:
  palette:
    sw-yellow: "#FFE81F"
    sw-black:  "#0B0B0F"
    sw-cream:  "#F5F0E1"
  primary:    sw-yellow
  foreground: sw-black
  background: sw-cream

typography:
  fonts:
    - family: Orbitron
      source: google
      weight: [400, 700]
    - family: Inter
      source: google
      weight: [400, 600]
  base: Inter
  headings: Orbitron
```

Run:

```bash
quarto render
```

Render output:

```
[typst]: Compiling index.typ to index.pdf...warning: unknown font family: orbitron
    ┌─ index.typ:448:30
    │
448 │ #show heading: set text(font: ("Orbitron",), )
    │                               ^^^^^^^^^^^^^

DONE
Output created: _book/Anatomie-d-une-saga.pdf
```

## Expected behavior

Brand fonts (Inter, Orbitron) should be available to the Typst compile step. No warning. Headings should render in Orbitron (not the Libertinus Serif fallback).

## Actual behavior

`quarto typst fonts --ignore-system-fonts --font-path .quarto/typst/fonts/` correctly lists Inter and Orbitron — they **are downloaded**:

```
DejaVu Sans Mono
Inter
Libertinus Serif
New Computer Modern
New Computer Modern Math
Orbitron
```

But `strace -f -e trace=execve` on the render shows `typst compile` is invoked with only the bundled font path, not the brand cache:

```
execve("/opt/quarto/bin/tools/x86_64/typst",
  [..., "compile", "--root", "<projectDir>",
   "--package-cache-path", "<projectDir>/.quarto/typst/packages",
   "<projectDir>/index.typ",
   "--font-path", "/opt/quarto/share/formats/typst/fonts",
   "<projectDir>/index.pdf"], ...)
```

No `--font-path <projectDir>/.quarto/typst/fonts` is ever appended.

## Workaround

Adding `font-paths` explicitly in the format config makes both paths get passed (verified via strace):

```yaml
format:
  typst:
    font-paths:
      - .quarto/typst/fonts
```

Post-workaround `execve` shows:

```
... "--font-path", "/opt/quarto/share/formats/typst/fonts",
    "--font-path", "<projectDir>/.quarto/typst/fonts", ...
```

No warning, headings render in Orbitron.

## Root cause hypothesis (from `quarto.js` source inspection)

The brand-font integration is wired correctly in `resolveExtras()` (Quarto 1.9.36, `/opt/quarto/bin/quarto.js`):

- **L. 129770**: `const fontdirs = new Set();` initialised
- **L. 129841-892**: fonts downloaded into `font_cache = migrateProjectScratchPath(brand.projectDir, "typst-font-cache", "typst/fonts")` and `fontdirs.add(font_cache)`
- **L. 129893-901**: `fontPaths = format.metadata['font-paths'] || []; ...; fontPaths.push(...fontdirs); format.metadata['font-paths'] = fontPaths;`

The single `typstCompile` call site (**L. 135873**) reads `format.metadata['font-paths']` and passes it to `fontPathsArgs()` (**L. 104059**), which concatenates `["--font-path", resourcePath("formats/typst/fonts")]` with the user-supplied paths.

So the chain is correctly wired **per file**. The issue appears in **book mode**: `resolveExtras()` runs and mutates `format.metadata['font-paths']` for individual chapter formats, but the `format` object passed to the final `typstCompile` call (compiling the assembled `index.typ`) is **not the same object** that was mutated, so `format.metadata['font-paths']` is empty at compile time.

Standalone `format: typst` documents (no project, or `type: default`) seem unaffected — needs explicit re-test, but the prior workshop session reported standalone working with `source: google`.

## Environment

- OS: Linux (Debian, Claude Code on the web sandbox)
- Quarto: 1.9.36
- Typst (bundled): 0.14.2
- Brand: `_brand.yml typography.fonts.source: google`, fonts Inter (400/600) + Orbitron (400/700)
- Reproduces with both `format: typst` (auto orange-book) and `format: orange-book-typst` (explicit)
- Reproduces freshly (no R, no chunks, lipsum only)

## Related upstream context

- #13548 — Variants fonts from same family with Brand YAML (similar cluster: brand fonts not reaching Typst compile reliably)
- #11929 — All `brand.typography.fonts` should be made available in websites (different but adjacent: "downloaded but not exposed")
- Discussion #7580 — Custom fonts with typst (env var vs CLI flag exclusivity)
- #11278 — Documentation: troubleshooting Typst fonts
- #12695 — `font-path` resolution relative to project root

## Suggested fix direction

Two angles, not mutually exclusive:

1. **Wire-up fix**: ensure the format object whose `metadata['font-paths']` is mutated by `resolveExtras` is the same object that flows into the book-level `typstCompile` call. If the book pipeline rebuilds or clones the format, propagate the brand `fontdirs` accordingly.
2. **Belt-and-braces fix in `fontPathsArgs`**: always include the project-level brand cache when it exists. The function already knows about `Deno.env.get("TYPST_FONT_PATHS")` and the bundled path; add a check for a known scratch path under the project dir (`migrateProjectScratchPath(projectDir, "typst-font-cache", "typst/fonts")`).

Happy to test a candidate fix if useful.

---

## Notes pour l'issue (à retirer avant filing)

- Si CD veut un repro encore plus minimal (sans book), tester d'abord en `type: default` + `format: typst` pour confirmer/infirmer si c'est un bug **book-only**. Si non book-only, l'angle root cause change (le bug est plus haut dans `resolveExtras`).
- L'inspection `quarto.js` ci-dessus est sur le bundle compilé (Deno bundle). Les vrais paths source TS sont dans `quarto-cli/src/...`. Référencer les fichiers source plutôt que les line numbers du bundle dans l'issue finale.
- Vérifier la branche / version : 1.9.36 est dans la sandbox ; si CD a 1.9.37+ localement, re-confirmer avant d'ouvrir l'issue.
