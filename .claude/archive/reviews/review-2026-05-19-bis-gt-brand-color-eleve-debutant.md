# Review débutante — Bonus 4 brand couleur (gt + ggplot) — 2026-05-19-bis

Profil : R intermédiaire (dplyr/ggplot2 OK), gt connu à niveau "j'ai déjà fait un tableau",
Quarto = découverte, `brand.yml` jamais manipulé côté R.

---

## Verdict général

Le Bonus 4 est techniquement propre et le callout "Piège silencieux" est une vraie valeur
ajoutée. Mais tel qu'il se présente à une débutante à 10h28 (12 min de base + B1 + B2 déjà
consommés), c'est une marche haute : 3 étapes, ~50 lignes de code à comprendre, une fonction
nouvelle (`brand_color_pluck`), une API `scale_color_manual` que je connais à peine. Le problème
n'est pas la difficulté intrinsèque — c'est l'absence de résultat visuel promis et la mécanique
des noms "Autres" / "Cas remarquables" qui suppose un lien avec le code `mutate()` que je dois
retrouver moi-même.

---

## P0 — bloquant pour le 16 juin

Aucun P0 identifié sur les nouveautés. Les corrections précédentes (tiret → underscore
`sw_yellow` documenté dans le callout, `opt_table_font` pour le bug « 1 7 5 ») sont en place et
fonctionnelles.

---

## P1 — à corriger avant le 16 juin

### 1. Le Bonus 4 n'indique pas le résultat visuel attendu

**Fichier :** `2-projets/index.qmd` ligne 206

La phrase de clôture dit :
> "Vous devriez voir : bandeau titre jaune SW + en-têtes noir/crème + ligne 1 rouge impérial dans
> tous les tableaux, et fond crème + axes noirs sur les graphiques."

C'est une description textuelle. Je n'ai aucune image de référence. Après 3 étapes et ~50 lignes
de code, je ne sais pas si j'ai "réussi" ou non sans ouvrir la correction et comparer visuellement
— ce que je ne suis pas censé faire pendant l'exo.

Comparaison avec les étapes 1/2a/2b/3 : chaque étape du tableau principal dit "Vous devriez
voir" avec un résultat **concret et unique** ("PDF unique avec couverture orange-book, TOC,
Figure 1.1..."). Le Bonus 4 est le seul endroit où la description visuelle tient en une phrase
sans image ni capture d'écran.

Conséquence réelle le 16 juin : je rends, je vois quelque chose, je ne sais pas si c'est ce
qui était attendu, je lève la main pour demander au formateur, qui est occupé avec 29 autres
personnes.

### 2. Le README Exo 2 ne liste pas `brand.yml` dans les prérequis packages

**Fichier :** `exercises/02-projet-book/README.md` ligne 9

```
Packages R installés : dplyr, ggplot2, ggrepel, gt, scales
```

Le Bonus 4 (étape 1) demande `library(brand.yml)`. Le package est dans `preparatifs.qmd` ligne
20, donc il est installé — mais quand j'ouvre le README de l'exo le matin, je lis la liste des
prérequis et `brand.yml` n'y est pas. Si pour une raison ou une autre mon install a raté (warning
ignoré lors du setup), je découvre le problème au moment du Bonus 4 seulement.

Correction minimale : ajouter `brand.yml` à la ligne 9 du README, entre `gt` et `scales`.

---

## P2 — nice-to-have

### 3. D'où viennent les noms "Autres" et "Cas remarquables" dans `scale_color_manual` ?

**Fichier :** `exercises/02-projet-book/correction/01-anatomie.qmd` lignes 85-86 et
`exercises/01-document-typst/correction/rapport-starwars.qmd` lignes 111-112

```r
mutate(categorie = if_else(mass > 200 | name == "Yoda",
                           "Cas remarquables", "Autres"))
```

puis plus bas :

```r
scale_color_manual(values = c(
  "Autres"           = brand_color_pluck(brand, "foreground"),
  "Cas remarquables" = brand_color_pluck(brand, "primary")
))
```

En lisant la correction, je vois `"Autres"` et `"Cas remarquables"` dans `scale_color_manual`
sans comprendre immédiatement d'où viennent ces chaînes. Je dois remonter jusqu'au `mutate()`
deux lignes plus haut pour voir que ce sont les valeurs créées dans la colonne `categorie`. Si
je copie ce pattern sur mes propres données, je dois comprendre que les noms dans `c(...)` doivent
être exactement les valeurs du `if_else()` — et ça ne se déduit pas seul.

Ce n'est pas bloquant (la correction fonctionne), mais le lien n'est jamais explicité, ni dans
la page Bloc 2, ni dans le Bonus 4. Un commentaire d'une ligne dans le code suffiirait :
`# noms = valeurs de la colonne 'categorie' créée dans mutate() ci-dessus`.

### 4. Bonus 4 — perception de taille : mini-tutoriel ou bonus de 3 min ?

**Fichier :** `2-projets/index.qmd` lignes 152-216

Le tableau des étapes dit "2 bonus (3 min, pour les rapides)". Mais il y a 3 bonus (B1, B2, B3
dans le tableau des étapes, et un B4 dans les callouts). Le Bonus 4 fait 3 sous-étapes avec
~50 lignes de code total. À 10h28, après avoir déjà fait B1 (refs croisées) et B2 (saut de
page conditionnel), je lis "Bonus 4" et j'ouvre un callout de même apparence que B3. Je
m'attends à 2 min. Je découvre 3 étapes et du code que je n'ai pas encore manipulé.

Ce n'est pas trompeur — le bonus est clairement marqué comme distinct — mais la phrase "2 bonus
(3 min)" dans le tableau des étapes ne couvre pas B3 et B4 (qui sont dans des callouts séparés
sous le tableau). Un participant·e qui lit vite pense que tout est couvert par "3 min".

Soit préciser que B3/B4 sont des bonus supplémentaires au-delà des 3 min, soit ajuster
l'annonce de durée.

### 5. Lisibilité : points "Autres" en `foreground` (noir SW) sur fond crème

**Palette :** `_brand.yml` — `foreground: sw-black` = `#0B0B0F`, `background: sw-cream` =
`#F5F0E1`

Le contraste `#0B0B0F` sur `#F5F0E1` est ~17:1 — excellent (AAA). Les points sont bien
visibles. En revanche, les axes de ggplot et la grille de `theme_minimal` utilisent aussi des
traits sombres (pas de confusion avec les points "Autres" grâce à la forme géométrique). Pas
de problème réel.

Ce que je perçois en tant que débutante : les points "Autres" sont noirs → ils se fondent avec
les ticks des axes. Ça n'est pas illisible, mais l'effet "couleur brandée" est peu saillant sur
les points de la masse de données. Seuls les points "Cas remarquables" en rouge impérial sont
vraiment visibles comme "brandés". La démonstration de la charte est un peu frustrante : le
seul point visuellement frappant, c'est la couleur `primary`, et c'est déjà le cas sans
brand.yml (on aurait pu mettre `"#BC1E22"` en dur). Ce n'est pas un bug, mais ça affaiblit
l'argument "charte cohérente" pour le participant qui ne fait pas le lien avec le swap palette
(Bonus 3).

### 6. Swap palette Bonus 3 → combien d'endroits changent ?

En faisant mentalement le compte :
- `_quarto.yml` : 1 ligne (`brand: _brand-jedi.yml`)
- Les barres du `geom_col` dans `02-origines.qmd` : `fill = brand_color_pluck(brand, "primary")` → suit
- La ligne 1 des 3 tableaux gt : `cell_fill(color = brand_color_pluck(brand, "primary"))` → suit
- La couleur "Cas remarquables" du ggplot de `01-anatomie.qmd` → suit
- La couverture du livre orange-book → suit (géré par Quarto/brand.yml)

Résultat : **1 changement YAML → 5+ éléments mis à jour**. L'effet est wow et l'argument
pédagogique tient. Le Bonus 4 + Bonus 3 ensemble sont la meilleure démo de "source unique".

Le callout "Combo avec Bonus 3" dans la page Bloc 2 (ligne 208) pointe ça en une phrase. C'est
court mais suffisant pour qui a déjà fait B3. Pas de problème ici.

---

## Ce qui me rassure

- Le package `brand.yml` est dans `preparatifs.qmd` ligne 20 — pas de surprise d'install à
  la dernière minute.
- Les commentaires inline dans la correction (`# Bandeau titre`, `# En-têtes colonnes`,
  `# Ligne 1 (Jabba)`) sont très clairs. Je comprends ce que chaque bloc fait sans
  connaître `tab_style()` par coeur.
- Le callout "Piège silencieux à connaître" (ligne 210-214 de `2-projets/index.qmd`) sur
  la normalisation `sw-yellow` → `sw_yellow` est placé exactement au bon endroit — juste
  après le code qui utilise `brand_color_pluck`. Je ne peux pas le manquer.
- Le code du Bonus 4 est entièrement copiable tel quel sur les fichiers du livre. Pas
  besoin d'adapter : "utilisable tel quel sur les 3 tableaux du livre" est une formulation
  qui me rassure.
- La colonne `categorie` est créée via `if_else()` dans le code visible — le lien avec
  `scale_color_manual` est trouvable même si non commenté.
- L'Étape 3 du Bonus 4 cite explicitement le fichier concerné (`02-origines.qmd`) pour le
  `geom_col` — je sais exactement où aller.

---

## Évolution depuis la review précédente

### Ce qui s'est amélioré

- **Le callout "Piège silencieux"** sur la normalisation tiret → underscore : dans ma
  première review, ce piège n'était documenté nulle part. Il est maintenant clairement
  signalé au bon endroit dans le Bonus 4.
- **Les commentaires inline** dans la correction (`# Bandeau titre`, `# En-têtes colonnes`,
  `# Ligne 1 (Jabba)`) : ma première review relevait que je voyais "40 lignes de tab_style()
  sans commentaires". Maintenant chaque bloc est annoté.
- **La note presenter du Bloc 1** (ligne 242 de `1-quarto-typst.qmd`) dit explicitement aux
  participants rapides d'aller voir `brand_color_pluck()` dans la correction — le formateur
  a maintenant le cue. C'était absent lors de ma première review.
- **La correction ggplot avec légende 2 couleurs** est cohérente entre l'Exo 1 et
  l'Exo 2 (même pattern `categorie` / `Autres` / `Cas remarquables` / `scale_color_manual`).
  Pas de divergence entre les deux corrections.
- **`brand_color_pluck` est maintenant mentionné dans `4-ressources.qmd`** (ligne 74 avec
  explication de la normalisation) — ma première review signalait l'absence.

### Ce qui était déjà bon

- Le code de styling gt dans la correction était déjà structuré de façon lisible (pipeline
  additive, pas de magic numbers).
- L'argument "une source, partout" est cohérent du début à la fin du parcours.
