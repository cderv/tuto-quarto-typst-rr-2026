# Review pédagogique — Refonte Our Turn Bloc 1 & Bloc 2 + docs orateur

**Date :** 2026-05-26
**Commit de base :** `2e5e630` (branche `main`, fichiers modifiés non commités inclus)
**Review précédente :** `.claude/reviews/review-2026-05-25-charte-pedagogue.md`
**Périmètre :** Slides Bloc 1 & 2, pages exercice, docs orateur `_speaker/`, exercices starter

---

## Verdict général

La refonte du rythme Our turn est **pédagogiquement solide et bien exécutée**. La séparation démo minimale (2 étapes) / exercice complet élimine le risque de redondance entre Our turn et Your turn dans les deux blocs. Les docs orateur `_speaker/` sont un ajout de qualité : snippets prêts à coller, checklist de sortie, fallbacks — tout ce qu'il faut pour piloter 50 participants sans se noyer. L'arc `.qmd → PDF pro → livre → personnalisé/pérennisé` est visible et tracé bout-à-bout. **Deux items à corriger avant le 16 juin** (note orateur qui référence une démonstration qui n'a pas lieu, et callout "Your turn" de la slide d'introduction de rythme incohérent visuellement). Pas de P0.

---

## 🔴 P0 — bloquant pour le 16 juin

Aucun.

---

## 🟠 P1 — à corriger avant le 16 juin

### P1-1. Note orateur Exercice 2 référence une démonstration qui n'a pas lieu

`2-projets/2-projets.qmd:137` — la note des participant·e·s qui finissent vite dit : « Le bonus B2 (pagebreak) demande de connaître la syntaxe `.content-visible` — **l'avoir montrée à la fin de Our turn aide**. »

Problème : `.content-visible` n'est jamais montrée dans le Our turn Bloc 2. La checklist de `_speaker/demo-bloc2-our-turn.qmd:172` confirme que `appendices`, `_brand.yml` et les bonus (dont B2) sont explicitement gardés pour Your turn. La note mentionne quelque chose qui ne se passe pas — un animateur qui la lirait en séance chercherait en vain « ce qu'il a montré à la fin de Our turn ».

**Fix** : supprimer la parenthèse `— l'avoir montrée à la fin de Our turn aide` ou la remplacer par `— la syntaxe est dans la page Exercice 2 et la boussole`.

### P1-2. Callout "Your turn" dans la slide d'intro du rythme utilise un type générique

`1-quarto-typst/1-quarto-typst.qmd:30` — la slide "Le rythme du tutoriel" présente les 3 modes en 3 callouts : My turn = `.callout-note` (bleu), Our turn = `.callout-tip` (vert), mais Your turn = `.callout` générique sans type. Le résultat visuel est un callout gris/neutre sans la couleur jaune (`$callout-color-warning: #FDC538`) que le participant verra systématiquement pour tous les "À vous !" réels.

Convention CLAUDE.md : **Your turn = `.callout-warning`**. La slide d'intro ne respecte pas cette convention et crée une dissonance dès la première exposition au rythme — le code couleur n'est pas planté.

**Fix** : remplacer `::: {.callout appearance="minimal"}` par `::: {.callout-warning appearance="minimal"}` à la ligne 30.

### P1-3. Titre callout "Pépites" incohérent avec la convention de nommage

`1-quarto-typst/1-quarto-typst.qmd:277` et `2-projets/2-projets.qmd:143` — les deux slides "Saviez-vous que..." portent comme titre de callout **"Pépites pour aller plus loin"**, alors que la convention (CLAUDE.md) dit que le callout `.callout-note` doit avoir le titre **"Saviez-vous que…"**.

La slide H2 est bien "Saviez-vous que..." (correct), mais le titre du callout à l'intérieur de la slide dit quelque chose de différent. En projection, c'est le titre du callout qui est le plus visible (bande bleue avec le texte). Résultat : les pépites ne portent pas leur propre nom.

**Fix** : changer les deux titres internes en `## Saviez-vous que…` (ou supprimer la redondance si le titre H2 de slide suffit).

---

## 🟡 P2 — nice-to-have

### P2-1. Co-animation : un seul "CD parle" dans 200 lignes de slides Bloc 2

`2-projets/2-projets.qmd:171` — seule indication explicite d'attribution dans les slides des deux blocs. Tous les moments de démo, transition et pépite sont muets sur "qui dit quoi". Le doc orateur `_speaker/` ne mentionne ni Maëlle ni la co-animation.

Pour une séance à deux, c'est gérable à l'oral, mais risqué si Maëlle prépare seule sa partie depuis les docs. Les moments naturels : (a) présentation de la charte SW ("Voici la charte" slide Bloc 1) — Maëlle peut la commenter en direct pendant que CD ouvre l'IDE ; (b) transition Exo 1 → pause (pendant que CD circule) ; (c) ouverture Bloc 2.

**Suggestion** : 2-3 lignes de notes dans les slides ou les `_speaker/` docs indiquant le partage CD/Maëlle — pas une répartition exhaustive, juste les moments de relais.

### P2-2. Pépite "Une charte, partout" (`brand_color_pluck`) en position 3 sur 4 — risque de coupure

`1-quarto-typst/1-quarto-typst.qmd:281` — la pépite est en 3e position dans la liste (après "blocs raw Typst" et "tableaux fonctionnent"). La note dit que c'est le premier fusible à couper. Si la pépite est lue à 2-3 min max de bas en haut, ce bullet — probablement le plus inspirant pour clore la boucle `.qmd + _brand.yml → tout vos outputs R` — risque de ne jamais être verbalisé.

Décision à trancher : soit remonter en position 1 ou 2, soit noter explicitement que ce bullet est prioritaire à l'oral même si on coupe les deux derniers.

### P2-3. Boussole Bloc 2 : l'étape 3 mentionne un "bloc `format.typst.logo` custom" sans précédent dans les slides

`2-projets/boussole.qmd:24` — l'étape 3 de la boussole dit « Copier `_brand.yml` (+ logo + `_fonts/`) à la racine + bloc `format.typst.logo` custom (sinon chevauchement titres p. 2+) ». Ce bloc logo n'est jamais montré en Our turn, pas mentionné dans les slides Bloc 2, et n'apparaît qu'en inline dans le modèle `_quarto.yml` de la page exercice (`2-projets/index.qmd:106-136`).

Un participant qui consulte uniquement la boussole (usage prévu en séance) sera perdu à l'étape 3 : "bloc `format.typst.logo` custom" est une instruction sans syntaxe visible. La page exercice le donne en modèle complet — mais la boussole ne pointe pas dessus. Suggestion : reformuler en « Copier `_brand.yml` (+ logo + `_fonts/`) à la racine — cf. modèle `_quarto.yml` sur la page exercice si besoin du bloc logo ».

---

## ✅ Forces pédagogiques confirmées

### Refonte Our turn : démo minimale bien calibrée

La décomposition en 2 étapes (Bloc 1 : `format: typst` + 1 couleur ; Bloc 2 : `type: default` → `type: book`) est le bon niveau d'abstraction. On montre la boucle (éditer → render → voir l'effet) sans refaire l'exercice. Your turn a une vraie valeur ajoutée (charte complète, appendices, brand, bonus) et ne répète pas ce qu'on vient de voir.

### Docs orateur `_speaker/` : qualité professionnelle

Les deux docs (`demo-bloc1-our-turn.qmd`, `demo-bloc2-our-turn.qmd`) répondent exactement au besoin séance : setup checklist, snippets à coller (aucune frappe en live sur des hex codes), timings, script de transition mot-à-mot, FAQ pièges, checklist de sortie, fallbacks. Un animateur peut piloter la démo sans les slides. Notamment, la checklist "avant de quitter Our turn" (items à ne PAS avoir fait = pas de `appendices`, pas de `_brand.yml`) est un garde-fou concret contre le débordement.

### Transition Our turn → Your turn : le mot "boucle" retiré et remplacé par une description d'action

Les deux diffs commités (`1-quarto-typst/1-quarto-typst.qmd` et `1-quarto-typst/index.qmd`) remplacent "planter la boucle" par des descriptions d'actions concrètes ("on passe le doc en `format: typst`, puis on lui applique une couleur via `_brand.yml`"). Le jargon pédagogique interne disparaît des surfaces apprenant.

### Slide "Voici la charte" correctement intercalée et méta-argumentée

`1-quarto-typst/1-quarto-typst.qmd:194-217` — la slide remplit son rôle de pont entre le concept `_brand.yml` générique et la démo concrète. Le 4e bullet ("Ce PDF est lui-même rendu par Quarto + Typst + `_brand.yml`") plante la méta-cohérence. La note presenter demande explicitement de projeter la charte PDF pendant la démo.

### Progression d'autonomie entre Our turn et Your turn dans les deux blocs

- Bloc 1 : Our turn = 1 couleur → Your turn = palette 4 couleurs + assignments + 2 polices + logo. Vraie montée en complexité, objet d'apprentissage identique (`_brand.yml`).
- Bloc 2 : Our turn = `type: default` → `type: book` → Your turn = `appendices` + brand projet + bonus cross-refs/pagebreak. Chaque étape Your turn s'appuie sur ce qu'on vient de voir.

### `echo: false` + starters partiels : charge R neutralisée

`exercises/01-document-typst/starter/rapport-starwars.qmd:7-9` — `execute: { echo: false, warning: false, message: false }` en place. Starter Exo 2 sans `_quarto.yml` (à créer) mais avec tous les `.qmd` prêts. L'apprenant n'écrit pas de R — il configure du YAML. Conforme au principe de scaffolding.

### Arc narratif `.qmd → PDF pro → livre → personnalisé/pérennisé` traçable bout-à-bout

Cinq bullets du wrap-up (`2-projets/2-projets.qmd:162-167`) font écho aux 3 questions de l'accueil (`index.qmd:17-19`). La slide "Et maintenant ?" donne une action immédiate ("ouvrez un `.qmd` existant cette semaine"), une piste d'approfondissement et une communauté — sans mentionner des concepts non couverts en séance comme promesses implicites.

### Fixes de la review 2026-05-25 intégrés

| Item précédent | État |
|---|---|
| P1-1 désynchro 4/5/6 étapes Exo 1 boussole vs page | ✅ Réglé : boussole = 4 core + B1 bonus |
| P1-2 charte jamais projetée dans les slides | ✅ Réglé : slide "Voici la charte" + note presenter |
| P1-3 README durée 15 vs 12 min | ✅ Réglé : `exercises/01-document-typst/README.md` dit 12 min |
| P2-3 boussole Exo 1 ne mentionne pas la charte | ✅ Réglé : `1-quarto-typst/boussole.qmd:19` |
| P2-1 méta-argument charte dans note presenter | ✅ Réglé : `1-quarto-typst/1-quarto-typst.qmd:214` |
| P2-2 statut `keep-typ` aligné | ✅ Réglé : B1 bonus sur boussole + page-exo |

### Items non résolus de la review précédente

| Item précédent | État |
|---|---|
| P1-4 notes co-animation quasi-absentes | Toujours en P2 (remontée en P2-1 ici) |
| P2-6 `brand_color_pluck` en position 3 sur 4 | Toujours en P2-2 ici |

---

## 📝 Évolution depuis la review précédente (2026-05-25)

### Ce qui s'est amélioré

1. **Refonte Our turn** : la démo minimale 2-étapes est pédagogiquement beaucoup plus propre. Plus de risque de "Your turn = répétition de Our turn". Le wording des callouts "Faisons ensemble !" est maintenant descriptif (actions concrètes) au lieu de conceptuel.
2. **Docs orateur `_speaker/`** : les deux fichiers sont un ajout structurant. Aucun gap d'outillage formateur désormais.
3. **Fixes ciblés des 6 items P1/P2 précédents** : tous résolus sans introduire de régression visible.

### Ce qui était déjà bon et reste bon

- Cycle My/Our/Your respecté dans les deux blocs (avec la réserve P1-2 sur la slide d'intro).
- Scaffolding exercices : `echo: false`, starters partiels, boussole countdown, 3 filets d'autonomie.
- Page Préparatifs avec Plan B offline et test Typst end-to-end.
- Notes presenter avec erreurs fréquentes anticipées (guillemets hex, underscore YAML, espacement chiffres gt).

### Ce qui aurait pu se dégrader — et n'a pas

- **Risque de surcharge Our turn** : non confirmé. Les 2 étapes sont rapides (5-6 min), les snippets sont prêts à coller dans les docs orateur.
- **Cohérence inter-blocs** : le rythme M/O/Y est symétrique entre Bloc 1 et Bloc 2. Un participant qui a vécu Bloc 1 sait exactement ce qui l'attend en Bloc 2.
- **Arc narratif** : non dégradé. Le wrap-up "Ce que vous savez faire maintenant" reste la bonne boucle de clôture.

### Nouveaux risques apparus avec la refonte

- **P1-1** (note orateur qui référence `.content-visible` comme ayant été montré en Our turn) — créé par la refonte : le Our turn est maintenant minimal, mais une note rescapée de l'ancienne version suggère une démo qui n'a plus lieu.
- **P1-2** (callout générique pour Your turn dans la slide d'intro) — pré-existant mais remis en relief par le refactor qui a soigné les callouts partout ailleurs.
