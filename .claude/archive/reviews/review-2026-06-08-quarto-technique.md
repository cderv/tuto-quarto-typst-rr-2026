# Review technique Quarto+Typst — RR 2026 (finale avant ouverture publique)

- **Date** : 2026-06-08 · **Commit** : `e1c9f3b`
- **Env de test** : sandbox Linux, Quarto **1.9.36** (plancher stable, *pas* la pre-release 1.10.4+ recommandée). **R absent de cet environnement** → les rendus exécutant du R (exo1/exo2/test-install/site) n'ont **pas** pu être relancés ici. Link-audit, sync pkg, YAML/schémas et cohérence des seuils vérifiés directement.
- **Review précédente** : `review-2026-06-01-quarto-technique.md` (commit `0bfc299`, 0 P0 / 1 P1 / 3 P2).

## Verdict général

**Techniquement prêt pour l'ouverture publique et pour donner le workshop.** L'unique P1 précédent (date d'accueil mal formée) est **corrigé** : `index.qmd` n'a plus de `date:` local et hérite l'ISO `2026-06-16` du projet — vérifié dans `_site/index.html` (`<p class="date">16 juin 2026</p>`). Tous les invariants tiennent : `format: typst`, `_brand.yml` (`images:`+`medium:`), `font-paths` sous `format.typst`, cross-refs résolues, website `format: html`, conditional content mono-idiome, extensions compatibles 1.9.36. Seuils de version (R 4.1 / Quarto 1.9 min / 1.10.4 reco) et liste des 8 paquets R **alignés partout**. Sync `pkg/inst/` ↔ `exercises/` propre. Link-audit : toutes les URLs doc en 200. **0 P0, 0 P1, 2 P2** cosmétiques.

**Limite** : R indisponible ici → 3 PDF non re-confirmés. Mais (a) la review du 01-06 les a validés end-to-end sur 1.9.36, et (b) `git diff 0bfc299..HEAD` ne touche **aucun `.qmd` exécutant du R**.

## 🔴 P0 — bloquant
*Aucun.*

## 🟠 P1 — à corriger avant le 16 juin
*Aucun.* (Le P1-1 précédent — date d'accueil — est corrigé.)

## 🟡 P2 — nice-to-have
- **P2-1 — `_brand-empire.yml` ≡ `_brand.yml` (correction exo2)** : `diff` vide. Voulu (Empire = défaut, `imperial-red` en `primary`), mais qui teste `brand: _brand-empire.yml` au Bonus 3 ne voit aucun changement → confusion. jedi/mando diffèrent bien. Suggestion : une phrase dans le callout Bonus 3 (`2-projets/index.qmd`).
- **P2-2 — `preparatifs.qmd:54`** affiche « Quarto 1.10.7 » dans l'exemple de sortie `verifier_installation()` — plausible (pre-release) mais en avance sur le « 1.10.4+ » du même fichier. Cosmétique ; harmoniser sur `1.10.4` si on veut être strict.

## ✅ Choix techniques validés (vérifiés ce jour)
- **Zéro anti-pattern `format:`** ; les `orange-book` restants = prose descriptive correcte.
- **`font-paths`** sous `format.typst:` partout, jamais sous `book:` ni top-level.
- **`_brand.yml` conforme** : `palette` + `primary/foreground/background` ; `fonts` liste de dicts ; `logo.images.<id>` + `logo.medium`. exo1 ≡ exo2.
- **`_brand-starter.yml` ≡ correction `_brand.yml`** (`diff` vide). **`_brand-offline.yml`** : vraie diff (Inter google→file + 3 TTF).
- **`type: book` vs `default`** net ; pas de chapitre fantôme ; `index.qmd` = `# Préface {.unnumbered}`.
- **Cross-refs résolues** ; `lang: fr` partout.
- **`execute:`** homogène starter↔correction↔test-install.
- **Website** : toutes pages `format: html` explicite ; internes avec `author:""`+`date:""`.
- **Slides** : 2 decks avec `engine: markdown` + `filters:[typst-render]` + `package-path:/_typst-packages` + `output-directory: typst-figures`.
- **Extensions compatibles 1.9.36** : clean 1.4.1, typst-render 0.17.0, countdown 0.6.0, fontawesome 1.3.0.
- **Seuils alignés** : R 4.1.0, Quarto 1.9/1.10.4, 8 paquets identiques.
- **pkg/inst sync propre** : tous `diff` vide.
- **justfile / profiles** : `all = charte exos pkg-sync pkg-site site` cohérent.
- **Liens** : link-audit → toutes URLs doc en 200.

## Comptage
**0 P0 / 0 P1 / 2 P2 → Go pour ouverture publique et workshop.**

## À refaire idéalement sur une machine avec R + Quarto 1.10.4+
- `just all` complet ; re-confirmer les 3 PDF ; `R CMD check` du paquet (0 ERROR attendu).
