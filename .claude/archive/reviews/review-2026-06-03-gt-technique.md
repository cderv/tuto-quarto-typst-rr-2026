# Review technique — Brand styling `gt` → Typst (Bonus 4 / corrections)

- **Date :** 2026-06-03
- **Branche :** `claude/r-tutorial-feedback-Tsyfd` (PR #14)
- **Périmètre :** correction technique du brand styling `gt` (helper `styliser_brand()`, `teinte()`, `colorer_metrique()`, `data_color()`) dans les corrections exo 1 / exo 2 + cohérence avec le Bonus 4 du site.
- **Env de test :** R 4.6.0, gt 1.3.0, prismatic 1.1.2, brand.yml 0.1.0, Quarto 1.9.36, orange-book 0.7.1 (auto-activé).

## Verdict général

Le changement est **techniquement solide et reproductible**. J'ai rendu en PDF Typst la correction exo 1 (`rapport-starwars.qmd`) et le book complet exo 2 (`_book/Anatomie-d-une-saga.pdf`) sans erreur (exit 0), et reproduit isolément le dégradé `colorer_metrique()` avec `keep-typ` pour inspecter le `.typ` généré. Les trois points de fragilité signalés au briefing sont **vérifiés et tiennent** : `{{ col }}` dans `data_color` fonctionne au rendu réel, `substr(...,1,7)` retire correctement l'alpha du `#RRGGBBAA` de `clr_darken`, et `prismatic` est déclaré partout où ces fichiers sont rendus. Toutes les features `gt` utilisées rendent en Typst (preuve : couleurs `rgb(...)` cellulaires dans le `.typ`). Cohérence instructions↔correction quasi parfaite, à un écart de factorisation près (le site enseigne `data_color()` inline, la correction le wrappe dans `colorer_metrique()`).

- **« Trop compliqué / fragile » → 👍** (robuste ; complexité justifiée et bien commentée)
- **« Cohérence instructions ↔ correction » → 👍** (un seul écart mineur P2 sur `colorer_metrique`)

## 🔴 P0 — bloquant

Néant.

## 🟠 P1 — à corriger avant le 16 juin

Néant. (Aucun bug technique. Voir P2 pour les points de robustesse/cohérence.)

## 🟡 P2 — nice-to-have / robustesse

### P2-1 — Le helper `colorer_metrique()` n'est jamais montré au participant
`2-projets/index.qmd:238-244` enseigne le dégradé en **`data_color()` inline** :
```r
... |> styliser_brand() |> data_color(columns = n, palette = c(...), apply_to = "fill")
```
La correction (`02-origines.qmd:42-46,71,132`) le **factorise** dans `colorer_metrique <- function(t, col) data_color(columns = {{ col }}, ...)`. Résultat strictement identique, palette identique — mais le participant qui ouvre la correction « filet final » découvre un helper avec embrace `{{ col }}` jamais introduit. Deux options :
- (préférée, minimal) ajouter une demi-phrase au Bonus 4 : « dans la correction, ce `data_color()` est regroupé dans un petit helper `colorer_metrique()` pour ne pas le répéter sur deux tableaux » ;
- ou inliner `data_color()` dans la correction comme le fait le site (mais on perd le DRY sur 2 tableaux).
Non bloquant : c'est une montée en abstraction cohérente, pas une contradiction.

### P2-2 — Le mot « silencieusement » du callout « Piège silencieux » est optimiste pour le chemin `cell_fill`/`tab_style`
`2-projets/index.qmd:272-276` affirme qu'une clé palette mal saisie fait « disparaître silencieusement » la mise en forme. C'est **exact pour `pal()` seul** (vérifié : `pal("sw-yellow")` dash renvoie `"sw-yellow"`, clé inconnue `pal("sw_yelow")` renvoie `"sw_yelow"` sans erreur). **Mais** dès que cette chaîne invalide est passée à `cell_fill(color=...)` ou `data_color(palette=...)`, **gt lève une erreur dure** :
```
Error in `cell_fill()`: ! An invalid color name was used ("sw-yelow").
```
Donc en pratique, dans `styliser_brand()`/`colorer_metrique()`, une faute de frappe **plante le rendu** (ce qui est plutôt rassurant) plutôt que de disparaître en silence. Le « silence » ne survient que si la chaîne erronée se trouve être fortuitement un nom de couleur CSS/R valide — cas rare. Suggestion : reformuler en « `pal()` ne lève pas d'erreur sur une clé inconnue ; selon où la valeur atterrit, soit `gt` plante au rendu (cas `cell_fill`/`data_color`), soit la mise en forme est ignorée ». Cosmétique, mais le callout vend un risque légèrement différent du vrai.

### P2-3 — Warnings de fallback fonts sur la chaîne par défaut de `gt` (cosmétique, attendu)
Au render exo 1, Typst émet `warning: unknown font family: helvetica / arial / sans-serif / apple color emoji / segoe ui …` sur la pile de fallback que gt sérialise (`font: ("Inter", "system-ui", "Segoe UI", …, "Noto Color Emoji")`, `rapport-starwars.typ:468`). **Inter est bien en tête** (preuve que `opt_table_font("Inter")` fonctionne), donc le rendu est correct ; ce ne sont que des warnings sur les fallbacks absents sous Linux. Attendu et non bloquant — déjà couvert par la culture « warnings fonts Linux » du repo. Rien à faire, mentionné pour traçabilité.

## ✅ Choix techniques validés (avec preuves)

### `substr(as.character(clr_darken(pal(x), f)), 1, 7)` — correct et robuste
`clr_darken()` retourne un objet `colors` dont `as.character()` donne **`#RRGGBBAA` (9 caractères)**, ex. `#E5E0D1FF`. `substr(...,1,7)` → `#E5E0D1`, alpha retiré proprement. Confirmé sur input nommé aussi (`c(sw_yellow="#FFE81F")` → `#DDC900`). gt accepte ce hex 6-chiffres sans souci et Typst émet `rgb("#e5e0d1")`. **Le `,1,7` est nécessaire** : sans lui, gt recevrait `#E5E0D1FF` (8 hex) que gt/Typst gère différemment — le choix est volontaire et juste.

### `{{ col }}` (embrace) dans une fonction appelant `data_color` (tidyselect) — fiable
Testé au rendu Typst réel : `colorer_metrique(n)` et `colorer_metrique(n_films)` produisent un dégradé correct. Le `.typ` standalone (reproduit avec `keep-typ`) montre l'interpolation crème→jaune→rouge effective sur la colonne :
```
fill: rgb("#f5f0e1")  (background)
fill: rgb("#fbeec1")  fill: rgb("#feeca0")   (vers sw-yellow)
fill: rgb("#cc5324")  fill: rgb("#bc1e22")   (vers primary/imperial-red)
```
`{{ }}` est le bon outil ici (tidyselect dans `columns=`), pas de fragilité.

### `prismatic` déclaré partout où les fichiers sont rendus
- `preparatifs.qmd:51` : `pkg <- c(..., "brand.yml", "prismatic")`.
- `pkg/R/utils.R:17` (`.paquets_requis`) + `pkg/DESCRIPTION:25` (`Imports`) + snapshot `pkg/tests/.../snapshots.md:61`.
- `exercises/02-projet-book/README.md:10` : « Pour le Bonus 4 … `brand.yml` + `prismatic` ».
- `2-projets/index.qmd:200` : `library(prismatic)` dans l'étape 1 du Bonus 4.
Le README **starter** (`starter/README.md`) ne le liste pas, ce qui est **correct** : le starter est l'état « avant », le Bonus 4 est optionnel et renvoie au site. Cohérent.

### Features `gt` → Typst : toutes rendues, aucune ignorée silencieusement
Inspection du `rapport-starwars.typ` (region tableau, lignes ~471-490) :
- `tab_style(cells_title(groups="title"))` → `table.header(... fill: rgb("#ffe81f"))` **bandeau jaune SW** ✓
- `cells_column_labels()` noir/crème → `fill: rgb("#0b0b0f")` + `text(fill: rgb("#f5f0e1"))` ✓
- ligne 1 Jabba `cells_body(rows=1)` → `fill: rgb("#bc1e22")` texte crème gras ✓
- `opt_row_striping()` + `row.striping.background_color` → `fill: rgb("#e5e0d1")` (= `teinte("background",0.06)`) ✓
- `table_body.hlines.color` → `stroke: (paint: rgb("#d5d0c1") …)` (= `teinte(...,0.12)`) ✓
- borders `pal("primary")` / `px(2)` → filets imperial-red ✓
- `fmt_number(sep_mark=" ")` → `1 358` correct, **pas de bug « 1 7 5 »** grâce à `opt_table_font("Inter")`.
Toutes les `tab_options` utilisées produisent du Typst — aucune n'est avalée par le backend `as_typst` de gt 1.3.0.

### Renders smoke — OK
- `exercises/01-document-typst/correction/rapport-starwars.qmd --to typst` → `rapport-starwars.pdf` (86 ko), exit 0.
- `exercises/02-projet-book/correction/` (`quarto render`) → `_book/Anatomie-d-une-saga.pdf`, exit 0, orange-book 0.7.1 auto-activé, 5 chapitres + annexe.
- Cross-refs `@fig-anatomie-mass`, `@sec-origines`, `@tbl-origines-films` (`conclusion.qmd`) tous résolus (aucun `?@` dans l'output).
- `content-visible when-format="typst"` + `{{< pagebreak >}}` conforme au Bonus B2.

### `font-paths:` bien placé
`exercises/02-projet-book/correction/_quarto.yml` : `font-paths` sous `format.typst:` (pas `book:`, pas top-level), avec `.quarto/typst/fonts` + `_fonts`. Workaround #14517 correctement commenté comme inoffensif sur v1.10.4+.

### Cohérence helper site ↔ correction — identique
Tokens vérifiés un à un présents des deux côtés : `theme_brand_gt(brand)`, `opt_table_font(font = "Inter")`, `opt_row_striping()`, `cells_title(groups="title")`, `cells_column_labels()`, `teinte("background", 0.06)`, `teinte("background", 0.12)`, `heading.align`, palette `c(pal("background"), pal("sw_yellow"), pal("primary"))`. Le helper du Bonus 4 (`index.qmd:210-229`) est fonctionnellement le `styliser_brand()` de la correction.

### Clé palette : `sw_yellow` (underscore) utilisé partout — correct
Confirmé : `brand.yml` normalise `sw-yellow` → `sw_yellow` au read ; toutes les corrections utilisent l'underscore. Le callout « Piège silencieux » documente exactement ce comportement (modulo P2-2).

### Pas de claim faux « Star Jedi dans un titre gt »
`README/index.qmd:61` « titres Star Jedi » désigne **la couverture orange-book**, et la même cellule précise « les tableaux `gt` restent bruts à ce stade ». Les corrections gt utilisent **uniquement Inter** (`grep` : aucune occurrence de Star Jedi/headings dans les `.qmd` de correction). La capture `2-gt.png` et sa légende (`index.qmd:270`) décrivent fidèlement le `.typ` rendu (bandeau jaune, en-têtes noir/crème, ligne Jabba rouge, striping crème, filets imperial-red).

### Liens GitHub — tous légitimes
Seuls `github.com/cderv/tuto-quarto-typst-rr-2026` et `github.com/quarto-dev/quarto-cli` (cité pour le PR #14517). Aucun mauvais repo.

## 📝 Évolution depuis la review précédente

Par rapport à `review-2026-06-01-quarto-technique.md`, ce changement **ajoute** une couche brand styling `gt` substantielle sans introduire de régression : `font-paths` est resté correctement placé, le `lang: fr`/cross-refs/orange-book continuent de fonctionner, et le nouveau code R est entièrement reproductible avec les prérequis déjà déclarés. Le `opt_table_font("Inter")` répond proprement au bug « 1 7 5 » déjà documenté. La factorisation en helpers (`styliser_brand`, `teinte`, `colorer_metrique`) est bien commentée et pédagogiquement alignée sur le site, à l'écart P2-1 près.

---

## Résumé (5-8 lignes)

Le brand styling `gt`→Typst est techniquement sain et entièrement reproductible : j'ai rendu sans erreur la correction exo 1 et le book exo 2, et inspecté le `.typ` généré pour prouver que chaque effet (bandeau jaune, en-têtes noir/crème, ligne Jabba rouge, striping crème, filets imperial-red, dégradé `data_color`) atterrit bien en `rgb(...)` Typst. Les trois points de fragilité du briefing tiennent : `{{ col }}` marche au rendu réel, `substr(...,1,7)` retire correctement l'alpha du `#RRGGBBAA` de `clr_darken`, et `prismatic` est déclaré dans préparatifs, le pkg compagnon et le README exo. Verdict « trop compliqué/fragile » : 👍 (robuste, complexité justifiée). Verdict « cohérence instructions↔correction » : 👍 (helper site≡correction). Zéro P0/P1. Deux P2 cosmétiques : le helper `colorer_metrique()` n'est pas montré au participant (le site enseigne `data_color()` inline), et le mot « silencieusement » du callout est optimiste — une clé palette fautive fait en réalité **planter** `cell_fill`/`data_color` plutôt que disparaître. Les warnings fonts Linux sont attendus et non bloquants.
