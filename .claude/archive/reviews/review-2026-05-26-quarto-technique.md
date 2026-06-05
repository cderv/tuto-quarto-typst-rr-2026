# Review technique Quarto+Typst — 2026-05-26

## VERDICT GENERAL

Les supports sont techniquement sains dans leur ensemble : aucune syntaxe Quarto/Typst invalide dans le code actif, la progression Our turn → Your turn est cohérente avec les corrections, les claims orange-book et 1.10.4+ sont corrects. Une divergence factuelle entre une callout publique et la réalité filesystem (`_logo-sw.svg`), un commentaire R qui sous-entend un plancher de version plus strict qu'annoncé, et un cross-ref `@sec-origines` déjà présent dans le starter (résolution silencieuse en mode non-book) méritent attention avant le 16 juin. Aucun bug bloquant le rendu.

## P0 — Aucun bug technique bloquant

Aucun bug P0 identifié. Les rendus déjà effectués (`.typ` committé dans `correction/`) confirment que la chaîne fonctionne.

## P1 — À corriger avant le 16 juin

### P1-1 — Callout publique "dossier exo" incorrect pour `_logo-sw.svg`

`2-projets/2-projets.qmd:129` — la callout visible par le participant dit :

```
> Pas de `_brand.yml` ? `_brand-fallback.yml` + `_logo-sw.svg` dispo dans le dossier exo.
```

`_brand-fallback.yml` est bien à la racine `exercises/02-projet-book/`, mais `_logo-sw.svg` est uniquement dans `exercises/02-projet-book/correction/`. La speaker note ligne 135 dit correctement `correction/_logo-sw.svg`. Un participant qui cherche `_logo-sw.svg` à la racine du dossier exo ne le trouvera pas. Le `README.md` starter et `2-projets/index.qmd:165` pointent bien vers `correction/_logo-sw.svg` — seule la callout slide est erronée. Corriger en `_brand-fallback.yml` (dossier exo) + `_logo-sw.svg` ([`correction/`](…)).

### P1-2 — `@sec-origines` dans le starter résout en mode non-book (warning silencieux)

`exercises/02-projet-book/starter/01-anatomie.qmd:43` contient `@sec-origines`. Lors de l'étape 1 (5 PDF séparés, `type: default`), chaque fichier est rendu isolément et `@sec-origines` ne peut pas résoudre — Quarto produit un warning et affiche `@sec-origines` littéralement dans le PDF. Aucun blocage, mais le participant voit une référence cassée dans le PDF de l'étape 1 et pourrait croire à une erreur. Le starter du Bloc 2 est issu de la correction du Bloc 1 (`rapport-starwars.qmd` recyclé) où ce texte était dans un document unique. Dans le book starter, la référence n'a de sens qu'en contexte livre (étapes 2a+). À minima, la boussole / consigne pourraient noter que la référence `@sec-origines` dans `01-anatomie.qmd` est intentionnellement cassée à l'étape 1 et se résoudra à l'étape 2.

## P2 — Nice-to-have / robustesse

### P2-1 — `preparatifs.qmd:45` : plancher `1.9.37` vs `1.9` en texte principal

Le commentaire R dans le snippet de vérification dit `# 1.9.37 minimum, 1.10.x pre-release recommandée`. Le texte principal dit `stable 1.9 ou supérieure`. Un participant avec Quarto 1.9.0 pourrait penser qu'il est bloqué en lisant le commentaire. Aligner sur `# >= 1.9` ou `# 1.9.x minimum` pour cohérence avec le texte.

### P2-2 — `_brand-fallback.yml` n'est pas offline-safe (nomming potentiellement confusant)

`exercises/02-projet-book/_brand-fallback.yml` utilise `source: google` pour Inter — il nécessite internet. Seul `_brand-offline.yml` est truly offline. La distinction est documentée dans `preparatifs.qmd`, mais pendant la séance un participant "sans réseau" qui utilise `_brand-fallback.yml` (copié parce qu'il n'a pas fini Bloc 1) verra Inter échouer silencieusement et une police de fallback apparaître. Pas de correction structurelle nécessaire — juste s'assurer que l'animateur connaît la distinction (c'est dans les speaker notes, bien).

### P2-3 — `star_jedi.zip` et `star_jedi/` non-gitignorés à la racine

Ces fichiers apparaissent comme untracked dans `git status`. Ils ne font pas partie du matériel pédagogique et ne sont pas dans `.gitignore`. À ajouter à `.gitignore` ou supprimer si artefact temporaire.

### P2-4 — Exercice 2 starter : cross-ref `@sec-origines` dans `conclusion.qmd` absent

Le bonus B1 demande au participant d'ajouter `@fig-anatomie-mass` et `@sec-origines` dans `conclusion.qmd`. Le starter `conclusion.qmd` ne contient pas ces références (correct — c'est l'action du bonus). La cible `fig-anatomie-mass` existe dans le starter `01-anatomie.qmd` (label `#| label: fig-anatomie-mass`). La cible `{#sec-origines}` existe dans le starter `02-origines.qmd`. Les deux cibles sont présentes dans le starter avant que le participant n'effectue le bonus — la résolution fonctionnera dès l'ajout en `conclusion.qmd`. Aucune correction nécessaire, juste confirmation que le setup est propre.

## Choix techniques validés

- **`format: typst` exclusivement** (forme courte ou longue selon besoins). Aucune occurrence de `format: orange-book-typst` ou `extend: orange-book` dans le code actif. La forme courte `format: typst` est utilisée pour les cas sans options (`_speaker/`, snippets Our turn), la forme longue uniquement quand des options sont requises. Conformité parfaite avec la convention Quarto.
- **`font-paths:` toujours sous `format.typst:`.** Vérifié dans `exercises/02-projet-book/correction/_quarto.yml:27` et `_charte/charte-starwars.qmd:9`. Jamais au top-level ni sous `book:`.
- **`_brand.yml` syntaxe conforme.** Toutes les instances respectent la syntaxe : `color.palette` dict nommé + hex entre guillemets, `color.primary/foreground/background` assignments, `typography.fonts` liste de dicts avec `family/source`, `logo.images` map + `logo.medium`. La clé `source: google` (online) vs `source: file` + `files:` (offline) est correctement différenciée entre `_brand.yml` et `_brand-offline.yml`.
- **Orange-book auto-activation correctement décrit.** Le claim `format: typst` + `type: book` active automatiquement orange-book depuis Quarto 1.9 est vérifié : l'extension est dans `share/extension-subtrees/orange-book/` avec `_extension.yml` (`quarto-required: ">=1.9.17"`).
- **Partial override `_extensions/orange-book/typst-show.typ` dans la correction.** Override du template partial bundlé, pas une extension Quarto autonome. Différence avec bundled : ligne `title: [#text(font: ("Star Jedi",))[$title$]]` pour rendre le titre de couverture en Star Jedi. Usage documenté et correct du mécanisme de template partials.
- **Cross-refs correction Exo 2.** Labels définis (`fig-anatomie-mass` dans `01-anatomie.qmd:80`, `{#sec-origines}` dans `02-origines.qmd:1`, `tbl-origines-films` dans `02-origines.qmd:97`) et utilisés correctement. `lang: fr` dans `correction/_quarto.yml` produit bien `crossref-fig-title: "Figure"`, `crossref-tbl-title: "Table"`, `crossref-apx-prefix: "Annexe"`. Claims "Figure 1.1", "Table 1.1", "Annexe A" exacts.
- **`_brand.yml` Typst raw inline `brand-color.sw-yellow`.** La clé hyphenée `sw-yellow` est accessible en Typst via dot notation parce que Typst accepte les tirets dans les identifiants de champs.
- **`logo.images.sw-star` + `logo.medium: sw-star` syntaxe `_brand.yml`.** Forme correcte pour Quarto books. Le Lua filter lit `foundLogo.path` et le résout à partir du mediabag.
- **Workaround `font-paths` pour `< v1.10.4` correctement documenté et conditionnel.** La callout collapse "Polices brand pas chargées (Quarto < v1.10.4)" dans `2-projets/index.qmd:140-156` explique précisément le bug, le fix commit, et les versions concernées. Le workaround est gardé dans `correction/_quarto.yml:22-29` avec commentaire explicatif — inoffensif sur 1.10.4+.
- **`execute:` block cohérent.** `starter/rapport-starwars.qmd` : `echo: false/warning: false/message: false` dans YAML. Correction Exo 1 : même bloc. Correction Exo 2 (`_quarto.yml`) : même bloc au niveau projet (les fichiers chapitres n'ont pas de bloc `execute` local — correct, ils héritent du projet).
- **`.content-visible when-format="typst"` + `{{< pagebreak >}}`.** Usage propre dans `correction/conclusion.qmd:12-14`. La notation non-escapée `{{< pagebreak >}}` (vs `{{</* pagebreak */>}}` dans le snippet de la consigne) est intentionnelle.
- **Pas de chapitre fantôme titre YAML + H1 body.** Tous les fichiers chapitres du book commencent par un H1 sans titre YAML — convention book correcte.
- **`lang: fr` uniquement dans `_quarto.yml` (deux niveaux) et non dupliqué.** Présent dans le site root (`_quarto.yml:35`) et dans la correction book. Absent des documents individuels — correct (héritage projet).
- **Liens GitHub tous sur `cderv/tuto-quarto-typst-rr-2026`.** Aucun lien sur un autre repo owner.
- **Demo Bloc 1 Our turn (snippets orateur)** — étape 1 (`format: typst`) produit PDF avec polices Typst par défaut, sans couleur. Étape 2 (`_brand.yml` avec `primary: imperial-red`) produit des titres et liens rouges. Séquence techniquement correcte.
- **Demo Bloc 2 Our turn (snippets orateur)** — étape 1 (`type: default` + `format: typst`) produit 5 PDFs séparés. Étape 2 (`type: book` + bloc `book:` minimal, 4 fichiers dans `chapters:`) active orange-book et produit un PDF unique avec couverture, TOC, numérotation par chapitre. `annexe-donnees.qmd` reste hors de `chapters:` à cette étape — il apparaît comme dernier chapitre numéroté (comportement correct, Your turn ajoute `appendices:`).
