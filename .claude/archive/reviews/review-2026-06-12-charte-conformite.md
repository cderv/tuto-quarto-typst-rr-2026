# Review — Conformité Correction Exo 1 ↔ Charte graphique Star Wars

> Date : 2026-06-12 · Type : conformité charte (source de vérité)
> Périmètre : `_charte/` (SoT) vs `exercises/01-document-typst/correction/`
> Méthode : lecture intégrale charte + les trois `_brand.yml`, diff YAML, rendu Typst des deux documents (`.typ` + PNG), comparaison visuelle.
> (Rédigée par l'agent technique de conformité, reportée sur disque par l'orchestrateur — Write refusé pour l'agent.)

## Verdict général

**La correction de l'Exercice 1 est conforme à la charte.** Les deux `_brand.yml` (charte et correction) sont **rigoureusement identiques** sur palette, rôles, polices et logo — seule différence : l'ajout du poids `700` à Inter dans la correction (besoin réel de gras). Le rendu Typst des deux documents émet **exactement les mêmes** règles `#show heading` et `#show link`.

**L'hypothèse « titres noirs dans la correction = divergence à corriger en `headings.color: imperial-red` » est INFIRMÉE.** La charte ne colore pas ses headings non plus : `_charte/_brand.yml:22` a `headings: "Star Jedi"` **sans** `color`. Le rouge visible dans le PDF de charte vient uniquement de deux `#text(... fill: rgb("#BC1E22"))` **inline décoratifs** (bandeau-titre « CHARTE GRAPHIQUE » `charte-starwars.qmd:26` et échantillon de police « THE SAGA AWAKENS » `qmd:70`) — c'est une **vitrine de la police**, pas une prescription du moteur `_brand.yml`. Colorer les headings de la correction introduirait une divergence là où il n'y en a pas et casserait l'arc Bloc 1→Bloc 2 (`1-quarto-typst/index.qmd:62`).

**Aucun correctif requis** sur `correction/_brand.yml` ni `correction/rapport-starwars.qmd`.

## Tableau de divergences (trié par sévérité)

| Aspect | Charte prescrit | Correction fait | Sévérité |
|---|---|---|---|
| Palette (4 hex) | imperial-red/sw-black/sw-cream/sw-yellow (`_charte/_brand.yml:3-6`) | Identique | ✅ |
| Rôles | primary/foreground/background (`:7-9`) | Identique | ✅ |
| Couleur titres | `headings: "Star Jedi"` **sans color** → NOIRS (`:22`). Rouge = `#text` inline décoratif | idem → NOIRS | ✅ fidèle |
| Police titres | Star Jedi `source: file` w400 (`:13-17`) | Identique | ✅ |
| Police corps | Inter google `[400,600]`, `base: Inter` (`:18-21`) | Inter `[400,600,700]` | 🟡 non-bug (gras) |
| Liens | rouge via mapping auto `primary`→linkcolor | rouge (`.typ` `#show link ... #bc1e22`) | ✅ |
| Logo | `logo.images.sw-star` + `medium` (`:24-29`) | Identique | ✅ |
| Lien prose `[documentation]` | n/a | présent (`correction/...:74`), = starter | ✅ |

Aucune ligne 🔴 ni 🟠.

## Réponse : la charte a-t-elle des liens rouges ?

**Pas de lien hypertexte cliquable dans la charte** (`grep ](http` = 0). Mais la charte **prescrit** les liens rouges via `primary: imperial-red` → mappé automatiquement par Quarto vers `linkcolor` Typst (jamais vers `heading-color`). **La correction a un lien en prose, et il est rouge** (`correction/rapport-starwars.qmd:74`, identique au starter). → Oui, liens rouges, conforme. Rien à toucher.

## Liste des modifications à faire : AUCUNE

La correction est 100% conforme.
1. ~~`typography.headings.color: imperial-red`~~ — **NE PAS FAIRE** : la charte ne le fait pas, ce serait créer une divergence + casser l'arc Bloc1→Bloc2.
2. Poids Inter `700` — laisser (besoin de gras).

## Note annexe (wording de page, hors conformité correction)

`1-quarto-typst/index.qmd:37` dit encore « → titres et liens colorés » alors que seuls les liens le sont — imprécision déjà relevée dans les reviews demo-our-turn. La ligne détaillée `index.qmd:62` (titres restent noirs) est exacte côté correction.

**Bilan : 0 🔴 / 0 🟠 / 1 🟡 (non-bug) — correction conforme, aucune modification requise.**
