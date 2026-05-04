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
- 2026-05-02: **Exo 1 = doc standalone (PAS de `_quarto.yml`)**, **Exo 2 = projet Quarto book** (`_quarto.yml type: book`). Cohérent avec narratif Bloc 1 (`.qmd` → PDF) → Bloc 2 (passer à l'échelle projet).
- 2026-05-02: **Découverte Q2 — `_brand.yml` n'est lu que dans un projet Quarto**. Sans `_quarto.yml`, brand colors ET brand fonts sont ignorées. Conséquence pour Exo 1 standalone : stratégie fonts à trouver (cf. décisions Q2 dans PLAN). **⚠️ INFIRMÉ 2026-05-02 (re-test) : voir ligne suivante.**
- 2026-05-02: **CORRECTION ligne précédente — `_brand.yml` fonctionne PARFAITEMENT en standalone** (Quarto 1.9.36 + R 4.6.0). Re-test exhaustif avec env propre (gh CLI + rig + R) sur 3 scénarios : (1) standalone sans `_quarto.yml`, (2) projet `type: default`, (3) projet website parent + `!exercises/` excluant le sous-dossier `_brand.yml`. **Les 3 produisent le même `.typ` identique** : brand colors lues (`brand-color.primary: rgb("#ffe81f")`), brand fonts lues (`font: ("Inter",)`, `heading-family: ("Orbitron",)`), fonts Google téléchargées dans `.quarto/typst/fonts/fonts.gstatic.com/s/{inter,orbitron}/`, aucun warning. **L'observation initiale était erronée** — probablement liée à un cache obsolète, à `source: bunny` (cf. ligne 27 où le bug bunny est confirmé), ou à un état de dev intermédiaire. Conséquence : **les 4 options A/B/C/D pour Exo 1 ne sont plus contraintes par cette fausse limite**. `_brand.yml` peut rester en Exo 1 standalone sans complication.
- 2026-05-02: **Bug `_brand.yml source: bunny` confirmé Quarto 1.9.36 / Typst 0.14.2** : avec un projet Quarto local et `source: bunny`, brand colors lues mais fonts non téléchargées vers `.quarto/typst/fonts/`. Aucun warning d'erreur, fallback silencieux. À comparer : `source: google` même config → fonts téléchargées dans `fonts.gstatic.com/s/inter/v20/...`. **À reporter à l'équipe Quarto** (CD est la bonne personne).
- 2026-05-02: **CORRECTION ligne précédente — diagnostic affiné via re-test (env propre, gh CLI + rig + R 4.6.0)** : `source: bunny` n'est **pas un bug silencieux** — Quarto émet explicitement « Font bunny is not yet supported for Typst, skipping Inter/Orbitron » et Typst suit avec `warning: unknown font family: inter/orbitron`. **C'est une feature manquante côté Quarto** (`bunny` reconnu dans `_brand.yml` mais le pipeline Typst ne l'implémente pas encore). **Conséquence atelier : on reste sur `source: google` partout** (qui fonctionne, télécharge bien les fonts dans `.quarto/typst/fonts/fonts.gstatic.com/s/...`). À mentionner en pépite ou notes presenter comme une limite actuelle, pas comme un bug à reporter.
- 2026-05-02: **Q2 tranchée = (b)** — `opt_table_font("Inter")` UNIQUEMENT dans la correction Exo 1, **PAS dans le starter**. Le bug d'espacement chiffres `gt → Typst` (« 1 7 5 ») se manifeste donc en live chez les participants Windows/macOS pendant l'exo → sert de **moment pédagogique** : « regardez ce qui sort, voici le workaround ». La correction montre le fix propre (`opt_table_font("Inter")`). Mention rapide à intégrer en notes presenter du Bloc 1 pour outiller l'animation. État disque déjà conforme (commit `20bde0c`).
- 2026-05-02: **Test `source: file` confirmé OK** (env propre, standalone) avec **TTFs statiques** (Inter-Regular/SemiBold/Bold + Orbitron-Regular/Bold récupérés depuis le cache `.quarto/typst/fonts/` après un render `source: google`). Aucun warning, `.typ` propre. ⚠️ **Variable fonts (Inter[wght].ttf, Orbitron[wght].ttf) → Typst émet `warning: variable fonts are not currently supported`** : utiliser exclusivement des TTFs statiques pour `source: file`. `InterVariable.ttf` retiré du repo en conséquence (non référencé, source de warnings).
- 2026-05-02: **Décision stratégie fonts atelier** : `source: google` par défaut partout (correction Exo 1, Exo 2, démos), avec un **Plan B `source: file` shippé** dans `exercises/01-document-typst/correction/_brand-offline.yml` + `_fonts/` (5 TTFs statiques, ~1.3 MB). Couvre le risque réseau jour J Nantes (cf. review pédago). Bunny mentionné en pépite ou notes presenter comme limite actuelle Quarto, **pas utilisé** pour le rendu.
- 2026-05-02: **4-options Exo 1 tranchées = C-light** — `_brand.yml source: google` reste **dans Exo 1** (puisque la fausse limite « standalone ne marche pas » est levée). Cohérent avec le narratif Bloc 1 « doc → PDF stylé en un fichier ». Plan B offline fourni à part dans `correction/_brand-offline.yml` + `_fonts/`. Pas de nouvelle complexité dans le starter ; participants créent leur propre `_brand.yml` à l'étape 3 de l'exo (consigne actuelle inchangée).
- 2026-05-04: **Commit 1 Exo 2 livré** (skeleton `02-projet-book/correction/`). Deux corrections importantes vs plan initial :
  1. **`extend: orange-book` est une clé fictive** — n'existe pas dans le schema Quarto, ignorée silencieusement. La vraie syntaxe documentée par l'extension orange-book (`/opt/quarto/share/extension-subtrees/orange-book/_extensions/orange-book/_extension.yml` + README) est **`format: orange-book-typst`**. Test empirique : 3 PDFs visuellement identiques avec/sans `extend:` ou avec `format: orange-book-typst` (Quarto 1.9 applique aussi orange-book par défaut quand `project.type: book` + `format: typst`). Choix final : `format: orange-book-typst` (explicite + correct).
  2. **Bug Quarto book brand fonts** — Quarto télécharge bien Inter/Orbitron dans `.quarto/typst/fonts/` (via `resolveExtras` → `fontdirs.add(font_cache)` → `format.metadata['font-paths'].push`, cf. `quarto.js:129892`) mais cette mutation **ne propage pas** au call site `typstCompile` en mode book. Strace confirme : seul `--font-path /opt/quarto/share/formats/typst/fonts` (Font Awesome bundled) est passé à typst, sans le brand cache. Conséquence : warning `unknown font family: orbitron` + headings body en serif fallback. Workaround retenu dans `_quarto.yml` : `format: orange-book-typst: { font-paths: [.quarto/typst/fonts] }` — strace post-fix confirme les 2 paths passés, Orbitron s'applique sur tous les headings du body. **À reporter en issue Quarto upstream** (voisinages connus : #13548, #11929, #7580). CD est la bonne personne.
  3. PDF correction validé visuellement (15 pages) : cover orange-book + logo SW étoile jaune + bandeau jaune + Mon Mothma + Préface en Orbitron + 1.Anatomie/1.1/1.2 en Orbitron avec numéros jaune SW + numérotation chap 1 = 1 (préface unnumbered respectée). Cover titre+auteur restent en serif (template orange-book gère sa propre typo cover, indépendant de `#show heading`) — limite acceptable.
- 2026-05-04: **Commit 1 livré sur branche `claude/quarto-book-skeleton-qeDNI`** (commits `1b39468` skeleton + `7b0ac7e` workaround font-paths). Plan original mentionnait `claude/add-missing-content-4CdHE` mais cette branche a été mergée → branche actuelle = celle prévue par le harness pour cette session.
- 2026-05-04: **Commits 2-5 livrés sur même branche** (commits `43c1de8` + `3b5273b` + `ff2cbd3` + `b7f18ab` + `7e7ffde`). Findings cumulés :
  1. **Convention Quarto book chapitres** : pas de `title:` YAML sur les chapitres — seulement `# H1 {#sec-...}`. Sinon Quarto crée un chapitre fantôme depuis le YAML title et décale la numérotation (« 1 Anatomie » devient « 2 Anatomie »). Découvert au Commit 2 sur `02-origines.qmd`. Convention non documentée explicitement par Quarto mais cohérente avec tous les exemples books de la doc.
  2. **`lang: fr` partial sur orange-book** : Quarto traduit cross-refs (« la Figure 1.1 », « le Chapitre 2 ») et appendices separator (« Annexes »), mais le **running header** orange-book reste « Chapter 1. Anatomie ». Bug confirmé sur HEAD `quarto-dev/quarto-cli` via `gh api` — `typst-show.typ` ne pipe pas `crossref-ch-prefix` à `supplement-chapter`. Brouillon issue prêt : `.claude/issues/quarto-cli-orange-book-supplement-chapter-i18n.md` (3 commits : `c123634` + `ec2ac1b` + `e6570dc`). Path subtree confirmé : `src/resources/extension-subtrees/orange-book/_extensions/orange-book/`. Numéros lignes confirmés : `lib.typ:311` (book params), `lib.typ:419` (set heading supplement). À ouvrir côté `quarto-dev/quarto-cli` (pas de double-tracking via `quarto-ext/orange-book`).
  3. **Q4 (accent ggplot) résolue** : `LANG=C.UTF-8 LC_ALL=C.UTF-8` au render suffit (sandbox Linux container minimal). Pas de `Sys.setlocale()` à imposer côté participants.
  4. **Factuel data confirmé au render** : Naboo (11) > Tatooine (10) en homeworlds (j'avais initialement écrit Tatooine en tête, à reverify), Human top 1 / Droid top 2 espèces, Jabba 1358 kg.
  5. **3 retraits ciblés starter Commit 4** (idempotents avec spec plan) : `opt_table_font` ×2 (01 et 02 — bug gt visible volontairement à l'étape 3), cross-refs+pagebreak conclusion ×1 (contenu des bonus B1/B2). Labels conservés dans starter (cibles bonus).
  6. **Slides Bloc 2 reformulées** (Commit 5) : 3 core (12 min) + 2 bonus (3 min, B1/B2). Notes presenter : (a) bug gt « 1 7 5 » Windows/macOS + workaround `opt_table_font`, (b) prioriser B1 (cross-refs, cibles déjà dans starter) avant B2 (pagebreak) pour les rapides. Smoke test render racine 9/9 OK.
  7. **`gh` CLI dispo dans la sandbox Claude Code on the web** (auth `cderv` via `GH_TOKEN`). Préférable à WebFetch pour tout fetch GitHub — line numbers exacts via `grep -n`, pas d'intermédiaire de conversion HTML→markdown. Mémo pour sessions suivantes.

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

- [x] Starter `rapport-starwars.qmd` (~1-2 pages) :
  - YAML : `format: html`, `execute: { echo: false, warning: false }`
  - Setup chunk : `library(dplyr); library(gt); library(ggplot2); library(ggrepel)`
  - Intro : 3 lignes + question « Qui sont les colosses de la galaxie ? »
  - 1 tableau gt : top 5 par masse — `starwars |> arrange(desc(mass)) |> slice_head(n=5) |> select(name, height, mass, species, homeworld) |> gt() |> tab_header(title="Les colosses de la galaxie", subtitle="Top 5 par masse (kg)") |> fmt_number(columns=mass, decimals=0) |> cols_label(...)` — labels ASCII (workaround bug accents)
  - 1 figure : scatter `height` × `mass` (log10), Jabba étiqueté avec `ggrepel`, `fig-alt` obligatoire
  - Conclusion : 2 lignes cliffhanger (« on aimerait étendre... » → justifie Bloc 2)
  - Tout en `echo: false`
- [x] Correction `rapport-starwars.qmd` : starter + diff = `format: typst`, `papersize: a4`, `margin: { x: 2cm, y: 2.5cm }`, `mainfont: Inter`, `toc: true`, `number-sections: true`, `linestretch: 1.4`, `keep-typ: true`
- [x] Correction `_brand.yml` :
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
- [x] Insérer la pépite raw Typst dans la correction, **inline**, juste après le tableau :
  ```markdown
  Les vraies stars de la saga sont les `#highlight(fill: rgb("#FFE81F"))[droïdes]`{=typst} : R2-D2 apparaît dans 7 films, plus que n'importe quel humain.
  ```
- [x] ~~Variante `_brand.yml` source `file` à mentionner en pépite~~ → **réalisé différemment 2026-05-02** : Plan B complet shippé (`correction/_brand-offline.yml` + `_fonts/` 5 TTFs statiques) + section dédiée dans `preparatifs.qmd` (cf. decision log lignes 31-32)
- [x] README.md : 4 étapes (`format: typst` → options → `keep-typ` → brand)

### ~~Pause validation — vérifier le format de l'Exo 1 avec CD~~ — **CADUQUE 2026-05-02**

Cette pause est désormais résolue par les **2 reviews** lancées sur l'état courant (cf. `review.md` à la racine du repo : pédagogique + participant·e). Les retours sont consolidés dans la section « Reste à faire (priorisé) » plus bas.

- [x] Render la correction localement, PDF capturé (98 KB, 2 pages)
- [x] ~~Demander à CD si le format starter/correction/README convient~~ → **superseded par reviews** (`review.md`, 2026-05-02)

**Observations à plat (render Exo 1 correction) — ⚠️ partiellement invalidées par re-test env propre :**
- ✅ TOC + numérotation + cross-refs Table 1 / Figure 1 fonctionnent
- ✅ `#highlight(fill: rgb("#FFE81F"))[droïdes]` rendu en jaune SW dans le PDF — pépite raw inline opérationnelle
- ✅ Bug **espacement chiffres dans gt** : confirmé sur Win/macOS, workaround `opt_table_font("Inter")` appliqué dans la correction (Q2 = (b) tranchée, decision log ligne 30)
- ⚠️ ~~Background crème du brand non appliqué~~ → **observation périmée** : re-test 2026-05-02 montre que brand colors sont bien lues (`brand-color.background: rgb("#f5f0e1")`) ; à re-vérifier sur le PDF final
- ⚠️ ~~Police Inter pas chargée (warnings unknown font family)~~ → **observation périmée** : la fausse claim « standalone ne marche pas » est levée (decision log ligne 27). Inter et Orbitron téléchargées correctement dans `.quarto/typst/fonts/` au render
- ❓ Accent cassé dans label ggplot axe Y : Q4 toujours ouverte (cf. section « Questions ouvertes » consolidée plus bas)

**4 questions ouvertes (historique) — état au 2026-05-02 :**

1. ~~Format starter / correction / README Exo 1~~ → ✅ **résolu** par reviews (`review.md`)
2. **Bug espacement chiffres gt → Typst** : ✅ **TRANCHÉ 2026-05-02** : bug connu (quarto-cli#11683 ; fix structurel gt#1500 `as_typst()` v0.12.0). Workaround officiel `gt::opt_table_font(font = "Inter")` (decision log Q2 = (b)).
   → **Contexte CD** : développe sur **Windows** → bug visible (Segoe UI dans fallback gt). Sur Linux pur (sandbox), invisible (aucun fallback résolu). Sur macOS, visible via Apple Color Emoji.
3. ~~Brand non appliqué (background + Inter)~~ → ✅ **résolu 2026-05-02** : la cause supposée (« standalone ne déclenche pas le download fonts ») était une fausse claim. Re-test env propre confirme que `source: google` télécharge Inter+Orbitron correctement (cf. decision log ligne 27).
4. **Accent cassé label ggplot axe Y** (« Masse (kg, <U+00E9>chelle log) ») : régler via `Sys.setlocale()` dans le chunk setup, ou corriger l'environnement de dev ? → ⏳ **EN ATTENTE** (cf. section « Questions ouvertes » consolidée plus bas).

**Pépite ajoutée au matériel atelier (à intégrer Bloc 1) — « Typst CSS »** :
- Source : Quarto 1.5 release notes (2024-07-11), doc dédiée https://quarto.org/docs/advanced/typst/typst-css.html
- Mécanisme : Quarto `juice` les tables HTML brutes (inline les CSS via stylesheet) → un filtre post-process traduit chaque attribut HTML+propriété CSS en attribut `typst:property` ou `typst:text:property` → le Typst writer de Pandoc émet du **code Typst natif stylisé**.
- C'est ÇA qui permet à `gt` (qui sort uniquement du HTML+CSS) de produire des tables Typst natives stylisées — pas de hack, c'est un pipeline officiel.
- Narratif atelier : « pourquoi gt marche pour Typst alors qu'il sort du HTML ? Parce que Quarto a un compilateur CSS→Typst (depuis 1.5). Limites actuelles documentées (#11683 — letter-spacing parasite sur fallback de fonts, workaround `opt_table_font()`). Solution structurelle en cours côté gt v0.12.0 (`as_typst()` natif). »
- À placer dans la pépite Bloc 1 (« Saviez-vous que... CSS→Typst »).

**~~Cause racine identifiée (2026-05-02)~~ — ⚠️ INVALIDÉE le même jour par re-test env propre.** Voir decision log ligne 27 : `_brand.yml` fonctionne en standalone, la fausse claim a été générée par un état de dev intermédiaire (cache obsolète ou autre).

**Décision Exo 1 vs Exo 2 (état actuel) :**
- **Exo 1 = standalone** (`exercises/01-document-typst/correction/`) → pas de `_quarto.yml`. **`_brand.yml source: google` fonctionne nativement** (téléchargement fonts dans `.quarto/typst/fonts/`).
- **Exo 2 = projet Quarto book** (`exercises/02-projet-book/correction/`) → `_quarto.yml type: book` + `_brand.yml source: google` réutilisé (promu au niveau projet) + workaround `opt_table_font("Inter")` pour le bug gt.

**~~Question résiduelle 4-options A/B/C/D~~ → ✅ TRANCHÉE 2026-05-02 = C-light** (decision log ligne 33) : `_brand.yml source: google` reste dans Exo 1, Plan B offline `source: file` shippé à part (`correction/_brand-offline.yml` + `_fonts/`). Pas de complexité ajoutée au starter.

**État disque actuel (HEAD) :**
- `_quarto.yml` racine : `project.render: ["**/*.qmd", "!exercises/"]` + `project.resources: ["exercises/**"]` → website ne rend pas les exos mais copie leurs sources dans `_site/exercises/` pour téléchargement.
- `exercises/01-document-typst/correction/_brand.yml` : `source: google` (Inter + Orbitron) — **fonctionne en standalone**.
- `exercises/01-document-typst/correction/_brand-offline.yml` : Plan B `source: file` pointant vers `_fonts/`.
- `exercises/01-document-typst/correction/_fonts/` : 5 TTFs **statiques** (~1.3 MB) — Inter-Regular/SemiBold/Bold + Orbitron-Regular/Bold. Variable fonts retirées (cassent Typst).
- `exercises/01-document-typst/correction/rapport-starwars.qmd` : `opt_table_font(font = "Inter")` (workaround gt → Typst).
- `exercises/01-document-typst/starter/rapport-starwars.qmd` : pas de `opt_table_font` (Q2 = (b), bug visible en live → moment péda).

## Questions ouvertes (consolidées au 2026-05-02)

Toutes les autres questions historiques (Q1 séquencement reviews, Q2 `opt_table_font`, 4-options Exo 1, Q3 brand non appliqué, et Q4 ci-après pour partie) ont été tranchées dans le decision log. Restent **deux** questions actives :

**Q3 — Pépite « Typst CSS » (Quarto 1.5+, pipeline gt HTML → Typst native)** : où placer cette pépite ?
- (a) **Bloc 1** : tôt = mieux, on explique pourquoi gt marche dès qu'on l'utilise dans Exo 1. Cohérent avec « on a une table dans le rapport, voilà comment Quarto la transforme ».
- (b) **Bloc 2** : avec le brand (qui devient la grosse nouveauté Bloc 2). Permet de regrouper « tout ce qui est CSS-like ».
- → ⏳ **EN ATTENTE CD** (reco Claude : (a) Bloc 1, en mention orale intégrée à la pépite gt existante plutôt qu'en slide nouvelle, pour éviter la surcharge des 3 pépites Bloc 1 actuelles).

**Q4 — Accent cassé label ggplot axe Y** : « Masse (kg, <U+00E9>chelle log) ». Régler côté setup R des participants ou corriger l'environnement de dev ?
- → ✅ **TRANCHÉE 2026-05-04** : régler côté **environnement** via `LANG=C.UTF-8 LC_ALL=C.UTF-8` au render (preflight sandbox + commande de render). Tous les accents passent (axe Y ggplot, table gt, prose). Pas de `Sys.setlocale()` à imposer côté participants. À documenter dans `preparatifs.qmd` comme rappel : Linux container minimal nécessite locale UTF-8 explicite.

## Reste à faire (priorisé)

### P0 — Validation visuelle du Plan B et des deux corrections (rapide)

- [ ] Render `exercises/01-document-typst/correction/rapport-starwars.qmd` avec l'env actuel (R 4.6.0, packages installés via `pak`) → vérifier visuellement le PDF (background crème, jaune SW sur droïdes, gt sans bug espacement, accent label ggplot)
- [ ] Render avec `_brand-offline.yml` renommé en `_brand.yml` → confirmer que le PDF Plan B est identique au PDF online
- [ ] Si l'accent ggplot persiste, trancher Q4 (locale R ou autre)

### P1 — Phase 3 : Exo 2 book (le plus gros morceau)

**Plan détaillé prêt** (à reprendre tel quel à la prochaine session) : `.claude/plans/exo2-book.md` — reviewed pédagogiquement + techniquement (context7 Quarto). Décisions actées :
- **3 core (12 min) + 2 bonus** (cross-ref + pagebreak) — reframé depuis « 5 étapes en 15 min » (timing trop serré)
- `_quarto.yml` : `format: orange-book-typst` **explicite** (vraie syntaxe doc extension — `extend: orange-book` initialement proposé est fictif, ignoré silencieusement) + `font-paths: [.quarto/typst/fonts]` (workaround bug brand fonts non passées en book)
- `_brand.yml` book : variante avec `logo: { images: { sw-star: { path } }, medium: sw-star }` (syntaxe `images:` documentée pour books — blog Quarto 2026-03-31)
- Auteur book : **Mon Mothma** (ton sérieux, alternative ludique C-3PO)
- Conclusion **numérotée** (chap 3, pas `{.unnumbered}`)
- 5 commits granulaires (squelette → contenu R → cross-refs → starter+READMEs → slides Bloc 2 + notes presenter)

**Progression** :
- [x] Commit 0 — Persistance plan dans `.claude/plans/exo2-book.md` + référence dans `PLAN.md` (commit `d32e51e`)
- [x] Commit 1 — Squelette `02-projet-book/correction/` + workaround font-paths (commits `1b39468` + `7b0ac7e` + `66bda27` correction `extend:` fictif → `format: orange-book-typst`). 3 vérifs render OK : orange-book appliqué, logo SW visible (cover crème + bandeau jaune + Mon Mothma + étoile), numérotation chap 1 = 1 (préface unnumbered respectée).
- [x] Commit 2 — Contenu R 01-anatomie + 02-origines (commits `43c1de8` + `3b5273b` fix). Porting Bloc 1 + nouveau gt+barplot. **Découverte au render** : YAML `title:` + `# H1` body crée un chapitre fantôme → décale numérotation. Convention Quarto book retenue : **H1 seul, pas de YAML title** sur les chapitres. Factuel data confirmé : Naboo (11) > Tatooine (10), Human top 1 / Droid top 2 espèces, Jabba 1358 kg.
- [x] Commit 3 — Cross-refs + `.content-visible when-format="typst"` + `{{< pagebreak >}}` + annexe finale + `lang: fr` ajouté à `_quarto.yml` (commit `ff2cbd3`). Render validé : « la Figure 1.1 », « le Chapitre 2 », « Annexes » traduits. **Limite identifiée** : running header orange-book reste « Chapter X. » en anglais — bug confirmé sur HEAD `quarto-dev/quarto-cli` via `gh api` (typst-show.typ ne pipe pas `crossref-ch-prefix` à `supplement-chapter`). Brouillon issue prêt dans `.claude/issues/quarto-cli-orange-book-supplement-chapter-i18n.md` (commits `c123634` + `ec2ac1b` + `e6570dc`).
- [x] Commit 4 — `starter/` dérivé (5 .qmd, 3 retraits ciblés : `opt_table_font` ×2, cross-refs+pagebreak conclusion ×1) + `_brand-fallback.yml` (copie 1:1) + `README.md` racine Exo 2 (3 core + 2 bonus en tableau) + `starter/README.md` 4 lignes safety net (commit `b7f18ab`). Labels `tbl-anatomie-mass`, `fig-anatomie-mass`, `tbl-origines-homeworlds`, `fig-origines-especes`, ancre `#sec-origines` conservés dans le starter (cibles bonus).
- [x] Commit 5 — Slides Bloc 2 reformulées (commit `7e7ffde`). `2-projets/index.qmd` : Section Our turn 3 étapes + bloc Exercice en 2 tableaux 3 core / 2 bonus avec colonne « Vous devriez voir ». `2-projets/2-projets.qmd` : slides Faisons ensemble! et À vous! cohérentes 3 core + 2 bonus (B1/B2). **Notes presenter ajoutées** : (a) bug gt « 1 7 5 » Windows/macOS + workaround opt_table_font, (b) prioriser B1 (cross-refs) avant B2 (pagebreak) pour les rapides. Mentions « (matériel finalisé avant le 16 juin) » retirées (matériel livré). Smoke test render racine 9/9 OK.
- [x] Commit 6 — Cocher items Phase 3 dans PLAN.md + decision log final (ce commit).

**Note narrative à propager** : `_brand.yml` n'est plus « déplacé » depuis Bloc 1 → il est **réutilisé/promu au niveau projet** (le starter Exo 2 part SANS `_brand.yml` et l'étape 3 demande de copier celui de Exo 1 à la racine du book).

### P2 — Cluster 3 reviews (issus de `review.md`)

- [ ] **Wrap-up Bloc 2** : ajouter 3 slides (récap fin Bloc 1, next steps + ressources fin Bloc 2, Q&A) — ~5 min, gain pédagogique le plus important.
- [ ] **Objectifs d'apprentissage SMART** en haut de chaque page de bloc (`1-quarto-typst/index.qmd`, `2-projets/index.qmd`).
- [ ] **Rééquilibrage timing** : Bloc 1 Our turn 10→12 min, Bloc 2 My turn 5→8 min (marge dispo).
- [x] **Lien Exo 2 actuellement 404** dans `2-projets/index.qmd:44` — résolu 2026-05-04 (matériel livré Commit 4 ; mention « (matériel finalisé avant le 16 juin) » retirée du texte Commit 5). Le lien `tree/main/exercises/02-projet-book/starter/` résoudra naturellement après merge de la branche `claude/quarto-book-skeleton-qeDNI` sur `main`.
- [ ] **Trancher Q3** (placement pépite Typst CSS) → si (a) en mention orale, ajouter dans notes presenter de la pépite gt Bloc 1.

### P3 — Phase 4 : scripts de démo `demos/01-bloc1/` + `demos/02-bloc2/`

Cf. section « Phase 4 » plus haut.

### P4 — Phase 5 : enrichissement slides

- [ ] Fragment R `library(brand.yml) + theme_brand_*` dans la slide brand.yml Bloc 1.
- [ ] Narratif « 3 temps » de la pépite raw Typst (raw inline → soupape format-spécifique → ouverture `quarto-highlight-text` de Mickaël Canouil).
- [ ] Retirer per-file YAML override déjà acté (à vérifier dans l'état actuel des slides).

### P5 — Phase 6 : render des deux corrections + validation visuelle

Cf. section « Phase 6 ».

### P6 — Pre-workshop logistics

Cf. section « Pre-workshop logistics — TODO » en bas du fichier.

### Reco Claude (post-cleanup)

**Prochaine session — point d'entrée** : `.claude/plans/exo2-book.md` (plan Exo 2 commit-par-commit, reviewed). Démarrer **directement par Commit 1** (squelette correction + render check). P0 (validation visuelle Exo 1 dans env propre) peut s'intercaler en pré-flight ~30 min, ou être différé si urgence Exo 2.

Une fois P1 livré → débloquer P2 lien 404 + P3 démos. Le cluster 3 reviews (P2) peut s'intercaler en parallèle de P1 sans conflit.

### Phase 3 — Exo 2 : book starter + correction avec _quarto.yml + _brand.yml

Arborescence cible (correction) :
```
exercises/02-projet-book/correction/
├── _quarto.yml         # type:book + chapters + appendices
├── _brand.yml          # réutilisé/promu depuis Bloc 1 (même contenu, niveau projet)
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

### Phase 7 — commit + push (branche courante)

- [ ] `git status` + `git diff` final à la fin de chaque phase
- [ ] Commits granulaires par sous-phase : Exo 2 starter, Exo 2 correction, démos B1, démos B2, slides B1, slides B2, etc.
- [ ] Push sur la branche de travail courante (état au 2026-05-02 : `claude/review-main-integration-pNEI1`).
- [ ] (Sur demande explicite uniquement) ouvrir PR avec récap des phases.

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
- **Plan détaillé Exo 2 (Phase 3) : `.claude/plans/exo2-book.md`** (persistant, copié depuis `/root/.claude/plans/oui-p1-planifions-sp-cialement-sprightly-micali.md` sandbox-local). Reviewed pédagogiquement + techniquement (context7 Quarto). Décisions : 3 core + 2 bonus, `format: orange-book-typst` explicite (corrigé depuis `extend: orange-book` fictif initial), `_brand.yml logo: { images, medium }`, auteur Mon Mothma.
- Topic store: `.claude/references/topic-store.md`
- Pacing guidelines: `.claude/references/workshop-pacing.md`
- Project context: `.claude/references/project-context.md`
