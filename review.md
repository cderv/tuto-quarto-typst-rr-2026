# Reviews du tutoriel — Rencontres R 2026

> Reviews lancées le 2026-05-02 sur la branche `claude/add-tutorial-reviews-wkPAm`.
> Deux angles complémentaires : un·e expert·e pédagogique (vue de l'animateur·ice) et un·e participant·e type (vue de l'audience).
> Sauvegardé ici pour ne pas perdre le contenu si la session s'arrête.

---

## Review 1 — Expert·e pédagogique

### Synthèse en une ligne

Un tutoriel structurellement très solide (rythme M/O/Y maîtrisé, arc narratif cohérent, choix de scaffolding intelligents), mais qui présente trois risques pédagogiques concrets à traiter avant le 16 juin : objectifs implicites, wrap-up absent, et une fragilité non explicitée sur la transition entre l'Exo 1 (standalone) et l'Exo 2 (projet).

### 1. Forces

#### Arc narratif `.qmd → PDF → livre → personnalisé`

La progression est limpide. Le pivot Bloc 1 → Bloc 2 est explicitement préparé dans la conclusion du starter (`exercises/01-document-typst/starter/rapport-starwars.qmd:84` — « il faudrait étendre ce rapport en livre — c'est l'objet du Bloc 2 »). Cliffhanger pédagogique excellent : le rapport n'est pas un prétexte, il devient le matériau du Bloc 2. Les notes du presenter (`1-quarto-typst/1-quarto-typst.qmd:30` et `2-projets/2-projets.qmd:30`) explicitent bien la réutilisation du `_brand.yml` Bloc 1 → Bloc 2.

#### Storytelling `starwars`

« Qui sont les colosses de la galaxie ? » + punchline droïdes (R2-D2 dans 7 films) sur le `#highlight()` raw Typst : la pépite n'est pas un gadget, elle sert le narratif. Le choix `gt` partout (cf. décision 2026-05-02 dans `PLAN.md:18`) est cohérent avec la pépite « Vos tableaux fonctionnent » (`1-quarto-typst/1-quarto-typst.qmd:185`).

#### Scaffolding R figé (`echo: false`)

Excellent choix andragogique : les participants n'éditent que YAML, `_brand.yml`, raw Typst et structure projet. Cela maintient la charge cognitive sur l'objet d'apprentissage réel (Quarto+Typst, pas R/dplyr/ggplot). L'exception `echo: true` sur `theme_brand_*()` (pépite Bloc 1) est justifiée et didactique.

#### Rythme M/O/Y systématique

Conventions visuelles claires (background vert/jaune, callouts différenciés). Slide « Le rythme du tutoriel » (`1-quarto-typst/1-quarto-typst.qmd:11-37`) installe le contrat pédagogique dès le début.

#### Pépites bien dosées

Une pépite par bloc, courte, en fin de séquence. Notes du presenter explicites sur le rôle de fusible (`1-quarto-typst/1-quarto-typst.qmd:194` : « le premier fusible à couper si on manque de temps »). Discipline rare et précieuse.

### 2. Points d'amélioration (non bloquants mais à traiter)

#### Objectifs d'apprentissage non explicités

`index.qmd:17-20` pose des **questions** (« Comment remplacer LaTeX... ? ») mais pas d'objectifs SMART. Les pages Bloc 1/Bloc 2 (`1-quarto-typst/index.qmd`, `2-projets/index.qmd`) listent des « points couverts », pas ce que le participant **saura faire** à la fin. Recommandation : ajouter une section « À la fin de ce bloc, vous saurez : (1) transformer un .qmd en PDF Typst, (2) appliquer un brand custom, (3) déboguer via le .typ intermédiaire. » Cela donne aussi un fil conducteur pour le wrap-up (cf. point suivant).

#### Pas de wrap-up / clôture

**C'est le manque le plus visible.** Aucun slide « En résumé » à la fin des decks Bloc 1 et Bloc 2 ; aucune slide « Et maintenant ? » à la toute fin (Bloc 2 se termine sur la pépite `2-projets/2-projets.qmd:103`). Les 30 min de marge mentionnées dans `PLAN.md:45` permettent largement d'ajouter :

- 1 slide récap fin Bloc 1 (« vous avez transformé un rapport HTML en PDF Typst brandé »)
- 1 slide « Next steps » fin Bloc 2 : pointer vers `4-ressources.qmd`, mentionner les 2-3 choses à essayer dans la semaine (un PDF custom, lire la pépite partials, regarder typst-templates).
- 1 slide « Questions ? » + plage d'échange.

Sans wrap-up, le participant repart avec une expérience riche mais sans **ancrage** explicite — risque de perte de rétention sous 48h.

#### Préparatifs : risque réseau le jour J

`preparatifs.qmd` est minimaliste, mais le `PLAN.md:84` mentionne explicitement « Fonts source : `google` par défaut (réseau OK), variante `file` à mentionner pour robustesse offline jour J Nantes ». Le risque concret : `_brand.yml source: google` qui échoue silencieusement au téléchargement des fonts. Recommandation : ajouter une section « Si le réseau est indisponible » dans préparatifs et fournir un `_fonts/` zippé en plan B (qui existe déjà pour la correction `exercises/01-document-typst/correction/_fonts/`).

#### Liens cassés dans `preparatifs.qmd`

`preparatifs.qmd:24-25` : les zips pointent sur `#`. Idem `1-quarto-typst/index.qmd:46` et `2-projets/index.qmd:44`. À corriger avant publication, sinon participant bloqué dès la préparation.

### 3. Risques bloquants pour le timing

#### Bloc 1 « Our turn » sous-estimé

La démo live (`1-quarto-typst/1-quarto-typst.qmd:146-160`) enchaîne 5 manipulations (typst, options, `_brand.yml`, `keep-typ`, exploration `.typ`) en **10 minutes**. Or expérimentalement, dès qu'on tape en live et qu'on commente, on est plutôt à 12-15 min minimum. **Risque concret : déborder sur l'exo, sacrifier le `keep-typ` qui est pourtant le moment « aha » documenté dans le PLAN.** Recommandation : prévoir explicitement quel item couper si on dérive (probablement les options secondaires `mainfont`/`linestretch`, gardées pour l'exo).

#### Récupération en cas de pépin Exo 1

Le filet de sécurité Bloc 2 (`2-projets/index.qmd:53-54`, `2-projets/2-projets.qmd:93-95`) « Pas de `_brand.yml` ? Copiez le fichier fourni » est **excellent**. Mais : un participant qui n'a pas réussi à rendre le PDF Typst de l'Exo 1 (problème d'install, fonts non chargées, etc.) ne sait pas s'il peut quand même suivre l'Exo 2. Le starter Exo 2 doit clairement être autonome (cf. `PLAN.md:273` qui le prévoit). Recommandation : ajouter une ligne explicite dans `2-projets/index.qmd` : « L'Exo 2 ne dépend pas de votre Exo 1 — partez du dossier `02-projet-book/starter/`. »

#### Charge cognitive Exo 2 en 15 min

L'Exo 2 demande : créer `_quarto.yml`, organiser en chapitres, rendre, observer orange-book, plus le bonus brand. Le participant débutant Quarto qui découvre `type: book` pour la première fois aura du mal à finir en 15 min, surtout après 1h30 de tutoriel. Recommandation : les étapes 3-4 doivent être positionnées explicitement comme bonus (la 4 l'est, la 3 = « rendre et observer » devrait être l'objectif minimum atteignable).

#### Asymétrie « My turn » Bloc 1 (7 min) vs Bloc 2 (5 min)

Le Bloc 2 introduit deux concepts denses (`_quarto.yml` + `type: book` + orange-book auto) en 5 min selon `2-projets/index.qmd:24`. C'est tendu, surtout pour des participants débutants Quarto qui n'ont peut-être jamais vu un `_quarto.yml`. Recommandation : viser 7-8 min pour le My turn Bloc 2 ; on a la marge.

### 4. Points de vigilance secondaires

- **Slide « Saviez-vous que » Bloc 1** (`1-quarto-typst/1-quarto-typst.qmd:179-187`) condense 3 pépites denses (raw blocks, CSS→Typst, PDF/UA-1) en 2-3 min. C'est beaucoup. Le narratif « 3 temps » prévu pour la pépite raw Typst (cf. `PLAN.md:74`) n'apparaît pas dans la slide actuelle — à intégrer ou à assumer comme oral seulement.
- **Pépite « brand depuis R »** prévue dans `PLAN.md:301-309` (Phase 5) **n'apparaît pas** dans la slide actuelle (`1-quarto-typst/1-quarto-typst.qmd:115-144`). C'est un oubli ou un choix ?
- **Le fragment `Exercice 1` de la slide Bloc 1** (`1-quarto-typst/1-quarto-typst.qmd:162-176`) duplique exactement la consigne « Faisons ensemble ! » qui précède (`:146-160`). Pédagogiquement c'est voulu (consigne stable entre démo et exo) mais à l'oral, attention à ne pas donner l'impression de répéter — annoncer clairement « même consigne, mais cette fois c'est à vous, en autonomie ».
- **`linkcolor`, `codefont`, `mathfont`** sont mentionnés en notes (`:159`) mais jamais montrés. Si on les cite, prévoir 30 sec en démo pour ne pas frustrer les curieux.

### 5. Recommandations prioritaires

1. **Ajouter un wrap-up de 5 min en fin de Bloc 2** (récap, next steps, ressources, Q&A). C'est le gain pédagogique le plus important pour le coût le plus faible.
2. **Expliciter les objectifs d'apprentissage** en haut de chaque page de bloc.
3. **Fixer les liens cassés** dans `preparatifs.qmd` et les pages de bloc.
4. **Ajouter un plan B fonts offline** dans `preparatifs.qmd`.
5. **Annoter clairement que l'Exo 2 est autonome** vis-à-vis de l'Exo 1.
6. **Rééquilibrer Bloc 1 Our turn (12 min) / Bloc 2 My turn (8 min)** — la marge de 30 min le permet largement.

---

## Review 2 — Participant·e type (à chaud, le 16 juin vers 11h15)

> Profil simulé : utilisateur·ice R intermédiaire (3-5 ans), data science / recherche / consulting, R Markdown long-time, Quarto débutant, jamais utilisé Typst, fatigue post-soirée RR.

### 1. Première impression sur la page d'accueil

Le titre claque : « PDF sans frictions ». Quand on s'est battu·e pendant 4 ans avec des `! LaTeX Error: File 'xeCJK.sty' not found`, « sans frictions » c'est exactement le mot qui me fait ouvrir l'onglet. Le programme tient en deux blocs propres et je vois tout de suite l'arc : un PDF d'abord, un livre ensuite. Bien.

**Ce qui me fait tiquer** : « Quarto 1.9+ » en pré-requis sans dire pourquoi. Je suis encore en 1.5 sur mon laptop pro (politique IT du labo, on ne met pas à jour quand on veut). Est-ce que le tuto va planter chez moi ? Et « Typst comme moteur de rendu » — moi je croyais que Typst c'était un langage, donc je suis déjà un peu confus·e dès la première phrase.

### 2. Préparatifs

Honnêtement, ça va. La liste des packages est raisonnable, je connais tout sauf `brand.yml` (le package R, je suppose ?). Bonus : pas de TinyTeX, pas de LaTeX, je respire.

**Mais** : les liens `exercices.zip` et `exercices-correction.zip` pointent sur `#`. Hier soir à 23h dans mon AirBnB j'ai cliqué et je suis tombé·e sur la page elle-même. J'ai paniqué 5 minutes avant de me dire « c'est pas encore prêt, je verrai demain ». Ça mérite au moins une note « disponible le J-2 ».

Pas de check Quarto 1.9 explicite dans le bloc de vérification — `quarto::quarto_version()` me dit juste un numéro, mais on ne me dit pas quoi faire si je suis en 1.5. Et ma collègue à côté est sur Linux Ubuntu 20.04 où Quarto officiel veut être >= 22.04. Petit stress.

### 3. Bloc 1 — slides My turn

Très propre. La slide « rythme du tutoriel » en trois colonnes, j'adore, je sais où je vais. La slide `format: typst` avec les 4 puces incrémentales me vend le truc en 30 secondes : pas de LaTeX, rapide, lisible, léger. Vendu.

**Ce qui me fait tilter** :

- `keep-typ: true` et le diagramme `qmd → typ → pdf` : c'est super pédago, mais je me demande « est-ce que je dois apprendre Typst ou pas ? ». La réponse implicite est « non mais regarde si tu veux », ce qui est rassurant — sauf que dans la pépite il y a `#highlight(fill: rgb("#FFE81F"))` qui me dit l'inverse.
- `_brand.yml` arrive vite. C'est quoi cette norme ? D'où ça sort ? « présenté aux RR 2025 » dans les notes — sympa pour ceux qui y étaient, moi j'y étais pas. Un mot de contexte (« standard ouvert porté par Posit ») aiderait.

**Ce qui me fait peur** : rien, en fait. C'est court, c'est clair. Bravo.

### 4. Démo « Our turn » — Mac vs Windows

Sur Windows 11 avec RStudio, je suis. Ma voisine sur Mac M2 aussi. Aucun souci a priori, **sauf** : quand Christophe va taper `mainfont: Inter`, est-ce que Inter est installée chez moi ? Sur Mac, ma voisine l'a pas non plus. Mention « polices Google » sur la slide — donc Quarto la télécharge ? Ce n'est jamais explicité. Si ça plante en live je vais lever la main.

Autre angoisse Windows : les chemins, les espaces, les accents. `_brand.yml` à côté du `.qmd`, ok, mais si mon dossier s'appelle `Mes Documents/Tuto Quarto/` ça pète ?

### 5. Exercice « Your turn » — 15 min

Je rouvre `rapport-starwars.qmd`. Étape 1, je remplace `format: html` par `format: typst`, je render, **boom premier PDF**. Petit kif. Étape 2, j'ajoute `papersize`, `margin`, `toc`, `mainfont` — je galère 2 min sur l'indentation YAML (margin avec x/y c'est pas standard pour moi).

Étape 3 : `_brand.yml`. Là je rame. La consigne dit « vos couleurs et une police Google », mais je n'ai pas d'exemple sous les yeux dans l'exercice. Le starter ne contient pas de `_brand.yml` template. Je dois remonter aux slides ou attraper ce que Christophe a tapé en démo. Si j'ai loupé un détail je suis bloqué·e. **Je serais content·e d'un `_brand.yml.example` commenté dans `starter/`.**

Questions que je pose à voix basse à Maëlle qui passe :

- « C'est normal que mon ggplot reste en gris alors que mon brand est jaune ? » (Réponse : utiliser `brand.yml` package R — pas évident depuis le YAML.)
- « Comment je sais quelles polices Google sont dispo ? »
- « Pourquoi mon `é` dans le tableau gt sort en `?` dans le PDF ? » (le starter écrit `Espece` et `Planete` sans accent — louche, pourquoi ?)

### 6. Bloc 2 — projet et livre

La transition est OK : « on a stylé un fichier, maintenant on passe à l'échelle ». J'attrape le concept. **Mais** je me mélange : `_quarto.yml` vs `_brand.yml`, deux fichiers en `_xxx.yml`, deux rôles. Un schéma « qui contient quoi » en début de Bloc 2 m'aiderait.

`type: book` + orange-book : je comprends mais « orange-book » sort de nulle part. C'est un nom de produit ? Une convention ? Une extension ? Les notes parlent de « extension bundlée Quarto 1.9 », la slide dit pas. Je serais rassuré·e d'avoir un screenshot de ce que ça donne.

`_brand.yml` au niveau projet vs fichier : oui c'est clair, **à condition** d'avoir réussi l'exo 1. Si j'ai pas fini, le fallback « copiez le fichier fourni » est rassurant — bravo de l'avoir prévu.

### 7. Pépites « Saviez-vous que... »

Trop dense. Trois pépites en 2 minutes c'est rapide, et `pdf-standard: ua-1` mérite à lui seul une slide (l'accessibilité c'est un sujet politique au labo en ce moment). Sur la pépite Bloc 2 — « template partials » — je décroche. Trop de meta. Mais bon, je sais que je peux y revenir.

### 8. Après le tuto

Ce que je retiens : **trois lignes de YAML pour basculer d'HTML à PDF**, et un PDF qui ne fait pas honte. Ça suffit à me rentabiliser le tuto. Ce que je veux faire cette semaine : convertir mon prochain rapport client en `format: typst` et caler un `_brand.yml` aux couleurs du labo. Je me sens autonome **pour un document seul**. Pour un book, j'aurai besoin de relire la doc.

### 9. Mes vraies questions à la fin

- Et si j'ai déjà un projet R Markdown avec `bookdown` ? Migration ?
- Ça marche avec Quarto Pub ? GitHub Pages ? (Pour partager le livre.)
- Le logo de mon labo est en SVG avec un dégradé, ça passe dans Typst ?
- Comment je gère les références bibliographiques en Typst ? `.bib` toujours ?
- Et `kableExtra` ? `flextable` ? Mes tableaux historiques sortent comment ?
- Si je passe à Typst, je perds les liens cliquables / les bookmarks PDF / le PDF/A pour archivage légal ?
- Comment je versionne `_brand.yml` entre 3 projets différents sans le dupliquer ?
- Ça marche en CI (GitHub Actions, GitLab CI) sans installer LaTeX ? Quelle taille de runner ?
- Quarto 1.9 est-il LTS ? Je peux y aller en prod ?
- Je peux mettre du français avec césures correctes ? (Typst gère ça bien ?)

### 10. Petites frustrations

- « format: typst » et « Typst » comme nom propre : la première fois j'ai cru à une typo de « Typescript ».
- « orange-book » : nom mystérieux, jamais explicité visuellement.
- Les liens `#` morts dans préparatifs et exos — gros stress la veille.
- « Posit / ROpenSci » dans `institute:` des slides : c'est `rOpenSci`, pas `ROpenSci`, et Maëlle va peut-être grincer.
- L'exo 1 demande de créer un `_brand.yml` from scratch sans template — un skeleton commenté me sauverait.
- La pépite « vos tableaux fonctionnent » me donne envie d'y croire mais je n'ai pas de preuve sous les yeux dans l'exo (le `gt` est là mais on ne s'arrête pas dessus).
- Le countdown 15:00 est pratique, mais quand il sonne, on en est tous au début de l'étape 3. Soit raccourcir l'exo, soit pousser à 18 min.
- Pas de moment « questions du public » matérialisé entre les blocs.

Globalement : tuto **ramassé, honnête, qui tient ses promesses**. Je repars avec un truc utilisable lundi. Bravo, mais corrigez les zips morts svp.

---

## Convergences entre les deux reviews (à traiter en priorité)

Les deux angles indépendants pointent les mêmes 4 problèmes — c'est le signal le plus fort :

1. **Liens cassés** (`#` dans `preparatifs.qmd` et pages de bloc) → bloque la préparation et stresse les participants la veille.
2. **Pas de wrap-up / clôture** → pas de récap, pas de « next steps », pas de Q&A formalisé. La marge de 30 min permet largement de l'ajouter.
3. **Plan B offline** absent (Posit côté pédago, panique participante côté Inter/Google fonts) → fournir un zip `_fonts/` et l'expliciter dans `preparatifs.qmd`.
4. **Exercice 1 sans `_brand.yml.example`** → la consigne « créez un `_brand.yml` » sans skeleton bloque les participants en autonomie.

Autres points secondaires alignés :

- Asymétrie temporelle Bloc 1 / Bloc 2 (Our turn 10 min trop court, My turn Bloc 2 5 min trop court).
- « orange-book » jamais explicité visuellement (côté participant) ↔ aucun screenshot dans les slides (côté pédago).
- Pépites Bloc 1 trop denses (3 sujets en 2-3 min).
- Lien explicite « Exo 2 = autonome vis-à-vis Exo 1 » manquant.
