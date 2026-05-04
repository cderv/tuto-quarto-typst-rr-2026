# Issue draft — quarto-cli: orange-book Typst extension doesn't pipe Quarto's `crossref-ch-prefix` to `supplement-chapter` (running header stays English with `lang: fr`)

**Repo cible :** [`quarto-dev/quarto-cli`](https://github.com/quarto-dev/quarto-cli) — orange-book est livré bundled dans Quarto, donc on ouvre côté `quarto-cli` (pas duplication chez `quarto-ext/orange-book`).
**À ouvrir par :** Christophe (CD)
**Voisinage :** issue Quarto book brand fonts (cf. `.claude/issues/quarto-book-brand-fonts.md`) — bug différent, même repo.

---

## Title

`orange-book-typst`: `lang: fr` doesn't localize the running header — "Chapter X. Title" stays English

## Bug

Setting `lang: fr` (or any non-English `lang`) at the project level of a Quarto book using `format: orange-book-typst` correctly localizes Quarto-managed labels — cross-refs render as « la Figure 1.1 », « le Chapitre 2 », appendix separator as « Annexes » — but the **running page header** keeps a hardcoded English string:

```
... | Chapter 1. Anatomie    ← expected: "Chapitre 1. Anatomie"
```

The same applies (presumably — not retested) to `supplement-part` if `parts` are used.

## Reproduction

Project layout:

```
_quarto.yml
index.qmd
01-chapter.qmd
```

```yaml
# _quarto.yml
project:
  type: book

lang: fr

book:
  title: "Repro"
  chapters:
    - index.qmd
    - 01-chapter.qmd

format: orange-book-typst
```

```markdown
<!-- index.qmd -->
# Préface {.unnumbered}
```

```markdown
<!-- 01-chapter.qmd -->
# Anatomie

Some content long enough to spill onto a second page so the running header is visible.

(repeat to force pagination …)
```

`quarto render` then open the resulting PDF: pages 2+ of the chapter show `Chapter 1. Anatomie` in the header instead of `Chapitre 1. Anatomie`.

## Expected

With `lang: fr` set, all chapter-related labels — including the supplement used as the running header — should render in French. Quarto already ships the correct string in `_language-fr.yml`:

```yaml
crossref-ch-prefix: "Chapitre"
```

## Root cause (orange-book 0.7.1 bundled in Quarto 1.9.36)

The Typst template parameter is hardcoded English in the bundled package. Path observed in the installed binary under `share/extension-subtrees/orange-book/_extensions/orange-book/typst/packages/preview/orange-book/0.7.1/lib.typ` (verify the exact subtree location in `quarto-cli` source tree before publishing):

```typst
// lib.typ:311
#let book(title: "", subtitle: "", date: "", author: (), …,
          supplement-chapter: "Chapter", supplement-part: "Part", …) = { … }

// lib.typ:419
show heading.where(level: 1): set heading(supplement: supplement-chapter)
```

The Pandoc template that calls `book.with(...)` —
`_extensions/orange-book/typst-show.typ` — pipes `crossref.lof-title` and `crossref.lot-title` (which Quarto fills from the loaded `_language-*.yml`):

```
$if(lof)$
  list-of-figure-title: "$if(crossref.lof-title)$$crossref.lof-title$$else$$crossref-lof-title$$endif$",
$endif$
$if(lot)$
  list-of-table-title: "$if(crossref.lot-title)$$crossref.lot-title$$else$$crossref-lot-title$$endif$",
$endif$
```

… but **does not pipe** `crossref.ch-prefix` → `supplement-chapter` (nor `pt-prefix` → `supplement-part`). So when Quarto loads `_language-fr.yml` and exposes `crossref.ch-prefix = "Chapitre"` as a Pandoc variable, the value is dropped on the floor for this template, and the Typst default `"Chapter"` is what reaches the rendered PDF.

## Suggested fix

Add the missing pipes in `typst-show.typ`, mirroring the existing `lof-title` / `lot-title` pattern:

```diff
$if(date)$
   date: "$date$",
$endif$
+$if(crossref.ch-prefix)$
+  supplement-chapter: "$crossref.ch-prefix$",
+$else$$if(crossref-ch-prefix)$
+  supplement-chapter: "$crossref-ch-prefix$",
+$endif$$endif$
+$if(crossref.pt-prefix)$
+  supplement-part: "$crossref.pt-prefix$",
+$else$$if(crossref-pt-prefix)$
+  supplement-part: "$crossref-pt-prefix$",
+$endif$$endif$
$if(by-author)$
   author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
```

After this change, `lang: fr` produces "Chapitre" everywhere — including the running header — without any user-side patching.

> **Side question (separable into a follow-up sub-issue if preferred):** today, every Typst extension that wraps Quarto must remember to manually plumb each `crossref-*-prefix` from Quarto's language system to the underlying Typst template. A single missed key results in silently-broken localization for that label, with no warning. Would it be worth providing a Pandoc partial (e.g. a shared Typst preamble) that exposes a complete `crossref` namespace as Typst variables, that extensions can include with one line? Same idea for `title-block-*`, `theorem-*`, etc. Out-of-scope for this issue, but maybe worth a chat.

## Workaround for users (until fixed)

`quarto add quarto-ext/orange-book` to install the extension locally (overrides the bundled copy), then edit `_extensions/orange-book/typst-show.typ` to add the diff above. Brittle — gets overwritten on extension upgrade — but works in the meantime.

## Environment

- OS: Linux (Debian, Claude Code on the web sandbox)
- Quarto: 1.9.36
- Typst: 0.14.2 (bundled)
- orange-book: 0.7.1 (bundled subtree)
- `_brand.yml` present in the original repro but irrelevant: bug also reproduces with no brand.

## Optional context

Caught while building workshop material for *Rencontres R 2026 — PDF sans frictions : Typst dans vos projets Quarto* (correction in [cderv/cderv-tuto-quarto-typst-rr-2026](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026), branch `claude/quarto-book-skeleton-qeDNI`, file `exercises/02-projet-book/correction/`). Render with `lang: fr` shows the bug; `lang: en` masks it (the hardcoded "Chapter" matches by coincidence).

---

## Notes pour CD avant publication

- **Subtree path à confirmer** dans le source `quarto-cli`. J'ai uniquement inspecté les fichiers binaires installés (`/opt/quarto/share/extension-subtrees/orange-book/`) et `quarto-ext/orange-book` côté GitHub. Vérifier le chemin exact du subtree dans `quarto-dev/quarto-cli` (probablement `src/resources/extensions/quarto-ext/orange-book/...` mais à confirmer).
- **Diff fix non testé empiriquement**. J'ai inspecté la logique mais pas patché un build local pour vérifier que `$if(crossref.ch-prefix)$ … $else$$if(crossref-ch-prefix)$ …` se résout bien. La double-fallback suit le pattern `lof-title` existant (`$if(crossref.lof-title)$ … $else$$crossref-lof-title$$endif$`), à priori OK mais à confirmer au build.
- **Side question (Pandoc partial pour crossref namespace)** : à conserver ou retirer selon ton appétit. Si retiré, l'issue devient plus chirurgicale (juste le diff).
- **Repro env** : tester sur un build Quarto local CD pour confirmer que c'est encore le cas en HEAD (pas seulement 1.9.36 sandbox).
