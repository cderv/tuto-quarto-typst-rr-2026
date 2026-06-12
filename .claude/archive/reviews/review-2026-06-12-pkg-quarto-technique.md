# Review technique — Paquet R `tutoquartotypst` (vérification d'assertions)

> Date : 2026-06-12 · Type : quarto-technique · Périmètre : `pkg/` uniquement
> Méthode : lecture source + exécution R légère (parsing constantes, `.brand_generique()`, `sync-exercices.R --check`). `R CMD check`/`devtools::test()` non lancés (testthat absent — non bloquant).
> (Rédigée par l'agent technique, reportée sur disque par l'orchestrateur — Write refusé pour l'agent.)

## Verdict : OK — paquet sain et fidèle à ses assertions

Seuils de version exacts et alignés (`preparatifs.qmd`, DESCRIPTION, CLAUDE.md) ; logique `< .quarto_fix ⇒ workaround` correcte aux bornes (vérifiée par exécution) ; 8 prérequis, 20 fonctions exportées (NAMESPACE = pkgdown = Rd), synchro `inst/` ↔ `exercises/` (`--check` = `[OK]`) cohérents. Logique métier conforme au code. **P0 = 0 · P1 = 1 · P2 = 3.**

## 🟠 P1

- **P1-1 — `pkg/dev/packages.json` référencé mais inexistant — FAUX.** CLAUDE.md et `pkg/dev/` affirment « packages.json prêt » → le fichier n'existe pas (`pkg/dev/` = `PUBLICATION-r-universe.md`, `README.md`, `TESTS-MANUELS.md`).
  - `PUBLICATION-r-universe.md:22` lien `[…](packages.json)` → cible morte
  - `PUBLICATION-r-universe.md:104` table le liste comme présent
  - `README.md:6-12` section `## packages.json` le décrit comme existant
  - Atténuation : le JSON exact est **inliné** dans `PUBLICATION-r-universe.md:24-32` (récupérable). Impact pratique limité (procédure mainteneur). → Créer le fichier, ou retirer lien/table/section.

## 🟡 P2

- **P2-1** — Nom de repo erroné en prose : `PUBLICATION-r-universe.md:48,86` écrivent `cderv-tuto-quarto-typst-rr-2026` (tiret) au lieu de `cderv/tuto-quarto-typst-rr-2026` (slash). URLs et `gh repo create` corrects. Cosmétique.
- **P2-2** — « 105 tests » (`TESTS-MANUELS.md:3`) : on compte 85 blocs `test_that()`. Le 105 désigne vraisemblablement les assertions `expect_*` (non re-vérifiable, testthat absent). Plausible.
- **P2-3** — `typst.R:31` et `brand.R:151` : `reco <- as.character(.quarto_fix)` (1.10.4). Sémantiquement correct (le seuil `font-paths` est bien `.quarto_fix`) mais le nom `reco` prête à confusion avec `.quarto_reco` (1.10.7). Comportement juste, nommage trompeur.

## ✅ Validé (contre la source)

- **Seuils version — VRAIS, alignés** (`utils.R:16-19`) : R 4.1.0 ↔ DESCRIPTION ↔ `preparatifs.qmd:53` ; Quarto min 1.9 / reco 1.10.7 / fix 1.10.4 ↔ PR #14517. Logique exécutée aux bornes : `1.10.3 < fix`=TRUE, `1.10.4 < fix`=FALSE, `1.9 >= min`=TRUE. `verifier_quarto()` (`checks.R:70-92`) classe correctement < 1.9 danger / 1.9–1.10.3 warning / 1.10.4–1.10.6 succès / ≥ 1.10.7 recommandée.
- **8 prérequis — VRAI** : `.paquets_requis` (`utils.R:22-25`) = `preparatifs.qmd:91` = Imports.
- **Corrections — VRAI** : `installer_exercices()` starters only (`exclure="correction"`, `installer-exercices.R:81-85,216`) ; `recuperer_correction()` confirmation+force (`correction.R:90-103`) ; `ouvrir_correction()` URL `…/tree/main/exercises/<exo>/correction` sur le bon repo.
- **Synchro inst/ ↔ exercises/ — VRAI** : `--check` = `[OK]`. Renommage `exercises/`→`inst/exercices/`. Templates brand + 3 Inter byte-identiques aux sources.
- **`.brand_generique()` — VRAI** ; **`valider_brand()` — VRAI** (`logo.medium` validé contre `names(logo.images)`) ; **`basculer_hors_ligne()`/`appliquer_polices_locales()` — VRAI** (bloc Inter `source:file` 400/600/700 = `_brand-offline.yml`, `font-paths` injecté = celui de l'exo 2, rollback présent).
- **Format/structure** : `test-install.qmd` `execute: echo/warning/message: false` ; aucun `format: orange-book-typst`/`extend:` ; `creer_projet_typst()` écrit `format: typst`.
- **Métadonnées** : 20 export NAMESPACE = 20 pkgdown = 20 Rd. `inst/` ships ; `dev/`/`data-raw/`/`vignettes/articles` exclus du tarball.
- **R CMD check (non exécuté)** : WARNING non-ASCII certain, NOTE Imports plausible (assumés). Aucun anti-pattern R (guards `is_interactive()` partout où `menu()`/`readline()`/`rstudioapi`).
