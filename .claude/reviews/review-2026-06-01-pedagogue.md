# Review pédagogique — Quarto+Typst RR 2026

**Date :** 2026-06-01 · **Commit de base :** `0bfc299` · **Review précédente :** `review-2026-05-26-pedagogue.md`

## Verdict général

Workshop **pédagogiquement prêt** pour le 16 juin. Arc `.qmd → PDF pro → livre → personnalisé/pérennisé` tracé bout-à-bout, rythme My/Our/Your symétrique entre les deux blocs. Les 3 P1 de la review du 2026-05-26 sont tous corrigés, et le P2-1 co-animation est désormais traité dans les deux docs `_speaker/`. Scaffolding solide, charge cognitive bien dosée. **Aucun P0.** Un seul vrai irritant subsiste : une incohérence de code-couleur des callouts entre slides et pages exercice.

## P0 — bloquant

Aucun.

## P1 — à corriger avant le 16 juin

**P1-1. Code-couleur « À vous ! » cassé entre slides et pages exercice.**
`1-quarto-typst/index.qmd:43` et `2-projets/index.qmd:47` — les pages exercice utilisent `::: callout-tip` (vert = couleur Our turn « Faisons ensemble ! ») pour le bloc « À vous ! ». Les slides utilisent `callout-warning` (jaune = Your turn), conformément à CLAUDE.md et à la slide d'intro du rythme (`1-quarto-typst/1-quarto-typst.qmd:30`). Les boussoles sont elles aussi jaunes (`1-quarto-typst/boussole.qmd:11`). Conséquence : quand le participant clique « Page Exercice 1 » depuis la slide jaune « À vous ! », il atterrit sur un bloc **vert** « À vous ! » — le signal couleur soigneusement codé partout ailleurs se contredit au moment clé du passage à l'exercice.
**Fix :** passer les deux blocs « À vous ! » des pages exercice de `callout-tip` à `callout-warning`.

## P2 — nice-to-have

- **P2-1 (non résolu depuis 2026-05-26).** `2-projets/boussole.qmd:24` — l'étape 3 mentionne un « bloc `format.typst.logo` custom » dont la syntaxe n'existe que dans le modèle `_quarto.yml` de la page exercice (`2-projets/index.qmd:121-131`), jamais sur la boussole. Un participant qui ne consulte que la boussole projetée bute. Reformuler en renvoyant au modèle de la page exercice.
- **P2-2 (non résolu).** `1-quarto-typst/1-quarto-typst.qmd:281` — pépite « Une charte, partout » (`brand_color_pluck`), la plus alignée avec l'arc, en position 3/4 sur la slide désignée comme « premier fusible à couper ». Risque qu'elle ne soit jamais verbalisée. Remonter en position 1-2 ou flagger en priorité orale dans la note.
- **P2-3.** `2-projets/index.qmd:172-252` — Bonus 3/4 (~80 lignes de code R) volumineux par rapport au temps. Bien marqués « post-atelier » (callout `:168`), donc non bloquant ; juste un possible effet « exercice plus long qu'il n'est » à la lecture écrite.

## ✅ Forces confirmées

Objectifs explicites par section (« À la fin de ce bloc, vous saurez ») ; wrap-up synthétique bouclant les 3 questions de l'accueil sans promesse implicite ; transition Exo 1→2 narrée + fallback `_brand-starter.yml` ; boucle d'autonomie robuste (colonne « Vous devriez voir » + escalier 3 marches + correction) ; co-animation CD/Maëlle désormais outillée dans les `_speaker/` ; scaffolding R neutralisé (`echo: false`) ; pépites bien dosées (1/bloc, titres conformes) ; préparatifs complets (Plan B offline + test Typst end-to-end + workaround version).

## 📝 Évolution depuis 2026-05-26

Résolus : P1-1 note `.content-visible` fantôme (`2-projets/2-projets.qmd:137`), P1-2 callout intro jaune, P1-3 titres « Saviez-vous que… », P2-1 co-animation. **Dégradé relatif :** la cohérence couleur — maintenant que les slides plantent proprement jaune=Your turn, le décalage page/slide (P1-1 ci-dessus) devient un vrai faux signal. Portés sans changement : boussole logo (P2-1) et pépite position 3/4 (P2-2).

## Vérifications RAS

Countdown cohérents (12:00 partout, plus de 15/12) ; aucun objectif implicite sur les 4 pages bloc/ressources + slides ; `fig-alt` présent (charte, tableau gt) ; pages internes `author/date` vides conformes ; 2 pépites au total, pas de surdosage.

## Comptage

**0 P0 / 1 P1 / 3 P2.**
