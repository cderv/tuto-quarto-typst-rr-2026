# Review pédagogique — `brand_color_pluck` dans la correction Exo 1

**Date :** 2026-05-19
**Scope :** `exercises/01-document-typst/correction/rapport-starwars.qmd` (lignes 72-98) + contexte slides Bloc 1 (`1-quarto-typst/1-quarto-typst.qmd:193-198`) + page Ressources (`4-ressources.qmd:73`)

---

## Verdict général

L'ajout est techniquement propre et l'idée centrale — "une source, plusieurs rendus" — est pédagogiquement solide. Mais dans son placement actuel (correction Exo 1, silencieuse côté slides), il crée une asymétrie : le message est enterré dans un fichier que la majorité des participants n'ouvriront pas pendant le workshop. Le risque n'est pas le découragement mais l'invisibilité totale. La valeur justifie de garder l'addition, à condition de lui donner un point d'ancrage visible dans les slides.

---

## Analyse point par point

### 1. Valeur ajoutée pédagogique

Ce que `theme_brand_gt(brand)` seul enseigne : "la charte s'applique globalement au tableau via un helper".

Ce que les trois `tab_style()` + `brand_color_pluck()` ajoutent :

- **Concept clé nouveau** : la palette nommée du `_brand.yml` est interrogeable depuis R avec une API typée — pas juste un thème appliqué en bloc, mais une valeur de couleur extractible et réutilisable à la granularité de chaque cellule.
- **Preuve de la source unique** : `brand_color_pluck(brand, "sw-yellow")` dans R résout exactement le même jaune `#FFE81F` qui colore le bandeau orange-book du PDF Typst. Aucune duplication hex.
- **Charge cognitive** : modérée. Les participants qui lisent la correction connaissent déjà `tab_style()` + `cell_fill()` + `cell_text()` (API gt standard). La seule nouveauté est `brand_color_pluck()`. Le code est commenté ligne à ligne, ce qui désamorce la complexité.

Bilan valeur/coût : ratio favorable. Le concept "une charte, un fichier, partout" passe d'abstrait à concret en 3 appels de fonction.

### 2. Placement — Bloc 1 correction vs alternatives

**Placement actuel (correction Exo 1) — analyse honnête**

Problème principal : la note presenter sur la slide `_brand.yml` (ligne 195 de `1-quarto-typst.qmd`) mentionne les helpers en 30 secondes et pointe vers la correction, mais ne crée pas d'ancrage mémoriel. Un participant qui passe 15 min sur son exercice, voit un décompte, et ne finit peut-être pas — il n'ouvrira pas la correction pendant le workshop. Il l'ouvrira après, si du tout.

Le code lui-même est dans la correction mais n'est signalé nulle part dans les slides comme "allez voir tel bout de code pour ça". La note presenter (ligne 195) dit "Visible dans `correction/rapport-starwars.qmd`" — mais ce n'est pas répété aux participants à l'oral dans le Your turn (la note du Your turn, ligne 238, ne mentionne que le bug gt/espacement, pas `brand_color_pluck`).

**Option A : Pépite "Saviez-vous que..." Bloc 1 — recommandée**

La slide pépite Bloc 1 (lignes 243-255) liste trois items techniques. Ajouter un quatrième item :

> `brand.yml` côté R — `brand_color_pluck(brand, "sw-yellow")` renvoie le hex exact de la palette. Vos figures ggplot, tableaux gt et votre PDF Typst partagent la même source. Visible dans la correction.

Avantages : (1) exposé à tous, pas seulement ceux qui ouvrent la correction ; (2) clôture narrativement la slide `_brand.yml` qui précède l'exo ; (3) un seul item = charge cognitive nulle ; (4) "Visible dans la correction" devient un vrai appel à action post-exo.

Inconvénient mineur : la slide pépite Bloc 1 a déjà 3 items bien équilibrés. Un 4ème allonge. Alternative : remplacer l'item "Blocs raw Typst" (déjà dans la pépite Bloc 2 ligne 127) par cet item — le raw Typst peut rester dans les Ressources sans perte.

**Option B : Garder en correction Bloc 1 + mentionner explicitement dans la note presenter Your turn**

Coût : zéro modification de slide. Gain : les formateurs pensent à le signaler oralement. Limite : dépend de l'oral, non tracé dans les supports participant.

**Option C : Bonus Exo 2**

Le Bloc 2 porte déjà "tableaux gt re-stylés" dans les attendus de l'étape 3 (index.qmd:56). Mais le message "une source" est plus percutant quand on vient juste de créer son `_brand.yml` — soit fin Bloc 1. Déplacer en Bloc 2 affaiblit le lien temporel avec la création du fichier.

**Option D : Page Ressources seule**

La page Ressources cite déjà `theme_brand_gt()` et `theme_brand_ggplot2()` (ligne 73) mais pas `brand_color_pluck`. Si le styling reste en correction sans slide, au minimum ajouter `brand_color_pluck` à la liste en 4-ressources.qmd:73 pour que les chercheurs trouvent.

### 3. Effet "wow" à l'ouverture de la correction

Scénario réaliste : un participant finit l'exo avec un tableau gt fonctionnel mais monochrome (le starter ne charge pas `brand.yml`). Il ouvre la correction PDF. Il voit un tableau avec bandeau titre jaune vif, en-têtes noirs, ligne Jabba en rouge impérial.

Réaction probable : pas de découragement — parce que le tableau du starter fonctionne, le styling est clairement un "plus" et non un pré-requis. L'effet aspirationnel ("ah, c'est ça que je pourrais faire") est positif si et seulement si le participant comprend le lien avec ce qu'il vient de faire. Sans ce lien explicité (dans les slides ou à l'oral), il voit "du code gt avancé" sans comprendre que c'est juste `brand_color_pluck` + les noms de sa palette.

Condition pour que le wow soit lisible : le code source de la correction doit rester aussi commenté qu'il l'est aujourd'hui (les 3 commentaires `# Bandeau titre`, `# En-têtes colonnes`, `# Ligne 1`) — c'est déjà le cas, ne pas toucher.

### 4. Risque de doublon narratif

Vérifié : `theme_brand_ggplot2()` + `theme_brand_gt()` apparaissent dans la note presenter ligne 195 (Bloc 1) et dans les Ressources (ligne 73). `brand_color_pluck` n'apparaît **nulle part** en dehors de la correction.

Pas de doublon. C'est précisément le problème : la fonction est dans le code mais absente du discours pédagogique. Le gap est réel.

### 5. Point technique à vérifier

`brand_color_pluck` est une fonction du package `brand.yml`. Ce package est dans la liste d'installation de `preparatifs.qmd` (ligne 20). Aucun risque de dépendance manquante. La fonction n'est pas documentée dans les slides ni les pages web du tutoriel — acceptable si la correction reste le seul lieu, mais à mentionner dans les Ressources.

---

## Recommandation finale

**Garder l'addition dans la correction — elle est pédagogiquement juste.**

Actions à mener pour qu'elle soit utile :

1. **Prioritaire** — Ajouter un item à la slide pépite Bloc 1 (`1-quarto-typst/1-quarto-typst.qmd:248`) :

   > `brand.yml` côté R — `brand_color_pluck(brand, "sw-yellow")` extrait une couleur de la palette. Vos tableaux gt utilisent la même source que votre PDF Typst. Voir la correction.

   Si la slide est déjà trop chargée, remplacer l'item "Blocs raw Typst" (déjà couvert en Bloc 2 pépite) par celui-ci.

2. **Secondaire** — Mettre à jour `4-ressources.qmd:73` pour ajouter `brand_color_pluck()` dans la liste des helpers mentionnés.

3. **Optionnel** — Dans la note presenter du Your turn Exo 1 (`1-quarto-typst.qmd:237-241`), ajouter une ligne : "Pour les rapides qui ouvrent la correction : montrer `brand_color_pluck` dans le code gt — c'est la même source que le PDF."

Sans l'action 1, l'addition reste un easter egg de correction — utile pour le post-workshop, invisible le jour J.
