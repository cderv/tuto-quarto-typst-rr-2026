# Review orthographe / typographie FR — Workshop Quarto+Typst RR 2026 (2026-06-08)

**Périmètre couvert :** pages du site (`index.qmd`, `preparatifs.qmd`, `1-quarto-typst/`, `2-projets/`, `3-aller-plus-loin/`, `4-ressources.qmd`, boussoles), les 2 decks de slides, exercices (starters + corrections + READMEs), et les messages `cli` du paquet R (`pkg/R/*.R`).
**Hors périmètre :** `README.md` racine, `.claude/`, notes presenter `::: {.notes}`, dossier généré `pkg/inst/exercices/`.

## Verdict général

Qualité de langue **largement au niveau workshop pro** — le dépôt peut être ouvert publiquement tel quel. Prose en français soigné, vouvoiement uniforme dans tout le contenu participant (seul tutoiement résiduel = `_speaker/`, hors périmètre et légitime). Aucun anglicisme évitable en prose, aucune coquille, aucun doublon, accents/accords corrects. Les termes anglais subsistants (`brand`, `heading`, `render`, `book`, `keep-typ`…) sont tous des clés YAML, commandes ou noms d'API. **Aucun problème bloquant ni important.** Feu vert.

## 🔴 P0 — bloquant
Néant.

## 🟠 P1 — à corriger avant le 16 juin
Néant.

## 🟡 P2 — nice-to-have (cosmétique)

**1. Incohérence « paquet » vs « package » entre fichiers.** La version FR « paquet » est utilisée dans `preparatifs.qmd`, `4-ressources.qmd` et **tous** les messages `cli` du paquet. Mais « package » subsiste ailleurs :
- `2-projets/index.qmd:200` — « Le **package** R `brand.yml` lit votre charte… »
- `2-projets/index.qmd:204` — « Ce bonus suppose les **packages** `brand.yml` et `prismatic`… »
- `exercises/02-projet-book/starter/annexe-donnees.qmd:4` + `correction/annexe-donnees.qmd:4` — « livré avec le **package** R `{dplyr}` »
- `4-ressources.qmd:83` — « `brand.yml` **package** »
- `1-quarto-typst/1-quarto-typst.qmd:238` — note presenter, à la limite du périmètre

Proposition : harmoniser sur « paquet R ». Décision purement éditoriale.

**2. Apostrophes ASCII dans des titres YAML — auto-corrigé, ne pas toucher.** `rapport-starwars.qmd:2`, `test-install.qmd:2`. Apostrophe droite convertie en sortie par Pandoc/Typst + `lang: fr` + smart quotes. Signalé pour mémoire.

## ✅ Forces linguistiques
- **Vouvoiement parfait** dans tout le contenu participant.
- **Aucun anglicisme évitable en prose** : « charte », « références croisées », « squelette d'extension », « polices ».
- **Typographie FR correcte** : guillemets « … » systématiques, pas de `"…"` anglais en prose.
- **Formes longues « Figure 1.1 » / « Table 1.1 »** correctes.
- **Aucun doublon** ; aucun faux-ami détourné.
- **Messages `cli` du paquet R** : français impeccable, lexique figé et cohérent, pluriels `cli` corrects.
- **Cohérence des néologismes** : « hors-ligne » avec trait d'union partout.

## Comptage
**P0 = 0, P1 = 0, P2 = 2** (incohérence paquet/package entre fichiers ; apostrophes ASCII en titres YAML auto-corrigées au rendu). Aucune action requise avant l'ouverture.
