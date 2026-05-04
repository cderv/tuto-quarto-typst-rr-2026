# Review pédagogique — 2026-05-04 (vague 3, post-fix #2)

> Reviewer : agent reviewer (pédagogue, 3ᵉ vague). État inspecté : working tree de `claude/post-merge-doc-audit` qui contient l'ensemble des fixes du brief (B1 wrap-up, C1 helpers brand R, C2 logo SW correction Exo 1, C3 mini-test install, réformulation « À la fin de ce bloc, vous saurez »).
> Méthode : re-lecture intégrale du périmètre, focus sur les boucles promesse/validation et sur la cohérence des fixes livrés. Pas de render R (R indisponible dans le sandbox), mais structure pédagogique entièrement vérifiable à la lecture.

## Verdict général

**Matériel pédagogiquement prêt pour le 16 juin.** La review #2 avait isolé un seul P1 (wrap-up Bloc 2 absent) — il est livré avec les trois slides terminales attendues (`2-projets/2-projets.qmd:142-180`), et la qualité dépasse l'attendu : la slide « Ce que vous savez faire maintenant » utilise `::: incremental` pour rejouer les 4 promesses du tutoriel, la slide « Et maintenant ? » donne un horizon temporel clair (« cette semaine »), et la slide finale prévoit un hand-off explicite CD → Maëlle pour Q&A avec deux questions stock en filet de sécurité. La réformulation « À la fin de ce bloc, vous saurez » sur les pages bloc (`1-quarto-typst/index.qmd:24-29`, `2-projets/index.qmd:24-28`) referme la boucle promesse/validation qu'on flaggait depuis la review du matin. Les autres fixes (C1/C2/C3) sont propres et n'introduisent aucune friction nouvelle. Aucun nouveau P0 ou P1 trouvé.

## P0 — bloquant pour le 16 juin

Aucun.

## P1 — à corriger avant le 16 juin

Aucun.

## P2 — nice-to-have

### Asymétrie co-animation : Maëlle invisible côté Bloc 1

- `1-quarto-typst/1-quarto-typst.qmd` n'a **aucune** indication « qui parle » dans les notes presenter (`grep "CD parle\|Maëlle"` → 1 seul hit, l'auteur en YAML). Le Bloc 2 a 3 hand-offs explicites (`2-projets/2-projets.qmd:152, 166, 177`).
- Conséquence : si on lit les notes presenter au pied de la lettre, Maëlle n'a aucun moment réservé avant la slide « Merci ! Questions ? ». Pour le public, elle peut donner l'impression d'être passive pendant 1h40, puis de récupérer le micro juste pour le Q&A.
- Recommandation triviale (1 ligne) : ajouter dans les notes de `1-quarto-typst/1-quarto-typst.qmd:144-148` (slide `_brand.yml`) une option « Maëlle peut prendre la main 30 sec ici sur le helper R `theme_brand_ggplot2()` ». Le matériel existe déjà (correction Exo 1, ressource page 4) — il ne manque que l'invitation orale dans les notes presenter pour donner à Maëlle un moment naturel d'expression côté Bloc 1.
- Non-bloquant : cette répartition peut se gérer à l'oral CD/Maëlle hors-tutoriel. Mais avoir l'indication écrite réduit le risque d'oubli au feu de l'action.

### Wrap-up couvre les 2 blocs, pas explicitement le contrat Bloc 1

- La slide « Ce que vous savez faire maintenant » (`2-projets/2-projets.qmd:142-149`) liste 4 bullets : Typst, `_brand.yml`, `type: book`, savoir où chercher. La note presenter ligne 154 indique que ces bullets « miroir les 4 questions posées en intro (cf. `index.qmd:17-20`) ».
- Vérification : la promesse Bloc 1 (`1-quarto-typst/index.qmd:24-29`) liste **4** items : (1) `format: typst`, (2) options essentielles `papersize`/`margin`, (3) `keep-typ` et le pipeline `.qmd → .typ → .pdf`, (4) `_brand.yml`. Le wrap-up valide explicitement (1) et (4), mais pas (2) ni (3).
- Léger : le pipeline `keep-typ` est probablement la pépite « démystification » la plus mémorable du Bloc 1 (note presenter `1-quarto-typst/1-quarto-typst.qmd:111-113` parle de « moment pédagogique clé »). Il pourrait mériter un tiret dans le wrap-up final, du type « comprendre le pipeline `.qmd → .typ → .pdf` (et savoir le déboguer) ».
- Non-bloquant : l'arc visuel reste cohérent, et la slide « Et maintenant ? » prend déjà bien la suite. À garder en tête pour une v2 du tutoriel.

### Page `3-aller-plus-loin/index.qmd` orpheline mais avec timings trompeurs

- La page n'est plus dans la navbar (`_quarto.yml:14-25`), conformément à la décision « topic store » documentée dans `README.md:96-134`. Bonne décision pédagogique (évite la confusion « est-ce un Bloc 3 ? »).
- Mais la page conserve des annotations « (5 min) (12 min) (8 min) » (`3-aller-plus-loin/index.qmd:12, 21, 31`) qui suggèrent un découpage temporel — vestige d'une ancienne structure 3 blocs. Un participant qui tombe dessus via search/lien direct lira « 25 min de contenu prêt à enseigner » alors que rien de cela n'est au programme.
- Recommandation triviale : retirer les `(N min)` des trois H3, ou ajouter une note d'introduction « ces sujets sont des pistes pour aller plus loin après le tutoriel — non couverts en séance ». Cohérence avec le statut « topic store » revendiqué dans le README.
- Non-bloquant : impact très limité (la navbar guide bien le participant, et la page Ressources `4-ressources.qmd` est la véritable porte d'entrée « après tutoriel »).

### Mini-test C3 : friction faible mais à surveiller

- `exercises/00-test-install/test-install.qmd:25` : `opt_table_font(font = "Arial")` — Arial n'est pas garantie sur Linux (free fonts). Le bug `gt → Typst` qu'on cherche à éviter justement viendra du fallback Liberation Sans / DejaVu. Cohérence avec le troubleshooting `preparatifs.qmd:59` qui dit « le contournement (`opt_table_font(font = "Inter")`) sera vu pendant l'Exercice 1 » — donc le test attend des chiffres mal espacés sur Linux et c'est OK pour valider la chaîne.
- Mais le `preparatifs.qmd:51` dit « Aucune erreur en console » comme résultat attendu, alors que `unknown font family` (ligne 56) est annoncé comme warning à ignorer. Légère contradiction de tonalité : « aucune erreur » vs « ignorez ce warning ».
- Recommandation triviale : reformuler `preparatifs.qmd:51` en « Aucune **erreur** en console (un warning sur la police est normal et documenté ci-dessous) ». Évite que le participant le plus consciencieux paniquer pour rien et écrive sur le canal Slack 5 min avant le tutoriel.
- Non-bloquant : le troubleshooting suit immédiatement et désamorce. Le participant qui lit jusqu'au bout est rassuré.

### Pas de cliffhanger explicite Bloc 1 → pause → Bloc 2 dans les slides

- Bloc 1 se termine sur « Saviez-vous que... » (`1-quarto-typst/1-quarto-typst.qmd:186-198`), explicitement positionné comme « premier fusible à couper » (note presenter ligne 201). Si elle saute, le Bloc 1 se termine littéralement sur l'expiration du chronomètre Your turn.
- La transition « du document au livre » est bien préparée **dans la correction Exo 1** (`exercises/01-document-typst/correction/rapport-starwars.qmd:107` : « il faudrait étendre ce rapport en livre — c'est l'objet du Bloc 2 »), mais aucun participant ne lit la correction avant la pause. Et la slide d'ouverture Bloc 2 (`2-projets/2-projets.qmd:11`) commence directement sur `_quarto.yml` sans rappel narratif.
- Recommandation : la note presenter `2-projets/2-projets.qmd:28-30` indique déjà à CD comment faire la transition à l'oral (« au Bloc 1 on a stylé un document unique. Maintenant on passe à l'échelle. Le `_brand.yml` créé dans l'exercice 1 va être réutilisé ici »). Bien. Le risque résiduel est si CD oublie de la dire — il pourrait être utile d'avoir une slide titre « Du document au livre » avec une figure 1-écran qui rejoue visuellement l'arc, mais c'est un nice-to-have, pas un manque.
- Non-bloquant : le hand-off est porté par le presenter, c'est OK pour une co-animation.

## Forces pédagogiques confirmées

### Wrap-up Bloc 2 livré : exactement la qualité espérée

- Slide « Ce que vous savez faire maintenant » (`2-projets/2-projets.qmd:142-149`) — `::: incremental` permet le « rejeu » progressif des 4 acquis. Pédagogiquement, le participant **revit** ses victoires une à une au lieu de les lire d'un bloc.
- Slide « Et maintenant ? » (`2-projets/2-projets.qmd:157-167`) — donne un horizon temporel concret (« cette semaine », « pour creuser », « communauté ») et boucle vers `4-ressources.qmd`. C'est le pattern andragogique « action concrète immédiate après formation » qui maximise la rétention.
- Slide « Merci ! Questions ? » (`2-projets/2-projets.qmd:169-180`) — hand-off CD → Maëlle explicitement écrit dans les notes (« CD passe la main à Maëlle pour Q&A »), et 2 questions stock pré-préparées en filet de sécurité (« et si je veux du LaTeX et du Typst dans le même projet ? », « équipe avec 5 ans de templates LaTeX »). Co-animation parfaitement scénarisée.

### Boucle promesse → validation refermée

- `index.qmd:17-20` pose 4 questions du tutoriel.
- `1-quarto-typst/index.qmd:24-29` les décline en 4 « À la fin de ce bloc, vous saurez ».
- `2-projets/index.qmd:24-28` fait pareil pour le Bloc 2 en 3 verbes infinitifs (centraliser, assembler, identifier) — formulation côté apprenant impeccable.
- Slide wrap-up `2-projets/2-projets.qmd:142-149` rejoue 4 acquis en miroir des 4 questions intro. **La boucle est explicitement notée par le presenter** (note ligne 154 : « miroir les 4 questions posées en intro »).
- C'est le 1er des 7 principes andragogiques (« les adultes ont besoin de savoir pourquoi ils apprennent ») entièrement traité, du `index.qmd` au wrap-up.

### Cohérence visuelle Bloc 1 ↔ Bloc 2 grâce au logo SW (fix C2)

- `exercises/01-document-typst/correction/_logo-sw.svg` + même logo dans `exercises/02-projet-book/correction/_logo-sw.svg`. Le participant qui passe son rapport au statut de livre **reconnaît son logo** sur la couverture orange-book. Excellent renforcement narratif (« mon document devient mon livre ») — c'est exactement le type de cohérence matérielle qui crée le « moment wow » au Bloc 2.

### Helpers `theme_brand_ggplot2()` / `theme_brand_gt()` (fix C1)

- `exercises/01-document-typst/correction/rapport-starwars.qmd:25-31, 65-69, 98-99` : utilisation explicite avec commentaires inline qui expliquent ce que font les helpers.
- README Exo 1 (`exercises/01-document-typst/README.md:32-34`) tient désormais la promesse étape 4 (« utilisez les helpers du package R `brand.yml` »).
- `4-ressources.qmd:72` les liste avec lien vers le package — pour le participant motivé qui veut les retrouver après.
- Mention orale prévue dans les notes presenter `1-quarto-typst/1-quarto-typst.qmd:146` (« 30 sec pendant la démo Our turn »). Bien dosé : pas de slide dédiée, juste une mention.

### Mini-test install C3 : sécurise l'entrée participant

- `preparatifs.qmd:43-59` : section dédiée avec commande exacte, résultat attendu décrit en 3 éléments visibles (« titre accentué, tableau 3 lignes, graphique »), 5 cas de troubleshooting préanticipés.
- `exercises/00-test-install/test-install.qmd` : minimal (47 lignes), couvre R + dplyr + gt + ggplot + Typst + accents. Bonne décision de mettre `echo: false` (ne distrait pas le participant avec du code, focus sur « ça marche / ça marche pas »).
- Le test n'utilise pas `_brand.yml` ni Google Fonts (commentaire explicite ligne 58 du `preparatifs.qmd`) : excellent — un participant offline peut valider sa chaîne sans condition réseau.

### Notes presenter dosées et utiles

- Toutes les slides callout ont des notes presenter dédiées avec : timing recommandé, problèmes fréquents anticipés, fusibles à couper si timing serre (`1-quarto-typst/1-quarto-typst.qmd:201`, `2-projets/2-projets.qmd:139`), répartition CD/Maëlle (Bloc 2). Elles permettent à un présentateur tiers de reprendre le matériel — c'est aussi un test de robustesse pédagogique.

### Rythme M/O/Y respecté de bout en bout

- Bloc 1 : My turn (`1-quarto-typst/1-quarto-typst.qmd:43-149`) → Our turn callout-tip vert (`:151-167`) → Your turn callout jaune + countdown (`:169-184`) → pépite (`:186-198`).
- Bloc 2 : My turn (`2-projets/2-projets.qmd:11-67`) → Our turn (`:69-89`) → Your turn (`:91-120`) → pépite (`:122-140`) → wrap-up (`:142-180`).
- Conventions de couleur (#27ae60 vert Our turn, #FDC538 jaune Your turn) appliquées partout. Visuellement cohérent.

## Évolution depuis la review précédente

### Ce qui s'est amélioré (review #2 → review #3)

- **P1 wrap-up Bloc 2 résolu** (B1 / `2-projets/2-projets.qmd:142-180`) : trois slides terminales livrées avec qualité supérieure à l'attendu. Hand-off CD/Maëlle explicite, questions stock en filet, `::: incremental` pour rejeu progressif. Single P1 de la review #2 entièrement traité.
- **P2 « objectifs implicites » résolu** : sections « Concepts clés » réformulées en « À la fin de ce bloc, vous saurez » (`1-quarto-typst/index.qmd:24`, `2-projets/index.qmd:24`) avec verbes infinitifs côté apprenant. La review #2 avait suggéré ce fix « lite, en 1 commit » — fait, et c'est exactement la formulation andragogique attendue.
- **Cohérence narrative renforcée** (C2 / logo SW partagé) : la matérialité « mon document → mon livre » est désormais portée par un asset visuel concret. C'était une absence non flaggée par la review #2 mais qui aurait probablement émergé en P2 « cohérence narrative » lors d'un test utilisateur.
- **Promesse README Exo 1 tenue** (C1 / helpers `theme_brand_*`) : la promesse étape 4 du README et la promesse implicite de `_brand.yml` (« la charte suit partout, y compris vos figures ») sont désormais matérialisées dans la correction.
- **Friction d'entrée participant réduite** (C3 / mini-test install) : avant, le participant devait attendre l'Exercice 1 pour découvrir si sa chaîne Typst fonctionnait. Désormais il peut valider à froid avec une commande explicite et un troubleshooting préanticipé. C'est une victoire pour l'adoption du tutoriel — particulièrement pour les participants moins à l'aise techniquement.

### Ce qui était déjà bon et reste bon

- Découpage `code-line-numbers="1-2|4-9|10-11|13"` sur `2-projets/2-projets.qmd:34` (4 beats pour le YAML book) : noté comme une force dans la review #2, toujours là.
- Découpage Exo 2 en 3 étapes principales + 2 bonus (`2-projets/index.qmd:51-72`) : toujours la meilleure défense contre la pression « rapide vs lent » — preserved.
- Annonce explicite « Exercice 2 autonome vis-à-vis de l'Exercice 1 » (`2-projets/index.qmd:40-42`) : toujours là.
- Notes presenter denses et présentes sur quasi toutes les slides callout : préservées et même enrichies (B1 ajoute des notes nouvelles propres).

### Ce qui aurait pu se dégrader mais ne s'est pas dégradé

- Risque potentiel : ajouter 3 slides au wrap-up Bloc 2 + une section « Test de la chaîne Typst » à `preparatifs.qmd` aurait pu déséquilibrer le timing 40 min Bloc 2. Vérification : Bloc 2 reste découpé My turn 5 min + Our turn 10 min + Your turn 15 min + pépite 2-3 min + wrap-up estimé 5 min = ~37-38 min, dans le slot 40 min. OK, pas de dérapage.
- Risque potentiel : le mini-test install aurait pu introduire une friction inverse (« je dois faire un truc en plus avant le tutoriel »). Atténuation effective : la commande est unique, le résultat attendu est décrit visuellement, et le troubleshooting est intégré. C'est un gain net pour le participant moins à l'aise.
- Risque potentiel : ajouter `_logo-sw.svg` à la correction Exo 1 aurait pu créer une attente que le starter Exo 1 le fournisse aussi (or starter Exo 1 = 1 seul fichier `.qmd`). Vérification : README Exo 1 ligne 30 « un logo SVG — cf. `correction/_logo-sw.svg` » indique clairement où le récupérer. Pas de friction nouvelle créée.
- Aucune régression détectée.
