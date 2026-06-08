# Review pédagogique finale — Quarto+Typst RR 2026

**Date :** 2026-06-08 · **Commit :** `e1c9f3b` · **Référence :** reviews du 2026-06-05 (ciblée) et 2026-06-01 (dernière complète)

## Verdict général — PRÊT

Le workshop est **pédagogiquement prêt** pour le 16 juin et le dépôt peut être **ouvert publiquement**. L'arc `.qmd → PDF pro → livre → personnalisé/pérennisé` est tracé bout-à-bout et explicitement outillé pour l'animation (les 4 bascules B1–B4 du `pilotage.qmd`, chacune avec phrase-clé + filet « si non acquis »). Rythme My/Our/Your symétrique et codé visuellement de façon cohérente sur les deux blocs. **Aucun P0.** Un seul vrai accroc : une phrase factuellement fausse dans le `README` du starter Exo 2, qui se publie aussi sur la page exercice.

### 🔴 P0 — bloquant
Aucun.

### 🟠 P1 — à corriger avant le 16 juin

**P1-1. Contradiction factuelle sur `quarto render` sans `_quarto.yml` (Exo 2).**
`exercises/02-projet-book/starter/README.md:28` affirme « Sortie initiale (sans `_quarto.yml`) : 5 fichiers HTML séparés ». C'est **faux** : les 5 `.qmd` du starter n'ont aucune clé `format` (vérifié — ils commencent directement par `#`), donc `quarto render` sans `_quarto.yml` est un **no-op silencieux** (rien produit). C'est précisément le piège verrouillé ailleurs : `_speaker/demo-bloc2-our-turn.qmd:59-63` et `2-projets/index.qmd:149-151`. Ce README est **inclus sur la page exercice** (`2-projets/index.qmd:102`), donc l'erreur est publiée. Un participant en autonomie lance `quarto render`, ne voit rien, et croit à un bug d'installation — l'inverse de la boucle d'auto-correction visée.
**Fix :** « Sortie initiale (sans `_quarto.yml`) : **rien** — `quarto render` ne produit aucun fichier tant que le projet n'est pas déclaré. C'est l'objet de l'étape 1. »

### 🟡 P2 — nice-to-have

- **P2-1 (porté, atténué).** `2-projets/boussole.qmd:29` mentionne toujours un « bloc `format.typst.logo` custom » dont la syntaxe complète ne vit que dans `2-projets/index.qmd:126-137`. Moins grave désormais (renvoi explicite « Consigne complète → page exercice »). Non bloquant.
- **P2-2 (porté du 2026-06-01).** `1-quarto-typst/1-quarto-typst.qmd:341` — la pépite « Une charte, partout » (`brand_color_pluck`), la plus alignée avec le volet « pérennisé », reste en position 3/4 d'une slide désignée « premier fusible à couper » (`pilotage.qmd:65`). Filet existant via la note Exo 1 (`:331`) mais fragile ; la remonter en 1-2 sécuriserait le message.
- **P2-3.** Redondance `3-aller-plus-loin/index.qmd` vs `4-ressources.qmd` (partials, extensions, PDF/UA-1). La page « aller plus loin » n'est même pas au programme de la home (`index.qmd:25-31`). Toutes deux étiquetées « après l'atelier », donc pas de promesse non tenue ; à fusionner un jour.

### ✅ Forces pédagogiques confirmées

- **Arc outillé pour l'oral** : `pilotage.qmd:81-92` formalise les 4 bascules avec phrase-clé + filet — l'arc ne tient plus seulement par la mémoire de l'animateur.
- **Couture Exo 1 → Exo 2 traitée comme risque nommé** : `pilotage.qmd:108-113` + slide Pause (`1-quarto-typst.qmd:357`) + `_brand-starter.yml` de secours.
- **Boucle d'auto-correction robuste** : colonne « Vous devriez voir » sur chaque étape, escalier « Si vous bloquez » identique partout, pièges anticipés (PDF verrouillé Windows, bug gt « 1 7 5 », polices < v1.10.4).
- **Support Maëlle excellent** : zooms démo avec « Pièges à anticiper » comme aide-mémoire 1:1.
- **Charge cognitive identifiée** : `pilotage.qmd:100-106` nomme le pic (étapes 3-4 Exo 1 avant la pause) et dédramatise.
- **Rythme M/O/Y conforme et cohérent** slides ↔ pages ↔ boussoles.
- **Wrap-up protégé** : 3 slides obligatoires marquées « jamais coupé » (`pilotage.qmd:69`).

### Comptage : **0 P0 / 1 P1 / 3 P2.**

**C'est prêt.** Le seul correctif réellement souhaitable avant le 16 juin est P1-1 — une seule phrase dans `exercises/02-projet-book/starter/README.md:28`.
