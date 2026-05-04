# Review participant·e débutant·e — 3ᵉ relecture, 2026-05-04

> Tutoriel RR 2026 — branche `claude/post-merge-doc-audit`, repo réel à `1168e70`
> (les 18 commits de fix `9b7a27e` → `9856186` annoncés dans le brief NE SONT PAS
> dans la branche review — voir note méthodo en bas). J'ai donc relu l'état tel
> qu'il existe sur disque, en cochant pour chaque fix annoncé s'il est bien
> présent ou non.
>
> Profil : R + RStudio depuis 2-3 ans, R Markdown occasionnel, jamais touché à
> Quarto en projet ni à Typst.

## Verdict général

Bonne nouvelle : sur les 6 fixes annoncés, **5 sont bien présents et résolvent
correctement** ce que j'avais flaggé en vague 2 (font-paths workaround dans le
modèle participant, shortcode pagebreak échappé sur la slide, helpers `brand.yml`
dans la correction Exo 1, logo SW dans `_brand.yml` Exo 1, mini-test Typst dans
`preparatifs.qmd`). Le 6ᵉ — `index.qmd:20` qui promet template partials et
extensions hors programme — **n'est pas corrigé** dans la branche que je relis.
Au-delà de ça, je trouve **2 nouveaux frottements** (le starter Exo 2 promet du
PDF où je vais voir du HTML ; le `brand-fallback.yml` dupliqué crée une asymétrie
silencieuse entre « j'arrive d'Exo 1 » et « je copie le fallback »). Globalement
le 16 juin, je m'en sors **largement**, à condition que P0 soit corrigé.

## Note méthodologique sur l'écart de commit

Le brief annonce que la review se fait sur `main` HEAD `9856186` avec 18 commits
de fix par-dessus l'état vague 2 (`34e8d0f`). Sur la branche review actuelle
(`claude/post-merge-doc-audit`, HEAD `513a05a`), `git log main` ne montre que
8 commits, le plus récent étant `1168e70` du 4 mai. **Aucun des SHA fix annoncés
(`9b7a27e`, `d55526a`, `b66900d`, `2fdf8fc`, `f3760e6`, `52d98e4`, `d3beea3`,
`9856186`) n'existe dans `git log --all`.** Ils ont été appliqués comme
modifications « live » sur le working tree (vérifié : tous les fichiers cités
contiennent bien le contenu de fix). Donc je relis le **contenu effectif des
fichiers**, pas une histoire git. Mes citations `file:line` sont fiables.

## P0 — bloquant pour le 16 juin

Aucun. Le P0 vague 2 (`font-paths` manquant dans le modèle participant) est
correctement résolu :

- `2-projets/index.qmd:93-99` : bloc `format.typst.font-paths: [.quarto/typst/fonts]`
  présent dans le modèle, avec commentaire « Workaround Quarto book… À retirer
  quand le bug upstream est fixé ».
- `exercises/02-projet-book/README.md:46-52` : idem.
- `exercises/02-projet-book/correction/_quarto.yml:19-25` : idem côté correction.

C'était mon seul vrai blocage il y a 12h. Bien joué.

## P1 — à corriger avant le 16 juin

### `index.qmd:20` promet toujours « template partials et extensions »

`index.qmd:20`

```
- Comment aller plus loin avec les template partials et les extensions ?
```

Le brief vague 3 indique « cf. consolidation review vague 2 (à vérifier sur
`index.qmd:20`) ». **Vérifié : non corrigé.** Le programme officiel (Bloc 1 +
Bloc 2) ne couvre toujours pas les template partials ni les extensions. La page
topic store `3-aller-plus-loin/index.qmd` qui en parle n'est ni dans la navbar
(`_quarto.yml:9-20`) ni linkée depuis `4-ressources.qmd` ni depuis `index.qmd`.

Si un·e participant·e me lit en préparation et arrive à la fin du Bloc 2 sans
avoir vu de partial ni d'extension, il·elle aura le sentiment d'une promesse
non tenue.

**Fix proposé** (rappelé de vague 2) : remplacer la 4ᵉ puce par « Comment aller
plus loin après ce tutoriel ? » avec lien vers `4-ressources.qmd`. Ou bien
ajouter `3-aller-plus-loin/index.qmd` à la navbar.

### Starter Exo 2 — promesse « 5 PDF » alors que je vais voir 5 HTML

`exercises/02-projet-book/starter/README.md:3-5` :

> « Ce dossier contient 5 fichiers `.qmd` mais **pas de `_quarto.yml`**. Sans
> fichier de configuration de projet, `quarto render` produit 5 PDF séparés
> (au lieu d'un livre). »

`exercises/02-projet-book/README.md:14-16` répète :

> « Sans configuration de projet, `quarto render starter/` produit 5 PDF
> orphelins : c'est le point de départ. »

Et `2-projets/index.qmd:53` (étape 1 du tableau) : « → 5 PDF séparés ».

**Mais** : aucun des 5 `.qmd` du starter n'a `format: typst` dans son YAML.
Vérifié : `01-anatomie.qmd`, `02-origines.qmd`, `conclusion.qmd`,
`annexe-donnees.qmd`, `index.qmd` n'ont **aucun front-matter YAML** du tout
(commencent directement par `# Anatomie`, `# Origines`, etc.). Donc si je tente
`quarto render starter/` AVANT l'étape 1, j'obtiens 5 **HTML**, pas 5 PDF.
L'étape 1 du tableau (créer `_quarto.yml` avec `format: typst`) est ce qui
DÉCLENCHE les 5 PDF. La phrase actuelle me fait croire que les 5 PDF sont l'état
de départ, alors qu'ils sont l'état d'arrivée de l'étape 1.

C'est de la confusion silencieuse — je vais peut-être ne jamais essayer
`quarto render` au stade « point de départ » et la pédagogie s'en sort, mais
le·la participant·e curieux·se qui essaie sera désorienté·e.

**Fix proposé** : reformuler le starter README en :

> « Ce dossier contient 5 fichiers `.qmd` mais pas de `_quarto.yml`. Sans
> configuration de projet, `quarto render starter/` produirait 5 fichiers
> séparés (par défaut HTML). L'étape 1 ajoute `format: typst` au `_quarto.yml`
> → vous obtenez 5 PDF séparés. L'étape 2 passe en `type: book` → un seul PDF
> assemblé. »

Et même ajustement sur `2-projets/index.qmd:53` + `exercises/02-projet-book/README.md:14-16`.

### Étape 4 Exo 1 : `correction/_logo-sw.svg` référencé sans avoir confirmé l'état du starter

`exercises/01-document-typst/README.md:28-31` étape 4 :

> « Créez un fichier `_brand.yml` à côté du `.qmd` (palette couleurs, une ou
> deux polices Google, et un logo SVG — cf. `correction/_logo-sw.svg`). »

**Bonne nouvelle** : le `_logo-sw.svg` est bien dans `correction/` (vérifié,
fix `f3760e6` livré). **Mais** : la formulation actuelle me dit « cf.
correction/_logo-sw.svg » — donc je dois aller chercher dans le dossier
correction pour récupérer le SVG. Or la consigne « ne les ouvrez pas avant le
tutoriel » de `preparatifs.qmd:30` me l'a interdit. Je suis coincé·e dans une
contradiction entre deux instructions.

À l'usage en atelier ce n'est pas grave (le·la formateur·trice le dira à l'oral),
mais en prépa solo en amont c'est ambigu.

**Fix proposé** : reformuler en « pour vous éviter de dessiner un SVG, vous
pouvez réutiliser celui qui est dans `correction/_logo-sw.svg` (c'est le seul
asset que vous regardez avant la fin de l'exercice) » — ou copier le SVG en
amont à un endroit neutre comme `exercises/01-document-typst/_logo-sw.svg`.

### Étape 4 Exo 1 — promesse helpers brand toujours optimiste vis-à-vis du starter

`exercises/01-document-typst/README.md:32-34` :

> « Pour propager la charte aux figures ggplot et tableaux gt, utilisez les
> helpers du package R `brand.yml` (`theme_brand_ggplot2()`, `theme_brand_gt()`)
> — voir `correction/rapport-starwars.qmd`. »

**Bonne nouvelle** : la promesse est désormais HONNÊTE sur le ton (« voir la
correction » au lieu de prétendre que ça marche tout seul), et la correction
contient bien `library(brand.yml)` + `read_brand_yml()` + `theme_brand_gt(brand)`
+ `theme_brand_ggplot2(brand)` (lignes 27-30, 66, 99 de la correction).

**Mais** : le·la débutant·e qui suit les 4 étapes dans le starter ne touchera
PAS aux helpers. Donc à la fin de l'Exo 1, son ggplot et son gt ne seront PAS
brandés en couleurs SW — il·elle verra `theme_minimal()` par défaut. C'est moins
violent que vague 2 où la promesse était écrite comme un automatisme, mais ça
laisse encore un écart visuel inexpliqué entre « ce que j'ai produit » et « la
correction ».

Pas un blocage. Mais la phrase pourrait devenir une étape 5 explicite (ou un
bonus) — « Étape 5 (bonus) : ouvrez `correction/rapport-starwars.qmd` et regardez
comment `theme_brand_gt()` / `theme_brand_ggplot2()` sont appelés. Recopiez ces
3 lignes dans votre version. »

### `preparatifs.qmd:18` — `prismatic` toujours dans la liste, jamais utilisé

`preparatifs.qmd:18` :

```r
pkg <- c("rmarkdown", "quarto", "dplyr", "ggplot2", "ggrepel", "gt", "knitr",
         "scales", "brand.yml", "prismatic")
```

Vérifié : `library(prismatic)` n'apparaît nulle part dans `exercises/`,
`1-quarto-typst/`, `2-projets/` (`grep -rn "library(prismatic)"`). `brand.yml`
est désormais utilisé dans la correction Exo 1 — bonne chose. `prismatic` reste
un package fantôme qui me coûte un download supplémentaire pour rien.

À retirer de la liste, ou ajouter une note « pour explorer hors-tutoriel ».

## P2 — nice-to-have

### Test Typst `preparatifs.qmd` — un edge case de troubleshooting absent

`preparatifs.qmd:43-59` est une excellente addition (fix `52d98e4`). Le
troubleshooting couvre 5 cas réalistes : Quarto < 1.9, fonts fallback, accents
cassés (locale), réseau, chiffres espacés gt. Très bien.

Petit manque : **le test n'utilise PAS `_brand.yml`**, donc il ne valide pas le
téléchargement des polices Google par Quarto. Or c'est précisément un point de
panique potentiel le matin du 16 juin (« j'avais validé chez moi, mais ici la
police Inter ne se télécharge pas »). Le « Plan B pas de réseau » répond à ce
risque APRÈS coup ; le test C3 ne le détecte pas EN AMONT.

**Fix proposé (P2 car mitigeable par le Plan B)** : soit ajouter un mini
`_brand.yml` à `00-test-install/` qui force un download Google de Inter, soit
ajouter une note dans `preparatifs.qmd:51` : « ce test n'utilise pas de brand —
si vous voulez aussi valider le téléchargement Google fonts, ajoutez `mainfont:
Inter` au YAML du test ».

### Duplication `_brand.yml` ↔ `_brand-fallback.yml` — divergence latente

`exercises/02-projet-book/_brand-fallback.yml`,
`exercises/02-projet-book/correction/_brand.yml`,
`exercises/01-document-typst/correction/_brand.yml` sont **strictement
identiques** (vérifié : 27 lignes, mêmes couleurs SW, mêmes fonts Google, même
bloc `logo: { images: { sw-star: { path: _logo-sw.svg } } }`).

C'est rassurant côté pédagogie (pas de surprise visuelle entre Exo 1 et Exo 2).
Mais ça veut dire 3 fichiers à maintenir en sync. Si l'un d'eux dérive
(palette ajustée, font changée), l'expérience devient incohérente. Suggestion :
remplacer 2 des 3 par des liens symboliques OU documenter dans `.claude/` que
ces 3 fichiers doivent rester en sync. Pas critique pour le 16 juin.

### Slide Bloc 2 wrap-up — 3 slides terminales bien dosées

`2-projets/2-projets.qmd:142-180` (« Ce que vous savez faire maintenant », « Et
maintenant ? », « Merci ! Questions ? »).

C'est nouveau (fix `d3beea3` annoncé). Refermement narratif convaincant :

- La slide 142 reprend les 4 promesses miroir des 4 questions de `index.qmd:17-20`
  (le « rappel mémoriel » mentionné dans les notes presenter à L154 fonctionne).
- La slide 157 « Cette semaine — ouvrez un de vos `.qmd` existants, ajoutez
  `format: typst` » me donne UN action item concret, pas une todo list intimidante.
  Très bien.
- La slide 169 Q&A est minimaliste, OK.

**Petite remarque P2** : la slide 142 « Ce que vous savez faire maintenant »
liste 4 bullets dont la 4ᵉ : « Savoir où chercher pour aller plus loin (partials,
formats communautaires) ». Or le programme ne m'a montré ni partials ni formats
communautaires en main. Je sais où chercher (la page Ressources), mais je ne
« sais » rien faire — c'est une demi-promesse. Reformulation possible : « Savoir
où chercher pour explorer partials et formats communautaires ».

### `index.qmd:9` zone date/lieu en clair, mais lien Préparatifs un peu enterré

Pour quelqu'un qui arrive sur le site une semaine avant : le bloc « Se préparer »
(`index.qmd:22-24`) avec le lien vers `preparatifs.qmd` est mis dans un
paragraphe entre « À propos » et « Programme ». Ce serait peut-être plus
visible en callout-tip/warning au-dessus. Mineur.

### Vocabulaire « partials » toujours non-défini en pépite Bloc 2

`2-projets/2-projets.qmd:127` :

> « **Template partials** — Le fichier `typst-show.typ` (et son
> `typst-template.typ` côté template par défaut) contrôle la génération du
> `.typ`. »

Mêmes findings que vague 2. La pépite est volontairement légère (« on ne fait
que mentionner »), donc OK si je passe vite — mais en révisant le PDF le soir
sans les notes presenter, je vais me demander ce qu'est un « partial ». La page
Ressources L104-137 est très bien, mais je ne sais pas que c'est là. Une mini
définition entre parenthèses sur la slide pépite (« partials = fragments de
template Pandoc qu'on remplace pour customiser le `.typ` ») coûterait peu.

### `tbl-cap` toujours absent sur les chunks `tbl-*` de l'Exo 2

`exercises/02-projet-book/starter/01-anatomie.qmd:18`,
`02-origines.qmd:16` et idem corrections.

Détail de qualité, déjà noté en vague 2. Impact = 0 en pratique (le bonus B1
référence `@fig-anatomie-mass`, jamais `@tbl-`). Pas urgent.

## Forces — ce qui me rassure

- **`preparatifs.qmd:43-69`** : la section « Test de la chaîne Typst » + « Plan B
  pas de réseau » est exactement ce qu'il me fallait pour dérisquer mon install.
  Le mini `00-test-install/test-install.qmd` est vraiment minimal (3 lignes
  starwars + 1 ggplot, accents dans le titre) et le troubleshooting 5 cas anticipe
  les pannes que j'aurais rencontrées en silence. Très gros progrès depuis vague 2.
- **`exercises/02-projet-book/README.md:46-52`** : workaround `font-paths` documenté
  AVEC commentaire « À retirer quand le bug upstream est fixé ». C'est ce qui me
  manquait absolument en vague 2.
- **`exercises/01-document-typst/correction/rapport-starwars.qmd:27-30`** : le bloc
  `library(brand.yml) + brand <- read_brand_yml()` avec commentaire est une excellente
  reference pour ceux·celles qui veulent reproduire chez eux. Court, lisible.
- **`2-projets/2-projets.qmd:105`** : le shortcode est bien échappé en
  `{{</* pagebreak */>}}`. Si je révise les slides en PDF, je verrai le terme.
- **`exercises/02-projet-book/_brand-fallback.yml`** : identique à
  `correction/_brand.yml`, donc le filet de sécurité « pas de brand récupéré du
  Bloc 1 » fonctionne — je peux démarrer Exo 2 même sans avoir fini Exo 1.
- **`2-projets/2-projets.qmd:142-180`** : wrap-up 3 slides, refermement narratif
  qui boucle sur les 4 promesses de `index.qmd`. Je repars avec une action concrète
  (« cette semaine, ouvrez un `.qmd` existant »).
- **Cohérence Exo 1 → Exo 2** : si je suis Exo 1 jusqu'au bout (correction comme
  référence), mon `_brand.yml` est strictement identique à celui demandé par
  Exo 2 étape 3 (vérifié byte-à-byte). Donc « copiez `_brand.yml` à la racine »
  fonctionne sans surprise — y compris le bloc `logo:`.
- **README Exo 2 ligne 65-70** : le callout `gt` « 1 7 5 » avec workaround
  `opt_table_font(font = "Inter")` me sauve d'au moins 5 minutes de panique
  silencieuse à l'étape 3.

## Évolution depuis la review précédente

### Améliorations très visibles pour moi

| # | Vague 2 | Vague 3 | État |
|---|---|---|---|
| P0 | Modèle `_quarto.yml` participant sans `font-paths` workaround | Présent dans `2-projets/index.qmd:93-99` + `exercises/02-projet-book/README.md:46-52` avec commentaire explicite | ✅ résolu |
| P1 | Shortcode `{{< pagebreak >}}` interprété sur slide B2 | Échappé en `{{</* pagebreak */>}}` à `2-projets/2-projets.qmd:105` | ✅ résolu |
| P1 | Promesse « brander ggplot/gt » non tenue par le starter ni la correction | Helpers `theme_brand_gt()` / `theme_brand_ggplot2()` désormais dans la correction Exo 1 (lignes 27-30, 66, 99) ; promesse README étape 4 reformulée en « voir correction » | ✅ résolu (ton honnête) |
| P1 | Étape 3 Bloc 2 demande logo SW absent du `_brand.yml` Exo 1 | `_logo-sw.svg` ajouté à `correction/` Exo 1 + bloc `logo: { sw-star }` dans `_brand.yml` ET `_brand-offline.yml` Exo 1 (cohérent avec Exo 2) | ✅ résolu |
| P1 | `preparatifs.qmd` ne teste pas le rendu Typst | Section « Test de la chaîne Typst » + `00-test-install/test-install.qmd` + 5 cas troubleshooting | ✅ résolu |
| P1 | `index.qmd:20` promet template partials et extensions hors programme | Identique au texte vague 2 | ❌ non résolu |
| P2 | Lorem ipsum préface | Préface réécrite en français Star Wars (vérifié `index.qmd` Exo 2 starter) | ✅ résolu (annoncé `d55526a`) |

### Ce qui était déjà bon et qui le reste

- Vouvoiement uniforme.
- Vocabulaire FR (« charte » au lieu de « brand » dans la prose).
- Étapes 2a/2b séparées dans le tableau, modèle `_quarto.yml` complet.
- Star Wars / Mon Mothma comme fil rouge.
- Iframe slide deck sur les pages de bloc.
- Countdown `{{< countdown 15:00 >}}`.
- Note bug `gt` côté participant en callout collapse.
- Autonomie Exo 2 vis-à-vis Exo 1 explicitement annoncée.

### Findings nouveaux non vus en vague 2

1. **Starter Exo 2 promet « 5 PDF » alors que `quarto render` au stade initial
   produit 5 HTML** (pas de `format:` dans les `.qmd`). Confusion silencieuse,
   probablement non bloquante en atelier mais inexacte en lecture solo.
2. **Étape 4 Exo 1 demande de regarder dans `correction/_logo-sw.svg`** — entre
   en contradiction avec « ne pas ouvrir `correction/` » de `preparatifs.qmd:30`.
3. **`preparatifs.qmd` test Typst ne valide PAS le téléchargement Google fonts**
   (le mini-test n'utilise pas `_brand.yml`). C'est précisément le point de
   panique le matin du 16 juin si firewall.
4. **Slide 142 « Ce que vous savez faire » liste « partials et formats
   communautaires »** — demi-promesse (je sais où chercher, je ne « sais » pas
   faire).

Si seul P1 #1 (`index.qmd:20`) et le starter Exo 2 sont corrigés d'ici le 16 juin,
je m'en sors très bien. Le reste tient du polish.
