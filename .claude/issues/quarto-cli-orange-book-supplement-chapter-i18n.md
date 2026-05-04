# Issue draft — quarto-cli: `orange-book-typst` running header not localized via `lang: fr` (typst-show.typ doesn't pipe `crossref-ch-prefix`)

**Repo cible :** [`quarto-dev/quarto-cli`](https://github.com/quarto-dev/quarto-cli)
**À ouvrir par :** Christophe (CD)
**Note interne :** orange-book est livré directement avec `quarto-cli` — subtree à `src/resources/extension-subtrees/orange-book/_extensions/orange-book/` (path confirmé sur HEAD `quarto-dev/quarto-cli`, cf. directory listing `src/resources/`). Le fix se fait donc côté `quarto-cli` en un seul PR — pas besoin de double-tracking via `quarto-ext/orange-book` (existe en tant que repo public mais le code utilisé par les utilisateurs vient du subtree quarto-cli).

---

## Title

`orange-book-typst`: running header stays "Chapter X." despite `lang: fr` — `typst-show.typ` doesn't pipe `crossref-ch-prefix` to `supplement-chapter`

## Bug

In a Quarto book using `format: orange-book-typst`, setting `lang: fr` (or any non-English `lang`) correctly localizes Quarto-managed labels — cross-refs (« la Figure 1.1 », « le Chapitre 2 »), appendix separator (« Annexes ») — but the **running page header** keeps the hardcoded English string:

```
... | Chapter 1. Anatomie
```

Expected with `lang: fr` :

```
... | Chapitre 1. Anatomie
```

## Root cause (orange-book 0.7.1 bundled with Quarto 1.9.36 — verified against HEAD on `quarto-dev/quarto-cli` `main` via `gh api`)

Subtree `src/resources/extension-subtrees/orange-book/_extensions/orange-book/` :

- `typst/packages/preview/orange-book/0.7.1/lib.typ:311` — `book(...)` accepts a `supplement-chapter` parameter with default `"Chapter"` (hardcoded English):

  ```typst
  #let book(title: "", subtitle: "", date: "", author: (), …,
            supplement-chapter: "Chapter", supplement-part: "Part", …) = { … }
  ```

- `lib.typ:419` — used as the H1 supplement, which controls the running header:

  ```typst
  show heading.where(level: 1): set heading(supplement: supplement-chapter)
  ```

- `typst-show.typ` (the Pandoc template that calls `book.with(...)`) pipes `crossref.lof-title` and `crossref.lot-title` from Quarto's language system to `book.with(...)`, but **does not pipe** `crossref.ch-prefix` (nor an analog for `supplement-part`). Excerpt of the mappings currently present:

  ```
  $if(lof)$
    list-of-figure-title: "$if(crossref.lof-title)$$crossref.lof-title$$else$$crossref-lof-title$$endif$",
  $endif$
  $if(lot)$
    list-of-table-title: "$if(crossref.lot-title)$$crossref.lot-title$$else$$crossref-lot-title$$endif$",
  $endif$
  ```

So when Quarto loads `_language-fr.yml` (`crossref-ch-prefix: "Chapitre"`, confirmed in `share/language/_language-fr.yml`), the value never reaches `supplement-chapter` and the default `"Chapter"` is used. This is a missing-pipe bug, not a missing-localization-key bug.

## Reproduction

Minimum viable repro (no R, no brand) :

```yaml
# _quarto.yml
project:
  type: book

lang: fr

book:
  title: "Repro running header"
  chapters:
    - index.qmd
    - 01-chapter.qmd

format: orange-book-typst
```

```markdown
<!-- index.qmd -->
# Préface {.unnumbered}

Préface courte.
```

```markdown
<!-- 01-chapter.qmd -->
# Anatomie

Lorem ipsum dolor sit amet, consectetur adipiscing elit.

[... assez de texte pour déborder sur une 2e page afin que le running header soit visible ...]
```

`quarto render`, open `_book/Repro-running-header.pdf`, page 2+ of chapter 1: shows `Chapter 1. Anatomie` instead of `Chapitre 1. Anatomie`.

## Suggested fix

Add the missing pipe in `src/resources/extension-subtrees/orange-book/_extensions/orange-book/typst-show.typ`, mirroring the existing `lof-title` / `lot-title` pattern:

```diff
$if(date)$
   date: "$date$",
$endif$
+$if(crossref.ch-prefix)$
+  supplement-chapter: "$crossref.ch-prefix$",
+$else$
+$if(crossref-ch-prefix)$
+  supplement-chapter: "$crossref-ch-prefix$",
+$endif$
+$endif$
$if(by-author)$
   author: "$for(by-author)$$it.name.literal$$sep$, $endfor$",
$endif$
```

(Or, more compactly, the same `$if/$else/$endif` pattern already used for `lof-title` / `lot-title`.)

After this change, `lang: fr` (which is enough to load `_language-fr.yml`) would produce "Chapitre" in the running header without any user-side patching.

## Related (probably the same bug class)

`supplement-part` (orange-book template parameter, default `"Part"`) is also not piped from Quarto's language system. Not re-tested empirically here (no parts in the workshop repro), but the same fix would apply via whichever Pandoc variable Quarto exposes for parts. To be confirmed in the PR.

## Workaround for users (until merged)

`quarto add quarto-ext/orange-book` to install the extension locally as a project-side copy, then edit `_extensions/orange-book/typst-show.typ` to add the pipe shown above. Brittle (gets overwritten on extension upgrade) but works.

## Environment

- OS: Linux (Debian noble, Claude Code on the web sandbox)
- Quarto: 1.9.36
- Typst: 0.14.2 (bundled)
- orange-book extension: 0.7.1 (bundled subtree of quarto-cli)
- `_brand.yml` present (irrelevant to the bug — repro works without brand)

## Optional context

Caught while building workshop material for *Rencontres R 2026 — PDF sans frictions : Typst dans vos projets Quarto* (correction in [cderv/cderv-tuto-quarto-typst-rr-2026](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026), branch `claude/quarto-book-skeleton-qeDNI`, file `exercises/02-projet-book/correction/`). Le tutoriel pousse `format: orange-book-typst` côté book — bug visible pour tout participant francophone avec `lang: fr` correctement set.

---

## Notes pour CD avant publication

- **Subtree path confirmé** : `src/resources/extension-subtrees/orange-book/_extensions/orange-book/` (vérifié sur HEAD `quarto-dev/quarto-cli` `main` via `gh api repos/quarto-dev/quarto-cli/contents/...` sur `typst-show.typ` et `lib.typ` — pas de subtree sous `src/resources/extensions/quarto-ext/`, le bon parent est `extension-subtrees/`).
- **Numéros de ligne confirmés sur HEAD** : `lib.typ:311` (book params), `lib.typ:419` (`set heading(supplement: ...)`). Identiques au binaire 1.9.36 installé.
- **Variable Pandoc** : double-vérifier que `crossref.ch-prefix` (avec point) est bien la variable que Quarto expose au template Typst. Si c'est `crossref-ch-prefix` (avec tiret) dans le contexte du template, ajuster le diff. Le pattern existant pour `lof-title` utilise les deux formes en cascade — c'est ce qui est repris dans le diff.
- **Couvrir aussi `supplement-part`** ou laisser pour une issue dérivée ? Pas critique pour la correction RR 2026 (pas de parties), mais c'est probablement la même classe de bug — un fix complet serait plus propre.
- **Backup** : un brouillon parallèle ciblé `quarto-ext/orange-book` a été supprimé après confirmation (CD) que l'extension est livrée directement avec `quarto-cli`. Si jamais la routine release préfère que le PR aille upstream chez `quarto-ext/orange-book` puis re-sync vers le subtree, dis-le et je re-rédige une variante.
