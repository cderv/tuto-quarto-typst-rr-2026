# Review pédagogique — `typography.headings.color: primary` (titres rouges) en Bloc 1

> Date : 2026-06-12 · Type : pedagogue · Question ciblée (single-issue)
> Fichiers lus : `1-quarto-typst/index.qmd` (Our turn + tableau étapes 3/4), `1-quarto-typst/1-quarto-typst.qmd` (démo Our turn + notes 270/310/334), `_charte/_brand.yml`, `exercises/01-document-typst/correction/_brand.yml`, `.claude/references/brand-typst-capabilities.md` (§3-4), la review conformité du 2026-06-12, `2-projets/2-projets.qmd` (slide `type: book`) + `2-projets/index.qmd` (objectifs/étapes), `workshop-pacing.md`.
> (Rédigée par l'agent pédagogue, reportée sur disque par l'orchestrateur — Write refusé pour l'agent.)

## Verdict : GARDER (avec un micro-ajustement de wording optionnel, P2)

C'était la **bonne décision**. Enseigner `headings.color` explicitement en Bloc 1 est andragogiquement supérieur à l'arc « titres noirs » d'origine, et les trois conditions qui le rendent sûr sont **déjà toutes remplies**. L'asymétrie Bloc 1 (explicite) → Bloc 2 (gratuit) n'est **pas** un piège : c'est exactement la progression « je le fais à la main, puis l'outil le fait pour moi », qui rend la magie du Bloc 2 *lisible* au lieu de magique. Aucun risque bloquant. Seule réserve : un point de wording (P2) pour désamorcer par anticipation la question « pourquoi pas en Bloc 2 ? » si elle surgit.

## Pourquoi GARDER (et non revenir aux titres noirs)

1. **Effet visible / récompense immédiate.** Le tableau (`1-quarto-typst/index.qmd:63`) promet « Titres de section en lettres décoratives Star Jedi, **en rouge imperial** ». Couleur + police changent ensemble → l'étape 4, la plus coûteuse syntaxiquement (`source: file` + `files:`), devient l'étape « wow ». La couleur **maximise le payoff là où l'effort est le plus grand**.
2. **Cohérence cible↔transcription.** L'apprenant a `charte-starwars.pdf` projeté (notes `:268, :300`) où les titres sont **déjà rouges** ; la note méta (`:270`) dit « ses titres en Star Jedi rouge […] viennent d'un `_brand.yml` identique au vôtre ». Avant, dissonance charte-rouge/correction-noire. Le changement la **résout**. Gain net de cohérence.
3. **Modèle mental correct et transférable.** `primary` colore automatiquement les liens uniquement (`index.qmd:37`, `1-quarto-typst.qmd:283`). L'étape 4 enseigne « pour colorer les titres, il faut le demander » via `headings.color` — la vérité du modèle brand→Typst (`brand-typst-capabilities.md:9, :79`).

## Pourquoi l'asymétrie Bloc 1→Bloc 2 est un atout

1. **Pattern « manuel → automatique ».** L'effort manuel en Bloc 1 crée le contraste qui rend orange-book impressionnant en Bloc 2 (`2-projets.qmd:113` : « zéro configuration supplémentaire »). **L'asymétrie produit le wow.**
2. **La 3e voie (titres noirs Bloc 1) est plus faible** : symétrie cosmétique, gaspille l'occasion d'enseigner `headings.color` au moment où l'apprenant manipule déjà `typography.headings` (coût +1 ligne), laisse la dissonance, prive le Bloc 2 de son contraste.
3. **La question « pourquoi pas en Bloc 2 ? » ne se pose presque jamais** : en Bloc 2 l'apprenant ne touche jamais `typography.headings` (`2-projets/index.qmd:61-62`). Il obtient les titres colorés en bloc avec couverture + TOC.

## Seule réserve (P2)

Un participant rapide pourrait demander à Maëlle « pourquoi `headings.color` au Bloc 1 et plus maintenant ? ». Aucune note orateur Bloc 2 n'arme cette réponse. Non bloquant.

**Wording recommandé** — dans `::: notes` de la slide `type: book` (`2-projets/2-projets.qmd:112-116`), après « moment wow » :

> **Pont avec le Bloc 1 (si on le demande)** : au Bloc 1, pour des titres rouges il fallait écrire `typography.headings.color: primary` à la main (template article = Quarto ne colore que liens/fond/texte). Ici, orange-book reprend `primary` comme accent et colore titres + couverture + TOC **toute seule** — c'est ça, la valeur d'une extension. `headings.color` est d'ailleurs ignoré en mode book. À ressortir seulement si la question vient.

Déconseillé de toucher le tableau étape 4 (`index.qmd:63`) : déjà dense.

## Articulation avec la review conformité du même jour

Elle concluait « NE PAS ajouter `headings.color` » — mais sur la conformité à la charte *telle qu'elle était alors*. La présente décision **change la charte elle-même** (redesign assumé). Une fois charte + correction + supports alignés sur le rouge, plus de divergence et l'arc est *renforcé*. Les deux reviews ne se contredisent pas.

## Synthèse priorités

- 🔴 P0 — Aucun.
- 🟠 P1 — Aucun.
- 🟡 P2 — Armer une note orateur Bloc 2 (slide `type: book`, `::: notes`) avec le « pont » Bloc 1→Bloc 2. Ne pas alourdir le tableau étape 4.

**Bilan : décision validée — GARDER. 0 P0 / 0 P1 / 1 P2.**
