# Review débutant·e — Styling gt avancé dans la correction Exo 1
**Date :** 2026-05-19
**Profil :** participant·e R/RMarkdown, jamais touché à Quarto ni Typst, dplyr/ggplot2 confortable, gt occasionnel
**Périmètre :** correction `exercises/01-document-typst/correction/rapport-starwars.qmd` + PDF rendu + `.typ` généré

---

## Verdict général

Le nouveau bloc de styling gt dans la correction est techniquement sophistiqué mais **il ne produit pas l'effet visuel attendu dans le PDF** — et personne ne me le dit. Le PDF montré lors du workshop montre un tableau sobre en crème/noir, sans bandeau jaune ni ligne rouge Jabba. En lisant la correction après l'exo, je vois 40 lignes de `tab_style()` avec `brand_color_pluck()` pour un résultat qui... ressemble au tableau sans styling. C'est déstabilisant.

---

## 1. Confusion potentielle : découragé·e ou motivé·e ?

**Découragé·e, et pour une mauvaise raison.**

La section styling dans la correction fait environ 45 lignes de code R (3 blocs `tab_style()`, chacun avec `list()`, `cell_fill()`, `cell_text()`, `brand_color_pluck()`). Dans mon starter, la même section fait 7 lignes. La différence est brutale.

Ce qui aggrave : je cherche la récompense visuelle. Je regarde le PDF. Le tableau est... identique à un tableau non stylisé. Fond crème, texte noir, séparateurs gris. Aucun bandeau jaune `#FFE81F`, aucune ligne rouge Jabba. Si j'avais écrit ce code moi-même, je penserais avoir fait une erreur.

Vérification dans le `.typ` généré : les `tab_style()` produisent bien des `fill: rgb("#f5f0e1")` (sw-cream, couleur de fond) et `fill: rgb("#0b0b0f")` (sw-black) pour le titre et les en-têtes. Le rouge `#bc1e22` et le jaune `#ffe81f` n'apparaissent nulle part dans le tableau Typst. Le styling "avancé" s'applique mais avec les couleurs `foreground`/`background` de la charte — qui fondent avec le fond de page. L'effet escompté (bandeau jaune, ligne Jabba rouge) n'est **pas visible dans le PDF**.

Résultat du point de vue débutant·e : je vois du code complexe dont l'effet est invisible, sans explication.

---

## 2. Charge cognitive : combien de concepts nouveaux ?

Je compte les concepts que je dois absorber pour comprendre ce seul bloc de code :

1. `brand_color_pluck(brand, "sw-yellow")` — fonction inconnue, je ne sais pas ce qu'elle retourne (une string hex ? un objet R ?) ni d'où vient `brand` (je cherche dans le code, je vois `brand <- read_brand_yml()` dans le chunk setup, mais `read_brand_yml()` est aussi nouveau)
2. `tab_style()` avec `style = list(...)` — je connais `tab_style()` de base mais pas la syntaxe avec liste imbriquée
3. `cell_fill(color = ...)` — nouveau
4. `cell_text(weight = ..., color = ...)` — nouveau
5. `cells_title()` vs `cells_column_labels()` vs `cells_body(rows = 1)` — 3 sélecteurs `gt` distincts que je ne connais pas
6. Le fait que `foreground` dans `_brand.yml` = sw-black, et `background` = sw-cream — mapping indirect que je dois reconstituer en lisant `_brand.yml`
7. Pourquoi les couleurs nommées dans `tab_style()` correspondent à des noms du `_brand.yml` (pas à des hex directs)

**7 concepts nouveaux en 45 lignes, pour un effet invisible dans le PDF.** C'est la combinaison la plus décourageante possible.

---

## 3. Liens manquants : la correction explique-t-elle ce qui se passe ?

Les commentaires R existants sont corrects mais insuffisants pour un débutant :

```r
# Bandeau titre : jaune SW + texte noir gras
# En-têtes colonnes : noir SW + texte crème gras
# Ligne 1 (Jabba) : rouge impérial + texte crème gras
```

Ces commentaires décrivent l'intention mais pas la réalité visible. En lisant le PDF, je ne vois pas de bandeau jaune. Je me demande si les commentaires sont des aspirations non réalisées ou des descriptions exactes.

**Ce qui manque :**
- Un commentaire ou callout expliquant que `brand_color_pluck()` vient du package `brand.yml`, déjà chargé dans le chunk setup
- Une note expliquant pourquoi la couleur "sw-yellow" de `_brand.yml` s'appelle via `brand_color_pluck(brand, "sw-yellow")` et pas juste `"#FFE81F"`
- Un pointeur vers la pépite ou la slide qui a présenté `theme_brand_gt()` — ce combo `theme_brand_gt()` + `tab_style()` suppose que j'ai compris les deux
- Une explication (même courte) sur pourquoi les sélecteurs `cells_title()` / `cells_column_labels()` / `cells_body(rows = 1)` ciblent des zones différentes

**Absence de note pédagogique cruciale :** si le styling jaune/rouge ne s'affiche pas dans le PDF rendu (voir constat ci-dessous), il n'y a aucun callout pour le signaler.

---

## 4. Copier-coller-adapter au boulot : est-ce suffisant ?

**Partiellement.** Le code est copiable tel quel pour reproduire le pattern `brand_color_pluck() + tab_style()`. Mais :

- Je dois savoir que `brand.yml` est un package R à installer (`library(brand.yml)` dans le setup, ok, mais le package lui-même n'est pas mentionné dans les prérequis du workshop)
- Je ne sais pas si `brand_color_pluck()` est documenté quelque part, ni comment je peux l'utiliser sans un `_brand.yml` Star Wars
- Pour adapter à mes propres couleurs, je dois comprendre que les noms dans `brand_color_pluck(brand, "mon-bleu")` doivent correspondre aux clés `palette:` dans mon `_brand.yml` — ça n'est pas dit
- La relation entre `primary` / `foreground` / `background` (les aliases de `_brand.yml`) et les couleurs de palette n'est pas explicitée

---

## 5. Couleurs : lisible et professionnel ?

Observation directe du PDF : le tableau est sobre, crème et noir, séparateurs gris discrets. C'est **parfaitement professionnel**. Le fond de page crème `#f5f0e1` est agréable.

Le problème est exactement l'inverse de ce que je craignais : **les couleurs Star Wars ne s'appliquent pas dans le tableau du PDF**. Le jaune `#FFE81F` et le rouge `#BC1E22` sont absents. Le tableau Typst généré (visible dans le `.typ`) utilise `fill: rgb("#f5f0e1")` pour le titre et les en-têtes — soit la couleur de fond de page, rendant le "bandeau jaune" invisible.

Du coup pour un rapport d'entreprise, le rendu actuel est excellent. Mais l'objectif pédagogique annoncé (montrer la charte appliquée au tableau) n'est pas atteint visuellement.

---

## 6. Placement : frustrant ou rassurant que ce soit "juste dans la correction" ?

**Rassurant sur le principe**, à condition d'être honnête sur ce point.

Si l'animateur·ice me dit "ce styling avancé est dans la correction pour vous montrer jusqu'où on peut aller, vous n'avez pas à le reproduire en 15 min", je comprends et j'apprécie le modèle. C'est la bonne pédagogie "Your turn lite + correction riche".

Mais si je lis la correction en autonomie sans cette explication — ce qui arrive typiquement le soir après le workshop — je vois du code complexe dont l'effet est invisible dans le PDF et je ne sais pas quoi conclure. Est-ce cassé ? Est-ce que j'ai mal configuré mon environnement ? Est-ce normal ?

---

## Problème principal identifié (P0)

Le `.typ` généré confirme que les `tab_style()` avec jaune/rouge ne produisent pas de cellules colorées dans le PDF. Voici ce qui se passe :

- `cells_title()` reçoit `fill: rgb("#f5f0e1")` (sw-cream = couleur de fond) et `fill: rgb("#0b0b0f")` (sw-black) — le bandeau "jaune" est en réalité crème
- `cells_column_labels()` reçoit `fill: rgb("#f5f0e1")` (encore crème) — les en-têtes "noirs" sont en réalité crème sur crème
- La ligne Jabba ne reçoit aucune couleur distincte dans le Typst généré

Concrètement : `brand_color_pluck(brand, "sw-yellow")` retourne probablement la couleur de fond de la crème (résolution via `palette` → alias `background` → `sw-cream`), pas le jaune `#FFE81F`. La chaîne de résolution `_brand.yml` via `brand_color_pluck()` ne se traduit pas en couleurs vives dans le tableau Typst.

**L'effet visuel annoncé par les commentaires R ne correspond pas au PDF rendu.** C'est le point le plus important à corriger ou à documenter.

---

## Résumé par priorité

**P0 — bloquant pédagogiquement**
- Le tableau du PDF ne montre pas les couleurs jaune/rouge annoncées dans les commentaires. Il faut soit corriger le code R pour que l'effet soit visible, soit ajouter un callout expliquant que le rendu Typst via `gt` a des limites sur le styling de couleurs de cellules (et que c'est attendu/connu).

**P1 — à clarifier avant le 16 juin**
- Ajouter une note dans la correction sur l'origine de `brand_color_pluck()` et son lien avec les clés de `_brand.yml` — un débutant ne fait pas ce lien seul
- Expliquer en une phrase pourquoi on utilise `brand_color_pluck(brand, "sw-yellow")` plutôt que `"#FFE81F"` directement (réponse : cohérence avec la charte, pas le hardcoding)
- Préciser dans le README de l'exo ou dans un callout de la correction que le styling `tab_style()` est du "bonus avancé" et non l'objectif des 15 min

**P2 — nice-to-have**
- Un schéma ou tableau commenté montrant les 3 zones ciblées par `cells_title()` / `cells_column_labels()` / `cells_body(rows = 1)` aiderait énormément les débutants gt
- Lien vers la doc `brand.yml` R package pour permettre la réutilisation hors workshop

---

## Ce qui me rassure

- Le code est bien commenté ligne par ligne (intention de chaque `tab_style()` claire)
- La structure `gt() |> tab_header() |> fmt_number() |> cols_label() |> theme_brand_gt()` dans le starter est accessible et lisible
- La présence de `opt_table_font(font = "Inter")` avec son commentaire sur le bug "1 7 5" est un excellent exemple de documentation de workaround
- Le PDF final est élégant et professionnel — le fond crème, la police Inter, le logo étoile : ça donne envie de produire ce résultat
