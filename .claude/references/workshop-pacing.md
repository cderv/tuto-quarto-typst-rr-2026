# Workshop Pacing Guidelines

Derived from Mine Çetinkaya-Rundel's workshops (USCOTS 2023, Monash 2023) and Maëlle's feedback.

## The Three Modes

Every module cycles through three teaching modes:

- **My turn** — Short concept presentation via slides (~5-10 min max per cycle)
- **Our turn** — Live coding, participants follow along in their editor
- **Your turn** — Independent exercise with countdown timer (5-10 min)

The cycle repeats multiple times per module. It's NOT "30 min talk then 30 min exercise."

## Time Ratios

Maëlle's rule: **1h hands-on for 30min talk** (2:1 ratio favoring exercises).

For a 2h workshop with ~110 min effective time:
- ~35-40 min presentation + live demo ("My turn" + "Our turn")
- ~60-70 min hands-on ("Your turn")

Mine's Monash workshop (3h instruction): each 60-min module ≈ 20 min presentation/demo + 25-30 min hands-on.

## Exercise Design

- **Starter `.qmd` files**, not instructions on slides — participants have something open immediately
- Exercises are **short and focused** (5-10 min each with countdown), not comprehensive
- Each exercise ships its own `correction/` folder (référence pédagogique post-Your turn) — pas un secret. Le « Our turn » live coding reste la traversée principale.
- Exercises servis via le website : `_quarto.yml` racine exclut `!exercises/` du render mais garde `exercises/**` comme `resources:`. Téléchargeables via `tree/main/exercises/0X-…/` (pas de `.zip` distribué).
- **Progressive**: later exercises build on earlier ones (l'Exo 2 réutilise/promeut le `_brand.yml` + logo SW de l'Exo 1 au niveau projet ; pour les participants n'ayant pas fini, `_brand-fallback.yml` à la racine d'Exo 2)
- Exercise files are minimal: working code but bare structure — participants add the new concepts
- **Mini-test pré-tutoriel** : `exercises/00-test-install/test-install.qmd` (sans `_brand.yml` pour fiabilité offline) référencé dans `preparatifs.qmd` pour valider la chaîne Typst end-to-end avant le jour J

## Structure Patterns

### File organization (Mine's pattern, adapté RR 2026)
```
exercises/              # nested per exo (starter + correction)
  00-test-install/
    test-install.qmd    # mini-test pré-tutoriel (autonome)
  01-document-typst/
    starter/rapport-starwars.qmd
    correction/         # _brand.yml + _brand-offline.yml + _fonts/ + _logo-sw.svg + .qmd
  02-projet-book/
    starter/            # 5 .qmd, sans _quarto.yml
    correction/         # _quarto.yml + _brand.yml + _logo-sw.svg + 5 .qmd
    _brand-fallback.yml # pour participants n'ayant pas fini Exo 1
N-module-name/
  index.qmd             # landing page (iframe + exercise download links)
  N-module-name.qmd     # RevealJS slides (short!)
```

Différence vs Mine : (a) starter/correction explicites au lieu de starter seul,
(b) exercices servis via le site (pas de `.zip`), (c) un mini-test
pré-tutoriel autonome pour dérisquer l'install.

### Slide deck structure
- Announce "My turn / Our turn / Your turn" rhythm at the start
- Each "Your turn" block has a countdown timer
- End each module with an iframe to the relevant Quarto docs page ("Learn more")
- Keep slides short — the live demo carries the teaching, not the slides
- **Wrap-up de fin de tutoriel** : 3 slides My turn terminales sur le dernier deck (cf. `2-projets/2-projets.qmd:122-138`) — (a) « Ce que vous savez faire maintenant » miroir des objectifs, (b) « Et maintenant ? » pistes prochaines, (c) « Merci ! Questions ? » signatures + Q&A. Position absolue : survit même si la pépite « Saviez-vous que… » saute pour timing.
- **Réformulation côté apprenant** : sur les pages de bloc, sections « À la fin de ce bloc, vous saurez » (verbes infinitifs) plutôt que « Concepts clés » — promesse au début / validation à la fin via le wrap-up.

### What works well
- "Build something you'll actually use" framing motivates more than toy exercises
- Share-out slots after exercises (peer learning)
- Posit Cloud / codespaces as fallback for setup issues
- `chalkboard: true` for live annotation on slides
- Resources section as a curated "what to explore next" page

## Sources

- USCOTS 2023 (Theobold): <https://github.com/atheobold/uscots-quarto>
- Monash 2023 (Çetinkaya-Rundel): <https://github.com/mine-cetinkaya-rundel/quarto-monash>
