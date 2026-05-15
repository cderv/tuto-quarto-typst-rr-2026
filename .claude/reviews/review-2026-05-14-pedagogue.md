# Review pédagogique — slide « C'est quoi Typst ? » — 2026-05-14

**Périmètre** : `1-quarto-typst/1-quarto-typst.qmd:43-100`, croisé avec `1-quarto-typst/index.qmd` et `exercises/01-document-typst/README.md`.

## Verdict général

L'ajout est pédagogiquement nécessaire : il pose la pré-connaissance manquante avant `format: typst`. **Préférence B**, pour des raisons andragogiques distinctes des autres reviewers : B est un *advance organizer* (Ausubel) qui réduit la charge cognitive **avant** l'Exo 1, là où A active une charge sémantique sans payoff visuel.

## 1. Avis tranché — B

- **Andragogie (Knowles)** : l'adulte apprend en raccrochant le neuf au déjà-su. B raccroche explicitement Typst au Markdown déjà connu. A raccroche à LaTeX, que la moitié n'a jamais touché directement.
- **Charge cognitive (Sweller)** : B introduit *un seul* concept neuf (« la traduction est automatique ») via comparaison visuelle. A empile trois claims abstraits en 1re slide post-intro → charge intrinsèque + extrinsèque cumulées.
- **Effet de modalité** : juste avant une démo Our turn, mieux vaut une slide visuelle qu'une slide à puces ressemblant aux 5 suivantes (rupture de pattern utile).
- **Continuité narrative** : le fragment `1-quarto-typst/1-quarto-typst.qmd:91` (teaser `keep-typ`) tisse l'arc M→O→Y. A est un cul-de-sac narratif.

## 2. Cohérences avec ce qui suit

Une seule tension réelle : la slide promet implicitement « tu n'as pas besoin de lire du Typst ». Or 3 slides plus loin (`1-quarto-typst/1-quarto-typst.qmd:163-169`) on demande d'ouvrir le `.typ`, et l'Exo 1 étape 3 (`exercises/01-document-typst/README.md:23-26`) aussi.

**Recommandation** : reformuler `:91` non comme teaser optionnel mais comme **contrat** : « On y jettera un œil ensemble — juste pour démystifier. » Transforme une rupture potentielle en promesse tenue.

`1-quarto-typst/index.qmd:24-29` annonce 4 objectifs d'apprentissage qui n'incluent pas « comprendre la place de Typst dans le pipeline ». Si B est retenue, ajouter un bullet 0 : *« Situer Typst dans le pipeline Quarto (vous écrivez du Markdown, Quarto traduit) »* — sinon la nouvelle slide est orpheline d'objectif explicite côté page web.

## 3. Faut-il adapter l'Exo 1 ?

**Oui, un seul ajustement.** `exercises/01-document-typst/README.md:23-26` annonce « le tableau `gt` y est bien une vraie `table()` ». Avec B, le participant a vu `=`, `*gras*`, `#link(...)` — pas `#table()`.

Suggestion : *« Vous y retrouverez le `=`, `*gras*` vus en slide, plus quelques fonctions Typst comme `#table()` pour le tableau gt. »* — boucle de feedback fermée, le participant ne panique pas.

Starter et correction : RAS. La slide pose un cadre mental, pas une syntaxe.

## 4. Suggestions concrètes

- `1-quarto-typst/1-quarto-typst.qmd:91` — reformuler en contrat plutôt qu'en option (cf. §2).
- `1-quarto-typst/1-quarto-typst.qmd:94-100` — les notes presenter n'évoquent **rien sur la co-animation**. Suggestion : « CD pose la slide (30 sec), Maëlle ajoute oralement *“et si vous avez fait du LaTeX, c'est la même place dans le pipeline”* » — couvre les deux profils sans alourdir la slide visuelle.
- `1-quarto-typst/index.qmd:24` — ajouter le bullet « Situer Typst dans le pipeline » (cf. §2).
- `exercises/01-document-typst/README.md:25` — anticiper `#table()` (cf. §3).
- **Supprimer A définitivement** plutôt que la laisser comme option dans le qmd : deux slides marquées « option » dans le deck live = risque de reveal accidentel le jour J si la suppression est oubliée. La décision se prend maintenant, pas le 15 juin.
