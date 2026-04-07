# Workshop Preparation Plan

Workshop: "PDF sans frictions : Typst dans vos projets Quarto"
Event: Rencontres R 2026, 16 juin, Nantes — 2h tutorial

## Decision log

- 2026-04-07: Decided to reorganize around "My turn / Our turn / Your turn" format
- 2026-04-07: Reframed Bloc 1 entry point: "you have a doc, you want PDF" (not "switch from LaTeX")
- 2026-04-07: Created topic store with CORE/DEMO/MENTION/STORE triage of all 55 topics
- 2026-04-07: Target ratio ~30 min slides + 30 min live demo + 45 min exercises

## Content reorganization

- [ ] Discuss topic store triage with Maëlle (what stays CORE, what gets cut)
- [ ] Trim Bloc 1 slides: keep format:typst, basic options, keep-typ, brand basics
- [ ] Trim Bloc 2 slides: keep _quarto.yml, book, orange-book — cut Marginalia, typst-gather
- [ ] Trim Bloc 3 slides: keep raw Typst concept + partials concept — cut deep dives
- [ ] Add "My turn / Our turn / Your turn" rhythm markers to slides
- [ ] Move STORE topics to resources page or appendix slides
- [ ] Update Bloc 1 framing: "you have a doc, you want PDF" not "LaTeX bad"

## Fixes needed

- [ ] Fix Bloc 3 missing accents (pervasive — entire file needs accent restoration)
- [ ] Fix "A vous !" → "À vous !" in Blocs 2 and 3
- [ ] Fix "Fini la répétition" → "Finie" in Bloc 2
- [ ] Standardize callout syntax across all 3 decks
- [ ] Verify Quarto 1.9 claims: orange-book auto-activation, theorem-appearance styles, logo sub-options, Typst version
- [ ] Fix raw `{=typst}` block in Bloc 3 used for display (should be fenced code block)

## Exercise materials

- [ ] Create `exercises/` folder structure
- [ ] Create `rapport-penguins.qmd` starter file (Exercise 1: add format:typst + brand)
- [ ] Create Exercise 2 starter files (book project)
- [ ] Create Exercise 3 starter files (template partials — optional exercise)
- [ ] Create `_brand.yml` example for exercises
- [ ] Create `typst-show.typ` and `typst-template.typ` for Exercise 3
- [ ] Bundle as `exercises.zip` for download
- [ ] Update all `(#)` placeholder links in index pages and preparatifs.qmd

## Live demo scripts

- [ ] Write Bloc 1 demo script: add typst to a doc, create brand, enable keep-typ
- [ ] Write Bloc 2 demo script: create book project, apply brand, render
- [ ] Write Bloc 3 demo script: add a partial, modify footer

## Documentation updates

- [ ] Clean up README: move "Questions pour Maëlle" and "Points à discuter" to a GitHub issue
- [ ] Update `.claude/references/project-context.md` after slide reorganization
- [ ] Update `.claude/CLAUDE.md` if conventions change
- [ ] Update workshop-content skill if slide structure changes

## Pre-workshop logistics

- [ ] Test full workshop flow end-to-end (setup → exercises → wrap-up)
- [ ] Test exercises on a clean machine (no pre-existing Quarto/R config)
- [ ] Prepare Posit Cloud workspace as fallback for setup issues
- [ ] Confirm exercise timing with dry run

## References

- Topic store: `.claude/references/topic-store.md`
- Pacing guidelines: `.claude/references/workshop-pacing.md`
- Project context: `.claude/references/project-context.md`
