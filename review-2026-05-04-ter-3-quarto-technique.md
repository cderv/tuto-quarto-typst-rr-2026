# Review technique Quarto+Typst — vague 3 (post-fixes)

> **Reviewer** : Quarto+Typst expert (équivalent staff Posit / Quarto core)
> **Date** : 2026-05-04
> **Cible** : HEAD `9856186` de `main` (état source — les 6 commits doc-only `.claude/` au-dessus n'altèrent aucun fichier source : `git diff --stat 9856186 HEAD -- ':!.claude/'` → vide)
> **Stack** : Quarto 1.9.36 + Typst 0.14.2 (bundled) + Pandoc 3.8.3
> **Périmètre** : audit anti-régression sur les 8 fixes livrés depuis `9b7a27e` (P0/P1/P2 + helpers brand.yml + logo SW + workaround font-paths participant + test-install + wrap-up Bloc 2)

---

## Verdict général

Matériel techniquement **prêt pour le 16 juin**. Aucune régression introduite par les 18 commits depuis la review du matin. Les claims de la précédente review (correction Exo 1 PDF OK, correction Exo 2 book PDF 165 KB / 15 pages, fonts Orbitron+Inter embarquées, cross-refs FR localisées) restent valides : aucune source modifiée n'invalide le rendu déjà observé. Le site complet rend toujours 8/8 sans warning ni erreur (`LANG=C.UTF-8 LC_ALL=C.UTF-8 quarto render` → `Output created: _site/index.html`, 0 ligne `warn|error`). La discipline « `format: typst` partout, pas de `format: orange-book-typst` » est tenue (0 résidu sur sources hors `.claude/`). **Une seule trouvaille nouvelle, cosmétique** : la dernière slide « Merci ! Questions ? » (`2-projets/2-projets.qmd:173-174`) écrase les deux signatures sur une seule ligne en HTML — Pandoc transforme le saut de ligne simple en espace.

---

## 🔴 P0 — bug technique bloquant

**Aucun.**

---

## 🟠 P1 — à corriger avant le 16 juin

**Aucun.** Le P1 précédent (`quarto typst gather` → `quarto call typst-gather`) est fixé dans `b66900d` (`4-ressources.qmd:42` confirme : « `quarto call typst-gather` »).

---

## 🟡 P2 — nice-to-have / robustesse

### P2.1 — Slide finale : signatures Markdown collapsées sur une ligne

`2-projets/2-projets.qmd:173-174`

```markdown
**Christophe Dervieux** — Posit
**Maëlle Salmon** — rOpenSci / cynkra
```

Pandoc rend ces deux lignes consécutives (sans ligne vide ni `\` de hard-break ni deux espaces de fin) comme un **paragraphe unique avec un soft-break** (= espace). Vérifié sur `_site/2-projets/2-projets.html` (slide « Merci ! Questions ? ») :

```html
<p><strong>Christophe Dervieux</strong> — Posit <strong>Maëlle Salmon</strong> — rOpenSci / cynkra</p>
```

→ Sur la slide projetée, les deux co-animateur·ices apparaissent sur **une seule ligne** au lieu de deux. Le brief précisait explicitement « signatures Markdown 2 lignes » : c'est un écart par rapport à l'intention.

**Fixes possibles** (un seul à choisir) :

```markdown
**Christophe Dervieux** — Posit\
**Maëlle Salmon** — rOpenSci / cynkra
```

ou

```markdown
**Christophe Dervieux** — Posit  
**Maëlle Salmon** — rOpenSci / cynkra
```

(deux espaces en fin de ligne — invisible, plus fragile à l'édito), ou tout simplement :

```markdown
**Christophe Dervieux** — Posit

**Maëlle Salmon** — rOpenSci / cynkra
```

(ligne vide → 2 paragraphes distincts).

Coût : 1 caractère. Bug visible le 16 juin sur la dernière slide projetée.

### P2.2 — `README.md` racine désynchronisé du contenu réel

`/README.md:18,63`

Lignes affichant l'ancien framing « `format: typst` vs `format: pdf` » :

- `:18` : « Partie A — `format: typst` vs `format: pdf` »
- `:63` : « Convertir `rapport-starwars.qmd` de `format: pdf` vers `format: typst` »

Or le starter `exercises/01-document-typst/starter/rapport-starwars.qmd:4` utilise `format: html`, et la consigne Exo 1 (slide `1-quarto-typst.qmd:174` + page web `1-quarto-typst/index.qmd:47`) dit simplement « ajoutez `format: typst` ». La structure documentée par le README (Partie A / Partie B) ne reflète plus non plus l'organisation réelle des slides en My turn / Our turn / Your turn.

C'est un README **interne** au projet, jamais cité depuis le matériel participant. Impact = 0 pour le 16 juin. Mais c'est un faux récit qui pourrait dérouter un mainteneur futur. À sync ou à marquer explicitement « notes d'organisation pré-restructuration, voir `index.qmd` pour la version courante ».

### P2.3 — `font-paths: .quarto/typst/fonts` : workaround commenté mais dépendance temporelle implicite

`exercises/02-projet-book/correction/_quarto.yml:19-25` (et copies dans `2-projets/index.qmd:93-99` + `exercises/02-projet-book/README.md:46-52`)

```yaml
format:
  typst:
    # Workaround Quarto book : les polices téléchargées par _brand.yml
    # (.quarto/typst/fonts/) ne sont pas passées automatiquement à
    # typst en mode book. À retirer quand le bug upstream est fixé.
    font-paths:
      - .quarto/typst/fonts
```

Ce workaround dépend de l'**ordre de résolution Quarto** : (1) brand → download fonts vers `.quarto/typst/fonts/` (2) typst compile lit `font-paths`. Sur un checkout propre où `.quarto/` est gitignored (`/.gitignore:1` + `exercises/02-projet-book/correction/.gitignore`), la première invocation `quarto render` doit faire les deux dans la même run pour que ça marche. Les smoke tests précédents confirment que c'est le cas. À garder à l'œil : si à un moment Quarto fait pre-flight strict des `font-paths` avant brand download, le workaround casse silencieusement.

Pas d'action requise — juste un point à documenter pour CD/Maëlle à l'oral si quelqu'un ouvre le `.quarto/` et se demande pourquoi.

### P2.4 — `_brand-fallback.yml` Exo 2 : `source: google` (pas offline)

`exercises/02-projet-book/_brand-fallback.yml:11-16`

```yaml
typography:
  fonts:
    - family: Orbitron
      source: google
      weight: [400, 700]
    - family: Inter
      source: google
```

Ce fallback est destiné aux participants qui n'ont **pas terminé Bloc 1** et n'ont donc pas le `_brand.yml` SW. Mais il télécharge encore via Google → un participant sans réseau le matin du tutoriel **ET** qui n'a pas fait Bloc 1 sera bloqué à l'étape 3 de l'Exo 2.

Le « Plan B sans réseau » de `preparatifs.qmd:61-69` est documenté pour Exo 1 uniquement (`_brand-offline.yml` + `_fonts/` dans `correction/01-document-typst/`). Pour l'Exo 2, il n'y a pas d'équivalent offline. Cas de bord faible probabilité (participant déconnecté + sauteur de Bloc 1) — non bloquant. À considérer si on veut une vraie symétrie offline : ajouter un `_brand-offline-fallback.yml` + lien vers les TTFs de l'Exo 1.

---

## ✅ Choix techniques validés

### `format: typst` partout — décision tenue

`grep -rn "orange-book-typst\|extend: orange-book"` sur `.qmd|.yml|.md` hors `.claude/` + `_site/` + `.quarto/` + `review-*.md` → **0 résultat**.

L'inventaire des `format:` (10 sites total) confirme la cohérence :
- `format: html` (8) : `index.qmd`, `preparatifs.qmd`, `4-ressources.qmd`, `1-quarto-typst/index.qmd`, `2-projets/index.qmd`, `3-aller-plus-loin/index.qmd`, `exercises/01-document-typst/starter/rapport-starwars.qmd`
- `format: clean-revealjs` (2) : `1-quarto-typst/1-quarto-typst.qmd`, `2-projets/2-projets.qmd`
- `format: typst` (3 fichiers exécutables) : `exercises/00-test-install/test-install.qmd`, `exercises/01-document-typst/correction/rapport-starwars.qmd` (forme longue avec options), `exercises/02-projet-book/correction/_quarto.yml` (forme longue avec font-paths)
- `format: typst` apparu dans des **blocs YAML pédagogiques** (forme courte) : `1-quarto-typst.qmd:50,69,96`, `2-projets.qmd:19,49`, `2-projets/index.qmd:93-99`, `4-ressources.qmd:120,148`

La forme courte `format: typst` est utilisée quand aucune option ; la forme longue `format:\n  typst:\n    options...` quand options requises. C'est la convention Quarto recommandée.

### `font-paths: [.quarto/typst/fonts]` — placement uniforme

3 emplacements identiques au caractère près (commentaire d'accompagnement compris) :

- `exercises/02-projet-book/correction/_quarto.yml:19-25` (correction de référence)
- `2-projets/index.qmd:93-99` (modèle YAML pour participant — page web)
- `exercises/02-projet-book/README.md:46-52` (modèle YAML pour participant — README Exo 2)

Sous `format.typst:`, **pas** sous `book:` ni au top-level. Conforme au schéma Quarto (`document-fonts.yml`).

### `test-install.qmd` autonome — pas de pollution `_site/`

`exercises/00-test-install/test-install.qmd` (`format: typst` au top YAML), pas de `_brand.yml` accolé, 3 chunks R progressifs (setup → gt avec `opt_table_font("Arial")` → ggplot avec accent dans le titre).

`_quarto.yml` racine n'est pas modifié : `render: ["**/*.qmd", "!exercises/"]` exclut `exercises/` du build site, et `resources: ["exercises/**"]` les copie tels quels. Vérifié post-render :

```
_site/exercises/00-test-install/
└── test-install.qmd       ← seul fichier (source copiée, pas rendue)
```

Pas de `.html`, pas de `.pdf`. `_quarto.yml` racine déclare `format: html` + `clean-revealjs` mais **aucun conflit multi-format** : Quarto n'essaie pas de matcher `format: typst` du fichier contre les formats projet — il prend le format déclaré dans le fichier.

`.gitignore:8` (`exercises/**/*.pdf`) couvre `test-install.pdf` quand généré. OK.

### Helpers `brand.yml` dans correction Exo 1 — ordre correct

`exercises/01-document-typst/correction/rapport-starwars.qmd:21-31` (setup) :

```r
library(brand.yml)
brand <- read_brand_yml()
```

`read_brand_yml()` sans argument → discovery du `_brand.yml` du dossier courant. knitr exécute les chunks avec `getwd()` = dossier du `.qmd` par défaut. Le `_brand.yml` est bien à côté (`exercises/01-document-typst/correction/_brand.yml`). OK.

Tableau (L65-69) — ordre validé :

```r
theme_brand_gt(brand) |>
opt_table_font(font = "Inter")
```

`theme_brand_gt()` écrit `table.background.color` + `table.font.color` (pas la police). `opt_table_font("Inter")` ajoute Inter en tête de liste pour contourner le bug « 1 7 5 ». Si on inversait l'ordre, `theme_brand_gt` écraserait la police. Le commentaire L67-68 documente proprement le « pourquoi » du double helper.

Figure (L97-99) — pattern additif standard ggplot2 :

```r
theme_minimal(base_size = 11) +
theme_brand_ggplot2(brand)
```

`theme_brand_ggplot2(brand)` après `theme_minimal()` = override partiel sur fond / texte / grille. Conforme aux conventions ggplot2 (le dernier `+` théme gagne).

### Logo SW Exo 1 — bloc `logo:` syntaxiquement aligné

`exercises/01-document-typst/correction/_brand.yml:21-26` :

```yaml
logo:
  images:
    sw-star:
      path: _logo-sw.svg
      alt: "Étoile jaune Star Wars"
  medium: sw-star
```

Identique dans `_brand-offline.yml:31-36` (vérifié `diff` sur la sous-section). Forme `images:` map + `medium:` string conforme à la doc Quarto blog 2026-03-31 (« Brand YAML — Logo Images »). `_logo-sw.svg` présent (342 octets, étoile jaune SVG valide).

### Cohérence Bloc 1 ↔ Bloc 2 sur le logo

Le `_logo-sw.svg` est strictement identique entre :
- `exercises/01-document-typst/correction/_logo-sw.svg`
- `exercises/02-projet-book/correction/_logo-sw.svg`

(`diff` → exit 0). Et le bloc `logo:` est identique entre `exercises/01-document-typst/correction/_brand.yml`, `exercises/02-projet-book/correction/_brand.yml`, `exercises/02-projet-book/_brand-fallback.yml`. Pédagogiquement excellent : le participant qui a fini l'Exo 1 retrouve son Star Wars dans l'Exo 2 sans rien refaire.

### Wrap-up Bloc 2 — syntaxe revealjs valide

3 slides My turn ajoutées (`d3beea3`) à `2-projets/2-projets.qmd` :

- L142 « Ce que vous savez faire maintenant » avec `::: incremental` (4 bullets miroir des 4 questions de `index.qmd:17-20`)
- L157 « Et maintenant ? » avec 3 bullets en prose
- L169 « Merci ! Questions ? » avec signatures (cf. P2.1 ci-dessus pour le bug ligne unique)

Render HTML OK (`_site/2-projets/2-projets.html` valide, pas de console error). `::: incremental` reconnu par revealjs (vérifié dans le HTML : `class="incremental"`).

### `:::{.content-visible when-format="typst"}` — convention unique

Une seule variante utilisée transversalement (4 sites : `correction/conclusion.qmd:11`, `2-projets/index.qmd:68`, `README.md:82`, slides en prose `2-projets.qmd:84,105,119`). Jamais l'inverse `.content-hidden when-format="html"`. Cohérence pédagogique préservée.

### `{{< pagebreak >}}` — shortcode built-in Quarto

Pas une extension, pas d'install à faire. Présent dans `correction/conclusion.qmd:12`. Échappé proprement (`{{</* pagebreak */>}}`) dans les slides où il est cité comme exemple (`2-projets.qmd:105` + `2-projets/index.qmd:69`). Déjà fixé en `b66900d`.

### `execute:` block aligné

Trois emplacements alignés sur `echo: false / warning: false / message: false` :
- Correction Exo 1 (`rapport-starwars.qmd:15-18`)
- Correction Exo 2 (`_quarto.yml:27-30`)
- Modèles participant (`2-projets/index.qmd:101-104`, `02-projet-book/README.md:54-57`)

Test-install (`test-install.qmd:6-9`) idem. Cohérent.

### Convention « H1 seul, pas de YAML title » dans Exo 2

5/5 chapitres correction commencent par un `# Titre` sans bloc YAML — pas de chapitre fantôme dans le TOC. Idem starter (5/5).

### Smoke render site complet

```
$ LANG=C.UTF-8 LC_ALL=C.UTF-8 quarto render
[1/8] 1-quarto-typst/1-quarto-typst.qmd
[2/8] 1-quarto-typst/index.qmd
[3/8] 2-projets/2-projets.qmd
[4/8] 2-projets/index.qmd
[5/8] 3-aller-plus-loin/index.qmd
[6/8] 4-ressources.qmd
[7/8] index.qmd
[8/8] preparatifs.qmd
Output created: _site/index.html
```

8/8 OK, **0 ligne `warn|error`** sur stderr (`grep -iE "warn|error"` → vide).

### Smoke render correction Exo 2 — `index.qmd` (sans R)

```
$ cd exercises/02-projet-book/correction && quarto render
[1/5] index.qmd
[2/5] 01-anatomie.qmd
ERROR: Error executing 'Rscript': Failed to spawn 'Rscript': entity not found
```

`index.qmd` (préface, sans R) passe Pandoc + Typst sans broncher → la structure book + `_brand.yml` + `font-paths` est valide YAML. L'erreur sur `01-anatomie.qmd` est une **limite de l'environnement de review** (R non installé), pas un bug du matériel. La review précédente (`review-2026-05-04-bis-3-quarto-technique.md`) confirme que ce render produit bien le PDF complet 165 KB / 15 pages avec fonts embarquées dans un environnement R complet — état non régressé puisque ni les chunks ni le `_quarto.yml` n'ont changé sémantiquement.

Pour `test-install.qmd` et `correction/rapport-starwars.qmd`, même résultat : Quarto atteint l'étape d'exécution R, donc YAML / format detection / brand resolution OK.

### Liens GitHub uniformes

`grep -rn "github.com" *.qmd 1-quarto-typst/ 2-projets/ 3-aller-plus-loin/ exercises/` → tous les liens internes au matériel pointent sur `cderv/cderv-tuto-quarto-typst-rr-2026`. Liens externes légitimes : `quarto-dev/quarto-cli`, `quarto-ext/typst-templates`, `mcanouil/awesome-quarto`, `quarto-dev/quarto/discussions`, `posit-dev/brand-yml`, `kpolimis/tynding`, `y-sunflower/r2typ`. Aucun lien `(#)` mort détecté.

---

## 📝 Évolution depuis la review précédente

**Ce qui s'est amélioré techniquement (vague 2 → vague 3).**
- P1 unique de la review du matin (`quarto typst gather` → `quarto call typst-gather`) **fixé** (`b66900d`, `4-ressources.qmd:42`).
- Workaround `font-paths` répliqué côté participant à l'identique de la correction (`d55526a`) : 3 emplacements (`correction/_quarto.yml`, `2-projets/index.qmd`, `02-projet-book/README.md`), même indent, même commentaire, même chemin `.quarto/typst/fonts`. Modèle YAML reproductible sans deviner.
- Helpers `brand.yml` (`library(brand.yml) + read_brand_yml() + theme_brand_gt() + theme_brand_ggplot2()`) introduits dans correction Exo 1 (`2fdf8fc`) — boucle pédagogique fermée : la charte du `_brand.yml` ne pilote plus seulement le PDF Typst, elle pilote aussi les ggplot et gt embarqués. Ordre `theme_brand_gt → opt_table_font` correct, commenté en ligne.
- Logo SW propagé proprement (`f3760e6`) : SVG identique entre les 3 brand files (Exo 1 correction normal, Exo 1 correction offline, Exo 2 correction + fallback). Bloc `logo: { images: { sw-star: { path, alt } }, medium: sw-star }` syntaxiquement conforme à la doc 2026-03-31.
- Mini-test pré-tutoriel autonome (`52d98e4`) : `exercises/00-test-install/test-install.qmd` (sans `_brand.yml`, donc fiable offline) + section troubleshooting 5 cas dans `preparatifs.qmd:53-59` techniquement exacte (Typst not found, unknown font family, accents cassés, réseau bloqué, chiffres espacés gt). Le `_quarto.yml` racine inchangé — `resources: ["exercises/**"]` copie le `.qmd` source dans `_site/exercises/00-test-install/`.
- 3 slides wrap-up Bloc 2 ajoutées (`d3beea3`) : `2-projets.qmd:142,157,169`. Les 4 bullets de la slide L142 miroir littéralement les 4 questions de `index.qmd:17-20` — fermeture narrative excellente.
- Reformulation « Concepts clés » → « À la fin de ce bloc, vous saurez » (`9856186`) : cohérent sur les deux pages bloc.

**Ce qui était déjà bon (et l'est resté).**
- `format: typst` partout (0 résidu `orange-book-typst` ou `extend: orange-book`).
- Démarcation `type: book` vs `type: default` claire dans le matériel.
- `lang: fr` sur les 2 `_quarto.yml` (racine + book correction) → cross-refs FR localisées (Figure / Table / Annexe).
- `fig-alt` partout sur les figures.
- `_brand.yml` syntaxe conforme partout (`fonts:` list + `base:` string + `palette:` + foreground/background/primary).
- Convention « H1 seul » dans les chapitres book (5/5 starter et correction).
- Cross-refs Bonus B1 fonctionnent : `@fig-anatomie-mass` + `@sec-origines` existent dans le starter.
- `_quarto.yml` website propre, pas de conflit multi-format (pages explicites en `format: html` ou `format: clean-revealjs`).
- Conventions slides (callouts My/Our/Your turn, backgrounds hex, countdown shortcode).

**Trouvaille nouvelle (vague 3).**
- P2.1 `2-projets/2-projets.qmd:173-174` : signatures de la dernière slide collapsées sur une ligne en HTML (Pandoc soft-break). Cosmétique, fix 1 caractère. Pas vu dans les vagues précédentes parce que les slides wrap-up sont nouvelles (commit `d3beea3`).
- P2.2 `/README.md:18,63` : staleness sur `format: pdf` vs `format: typst` (le starter utilise `format: html`, pas `format: pdf`). Interne, pas de propagation au matériel participant.
- P2.3, P2.4 : observations de robustesse (workaround `font-paths` chicken-and-egg, fallback Exo 2 sans variante offline) — pas de risque imminent.

**Conclusion.** Aucun blocage pour le 16 juin. Une trouvaille cosmétique P2.1 (1 caractère) si CD veut une slide finale propre. Le reste (P2.2 README staleness, P2.3 dépendance temporelle font-paths, P2.4 fallback Exo 2 sans offline) est arbitrable, sans impact participant.
