# Review débutant — Exercice 1 refondu (Your Turn Bloc 1)
**Date :** 2026-05-19
**Profil :** R + RStudio 2-3 ans, R Markdown occasionnel, jamais touché Quarto en projet ni Typst
**Durée simulée :** 12 minutes autonomie, 1 animateur pour ~50 personnes
**Périmètre :** `1-quarto-typst/index.qmd`, `boussole.qmd`, slide "Exercice 1" (lignes 223-243), `exercises/01-document-typst/starter/README.md`, `exercises/01-document-typst/correction/README.md`

---

## Verdict général

La structure est solide et beaucoup plus navigable qu'une liste plate. Le tableau 3 colonnes, le collapse "Indices doc" et l'escalier autonomie forment un dispositif cohérent. **Mais** un bug bloquant va tuer l'étape 4 pour 100 % des participants : `_fonts/Starjedi.ttf` n'existe pas dans le starter (le dossier `_fonts/` ne contient que le fichier LICENSE). Sans ce fichier, l'étape 4 génère une erreur et le participant ne peut pas vérifier que son `_brand.yml` fonctionne. Par ailleurs, un deuxième README (`exercises/01-document-typst/README.md`) présente les étapes dans un ordre différent de celui du site — tout participant qui browse GitHub pour retrouver ses fichiers va se retrouver avec deux séquences contradictoires. Ces deux points mis à part, les 12 minutes sont jouables pour les étapes 1-3 et 5.

---

## Par étape

### Étape 1 — `format: typst` + render

**Est-ce que je sais quoi faire ?**
Oui. "Ouvrir `rapport-starwars.qmd`, ajouter `format: typst`, rendre" est sans ambiguïté. Le quick-ref du starter README dit "Sortie initiale : `rapport-starwars.html`. Après ajout de `format: typst` : `rapport-starwars.pdf`." — c'est exactement ce que j'attends.

**Est-ce que je sais où chercher si je bloque ?**
L'indice pointe `https://quarto.org/docs/output-formats/typst.html` section "Overview". C'est précis. Un débutant qui ne sait pas si `format: typst` va sous la clé `format:` racine ou dans une sous-clé trouvera la réponse en quelques secondes.

**Est-ce que je reconnais le résultat ?**
"PDF généré à la place du HTML, polices et marges par défaut Typst." Vérifiable. Je sais distinguer un PDF d'un HTML dans mon dossier. OK.

**Signal de passage à l'étape suivante ?**
Pas de signal explicite, mais c'est la situation la plus simple : j'ai un PDF → je passe. Aucun risque.

**Angle mort :** Le `rapport-starwars.qmd` du starter importe `ggrepel` (ligne 14). Si un participant n'a pas installé le package (les préparatifs le listent, mais dans la salle tout le monde ne l'a pas forcément fait), le render plante avant même le PDF. Ce n'est pas une incohérence du support — c'est un risque réseau/install à mentionner oralement lors du lancement de l'exercice.

---

### Étape 2 — Options Typst (`papersize`, `toc`, `mainfont`)

**Est-ce que je sais quoi faire ?**
L'action dit "Personnaliser avec des options : `papersize`, `toc`, `mainfont`..." Les trois points suggèrent qu'il y en a d'autres, mais je ne sais pas lesquelles. Ça me convient : les trois exemples sont suffisants pour démarrer.

**Problème :** Je ne sais pas où mettre ces options dans le YAML. Le starter `rapport-starwars.qmd` a `format: html` — quand je le remplace par `format: typst`, est-ce que les options vont *sous* `typst:` (forme imbriquée) ou sur la même ligne ? C'est précisément le saut conceptuel qui fait perdre 3 minutes à un débutant R Markdown. La doc Quarto a les deux syntaxes et un novice Quarto ne sait pas quelle forme choisir.

Exemple de la forme imbriquée que je devrais écrire :
```yaml
format:
  typst:
    papersize: a4
    toc: true
    mainfont: Inter
```
vs `format: typst` seul à l'étape 1. Ce changement de syntaxe YAML n'est pas mentionné dans l'action ni dans l'indice.

**Est-ce que je sais où chercher si je bloque ?**
L'indice pointe `https://quarto.org/docs/output-formats/typst.html#format-options` + référence complète. La section "Format Options" donne des exemples complets avec la syntaxe imbriquée. Accessible, mais seulement si j'ai l'idée d'aller chercher *la syntaxe* et pas seulement la *liste des options*.

**Est-ce que je reconnais le résultat ?**
"TOC en tête, marges/format adaptés, police corps modifiée." Vérifiable sur le PDF.

---

### Étape 3 — Créer `_brand.yml`

**Est-ce que je sais quoi faire ?**
"Créer `_brand.yml` avec vos couleurs (`color:`) et une police Google sur `base:`." — Je comprends que je dois créer un fichier. Mais :

1. **Où ?** L'action ne dit pas "à la racine du dossier starter, à côté du `.qmd`". C'est implicite pour quelqu'un qui connaît les conventions Quarto, mais pas pour moi. Les préparatifs présentent bien `_brand.yml` comme un fichier projet, mais pas l'emplacement précis dans ce contexte exercice.

2. **"Vos couleurs"** : je comprends que je suis libre de choisir, mais je n'ai aucune idée du format minimal acceptable. Un débutant va chercher un exemple complet. La correction n'est pas accessible facilement (collapse), et l'indice doc vers `brand.html` sections "Color" et "Typography" est pertinent mais demande de lire une documentation en anglais pour extraire la syntaxe de base.

3. **`color:` et `base:`** : ce sont des clés YAML spécifiques de `_brand.yml`. Je ne sais pas que `base:` vit sous `typography.fonts[n].family` → `typography.base`. Le libellé est trop condensé.

**Est-ce que je sais où chercher si je bloque ?**
Deux liens : `https://quarto.org/docs/authoring/brand.html` et `https://posit-dev.github.io/brand-yml/`. Correct, mais la page Quarto brand est longue et je ne sais pas où regarder en premier pour "créer un `_brand.yml` minimal". Un lien direct vers un exemple de départ (pas juste une section) manque.

**Est-ce que je reconnais le résultat ?**
"Couleurs primary/secondary visibles (titres, liens), police corps Google appliquée." — Attendez. Il y a `primary` dans le résultat attendu, mais l'action mentionne `color:` sans parler de `primary:`. Pourquoi est-ce que les titres changent de couleur si je mets juste des couleurs dans une palette ? Le mécanisme `primary: ma-couleur` → "ça s'applique aux titres" n'est pas expliqué ici. C'est un saut conceptuel silencieux : si je mets des couleurs dans la palette sans les assigner à `primary:`, rien ne change dans le PDF et je ne comprends pas pourquoi.

**Durée probable :** 4-5 minutes sur cette étape seule pour un débutant qui part de zéro. C'est l'étape pivot.

---

### Étape 4 — Police locale Star Jedi (`source: file`)

**Blocage immédiat confirmé.**

Le README starter dit : `_fonts/Starjedi.ttf` — Police locale (étape 4). Mais `exercises/01-document-typst/starter/_fonts/` ne contient que `LICENSE-StarJedi.txt`. Le fichier `.ttf` est absent.

Quand le participant écrit dans son `_brand.yml` :
```yaml
    - family: "Star Jedi"
      source: file
      files:
        - path: _fonts/Starjedi.ttf
```
... et rend le document, Typst va lever une erreur de police non trouvée ou rendre avec police de fallback sans que le participant comprenne pourquoi. Dans le meilleur cas, il cherche 5 minutes. Dans le pire cas, il croit que son `_brand.yml` est mal formé.

Le git status montre `star_jedi.zip` et `star_jedi/` comme fichiers non trackés à la racine du repo — la police semble être en cours de traitement, mais n'a pas encore atterri dans `starter/_fonts/`.

**Est-ce que l'indice aide si je bloque sur autre chose que le `.ttf` ?**
L'indice pointe `https://posit-dev.github.io/brand-yml/brand/typography.html` — "chercher `source: file`". Correct pour la syntaxe `source: file` + `files:` + `path:`. Mais si le fichier `.ttf` n'existe pas, l'indice ne m'aide pas à débloquer.

**Signal de passage :** "Titres de section en lettres décoratives Star Jedi." Très visuel, très clair — à condition que la police existe dans le dossier.

---

### Étape 5 — `keep-typ: true`

**Est-ce que je sais quoi faire ?**
"Activer `keep-typ: true`, ouvrir le `.typ` généré." C'est une action simple : ajouter une option YAML. L'indice dit "chercher 'keep-typ' dans la page" — la page typst.html est longue mais Ctrl+F fonctionne.

**Est-ce que je reconnais le résultat ?**
"Fichier `.typ` à côté du PDF, syntaxe Typst lisible (`= titre`, `#strong[...]`, etc.)." Vérifiable. Je peux ouvrir le fichier dans RStudio.

**Seul angle mort :** Où dans le YAML va `keep-typ: true` ? Dans `format: typst:` imbriqué ou à la racine ? Même problème de niveau YAML qu'à l'étape 2. Mais l'indice doc + un Ctrl+F le résoudra.

**Durée :** 1-2 minutes. C'est l'étape la plus rapide.

---

## Incohérence structurelle — Deux README avec des ordres contradictoires

C'est un problème silencieux mais sérieux. Un participant qui browse GitHub pour retrouver ses fichiers tombera sur `exercises/01-document-typst/README.md` (le README racine de l'exercice, visible par défaut sur GitHub). Ce fichier présente les étapes dans cet ordre :

1. Passer en Typst
2. Régler la mise en page (options)
3. **Inspecter le `.typ` (`keep-typ: true`)** — étape 3 ici
4. **Charte `_brand.yml`** — étape 4 ici
5. Police locale Star Jedi

Alors que `index.qmd` (le site) présente :

1. `format: typst`
2. Options
3. `_brand.yml` couleurs + police Google — étape 3 ici
4. Police locale — étape 4 ici
5. `keep-typ: true` — étape 5 ici

Deux ordres, deux README distincts, zéro mention de laquelle est la référence officielle. Le participant qui consulte GitHub verra la version obsolète en premier.

---

## Page boussole — ce qu'elle m'apporte à 8 min sur 12

**Ce qui marche :**
- Le countdown est la chose la plus utile. À 8 min sur 12, je sais qu'il me reste 4 minutes. C'est du concret.
- Les 5 étapes condensées me permettent de situer où j'en suis d'un coup d'oeil depuis mon PC.
- L'escalier autonomie est lisible et ne panique pas.

**Ce qui manque :**
- Le lien "Page Exercice 1" pointe vers `index.qmd` (path relatif). Dans le rendu du site, ça devient une URL absolue du site — mais est-ce que le participant peut y accéder depuis son navigateur pendant l'exercice ? Si le wifi est capricieux, ce lien vers le site en ligne peut tomber. Il aurait été utile d'avoir une URL absolue pour que je sache ce que je cherche si le lien ne marche pas.
- La marche 2 de l'escalier dit "Ouvrir le collapse **Indices doc** sous le tableau". Mais le participant travaille dans son éditeur local, pas sur le site. Il doit se souvenir qu'il faut ouvrir un onglet navigateur sur le site du workshop. Ce n'est pas explicite depuis la boussole.
- "Ouvrir `exercises/01-document-typst/correction/`" — ouvrir le dossier, c'est clair. Mais ouvrir quel fichier ? `rapport-starwars.qmd` et `_brand.yml` sont tous les deux utiles. Ce n'est pas bloquant, mais un débutant peut perdre 30 secondes à chercher.

**Ce qui me rassure :**
Le countdown seul justifie la page. Savoir qu'il me reste X minutes change mon comportement : je zapping l'étape 4 (Star Jedi) si je suis en retard plutôt que de m'y obstiner.

---

## Slide "Exercice 1" — ce que je vois depuis la salle

**Ce que je vois :**
```
À vous !
Transformer un .qmd HTML en PDF Typst stylé via _brand.yml.
12 minutes — page boussole projetée à côté.
Consigne complète : 1-quarto-typst/index.html
```

**Ce qui marche :**
- L'objectif en une phrase est clair.
- "12 minutes" est visible.
- "page boussole projetée à côté" me signale que je dois regarder l'écran du formateur.

**Problème :** La slide affiche le texte `1-quarto-typst/index.html` comme label cliquable (le lien pointe en réalité vers `index.qmd`). Depuis ma place dans la salle, je lis "1-quarto-typst/index.html" — je pourrais croire que je dois naviguer vers ce chemin dans mon dossier local. Si je cherche un fichier `index.html` dans mon dossier cloné, je ne le trouverai pas (il n'existe que dans `_site/` après un build). Le libellé du lien devrait être quelque chose comme "Page Exercice 1 sur le site" ou l'URL absolue du site.

**Ce qui manque :**
Aucun signal visuel sur les 5 étapes depuis la slide. C'est volontaire (slide minimaliste), et la boussole projetée prend le relais — c'est cohérent avec le design.

---

## Résumé des problèmes par priorité

### P0 — Bloquant le 16 juin

**`_fonts/Starjedi.ttf` absent du starter.**
`exercises/01-document-typst/starter/_fonts/` ne contient que `LICENSE-StarJedi.txt`. L'étape 4 est impossible à réaliser. Tous les participants qui arrivent à cette étape vont échouer ou obtenir un rendu silencieusement faux.
`exercises/01-document-typst/starter/README.md:12` : "| `_fonts/Starjedi.ttf` | Police locale (étape 4) |" — le fichier référencé n'existe pas.

### P1 — À corriger avant le 16 juin

**Deux README avec des ordres d'étapes contradictoires.**
`exercises/01-document-typst/README.md` place `keep-typ: true` en étape 3 et `_brand.yml` en étape 4. `1-quarto-typst/index.qmd` fait l'inverse (étapes 3 et 5). Un participant qui browse GitHub voit la version obsolète en premier. Soit supprimer/archiver `exercises/01-document-typst/README.md`, soit aligner les deux ordres.

**Étape 3 : saut conceptuel silencieux sur `primary:`.**
Le "Vous devriez voir" mentionne "Couleurs primary/secondary visibles (titres, liens)" mais l'action ne dit pas qu'il faut assigner `primary: ma-couleur` pour que les couleurs s'appliquent. Un participant qui crée une palette sans assigner `primary:` verra... rien changer. Il ne comprendra pas pourquoi.
`1-quarto-typst/index.qmd:57` — ajouter à l'action ou à l'indice : "penser à assigner `primary:` dans la palette pour que la couleur s'applique aux titres".

**Slide "Exercice 1" : libellé du lien trompeur.**
`1-quarto-typst/1-quarto-typst.qmd:232` affiche `1-quarto-typst/index.html` comme label. Depuis la salle, ce chemin ressemble à un path de fichier local introuvable dans le dossier cloné. Remplacer par un label sans ambiguïté ("Page Exercice 1" ou l'URL absolue du site).

### P2 — Nice-to-have

**Étape 2 : syntaxe YAML imbriquée non explicitée.**
Le saut de `format: typst` (forme courte) à `format: typst: papersize: a4 ...` (forme imbriquée) n'est mentionné ni dans l'action ni dans l'indice. Un exemple d'une ligne dans l'action ou dans l'indice suffirait : "sous `format: typst:`, ajouter `papersize: a4`".

**Boussole : lien "Page Exercice 1" ambigu offline.**
`1-quarto-typst/boussole.qmd:35` — `[Page Exercice 1](index.qmd)` est un lien relatif. Si le wifi est capricieux, donner l'URL absolue du site directement dans le texte, pas seulement dans le lien.

**`exercises/01-document-typst/README.md` (racine exercice) : durée affichée "15 minutes".**
`exercises/01-document-typst/README.md:3` dit "Durée : 15 minutes" alors que le site et la boussole disent 12 minutes. Incohérence mineure mais visible sur GitHub.

---

## Ce qui me rassure

- Le tableau 3 colonnes avec "Vous devriez voir" est excellent : je sais à quoi m'attendre après chaque étape sans avoir à interpréter.
- Le collapse "Indices doc" est le bon niveau d'aide : pas intrusif visuellement, accessible quand j'en ai besoin.
- L'escalier autonomie est réaliste et ne culpabilise pas : "après ~5 min sur une étape" est une jauge temporelle concrète.
- Le quick-ref du starter README (tableau fichiers + commande render) est parfait pour un participant qui travaille hors ligne ou a fermé l'onglet du site.
- L'étape 5 (`keep-typ: true`) est bien placée en dernier : c'est une récompense visuelle rapide pour ceux qui ont fini les 4 premières.
- La correction README en 3 lignes avec lien direct est exactement ce qu'il faut : pas de contenu superflu.

---

## Conclusion — Est-ce que je finirais l'exercice en 12 minutes ?

Avec le bug du `.ttf` corrigé :
- Étapes 1, 2, 5 : oui, sans aide. ~5 minutes au total.
- Étape 3 (`_brand.yml`) : probablement 4-5 minutes avec le collapse "Indices doc". Je risque de coller `primary:` sans comprendre le mécanisme si le lien sur `primary:` n'est pas explicite.
- Étape 4 (Star Jedi) : 2-3 minutes avec le `.ttf` présent.

Total réaliste : 12-14 minutes pour un débutant motivé. **Avec le `.ttf` manquant, je bloque à l'étape 4 et je finis démoralisé.**

Sans le bug P0 et avec la clarification P1 sur `primary:`, le format "indices doc" tient le timing pour un débutant. C'est le bon niveau de guidance : ni trop directif (pas de correction pas-à-pas), ni trop flou (chaque étape a une vérification concrète).
