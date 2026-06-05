# CLAUDE.md - Workshop RR 2026

## Qui suis-je

Christophe Dervieux, ingénieur open-source à Posit (R Markdown, Quarto). Maëlle Salmon (rOpenSci / cynkra) co-conçoit le contenu et **aide en salle pendant les exercices** (passe dans les rangs, pas d'animation au tableau). CD pilote le programme et toute l'animation.

## Le projet

Site Quarto pour un tutoriel de 2h aux Rencontres R 2026 (16 juin, Nantes). Contenu en français. Focus Quarto+Typst (pas Typst standalone).

**Arc :** `.qmd` → PDF pro → livre → personnalisé/pérennisé

**Structure :** 2 blocs avec rythme My turn → Our turn → Your turn + pépites "Saviez-vous que..."

## Build

- `quarto preview` / `quarto render` → `_site/` (profile `tuto` actif par défaut)
- `quarto render --profile pretuto` → `_site-pretuto/` (version réduite : accueil + préparatifs uniquement, pour partage avant le workshop)
- Plancher : Quarto 1.9+ ; **pre-release `v1.10.4+` recommandée** depuis le 2026-05-18 (fix brand fonts book [quarto-dev/quarto-cli#14517](https://github.com/quarto-dev/quarto-cli/pull/14517)). Sur Quarto < `v1.10.4`, l'exercice 2 doit appliquer le workaround `font-paths` documenté dans le callout des supports.

Les profiles `tuto` (complet) et `pretuto` (préparatifs only) sont définis dans `_quarto-tuto.yml` / `_quarto-pretuto.yml`. Group déclaré dans `_quarto.yml` — premier item (`tuto`) = défaut.

### `justfile` = orchestrateur réel du build (IMPORTANT)

`quarto render` seul **ne suffit pas** : c'est seulement la recette `site`, et le profil `tuto` **exclut les exercices** (`_quarto-tuto.yml` → `render: - "!exercises/"`). Le build complet passe par `just` :

- `just all` = `charte` + `exos` + `site` (le build de référence, ce que fait aussi `just publish`)
- `just exos` rend les **corrections** : `exo-typst` (`exercises/01-.../correction/rapport-starwars.qmd` → PDF Typst) et `exo-book` (`exercises/02-.../correction/` → `_book/`). **Aucune recette ne rend les `starter/`.**
- `just charte` rend `_charte/charte-starwars.qmd` ; son `_charte/_post-render.R` copie le `charte-starwars.pdf` dans les deux `starter/`.
- `just site` / `just site-pretuto` = `quarto render [--profile pretuto]`
- `just preview`, `just audit` (liens), `just publish` → Posit Connect Cloud

### Comment les exercices arrivent en ligne

`_quarto.yml` déclare `resources: - "exercises/**"` → l'arbre `exercises/` est **copié tel quel dans `_site/`** par le render `site`, y compris les artefacts produits juste avant par `just exos`. Donc : **les corrections (PDF, `_book/`) sont publiées en ligne bien qu'elles soient gitignorées.** `.gitignore` n'empêche pas la publication — Quarto copie depuis le disque, pas depuis git.

Conséquence pour `.gitignore` : `exercises/**/*.{typ,pdf,_files,html}` + `*_files/` sont des **artefacts de rendu ignorés de git mais publiés via `resources`** après un `just all`. Seule exception versionnée : `!exercises/**/charte-starwars.pdf` (committé pour que les participants l'aient sans rien rendre).

### Starters vs corrections

- `starter/rapport-starwars.qmd` est volontairement `format: html` : c'est l'état « avant » de l'exo 1, que le participant convertit en `format: typst` (étape 1 du tableau d'exercice). **Aucune recette `just` ne le rend** — il n'est pas publié rendu, sauf à ajouter une recette dédiée. Ne pas s'étonner d'un `.html` qui traîne : c'est un render manuel local, à supprimer (couvert par le `.gitignore`).
- Les liens vers les exercices dans les pages du site pointent vers **GitHub** (`tree/main/exercises/...`), pas vers la copie `_site/exercises/...`.

### Diagrammes Typst dans les slides (extension `typst-render`)

Les deux decks de slides (`1-quarto-typst/1-quarto-typst.qmd`, `2-projets/2-projets.qmd`) embarquent des schémas **dessinés en Typst** (package `fletcher`) via l'extension [`mcanouil/typst-render`](https://github.com/mcanouil/quarto-typst-render) — méta-cohérence (on dessine en Typst dans un atelier sur Typst). 3 schémas : pipeline `qmd→typ→pdf` (Bloc 1, SVG statique nettoyé — **pas** un bloc typst), hub `_brand.yml → sorties` (Bloc 1, slide `_brand.yml`), fusion `5 .qmd → 1 livre` (Bloc 2, slide `type: book`).

YAML requis dans chaque deck qui contient un bloc ` ```{typst} ` :
```yaml
engine: markdown          # sinon Quarto tente un kernel Jupyter sur le bloc {typst}
filters: [typst-render]
typst-render:
  package-path: /_typst-packages   # packages vendorisés (offline/repro), cf. ci-dessous
  output-directory: typst-figures  # SVG dans un dossier PUBLIÉ, pas le cache .quarto/
```

- **`_typst-packages/`** (racine, committé) = copie du cache Typst (`fletcher`, `cetz`, `oxifmt`, versions épinglées). Évite tout téléchargement `@preview` au build → **offline et reproductible**. Équivalent de `quarto call typst-gather`, mais pour le chemin HTML/RevealJS de l'extension (typst-gather ne couvre que le format Typst/PDF natif). Le préfixe `_` garde le dossier hors des entrées de rendu Quarto.
- **`output-directory: typst-figures` est obligatoire** : sans lui, les SVG sont écrits dans `.quarto/typst-render/` (dotdir de cache) et **cassent sur le site publié**. Les SVG générés (`**/typst-figures/`) sont **gitignorés mais publiés via disque** après render (même logique que les corrections d'exercices).
- **Pas de `label: fig-`** sur les blocs (sinon légende « Figure N » parasite sur les slides) ; `//| alt:` pour l'accessibilité.
- Vérifier le rendu/la **taille** des slides : pas de navigateur dans le sandbox par défaut, mais `npx playwright install chromium` + un script Playwright qui charge `_site/.../<deck>.html`, force les fragments (`section.fragment.add('visible')`) et screenshote à 1600×900 = aperçu fidèle (la métrique `scrollHeight−clientHeight` détecte le débordement vertical).

### Paquet R compagnon `tutoquartotypst` (dans `pkg/`)

Paquet R qui installe les prérequis, vérifie l'environnement et pose les exercices (publié sur r-universe via `subdir: pkg`). **Hors CRAN** : cible `R CMD check` = 0 ERROR ; le WARNING non-ASCII (accents FR) et la NOTE « Imports non utilisés » (prérequis en `Imports` à dessein) sont **assumés**.

- **20 fonctions** (messages `cli` FR) en 3 lots — *préparation*, *santé chaîne Typst & confort*, *pérennité* ; regroupement dans `pkg/_pkgdown.yml`. Seuils de version dans `pkg/R/utils.R`, **à garder alignés avec `preparatifs.qmd`**. YAML : lecture via `.lire_yaml()`, éditions **textuelles ciblées** (préservent les commentaires) + rollback.
- **`pkg/inst/` = COPIE générée** depuis `exercises/` (starters + **sources des `correction/`** + `templates/brands/` + `offline/_fonts/`) par `pkg/data-raw/sync-exercices.R` ; renommage `exercises/`→`exercices/` **assumé**. Régénérer : `just pkg-sync` ; vérifier : `just pkg-sync-check` (même garde-fou en CI, `pkg-inst-sync.yml`). **Committé** (r-universe build par `git clone`). Corrections embarquées **jamais** posées par `installer_exercices()` (starters only) : copie locale **opt-in** via `recuperer_correction()` (confirmation) ; consultation en ligne via `ouvrir_correction()`.
- **Build / site** : `just all = charte exos pkg-sync pkg-site site`. `pkg-site` génère le site pkgdown dans `package/` (gitignoré), publié sous `/package` via `resources: package/**` ; un seul article (`vignettes/articles/`, hors tarball) — **pas** d'article install/exos (doublonnerait le site). Exclusion render **obligatoire** : `"!pkg/"` dans `_quarto-tuto.yml` (conflit multi-format). `pkg-site` exige Pandoc + `ragg` (sandbox : `RSTUDIO_PANDOC=/opt/quarto/bin/tools/x86_64`, `apt install -y libwebpmux3`).
- **Procédures détaillées (progressive disclosure)** : publication r-universe → `pkg/dev/PUBLICATION-r-universe.md` (`packages.json` prêt dans `pkg/dev/`) ; tests manuels RStudio → `pkg/dev/TESTS-MANUELS.md`. Dév local : `pak::pak("local::./pkg")`.

## Règles critiques

- Pages web : `format: html` dans le YAML (obligatoire, sinon conflit multi-format)
- Slides : `format: clean-revealjs` (hérite config de `_quarto.yml`)
- Countdown : `{{< countdown 15:00 >}}` (extension Quarto, pas le package R)
- Pages web internes : `author: ""` + `date: ""` pour override les valeurs projet de `_quarto.yml` (sinon affichage non voulu). Slides ont déjà leur YAML auteur/date explicite.
- Toujours `fig-alt` sur les images

## Conventions slides (My turn / Our turn / Your turn)

- **My turn** : slides normales, pas de callout spécial
- **Our turn** : callout `.callout-tip` avec titre "Faisons ensemble !" (vert)
- **Your turn** : callout `.callout-warning` avec titre "À vous !" + countdown (jaune)
- **Pépites** : callout `.callout-note` avec titre "Saviez-vous que..." (bleu)

Différenciation visuelle = type de callout (pas `{background-color=...}` sur les slides — trop flashy). Couleurs ajustées via variables SASS dans `reveal-style.scss` : `$callout-color-tip: #27ae60`, `$callout-color-warning: #FDC538`, note par défaut bleu.

## Références

- Plan de travail → `.claude/PLAN.md`
- Setup sandbox vierge (gh/rig/R, pkgdown) → `.claude/references/sandbox-setup.md`
- Détails techniques, URLs, content patterns → `.claude/references/project-context.md`
- Skill pour créer du contenu → `.claude/skills/workshop-content.md`
- Skill Quarto authoring (Posit) → `.claude/skills/quarto-authoring.md`
- Skill alt text pour figures → `.claude/skills/quarto-alt-text.md`
- Skill brand.yml (Posit) → `.claude/skills/brand-yml.md`

## Reviews

Les rapports de review générés par les agents vont dans `.claude/reviews/`.

Convention de nommage : `.claude/reviews/review-YYYY-MM-DD[-tag]-[type].md`
- `[tag]` optionnel : `bis`, `ter`, `quater`, … pour plusieurs reviews le même jour
- `[type]` : `pedagogue`, `eleve-debutant`, `quarto-technique`, `orthographe-fr`, `content`

Agents disponibles dans `.claude/agents/` : `workshop-reviewer-pedagogue`, `workshop-reviewer-debutant`, `workshop-reviewer-technique`, `workshop-reviewer-fr`.
