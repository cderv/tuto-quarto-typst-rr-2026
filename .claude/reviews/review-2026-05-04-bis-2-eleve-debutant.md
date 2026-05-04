# Review participant·e débutant·e — 2ᵉ relecture, 2026-05-04

> Tutoriel RR 2026 — branche `claude/quarto-book-skeleton-qeDNI`, commit `34e8d0f`
>
> Profil : R + RStudio depuis 2-3 ans, R Markdown occasionnel, jamais touché à Quarto en projet ni à Typst.

## Verdict général

Je m'en sors le 16 juin, mais pas sans frictions. Les 14 commits du matin ont vraiment polishé le matériel : vouvoiement uniforme, vocabulaire FR, étapes 2a/2b séparées, modèle `_quarto.yml` complet, callout sur le bug `gt`. Bloc 1 est très bien calibré pour mon niveau. **Mais un piège silencieux costaud reste sur Bloc 2 étape 3** : le modèle `_quarto.yml` officiel ne contient PAS le workaround `font-paths: .quarto/typst/fonts` que la correction utilise — sans lui, mes polices Inter/Orbitron ne se chargent pas dans le book et je vais voir des `warning: unknown font family: orbitron` rouges en console que je ne saurai pas comment interpréter. C'est mon point de panique le plus probable. Le reste tient surtout du « nice-to-have ».

## 🔴 P0 — bloquant pour le 16 juin

### `font-paths` workaround manquant dans le modèle `_quarto.yml` côté participant

**Fichiers concernés :**
- `exercises/02-projet-book/README.md:31-52` (modèle README)
- `2-projets/index.qmd:78-99` (modèle page web)
- `2-projets/2-projets.qmd:34-50` (slides)

La correction `exercises/02-projet-book/correction/_quarto.yml:19-25` contient :

```yaml
format:
  typst:
    font-paths:
      - .quarto/typst/fonts
```

avec un commentaire explicite : *« Workaround Quarto book : les polices téléchargées par `_brand.yml` (`.quarto/typst/fonts/`) ne sont pas passées automatiquement à typst en mode book. À retirer quand le bug upstream est fixé. »*

Aucun des trois modèles côté participant ne contient ce workaround. **J'ai testé** : avec le modèle officiel du README + `_brand-fallback.yml` + `_logo-sw.svg`, le rendu produit `warning: unknown font family: orbitron` et `warning: unknown font family: inter` (Quarto les a téléchargées dans `.quarto/typst/fonts/` mais ne les retrouve pas). Le PDF se génère, mais sans Orbitron/Inter — donc l'« étape 3 = charte jaune SW + Orbitron + Inter » promise N'A PAS LIEU. Et l'erreur rouge en console est intimidante : je vais soit appeler à l'aide, soit penser que mes 5 minutes de débogage sur l'indentation YAML étaient mal faites.

Le bug `gt` « 1 7 5 » documenté dans le callout est également plus probablement déclenché parce qu'Inter n'est pas trouvée (les fallback génériques s'appliquent), pas seulement à cause du bug gt.

**Impact** : ~tout le monde tombera dessus à l'étape 3 (« le pic émotionnel du Bloc 2 »). C'est le seul vrai P0 que je vois.

**Fix proposé** : ajouter le bloc `font-paths` dans le modèle `_quarto.yml` du README et de la page web, avec un commentaire « workaround temporaire » comme dans la correction. La slide deck peut rester sans (le modèle slides reste `format: typst` simple par souci de pédagogie), mais le présentateur doit le mentionner à l'oral pendant Our turn.

## 🟠 P1 — à corriger avant le 16 juin

### Slide Exercice 2, B2 : le shortcode `{{< pagebreak >}}` est interprété au lieu d'être affiché

`2-projets/2-projets.qmd:105`

```
- B2. `.content-visible when-format="typst"` + `{{< pagebreak >}}`
```

Le shortcode `{{< pagebreak >}}` n'est pas échappé. Dans le HTML rendu (`_site/2-projets/2-projets.html`) ça donne :

```html
<li>B2. <code>.content-visible when-format="typst"</code> + <code></code></li>
```

→ un `<code></code>` vide. Si je révise les slides en PDF download, je vois B2 sans le mot « pagebreak » nulle part. La page web `2-projets/index.qmd:65-71` échappe correctement avec un fenced code block ` ````markdown ` ; les slides devraient faire pareil ou utiliser `{{</* pagebreak */>}}`.

### Promesse non tenue : « brander aussi les ggplot/gt »

`exercises/01-document-typst/README.md:30-33` étape 4 :

> « couleurs, fonds et typographies sont appliqués automatiquement, dans le PDF **et** dans les figures ggplot/tableaux gt si vous utilisez les helpers du package `brand.yml`. »

Or :
- Le starter `exercises/01-document-typst/starter/rapport-starwars.qmd` n'utilise PAS les helpers brand.yml (pas de `library(brand.yml)`, pas de `brand_color()`).
- Même la correction `exercises/01-document-typst/correction/rapport-starwars.qmd` ne les utilise pas (juste `theme_minimal`, fill `"#0B0B0F"` codé en dur dans `02-origines.qmd`).

Donc en suivant les 4 étapes, mon ggplot ne va PAS se mettre aux couleurs SW. Je vais me dire « j'ai mal fait quelque chose », alors que non. Il faut soit retirer cette promesse de l'étape 4, soit ajouter une étape « bonus » qui montre les helpers, soit reformuler en « le texte/titres/fonds sont brandés ; pour aussi brander vos ggplot/gt, le package `brand.yml` propose des helpers à explorer (voir Ressources) ».

### Étape 3 du Bloc 2 : « Copiez `_brand.yml` (+ `_logo-sw.svg`) à la racine » est ambigu

`2-projets/index.qmd:36, 56` ; `2-projets/2-projets.qmd:76, 100` ; `exercises/02-projet-book/README.md:25`

Si j'ai bien fait Exo 1, mon `_brand.yml` ne contient PAS de bloc `logo:` (la correction Exo 1 `exercises/01-document-typst/correction/_brand.yml` n'en a pas non plus). Donc en copiant mon `_brand.yml` Bloc 1 à la racine + `_logo-sw.svg`, je n'aurai PAS le logo sur la couverture. La promesse « Couverture jaune Star Wars + logo » échoue.

Ce n'est rattrapable que par le `_brand-fallback.yml` (qui, lui, contient bien le bloc `logo:`). Mais je ne le sais pas si je suis arrivé·e jusqu'à l'étape 3 « par moi-même » — j'irai au fallback uniquement si je n'ai rien produit en Bloc 1.

**Fix proposé** : soit à l'étape 4 du Bloc 1, ajouter explicitement un bloc `logo:` à inclure dans le `_brand.yml` (même sans image, ça documente l'API) ; soit dans l'étape 3 du Bloc 2, dire « si votre `_brand.yml` Bloc 1 n'a pas de bloc `logo:`, ajoutez-y celui-ci : … ».

### `preparatifs.qmd` : la vérification ne couvre pas le scénario « rendre du Typst »

`preparatifs.qmd:33-41`

```r
quarto::quarto_version()
library(dplyr)
head(starwars)
```

C'est utile mais ça ne teste PAS un rendu `format: typst`. Je vais arriver le matin sans avoir validé que :
- Quarto trouve le binaire Typst embarqué (rare mais possible si install corrompu)
- Le download des polices Google fonctionne (firewall corp)
- `gt` rend correctement en Typst sur ma machine

Proposer un mini `test.qmd` avec `format: typst` + un chunk `head(starwars) |> gt::gt()` à rendre, pour valider la chaîne complète. Ça réduirait significativement les pannes en début de tutoriel.

### Packages `brand.yml` et `prismatic` listés mais jamais utilisés

`preparatifs.qmd:18`

```r
pkg <- c("rmarkdown", "quarto", "dplyr", "ggplot2", "ggrepel", "gt", "knitr", "scales", "brand.yml", "prismatic")
```

Aucun usage de `library(brand.yml)` ni `library(prismatic)` dans les exercices (vérifié : `grep -rn "library(brand\|library(prismatic)"` → rien). Je vais installer 2 packages inutiles, ce qui peut prendre du temps si j'ai une connexion lente ou un CRAN binaire pas à jour. Si ces packages servent uniquement aux notes presenter ou à un possible bonus oral, ce n'est pas grave, mais alors documenter pourquoi ; sinon les retirer.

### `index.qmd:20` promet du contenu qui n'est plus dans le programme

```
- Comment aller plus loin avec les template partials et les extensions ?
```

Le programme officiel (Bloc 1 + Bloc 2) ne couvre PAS les template partials ni les extensions. Le contenu existe en topic store (`3-aller-plus-loin/index.qmd`) mais cette page n'est référencée NULLE PART en navigation visible — ni navbar, ni autre page. C'est une promesse non tenue en Q&A : si quelqu'un demande « j'attendais voir partials, où est-ce ? », la réponse sera « voir 4-ressources.qmd » qui mentionne les partials mais pas comme contenu du tutoriel.

**Fix proposé** :
- soit alléger la promesse de `index.qmd` en remplaçant la 4ᵉ puce par « Comment aller plus loin ? » et lien vers 4-ressources ;
- soit ajouter `3-aller-plus-loin/index.qmd` à la navbar (le `_quarto.yml` ne le référence pas — j'ai vérifié).

## 🟡 P2 — nice-to-have

### Notation YAML inline `project: { type: default }`

`2-projets/index.qmd:34, 53` ; `2-projets/2-projets.qmd:74, 98` ; `exercises/02-projet-book/README.md:22`

Pour quelqu'un qui découvre Quarto, voir `project: { type: default }` (flow notation) puis devoir taper `project:\n  type: default` (block notation) dans son fichier réel = micro-frottement. Je vais peut-être copier-coller la flow notation, qui marche d'ailleurs, mais qui n'est pas ce que la correction utilise. Préférer la forme block partout en prose, ou expliquer qu'on peut écrire les deux.

### `mainfont: Inter` à l'étape 2 sans `_brand.yml`

`exercises/01-document-typst/README.md:20-21` étape 2 dit :

> ajoutez `papersize`, `margin`, `toc: true`, `number-sections: true`, `mainfont: Inter`, `linestretch: 1.4`. Re-rendez et observez la différence.

Mais Inter n'est pas installée par défaut sur la majorité des macOS/Windows. **J'ai testé** : sans `_brand.yml`, ajouter `mainfont: Inter` produit `warning: unknown font family: inter` au rendu. Le PDF est produit avec une police fallback. Le débutant qui voit ce warning peut paniquer.

Suggestion : à l'étape 2, utiliser `mainfont: Helvetica` ou `mainfont: Arial` (présent partout par défaut) ; mettre `Inter` à l'étape 4 quand le `_brand.yml` télécharge la police. Ou bien, mentionner explicitement « si vous voyez un warning `unknown font family`, c'est normal, l'étape 4 résout ça ».

### Vocabulaire « intimidant » non défini

- **« partials »** apparaît dans la pépite slide Bloc 2 (`2-projets/2-projets.qmd:127`) sans définition (« Le fichier `typst-show.typ`… contrôle la génération du `.typ` »). Pour un débutant, « partials » est un terme étranger. La page Ressources (`4-ressources.qmd:103`) le documente mais c'est ailleurs.
- **« Marginalia »** apparaît une seule fois (`4-ressources.qmd:41`) sans définition : « article layout avec figures, légendes et notes de marge (`.column-margin`, `.aside`) ». Bon, là c'est entre parenthèses, donc OK.
- **« orange-book »** est OK, défini en clair sur `2-projets/index.qmd:28`.
- **« cross-ref »** : utilisé seulement dans le tableau bonus B1 du README (`exercises/02-projet-book/README.md:70`) avec exemple visuel, donc OK.

### Le starter `README.md` est légèrement trompeur

`exercises/02-projet-book/starter/README.md:3-5`

> « Sans fichier de configuration de projet, `quarto render` produit 5 PDF séparés (au lieu d'un livre). »

En réalité, sans `_quarto.yml` ni `format:` dans les `.qmd`, `quarto render starter/` produit 5 **HTML**, pas 5 PDF. Les 5 PDF n'apparaissent qu'après création du `_quarto.yml` avec `format: typst`. Reformulation possible : « … `quarto render` produit 5 fichiers séparés (par défaut HTML) ; après l'étape 1, ce seront 5 PDF Typst. »

### `tbl-cap` manquant sur les `tbl-*` chunks gt

`exercises/02-projet-book/starter/01-anatomie.qmd:18`, `02-origines.qmd:16` ; idem dans les corrections.

Les chunks `#| label: tbl-anatomie-mass` etc. n'ont pas de `#| tbl-cap:`. Quarto utilisera le `tab_header(title = ...)` du gt comme caption, mais ce n'est pas la voie « propre » pour les crossrefs. En pratique le bonus B1 référence quand même `@fig-anatomie-mass`, jamais `@tbl-anatomie-mass`, donc impact = 0 pour l'exercice. Mais c'est un détail de qualité.

### Topic store `3-aller-plus-loin/index.qmd` toujours invisible

Aucun lien vers cette page dans la navbar ni dans le contenu visible (j'ai cherché avec `grep -rn "aller-plus-loin"` — aucun hit hors README dev et `.claude/`). Donc la promesse « topic store accessible aux participants curieux » n'est pas remplie. Soit la mettre en navbar, soit la lier depuis `4-ressources.qmd` comme « index des sujets non couverts dans le tutoriel ».

### Slide Bloc 2 dit « 5 PDF » pour étape 1 mais le terme « PDF » n'est pas neutre

`2-projets/2-projets.qmd:74`, `2-projets/index.qmd:34` : « → 5 PDF séparés ». OK c'est cohérent partout. Pas un blocage.

## ✅ Ce qui me rassure

- **`exercises/01-document-typst/README.md`** très lisible : « Démarche en 4 étapes incrémentales » avec verbe d'action clair pour chaque (« Passer en Typst », « Régler la mise en page », « Inspecter », « Brander »). Je sais où je vais.
- **Vouvoiement et style** uniformes — c'est apaisant, je ne sens jamais le décalage tutoiement / vouvoiement comme dans la review du matin.
- **`_quarto.yml` modèle complet** dans le README Exo 2 (lignes 31-52) avec `execute: echo/warning/message: false` — ça résout le « comment je masque le code R » que j'aurais bricolé pendant 5 min. Très bonne addition.
- **Étape 2a / 2b séparées** dans la table d'étapes : très clair, je vois bien pourquoi `appendices:` change quelque chose. Le découpage en 4 fragments YAML sur la slide `code-line-numbers="1-2|4-9|10-11|13"` accompagne bien.
- **Bloc B2 en code-block copiable** dans la page web Bloc 2 (`2-projets/index.qmd:65-71`) — je peux faire copier sans risque de mal échapper le shortcode (contrairement à la slide).
- **Note bug `gt` « 1 7 5 »** côté participant (`2-projets/index.qmd:103-107`) : c'est un callout-warning collapsable, ça ne pollue pas la lecture mais c'est dispo si je tombe dessus. Bon réflexe pédagogique.
- **Plan B pas de réseau** dans `preparatifs.qmd:43-51` — j'aime bien cette anticipation.
- **L'iframe slide deck** sur la page Bloc 1/2 me permet de scroller les slides sans changer de fenêtre. Pratique pendant les exercices.
- **Countdown** : `{{< countdown 15:00 >}}` est rassurant en haut de la slide Your turn.
- **Autonomie Exo 2 vis-à-vis Exo 1** explicitement annoncée (`2-projets/index.qmd:40-42`) : pas de panique si j'ai pas fini Exo 1.
- **Star Wars / Mon Mothma** : c'est ludique, ça allège l'apprentissage, je trouve ça sympa.
- **Page `4-ressources.qmd`** très complète. Si je veux refaire l'Exo 2 chez moi, j'ai les liens. La section « Aller plus loin avec Quarto » de Mickaël Canouil est un bon pointeur.

## 📝 Évolution depuis la review du matin

### Améliorations très visibles pour moi
- Vouvoiement uniforme (« Créez », « Passez ») — je ne suis plus baladé entre tutoiement et vouvoiement.
- Vocabulaire FR (charte au lieu de « brand », titres au lieu de « headings ») dans la prose. Les mots-clés YAML restent en code, ce qui est juste.
- Étape 2 splittée en 2a (chapter) / 2b (appendice). Mon point de confusion principal de la review du matin est résolu.
- Modèle `_quarto.yml` complet pour Exo 2, avec `execute:` ajouté en finale. Évite que je galère avec `echo: false`.
- Note bug `gt` côté participant — savoir « c'est un bug connu, voici le fix » m'évite 10 min de panique.
- B2 bloc `.content-visible`/`pagebreak` en code-block copiable dans la page web — les guillemets et accolades étaient un piège typique.
- README racine trimmé, timings 5→15 min cohérents, et le slide deck Bloc 3 supprimé (donc plus de promesse fantôme dans la navbar).

### Ce qui était déjà bon et qui le reste
- Démarche pédagogique claire : My turn / Our turn / Your turn — je sais à chaque instant ce qu'on attend de moi.
- Star Wars comme fil rouge — ludique, sans charge cognitive supplémentaire.
- 15 min de countdown avec `{{< countdown >}}` — me rassure sur le tempo.
- `keep-typ: true` comme moment pédagogique pour démystifier le pipeline.
- L'iframe slide deck sur les pages de bloc — je peux suivre sans switcher de fenêtre.

### Ce qui reste à régler avant le 16 juin
- **P0** : workaround `font-paths` manquant dans le modèle `_quarto.yml` côté participant (impact : tout le monde à l'étape 3 du Bloc 2).
- **P1** : shortcode `{{< pagebreak >}}` interprété sur la slide B2 (impact : confusion sur slide PDF download).
- **P1** : étape 3 du Bloc 2 demande `_logo-sw.svg` mais le `_brand.yml` du Bloc 1 n'a pas de bloc `logo:` (impact : pas de logo si on suit le chemin « par soi-même »).
- **P1** : promesse « brander ggplot/gt » à l'Exo 1 étape 4 non tenue par le starter ni la correction.
- **P1** : `index.qmd:20` promet « template partials et extensions » qui ne sont plus dans le programme.

Si seul P0 est corrigé d'ici le 16 juin, je m'en sors largement bien. Les P1 sont des frottements, pas des bloqueurs.
