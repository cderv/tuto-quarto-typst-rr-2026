# Workshop Preparation Plan

Workshop: "PDF sans frictions : Typst dans vos projets Quarto"
Event: Rencontres R 2026, 16 juin, Nantes — 2h tutorial

## Decision log

- 2026-04-07: Decided to reorganize around "My turn / Our turn / Your turn" format
- 2026-04-07: Reframed Bloc 1 entry point: "you have a doc, you want PDF" (not "switch from LaTeX")
- 2026-04-07: Created topic store with CORE/DEMO/MENTION/STORE triage of all 55 topics
- 2026-04-07: Target ratio ~30 min slides + 30 min live demo + 45 min exercises
- 2026-04-16: Restructured from 3 blocs to 2 blocs + pépites (nuggets)
- 2026-04-16: Bloc 3 content disseminated into Blocs 1 and 2 as "Saviez-vous que..." slides
- 2026-04-16: brand.yml moved to Bloc 1 (single presentation, reused in Bloc 2 exercise)
- 2026-04-16: Exercise timers set to 15:00 / 15:00
- 2026-04-16: Mode markers use Quarto callouts (callout-tip for Our turn, callout for Your turn, callout-note for pépites)
- 2026-05-02: Switched dataset from `palmerpenguins` to `dplyr::starwars` — more variety, fun outliers (Jabba mass, Yoda age, R2-D2 in 7 films), still small (87×14)
- 2026-05-02: All tables in workshop examples use `gt` (showcases Quarto's CSS→Typst translation)
- 2026-05-02: Storytelling minimal — "Qui sont les colosses de la galaxie ?" — no analytical multi-question arc; the data analysis is a stable backdrop, not a teaching topic
- 2026-05-02: R code is **frozen** in starter files (chunks invisible via `echo: false`); participants only edit YAML, `_brand.yml`, raw Typst, and project structure. Exception: `echo: true` on the R chunk that demos `theme_brand_*()` helpers (pépite Bloc 1)
- 2026-05-02: Pépite Bloc 1 raw Typst — chosen example: inline `#highlight(fill: ...)` to colour a word; opens a 1-line mention of the `quarto-highlight-text` extension as the "portable" alternative (no extension creation in this workshop)
- 2026-05-02: Pépite Bloc 1 brand-from-R — added: `library(brand.yml)` + `theme_brand_ggplot2()` + `theme_brand_gt()` integrated as a fragment in the brand slide
- 2026-05-02: Bloc 2 book has 2 real chapters (anatomie + origines) + préface (`{.unnumbered}`) + conclusion + appendix (`appendices:`). Cover-image not used (not natively supported for Typst books)
- 2026-05-02: Per-file YAML override removed from slides (was MENTION → moved to STORE)

## Current structure (implemented 2026-04-16)

### Bloc 1 — Un PDF pro en quelques minutes (~40 min)
- **My turn (~7 min):** intro rythme, format:typst, options, keep-typ, _brand.yml — 5 slides
- **Our turn (~10 min):** démo live — add typst, options, create brand, keep-typ — 1 callout slide
- **Your turn (~15 min):** exercice 1 — 1 exercise slide
- **Pépites (~3 min):** raw Typst, CSS→Typst, pdf-standard:ua-1 — 1 note slide

### Bloc 2 — Passer à l'échelle : projet et livre (~40 min)
- **My turn (~5 min):** _quarto.yml, type:book + orange-book — 2 slides
- **Our turn (~10 min):** démo live — create book, apply brand, content-visible — 1 callout slide
- **Your turn (~15 min):** exercice 2 + fallback _brand.yml — 1 exercise slide
- **Pépites (~3 min):** template partials, extensions, community formats — 1 note slide

### Totaux
- 13 slides total (was 55)
- ~90 min planned, ~30 min margin on 2h

## Content reorganization — DONE

- [x] Discuss topic store triage with Maëlle (what stays CORE, what gets cut)
- [x] Trim Bloc 1 slides: keep format:typst, basic options, keep-typ, brand basics
- [x] Trim Bloc 2 slides: keep _quarto.yml, book, orange-book — cut Marginalia, typst-gather
- [x] Bloc 3 disseminated: raw Typst → pépite B1, partials/extensions → pépite B2, rest → Ressources
- [x] Add "My turn / Our turn / Your turn" rhythm markers to slides (callouts)
- [x] Move STORE topics to resources page
- [x] Update Bloc 1 framing: "you have a doc, you want PDF" not "LaTeX bad"

## Fixes — DONE

- [x] Fix Bloc 3 missing accents (entire file rewritten)
- [x] Fix "A vous !" → "À vous !" in Blocs 2 and 3
- [x] Fix "Fini la répétition" → "Finie" in Bloc 2
- [x] Standardize callout syntax across decks
- [x] Fix raw `{=typst}` block in Bloc 3 used for display

## Exercise materials & live demos — IN PROGRESS (started 2026-05-02)

Workshop fil rouge : dataset `dplyr::starwars` (87 × 14), tableaux `gt` partout, code R figé/livré (les participants ne touchent qu'au YAML, au `_brand.yml` et au `.typ`). Storytelling minimal : **« Qui sont les colosses de la galaxie ? »** — Jabba en outlier de masse, scatter h × m comme figure phare. Punchline finale du book : les vraies stars sont les droïdes (R2-D2 dans 7 films).

**Décisions actées (validées par CD le 2026-05-02, cf. decision log) :**
- Renommage global `penguins` → `starwars` partout (slides, README, preparatifs, PLAN.md, topic-store, project-context, workshop-content)
- `echo: false` sur les chunks R d'analyse ; `echo: true`/fenced sur les chunks de **démo Quarto/Typst** (ex. pépite `theme_brand_*`)
- Bloc 2 = book à **2 chapitres réels** (option β) pour rendre orange-book + numérotation Fig 2.1 visibles
- Pépite raw Typst Bloc 1 = `#highlight()` inline (vs candidats écartés : B `#columns(2)` mention orale uniquement, C `#place(top+right)`)
- Narratif pépite raw Typst en **3 temps** : raw inline → pivot « soupape format-spécifique » → ouverture extension `quarto-highlight-text` de Mickaël Canouil (mention seulement, bonus communauté FR pour les RR Nantes)
- Pépite brand côté R = `theme_brand_ggplot2()` + `theme_brand_gt()` en **fragment de slide** Bloc 1 (option a, trace écrite)
- Per-file YAML override : **retiré** des slides (MENTION → STORE)
- Pas de `cover-image` (non supporté natif Typst → on n'en parle pas, même en pépite)

**Pièges techniques confirmés** (validés sur `/tmp/sw_typst/test.qmd`) :
- gt → Typst : espace parasite des chiffres (« 1 7 5 ») — workaround = libellés ASCII courts
- gt `tbl-cap` casse les accents (« <U+00E9> ») mais `tab_header(title=...)` à l'intérieur de gt les accepte → mettre titre dans `tab_header()`
- `theme_brand_ggplot2()` ne touche que bg/fg, pas les `geom_*` → pour le jaune SW dans les points, extraire via `brand_color_pluck(b, "primary")` et passer à `scale_color_manual()`
- Dépendances R à mentionner dans `preparatifs.qmd` : `bslib >= 0.9.0`, `brand.yml`, `prismatic` (requis par `theme_brand_ggplot2`)
- Fonts source : `google` par défaut (réseau OK), variante `file` à mentionner pour robustesse offline jour J Nantes

### Phase 1 — Renommage global penguins → starwars + mise à jour PLAN/topic-store

- [x] Grep des occurrences `penguins`/`palmer` dans `*.qmd`/`*.md`/`*.yml`
- [x] Renommer dans `preparatifs.qmd` (packages : enlever `palmerpenguins`, ajouter `dplyr`/`gt`/`brand.yml` — penser à ajouter `prismatic` aussi)
- [x] Renommer dans `1-quarto-typst/1-quarto-typst.qmd` et `1-quarto-typst/index.qmd`
- [x] Renommer dans `README.md`
- [x] Renommer dans `.claude/references/workshop-pacing.md`, `topic-store.md`, `project-context.md`
- [x] Renommer dans `.claude/skills/workshop-content.md`
- [x] Mettre à jour PLAN.md decision log avec entrées 2026-05-02
- [x] Vérifier `2-projets/2-projets.qmd`, `4-ressources.qmd`, `index.qmd` (racine), `_quarto.yml` (racine) — déjà propres, aucune occurrence
- [x] Ajouter `prismatic` + `quarto` aux packages requis dans `preparatifs.qmd` (`quarto` était utilisé par `quarto::quarto_version()` mais pas installé)
- [x] Grep final confirmé : seules mentions restantes = decision log et plan PLAN.md (légitimes)

### Phase 2 — Exo 1 : starter rapport-starwars + correction brand + raw highlight

Arborescence cible :
```
exercises/01-document-typst/
├── starter/
│   └── rapport-starwars.qmd       # format: html, R figé, à transformer
├── correction/
│   ├── _brand.yml                 # Star Wars
│   └── rapport-starwars.qmd       # format: typst + brand + #highlight()
└── README.md
```

- [ ] Starter `rapport-starwars.qmd` (~1-2 pages) :
  - YAML : `format: html`, `execute: { echo: false, warning: false }`
  - Setup chunk : `library(dplyr); library(gt); library(ggplot2); library(ggrepel)`
  - Intro : 3 lignes + question « Qui sont les colosses de la galaxie ? »
  - 1 tableau gt : top 5 par masse — `starwars |> arrange(desc(mass)) |> slice_head(n=5) |> select(name, height, mass, species, homeworld) |> gt() |> tab_header(title="Les colosses de la galaxie", subtitle="Top 5 par masse (kg)") |> fmt_number(columns=mass, decimals=0) |> cols_label(...)` — labels ASCII (workaround bug accents)
  - 1 figure : scatter `height` × `mass` (log10), Jabba étiqueté avec `ggrepel`, `fig-alt` obligatoire
  - Conclusion : 2 lignes cliffhanger (« on aimerait étendre... » → justifie Bloc 2)
  - Tout en `echo: false`
- [ ] Correction `rapport-starwars.qmd` : starter + diff = `format: typst`, `papersize: a4`, `margin: { x: 2cm, y: 2.5cm }`, `mainfont: Inter`, `toc: true`, `number-sections: true`, `linestretch: 1.4`, `keep-typ: true`
- [ ] Correction `_brand.yml` :
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
- [ ] Insérer la pépite raw Typst dans la correction, **inline**, juste après le tableau :
  ```markdown
  Les vraies stars de la saga sont les `#highlight(fill: rgb("#FFE81F"))[droïdes]`{=typst} : R2-D2 apparaît dans 7 films, plus que n'importe quel humain.
  ```
- [ ] Variante `_brand.yml` source `file` à mentionner en pépite (robustesse offline jour J), pas livrée par défaut
- [ ] README.md : 4 étapes (`format: typst` → options → `keep-typ` → brand), countdown 15-20 min

### Pause validation — vérifier le format de l'Exo 1 avec CD

- [ ] STOP avant Phase 3, render la correction localement, capture du PDF
- [ ] Demander à CD si le format starter/correction/README convient avant de dérouler l'Exo 2

### Phase 3 — Exo 2 : book starter + correction avec _quarto.yml + _brand.yml

Arborescence cible (correction) :
```
exercises/02-projet-book/correction/
├── _quarto.yml         # type:book + chapters + appendices
├── _brand.yml          # déplacé depuis Bloc 1
├── scripts/
│   ├── 01-anatomie.R   # tableau gt + figure (figés, sourcés depuis le .qmd)
│   └── 02-origines.R   # tableau gt + figure (figés)
├── index.qmd           # # Préface {.unnumbered}
├── 01-anatomie.qmd     # = rapport Bloc 1 → Tab 1.1, Fig 1.1, raw #highlight()
├── 02-origines.qmd     # NOUVEAU contenu R figé → Tab 2.1, Fig 2.1
├── conclusion.qmd      # cross-refs + .content-visible pagebreak
└── annexe-donnees.qmd  # listé dans appendices: → A.1
```

- [ ] `_quarto.yml` :
  ```yaml
  project:
    type: book
  book:
    title: "Anatomie d'une saga"
    subtitle: "Portrait statistique des personnages de Star Wars"
    author: "Christophe Dervieux"
    date: "2026-06-16"
    chapters:
      - index.qmd
      - 01-anatomie.qmd
      - 02-origines.qmd
      - conclusion.qmd
    appendices:
      - annexe-donnees.qmd
  format: typst
  ```
- [ ] `index.qmd` : `# Préface {.unnumbered}` + 5 lignes
- [ ] `01-anatomie.qmd` : rapport Bloc 1 réutilisé (top masses + scatter) + raw `#highlight()` inline, label `@fig-anatomie-mass`
- [ ] `02-origines.qmd` : contenu R figé NOUVEAU — 10-15 lignes (`count(homeworld)` + gt top 10, `count(species)` + barplot ggplot col), labels `@tbl-origines-homeworlds`, `@fig-origines-especes`
- [ ] `conclusion.qmd` : punchline droïdes + 2 cross-refs (`@fig-anatomie-mass`, `@sec-origines`) + bloc `::: {.content-visible when-format="typst"} {{< pagebreak >}} :::`
- [ ] `annexe-donnees.qmd` : description du dataset (87×14, source dplyr)
- [ ] Starter book : les 5 `.qmd` déjà découpés mais **sans** `_quarto.yml` ni `_brand.yml`. Tâches participants :
  1. Créer `_quarto.yml` `type: default` + `format: typst`, render
  2. Passer en `type: book`, render → orange-book
  3. Déplacer `_brand.yml` du Bloc 1 à la racine, render
  4. Bonus : cross-ref dans conclusion
  5. Bonus 2 : saut de page `.content-visible`
- [ ] `exercises/02-projet-book/_brand-fallback.yml` pour ceux qui n'ont pas fini Exo 1
- [ ] README.md exo 2

### Phase 4 — demos/01-bloc1/ + demos/02-bloc2/ scripts pas-à-pas

- [ ] `demos/01-bloc1/README.md` — script de démo Bloc 1 (5 étapes, ~10 min) :
  1. Remplacer `format: html` par `format: typst`, render
  2. Ajouter `papersize`, `margin`, `toc`, `mainfont`
  3. Activer `keep-typ: true`, ouvrir le `.typ` (moment « aha »)
  4. Créer `_brand.yml` (palette SW + Orbitron + Inter), re-render
  5. Pépite live : `library(brand.yml); read_brand_yml() |> theme_brand_ggplot2()` → ggplot brandé
- [ ] `demos/02-bloc2/README.md` — script de démo Bloc 2 (7 étapes, ~10 min) :
  1. Créer `_quarto.yml` minimal `type: default` + `format: typst`
  2. Découper rapport en `index.qmd` + `01-anatomie.qmd`
  3. Ajouter `02-origines.qmd` livré tout fait, l'inclure dans `chapters:`
  4. Passer `type: default` → `type: book`, render → orange-book + Fig 2.1
  5. Cross-ref `@fig-anatomie-mass` dans conclusion → *Fig 1.1*
  6. Saut de page conditionnel `.content-visible when-format="typst"` + `{{< pagebreak >}}`
  7. Mention `appendices:` + `# Préface {.unnumbered}`

### Phase 5 — slides : pépite R Bloc 1 + retrait per-file override

- [ ] Dans `1-quarto-typst/1-quarto-typst.qmd`, ajouter un fragment incremental sur le slide brand.yml avec :
  ```r
  library(brand.yml)
  b <- read_brand_yml()
  ggplot(...) + ... + theme_brand_ggplot2(b)   # plot brandé
  table |> theme_brand_gt(b)                   # gt brandé
  ```
  Narratif : « un fichier `_brand.yml`, partout : PDF Typst, HTML preview, ggplot, gt »
- [ ] Saviez-vous que : `brand_color_pluck(b, "primary")` retourne `"#FFE81F"` → réutilisable dans `scale_color_manual(values=...)` (pas de `scale_color_brand_*` auto pour l'instant)
- [ ] Retirer le slide/mention « per-file YAML override » dans `2-projets/2-projets.qmd` (MENTION → STORE ; passer en page ressources si besoin)
- [ ] Mettre à jour la pépite raw Typst Bloc 1 avec le narratif 3 temps : raw inline → pivot « soupape format-spécifique » → ouverture `quarto-highlight-text` de Mickaël Canouil (https://github.com/mcanouil/quarto-highlight-text), mention seulement, renvoi vers pépite extension Bloc 2

### Phase 6 — render des corrections, validation visuelle

- [ ] `quarto render exercises/01-document-typst/correction/` → ouvrir le PDF, vérifier :
  - Fonts Orbitron (titre) + Inter (corps) chargées
  - Background crème, jaune SW visible
  - `#highlight()` jaune sur « droïdes »
  - Tableau gt rendu (libellés ASCII courts → pas de bug espacement chiffres)
- [ ] `quarto render exercises/02-projet-book/correction/` → vérifier :
  - Page de garde orange-book (titre/sous-titre/auteur/date/fond brandé)
  - Préface non-numérotée
  - Chapitres 1 et 2 numérotés, Fig 1.1, Fig 2.1, Tab 1.1, Tab 2.1
  - Cross-refs résolues dans conclusion
  - Saut de page conditionnel
  - Annexe A
- [ ] Render starter Exo 2 brut (sans `_quarto.yml`) pour confirmer que le starter est cohérent
- [ ] Slides : `quarto preview` sur Bloc 1 et Bloc 2, vérifier le fragment R + retrait per-file override

### Phase 7 — commit + push branch claude/explore-starwars-dataset-D8a4k

- [ ] `git status` + `git diff` final
- [ ] Commits par phase (P1 déjà commité dans `9e726b6`) : Exo 1, Exo 2, démos, slides
- [ ] Push `claude/explore-starwars-dataset-D8a4k`
- [ ] (Sur demande explicite uniquement) ouvrir PR avec récap des 6 phases

## Documentation updates — DONE

- [x] Update `.claude/references/project-context.md` after slide reorganization
- [x] Update `.claude/PLAN.md` with new structure
- [x] Resources page enriched with all STORE topics + ex-Bloc 3 content

## Pre-workshop logistics — TODO

- [ ] Test full workshop flow end-to-end (setup → exercises → wrap-up)
- [ ] Test exercises on a clean machine
- [ ] Prepare Posit Cloud workspace as fallback
- [ ] Confirm exercise timing with dry run
- [ ] Pre-render demo outputs as backup screenshots

## References

- Plan de restructuration détaillé: `/root/.claude/plans/wiggly-mixing-giraffe.md`
- Topic store: `.claude/references/topic-store.md`
- Pacing guidelines: `.claude/references/workshop-pacing.md`
- Project context: `.claude/references/project-context.md`
