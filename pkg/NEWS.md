# tutoquartotypst 1.0.2

Cette version ne change aucune fonction : elle nettoie et fiabilise les
**corrections d'exercices** embarquées (posables via `recuperer_correction()`,
consultables via `ouvrir_correction()`).

## Corrections d'exercices

* **Exercice 1 — balisage du Bonus B4.** La correction
  (`rapport-starwars.qmd`) applique le câblage R de la charte aux tableaux
  `gt` et figures `ggplot2` (paquet *brand.yml*) ainsi qu'un `#highlight()`
  Typst. Ce câblage **va au-delà des 4 étapes** de l'énoncé (qui ne brandent
  que la mise en page Typst) : il relève du **Bonus B4 de l'exercice 2**. Il
  est désormais explicitement signalé (README de la correction + commentaires
  dans le fichier) pour ne plus surprendre qui ouvre la correction en filet de
  secours.

* **Correctifs polices Typst.**
  - *Corps du book en Inter.* En mode `book`, Quarto ne propage pas
    `typography.base` / `mainfont` au template orange-book : le corps retombait
    en serif (Libertinus). La correction de l'exercice 2 force désormais
    `#set text(font: "Inter")` via `include-in-header`. C'est un contournement
    d'un bug Quarto, pas un défaut du `_brand.yml` (Inter s'applique bien en
    document simple, exercice 1).
  - *Lisibilité Star Jedi.* La fonte décorative Star Jedi rend ses MAJUSCULES
    en glyphes « logo » (I→H, O→N, Q→M, U→K). Les corrections appliquent un
    *show-rule* Typst qui passe les majuscules des **titres** en minuscules
    (que Star Jedi rend en capitales propres) — corrige « Introduction »
    (exercice 1) et « Origines » (exercice 2). Le sous-titre de l'exercice 1,
    qui n'est pas un titre de section, a été reformulé pour éviter l'initiale
    « Q » (« Qui… » → « Les colosses de la galaxie, qui sont-ils ? »).

# tutoquartotypst 1.0.1

* Version jouée au tutoriel « PDF sans frictions : Typst dans vos projets
  Quarto » aux Rencontres R 2026 (Nantes, 16 juin 2026). Installe les
  prérequis, vérifie l'environnement (R, Quarto, Typst, paquets) et pose les
  exercices.
