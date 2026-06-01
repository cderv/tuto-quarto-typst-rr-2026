# Review « élève débutant·e Quarto » — RR 2026

**Date :** 2026-06-01 · **Commit de base :** `0bfc299`

> ⚠️ **Note de capture :** lors du run, le tool `Write` de l'agent a été refusé (permission, depuis corrigée dans `.claude/settings.json`). Le rapport détaillé ligne-à-ligne rédigé par l'agent n'a pas pu être sauvegardé et n'est pas récupérable. Ce fichier reprend la **synthèse détaillée** retournée au thread principal (verdict, P1 complets, P2 partiels). Pour le détail exhaustif, relancer l'agent `workshop-reviewer-debutant`.

## Verdict général

**Un·e débutant·e peut suivre le 16 juin sans blocage dur.** Le parcours est bien balisé : boussoles + countdown, escalier d'autonomie, indices doc en collapse, colonne « Vous devriez voir », modèle `_quarto.yml` copiable, fallback `_brand-starter.yml` si l'Exo 1 est raté. Préparatifs solides : test-install end-to-end et Plan B offline détaillé.

**Comptage : 0 P0 / 3 P1 / 5 P2.**

## 🔴 P0

Aucun.

## 🟠 P1

**P1-1 — Exo 2 étape 1 : piège silencieux.**
`exercises/02-projet-book/starter/01-anatomie.qmd:43` référence `@sec-origines` (section d'un autre fichier). En `type: default` (rendu isolé de l'étape 1), ça sort en `?@sec-origines` + warning à la compilation ; ça ne se résout qu'à l'étape 2a (`type: book`). Non annoncé comme normal côté participant → panique probable de ~5 min. **Fix :** prévenir explicitement dans la consigne de l'étape 1 que la référence croisée non résolue est normale à ce stade.

**P1-2 — Lien mort.**
`2-projets/index.qmd:181` pointe vers une section « Bonus 3 » du README de l'exercice 2 (`#bonus-3--changer-de-palette-star-wars`) qui n'existe pas → l'ancre tombe en haut de page. **Fix :** créer la section dans le README (ou corriger la cible).

**P1-3 — Charte Bloc 1 : chemin contradictoire.**
`1-quarto-typst/index.qmd:58` dit « dans le starter » mais le lien va vers `/_charte/charte-starwars.pdf` (racine site). Les deux fichiers existent → ambigu plutôt que cassé. **Fix :** lever la contradiction dans le libellé.

## 🟡 P2 (5, partiellement capturés)

- Quelques points de friction mineurs autour des chemins/copies de fichiers et de la formulation d'étapes (détail exhaustif perdu avec le rapport complet — relancer l'agent si besoin).

## ✅ Ce qui me rassure

- Le test-install + la section « Si ça échoue » qui dédramatise les erreurs.
- Le bug `gt` « 1 7 5 » anticipé avec son workaround marqué « non bloquant ».
- L'indépendance Bloc 2 / Bloc 1 répétée partout, slides révisables sans les notes presenter.
- Le modèle `_quarto.yml` complet avec le bloc `logo:` commenté (explique le *pourquoi* du chevauchement).
