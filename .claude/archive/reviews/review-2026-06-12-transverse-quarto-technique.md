# Review technique — Pages transverses (vérification d'assertions)

> Date : 2026-06-12 · Type : quarto-technique · Périmètre : `preparatifs.qmd`, `index.qmd`, `4-ressources.qmd`, `_quarto*.yml`, `justfile` (hors Bloc 1/2)
> Méthode : lecture source + doc Quarto (context7) + smoke test `quarto render --profile pretuto` (exit 0). Réseau non testé.
> (Rédigée par l'agent technique, reportée sur disque par l'orchestrateur — Write refusé pour l'agent.)

## Verdict : OK — assertions transverses solides et cohérentes

Seuils de version alignés sur 4 sources, 8 paquets R exacts, claims Typst 1.9 vérifiés, profil `pretuto` rend proprement. **0 P0 · 0 P1 · 3 P2.**

## 🟡 P2 — imprécisions / robustesse

- **P2-1** — `4-ressources.qmd:51` orange-book « intégré à Quarto 1.9 pour les projets book » : VRAI mais imprécis. Extension bundlée, auto-activée sur `project.type: book` en Typst (package `orange-book:0.7.1`). Le format long documenté est `format: orange-book-typst` — rester sur `type: book` auto-activé dans les supports. Le faux-ami `format: orange-book` n'apparaît nulle part (vérifié).
- **P2-2** — `4-ressources.qmd:76` `brand-mode: dark` : VRAI, mais feature présente depuis Quarto **1.7** (pas 1.9). La ligne ne la date pas → pas d'erreur ; signalé car entourée de claims « 1.9 ». Clé correcte.
- **P2-3** — CLAUDE.md décrit `just all` = `charte + exos + site` (forme courte) alors que `justfile:10` = `charte exos pkg-sync pkg-site site` (5 recettes). IMPRÉCIS — CLAUDE.md donne pourtant la forme exacte plus bas. Incohérence interne de la doc projet.

## ✅ Assertions vérifiées VRAIES (preuves clés)

- **Seuils version alignés** : `preparatifs.qmd:83-84,133` ↔ `pkg/R/utils.R:16-19` (`.quarto_min 1.9`, `.quarto_fix 1.10.4`, `.quarto_reco 1.10.7`, `.seuil_r 4.1.0`) ↔ `pkg/DESCRIPTION` (`R >= 4.1`, `Quarto >= 1.9.0`) ↔ CLAUDE.md.
- **8 paquets R** : `preparatifs.qmd:91` = `pkg/R/utils.R:22-25` `.paquets_requis`. Imports DESCRIPTION = ces 8 + infra.
- **Typst bundlé** : DESCRIPTION + `preparatifs.qmd:158`. VRAI.
- **Éditeurs** : `preparatifs.qmd:86` RStudio bundle Quarto / Positron embarque 1.9 + override `quarto.path`. Cohérent.
- **Profils** : `_quarto.yml:57-59` group `[[tuto,pretuto]]` → tuto défaut. `_quarto-tuto.yml:2-7` glob + `!exercises/` + `!pkg/`. `_quarto-pretuto.yml:4-6` liste explicite (index+preparatifs), sidebar pretuto ne référence que ces 2 pages → aucun lien mort. `index.qmd` `when-profile` masque les liens non rendus en pretuto. Smoke test `--profile pretuto` → exit 0.
- **`resources:` + gitignore** : `_quarto.yml:3-8` (`exercises/**`, `package/**`) ; `.gitignore:7-23` ignore artefacts mais `resources` copie depuis disque → corrections/`_book/`/`typst-figures/`/`package/` publiés après `just all`. VRAI.
- **justfile** : `all:10` ordre correct (charte→exos→pkg-sync→pkg-site→site) ; `exos:21-29` ne rend que les `correction/` ; `publish:84` dépend de `all`. VRAI.
- **Pages web** : `format: html` + `author:""`/`date:""` (sauf index.qmd, sans héritage problématique). VRAI.
- **Liens GitHub** : tous sur `cderv/tuto-quarto-typst-rr-2026`, exercices vers `tree/main/exercises/`. VRAI.
- **Features Typst 1.9 (context7)** : `theorem-appearance` VRAI ; `pdf-standard: ua-1` VRAI ; `linkcolor/codefont/mathfont`. Limitation « books pas encore PDF/UA-1 » plausible.
- **Test chaîne + warnings polices** : `preparatifs.qmd:151-159` issues #12556 (font fallback) et #11683 (« 1 7 5 », corrigé par `gt::opt_table_font()`) distinguées correctement.
- **Locale UTF-8** : `preparatifs.qmd:141` diagnostic `l10n_info()[["UTF-8"]]` correct.
- **Doc-mapping** : URLs `4-ressources.qmd` cohérentes avec `doc-mapping.md` (ancres à re-vérifier au J16 via `audit-doc-links.sh`).

## Non vérifié (raison)
- Réseau non testé (liens/téléchargements).
- `just all` complet non lancé (nécessite pkgdown/ragg/fonts) — seul `--profile pretuto` rendu.
- Bornes RStudio/Positron `2026.05` non vérifiables hors réseau.
