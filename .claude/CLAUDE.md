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

### Paquet R compagnon `tutotypst` (dans `pkg/`)

Paquet R qui installe les prérequis, vérifie l'environnement et pose les exercices. Vit dans le **sous-dossier `pkg/`** (publié sur r-universe via le champ `subdir`). **Hors CRAN** : on garde 0 ERROR à `R CMD check`, mais le WARNING non-ASCII (accents FR) et la NOTE « Imports non utilisés » (tous les prérequis sont en `Imports` à dessein) sont **assumés**.

- **Fonctions (lot 1)** : `verifier_installation()`, `installer_exercices()`, `reinitialiser_exercice()`, `lister_exercices()`, `par_ou_commencer()`, `diagnostiquer_rendu()`. API + messages `cli` en français. Seuils de version centralisés dans `pkg/R/utils.R`, **à garder alignés avec `preparatifs.qmd`**.
- **`pkg/inst/exercices/` = COPIE générée** des starters (par `pkg/data-raw/sync-exercices.R`). Source de vérité = `exercises/` (renommage `exercises/`→`exercices/` assumé). Régénérer avec `just pkg-sync` ; un job CI (`.github/workflows/pkg-inst-sync.yml`) échoue si la copie diverge. Les starters sont **committés** (r-universe build par `git clone`).
- **Site pkgdown** : `just pkg-site` génère `package/` (à la racine, gitignoré), publié sous `/package` via `resources: package/**` dans `_quarto.yml`. Lien dans la sidebar tuto. `pkg/_pkgdown.yml` porte l'`url` (sous-chemin) — à garder synchro avec `URL:` de `DESCRIPTION` et l'ID de `_publish.yml`.
- **Recettes `just`** : `pkg-sync`, `pkg-site` ; `just all = charte exos pkg-sync pkg-site site`. `pkg-site` exige Pandoc (fourni par Quarto/RStudio ; en sandbox : `export RSTUDIO_PANDOC=/opt/quarto/bin/tools/x86_64`).
- **Exclusion render** : `"!pkg/"` dans `_quarto-tuto.yml` (sinon conflit multi-format avec `pkg/inst/.../test-install.qmd` en `format: typst`). `pretuto` est sûr par liste explicite.

#### Publication r-universe (action manuelle côté compte `cderv`)

1. Créer le repo GitHub `cderv/cderv.r-universe.dev` avec un `packages.json` :
   ```json
   [{ "package": "tutotypst",
      "url": "https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026",
      "subdir": "pkg" }]
   ```
2. Installer la **GitHub App r-universe** sur le compte `cderv`.
3. Les participants installent ensuite via `install.packages("tutotypst", repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org"))`.

Dév local sans r-universe : `pak::pak("local::./pkg")` ou `R CMD INSTALL pkg`.

## Setup environnement (Claude Code on the web / sandbox vierge)

Quarto est généralement préinstallé. Pour ajouter `gh` CLI, `rig` et R :

```bash
# 1. gh CLI via apt repo officiel
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  -o /usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  > /etc/apt/sources.list.d/github-cli.list
apt update -qq && apt install -y gh

# 2. rig (R Installation Manager) via gh release download
cd /tmp && gh release download --repo r-lib/rig --pattern "r-rig_*_amd64.deb" --clobber
apt install -y ./r-rig_*_amd64.deb

# 3. R release courante via rig
rig add release   # installe R + pak

# 4. Quarto (si manquant) via gh release download
# gh release download --repo quarto-dev/quarto-cli --pattern "quarto-*-linux-amd64.deb" --clobber
# apt install -y ./quarto-*-linux-amd64.deb
```

Tester un rendu Typst end-to-end :
```bash
quarto render exercises/01-document-typst/correction/rapport-starwars.qmd
```

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
