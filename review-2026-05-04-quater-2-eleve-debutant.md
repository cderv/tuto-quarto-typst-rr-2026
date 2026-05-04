# Review participant·e débutant·e — 4ᵉ relecture, 2026-05-04

> Repo `/home/user/cderv-tuto-quarto-typst-rr-2026`, branche
> `claude/post-merge-doc-audit`, HEAD `39f9ff5`.
> Profil : R + RStudio depuis 2-3 ans, R Markdown occasionnel, jamais touché
> à Quarto en projet ni à Typst. Lecture du matériel en condition réelle de
> participant·e — pas de SO, pas de chat, juste mes notes et le repo.

## Verdict général

Mes 3 P1 sont effectivement résolus, et bien résolus : la promesse Q3 sur le
pivot Bloc 1 → Bloc 2 sonne naturelle, le starter Exo 2 explique honnêtement le
basculement HTML par défaut → PDF via `format: typst` → livre via `type: book`,
et l'étape 4 Exo 1 sur le logo SVG ne me met plus dans une contradiction
silencieuse. Les fixes de polish (annotation slide 142, refonte slide A à
5 bullets) tiennent leurs promesses. **0 P0, 0 P1 nouveau.** Je trouve un seul
P2 nouveau (mineur, vocabulaire de la slide d'enrichissement) et je
re-soulève 1 P2 que j'avais déjà vu en vague 3 et qui n'est pas dans le scope
des fixes livrés. Côté audit anti-régression : aucun nouveau frottement
introduit par les sweeps des 3 commits. Je m'en sors le 16 juin sans réserve.

## P0 — bloquant pour le 16 juin

Aucun.

## P1 — à corriger avant le 16 juin

Aucun nouveau finding.

## P2 — nice-to-have

### Slide 142 wrap-up — l'annotation marche, mais le terme « pistes » mérite un mot

`2-projets/2-projets.qmd:149`

> « Savoir où chercher pour aller plus loin (partials, formats communautaires
> — couverts en pistes, pas en séance) »

L'annotation entre parenthèses désamorce **complètement** la demi-promesse que
j'avais flaggée en vague 3 (P2 #2). Comme participant·e, je comprends sans
ambiguïté que ces sujets ne sont pas une compétence acquise. Bon fix.

Petit reste : « **couverts en pistes** » est un peu sec à l'écrit. À l'oral CD
peut développer (« je vous donne où chercher »), mais si je révise les slides
le soir sans les notes presenter, « couverts en pistes » me laisse imaginer une
section dédiée que je n'ai pas vue. Reformulation possible : « pistes pour
explorer après le tutoriel, page Ressources ». Très mineur.

### `preparatifs.qmd:18` — `prismatic` toujours fantôme dans la liste packages

Déjà flaggé en vague 3 (P1 #4 dans mon rapport, hors brief des 3 P1 confirmés).
Non traité par les commits livrés — ce qui est normal puisque tu n'as gardé que
3 P1 sur les 4 du rapport vague 3. Je le re-mentionne **sans le re-flagger**
comme nouveau : `prismatic` n'apparaît dans aucun fichier exo / slide / page
web. Coût minuscule (un download de plus), j'en parle pour mémoire.

```bash
grep -rn "library(prismatic)\|prismatic::" \
  exercises/ 1-quarto-typst/ 2-projets/ 3-aller-plus-loin/ 4-ressources.qmd
# → 0 résultat
```

## Forces — ce qui me rassure

### Q3 reformulée — le pivot Bloc 1 → Bloc 2 est naturel

`index.qmd:17-19`

```
- Comment remplacer LaTeX par Typst pour des PDF sans frictions ?
- Comment personnaliser vos documents avec `_brand.yml` ?
- Comment passer d'un document isolé à un projet Quarto multi-chapitres
  avec `type: book` ?
```

Les 3 questions cartographient les 2 blocs sans laisser d'orphelin. Q1+Q2
couvrent Bloc 1, Q3 couvre Bloc 2 et le mot **« multi-chapitres »** rend le
saut de scope intuitif (« j'avais 1 doc, je vais avoir N chapitres »). Le
mot-clé `type: book` est cité explicitement, donc quand je vois les slides
Bloc 2 avec `type: book`, je reconnais. La promesse a aussi disparu sur les
partials/extensions — donc plus de promesse non tenue à la fin.

### Étape 4 Exo 1 — la contradiction est levée

`exercises/01-document-typst/README.md:28-35`

> « Créez un fichier `_brand.yml` à côté du `.qmd` (palette couleurs, une ou
> deux polices Google, et un logo SVG si vous en avez un sous la main).
> Re-rendez : couleurs, typographies et logo sont appliqués automatiquement
> à la mise en page PDF. Pour propager la charte aux figures ggplot et
> tableaux gt, utilisez les helpers du package R `brand.yml`
> (`theme_brand_ggplot2()`, `theme_brand_gt()`). La correction
> (`correction/`) fournit un exemple complet avec un logo Star Wars. »

« Si vous en avez un sous la main » fait du logo une option facultative. La
référence à la correction est désormais en fin d'étape comme **exemple
complet**, pas comme une dépendance dure pour réussir l'étape. Plus de tension
avec la consigne « ne pas ouvrir correction/ » de `preparatifs.qmd:30` :
l'étape se résout sans ouvrir la correction.

J'aime aussi qu'on évite de mentir : si je suis l'étape sans logo, je vais
voir une charte couleur/typo qui marche, pas un trou visuel inexpliqué.

### Pivot HTML → PDF → book — clair des deux côtés

`exercises/02-projet-book/starter/README.md:3-5`

> « Sans fichier de configuration de projet, `quarto render` produit 5 HTML
> séparés (format par défaut de Quarto, au lieu d'un livre PDF). »

`exercises/02-projet-book/README.md:14-17`

> « Sans configuration de projet, `quarto render starter/` produit 5 HTML
> séparés (format par défaut de Quarto) : c'est le point de départ. La
> première étape ajoute `_quarto.yml` avec `format: typst` pour basculer
> en PDF. »

Les 3 états (5 HTML par défaut → 5 PDF avec `format: typst` → 1 PDF avec
`type: book`) sont distincts et chronologiques. La phrase pivot « la première
étape ajoute… pour basculer en PDF » rend le tableau d'étapes attendu. Quand
je tape `quarto render starter/` en arrivant et que je vois 5 HTML (le starter
n'a pas de `format:` dans ses chapitres, vérifié), je ne suis pas surpris·e :
le README me l'a annoncé. Belle correction.

Petit bonus : « format par défaut de Quarto » entre parenthèses définit le
mécanisme sans jargon — un·e débutant·e R Markdown sait ce qu'est un HTML par
défaut.

### Slide A wrap-up à 5 bullets — match exact avec les promesses

`2-projets/2-projets.qmd:144-150`

```
- Produire un PDF pro avec `format: typst`, sans LaTeX
- Inspecter le pipeline `.qmd` → `.typ` → `.pdf` via `keep-typ: true`
- Personnaliser couleurs, polices et logo via `_brand.yml`
- Assembler plusieurs `.qmd` en livre avec `type: book` (orange-book auto)
- Savoir où chercher pour aller plus loin (partials, formats communautaires
  — couverts en pistes, pas en séance)
```

Cross-check vs `1-quarto-typst/index.qmd:26-29` (promesses Bloc 1) et
`2-projets/index.qmd:26-28` (promesses Bloc 2) :

- Bullet 1 ↔ Bloc 1 ligne 26 (« Produire un PDF pro avec `format: typst`… »)
  — match exact.
- Bullet 2 ↔ Bloc 1 ligne 28 (« Inspecter le pipeline `.qmd` → `.typ` →
  `.pdf` via `keep-typ: true` ») — match exact.
- Bullet 3 ↔ Bloc 1 ligne 29 (« Personnaliser couleurs, polices et logo via
  un seul fichier `_brand.yml` ») — match.
- Bullet 4 ↔ Bloc 2 lignes 27-28 (« Assembler plusieurs `.qmd` en un livre
  avec `type: book` … orange-book ») — match.
- Bullet 5 ↔ explicitement annoncé comme post-tutoriel via la page
  topic-store `3-aller-plus-loin/index.qmd:13-15`.

Le miroir est propre. L'inclusion du pipeline `keep-typ` (qui était une vraie
compétence du Bloc 1, pas juste un détail) montre que je repars avec un
vocabulaire opérationnel, pas juste « j'ai vu une démo ».

### Audit anti-régression — clean

J'ai relu chaque fichier touché par les 3 commits :

- `index.qmd` : 3 questions cohérentes, pas d'orphelin. Programme à 2 blocs
  matche les questions.
- `1-quarto-typst/index.qmd`, `1-quarto-typst.qmd` : pas touchés au-delà des
  fixes anglicismes vague 3, lecture fluide.
- `2-projets/index.qmd:53-56` : tableau étapes 1 / 2a / 2b / 3 inchangé
  côté logique, cohérent avec `exercises/02-projet-book/README.md:23-26`.
  La phrase « 5 PDF séparés (un par fichier) » dans la colonne « Vous devriez
  voir » de l'étape 1 reste cohérente : c'est bien l'état **après** étape 1
  (`format: typst` ajouté), pas l'état initial du starter.
- `2-projets/2-projets.qmd` : slide 142 et slide « Et maintenant ? » alignées
  sur les 3 questions de `index.qmd`. Lien `4-ressources.qmd` en place.
- `4-ressources.qmd` et `3-aller-plus-loin/index.qmd` : inchangés, toujours
  utiles comme rampes de sortie.
- `preparatifs.qmd` : section test + Plan B + troubleshooting toujours là,
  reformulations FR vague 3 ne cassent rien.
- `exercises/01-document-typst/README.md` : étape 4 reformulée, le reste
  cohérent.
- `exercises/02-projet-book/README.md` : phrase pivot vers « basculer en PDF »
  ajoutée à la mise en place, le tableau d'étapes reste navigable, le bug
  `gt` toujours documenté avec workaround.

Aucun lien cassé détecté. Les SHA `438aafd`, `625c03e`, `39f9ff5` ne laissent
pas de trace de fix bâclé.

## Évolution depuis la review précédente

### Mes 3 P1 vague 3 — résolus

| # | Vague 3 (mon flag) | Vague 4 (état actuel) |
|---|---|---|
| P1 #1 | `index.qmd:20` promet « template partials et extensions » hors programme | Q4 retirée, 3 questions mappent 1:1 sur les 2 blocs, Q3 reformulée explicite le pivot. **Résolu sans demi-mesure.** |
| P1 #2 | « 5 PDF » faux comme état initial du starter | `starter/README.md:3-5` + `02-projet-book/README.md:14-17` reformulés en HTML par défaut + phrase pivot vers `format: typst`. **Résolu**, le pivot pédagogique HTML → PDF → book est désormais explicite. |
| P1 #3 | Contradiction `correction/_logo-sw.svg` ↔ « ne pas ouvrir correction/ » | Étape 4 reformulée : logo « si vous en avez un sous la main », correction citée comme exemple. **Résolu**, plus de double-contrainte. |

### Mes 2 P2 vague 3 — état

| # | Vague 3 | Vague 4 |
|---|---|---|
| P2 #1 | Test C3 ne valide pas Google fonts | Non traité (annoncé hors scope sweep). Ack — c'est un changement de feature, pas un fix. Plan B documenté absorbe le risque. |
| P2 #2 | Slide 142 demi-promesse partials/formats | Annotation « (couverts en pistes, pas en séance) » ajoutée. **Résolu** sur le fond ; juste un mini-lift de wording possible (cf. P2 ci-dessus). |

### Pas de régression introduite par les commits livrés

- `438aafd` (anglicismes FR) : je n'ai pas reflaggé de term ambigu dans ma
  passe, vocabulaire toujours accessible (« charte », « rendre »,
  « références croisées »).
- `625c03e` (mes 3 P1) : voir tableau ci-dessus, propre.
- `39f9ff5` (sweep P2) : la slide 142 et la slide A à 5 bullets s'enchaînent
  sans incohérence, le wrap-up tient.

### Findings nouveaux non vus en vague 3

Un seul : la phrase « couverts en pistes » de la slide 142 est compréhensible
en présence du formateur·trice mais un peu sèche en lecture solo (P2 ci-dessus).

Si seul ce P2 reste, je m'en sors le 16 juin sans réserve. Tout ce qui me
faisait hésiter en vague 3 est levé.
