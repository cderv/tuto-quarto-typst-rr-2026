# Review — élève débutant·e — 2026-06-08

**Profil :** R/RStudio depuis 2-3 ans, R Markdown occasionnel, jamais touché Quarto en projet ni Typst. Commit de référence : `e1c9f3b`.

## Verdict général

Oui, je m'en sors le 16 juin. Le parcours est clair, bien découpé, et les filets (boussole, indices doc, « Si vous bloquez », correction) sont rassurants. Les préparatifs sont solides : le paquet compagnon + `test-install.qmd` me font valider ma chaîne **avant** d'arriver, et les avertissements `unknown font family` sont documentés à l'avance. Le seul vrai trou côté débutant : **le bug gt « 1 7 5 » va probablement me tomber dessus à l'Exercice 1 étape 3, et l'exo 1 n'en parle nulle part** (le callout existe seulement sur la page Bloc 2). C'est mon unique point qui risque de me coûter 5-10 min de débogage silencieux. Le reste est nice-to-have.

**Comptage : P0 = 0 · P1 = 1 · P2 = 4**

## 🔴 P0 — bloquant
Aucun.

## 🟠 P1 — à corriger avant le 16 juin

**P1-1 — Le bug gt « 1 7 5 » n'est documenté QUE sur le Bloc 2, alors qu'il frappe dès l'Exercice 1 étape 3.**
`1-quarto-typst/index.qmd:62` (étape 3) me fait créer `_brand.yml` avec Inter et annonce « police corps Google (Inter) appliquée ». Le tableau du starter produit « 1 358 » pour Jabba (`exercises/01-document-typst/starter/rapport-starwars.qmd:39` + ligne 50). Or la correction applique explicitement le contournement : `exercises/01-document-typst/correction/rapport-starwars.qmd:49-50` (`opt_table_font(font = "Inter")`). Dès l'étape 3, je vais donc très probablement voir **« 1 3 5 8 »** — le symptôme du callout… qui est sur l'**autre** page (`2-projets/index.qmd:171-175`), que je n'ai aucune raison d'avoir ouverte au Bloc 1. Vérifié : `opt_table_font` / `1 7 5` / `11683` n'apparaissent nulle part dans `1-quarto-typst/index.qmd`, le starter exo1, ni son README.
*Fix :* ajouter sur la page Bloc 1 (ou dans le starter) un mini-callout « si vous voyez 1 3 5 8 → `opt_table_font(font = "Inter")` », ou une note dans la colonne « Vous devriez voir » de l'étape 3.

## 🟡 P2 — nice-to-have

- **P2-1** — Jargon non défini (`3-aller-plus-loin/index.qmd:26` « partials », `4-ressources.qmd:52` « Marginalia », « front-matter »/« layout »). Pages post-workshop explicitement hors séance, donc non bloquant.
- **P2-2** — Étape 3 exo1 : double source pour la charte, `[/_charte/charte-starwars.pdf]` **et** « dans le starter » (`1-quarto-typst/index.qmd:62`). Les deux fichiers existent, mais le double pointeur fait hésiter une seconde.
- **P2-3** — Exo1 → Exo2 : pas de continuité de fichiers (dossiers séparés), bien annoncé, mais un débutant pressé peut chercher où est passé son travail de l'exo1. Une phrase « l'exo 2 est un dossier neuf » dans la boussole aiderait.
- **P2-4** — Bonus 4 (`2-projets/index.qmd:197-285`) très dense (mur de code) ; bien cadré « après l'atelier », donc pas de risque de noyade en séance.

## ✅ Ce qui me rassure
- Préparatifs en deux vitesses (paquet compagnon + chemin manuel) avec exemple de sortie verte attendue.
- `test-install.qmd` valide la chaîne complète avant le jour J ; warnings `unknown font family` expliqués d'avance.
- `.Rproj` à double-cliquer = règle le piège du répertoire de travail.
- Warning « `quarto render` sans `_quarto.yml` ne fait rien » anticipé.
- Boussoles autonomes, countdowns cohérents (12:00 / 15:00).
- Colonnes « Vous devriez voir » à chaque étape = meilleur antidote au décrochage.
- Plan B offline pas-à-pas.
- Aucun lien cassé / placeholder `(#)`.

**Résumé :** un·e débutant·e peut suivre sans rester bloqué·e. Seul correctif vraiment recommandé : P1-1.
