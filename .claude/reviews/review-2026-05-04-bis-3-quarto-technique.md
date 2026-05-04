# Review technique post-fix — Quarto+Typst — 2026-05-04 (3ᵉ vague)

**Reviewer :** staff/Quarto core, en aveugle de la session du matin sauf pour le contexte historique fourni par CD.
**Branche :** `claude/quarto-book-skeleton-qeDNI` · HEAD : `34e8d0f`.
**Quarto :** 1.9.36 (`/usr/local/bin/quarto`). **Typst embedded :** 0.14.2.

## Verdict général

Le matériel est **techniquement solide**. Tous les fixes T1/T2/T5/B2 de la session du matin tiennent : zéro résidu de `format: orange-book-typst` ou `extend: orange-book` dans le contenu pédagogique (sources `.qmd`/`.yml`/`.md` hors `.claude/`), `font-paths:` correctement placé sous `format.typst:`, pépite « template partials » reformulée honnêtement. Le rendu site complet `quarto render` passe sans warning Pandoc, et les 2 corrections (Exo 1 standalone + Exo 2 book) produisent des PDFs valides (Exo 1 : 1 PDF ; Exo 2 : `_book/Anatomie-d-une-saga.pdf`, 15 pages A4, fonts Orbitron + Inter embarquées via `pdffonts`, cross-refs « Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1 / Chapitre 2 / Annexes » bien localisées en français). Reste **un seul claim techniquement faux** (P1 : `quarto typst gather` n'existe pas, c'est `quarto call typst-gather`), un piège H1/H2 mineur d'inconsistance starter↔correction Exo 1, et 2-3 micro-imprécisions à arbitrer.

## P0 — bug technique bloquant

Aucun.

## P1 — à corriger avant le 16 juin

### P1.1 — `quarto typst gather` n'existe pas — la vraie commande est `quarto call typst-gather`

**Localisation :** `4-ressources.qmd:42`.

```markdown
- `typst-gather` : embarquer les packages Typst pour le rendu hors-ligne (`quarto typst gather`)
```

**Problème.** La commande `quarto typst gather` n'existe pas. `quarto typst …` exécute le binaire Typst embarqué, qui n'a pas de sous-commande `gather` (`quarto typst gather` → *unrecognized subcommand 'gather'. tip: a similar subcommand exists: 'watch'*). La vraie commande est sous le namespace `quarto call` :

```
$ quarto call --help
…
  typst-gather   - Gather Typst packages for a format extension.

$ quarto call typst-gather --help
Description:
  Gather Typst packages for a format extension.
  This command scans Typst files for @preview imports and downloads the packages to
  a local directory for offline use.
```

**Référence externe.** Le blog post officiel Quarto 2026-03-31 (déjà cité dans `4-ressources.qmd:24`) écrit littéralement : « Authors run `quarto call typst-gather` and commit the results ».

**Fix proposé.** Sur `4-ressources.qmd:42` :

```markdown
- `typst-gather` : embarquer les packages Typst pour le rendu hors-ligne (`quarto call typst-gather`)
```

**Impact.** Si un participant curieux le tape pendant le tutoriel, il aura un message d'erreur. Pour quelqu'un qui suit la doc à la lettre après l'événement, c'est un point d'arrêt. Trivial à corriger, à ne pas laisser traîner.

## P2 — nice-to-have / amélioration de robustesse

### P2.1 — Inconsistance niveau de titres entre starter et correction Exo 1

**Localisation :** `exercises/01-document-typst/starter/rapport-starwars.qmd` (H2 partout) vs `exercises/01-document-typst/correction/rapport-starwars.qmd:29,36,70,94` (H1 : `# Introduction`, `# Top 5…`, `# Taille vs masse`, `# Conclusion`).

Le starter a `## Introduction`, `## Top 5…`, `## Taille vs masse`, `## Conclusion` (level 2). La correction a `# Introduction`, `# Top 5…`, `# Taille vs masse`, `# Conclusion` (level 1). La consigne (Exercice 1, page web `1-quarto-typst/index.qmd:47-51` et slide `1-quarto-typst.qmd:170-174`) ne demande pas de changer les niveaux de titre. Un participant qui suit la consigne à la lettre obtiendra un PDF avec sections non numérotées au top-level (puisque `number-sections: true` numérote à partir du H1) et un autre TOC que la correction.

Pas un bug technique (les deux rendent), mais inconsistance pédagogique : la correction n'est pas obtenue par la procédure décrite. Soit aligner le starter sur H1, soit aligner la correction sur H2 (plus fidèle à la transformation `format: html → format: typst`).

### P2.2 — `linkcolor:` documenté sans préciser que la valeur attend une chaîne hex

**Localisation :** `4-ressources.qmd:51`, `README.md:40`.

Smoke test : `format.typst.linkcolor: blue` → `error: color string contains non-hexadecimal letters` (le pipeline orange-book passe la valeur littérale à `rgb(content-to-string(linkcolor))` qui n'accepte pas les couleurs nommées). Avec `linkcolor: "#1a5276"` → OK.

Si quelqu'un essaie pendant la pause `linkcolor: blue` (pattern raisonnable), il aura une erreur Typst frustrante. À mentionner à l'oral ou en pépite.

### P2.3 — `preparatifs.qmd:18` liste 3 packages R jamais utilisés

```r
pkg <- c("rmarkdown", "quarto", "dplyr", "ggplot2", "ggrepel", "gt", "knitr", "scales", "brand.yml", "prismatic")
```

Audit `library(...)`+`::` dans `exercises/` : seuls `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales` (via `scales::label_number`) sont effectivement appelés. `quarto` (R package) sert pour `quarto::quarto_version()` au L38 de `preparatifs.qmd` — défendable. `brand.yml` et `prismatic` ne sont jamais utilisés ni mentionnés ailleurs dans le matériel — risque d'erreur d'install (CRAN install depuis une release Linux récente peut échouer sur ces paquets sans valeur ajoutée pour le tutoriel). Suggestion : retirer `brand.yml` et `prismatic` ou ajouter une justification (helper ggplot2 brand-aware, p. ex.). `rmarkdown` aussi est sans usage direct mais souvent installé en pré-requis Quarto/knitr — laisser.

### P2.4 — Bug i18n running header orange-book : déjà documenté en `.claude/issues/`, mais aucune mention pour le présentateur

Le PDF book correction garde « Chapter 1. Anatomie » / « Chapter 2. Origines » dans le running header malgré `lang: fr`. Bug confirmé upstream et issue prête (`.claude/issues/quarto-cli-orange-book-supplement-chapter-i18n.md`). Aucun fix dans le matériel attendu. À mentionner à l'oral si quelqu'un pose la question (« Pourquoi "Chapter X" et pas "Chapitre X" en haut de page ? »). Pas de fix actionnable côté repo workshop — donc pas un P1.

### P2.5 — `_brand-fallback.yml` est une copie 1:1 de `correction/_brand.yml`

Diff binaire : identiques. Le README Exo 2 (`exercises/02-projet-book/README.md:89`) le dit explicitement (« C'est une copie 1:1 de la charte utilisée dans la correction. »). Pas un problème en soi, mais cette redondance est un foot-gun de maintenance : si `correction/_brand.yml` évolue avant le 16 juin, il faudra penser à re-synchroniser. À considérer : symlink, ou un commentaire d'en-tête `# Copie de correction/_brand.yml — synchroniser à la main`.

### P2.6 — `index.qmd:37` mentionne « orange-book » en prose sans définition immédiate

```
`_quarto.yml`, `type: book`, orange-book, `_brand.yml` au niveau projet
```

C'est la première mention du terme dans le tunnel pédagogique côté participant (page d'accueil avant Bloc 2). « Orange-book » n'est défini qu'à `2-projets/index.qmd:28`. Pas un bug, juste un terme qui sort de nulle part en page d'accueil. Optionnel : retirer ce mot sur l'accueil et le laisser pour la page Bloc 2.

## Choix techniques validés

### Cohérence `format: typst`

`grep` exhaustif (sources `.qmd`/`.yml`/`.md` hors `.claude/`) : **0 occurrence** de `format: orange-book-typst` ou `extend: orange-book`. Les seuls survivants sont dans `.claude/` (notes meta, decision logs, issues drafts) — hors périmètre. La forme principale `format: typst` est utilisée dans :
- `2-projets/2-projets.qmd:19`, `:49` (slides)
- `2-projets/index.qmd:93` (modèle YAML participant)
- `exercises/02-projet-book/README.md:46` (modèle participant README)
- `1-quarto-typst/1-quarto-typst.qmd:50` (slide Bloc 1)

La forme longue `format: typst:` (avec options) est utilisée uniquement quand justifié :
- `exercises/01-document-typst/correction/rapport-starwars.qmd:4-14` (papersize, margin, mainfont, toc, number-sections, linestretch, keep-typ)
- `exercises/02-projet-book/correction/_quarto.yml:19-25` (font-paths workaround)
- `1-quarto-typst/1-quarto-typst.qmd:69-76`, `:96-100` (slides montrant les options)

### `font-paths:` placement

`exercises/02-projet-book/correction/_quarto.yml:19-25` :

```yaml
format:
  typst:
    font-paths:
      - .quarto/typst/fonts
```

Sous `format.typst:`, **pas** sous `book:` ni au top-level. Conforme. Validation empirique :
- `find .quarto/typst/fonts` → 4 TTF Orbitron+Inter dans `fonts.gstatic.com/s/{orbitron,inter}/`
- `pdffonts _book/Anatomie-d-une-saga.pdf` → `Orbitron-Bold` + `Inter-Regular` embarqués (subset)
- Render reproduit clean sur copie tmp.

### `_brand.yml` syntaxe (forme `fonts:` list + `base:` string + `logo: { images:, medium: }`)

**Cohérence transverse confirmée** :
- `exercises/01-document-typst/correction/_brand.yml` (no logo, online)
- `exercises/01-document-typst/correction/_brand-offline.yml` (no logo, source: file + files: paths)
- `exercises/02-projet-book/correction/_brand.yml` (avec `logo: { images: { sw-star: { path, alt } }, medium: sw-star }`)
- `exercises/02-projet-book/_brand-fallback.yml` (idem, copie 1:1)
- Slide Bloc 1 `1-quarto-typst/1-quarto-typst.qmd:121-130` (forme `fonts:` list + `base:` string, exemple générique avec `primary`/`secondary`)

Tous utilisent : `color: { palette:, primary:, foreground:, background: }` (sémantique) ou `color: { primary:, secondary: }` (générique pédagogique). `typography: { fonts: [list], base:, headings: }`. `logo: { images: { name: { path, alt } }, medium: name }`. Conforme blog Quarto 2026-03-31.

### Démarcation `type: book` vs `type: default`

Patterns clairement séparés dans le matériel :
- Étape 1 (Our turn + Your turn 1) : `project: { type: default }` + `format: typst` → 5 PDFs séparés (page `2-projets/index.qmd:34`, slide `2-projets/2-projets.qmd:17`, README Exo 2 `:22`).
- Étape 2a (le pivot) : `project: { type: book }` + `book: { ... }` + `format: typst` → PDF unique avec orange-book auto.
- Étape 2b : ajout d'`appendices: [annexe-donnees.qmd]`.

Le récit est cohérent entre slides, page web Bloc 2, README Exo 2 et `_quarto.yml` correction.

### Cross-refs

Labels présents et résolus :
- `tbl-anatomie-mass` → starter+correction `01-anatomie.qmd:18`
- `fig-anatomie-mass` → starter+correction `01-anatomie.qmd:48-49`
- `tbl-origines-homeworlds` → starter+correction `02-origines.qmd:16`
- `fig-origines-especes` → starter+correction `02-origines.qmd:40-41`
- `sec-origines` → starter+correction `02-origines.qmd:1` (`# Origines {#sec-origines}`)

Bonus B1 (`@fig-anatomie-mass` + `@sec-origines` à coller dans `conclusion.qmd`) référence des labels qui existent **déjà** dans le starter — le bonus n'exige aucune modification des chapitres. Bien conçu.

Render PDF correction Exo 2 (`pdftotext`) confirme : « Comme l'a montré la **Figure 1.1**, … le **Chapitre 2** … **Annexes** … **Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1** ». `lang: fr` rend bien les supplements cross-ref en français.

### `execute:` modèle YAML aligné

3 emplacements alignés sur `echo: false / warning: false / message: false` :
- `exercises/02-projet-book/correction/_quarto.yml:27-30` (correction)
- `2-projets/index.qmd:95-98` (modèle participant page web)
- `exercises/02-projet-book/README.md:48-51` (modèle participant README)

Le starter Exo 1 `:5-8` et la correction Exo 1 `:15-18` ont aussi le bloc.

### `.content-visible when-format="typst"` propre

Une seule variante utilisée, jamais l'inverse `.content-hidden when-format="html"`. Présente à 4 endroits (correction `conclusion.qmd:11`, page web `2-projets/index.qmd:68`, README Exo 2 `:76`, slide `2-projets/2-projets.qmd:84,105,119` en prose). Cohérent.

### `{{< pagebreak >}}`

Shortcode **built-in Quarto** (pas une extension), donc rien à installer. Render OK dans correction Exo 2 (saut entre conclusion et annexe visible dans le PDF 15 pages).

### Pas de chapitre fantôme YAML title + H1

Tous les chapitres de l'Exo 2 (correction et starter) suivent la convention « pas de `---` YAML, juste H1 en première ligne » :
- `01-anatomie.qmd` → `# Anatomie`
- `02-origines.qmd` → `# Origines {#sec-origines}`
- `conclusion.qmd` → `# Conclusion`
- `index.qmd` → `# Préface {.unnumbered}`
- `annexe-donnees.qmd` → `# Le dataset starwars`

Aucun risque de chapitre dupliqué TOC + page de titre.

### Pas de `format: orange-book-typst` ni `extend: orange-book` orphelin

`grep -rn "orange-book-typst|extend: orange-book"` sur sources hors `.claude/` → 0 résultat. Tout est passé sur `format: typst` (auto-activation).

### Smoke render

```
quarto render                           # Site complet → 8/8 .qmd, 0 warning
quarto render correction Exo 1          # PDF OK, warnings fonts fallback Linux attendus
quarto render correction Exo 2 (book)   # _book/Anatomie-d-une-saga.pdf (165KB, 15 pages, A4)
                                          fonts Orbitron+Inter embarquées (pdffonts)
                                          cross-refs FR localisées (pdftotext grep)
```

Aucune erreur. Warnings Typst fontes fallback (`apple color emoji`, `segoe ui`, `system-ui`, `sans-serif`) attendus côté Linux (gt fallback list par design — non bloquant).

### `_quarto.yml` website propre — aucun conflit multi-format

`_quarto.yml:29-41` déclare 2 formats (`html` + `clean-revealjs`). Toutes les pages explicites :
- `format: html` : `index.qmd`, `preparatifs.qmd`, `1-quarto-typst/index.qmd`, `2-projets/index.qmd`, `3-aller-plus-loin/index.qmd`, `4-ressources.qmd`, `exercises/01-document-typst/starter/rapport-starwars.qmd`
- `format: clean-revealjs` : `1-quarto-typst/1-quarto-typst.qmd`, `2-projets/2-projets.qmd`

Le projet website avec `render: ["**/*.qmd", "!exercises/"]` exclut bien `exercises/` du build site. `resources: ["exercises/**"]` les copie quand même → liens GitHub Pages OK pour les téléchargements.

### Liens GitHub uniformes

Tous sur `cderv/cderv-tuto-quarto-typst-rr-2026` (`grep` exhaustif). Le seul autre repo cité est `cderv/tuto-quarto-rr-2023` (antécédent, contexte historique au L159 de `README.md`).

### Conventions slides

- `format: clean-revealjs` (hérite de `_quarto.yml:36`) ✓
- `{{< countdown 15:00 >}}` shortcode (extension installée `_extensions/gadenbuie/countdown/`) ✓
- Backgrounds `{background-color="#27ae60"}` (Our turn) et `{background-color="#FDC538"}` (Your turn) — codes hex valides ✓
- Callouts `.callout-tip` titre « Faisons ensemble ! » et `.callout` titre « À vous ! » ✓
- Pépites `.callout-note` titre « Saviez-vous que… » ✓

### Quarto 1.9 features citées

`linkcolor`, `codefont`, `mathfont`, `linestretch`, `font-paths` → tous présents dans `/opt/quarto/share/schema/document-{fonts,colors}.yml`. Pas de feature inventée. La pépite « PDF accessible `pdf-standard: ua-1` » est correcte (livré 1.9). La limite « Typst books pas encore compatibles UA-1 » est documentée honnêtement (`4-ressources.qmd:155`).

## Évolution depuis la review du matin

**Ce qui s'est amélioré techniquement.**
- T1 inversion `format: orange-book-typst → format: typst` propre côté contenu (0 résidu).
- T2 `font-paths:` sous `format.typst:` validé empiriquement (TTFs trouvés, fontes embarquées, render reproduit).
- T5 pépite « heading offset h1→h2 » retirée + reformulation honnête de « template partials » (`2-projets/2-projets.qmd:127`) qui dit maintenant que `typst-show.typ` suffit souvent (orange-book n'a pas de `typst-template.typ`).
- B2 (`.content-visible` + pagebreak) extrait en bloc copiable (page web et README).
- Modèle `_quarto.yml` complet ajouté côté participant à 2 endroits cohérents (`2-projets/index.qmd:78-99` + `exercises/02-projet-book/README.md:31-52`), avec bloc `execute:` aligné sur la correction.
- Slide deck `3-aller-plus-loin` retiré (page index.qmd reste comme topic store) — pas de lien `(#)` mort détecté.
- 2 issues drafts persistées (`.claude/issues/`) cohérentes avec le matériel actuel.
- `_brand.yml` slide Bloc 1 passé en forme `fonts:` list + `base:` string (cohérent avec correction).
- Étape 2 splittée en 2a (chapitres) / 2b (appendices) — 4-fragment `code-line-numbers="1-2|4-9|10-11|13"` validé syntaxiquement.

**Ce qui était déjà bon (et l'est resté).**
- `lang: fr` sur `_quarto.yml` racine et sur `_quarto.yml` book.
- `fig-alt` partout sur les figures.
- Convention « H1 seul en début de chapitre » dans Exo 2 (5/5 chapitres).
- `_quarto.yml` racine clean, sans conflit multi-format website.
- `execute: { echo: false, warning: false, message: false }` cohérent transversalement.

**Ce qui était passé entre les mailles du matin (nouveaux signalements ici).**
- P1.1 `quarto typst gather` → `quarto call typst-gather` (4-ressources.qmd:42, fix 1 ligne).
- P2.1 inconsistance H1 (correction Exo 1) ↔ H2 (starter Exo 1) — pédagogique pas technique mais visible si quelqu'un compare.
- P2.2 `linkcolor:` valeur hex requise non précisée.
- P2.3 `brand.yml` + `prismatic` packages R inutilisés dans `preparatifs.qmd:18`.
- P2.5 `_brand-fallback.yml` copie 1:1 — risque de drift de maintenance.

**Conclusion.** Une seule correction (P1.1) à passer avant le 16 juin. Le reste est arbitrable côté CD/Maëlle (édito) ou laissable en l'état.
