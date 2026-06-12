# Review technique — Bloc 2 (vérification d'assertions)

> Date : 2026-06-12 · Type : quarto-technique · Périmètre : `2-projets/` (slides + index), `exercises/02-projet-book/`, extension orange-book 0.7.1
> Méthode : vérification contre la source réelle (orange-book `lib.typ`/`typst-show.typ` 0.7.1, `quarto.js`, `main.lua`, `.typ` généré). Env : **Quarto 1.9.36** (sous v1.10.4 → preuve empirique du workaround polices).
> (Rédigée par l'agent technique, reportée sur disque par l'orchestrateur — Write refusé pour l'agent.)

## Verdict : OK — toutes les assertions centrales VRAIES, vérifiées contre la source

Le claim sensible nouvellement ajouté (`headings.color` sans effet en book / couleur via `primary`) est **exact**. Smoke render OK. **P0 = 0 · P1 = 1 · P2 = 4.**

## Assertions confirmées (VRAI)

- **A1 — `type: book` + `format: typst` active orange-book** : `quarto.js:91326-91328` (`baseFormat === "typst"` + `project.type === "book"` → `effectiveExtension = "orange-book"`) + `.typ` généré (`correction/index.typ:462-464`).
- **A2 — orange-book ne lit pas `headings.color`, sans effet en book** : EXACT. orange-book remplace le `typst-show.typ` via `template-partials` (`_extension.yml:8-11`) ; son partial ne consomme que `brand-color.primary` → `main-color` (ligne 19), jamais `heading-color`. Le `typst-show.typ` *par défaut* de Quarto lit `brand.typography.headings.color` (`:54-55`) mais il est overridé. Aucun chemin de consommation en book.
- **A3 — couleur des titres via `primary`/`main-color`, recolore tout l'accent** : EXACT. `book()` n'a que `main-color`, qui pilote couverture + titres N1/N2/N3 + liens + citations + numéros (`lib.typ:443,463,517,537,574-578,638`). Aucune dissociation possible.
- **A4 — `appendices:` → numérotation A/B, couverture+TOC auto** : `index.typ:643` `#show: appendices.with("Annexes", …)` ; `appendices()` installe `numbering("A.1", …)` (`lib.typ:116-140`). `lang: fr` → titre localisé (`orange-book.lua:39-41`).
- **A5 — `headings: "Star Jedi"` forme courte = family** : `_brand.yml:22` / `_brand-starter.yml:22`, police chargée sans warning.
- **A6 — fix v1.10.4 / PR #14517 + workaround `font-paths`** : cohérence interne parfaite (slide `index.qmd:156`, `correction/_quarto.yml:21-29`, `pkg/R/utils.R:9-19`). Preuve empirique : sur Quarto 1.9.36 (version buggée), le render charge Star Jedi + Inter sans warning grâce à `font-paths: [.quarto/typst/fonts, _fonts]`. Placement correct sous `format.typst:`.
- **A7 — pas de conflit multi-format** : `index.qmd:3` `format: html` + `author/date: ""` ; deck `clean-revealjs` ; book mono-format `typst` ; chapitres H1-seul.
- **Cross-refs / pagebreak / brand** : labels résolvent (`tbl-anatomie-mass`, `fig-anatomie-mass`, `#sec-origines`, `tbl-origines-films`) cohérents starter↔correction ; pagebreak `content-visible when-format="typst"` propre ; `_brand-empire.yml` ≡ `_brand.yml` ; `execute:` identique modèle↔correction ; logo `medium:` consommé.
- **Smoke render** : `_book/Anatomie-d-une-saga.pdf` produit, seuls warnings fonts `gt` attendus (couverts par callout `index.qmd:171-175`).

## 🟠 P1

- **P1-1** — Métadonnées de la **PR #14517** non vérifiables hors-ligne (`gh` indisponible). Tout cohérent en interne + workaround marche empiriquement, mais **reconfirmer en ligne** que #14517 est mergée/livrée en v1.10.4. Si la borne diffère, aligner slide + `_quarto.yml` + `pkg/R/utils.R`.

## 🟡 P2

- **P2-1** — slide `2-projets.qmd:80` dit « Quarto 1.9 » ; orange-book exige `>=1.9.17` (`_extension.yml:4`). Approximation acceptable.
- **P2-2** — divider d'annexes = « Annexes » (localisé), items numérotés A./B. ; « bascule en Annexe A » (`index.qmd:62`) juste pour l'item mais perfectible.
- **P2-3** — warnings fonts `gt` (`helvetica/arial/emoji`) attendus et documentés — vérifier en démo qu'ils n'inquiètent pas.
- **P2-4** — « `font-paths` inutile mais anodin sur 1.10.4+ » — exact, rien à faire.
