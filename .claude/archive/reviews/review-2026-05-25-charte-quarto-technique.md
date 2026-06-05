# Review technique Quarto+Typst — Charte + nouveau gabarit Your Turn

**HEAD audité** : `d024d6c` sur `claude/tutorial-review-charter-9H98W` · **Quarto sandbox** : 1.9.36 · **R** : indisponible (env sans R, smoke render R-dépendant impossible)

---

## Verdict général

Aucun bug bloquant détecté. La nouvelle infrastructure `_charte/` est techniquement saine : `_brand.yml` valide (syntaxe `images:` + `medium:` conforme à la spec brand-yml 2026-03-31), `format.typst.logo` correctement utilisé pour réduire le logo à 0.6in et stopper le chevauchement, rendu PDF reproductible (`quarto render _charte/charte-starwars.qmd` → DONE). Les trois `charte-starwars.pdf` (source `_charte/`, starter exo1, starter exo2) sont bit-identiques (`md5: 17ab0194…`) — le pipeline de copie manuelle documenté dans `_charte/README.md` a été exécuté et tient la route. La cohérence brand entre charte distribuée et corrections est parfaite : les 4 `_brand.yml` actifs (charte + exo1 correction + exo2 correction + exo2 fallback) sont strictement identiques (diff vide). Le nouveau gabarit Your Turn (boussole + countdown migré + includes README) ne pose aucun problème de format multi-format ; toutes les pages web ont `format: html` explicite et les boussoles utilisent `start_immediately=true` qui existe bien dans `countdown.lua:245-246`. Le bug `brand_color_pluck("sw-yellow")` de la review du 19/05 est résolu partout (toutes les occurrences utilisent désormais `"sw_yellow"`). Le workaround `font-paths` Quarto < 1.10.4 est correctement isolé dans la correction Exo2 et documenté en callout dépliable côté supports.

---

## P0 — bloquant

Aucun.

---

## P1 — à corriger avant le 16 juin

### P1.1 — `editor: visual` résiduel sur les slides Bloc 2

`2-projets/2-projets.qmd:8` contient `editor: visual` alors que CD l'a explicitement retiré ailleurs (commits `65faf18` "enlever visual editor" et `0d224fb` "Enleve visual editor"). C'est la seule occurrence restante dans tout le repo (`grep -rn "editor:" --include="*.qmd"` ne retourne que cette ligne).

Pas bloquant pour le rendu, mais incohérent avec l'effort déjà fait. Sans risque de retirer.

---

## P2 — nice-to-have / robustesse

### P2.1 — Pas d'automatisation pour la propagation `_charte/charte-starwars.pdf` → starters

`_charte/README.md:16-25` documente un pipeline manuel :

```bash
quarto render charte-starwars.qmd
cp charte-starwars.pdf ../exercises/01-document-typst/starter/
cp charte-starwars.pdf ../exercises/02-projet-book/starter/
```

Si CD modifie `_charte/charte-starwars.qmd` ou `_charte/_brand.yml` sans exécuter cette séquence, les deux starters embarqueront un PDF stale (le `.gitignore:9` négativé `!exercises/**/charte-starwars.pdf` n'aide pas à détecter la dérive). Vérifié à l'instant : les 3 PDFs ont md5 `17ab0194da5224dd0837f60db4cb04eb` — actuellement à jour.

Suggestion : transformer le bloc bash du README en `scripts/build-charte.sh` ou y ajouter une commande `make charte` pour réduire la friction. Optionnel — pas un blocage pour le J16.

### P2.2 — Page number "1" affiché sur la charte mono-page

Le PDF rendu (`_charte/charte-starwars.pdf`) affiche `1` en bas centré — c'est le pied de page Typst par défaut. `_charte/charte-starwars.qmd:11` désactive bien `section-numbering: ""` et `toc: false`, mais le numéro de page n'est pas désactivable via YAML Quarto. Pour une charte mono-page, esthétiquement marginal.

Workaround si gênant : ajouter un bloc raw `#set page(numbering: none)` en tête du `.qmd`. Cosmétique uniquement.

### P2.3 — Inconsistance plancher Quarto entre supports

- `preparatifs.qmd:16` : « Plancher : stable 1.9 ou supérieure »
- `preparatifs.qmd:45` : `quarto::quarto_version() # 1.9.37 mini, 1.10.x prerelease recommandée`
- `CLAUDE.md` : « Plancher : Quarto 1.9+ »
- `.claude/issues/quarto-book-brand-fonts.md:3` : « Stable v1.9.37 » mentionné

Le `1.9.37 mini` du commentaire de code R est plus restrictif que le « 1.9+ » documenté ailleurs (1.9.37 = dernier patch 1.9 stable au 2026-05-18). Le participant qui voit le commentaire `# 1.9.37 mini` et a `1.9.36` ou `1.9.0` pourrait se croire bloqué inutilement. Aligner sur une seule formulation (probablement « 1.9.37+ recommandé » ou retirer le `.37`).

### P2.4 — CSS classes décoratives sans style associé sur la home

`index.qmd:9` (`::: when-where`) et `index.qmd:27` (`::: programme`) créent des divs avec ces classes, mais aucun fichier `*.scss`/`*.css` HTML n'est défini (`reveal-style.scss` est slides-only). Le rendu HTML actuel produit des `<div class="when-where">` et `<div class="programme">` sans styling — fonctionnellement identique à un div vide. Pas un bug, mais code mort. Soit ajouter du SCSS pour valoriser visuellement (un bandeau pour "when-where", un encart pour "programme"), soit retirer les classes.

### P2.5 — Hexs sw-cream et sw-black hard-codés dans `charte-starwars.qmd`

`_charte/charte-starwars.qmd:26,33,41,70,98,112,114` utilisent `rgb("#BC1E22")`, `rgb("#0B0B0F")` en dur dans les blocs `{=typst}` au lieu de référencer `brand-color.imperial-red` / `brand-color.sw-black`. Acceptable dans une charte (le document *définit* ces couleurs et peut donc se permettre les hex), mais incohérent avec le message pédagogique « pas de hex en dur, tout passe par brand-color ». Pas de fix prioritaire — choix de design à arbitrer.

### P2.6 — `format.typst.logo` dupliqué entre `_quarto.yml` et `_brand.yml`

Le `_brand.yml` déclare `logo.images.sw-star` + `logo.medium: sw-star`, et `format.typst.logo` ré-déclare la même image (`path: sw-star`) avec des dimensions custom (`width: 0.6in`, `padding: 0.4in`). La duplication est nécessaire actuellement (sinon Quarto force 1.5in × 0.75in par défaut, cf. note dans `2-projets/index.qmd:120-122` et `1-quarto-typst.qmd:198`). C'est un *workaround documenté*, pas un bug — mais quand un fix upstream `_brand.yml` permettra des dimensions par image, ce sera à nettoyer. Pas d'action immédiate.

---

## Validations passées (preuves)

### Smoke tests effectués
- `quarto render _charte/charte-starwars.qmd` → `Output created: charte-starwars.pdf` ; rendu visuel inspecté via `pdftoppm` — logo top-left présent (`sw-star` correctement résolu), palette swatches OK, échantillons typographiques OK (Star Jedi pour titres, Inter pour corps), zéro warning bloquant.
- `quarto render` (site complet) → 10/10 pages rendues, `Output created: _site/index.html`, hiérarchie `_site/exercises/{00,01,02}-…/` présente comme resources copiées (validation `resources: - "exercises/**"` dans `_quarto.yml:3-4`).
- `bash scripts/audit-doc-links.sh` → 17 URLs scannées, toutes 200 (quarto.org + posit-dev.github.io), exit code 0. Le script fonctionne comme annoncé.
- `quarto render exercises/01-document-typst/correction/rapport-starwars.qmd` et `quarto render exercises/00-test-install/test-install.qmd` → échec `Error executing 'Rscript': entity not found` (R absent du sandbox, attendu — pas imputable au repo).

### `_charte/_brand.yml` — syntaxe brand-yml
- `color.palette` (4 entrées nommées), `color.primary/foreground/background` référençant ces noms : conforme.
- `typography.fonts` : list de dicts, une font `source: file` (Star Jedi, fichier présent `_charte/_fonts/Starjedi.ttf` 46 Ko) + une font `source: google` (Inter 400, 600) : conforme.
- `typography.base`/`headings` : strings référençant les family names : conforme.
- `logo.images` : map nommée `sw-star: { path, alt }` + `logo.medium: sw-star` (référence par nom) : conforme à la spec brand-yml documentée 2026-03-31, vérifiée via context7 `/posit-dev/brand-yml` (« `logo.medium` is for sidebar logos and can have light and dark variants »).

### `_charte/charte-starwars.qmd` — YAML et structure
- `format.typst` (forme longue, justifiée par les multiples options) : `papersize`, `margin`, `font-paths: [_fonts]`, `section-numbering: ""`, `toc: false`, `logo: { path: sw-star, location: left-top, width: 0.6in, padding: 0.4in }` : tous valides.
- Pas de `format: orange-book-typst` (faux nom), pas de `extend:` (syntaxe inventée). Conforme aux conventions Quarto 1.9+.
- Title YAML `title: ""` (vide, le titre est composé en raw Typst pour le visuel red imperial gras) — pas de chapitre fantôme parce que ce n'est pas un book.

### Cohérence brand charte ↔ corrections (diff vide)
```bash
diff _charte/_brand.yml exercises/01-document-typst/correction/_brand.yml   # vide
diff _charte/_brand.yml exercises/02-projet-book/correction/_brand.yml      # vide
diff exercises/02-projet-book/_brand-fallback.yml exercises/02-projet-book/correction/_brand.yml  # vide
```
Quatre fichiers identiques. La seule variante `_brand-offline.yml` (exo1 correction) bascule Inter sur `source: file` avec fichiers `Inter-Regular/SemiBold/Bold.ttf` dans `_fonts/` — Plan B 100 % offline cohérent.

### Workaround `font-paths` Quarto < 1.10.4
- Présent dans `exercises/02-projet-book/correction/_quarto.yml:21-29` avec commentaire détaillé citant `#14517` et noté « inoffensif sur version fixée ».
- Documenté côté supports dans `2-projets/index.qmd:138-153` (callout dépliable « Polices brand pas chargées (Quarto < v1.10.4) ») avec bloc YAML copiable et indication que c'est inutile sur 1.10.4+.
- Référence GitHub PR #14517 cohérente avec `.claude/issues/quarto-book-brand-fonts.md:3` qui marque l'issue « RÉSOLU UPSTREAM ».
- Plancher 1.9+ correct : sans le workaround, les polices brand ne sont pas appliquées en mode book mais le rendu n'échoue pas (warning seulement).

### Boussole et countdown
- `1-quarto-typst/boussole.qmd:12` et `2-projets/boussole.qmd:12` : `{{< countdown 12:00 start_immediately=true >}}`. L'option `start_immediately` existe dans `_extensions/gadenbuie/countdown/countdown.lua:245-246` (`local start_immediately = getOption(kwargs, "start_immediately", "false") == "true"`). Bien invoqué.
- `format: html` + `author: ""` + `date: ""` + `toc: false` + `sidebar: false` : conformes aux règles critiques du `CLAUDE.md`.
- `{{< include ../exercises/01-document-typst/starter/README.md >}}` (resp. Exo 2) dans les pages `index.qmd:89` et `2-projets/index.qmd:97` : les fichiers cibles existent, l'include shortcode est natif Quarto (pas d'extension à installer). Rendu OK (validé par smoke test).

### Cross-refs `lang: fr`
- `_quarto.yml:34` : `lang: fr` au niveau projet → toutes les pages héritent.
- `exercises/02-projet-book/correction/_quarto.yml:4` : `lang: fr` au niveau livre → « Figure » / « Table » / « Annexe A » en français. Les xrefs `@fig-anatomie-mass`, `@sec-origines`, `@tbl-origines-films` utilisées dans `01-anatomie.qmd:75`, `conclusion.qmd:6-9` ont leur cible définie (labels existent).
- Exo 1 (`rapport-starwars.qmd`) ne contient pas de xrefs en texte (`grep -n "@fig\|@tbl\|@sec"` retourne vide), donc `lang` n'a aucun impact perçu — pas un bug.

### `{{< pagebreak >}}` shortcode
- `exercises/02-projet-book/correction/conclusion.qmd:13` : `{{< pagebreak >}}` dans un `.content-visible when-format="typst"`. Shortcode natif Quarto, pas d'extension à installer. La version échappée `{{</* pagebreak */>}}` dans `2-projets/index.qmd:71` (bloc de code Markdown) est la syntaxe correcte pour afficher un shortcode littéral.

### `.content-visible when-format="typst"`
- Utilisé une fois (`conclusion.qmd:12-14`) pour isoler le pagebreak — cohérent pédagogiquement (bonus B2 enseigne cette syntaxe). Pas de variantes mélangées (`.content-hidden when-format="html"` non utilisé).

### `format: html` partout où nécessaire
- Pages web internes : `index.qmd:4`, `1-quarto-typst/index.qmd:3`, `1-quarto-typst/boussole.qmd:4`, `2-projets/index.qmd:3`, `2-projets/boussole.qmd:4`, `3-aller-plus-loin/index.qmd:3`, `4-ressources.qmd:3`, `preparatifs.qmd:3` : tous présents.
- Slides : `format: clean-revealjs` explicite (`1-quarto-typst.qmd:7`, `2-projets.qmd:7`).
- Aucun conflit multi-format détecté.

### `brand_color_pluck()` — bug 19/05 résolu
Toutes les occurrences utilisent `"sw_yellow"` (underscore) :
- `exercises/01-document-typst/correction/rapport-starwars.qmd:75`
- `exercises/02-projet-book/correction/01-anatomie.qmd:47`
- `exercises/02-projet-book/correction/02-origines.qmd:36,121`
- `2-projets/index.qmd:203` (extrait du bonus B4 reproductible)

Le piège est explicitement documenté pour les participants dans `2-projets/index.qmd:243-247` (callout « Piège silencieux à connaître ») avec mécanique correcte : « `brand.yml` normalise les clés palette tiret-séparé en tiret_souligné au read ». Excellent renvoi.

### URLs externes
- `audit-doc-links.sh` couvre 17 URLs (quarto.org + posit-dev.github.io), toutes 200.
- Toutes les URLs internes GitHub pointent sur `cderv/tuto-quarto-typst-rr-2026` (vérifié grep) — pas de fork errant.

### Cohérence `format: typst` vs `orange-book`
- Zéro occurrence de `format: orange-book-typst` ou `extend: orange-book` dans le code actif (`grep -rn "format: orange-book-typst\|extend:" --include="*.qmd" --include="*.yml"` vide hors `.claude/`).
- Le pattern correct `format: typst` activant automatiquement orange-book sur `type: book` est utilisé partout (correction Exo 2 `_quarto.yml:19-20`, slides `2-projets.qmd:49`, supports `2-projets/index.qmd:56`).
- Le pédagogique « orange-book s'active automatiquement » est répété 7+ fois dans les supports (boussole, slides, index Exo 2) — message clair.

---

## Évolution depuis la review précédente (2026-05-19)

### Améliorations techniques observées
1. **Bug `brand_color_pluck("sw-yellow")` résolu partout** — la review du 19/05 (P0 unique) signalait `cell_fill(color = brand_color_pluck(brand, "sw-yellow"))` à `rapport-starwars.qmd:75` qui plantait avec `Error: An invalid color name was used`. Aujourd'hui : 5 occurrences toutes en `"sw_yellow"`, plus un callout pédagogique dédié dans `2-projets/index.qmd:243-247` expliquant le piège (read R normalisant tiret→underscore). Excellente boucle de feedback.

2. **Nouveau dossier `_charte/`** (post-19/05) — méta-exemple proprement structuré : `_brand.yml` identique à celui des corrections, `charte-starwars.qmd` rend une page A4 lisible (logo, palette, typographie, usage), PDF distribué aux participants comme spec graphique. Le « participant voit en regardant la charte ce que produit la déclaration logo de _brand.yml » (README ligne 31) est pédagogiquement fort. Smoke render confirmé.

3. **Logo dimensionné via `format.typst.logo`** (commit `d024d6c` "Shrink charter logo via format.typst.logo to stop title overlap") — workaround propre du bug 1.5in × 0.75in par défaut. La même pattern est appliquée dans `exercises/02-projet-book/correction/_quarto.yml:33-37` et documentée en commentaire YAML, et dans `2-projets/index.qmd:120-127` (modèle copiable participant). Cohérence cross-supports.

4. **Workaround `font-paths` correctement isolé** — sorti du modèle participant principal (`_quarto.yml` simulé dans `2-projets/index.qmd:104-133`) et déplacé dans un callout dépliable « Polices brand pas chargées (Quarto < v1.10.4) » (`2-projets/index.qmd:138-153`). Le participant sur Quarto 1.10.4+ n'a pas à le voir. Conservé en config active dans la correction (défensif). Stratégie pile dans les recommandations de la review précédente.

5. **Refonte Your Turn** — gabarit 3-colonnes uniforme (boussole projetée + page exo + countdown migré sur la boussole), READMEs starter/correction quick-ref, includes de README dans les pages exo (`{{< include … >}}`). Architecture cohérente Exo 1 ↔ Exo 2.

6. **Script `audit-doc-links.sh`** — nouvel outil de robustesse, fait ce qu'il prétend (vérifié), exit 1 si une URL casse, scannés 17 URLs toutes 200. Bon ajout pour le maintien long-terme.

### Ce qui était déjà bon (et le reste)
- Contrastes WCAG AA confirmés sur les 4 combinaisons sw-yellow/sw-black, sw-cream/sw-black, sw-cream/imperial-red.
- Architecture `theme_brand_gt()` + `opt_table_font("Inter")` + 3 `tab_style()` orthogonale (pas de last-wins).
- Conventions slides My/Our/Your turn (callout-note / callout-tip / callout-warning) respectées.
- Hex en dur dans Typst raw inline (`#highlight(fill: rgb("#FFE81F"))[droïdes]` dans le starter Exo 2 `01-anatomie.qmd:42`) — choix pédagogique intentionnel (le brand pas encore créé à ce stade de l'exo) ; la correction passe à `brand-color.sw-yellow` (`01-anatomie.qmd:74`).

---

## Périmètre couvert

| Périmètre demandé | Statut |
|---|---|
| `_charte/_brand.yml` syntaxe + fonts existence | OK (validations 1, 4) |
| `_charte/charte-starwars.qmd` YAML + render | OK (smoke test + visuel) |
| Cohérence brand charte ↔ corrections | OK (diff vide x3) |
| Workaround `font-paths` < 1.10.4 | OK (isolé + documenté) |
| Gabarit Your Turn (boussole, countdown, includes) | OK (smoke render + countdown.lua vérifié) |
| Script `audit-doc-links.sh` | OK (lancé, 17/17 URLs vertes) |
| Anti-patterns / faux claims | 0 P0, 1 P1 (`editor: visual`), 6 P2 |
