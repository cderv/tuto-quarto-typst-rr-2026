# Review élève débutant·e — slide « C'est quoi Typst ? » — 2026-05-14

**Périmètre** : nouvelle slide « C'est quoi Typst ? » (options A et B) dans `1-quarto-typst/1-quarto-typst.qmd:43-89`, avec passage par `exercises/01-document-typst/`.

## Verdict général

Les deux variantes me rassurent — c'est exactement la slide qui me manquait avant qu'on me dise « écris `format: typst` ». **Je préfère B.** Quelques bricoles à clarifier mais rien de bloquant.

## Variante A (concepts)

J'ai capté : Typst remplace LaTeX, c'est dans Quarto, je n'ai pas besoin de l'apprendre. OK.

Frictions :
- `1-quarto-typst/1-quarto-typst.qmd:45` — « système de composition » : terme jargon. Comme débutant·e, je dirais juste « outil ». « Composition » m'évoque Word/PowerPoint, pas un compilateur.
- Bullet 1 (`:48`) — « il prend la place de LaTeX » : je n'ai jamais utilisé LaTeX directement (juste `output: pdf_document` qui me crashait). Donc « place de LaTeX » me parle vaguement, pas concrètement.
- Aucun visuel : trois bullets abstraits, je ne sais toujours pas à quoi ressemble du Typst.

## Variante B (visuel side-by-side)

Là je **vois** ce qu'est Typst. Les deux blocs côte à côte = j'ai compris en 3 secondes : c'est un autre Markdown, à peine différent. La phrase `:61` « vous restez côté Markdown — la traduction se fait toute seule » me rassure exactement au bon endroit.

Le teaser fragment `:91` « Envie de voir le Typst généré ? On y arrive avec `keep-typ: true` » crée une attente saine.

Petite friction : `#link("…")[lien]` dans le snippet Typst (`:85`). Comme débutant·e je vais me demander « pourquoi `#` ? c'est un commentaire R ? ». Pas grave si c'est juste pour comparer visuellement, mais ça me distrait 2 secondes.

## Préférence : B

Avec un exemple concret je comprends. La A me parle au cerveau, la B me parle aux yeux. Et c'est plus court à lire à 9h25 quand j'ouvre encore mon laptop.

## Cohérence avec l'Exo 1

Pas de contradiction, mais une petite surprise : le README de l'exo (`exercises/01-document-typst/README.md:25`) m'annonce « C'est du Typst natif : le tableau `gt` y est bien une vraie `table()` ». Si j'ai vu la variante B juste avant, je m'attendais à `=`, `*gras*`. Voir `table()` me déstabilise un peu — mais c'est franchissable.

Plus gênant : la slide me promet implicitement que je ne verrai pas de Typst. Or à l'étape 3 du README on me demande **d'ouvrir le `.typ`**. La slide `keep-typ: true` (`:163-169`) recadre bien (« Apprendre la syntaxe Typst progressivement »), donc c'est bon — mais sans visuel préalable, ouvrir le `.typ` la première fois sera un choc.

**Argument supplémentaire pour B** : elle me prépare visuellement à ce que je verrai dans le `.typ`.

## Pépites bloquantes

- `1-quarto-typst/1-quarto-typst.qmd:45` — « système de composition » : à remplacer par « outil » ou « moteur ».
- `:85` — `#link(...)[...]` non expliqué : mini-friction, OK si le but est juste la comparaison visuelle.
- Saut logique latent (les deux variantes) : la slide dit « pas besoin de l'apprendre pour démarrer », puis 3 slides plus tard « ouvre le `.typ` ». Pas une contradiction, mais une légère tension. Une note orale type « on jettera juste un œil pour démystifier » suffit.

## Ce qui me rassure

- Les deux variantes posent **explicitement** que Typst remplace LaTeX. C'était ma question n°1.
- « Rien à installer » → soulagement. Pas peur d'une install qui foire avant l'exo.
- Lien `https://typst.app/` pour aller voir plus tard.
- Teaser `keep-typ` (B) crée une continuité narrative agréable.
