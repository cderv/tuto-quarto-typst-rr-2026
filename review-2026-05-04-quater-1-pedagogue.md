# Review pédagogique — 2026-05-04 (vague 4, post-fix #3)

> Reviewer : agent reviewer (pédagogue, 4ᵉ vague). État inspecté : HEAD `39f9ff5` sur `claude/post-merge-doc-audit`.
> Méthode : focus ciblé sur les 4 P2 traités (et le P2 #5 non traité) de ma review vague 3 + chasse aux régressions introduites par les 3 commits de fixes (`438aafd`, `625c03e`, `39f9ff5`). Pas de re-review intégrale ; pas de render (R indisponible, mais fixes vérifiables à la lecture).

## Verdict général

**Matériel pédagogiquement prêt pour le 16 juin, sans réserve.** Les 4 P2 traités tiennent : la 5ᵉ bullet ajoutée au wrap-up (`2-projets/2-projets.qmd:146`) referme proprement la promesse `keep-typ` du Bloc 1, le hand-off Maëlle dans Bloc 1 (`1-quarto-typst/1-quarto-typst.qmd:148`) est à un endroit pédagogiquement pertinent (slide `_brand.yml`, juste avant les helpers R qu'elle peut signer), le statut topic store de `3-aller-plus-loin/index.qmd` est désormais explicite via le callout-note minimal (L12-14), et la contradiction « aucune erreur » vs « warning à ignorer » de `preparatifs.qmd:51` est désamorcée. Le P2 #5 (cliffhanger Bloc 1 → Bloc 2) reste effectivement acceptable sans slide dédiée. Aucune nouvelle régression détectée — et bonus, le compte « 4 questions » dans la note presenter L155 a bien été mis à jour en cohérence avec le retrait de Q4 dans `index.qmd` (commit `625c03e`). Verdict : **0 P0, 0 P1, 1 P2 (mineur), 0 régression**.

## P0 — bloquant pour le 16 juin

Aucun.

## P1 — à corriger avant le 16 juin

Aucun.

## P2 — nice-to-have

### Léger flou narratif sur la 5ᵉ bullet wrap-up — promesse Q1 « LaTeX » inchangée, mais 5ᵉ bullet « savoir où chercher » devient le seul lien explicite vers `3-aller-plus-loin`

- `2-projets/2-projets.qmd:149` : « Savoir où chercher pour aller plus loin (partials, formats communautaires — couverts en pistes, pas en séance) ».
- C'est cohérent avec le statut topic store désormais clarifié de `3-aller-plus-loin/index.qmd`. Mais il n'y a pas de lien hypertexte cliquable depuis la slide vers cette page (la page n'est plus dans la navbar non plus). Sur la slide « Et maintenant ? » qui suit (`2-projets/2-projets.qmd:158-162`), le lien pointe vers `4-ressources.qmd`, pas vers `3-aller-plus-loin/index.qmd`.
- Conséquence : si un participant accroche sur « partials, formats communautaires » dans le wrap-up, il n'a pas de pointeur direct depuis les slides vers la page topic store qui les couvre. Il devra passer par `4-ressources.qmd` (qui a effectivement les bonnes sections « Template partials — guide » L104-137 et « Formats Typst existants » L37-42).
- Recommandation triviale (1 ligne, optionnelle) : la slide « Et maintenant ? » L161 dit déjà « la page Pour aller plus loin (partials, blocs raw Typst, accessibilité PDF/UA-1, helpers `brand.yml` côté R) » avec lien vers `4-ressources.qmd`. C'est correct — la 5ᵉ bullet wrap-up est en fait validée par la slide suivante. Donc rien à faire au niveau matériel, mais **la note presenter L155** pourrait gagner un mot du type « les 5ᵉ bullet est rappelée concrètement à la slide suivante (lien `4-ressources.qmd`) » pour que CD ait le réflexe de pointer vers la slide suivante en disant la 5ᵉ bullet.
- Non-bloquant : le risque est purement « participant qui zappe la slide d'après et ne sait pas où trouver les partials » — mais la page Ressources est bien dans la navbar, et le lien depuis la slide « Et maintenant ? » est précis. C'est un nice-to-have de seconde lecture, pas un trou pédagogique.

## Forces pédagogiques confirmées

### TON P2 #1 (Maëlle invisible Bloc 1) — résolu proprement

- `1-quarto-typst/1-quarto-typst.qmd:148` : « **Maëlle peut prendre la main 30 sec ici** sur les helpers R `theme_brand_*()` (signature naturelle de son passage Bloc 1, le matériel correction Exo 1 + Ressources existe déjà — c'est le moment opportun pour donner à Maëlle un temps de parole avant le Q&A final). »
- Excellent placement : c'est sur la slide `_brand.yml` (slide « deuxième moment fort » selon la note presenter L144), donc le moment narratif le plus naturel. Et elle reste sur **30 sec** — pas un partage de timing qui déséquilibrerait Bloc 1. Cohérence avec le hand-off déjà existant de la slide « Et maintenant ? » (`2-projets/2-projets.qmd:166-167`) : Maëlle a désormais **2 micro-interventions** (Bloc 1 + Bloc 2 wrap-up) avant le Q&A final qu'elle anime. Co-animation crédible sur les 2h.

### TON P2 #2 (wrap-up sans validation des promesses keep-typ Bloc 1) — résolu, lisibilité préservée

- 5ᵉ bullet ajoutée `2-projets/2-projets.qmd:146` : « Inspecter le pipeline `.qmd` → `.typ` → `.pdf` via `keep-typ: true` ».
- Note presenter L155 mise à jour : « **5 bullets** font écho aux **3 questions** posées en intro (cf. `index.qmd:17-19`) et aux apprentissages détaillés des 2 pages de bloc ». Cohérence avec le retrait de Q4 dans `index.qmd` (de 4 à 3 questions, commit `625c03e`).
- Vérification anti-régression timing : 5 bullets `::: incremental` dans la slide « Ce que vous savez faire maintenant » → 5 clics pour les révéler, ~5-7 sec/clic = **~30-40 sec** sur cette slide. Estimation Bloc 2 reste : My turn 5 + Our turn 10 + Your turn 15 + pépite 2-3 + wrap-up 5 (slides « savez faire » + « et maintenant » + « merci ») = ~37-40 min. **Pas de dérapage** sur le slot 40 min Bloc 2.
- La slide n'est pas titre `{.smaller}` (vérifié), donc 5 bullets restent confortablement lisibles à la projection. Pas de surcharge.

### TON P2 #3 (page topic store avec timings trompeurs) — résolu sans dégrader le statut topic store

- `3-aller-plus-loin/index.qmd:12-14` : callout-note minimal en tête : « Ces sujets sont des **pistes pour aller plus loin après le tutoriel**, pas couverts en séance. Le programme officiel tient en 2 blocs (cf. [page d'accueil](../index.qmd)). Cette page sert de point d'entrée pour les autodidactes. »
- Timings retirés des H3 (L16, 25, 35) — vérifié. L'arc « 1 — Blocs raw Typst / 2 — Template partials / 3 — Extensions & partage » reste un découpage pédagogique cohérent (allant du plus simple « raw » au plus avancé « extensions »), mais sans suggérer de minutage.
- Lien vers `index.qmd` dans le callout fait re-pointer le participant qui aurait atterri là par erreur vers la vraie home — bonne sécurité de navigation.
- Le statut « topic store » n'est pas dégradé : la page reste une référence consultable, désormais explicitement positionnée comme post-tutoriel. Bonne décision.

### TON P2 #4 (contradiction `preparatifs.qmd:51`) — résolu en 1 mot, pas plus

- `preparatifs.qmd:51` : « Aucune **erreur** en console (un avertissement sur la police est normal et documenté ci-dessous) ».
- Le mot `erreur` est en gras, et le warning est immédiatement contextualisé en parenthèse — donc le participant consciencieux qui voit `unknown font family` n'aura plus le réflexe panique « j'ai cassé quelque chose ». Le troubleshooting L56 confirme et désamorce. Boucle de feedback autonomie : intacte.

### TON P2 #5 (cliffhanger Bloc 1 → Bloc 2) — non traité, et c'est OK

- Vérifié : `2-projets/2-projets.qmd:11` commence toujours directement sur `_quarto.yml — centraliser la config`, sans slide titre « Du document au livre ».
- Mais la note presenter L28-30 reste : « Transition naturelle : au Bloc 1 on a stylé un document unique. Maintenant on passe à l'échelle. Le _brand.yml créé dans l'exercice 1 va être réutilisé ici — on le déplace juste à la racine. » Le hand-off est porté par CD à l'oral, c'est suffisant pour une co-animation.
- **Confirme ton avis vague 3** : non-bloquant. À noter pour une v2 du tutoriel si besoin (slide titre 1-écran « Du document au livre » avec figure narrative), mais pas pour le 16 juin.

### Cohérence FR + débutant des fixes vagues parallèles (commits `438aafd` + `625c03e`)

- `4-ressources.qmd:72` : « Fonctions auxiliaires R pour propager la charte aux sorties graphiques » (au lieu de « Helpers R »). Bonne traduction, conserve la précision technique sans anglicisme.
- `2-projets/index.qmd:28` : « Reconnaître que `format: typst` + `type: book` active automatiquement l'extension orange-book (Quarto 1.9) » — verbe d'objectif plus modeste et plus honnête côté apprenant que « Identifier l'auto-activation… ». Promesse plus tenable en 40 min.
- `exercises/02-projet-book/{starter,}/README.md` : « 5 HTML séparés (format par défaut de Quarto) » — promesse correcte vis-à-vis de l'état initial du starter (pas de `_quarto.yml`, donc Quarto bascule en HTML). C'est la première étape de l'exercice qui ajoute `format: typst` pour basculer en PDF. Plus honnête et pédagogiquement aligné avec le « moment wow » de l'étape 2.
- `exercises/01-document-typst/README.md:28-35` : étape 4 reformulée en logo optionnel (« si vous en avez un sous la main »), avec mention explicite « La correction (`correction/`) fournit un exemple complet avec un logo Star Wars » qui résout la friction « ne pas ouvrir correction/ avant le tutoriel » sans le contredire — la correction est mentionnée comme référence post-exercice, pas comme prérequis.

## Évolution depuis la review précédente

### Ce qui s'est amélioré (vague 3 → vague 4)

- **4/5 P2 vague 3 traités** avec des fixes ciblés (1-2 lignes par P2), zéro sur-correction. Le pédagogue est entendu sans inflation matérielle.
- **Aucun fix ne dégrade un autre aspect** — le test de cohérence le plus exigeant (5 bullets wrap-up + 4 sec/bullet incremental ne mange pas le slot Bloc 2) passe.
- **Effet collatéral positif** : le retrait de Q4 dans `index.qmd` (vague 3 fix débutant, commit `625c03e`) a forcé une mise à jour cohérente de la note presenter wrap-up Bloc 2 (de « 4 questions » → « 3 questions »), ce qui est une preuve que les commits de la vague 3 sont **cross-checked entre eux** plutôt que livrés en silos.
- **Hand-off Maëlle Bloc 1** ajouté à un endroit pédagogiquement précis (slide `_brand.yml`, là où sa contribution `theme_brand_*()` a une signature naturelle) — pas un placement arbitraire.

### Ce qui était déjà bon et reste bon

- Wrap-up Bloc 2 trois slides (« savez faire / et maintenant / merci ») : préservé et même renforcé par la 5ᵉ bullet.
- Boucle promesse → validation `index.qmd` → pages bloc → wrap-up : préservée et désormais explicitement notée pour le presenter (note L155 cite les 3 sources).
- Notes presenter denses sur quasi toutes les slides callout : enrichies (Maëlle Bloc 1 ajouté) sans alourdir la lecture.
- Co-animation scénarisée (3 hand-offs explicites Bloc 2 + 1 hand-off Bloc 1 désormais) : meilleur équilibre.

### Ce qui aurait pu se dégrader mais ne s'est pas dégradé

- **Slide wrap-up Bloc 2 à 5 bullets** — risque de surcharge visuelle ou de dérapage timing. Vérifié : pas de `{.smaller}` requis (5 bullets courts), `::: incremental` permet d'étaler ~30-40 sec, le slot 40 min Bloc 2 reste tenu.
- **Note presenter Bloc 1 enrichie de 2 nouveaux passages** (`L146` mention helpers R + `L148` hand-off Maëlle) — risque de surcharge cognitive pour CD au feu de l'action. Vérifié : les 2 paragraphes sont distincts, en gras pour le signal visuel, et restent dans la même slide (la note ne se déclenche qu'une fois). Digérable.
- **Callout-note dans `3-aller-plus-loin/index.qmd`** — risque de dégrader le statut « ressource consultable » en « page d'avertissement ». Vérifié : `appearance="minimal"` retire le visuel agressif, le ton reste informatif (« pistes pour aller plus loin »), et le contenu pédagogique en dessous est inchangé. La page reste utile.
- **Aucune régression détectée**.
