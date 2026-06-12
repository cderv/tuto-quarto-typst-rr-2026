# Review technique — Bloc 1 (vérification d'assertions)

> Date : 2026-06-12 · Type : quarto-technique · Périmètre : `1-quarto-typst/` (slides + index), `exercises/01-document-typst/`, `_charte/`
> Méthode : chaque assertion vérifiée contre le `.typ` réellement généré (`correction/rapport-starwars.typ`, regénéré ce jour sous Quarto **1.9.36**, le plancher annoncé) + doc Quarto officielle (changelog 1.7/1.8 via query-docs).
> (Rédigée par l'agent technique, reportée sur disque par l'orchestrateur — Write refusé pour l'agent.)

## Verdict : OK — Bloc 1 techniquement solide

**Toutes les assertions sont VRAIES** sauf une nuance pédagogique. Aucun faux nom d'extension, aucun conflit multi-format, syntaxe `_brand.yml` exacte.

**Compte : 0 P0 · 0 P1 · 3 P2.**

## Assertions clés confirmées (preuve dans le `.typ`)

- **`primary` colore les liens** (slide:283, index:37) — VRAI : `.typ:436` `#show link: set text(fill: rgb("#bc1e22"))`.
- **Titres colorés seulement via `typography.headings`** (index:62) — VRAI : `.typ:435` émis uniquement parce que `_brand.yml:22-24` définit `headings`. Distinction étape 3 (liens) / étape 4 (titres) correcte.
- **`foreground`/`background` → fond page + texte** — VRAI : `.typ:418-419`.
- **`logo:` imbriqué `images:→<nom>→path/alt` + `medium:`** (index:96) — VRAI : `_brand.yml:26-31`, `.typ:422-433`.
- **Mix Google + locale `source: file`** — VRAI : `_brand.yml:11-21`, syntaxe exacte.
- **Typst intégré depuis 1.5, rien à installer, auto-fallback `_brand.yml`** (slide:120,202) — VRAI (changelog 1.8 confirme le fallback auto Typst).
- **`keep-typ` + traduction `=`/`#strong[]`/`#link()`** — VRAI : `.typ:461,463`.
- **Seuils version** : `.quarto_min=1.9`, `.quarto_reco=1.10.7`, `.quarto_fix=1.10.4` (`pkg/R/utils.R:17-19`) alignés avec `preparatifs.qmd` — VRAI et cohérent.

## Découverte empirique importante

Sur **Quarto 1.9.36**, la police locale Star Jedi (`source: file`, **sans** `font-paths`) **se résout** : `available-fonts.json` liste `"star jedi"` et le PDF rend. Donc **l'Exo 1 ne nécessite PAS le workaround `font-paths`** — celui-ci (fix #14517 / v1.10.4) cible les projets **book**, et est correctement réservé au Bloc 2. Aucune incohérence support↔code.

## Findings P2 (nice-to-have)

- **P2-1** — Charte (`_charte/charte-starwars.qmd`) : la note slide:270 « rendu via un `_brand.yml` identique » est vraie sur les *valeurs* mais la charte **hardcode** couleurs/polices dans des blocs `{=typst}` (`:26,52-55,70`), elle n'est pas pilotée par le mapping brand. Nuance à formuler à l'oral.
- **P2-2** — `primary` colore aussi le **titre principal** (`.typ:452 heading-color`), pas seulement liens + titres de section. Les supports n'en parlent pas (slide:283, index:62). Sans impact, mais le titre passera en rouge à l'étape 4.
- **P2-3** — Vérifié : pas de référence orpheline à `_brand-starter.yml` dans le Bloc 1 (il n'existe que pour l'Exo 2 ; la slide Pause:365 le mentionne au titre du Bloc 2, correct).

## Validé

Syntaxe `_brand.yml` exacte (correction = charte = offline cohérents) ; zéro `orange-book-typst`/`extend:` ; `format: typst` court/long selon options ; `font-paths` au bon niveau (`_charte:9` sous `format.typst`) ; `execute:` cohérent starter↔correction (echo/warning/message false) ; `lang: fr` racine → `Table des matières` ; pas de conflit multi-format (index html + author/date override, slides clean-revealjs + engine markdown + typst-render avec `package-path: /_typst-packages` slash-racine supporté depuis 1.8).
