# Review contenu — 2026-05-04 (post-polish)

Reviewer : reviewer agent (final pass). Branche : `claude/quarto-book-skeleton-qeDNI`.

## Verdict général

**CD a raison : niveau contenu, c'est bon.** Le sweep post-review du jour a tenu — la cohérence transverse est solide (vouvoiement, vocabulaire FR, `format: typst`, `Figure 1.1` partout, plus aucune mention de `format: orange-book-typst`). Star Wars est cohérent bout-à-bout, l'arc `.qmd → PDF pro → livre → personnalisé` est tracé proprement, le rendu site complet passe sans warning Pandoc, les renders Typst end-to-end produisent des PDFs (avec uniquement les warnings fonts fallback Linux attendus). Les YAML headers sont conformes (HTML / clean-revealjs, `author: ""`/`date: ""`, `fig-alt`).

**Un seul vrai trou** : la page `3-aller-plus-loin/index.qmd` est restée orpheline. Slide deck supprimé, navbar nettoyée, mais la page contient toujours un « Exercice 3 » avec deux liens cassés `(#)`. C'est le seul vrai irritant fonctionnel à régler avant le 16 juin (P1, pas P0 — la page n'est pas dans la navbar, donc impact limité). Le `README.md` racine est aussi désynchronisé (parle encore de Bloc 3 actif), mais c'est un asset GitHub, pas du contenu workshop.

## 🔴 P0 — bloquant pour le 16 juin

_Aucun._

## 🟠 P1 — à corriger avant le 16 juin

### `3-aller-plus-loin/index.qmd` — Exercice 3 fantôme avec liens cassés

- `3-aller-plus-loin/index.qmd:46-57` — section « Exercice 3 » entière contient deux liens vides `(#)` :
  - `3-aller-plus-loin/index.qmd:51` → `[exercices/03-templates/](#)` (note : aussi orthographié `exercices` au lieu d'`exercises`, mais le dossier n'existe pas de toute façon)
  - `3-aller-plus-loin/index.qmd:62` → `[Voir la correction](#)`
- La page n'est pas dans la navbar (vérifié `_quarto.yml`) ni linkée depuis d'autres pages QMD, mais elle est rendue (`_site/3-aller-plus-loin/index.html`). Si un participant tombe dessus via `search.json` ou un deep link, il verra des liens morts.
- Recommandation : soit retirer entièrement le bloc Exercice 3 + Correction (la page reste un topic store comme prévu), soit supprimer la page (et nettoyer `_site/3-aller-plus-loin/`).
- Aussi `3-aller-plus-loin/index.qmd:9` : `## ⏱️ ~25 minutes` — timing fantôme (la page n'est plus dans le programme principal, qui ne fait que 2 blocs de 40 min).

### `README.md` — désynchronisé avec l'état réel du repo

- `README.md:17-31` programme avec **Bloc 3 actif** (25 min, 3 sections, Exercice 3) — n'existe plus.
- `README.md:97-133` détail Bloc 3 idem.
- `README.md:170-172` arborescence mentionne `3-aller-plus-loin.qmd` (slides Bloc 3) — supprimé.
- `README.md:18-25` timings « Exercice 1 / 2 → 5 min » — la réalité est 15 min côté `index.qmd` et `1-quarto-typst.qmd:176`.
- `README.md:151` checkbox Q3 sur garder Exercice 3 — caduque.
- Hors périmètre review utilisateur (le README est meta), mais c'est ce que voient les visiteurs sur GitHub. Recommandation : trim aggressif pour aligner sur le programme 2 blocs réel.

## 🟡 P2 — nice-to-have

### Cohérence forme `format: typst` vs `format: typst: default` (Bloc 2 slide étape 1)

- `2-projets/2-projets.qmd:19-20` montre la forme longue :
  ```yaml
  format:
    typst: default
  ```
  Alors que partout ailleurs (étape 2 slide L50, page index L93, README Exo 2 L46, modèle complet) c'est la forme courte `format: typst`. Pas faux, mais inconsistant. Possible source de confusion : « pourquoi ici c'est `typst: default` et là c'est `typst` tout court ? ». Suggestion : harmoniser sur `format: typst` (forme courte) pour la slide étape 1 aussi.

### `2-projets/2-projets.qmd:101` — anglicisme « brand » résiduel

- « `_brand.yml` (+ `_logo-sw.svg`) à la racine → **brand jaune SW** » — résidu du sweep vocabulaire FR (le terme « charte » a été appliqué partout sauf ici). Suggestion : `→ charte jaune SW` (cohérent avec les notes presenter ligne 81 « la charte de Bloc 1 ressuscite »).

### `2-projets/2-projets.qmd:105` — anglicisme « Cross-refs »

- « B1. Cross-refs `@fig-anatomie-mass` + `@sec-origines` » — autre vestige anglais en prose. Suggestion : `B1. Références croisées …` (cohérent avec `2-projets/index.qmd:35` qui dit « références croisées numérotées »).

### Starter Exo 2 sans `execute: echo: false` dans le modèle `_quarto.yml`

- Le modèle `_quarto.yml` proposé (page `2-projets/index.qmd:78-94` et README `exercises/02-projet-book/README.md:31-47`) **ne contient pas** de bloc `execute:`. Or la correction (`exercises/02-projet-book/correction/_quarto.yml:27-30`) l'inclut (`echo: false`, `warning: false`, `message: false`). Conséquence : le PDF produit par un participant qui suit littéralement le modèle aura le code R visible et probablement des warnings/messages bruyants. La similarité visuelle avec la correction (objectif clé de l'exercice) sera compromise.
- Suggestion : ajouter `execute: { echo: false, warning: false, message: false }` au modèle. Ou mentionner explicitement la différence dans une note.

### `exercises/01-document-typst/README.md:8` — « brandé »

- « le transformer en PDF Typst propre et brandé » — anglicisme léger. Le sweep FR a décidé « charte » ; pourrait devenir « PDF Typst propre, aux couleurs de votre charte ». Très mineur.

### Iframe height un peu juste

- `1-quarto-typst/index.qmd:17` et `2-projets/index.qmd:17` : `height="420"` pour les iframes — la slide « `_brand.yml` — un doc stylé en un fichier {.smaller} » avec ses 2 colonnes peut être un peu écrasée à cette hauteur. Pas critique, ouvrir en plein écran via le lien au-dessus marche.

## ✅ Forces

- **Arc narratif visible** : `index.qmd` (programme 40+10+40), `1-quarto-typst/index.qmd` (Bloc 1 « avant la pause »), `2-projets/index.qmd` (Bloc 2 « après la pause »), starter Exo 1 conclusion qui pointe explicitement vers Bloc 2 (`exercises/01-document-typst/starter/rapport-starwars.qmd:83`), starter Exo 2 qui réutilise les mêmes labels (`fig-anatomie-mass`, `tbl-anatomie-mass`) que la version solo. La progression `.qmd → PDF pro → livre → personnalisé` est lisible.
- **Star Wars cohérent bout-à-bout** : top mass / Jabba / droïdes / planète d'Amidala / R2-D2-C-3PO se renvoient les uns aux autres entre Exo 1 → Exo 2 chapitres → conclusion. Aucun résidu de manchots/penguins.
- **Étape 2a/2b bien découpée** : la page (`2-projets/index.qmd:54-55`) et le README (`exercises/02-projet-book/README.md:23-24`) explicitent le moment où `annexe-donnees` bascule de chapitre numéroté à « Annexe A ». La slide (`2-projets/2-projets.qmd:35`) fait le découpage 4-fragments via `code-line-numbers="1-2|4-9|10-11|13"`, cohérent avec la narration des notes presenter (L66-67).
- **Bug `gt` documenté côté participant** : callout warning sur `2-projets/index.qmd:98-102` + bloc équivalent `exercises/02-projet-book/README.md:54-59` + commentaire inline dans la correction `exercises/01-document-typst/correction/rapport-starwars.qmd:61-63` + notes presenter dans les 2 decks. Mention par tous les canaux : participant prévenu, presenter peut anticiper.
- **Plan B sans réseau** : `preparatifs.qmd:43-51` + `_brand-offline.yml` + `_fonts/` côté correction Exo 1, opérationnel. Un truc en moins à gérer le matin.
- **Pépite « Template partials » bien reformulée** : `2-projets/2-projets.qmd:128` confirme que `typst-show.typ` suffit en pratique pour orange-book — message honest, pas survendu.
- **Conventions slides respectées** : `My turn` callout note, `Our turn` callout-tip + background `#27ae60`, `Your turn` callout par défaut + background `#FDC538` + `{{< countdown 15:00 >}}`. Cohérent entre les 2 decks.
- **`fig-alt` présent** sur toutes les figures R (4/4 vérifiées dans les exos).

## 📝 Notes

### Vérifications faites (synthèse pour CD)

- **Render** : `quarto render` racine → `_site/index.html` produit, **0 warning Pandoc**, 8/8 fichiers QMD rendus.
- **Render Typst** : Exo 1 correction → `rapport-starwars.pdf` OK ; Exo 2 correction → `_book/Anatomie-d-une-saga.pdf` OK. Warnings fonts fallback Linux uniquement (Helvetica/Arial/sans-serif/Roboto/system-ui/Apple Color Emoji/Segoe UI Symbol — attendus).
- **Refs slide deck supprimé** : aucune occurrence de `3-aller-plus-loin.html` ni d'iframe pointant dessus dans les sources QMD/HTML rendus. ✅
- **Tutoiement résiduel** : grep sur `\b(tu|toi|ton|ta|tes)\b` → 0 hit dans les sources (hors notes presenter qui sont OK).
- **`format: orange-book-typst` résiduel** : 0 hit dans le contenu (uniquement dans `.claude/plans/exo2-book.md` qui est meta, hors périmètre).
- **`Fig 1.1` / `Tab 2.1` résiduels** : 0 hit dans le contenu visible (uniquement dans `.claude/`).
- **Open-Source casing résiduel** : 0 hit. ✅
- **« échelle » / « planète » sans accent** : les hits trouvés sont des labels chunks techniques (`fig-origines-especes`) ou des `cols_label` volontairement sans accent (commentaire à `01-document-typst/correction/rapport-starwars.qmd:57` explique le workaround bug gt). ✅
- **Liens GitHub** : tous sur `cderv/cderv-tuto-quarto-typst-rr-2026/.../main/...`. À l'évidence ils ne marcheront que si `main` reflète le contenu de la branche `claude/quarto-book-skeleton-qeDNI` au moment du déploiement (le merge gère ça).
- **Liens vides `(#)`** : 2 hits, tous deux dans `3-aller-plus-loin/index.qmd` (cf. P1).
- **YAML headers** : 100 % conformes à la convention CLAUDE.md (HTML pages = `format: html` + `author: ""` + `date: ""` ; slides = `format: clean-revealjs` + auteur/date pleins).
- **Cross-refs `@fig-` / `@sec-`** : `@fig-anatomie-mass` et `@sec-origines` cités dans `conclusion.qmd` correction L5-6, et les labels existent bien (`exercises/02-projet-book/correction/01-anatomie.qmd:49` pour `fig-anatomie-mass`, `exercises/02-projet-book/correction/02-origines.qmd:1` pour `#sec-origines`). Rendu attendu OK.

### Observations non actionnables

- Titres légèrement variables entre navbar / page / slide pour Bloc 1 (« PDF avec Typst » / « Un PDF pro en quelques minutes » / « Quarto & PDF avec Typst ») et Bloc 2 (« Projets & book » / « Passer à l'échelle : projet et livre » / « Projets Quarto & Typst book »). Pas un bug — variantes acceptables et même probablement souhaitables (la navbar courte, la page descriptive, la slide avec institut). Je le note juste pour info.
- Le titre de `4-ressources.qmd` est « Pour aller plus loin » et celui de `3-aller-plus-loin/index.qmd` est « Aller plus loin avec Typst » — léger chevauchement sémantique. Si on garde la page 3 comme topic store, peut-être renommer en « Topics avancés » pour différencier ; sinon (cf. P1) la supprimer règle la question.
