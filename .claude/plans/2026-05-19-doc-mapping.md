# Doc mapping — Indices "💡 Indices doc" par étape

> Référence : `.claude/design-your-turn-refonte.md` § Inventaire doc → étapes.
> Règle : max 2-3 docs par étape (cf. risque "8 onglets noyé").
> Audit liens : `scripts/audit-doc-links.sh` à exécuter pré-J16.

## Exercice 1 — Document Typst stylé

| Étape | Action condensée | Doc primaire | Doc secondaire |
|---|---|---|---|
| 1 | `format: typst` + render | https://quarto.org/docs/output-formats/typst.html | — |
| 2 | Options Typst (`papersize`, `toc`, `mainfont`) | https://quarto.org/docs/output-formats/typst.html#format-options | https://quarto.org/docs/reference/formats/typst.html |
| 3 | `_brand.yml` couleurs + police Google | https://quarto.org/docs/authoring/brand.html | https://posit-dev.github.io/brand-yml/ |
| 4 | Police locale via `source: file` | https://posit-dev.github.io/brand-yml/brand/typography.html | — |
| 5 | `keep-typ: true` et exploration `.typ` | https://quarto.org/docs/output-formats/typst.html | — |

## Exercice 2 — Projet & book

| Étape | Action condensée | Doc primaire | Doc secondaire |
|---|---|---|---|
| 1 | `_quarto.yml` avec `project.type: default` + `format: typst` | https://quarto.org/docs/projects/quarto-projects.html | https://quarto.org/docs/output-formats/typst.html |
| 2a | Passer à `type: book` + `chapters:` | https://quarto.org/docs/books/ | https://quarto.org/docs/books/book-structure.html |
| 2b | Ajouter `appendices:` | https://quarto.org/docs/books/book-structure.html#appendices | — |
| 3 | Copier `_brand.yml` + logo + `_fonts/` à la racine | https://quarto.org/docs/authoring/brand.html | https://posit-dev.github.io/brand-yml/ |
| B1 | Cross-refs `@fig-` `@sec-` | https://quarto.org/docs/authoring/cross-references.html | — |
| B2 | Pagebreak conditionnel `content-visible` | https://quarto.org/docs/authoring/conditional.html | https://quarto.org/docs/authoring/markdown-basics.html#page-breaks |
| B3 | Variante palette via `brand: _brand-jedi.yml` | https://quarto.org/docs/authoring/brand.html | — |
| B4 | `brand.yml` R + `theme_brand_gt` / `theme_brand_ggplot2` | https://posit-dev.github.io/brand-yml/pkg/r/articles/branded-themes.html | https://posit-dev.github.io/brand-yml/pkg/r/reference/brand_color_pluck.html |

## Notes opérationnelles

- **Anglais** : doc Quarto/Posit majoritairement anglophone. Mentionner explicitement en intro workshop (cf. design § Risques résiduels).
- **Sections internes** (ancres `#format-options`, `#appendices`, etc.) : vérifier qu'elles existent toujours au J16 — la doc Quarto réorganise régulièrement les pages.
- **brand-yml R pkg URL** : `posit-dev.github.io/brand-yml/pkg/r/` sous-domaine en cours de stabilisation 2026. Si l'URL bouge, l'audit script remontera le 404.
