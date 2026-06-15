# Review élève débutant·e — Stylisme `_brand.yml` (2026-06-15)

Contexte : parcours de l'exo 1 puis 2 en suivant uniquement les pages de référence,
focus sur le stylisme via `_brand.yml`. Review parallèle avec le pédagogue.

## Verdict

Les 4 étapes YAML de l'exo 1 sont claires tant que je reste côté config (titre,
liens, fond, police). Le décrochage arrive quand je bloque et ouvre la **correction
de l'exo 1** : son bloc `setup` (30 lignes de `library(brand.yml)`, `styliser_brand`,
`pal()`, `teinte()`, `theme_brand_gt`, `#highlight(...)`{=typst}) répond à des
questions que l'exo 1 **ne pose jamais**. Le pont « je colore le doc » (exo 1) →
« je colore mes tableaux/graphiques » (Bonus B4 exo 2) n'est explicité nulle part
au moment où j'en ai besoin.

## 1. Correction exo 1 : confusion honnête

Après mes 4 étapes : titre rouge Star Jedi, liens imperial-red, fond crème, corps
Inter. **Mais mon tableau `gt` et mon `ggplot` restent gris.** Je crois avoir raté
un truc, j'ouvre la correction (`correction/rapport-starwars.qmd:27-70`) et je décroche :

- **`library(brand.yml)`** — je croyais que `_brand.yml` était un *fichier*. Là c'est
  un *package R* quasi-homonyme. Et il faut `prismatic` (sinon plante — écrit à
  l'exo 2 B4, pas ici).
- **`styliser_brand`, `pal()`, `teinte()`, `theme_brand_gt`** — aucune des 4 étapes
  ne les demande. `1-quarto-typst/index.qmd` ne contient zéro occurrence de
  `theme_brand`, `brand_color`, `prismatic`, « Bonus B4 ».
- **`#highlight(fill: brand-color.sw-yellow)[droïdes]`{=typst}** (`:115`) — Typst brut
  inline jamais introduit, et `brand-color.sw-yellow` (tiret) alors que le R écrit
  `pal("sw_yellow")` (underscore).

Bilan : la correction de l'exo 1 est en fait la correction **du Bonus B4 de l'exo 2**.
Trop riche pour l'exo 1, elle déstabilise au lieu de rassurer. **Débloquant :** un
bandeau en tête de la correction (ou callout dans l'index exo 1) disant que cette
correction va plus loin que les 4 étapes (= Bonus B4 exo 2) et que pour l'exo 1 seules
les 4 étapes YAML comptent, tableau et graphique restant bruts.

## 2. Pourquoi tableaux/graphiques ne se colorent pas ?

**Non, pas spontanément.** Modèle mental manquant : `_brand.yml` est lu par
**Quarto/Typst** pour la mise en page, mais **PAS par R** — gt/ggplot sont produits
avant Typst, donc ignorent la charte sauf branchement manuel depuis R. Ce paragraphe
n'existe nulle part dans l'exo 1. La phrase salvatrice existe à l'exo 2
(`2-projets/index.qmd:68`) — à avancer à l'exo 1.

## 3. Pont charte → `_brand.yml` → résultat

**Bien pour le YAML** : la charte (`_charte/charte-starwars.qmd`) donne les
affectations prêtes (`:59`), usages typographie, logo. **Manque :** le pont charte →
**code R** → tableaux/graphiques (absent de l'exo 1 alors que la correction l'emprunte) ;
et le piège **tiret vs underscore** (`sw-yellow` YAML vs `sw_yellow` R) expliqué trop
tard (`2-projets/index.qmd:288-292`).

## 4. Blocages classés

- **P0.1** — Correction exo 1 (`:27-70`, `:115`) contient du code jamais annoncé.
  Perte 5-10 min à croire avoir raté une étape. *Fix : bandeau « = Bonus B4 ».*
- **P1.1** — « Vous devriez voir » étape 3 (`index.qmd:67`) ne dit pas que
  tableau/graphique restent bruts. *Fix : avancer la phrase de `2-projets/index.qmd:68`.*
- **P1.2** — Modèle mental « Quarto/Typst lit `_brand.yml`, R non » absent.
  *Fix : pépite slides Bloc 1, ou encart index exo 1.*
- **P1.3** — Piège tiret/underscore invisible au moment rencontré.
- **P2.1** — Ambiguïté `brand.yml` (package) vs `_brand.yml` (fichier).
- **P2.2** — `{=typst}` inline / `#highlight(...)` jamais introduit.
- **P2.3** — « rôle sémantique » (`charte:61`) mériterait un mini-exemple.

## Ce qui rassure

Séquencement des 4 étapes excellent ; conseil « étape 1 seule » (`index.qmd:59`) ;
titres noirs jusqu'à l'étape 4 anticipé ; callout « PDF verrouillé » ; charte avec
affectations prêtes ; couple index/boussole cohérent ; callout `gt` « 1 7 5 » clair ;
exo 2 dit clairement que les tableaux restent bruts jusqu'au B4.

**Comptage : 1 P0, 3 P1, 3 P2.**
