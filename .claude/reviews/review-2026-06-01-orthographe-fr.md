# Review orthographe & typographie française — RR 2026

**Date :** 2026-06-01 · **Commit de base :** `0bfc299`

> ⚠️ **Note de capture :** lors du run, le tool `Write` de l'agent a été refusé (permission, depuis corrigée dans `.claude/settings.json`). Le rapport détaillé ligne-à-ligne n'a pas pu être sauvegardé. Ce fichier reprend la **synthèse détaillée** retournée au thread principal (verdict, P1 complets, P2 listés). Pour le détail exhaustif, relancer l'agent `workshop-reviewer-fr`.

## Verdict général

Qualité rédactionnelle **au niveau workshop pro**. Zéro faute d'orthographe, zéro accord fautif, zéro coquille (grep doublons vide). Vouvoiement parfait sur toutes les surfaces participants (les « tu » résiduels sont dans des notes `:::{.notes}`, hors périmètre). Formes longues FR (« Figure 1.1 », « Annexe A ») et guillemets français bien employés. Le sweep terminologique précédent tient bien ; les findings restants sont des finitions localisées. **Prêt pour le 16 juin, rien de bloquant.**

**Comptage : 0 P0 / 2 P1 / 6 P2.**

## 🔴 P0

Aucun.

## 🟠 P1

**P1-1 — Incohérence « dataset » vs « jeu de données ».**
L'Exo 1 dit « jeu de données », mais tout le Bloc 2 + la charte disent « dataset » (6 occurrences visibles, dont un titre d'annexe et le rendu PDF). À harmoniser sur « jeu de données ».

**P1-2 — Grappe d'anglicismes dans le Bloc 2.**
`2-projets/index.qmd` (bonus 3/4) : « swapper », « pattern », « styling brand » (dont un alt-text), « typo », « verbatim », « fallback ». Zone visiblement ajoutée après le sweep terminologique.

## 🟡 P2

- **Guillemets droits vs `« »`** : la citation « Vous devriez voir » apparaît 4× en `"…"` au lieu de `« … »`, plus quelques termes dans `3-aller-plus-loin/index.qmd` — incohérent avec le reste du site.
- « Espece » / « Planete » sans accent (workaround gt→Typst commenté en Exo 1 mais pas en Exo 2 → ambiguïté).
- « hors-ligne » → « hors ligne ».
- Ponctuation `):` en cascade dans `4-ressources.qmd:43`.
- (+ 2 finitions mineures — détail exhaustif perdu avec le rapport complet, relancer l'agent si besoin.)

## ✅ Forces

Orthographe et accords irréprochables ; vouvoiement homogène côté participants ; typographie française (formes longues, guillemets) globalement maîtrisée ; le sweep terminologique antérieur a tenu.
