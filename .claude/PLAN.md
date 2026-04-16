# Workshop Preparation Plan

Workshop: "PDF sans frictions : Typst dans vos projets Quarto"
Event: Rencontres R 2026, 16 juin, Nantes — 2h tutorial

## Decision log

- 2026-04-07: Decided to reorganize around "My turn / Our turn / Your turn" format
- 2026-04-07: Reframed Bloc 1 entry point: "you have a doc, you want PDF" (not "switch from LaTeX")
- 2026-04-07: Created topic store with CORE/DEMO/MENTION/STORE triage of all 55 topics
- 2026-04-07: Target ratio ~30 min slides + 30 min live demo + 45 min exercises
- 2026-04-16: Restructured from 3 blocs to 2 blocs + pépites (nuggets)
- 2026-04-16: Bloc 3 content disseminated into Blocs 1 and 2 as "Saviez-vous que..." slides
- 2026-04-16: brand.yml moved to Bloc 1 (single presentation, reused in Bloc 2 exercise)
- 2026-04-16: Exercise timers set to 15:00 / 15:00
- 2026-04-16: Mode markers use Quarto callouts (callout-tip for Our turn, callout for Your turn, callout-note for pépites)

## Current structure (implemented 2026-04-16)

### Bloc 1 — Un PDF pro en quelques minutes (~40 min)
- **My turn (~7 min):** intro rythme, format:typst, options, keep-typ, _brand.yml — 5 slides
- **Our turn (~10 min):** démo live — add typst, options, create brand, keep-typ — 1 callout slide
- **Your turn (~15 min):** exercice 1 — 1 exercise slide
- **Pépites (~3 min):** raw Typst, CSS→Typst, pdf-standard:ua-1 — 1 note slide

### Bloc 2 — Passer à l'échelle : projet et livre (~40 min)
- **My turn (~5 min):** _quarto.yml, type:book + orange-book — 2 slides
- **Our turn (~10 min):** démo live — create book, apply brand, content-visible — 1 callout slide
- **Your turn (~15 min):** exercice 2 + fallback _brand.yml — 1 exercise slide
- **Pépites (~3 min):** template partials, extensions, community formats — 1 note slide

### Totaux
- 13 slides total (was 55)
- ~90 min planned, ~30 min margin on 2h

## Content reorganization — DONE

- [x] Discuss topic store triage with Maëlle (what stays CORE, what gets cut)
- [x] Trim Bloc 1 slides: keep format:typst, basic options, keep-typ, brand basics
- [x] Trim Bloc 2 slides: keep _quarto.yml, book, orange-book — cut Marginalia, typst-gather
- [x] Bloc 3 disseminated: raw Typst → pépite B1, partials/extensions → pépite B2, rest → Ressources
- [x] Add "My turn / Our turn / Your turn" rhythm markers to slides (callouts)
- [x] Move STORE topics to resources page
- [x] Update Bloc 1 framing: "you have a doc, you want PDF" not "LaTeX bad"

## Fixes — DONE

- [x] Fix Bloc 3 missing accents (entire file rewritten)
- [x] Fix "A vous !" → "À vous !" in Blocs 2 and 3
- [x] Fix "Fini la répétition" → "Finie" in Bloc 2
- [x] Standardize callout syntax across decks
- [x] Fix raw `{=typst}` block in Bloc 3 used for display

## Exercise materials — TODO

- [ ] Create `exercises/` folder structure
- [ ] Create `rapport-penguins.qmd` starter file (Exercise 1)
- [ ] Create Exercise 2 starter files (book project)
- [ ] Create `_brand.yml` fallback template for Exercise 2
- [ ] Bundle as `exercises.zip` for download
- [ ] Update all `(#)` placeholder links in index pages and preparatifs.qmd

## Live demo scripts — TODO

- [ ] Write Bloc 1 demo script: add typst, options, create brand, keep-typ
- [ ] Write Bloc 2 demo script: create book project, apply brand, content-visible

## Documentation updates — DONE

- [x] Update `.claude/references/project-context.md` after slide reorganization
- [x] Update `.claude/PLAN.md` with new structure
- [x] Resources page enriched with all STORE topics + ex-Bloc 3 content

## Pre-workshop logistics — TODO

- [ ] Test full workshop flow end-to-end (setup → exercises → wrap-up)
- [ ] Test exercises on a clean machine
- [ ] Prepare Posit Cloud workspace as fallback
- [ ] Confirm exercise timing with dry run
- [ ] Pre-render demo outputs as backup screenshots

## References

- Plan de restructuration détaillé: `/root/.claude/plans/wiggly-mixing-giraffe.md`
- Topic store: `.claude/references/topic-store.md`
- Pacing guidelines: `.claude/references/workshop-pacing.md`
- Project context: `.claude/references/project-context.md`
