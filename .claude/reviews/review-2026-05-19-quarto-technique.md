# Review technique Quarto — Refonte Your Turn (PoC Exo 1)

**Date :** 2026-05-19  
**Scope :** `1-quarto-typst/index.qmd`, `1-quarto-typst/boussole.qmd`, `1-quarto-typst/1-quarto-typst.qmd`, `exercises/01-document-typst/starter/README.md`, `exercises/01-document-typst/correction/README.md`, `_quarto.yml`, `_quarto-tuto.yml`  
**Commit de référence :** branch `refonte-your-turn`, dernier commit `0067068` (main) + commits de la phase 1  
**Quarto target :** 1.9+ (recommandé 1.10.4+)

---

## Verdict general

Le PoC Exo 1 est structurellement solide : profils, exclusions render, intégration sidebar, extensions FA + countdown installées, YAML format:html/clean-revealjs cohérents avec les règles CLAUDE.md. Deux problemes bloquants avant le J16 : les fichiers de polices TTF (Star Jedi + Inter) ne sont pas commités — l'etape 4 de l'exercice et toute la correction basee sur `_brand-offline.yml` sont inoperantes. Le countdown dans le titre du callout de `boussole.qmd` est syntaxiquement fragile. Trois points P1 sur les chemins relatifs du README et le comportement auto-start du countdown.

---

## P0 — Bug technique bloquant

### Fichiers de polices TTF manquants du depot

**Fichiers concernes :**
- `exercises/01-document-typst/starter/_fonts/Starjedi.ttf` — absent, seulement `LICENSE-StarJedi.txt`
- `exercises/01-document-typst/correction/_fonts/Starjedi.ttf` — absent
- `exercises/01-document-typst/correction/_fonts/Inter-Regular.ttf` — absent
- `exercises/01-document-typst/correction/_fonts/Inter-SemiBold.ttf` — absent
- `exercises/01-document-typst/correction/_fonts/Inter-Bold.ttf` — absent

**Symptome :** Le `star_jedi.zip` et `star_jedi/` sont untracked au repo root (`git status`). La police a ete extraite mais non commitee.

**Impact :**
- `exercises/01-document-typst/starter/README.md:11` affirme `| _fonts/Starjedi.ttf | Police locale (étape 4) |` — le fichier n'existe pas pour le participant qui clone.
- `exercises/01-document-typst/correction/_brand.yml:16` reference `path: _fonts/Starjedi.ttf` — le rendu correction echoue avec `unknown font family: Star Jedi`.
- `exercises/01-document-typst/correction/_brand-offline.yml` reference 4 TTF inexistants — la variante offline est completement cassee.
- `exercises/01-document-typst/README.md:37-44` decrit `starter/_fonts/` comme contenant la police — description fausse.
- L'etape 4 de l'exercice ("Ajouter Star Jedi via `source: file`") ne peut pas etre realisee par les participants.

**Fix :** Commiter les fichiers depuis `star_jedi/` a leur emplacement correct :
- `Starjedi.ttf` → `exercises/01-document-typst/starter/_fonts/Starjedi.ttf`
- `Starjedi.ttf` → `exercises/01-document-typst/correction/_fonts/Starjedi.ttf`
- Inter TTFs → `exercises/01-document-typst/correction/_fonts/`
Puis supprimer/gitignorer `star_jedi.zip` et `star_jedi/` du root.

---

## P1 — A corriger avant le 16 juin

### 1. Countdown dans un titre de callout — syntaxe fragile

**Fichier :** `1-quarto-typst/boussole.qmd:11-13`

```markdown
::: {.callout-warning appearance="simple"}
## ⏱ {{< countdown 12:00 >}}
:::
```

**Probleme :** Le shortcode `{{< countdown 12:00 >}}` retourne `pandoc.RawBlock("html", ...)`, soit un element de type Block. Placer un Block dans le contexte d'un titre de callout (`##` dans un callout Quarto) est syntaxiquement incorrect — Pandoc attend du contenu inline dans un titre de section, pas un bloc HTML brut. En pratique, Quarto peut soit ignorer le titre, soit sortir le `<countdown-timer>` apres le titre, soit produire du HTML malformed.

**Fix recommande :** Deplacer le countdown dans le corps du callout, sans `##` heading :

```markdown
::: {.callout-warning appearance="simple"}
{{< countdown 12:00 >}}
:::
```

Ou sans callout du tout si le wrapper visuel n'est pas essentiel :

```markdown
{{< countdown 12:00 >}}
```

### 2. Lien relatif `../correction/` du README star brise dans le site Quarto

**Fichier :** `exercises/01-document-typst/starter/README.md:26-27`

```markdown
[`correction/`](../correction/) en dernier recours.
```

**Probleme :** Ce lien est correct pour le browse GitHub (resout vers `exercises/01-document-typst/correction/`). Mais lors du `{{< include ../exercises/01-document-typst/starter/README.md >}}` depuis `1-quarto-typst/index.qmd`, Quarto resout les liens relatifs de l'inclus dans le contexte du fichier inclueur. Depuis `1-quarto-typst/`, `../correction/` pointe vers `correction/` a la racine du site — chemin inexistant, lien 404.

**Fix :** Remplacer le lien relatif par l'URL GitHub absolue (qui fonctionne dans les deux contextes) :

```markdown
[`correction/`](https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026/tree/main/exercises/01-document-typst/correction/) en dernier recours.
```

Note : Ce probleme est de faible impact pratique car `index.qmd:88` fournit deja le lien GitHub complet vers la correction via `{{< fa download >}}`. Mais le lien brise dans la section "Bloque ?" du README inclus reste un defaut visible.

### 3. Countdown ne demarre pas automatiquement — design doc incorrect

**Fichier :** `.claude/design-your-turn-refonte.md:107`

> "son propre `format: html` et `{{< countdown 12:00 >}}` qui démarre au chargement de la page"

**Realite :** `_extensions/gadenbuie/countdown/countdown.lua:246` :

```lua
local start_immediately = getOption(kwargs, "start_immediately", "false") == "true"
```

La valeur par defaut de `start-immediately` est `false`. Le countdown affiche `12:00` statique jusqu'a ce que l'animateur clique dessus. Il ne demarre PAS au chargement de la page.

**Decision a prendre :** Si l'auto-start au chargement est voulu (projection autonome), utiliser :

```
{{< countdown 12:00 start_immediately=true >}}
```

Si le click-to-start est acceptable (animateur demarre le timer quand il ouvre l'onglet), laisser tel quel et corriger seulement la documentation du design. Recommandation : `start_immediately=true` correspond mieux au cas d'usage "ouvrir l'onglet = timer part".

### 4. H1 dans le README inclus cree une hierarchie incoherente

**Fichier :** `exercises/01-document-typst/starter/README.md:1`

```markdown
# Exercice 1 — Starter
```

**Probleme :** `index.qmd` utilise `title:` en YAML et des sections H2/H3 dans le corps. Quand le README est inclus via `{{< include >}}`, son `# H1` apparait comme un titre de niveau 1 au milieu du corps de la page, incongru entre `## Exercice 1` (H2) et les sous-sections H3.

**Impact :** Pas d'erreur de rendu, mais le TOC de la page (si actif) listera "Exercice 1 — Starter" en H1, perturbant la navigation. Le `toc: true` sur `index.qmd` (herite du profil tuto) affichera ce H1 en premier niveau.

**Fix :** Remplacer le `#` par `##` dans le README starter :

```markdown
## Exercice 1 — Starter
```

Cela casse la convention GitHub README (qui attendrait un H1 comme titre principal), mais preserve la hierarchie Quarto. Alternative : ajouter `toc-depth: 2` sur `index.qmd` pour exclure le H1 du README du TOC.

---

## P2 — Nice-to-have / robustesse

### 5. URL typography brand-yml : divergence entre plan et implementation

**Fichier plan :** `.claude/plans/2026-05-19-refonte-your-turn.md` (Task 1.1) utilise `https://posit-dev.github.io/brand-yml/reference/typography/`  
**Implementation :** `1-quarto-typst/index.qmd:69` et `.claude/plans/2026-05-19-doc-mapping.md:14` utilisent `https://posit-dev.github.io/brand-yml/brand/typography.html`

Les deux URLs sont differentes. Verifier laquelle est canonique via `scripts/audit-doc-links.sh` (a creer en Phase 4). Risque faible si l'une des deux redirige vers l'autre, mais a valider avant J16.

### 6. Texte du lien slide — path relatif ambigu

**Fichier :** `1-quarto-typst/1-quarto-typst.qmd:232`

```markdown
📖 Consigne complète : [`1-quarto-typst/index.html`](index.qmd)
```

Le texte visible `1-quarto-typst/index.html` est le chemin relatif depuis la racine du site, pas une URL complete. Un participant qui l'ecrit manuellement dans son navigateur obtiendrait un 404 (il manque le nom de domaine et le prefixe du repo). L'href `index.qmd` resout correctement en cliquant. Suggestion : utiliser l'URL complete du site deploye en texte visible, ou simplement `[Page Exercice 1](index.qmd)` sans chemin de fichier.

### 7. `_publish.yml` modifie non comite — pollution potentielle de la PR

**Fichier :** `_publish.yml` (statut `M` dans git status)

La modification est pre-existante (configuration Posit Connect Cloud, non liee a cette PR). A commiter separement ou inclure dans un commit dedie avant ouverture de la PR pour eviter qu'un reviewer confonde ce changement avec la refonte Your Turn.

---

## Valide — Choix techniques corrects

- **`format: html` sur `boussole.qmd`** (`boussole.qmd:4`) : correct, evite le conflit multi-format avec `clean-revealjs` declare dans `_quarto.yml`.
- **`sidebar: false` + `toc: false` placement** (`boussole.qmd:7-8`) : top-level YAML de page Quarto website — syntaxe documentee et correcte, pas sous `format.html:`.
- **`author: ""` + `date: ""` override** (`boussole.qmd:5-6`, `index.qmd:3-5`) : overrides les valeurs projet de `_quarto.yml` (`author:` + `date: 2026-06-16`) — comportement correct, pas d'affichage non voulu.
- **Extension countdown installee** (`_extensions/gadenbuie/countdown/`) : shortcode `{{< countdown >}}` disponible, fonctionne sur pages HTML et slides RevealJS.
- **Extension fontawesome installee** (`_extensions/quarto-ext/fontawesome/`) : `{{< fa >}}` fonctionnel.
- **`{{< include >}}` chemin correct** (`index.qmd:83`) : `../exercises/01-document-typst/starter/README.md` depuis `1-quarto-typst/` resout correctement vers `exercises/01-document-typst/starter/README.md` — fichier present.
- **`!exercises/` dans `project.render` n'affecte pas les includes** : `project.render` controle quels `.qmd` sont rendus comme projets Quarto, pas la resolution des shortcodes `{{< include >}}` — include fonctionne independamment.
- **Pas de countdown shortcode dans le slide deck** (`1-quarto-typst.qmd`) : l'occurrence a la ligne 236 est dans un bloc `::: notes` (texte pur de speaker notes), pas un shortcode actif. Le countdown a bien ete migre sur `boussole.qmd`. Verification : `grep -n "countdown" 1-quarto-typst/1-quarto-typst.qmd` → une seule occurrence en speaker notes.
- **`format: clean-revealjs`** sur le slide deck : correct per CLAUDE.md.
- **Pas de H1 + title YAML en doublon** : `index.qmd` et `boussole.qmd` utilisent `title:` YAML sans H1 dans le corps (le H1 du README vient de l'include, cf. P1 #4).
- **`boussole.qmd` non liste dans `sidebar.contents`** de `_quarto-tuto.yml` : ne pollue pas la navigation. Accessible uniquement par URL directe.
- **Profile `pretuto` non affecte** : `_quarto-pretuto.yml` rend uniquement `index.qmd` + `preparatifs.qmd`. Les nouveaux fichiers (`boussole.qmd`, READMEs) sont hors perimetre pretuto.
- **README starter sans YAML frontmatter** : parsable sans ambiguite par `{{< include >}}`.
- **Pas de markdown code fence executable** dans le README : ` ```bash ` (display) != ` ```{bash} ` (execute) — pas de risque d'execution accidentelle a l'include.
- **`correction/README.md`** (`exercises/01-document-typst/correction/README.md`) : 3 lignes conformes au design, format minimal correct.
- **`_brand.yml` syntaxe** dans la correction : structure `color.palette`, `typography.fonts` (liste de dicts), `logo.images` (map `images:` + `medium:`) — conforme a la spec brand-yml.
- **Callout types cohérents** : `callout-tip` pour "À vous !" sur la page web est coherent avec `2-projets/index.qmd:44` (meme convention). Le `callout-warning` pour "À vous !" dans les slides est conforme CLAUDE.md § "Conventions slides". La distinction slide vs page web est intentionnelle.

---

## URLs doc verifiees (doc mapping)

Verifications effectuees manuellement par inspection de la source et du design doc. L'audit complet doit etre realise via `scripts/audit-doc-links.sh` (Phase 4 du plan) avant J16.

| URL | Statut | Note |
|-----|--------|------|
| `https://quarto.org/docs/output-formats/typst.html` | A verifier | Page principale Typst |
| `https://quarto.org/docs/output-formats/typst.html#format-options` | A verifier | Ancre `#format-options` — peut bouger lors de reorganisations doc |
| `https://quarto.org/docs/reference/formats/typst.html` | A verifier | Reference complete |
| `https://quarto.org/docs/authoring/brand.html` | A verifier | Page brand.yml |
| `https://posit-dev.github.io/brand-yml/` | A verifier | Spec brand-yml |
| `https://posit-dev.github.io/brand-yml/brand/typography.html` | A verifier | Diverge de `/reference/typography/` du plan initial — cf. P2 #5 |

La note dans `.claude/plans/2026-05-19-doc-mapping.md:32` rappelle : "Sections internes (ancres `#format-options`, `#appendices`, etc.) : vérifier qu'elles existent toujours au J16 — la doc Quarto réorganise régulièrement les pages." Cette vigilance est correcte.

---

## Go / No-Go technique

**Go conditionnel.**

- **Bloquant avant merge :** Commiter les polices TTF (P0). Sans les fonts, la correction ne rend pas et l'etape 4 est inoperante pour tous les participants.
- **Bloquant avant J16 :** Corriger le countdown dans le heading callout (P1 #1), decider start_immediately (P1 #3).
- **Recommande avant J16 :** Corriger le lien `../correction/` (P1 #2), corriger le H1 dans le README (P1 #4).
- **Acceptable post-merge :** URL typography a valider (P2 #5), texte lien slide (P2 #6), commiter `_publish.yml` separement (P2 #7).

La structure a 4 surfaces (site / slide / boussole / README), le gabarit 3 colonnes, les indices doc, et l'integration Quarto sont techniquement corrects et bien executes.
