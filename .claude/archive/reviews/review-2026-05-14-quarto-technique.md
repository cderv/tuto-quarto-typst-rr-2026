# Review technique Quarto+Typst — slide « C'est quoi Typst ? » — 2026-05-14

**Périmètre** : `1-quarto-typst/1-quarto-typst.qmd:43-100` (options A et B) + `4-ressources.qmd:36`. Smoke test Quarto 1.9.36 sur Linux : `quarto render` OK. Ground truth option B obtenue via `keep-typ: true`.

## Verdict général

Les deux variantes sont techniquement correctes côté syntaxe Quarto/Reveal (`::: incremental`, `::: {.fragment .fade-in}`, columns 48/4/48). **Un seul bug factuel** : le snippet Typst de l'option B (`*en gras*`) ne correspond pas à ce que Quarto produit réellement (`#strong[en gras]`). À corriger si B est retenue, sous peine d'être contredit dès `keep-typ: true` deux slides plus loin.

## P0 — bloquant

- **`1-quarto-typst/1-quarto-typst.qmd:84`** — option B, claim faux. Pandoc émet `#strong[en gras]`, **pas** `*en gras*`. Vérifié via `keep-typ: true` sur Quarto 1.9.36 :
  ```
  = Mon rapport
  Un mot #strong[en gras] et un #link("https://example.org")[lien].
  ```
  Si un·e participant·e ouvre son `.typ` à l'étape 3 (`exercises/01-document-typst/README.md:23`) en s'attendant à `*gras*`, perte de confiance immédiate. **Fix** : remplacer `*en gras*` par `#strong[en gras]`. Bonus pédagogique : le contraste `**md** → #strong[...]` illustre mieux la **traduction** que la slide promet `:61`.

## P1 — à corriger avant le 16 juin

- **`1-quarto-typst/1-quarto-typst.qmd:49` et `:114`** — claim « depuis la version 1.5 » : `format: typst` est apparu en **pre-release dans 1.4** (févr. 2024) et stabilisé en **1.5** (mai 2024). Wording défendable, imprécis si quelqu'un pinaille.
- **Tension slide↔exo** signalée par le débutant·e : techniquement non bloquante mais **amplifiée si le P0 reste faux**. Une fois P0 corrigé, le snippet B devient l'amorce visuelle qui prépare à l'étape 3 — la tension s'inverse en pont pédagogique. **Aucune adaptation README/starter/correction nécessaire** côté exo 01.

## P2 — nice-to-have

- **`1-quarto-typst/1-quarto-typst.qmd:50`** — « Quarto traduit votre Markdown en Typst » : techniquement c'est **Pandoc** qui produit le `.typ` (cf. mermaid `:149-151`). Inexactitude vénielle, audience non-Pandoc-aware, OK de laisser.
- **`4-ressources.qmd:36`** — post ysunflower **correctement placé sous « Typst depuis R »** : retour d'expérience R-centric. Classer sous « Apprendre Typst » serait trompeur. **Classement validé.**
- Option A vs B : aucune différence technique, les deux compilent. Choix purement pédagogique.

## Choix techniques validés

- `::: incremental` + bullets : syntaxe Reveal correcte.
- `::: {.fragment .fade-in}` : classes valides, pas de conflit avec `format: clean-revealjs`.
- Columns 48/4/48 : pattern Quarto canonique, somme = 100%.
- Markdown→Typst structure (`= titre`, `#link(...)[...]`) : **conforme** à la sortie réelle. Seul `#strong` cassé.
- Rendu HTML : pas de warning multi-format.
