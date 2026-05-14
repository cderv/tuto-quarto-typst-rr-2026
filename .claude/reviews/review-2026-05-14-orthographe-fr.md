# Review orthographe & typographie FR — 2026-05-14

**Périmètre** : nouvelle slide « C'est quoi Typst ? » (options A et B) dans `1-quarto-typst/1-quarto-typst.qmd:43-89` + nouvelle ligne dans `4-ressources.qmd:36`.

## Verdict général

Qualité linguistique très propre, dans la lignée du reste du fichier. Vouvoiement uniforme, apostrophes courbes correctes, tirets cadratins `—` bien employés, accents propres. Quelques micro-ajustements (un pluriel anglicisant « PDFs », une redondance avec la slide suivante) — rien de bloquant.

## P0 — bloquant

_Aucun._

## P1 — à corriger avant le 16 juin

- `1-quarto-typst/1-quarto-typst.qmd:45` — « pour produire des **PDFs** » → « pour produire des **PDF** » *(les sigles sont invariables en français ; cohérent avec « un PDF » l. 61, 102, 104)*
- `1-quarto-typst/1-quarto-typst.qmd:48` — « **Un autre moteur pour produire des PDFs** » → « **Un autre moteur pour produire des PDF** »
- `1-quarto-typst/1-quarto-typst.qmd:49` — « **Embarqué dans Quarto** depuis la version 1.5 » est strictement redondant avec la slide suivante l. 114 (« **Rien à installer** — Typst est intégré à Quarto depuis la version 1.5 »). Suggestion : « **Embarqué dans Quarto** — disponible nativement depuis la version 1.5 » pour différencier.

## P2 — nice-to-have

- `1-quarto-typst/1-quarto-typst.qmd:45` — « système de composition pour produire des PDF » → « système de composition de documents » plus idiomatique en FR.
- `1-quarto-typst/1-quarto-typst.qmd:50` — « à votre place » est un léger anglicisme. Plus naturel : « **automatiquement** » ou « **pour vous** ».
- `1-quarto-typst/1-quarto-typst.qmd:61` — « la traduction vers Typst se fait toute seule » : registre familier vs reste de la slide. Alternative : « la traduction vers Typst est automatique ».
- `4-ressources.qmd:36` — « retour d'expérience d'une migration pagedown → Typst côté R » : double construction lourde. Plus fluide : « retour d'expérience sur une migration pagedown → Typst en R ».

## Forces linguistiques

- Apostrophes courbes systématiques.
- Tirets cadratins `—` cohérents.
- « depuis la version 1.5 » bien formulé.
- « moteur » : choix net pour traduire « engine ».
- Vouvoiement parfait, tutoiement réservé aux `::: notes` (convention projet respectée).
- Écriture inclusive soignée (« celles et ceux »).
