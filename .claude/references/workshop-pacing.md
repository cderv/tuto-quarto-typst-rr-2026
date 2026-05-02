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
- **No separate solution files** — the "Our turn" live coding IS the solution walkthrough
- All exercises bundled in a flat `exercises/` folder + `exercises.zip` download
- **Progressive**: later exercises build on earlier ones (Mine's Module 5 reuses everything)
- Exercise files are minimal: working code but bare structure — participants add the new concepts

## Structure Patterns

### File organization (Mine's pattern)
```
exercises/              # flat folder, all starter files
  hello-starwars.qmd
  rapport-starwars.qmd
exercises.zip           # bundled for download
N-module-name/
  index.qmd             # landing page (iframe + exercise download links)
  N-module-name.qmd     # RevealJS slides (short!)
```

### Slide deck structure
- Announce "My turn / Our turn / Your turn" rhythm at the start
- Each "Your turn" block has a countdown timer
- End each module with an iframe to the relevant Quarto docs page ("Learn more")
- Keep slides short — the live demo carries the teaching, not the slides

### What works well
- "Build something you'll actually use" framing motivates more than toy exercises
- Share-out slots after exercises (peer learning)
- Posit Cloud / codespaces as fallback for setup issues
- `chalkboard: true` for live annotation on slides
- Resources section as a curated "what to explore next" page

## Sources

- USCOTS 2023 (Theobold): <https://github.com/atheobold/uscots-quarto>
- Monash 2023 (Çetinkaya-Rundel): <https://github.com/mine-cetinkaya-rundel/quarto-monash>
