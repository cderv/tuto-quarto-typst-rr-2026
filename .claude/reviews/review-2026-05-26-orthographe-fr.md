# Review orthographe & typographie FR — 2026-05-26

**Périmètre** : `index.qmd`, `preparatifs.qmd`, `4-ressources.qmd`, `3-aller-plus-loin/index.qmd`, `1-quarto-typst/1-quarto-typst.qmd`, `1-quarto-typst/index.qmd`, `1-quarto-typst/boussole.qmd`, `2-projets/2-projets.qmd`, `2-projets/index.qmd`, `2-projets/boussole.qmd`, `_speaker/demo-bloc1-our-turn.qmd`, `_speaker/demo-bloc2-our-turn.qmd`, READMEs exercises.

## Verdict général

Les P1 de la review du 25/05 ont presque tous été traités : « brandé » a disparu, « Setup » → « Mise en place » est fait, les « deep dives » sont devenus « approfondissements ». La qualité linguistique est globalement au niveau workshop pro. Il reste un noyau de 8 anglicismes non assumés dans les supports visibles aux participants ou dans les docs orateur — aucun bloquant pour la projection, mais trois méritent correction avant le 16 juin. Le nouveau wording Our turn (Bloc 1 et Bloc 2) est naturel et lisible en français. Les docs `_speaker/` présentent un régime d'anglicismes plus dense (ce sont des notes internes), mais quelques termes remontent dans les notes presenter des slides et méritent attention.

## P0 — gros problème linguistique

Aucun.

## P1 — à corriger avant le 16 juin

### 1. « assignments » — terme anglais non traduit exposé aux participants

`1-quarto-typst/index.qmd:50` (tableau, colonne "Action" visible par tous), `1-quarto-typst/index.qmd:58` (tableau), `1-quarto-typst/1-quarto-typst.qmd:229` (slide Our turn), `1-quarto-typst/1-quarto-typst.qmd:257` (slide Your turn), `_speaker/demo-bloc1-our-turn.qmd:18` (doc orateur).

La note presenter `1-quarto-typst/1-quarto-typst.qmd:216` explique bien le terme. Mais cette explication reste invisible dans les surfaces participants (tableau, slides). Proposition : **« affectations »** (terme exact utilisé dans la spec `_brand.yml` française) ou **« assignations de rôles »**.

### 2. « Customisation » en note presenter de slide visible

`1-quarto-typst/1-quarto-typst.qmd:191` (note presenter) :

> « **Customisation** via `format.typst.logo: { path, location, width, padding }` »

→ « **Personnalisation** via `format.typst.logo: { path, location, width, padding }` »

(La review du 25/05 avait signalé ce terme ; toujours présent dans ce commit.)

### 3. « Cue rapide » en note presenter de slide

`1-quarto-typst/1-quarto-typst.qmd:271` :

> « **Cue rapide** pour les participants qui finissent vite »

→ « **Signal rapide** » ou « **Indication** pour les participants qui finissent vite ».

### 4. Cohérence inclusive : « les bloqués » sans point médian

`1-quarto-typst/1-quarto-typst.qmd:265` (note presenter) :

> « Passer dans les rangs pour aider **les bloqués**. »

Partout ailleurs dans le fichier : `apprenant·e`, `participant·e·s`, `bloqué·e·s` implicite. La forme non inclusivée est incohérente avec le reste.

→ « Passer dans les rangs pour aider **les bloqué·e·s**. »

## P2 — nice-to-have

### 5. « wow » en prose

`2-projets/2-projets.qmd:63` (note presenter), `_speaker/demo-bloc2-our-turn.qmd:87` (titre de section doc orateur), `2-projets/index.qmd:189` (prose apprenant — bonus 4, visible sur le site).

Dans les notes presenter et docs orateur, « wow » est tolérable comme raccourci expressif. En revanche, `2-projets/index.qmd:189` est visible par tous les participants sur la page web. Proposition : « **L'effet spectaculaire** » ou « **Le résultat frappant** ».

### 6. « swatches » et « hex codes » dans un texte alternatif

`1-quarto-typst/1-quarto-typst.qmd:198` (attribut `fig-alt`, contenu accessible) :

> « …4 **swatches** de palette (…) avec **hex codes**… »

Le texte alternatif est lu par les lecteurs d'écran et devrait être en français courant.

→ « …4 **échantillons de couleur** de palette (…) avec **codes hexadécimaux**… »

### 7. « beats » — anglicisme pédagogique interne

`2-projets/2-projets.qmd:65` (note presenter) :

> « 4 **beats** = 4 idées, plus digestible que tout d'un coup. »

Terme de dramaturgie anglophone. Dans une note interne c'est mineur, mais « **temps forts** » ou « **séquences** » seraient équivalents et plus lisibles à la relecture.

### 8. « 3 core » en note presenter

`2-projets/2-projets.qmd:133` (note presenter) :

> « 12 min sur les **3 core** + 3 min de bonus pour les rapides. »

→ « 12 min sur les **3 étapes principales** + 3 min de bonus pour les rapides. »

### 9. « deep dives » persistant dans boussole et README

`2-projets/boussole.qmd:39` (page visible participants), `exercises/02-projet-book/README.md:19` (README visible sur GitHub).

La page `2-projets/index.qmd` avait été corrigée (P1 du 25/05 : « Les Bonus 3 et 4 ci-dessous sont des approfondissements »), mais ces deux surfaces ont conservé « deep dives ».

→ « **approfondissements** B3/B4 » dans les deux fichiers.

### 10. « outputs R » en prose apprenant

`2-projets/index.qmd:189` (visible sur le site) :

> « …la charte pilote le PDF *et* tous les **outputs R** depuis un seul fichier. »

→ « …la charte pilote le PDF *et* toutes les **sorties R** depuis un seul fichier. »

### 11. « Polices brand pas chargées » — titre de callout mal formé

`2-projets/index.qmd:141` :

> `## Polices brand pas chargées (Quarto < v1.10.4)`

La construction « Polices brand » (article omis + anglicisme adjectival) est bancale en français.

→ `## Polices de la charte non chargées (Quarto < v1.10.4)` ou `## Polices _brand.yml_ non transmises (Quarto < v1.10.4)`

### 12. « Polices: » sans espace avant le deux-points dans une liste de slide

`1-quarto-typst/1-quarto-typst.qmd:205` (liste incrémentale dans une slide, visible sur écran) :

> `- Polices: Inter (Google) + Star Jedi (locale)`

Manque l'espace insécable avant `:`. À vérifier si le rendu corrige automatiquement ; sinon : `- Polices : Inter (Google) + Star Jedi (locale)`.

### 13. « baseline » et « Skip » dans docs orateur

`_speaker/demo-bloc2-our-turn.qmd:51`, `:181`, `:191` : « baseline » (état de référence avant modification).
`_speaker/demo-bloc1-our-turn.qmd:154` ; `_speaker/demo-bloc2-our-turn.qmd:181` : « Skip étape 2 », « Skip render baseline ».

Dans les docs orateur (usage strictement interne), ces termes sont mineurs. Équivalents FR : « état initial » / « passer », « ignorer ».

### 14. « warning » comme terme courant en prose

`2-projets/index.qmd:143` (prose visible participants) :

> « (titres en serif au lieu de Star Jedi, **warning** `unknown font family: ...` à la compilation) »

L'usage est ambigu mais acceptable car le `warning` est immédiatement suivi du message entre backticks, donc lu comme une citation littérale. `preparatifs.qmd:60` dit « un **avertissement** sur la police » — cohérence possible.

## Forces linguistiques

- **Vouvoiement uniforme** dans tout le contenu participant.
- **Nouveau wording Our turn naturel** : « on passe le doc en `format: typst`, puis on lui applique une couleur », « le saut est planté » (Bloc 2), « vous avez vu la boucle » (Bloc 1).
- **Aucun tutoiement résiduel** dans les pages participants.
- **Aucun doublon de mot** en prose.
- **Aucun faux ami** détecté.
- **Inclusif au point médian cohérent** — sauf un oubli signalé en P1.
- **Terminologie technique uniforme inter-blocs** : « charte » (brand), « police » (font), « références croisées », « chaîne de compilation », « contournement ».
- **Aucune forme courte Fig./Tab.** Formes longues « Figure 1.1 », « Table 1.1 » partout.
- **Apostrophes ASCII `'`** — cohérence parfaite, Pandoc `smart` + `lang: fr` convertit à la sortie.
- **`_speaker/` docs** : qualité globalement bonne pour des notes internes.

## Évolution depuis la review du 25/05

**Corrigé depuis le 25/05 :**

- « brandé » (×4) → « stylé » : fait.
- « Setup » → « Mise en place » (`2-projets/index.qmd:191`) : fait.
- « deep dives » → « approfondissements » sur `2-projets/index.qmd:166` : fait.
- La coquille majuscule `2-projets/2-projets.qmd:80` (minuscule après point) : fait — le fichier a été remanié.
- « 3 core » dans la note presenter Bloc 2 : toujours présent (l. 133), signalé en P2 ici.

**Non corrigé depuis le 25/05 :**

- `4-ressources.qmd:36` : « retour d'expérience d'une migration pagedown → Typst côté R » → toujours P2.
- `Customisation` (`1-quarto-typst/1-quarto-typst.qmd:191`) → toujours présent, maintenu en P1.
- `preparatifs.qmd:45` commentaire R `# 1.9.37 mini` → toujours présent (P2 mineur).
- Les guillemets droits autour de termes anglais dans `3-aller-plus-loin/index.qmd` (P2 du 25/05) : toujours présents.

**Nouveau depuis le 25/05 :**

- Les deux fichiers `_speaker/` sont propres pour des notes internes, avec les anglicismes circonscrits relevés ci-dessus.
- Le wording Our turn remanié (Bloc 1 et Bloc 2) est propre linguistiquement.

## Bilan actionnable

4 corrections P1 dans 3 fichiers participants (assignments × 4 occurrences slides+tableau, Customisation, Cue rapide, bloqué·e·s). Tout le reste est au niveau attendu pour un workshop francophone professionnel.

Fichiers sources concernés par les P1 : `1-quarto-typst/1-quarto-typst.qmd` (lignes 191, 229, 257, 265, 271), `1-quarto-typst/index.qmd` (lignes 50, 58).

Fichiers concernés par les P2 : `2-projets/2-projets.qmd` (lignes 63, 65, 133), `2-projets/index.qmd` (lignes 141, 189), `2-projets/boussole.qmd` (ligne 39), `exercises/02-projet-book/README.md` (ligne 19), `_speaker/demo-bloc1-our-turn.qmd` (lignes 18, 154), `_speaker/demo-bloc2-our-turn.qmd` (lignes 51, 87, 181, 182, 191, 192).
