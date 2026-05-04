# Issue draft — Quarto book + brand fonts: brand cache not passed as `--font-path` to typst

**Repo cible :** [`quarto-dev/quarto-cli`](https://github.com/quarto-dev/quarto-cli)
**À ouvrir par :** Christophe (CD)
**Voisinages :** [#13548](https://github.com/quarto-dev/quarto-cli/issues/13548), [#11929](https://github.com/quarto-dev/quarto-cli/issues/11929), [Discussion #7580](https://github.com/quarto-dev/quarto-cli/discussions/7580)

---

## Title

Typst book: brand fonts downloaded to `.quarto/typst/fonts/` are not passed as `--font-path` to `typst compile`

## Bug description

In a Quarto book project (`project.type: book` + `format: orange-book-typst` or `format: typst`) with `_brand.yml` declaring Google fonts, Quarto correctly **downloads** the fonts into `.quarto/typst/fonts/<host>/...` but **does not pass** that directory as `--font-path` to the final `typst compile` invocation.

Symptoms at render:
- `warning: unknown font family: <font-family>` emitted by typst
- `#show heading: set text(font: ("<font-family>",))` falls back to the default Typst font (Libertinus Serif) instead of the brand font
- The brand styling appears partial — colors apply, but typography does not

The same brand mechanism works for non-book Typst documents.

## Reproduction (minimal)

```yaml
# _quarto.yml
project:
  type: book

book:
  title: "Repro"
  chapters:
    - index.qmd

format: orange-book-typst
```

```yaml
# _brand.yml
typography:
  fonts:
    - family: Orbitron
      source: google
      weight: [400, 700]
  headings: Orbitron
```

```markdown
<!-- index.qmd -->
# Préface {.unnumbered}

Body.
```

Run `quarto render`. Output:

```
[typst]: Compiling index.typ to index.pdf...warning: unknown font family: orbitron
    ┌─ index.typ:NNN:30
    │
NNN │ #show heading: set text(font: ("Orbitron",), )
    │                               ^^^^^^^^^^^^^
```

Inspect with `strace -f -e trace=execve` (or check `--font-path` flags any other way):

```
typst compile … --font-path /opt/quarto/share/formats/typst/fonts <input> <output>
```

Only the Quarto-bundled font path is passed. Yet:

```
$ ls .quarto/typst/fonts/fonts.gstatic.com/s/orbitron/v35/
yMJMMIlzdpvBhQQL_SC3X9yhF25-T1nyGy6BoWg2.ttf
yMJMMIlzdpvBhQQL_SC3X9yhF25-T1ny_CmBoWg2.ttf

$ typst fonts --ignore-system-fonts --font-path .quarto/typst/fonts
…
Orbitron
```

The font is correctly downloaded and discoverable by typst when the path is provided — Quarto just doesn't provide it.

## Expected behavior

The brand font cache directory (`.quarto/typst/fonts/` after the `typst-font-cache` migration) should be appended to typst's `--font-path` arguments for **book projects**, the same way it is for standalone documents.

## Code analysis (Quarto 1.9.36)

The brand integration writes the cache directory into the format metadata (`quarto.js` ~line 129892):

```js
// resolveExtras (gated isTypstOutput)
const font_cache = migrateProjectScratchPath(brand.projectDir, "typst-font-cache", "typst/fonts");
// … download fonts to font_cache …
fontdirs.add(font_cache);

let fontPaths = format14.metadata[kFontPaths] || [];
// (normalize / resolve absolute paths …)
fontPaths.push(...fontdirs);
format14.metadata[kFontPaths] = fontPaths;
```

The single `typstCompile` call site (`quarto.js` ~line 135873) reads back from format metadata:

```js
typstOptions.fontPaths = asArray(format14.metadata?.[kFontPaths]).map(
  (p) => isAbsolute4(p) ? p : resolve4(inputDir, p)
);
```

And `fontPathsArgs` (~line 104059) concatenates Quarto-bundled + caller-provided:

```js
function fontPathsArgs(fontPaths) {
  const fontPathsQuarto = ["--font-path", resourcePath("formats/typst/fonts")];
  // …
  if (fontPaths && fontPaths.length > 0) {
    fontExtrasArgs = fontPaths.map((p) => ["--font-path", p]).flat();
  }
  return fontPathsQuarto.concat(fontExtrasArgs);
}
```

All the wiring is in place. Empirically in book mode, `format.metadata['font-paths']` is **empty** at the typstCompile call site for the assembled book — the mutation made in `resolveExtras` per chapter does not appear to propagate to the format object passed when the book's combined `index.typ` is compiled.

(Plausible hypothesis to verify: the format object that gets the font-paths mutation is the per-chapter one, while the book-level compile uses a freshly-built format that doesn't carry chapter-level mutations — but this is just a reading hypothesis, not a confirmed mechanism.)

## Workaround

Declare `font-paths` explicitly in `_quarto.yml`, pointing to the same dir Quarto already populates:

```yaml
format:
  orange-book-typst:
    font-paths:
      - .quarto/typst/fonts
```

After this change, `strace` confirms both paths are passed:

```
… --font-path /opt/quarto/share/formats/typst/fonts \
  --font-path /<projectDir>/.quarto/typst/fonts …
```

The warning disappears and headings render in the brand font.

This works because the `font-paths` user-set metadata is properly threaded through to the typstCompile call, but it requires the user to know the internal cache path — defeating the point of brand auto-download.

## Environment

- Quarto **1.9.36**
- Typst **0.14.2** (bundled)
- orange-book extension **0.7.1** (bundled)
- OS: Linux (sandbox), reproduces the same way; not OS-specific (Quarto JS pipeline)

## Optional context

Caught while building workshop material for *Rencontres R 2026 — PDF sans frictions : Typst dans vos projets Quarto* (full repro on disk: `exercises/02-projet-book/correction/` in [cderv/cderv-tuto-quarto-typst-rr-2026](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026)). I can produce a smaller standalone repro repo on request.

---

## Notes pour CD avant publication

- Vérifier si le bug se manifeste aussi en **standalone Typst doc** dans cet env (decision log ligne 27 dit que ça marche en standalone Quarto 1.9.36 — donc bug **book-only** probable, à confirmer en testant `exercises/01-document-typst/correction/rapport-starwars.qmd`).
- Vérifier si `format: typst` (sans extension orange-book) reproduit aussi → si oui, c'est un bug Quarto book pur, pas une interaction avec orange-book.
- Si tu veux un repro standalone hors workshop : je peux produire un mini-repo en 5 fichiers.
- Issue title courte alternative : *"Brand fonts downloaded but not added to `--font-path` for typst books"*.
