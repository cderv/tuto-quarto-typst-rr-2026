# Review élève débutant·e — Workshop RR 2026

**Date :** 2026-05-26
**Profil :** R + RStudio 2-3 ans, R Markdown occasionnel, jamais touché Quarto en projet ni Typst ni `_brand.yml`. Jamais vu `type: book`. Lecture FR native.
**Périmètre :** `index.qmd` racine, `preparatifs.qmd`, `1-quarto-typst/index.qmd`, `2-projets/index.qmd`, `exercises/01-document-typst/starter/`, `exercises/02-projet-book/starter/`, boussoles Exo 1 et 2, slides Bloc 1 et 2 (lecture critique uniquement — accès participant non simulé côté speaker notes).
**Focus du refactor :** Our turn réduit à démo 2 étapes (Bloc 1 : format typst + 1 couleur ; Bloc 2 : `_quarto.yml` default → book). Est-ce que Your turn est compréhensible après seulement ces 2 étapes ?
**Commit de référence :** `002cbdc` (branche main, 2026-05-26)

---

## Verdict général

Le refactor Our turn est pédagogiquement solide : la démo courte (2 étapes) plante réellement la graine sans spoiler l'exercice. La page exo est honnête ("le reste = Exercice 1"), le tableau 3 colonnes reste lisible, les boussoles sont alignées avec les étapes.

**Un seul point potentiellement bloquant reste ouvert** : le starter Exo 1 ne contient pas `_logo-sw.svg`, mais la charte PDF m'invite à transcrire la section `logo:` et le "Vous devriez voir" de l'étape 3 promet "logo en haut-gauche". Si je suis la charte à la lettre et que j'inclus `logo:` dans mon `_brand.yml`, Quarto va chercher un fichier qui n'existe pas — erreur de rendu. Ce point était absent des reviews précédentes.

Les deux frictions persistantes (terme "assignments" non défini, transition YAML `format: typst` → `format:\n  typst:\n    ...` à l'étape 2 non montrée) restent gênantes mais ne sont plus les seuls problèmes.

---

## Bloquant pour le 16 juin

### B1. `_logo-sw.svg` absent du starter Exo 1 mais promis dans "Vous devriez voir"

**Fichiers :** `1-quarto-typst/index.qmd:50,58`, `exercises/01-document-typst/starter/` (liste des fichiers), `exercises/01-document-typst/correction/_brand.yml:24-29`

La charte PDF fournie dans le starter contient une section "Logo" qui indique :

```
Fichier : _logo-sw.svg (étoile jaune, contour noir)
Usage : logo.images.sw-star  logo.medium
```

La page exo ligne 39 confirme : "Le reste (charte complète, polices, **logo**, `keep-typ`) = Exercice 1."

Le "Vous devriez voir" de l'étape 3 dit : "Couleurs palette visibles (titres, liens), police corps Google appliquée, **logo en haut-gauche**."

Mais `_logo-sw.svg` n'existe pas dans le starter. Le dossier contient uniquement :

```
_fonts/Starjedi.ttf
charte-starwars.pdf
rapport-starwars.qmd
README.md
```

**Scénario réel** : je lis la charte, je transcris la section `logo:` dans mon `_brand.yml` (ce que la charte m'y invite explicitement), je lance `quarto render rapport-starwars.qmd` — Quarto cherche `_logo-sw.svg` et plante avec une erreur fichier introuvable. Je perds 3-5 minutes à chercher pourquoi ça plante.

**Alternative possible** : je décide de ne pas inclure la section `logo:` pour l'instant. Dans ce cas le "Vous devriez voir" ne correspond plus (pas de logo en haut-gauche), et je ne sais pas si c'est normal ou si j'ai raté quelque chose.

**La correction** a bien `_logo-sw.svg` à côté de `_brand.yml`, et la correction README (visible sur GitHub) dit "À comparer avec votre résultat à la fin de l'exercice". Mais nulle part dans les documents accessibles aux participants il n'est expliqué d'où provient ce fichier ni comment l'obtenir.

**Correction recommandée :** soit ajouter `_logo-sw.svg` dans le starter Exo 1 (solution la plus simple), soit retirer "logo en haut-gauche" du "Vous devriez voir" de l'étape 3 et signaler que le logo est inclus dans la correction uniquement.

---

## À corriger avant le 16 juin

### G1. Terme "assignments" non défini dans les consignes participant

**Fichiers :** `1-quarto-typst/index.qmd:50,58`

Le mot "assignments" apparaît deux fois dans le tableau de l'Exo 1 :

- ligne 50 : "palette, polices, logo et **assignments** à transcrire en YAML"
- ligne 58 : "palette + **assignments** + police Google"

La charte PDF utilise le même terme en section "Affectations" (traduit) mais écrit `Assignments` en tête de section (sur le PDF livré aux participants, rendu depuis `_charte/charte-starwars.pdf`). Aucun des documents participants n'explique ce que signifie ce mot dans le contexte `_brand.yml` : c'est le mapping entre les rôles sémantiques (`primary`, `foreground`, `background`) et les noms de la palette (`imperial-red`, `sw-black`, `sw-cream`).

Ce point était signalé (G4) dans la review du 2026-05-25 et reste non adressé. Pour un débutant qui n'a jamais vu `_brand.yml`, ce terme est opaque et coûte du temps à interpréter.

**Correction minimale :** remplacer "assignments" par "affectations (`primary`/`foreground`/`background`)" dans les deux occurrences de `1-quarto-typst/index.qmd`.

### G2. Modèle `_quarto.yml` de la page Exo 2 contient déjà `appendices:` — brûle l'étape 2b

**Fichier :** `2-projets/index.qmd:106-136`

La page exo Bloc 2 propose un "Modèle `_quarto.yml` pour l'étape 2" qui contient déjà :

```yaml
book:
  title: "Anatomie d'une saga"
  chapters:
    - index.qmd
    - 01-anatomie.qmd
    - 02-origines.qmd
    - conclusion.qmd
  appendices:
    - annexe-donnees.qmd
```

Or les étapes 2a et 2b sont séquentielles : 2a = ajouter `chapters:` seul, observer `annexe-donnees` comme chapitre numéroté ; 2b = passer `annexe-donnees` en `appendices:`, observer la bascule "Annexe A".

Un participant qui copie le modèle tel quel pour démarrer l'étape 2a se retrouve immédiatement avec la configuration finale 2b. Il ne voit jamais l'effet de la bascule (l'objet pédagogique de l'étape 2b). Le modèle est intitulé "pour l'étape 2" sans distinguer 2a de 2b.

**Correction recommandée :** soit scinder le modèle en deux blocs (étape 2a sans `appendices:`, étape 2b avec), soit ajouter une note "copiez d'abord sans la ligne `appendices:` (étape 2a), puis ajoutez-la (étape 2b)".

### G3. Transition syntaxe YAML à l'étape 2 non montrée

**Fichier :** `1-quarto-typst/index.qmd:57`

L'étape 2 me demande "Personnaliser avec des options : `papersize`, `toc`, `mainfont`...". Mais je ne sais pas comment passer de `format: typst` (ligne unique, étape 1) à la forme imbriquée nécessaire pour ajouter des options :

```yaml
format:
  typst:
    papersize: a4
    toc: true
```

Ce changement de syntaxe YAML est le seul saut technique non montré dans les étapes 1 et 2. La démo Our turn (maintenant minimale) ne le montre plus non plus : elle reste sur `format: typst` seul (étape 1) puis passe directement à `_brand.yml` (étape 2 démo). Un participant qui voit pour la première fois ce YAML va probablement écrire `format: typst: papersize: a4` ou une variante invalide.

Ce point était signalé dans la review du 2026-05-19 et reste non adressé. L'indice de l'étape 2 pointe la doc Quarto, mais seulement si le participant comprend que c'est *la syntaxe* qui pose problème, pas la liste des options.

**Correction minimale :** ajouter une ligne dans l'action de l'étape 2 : "passer `format: typst` en forme imbriquée `format:\n  typst:\n    papersize: ...`". Ou ajouter un snippet de 4 lignes dans les Indices doc de l'étape 2.

---

## Nice-to-have

### N1. Our turn Bloc 2 et `_logo-sw.svg` — d'où il vient

**Fichier :** `2-projets/2-projets.qmd:77` (slide "Construisons un livre ensemble", étape 3 dans les notes)

La page exo Bloc 2, étape 3, dit bien : "Copier `_brand.yml` (+ `_logo-sw.svg` + `_fonts/`) à la racine." Mais si je suis un participant qui arrive à Bloc 2 sans avoir terminé Bloc 1, où est `_logo-sw.svg` ? La page dit "Sinon → renommez `_brand-fallback.yml`" mais le `_brand-fallback.yml` référence lui aussi `_logo-sw.svg` (ligne 27 de `exercises/02-projet-book/_brand-fallback.yml`). Le README starter Exo 2 dit bien "Copiez à la racine : `_brand-fallback.yml` + `correction/_logo-sw.svg`". Donc la chaîne est complète — mais l'information est fragmentée entre README, page exo et fallback. Un participant qui lit seulement la page exo sans le README va chercher.

Pas bloquant : le README starter Exo 2 est inclus dans la page via `{{< include >}}`. Mais un participant qui ne scrolle pas jusqu'à "Quick-ref starter" peut manquer cette info.

### N2. 12 minutes pour 4 étapes — serré mais jouable avec la démo Our turn courte

**Fichier :** `1-quarto-typst/index.qmd:52`

Avec le Our turn réduit à 2 étapes (format typst + 1 couleur), Your turn demande de compléter 2 étapes supplémentaires (options Typst + charte complète avec 4 couleurs + 2 polices). La montée en complexité est réelle mais annoncée honnêtement. 12 minutes est serré mais pas impossible si :

- étape 1 : 1-2 min (déjà vue en démo)
- étape 2 : 2-3 min (options YAML — friction G3 ci-dessus)
- étape 3 : 5-6 min (charte complète — la partie centrale, longue)
- étape 4 : 1-2 min (police locale)

La boussole n'a pas de découpage minuté par étape. Un participant lent peut s'enliser à l'étape 3 et ne jamais faire l'étape 4. Ce n'est pas grave (Star Jedi est le bonus visuel), mais une indication "si vous bloquez à l'étape 3 après 4 min, passez directement à l'étape 4" aiderait les plus lents.

### N3. Slide "Faisons ensemble!" Bloc 2 ne mentionne pas la charte (persistant)

**Fichier :** `2-projets/2-projets.qmd:70-78`

La slide "À vous !" Bloc 2 mentionne `charte-starwars.pdf` (ligne 124 du fichier source). Mais la slide "Faisons ensemble!" (Our turn Bloc 2) sur les étapes 1 et 2 de démo ne parle pas de la charte. C'est cohérent — la démo Our turn Bloc 2 ne touche pas à `_brand.yml` (c'est laissé pour Your turn). Mais si je suis un participant qui cherche la cible visuelle pendant la démo, je ne vois pas où regarder. La charte est pourtant dans mon dossier starter.

Point signalé en G2 dans la review 2026-05-25, non adressé. Reste mineur avec le Our turn court.

---

## Ce qui me rassure

**Notre turn vraiment minimal.** Les 2 étapes (format typst + 1 couleur dans `_brand.yml`) sont suffisantes pour voir la boucle complète sans spoiler Your turn. La phrase "Le reste (charte complète, polices, logo, `keep-typ`) = Exercice 1" (index.qmd:39) est directe et honnête. Je sais exactement ce qui m'attend.

**Table des étapes avec "Vous devriez voir".** Le tableau 3 colonnes est le meilleur outil de la page : pour chaque étape, je sais quoi faire et comment valider que j'ai réussi. La colonne de droite me sauve du "est-ce que c'est normal que mon PDF ressemble à ça ?".

**Boussole projetée.** Le countdown démarre automatiquement, les 4 étapes sont en verbes d'action courts. Si je lève les yeux du code pendant 3 secondes, je sais où j'en suis.

**Escalier d'autonomie cohérent.** "Relire l'objectif / ouvrir Indices doc / ouvrir correction" est identique sur les deux exos et sur les deux boussoles. La répétition du même pattern réduit la charge mentale.

**Modèle `_quarto.yml` fourni dans la page Exo 2.** Même s'il a le problème G2 (contient `appendices:` dès le début), sa présence m'évite une erreur de syntaxe YAML sur `project.type` et `book.chapters` — les deux points où je bloquerais probablement sans modèle.

**Continuité Exo 1 → Exo 2 bien gérée.** La page Exo 2 dit explicitement "L'Exercice 2 est indépendant de l'Exercice 1". Le `_brand-fallback.yml` + `_logo-sw.svg` dans la correction Exo 2 couvre le cas où je n'ai pas terminé Bloc 1. Je ne suis pas bloqué si je suis en retard.

**`preparatifs.qmd` couvre le plan B offline.** Détaillé, avec les chemins exacts pour les deux exos. Si je n'ai pas de réseau, je ne suis pas perdu.

**Le starter Exo 2 est propre.** Les 5 `.qmd` (index, 01-anatomie, 02-origines, conclusion, annexe-donnees) ont des labels cross-ref corrects (`fig-anatomie-mass`, `sec-origines`, etc.) déjà en place pour le Bonus B1. Je n'ai pas à inventer les labels moi-même.

---

## Évolution depuis la review précédente (2026-05-25)

### Ce qui s'est amélioré

- **Our turn réduit à 2 étapes.** La review précédente notait une asymétrie entre démo Our turn (6 étapes, quasi-complète) et Your turn (même chose à refaire). Ce problème est résolu : Our turn montre la boucle minimum, Your turn fait le reste.
- **Page exo Bloc 1 mise à jour.** La section "Our turn" indique maintenant clairement les 2 étapes de démo et ce qui reste pour Your turn. La frontière est nette.
- **Boussole Exo 2 alignée.** Les étapes 2a/2b sont désormais distinguées dans la boussole (commit `a3f906f`), ce qui corrigeait D5 de la review 05-25.
- **Rôle de la charte au Bloc 2 clarifié.** Le callout "Exercice 2 indépendant" dans `2-projets/index.qmd` précise maintenant : "La charte Star Wars reste votre référence visuelle — vous ne la retranscrivez pas ici". C'était le point G2 partiel de la review 05-25.

### Ce qui n'a pas bougé

- Le terme "assignments" non défini (G4 review 05-25 = G1 ici) : pas encore adressé.
- La transition syntaxe YAML étape 2 (signalé review 05-19) : pas encore adressé.
- Le modèle `_quarto.yml` avec `appendices:` dès le départ (nouveau dans cette review).
- Le `_logo-sw.svg` absent du starter Exo 1 (nouveau dans cette review — n'avait pas été signalé avant, la correction n'était pas dans le périmètre des reviews précédentes).
