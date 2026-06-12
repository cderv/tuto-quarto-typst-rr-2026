# Review pédagogue — Démo Our turn Exo 1 (couleur qui ne « prend » pas)

> Date : 2026-06-12 · Reviewer : pédagogue (design andragogique)
> Périmètre : plan `2026-06-12-demo-our-turn-couleurs.md` + `1-quarto-typst/{1-quarto-typst.qmd, index.qmd, boussole.qmd}` + `exercises/01-document-typst/starter/rapport-starwars.qmd`.
> Lecture faite : slide « Faisons ensemble ! » (`1-quarto-typst.qmd:275-311`), section Our turn (`index.qmd:32-39`), étape 3 (`index.qmd:62`), boussole (`boussole.qmd:27-37`), starter complet.

## Verdict général

Le diagnostic du plan est juste et le problème est **réel et pédagogiquement coûteux** : une démo Our turn dont la promesse (« titres et liens colorés ») ne produit **aucun effet visible** est le pire scénario possible — l'animateur édite du YAML au tableau, re-rend, et… rien. Cela casse la boucle « j'agis → je vois le résultat » qui est tout l'intérêt d'un Our turn live, et fragilise la crédibilité de l'outil juste avant de lâcher les participants en autonomie. Le choix de CD (§4 option 1 : `background` + `foreground`) est la bonne base mais **insuffisamment visible** pour une projection. Ma recommandation tranche les questions ouvertes vers une démo qui colore les titres, en réajustant l'arc narratif plutôt qu'en le subissant. C'est un correctif à appliquer **avant le 16 juin** : il touche le moment charnière du Bloc 1.

## 🔴 P0 — bloquant pour le 16 juin

### P0-1 — La promesse de la démo Our turn est fausse et invisible (`1-quarto-typst.qmd:283`, `index.qmd:37`)

Le snippet `palette: imperial-red` + `primary: imperial-red` ne colore que les liens, et le starter n'a **aucun lien** (`rapport-starwars.qmd` vérifié : prose `dplyr::starwars` en backticks l.21, conclusion l.78 sans lien). Résultat live : zéro changement à l'écran. C'est exactement le moment où l'animateur doit prouver « une ligne de YAML = effet visible ». **À corriger avant tout autre arbitrage** — sans effet visible, la démo n'a pas lieu d'être.

Décision recommandée ci-dessous (Q1/Q5) : remplacer le snippet par un `_brand.yml` qui produit un effet **franc en projection**.

## Réponses aux questions ouvertes du §6

### Q1 — Faut-il colorer les titres dans la démo ? → **OUI, colorer les titres.** Réajuster l'arc, ne pas le subir.

C'est l'arbitrage central. Mon analyse de design pédagogique :

**L'argument « visibilité » l'emporte largement sur l'argument « pureté de l'arc ».** Un Our turn a une seule fonction : démontrer la boucle action→effet de façon **incontestable depuis le fond de la salle**. Le fond crème seul (`#F5F0E1`, cf. Q5) ne remplit pas ce contrat. Des titres qui passent au rouge imperial, si.

**L'arc « titres noirs Bloc 1 → colorés Bloc 2 » n'est pas un acquis pédagogique, c'est une contrainte qu'on s'est imposée.** Rien dans l'apprentissage ne dépend du fait que les titres restent noirs au Bloc 1. Au contraire : montrer `typography.headings.color` en démo **enrichit** la palette de leviers que le participant connaît, sans rien retirer au Bloc 2 (qui apporte le *livre*, les polices locales, le logo finement placé, la pérennité — bien plus que « titres colorés »). L'arc réel du workshop est `.qmd → PDF pro → livre → personnalisé/pérennisé` ; « quand les titres deviennent rouges » n'en est pas un jalon structurant.

**Recommandation concrète** — démo Our turn = `_brand.yml` qui combine fond crème + titres colorés :

```yaml
color:
  palette:
    imperial-red: "#BC1E22"
  background: "#F5F0E1"   # fond crème (charte)
  foreground: "#0B0B0F"   # corps sombre
typography:
  headings:
    color: imperial-red   # titres rouges — TRÈS visible en projection
```

Effet à l'écran : fond crème + titres rouges + corps sombre = un PDF qui « prend la charte » de façon spectaculaire, en ~4 lignes utiles. La boucle action→effet est sauvée.

**Wording (reprend Q4)** : remplacer « → titres et liens colorés » (`1-quarto-typst.qmd:283`, `index.qmd:37`) par « → **le document prend les couleurs de la charte : fond crème, titres en rouge imperial** ». Précis, vrai, vérifiable.

**Conséquence sur l'étape 3 (`index.qmd:62`)** : si la démo colore les titres, la note « Les titres restent en `foreground` noir… la couleur `primary` sur les titres arrivera au Bloc 2 » devient incohérente. Deux options propres :
- (a) **Reformuler l'étape 3** pour que la charte complète colore aussi les titres via `headings.color` — c'est le plus cohérent : la cible finale est *plus* aboutie que la démo, pas différente sur ce point.
- (b) Retirer la mention « arrivera au Bloc 2 » et présenter `headings.color` comme un levier déjà disponible dont le réglage fin (police Star Jedi) se fait à l'étape 4.

Je recommande **(a)** : la progression devient « démo = titres rouges (couleur) → exo étape 4 = titres en Star Jedi (police + couleur) ». L'étape 4 reste un vrai ajout (la police décorative), donc Your turn n'est pas dévalué.

### Q2 — Où poser `primary` + les liens ? → **Retirer `primary` de la démo. Le déplacer dans la charte complète (étape 3 de l'exo), pas dans la boussole.**

Le `primary` est le coupable de l'effet-zéro. Le maintenir dans la démo « minimale » est un piège : il donne l'illusion qu'on fait quelque chose alors qu'il ne colore rien.

- **Démo Our turn** : `background` + `foreground` + `headings.color` (cf. Q1). **Pas de `primary`** — il n'a rien à colorer tant qu'il n'y a pas de lien, et il alourdit le snippet sans gain visuel.
- **Étape 3 (charte complète, `index.qmd:62`)** : c'est là que `primary` a sa place, **à condition d'ajouter au moins un lien au starter** (cf. Q3). Sinon, retirer la promesse « Liens colorés en imperial-red » de la colonne « Vous devriez voir » — une promesse fausse dans la grille d'auto-correction casse la **boucle d'autonomie** (le participant cherche un effet qui n'existe pas, doute de son YAML, appelle Maëlle pour rien).
- **Boussole (`boussole.qmd:31`)** : ne rien y ajouter. La boussole liste les étapes en télégraphique (« couleurs + police Google + logo ») ; c'est le bon niveau, n'y injectez pas de détail sur `primary`/liens — elle doit rester un panneau de pilotage léger en second écran.

**Sur le « réflexe de base » (étape 1 seule d'abord, `index.qmd:54`)** : intact. La démo Our turn reste un avant-goût ; l'instruction « commencez par l'étape 1 seule » porte sur l'**exercice** que le participant fait lui-même, pas sur ce que l'animateur montre. Aucun conflit. Bien garder cette consigne — c'est un excellent scaffolding (on ancre `format: typst` une ligne avant d'empiler le style).

### Q3 — Synchroniser la correction avec des liens ? → **OUI, ajouter 1 lien au starter ET à la correction.**

C'est la condition pour que `primary` (étape 3) soit honnête. Recommandation : **un seul lien suffit** (`dplyr::starwars` → la page de référence tidyverse, `starter:21`). N'en mettez pas plusieurs — un seul lien rouge bien placé suffit à prouver l'effet `primary`, et garde le doc sobre.

Charge de cohérence à ne pas oublier (le plan le note bien, §4.2) : starter + correction + `pkg/inst/` via `just pkg-sync`. **Important côté pédagogie** : si vous ajoutez le lien au starter mais pas à la correction, l'auto-correction diverge. Tout-ou-rien sur les trois copies.

Alternative si vous ne voulez pas toucher au starter avant le 16 : **retirer simplement « Liens colorés en imperial-red »** de l'étape 3 et ne pas mentionner `primary` du tout au Bloc 1. C'est moins riche mais cohérent à coût zéro. Mon ordre de préférence : ajouter le lien (meilleur), sinon retirer la promesse.

### Q4 — Wording « le document prend les couleurs de la charte » → précis si on colore les titres.

Avec la reco Q1, le wording exact recommandé : « → **le document prend les couleurs de la charte : fond crème, titres en rouge imperial** ». Il décrit deux effets concrets et observables, ce qui en fait aussi une **mini grille d'auto-vérification** pour le participant. Éviter le générique « prend les couleurs de la charte » seul — un débutant ne saurait pas si « ça a marché ».

### Q5 — Le fond crème est-il assez visible en projection ? → **NON, insuffisant seul.** D'où la reco Q1.

`#F5F0E1` est un blanc cassé. En projection (vidéoprojecteur, lumière de salle, compression), la différence avec le blanc du PDF brut sera **quasi imperceptible depuis le milieu/fond de salle**. Un fond crème comme *seul* effet d'un Our turn est un risque réel d'« effet-zéro perçu » — presque aussi mauvais que le bug `primary` d'origine. C'est précisément pourquoi je tranche Q1 vers les titres colorés : le rouge imperial sur les titres est l'élément **franchement visible** qui porte la démonstration. Le crème devient alors le détail confirmant « c'est bien la charte », pas la preuve principale.

## 🟠 P1 — à corriger avant le 16 juin

### P1-1 — Notes presenter de la démo à mettre à jour pour Maëlle et CD (`1-quarto-typst.qmd:295-311`)

Le snippet « à coller en étape 2 » (`l.303-308`) est l'ancien `primary`-only. Si la démo change (Q1), ce snippet doit changer **en parallèle** — sinon CD colle le mauvais YAML au tableau et reproduit l'effet-zéro en live. C'est le risque le plus opérationnel.

De plus, ajouter une ligne **piège anticipé** dans les notes, utile à Maëlle en salle : « Si un·e participant·e dit "ma couleur ne change rien" → vérifier qu'il/elle n'a posé que `primary` : `primary` ne colore que les liens. Pour voir un effet sur les titres, c'est `typography.headings.color` ; sur le fond, `background`. » Cela transforme le bug d'aujourd'hui en **outil de dépannage** pour la co-animatrice qui passe dans les rangs.

### P1-2 — La transition Our turn → Your turn doit refléter le nouveau périmètre (`1-quarto-typst.qmd:310`)

La note de transition dit « 4 couleurs au lieu d'1, rôles `foreground` + `background` ». Si la démo montre déjà `background`+`foreground`+`headings.color`, ajuster : la démo a montré *background + foreground + titres colorés (1 couleur)*, Your turn ajoute *palette complète + `primary`/liens + polices Google + Star Jedi + logo*. Garder une vraie marche à gravir côté Your turn (polices + logo + palette = largement de quoi remplir 12 min) ; bien le réénoncer pour que le participant sente la progression, pas la répétition.

## 🟡 P2 — nice-to-have

### P2-1 — Étape 3, alléger la cellule « Action » (`index.qmd:62`)

Indépendant de ce fix, mais visible en relisant : la cellule Action de l'étape 3 est **dense** (palette + 3 rôles + police Google en 2 temps + logo imbriqué, le tout en une phrase avec parenthèses). Charge cognitive élevée pour une cellule de tableau. Si vous y touchez pour Q1/Q3, profitez-en pour la scinder visuellement (puces). Non bloquant.

### P2-2 — Cohérence du compteur boussole vs énoncé

`boussole.qmd:15` = 12:00, `index.qmd:56` = 12 min, `1-quarto-typst.qmd:322` = 12 min. Cohérent — RAS, vérifié au passage.

## ✅ Forces pédagogiques confirmées

- **Rythme M/O/Y respecté** dans le Bloc 1 : My turn (objectifs `index.qmd:24-30`), Our turn (callout-tip « Faisons ensemble ! » `1-quarto-typst.qmd:277`), Your turn (callout-warning « À vous ! » + countdown `l.315-324`). Conventions couleurs respectées.
- **Scaffolding exemplaire** : `echo: false` dans le starter (`rapport-starwars.qmd:6`) maintient la charge sur Quarto+Typst, pas sur R. Le starter est un vrai rapport plausible, pas un jouet.
- **Boucle d'autonomie** bien pensée : « Si vous bloquez après ~5 min » (`index.qmd:101-107`) + colonne « Vous devriez voir » = auto-correction sans appeler l'animateur. **C'est justement cette qualité qui rend P0-1 grave** : une ligne fausse dans « Vous devriez voir » sabote un dispositif par ailleurs excellent.
- **Cliffhanger Bloc 1 → Bloc 2 déjà planté** dans le starter : la conclusion (`rapport-starwars.qmd:78`) annonce « il faudrait étendre ce rapport en livre — c'est l'objet du Bloc 2 ». Transition Exo 1 → Exo 2 préparée matériellement. Très bon.
- **Méta-cohérence** bien exploitée dans les notes (`1-quarto-typst.qmd:270`) : « ce PDF que vous tenez vient d'un `_brand.yml` identique à celui que vous allez écrire ».
- **Distinction réflexe de base / style** (`index.qmd:54`) : excellent dosage de charge cognitive (une ligne YAML d'abord, style ensuite).

## 📝 Évolution depuis la review précédente

Pas de review pédagogue antérieure portant sur ce point précis dans le périmètre lu ; cette review est ciblée sur le plan `2026-06-12-demo-our-turn-couleurs.md`. Ce qui est **déjà bon et à préserver** : tout le dispositif d'autonomie (boussole, « si vous bloquez », « vous devriez voir »), le cliffhanger Bloc 2, le réflexe de base. Ce qui s'est **dégradé / a été révélé** : le test terrain de Maëlle a mis au jour un défaut latent (promesse Our turn fausse) — c'est une régression de *contenu* détectée par l'usage, pas par les supports. Le plan la traite correctement ; ma seule divergence avec la décision §4 de CD est sur la **visibilité** : `background`+`foreground` seuls (option 1) ne suffisent pas en projection — d'où ma reco d'ajouter `headings.color` et de réajuster l'arc plutôt que de le protéger.

---

**Comptage : 1 P0 · 2 P1 · 2 P2.** Arbitrages : Q1 → colorer les titres (réajuster l'arc) ; Q2 → `primary` hors démo, dans l'exo ; Q3 → ajouter 1 lien (les 3 copies) ; Q4 → wording explicite à deux effets ; Q5 → crème insuffisant seul, d'où les titres.
