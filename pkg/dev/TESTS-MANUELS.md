# Plan de test manuel — `tutoquartotypst`

Les tests automatisés (`devtools::test()`, 105 tests) **mockent** l'interactivité
(`rlang::local_interactive()`) et `rstudioapi` : ils vérifient la *logique* mais pas
l'intégration **réelle** avec l'IDE ni les invites interactives. Ce plan couvre ce
qui ne peut être validé qu'à la main, **dans RStudio** (et idéalement une fois sous
Windows, pour les chemins).

Cocher après vérification. Pré-requis : paquet installé (`pak::pak("local::./pkg")`)
et Quarto présent.

## 1. Intégration RStudio (branches `rstudioapi`)

Ces fonctions n'empruntent `rstudioapi` QUE dans RStudio (`rstudioapi::isAvailable()`).
À lancer **depuis la console RStudio** :

- [ ] `installer_exercices(tempfile())` → le **volet Files** navigue vers le dossier créé.
- [ ] `ouvrir_exercices(<ce dossier>)` → le volet Files y re-navigue.
- [ ] `creer_projet_typst(tempfile())` → volet Files sur le projet généré.
- [ ] `inspecter_typ("<un .qmd format: typst>")` → le `.typ` **s'ouvre dans l'éditeur**.

Hors RStudio (R en terminal, mode interactif) : les mêmes appels doivent ouvrir via
`browseURL` / `file.edit` sans erreur (best-effort, jamais bloquant).

## 2. Invites interactives (menu Oui/Non)

- [ ] `reinitialiser_exercice("01")` sur un exercice existant → **menu « Oui/Non »** ;
      « Non » annule, « Oui » sauvegarde puis restaure.
- [ ] `ouvrir_correction("01")` → invite de confirmation ; « Non » n'ouvre rien,
      « Oui » ouvre l'URL GitHub de la correction dans le navigateur.

## 3. Chaîne de rendu réelle (au-delà du test 00 automatisé)

- [ ] `verifier_installation()` (avec `tester_rendu = TRUE`, défaut) → rapport complet
      + **PDF de test** réellement produit.
- [ ] Sur l'**exercice 1** rendu : `inspecter_typ("rapport-starwars.qmd")` → `.typ` cohérent.
- [ ] Sur l'**exercice 2** (livre), Quarto < 1.10.4 : `appliquer_polices_locales()`
      ajoute `font-paths`, puis `quarto render` du livre réussit (polices OK).
- [ ] **Mode hors-ligne** : couper le réseau, `basculer_hors_ligne()` sur l'exo 1,
      puis `quarto render` → PDF avec Inter **locale** (aucun téléchargement Google).
      Puis `basculer_hors_ligne(retour = TRUE)` restaure la charte d'origine.

## 4. Polices vues par Typst

- [ ] `polices_typst()` → liste non vide (polices système).
- [ ] `polices_typst("<dossier exo avec _fonts/>")` → **Star Jedi** apparaît.

## 5. Multi-plateforme (si possible)

- [ ] Sous **Windows** : `installer_exercices()`, `basculer_hors_ligne()`,
      `creer_projet_typst()` — chemins corrects (séparateurs), pas d'erreur d'encodage
      sur les accents (UTF-8).

> En cas de souci à reporter : `exporter_diagnostic()` affiche un résumé à copier-coller.
