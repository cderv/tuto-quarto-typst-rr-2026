# Changelog

Évolutions notables du projet : le **site du tutoriel** « PDF sans frictions :
Typst dans vos projets Quarto » (Rencontres R 2026) et son **paquet compagnon**
`tutoquartotypst`. Les versions suivent celles du paquet. Détail côté paquet :
[`pkg/NEWS.md`](pkg/NEWS.md). Format inspiré de
[Keep a Changelog](https://keepachangelog.com/fr/1.1.0/).

## [1.0.2] — 2026-06-16

Post-tuto : nettoyage et fiabilisation des **corrections d'exercices** (aucun
changement de fonction du paquet).

### Modifié

- **Exercice 1 — balisage du Bonus B4.** Le câblage R de la charte aux tableaux
  `gt` / figures `ggplot2` (paquet *brand.yml*) et le `#highlight()` Typst de la
  correction **vont au-delà des 4 étapes** de l'énoncé : ils relèvent du
  **Bonus B4 de l'exercice 2**. C'est désormais signalé (README de la correction
  + commentaires dans le fichier) — le rendu PDF, lui, est inchangé.
- **Sous-titre de la correction exercice 1** reformulé pour éviter l'initiale
  « Q » déformée par Star Jedi : « Qui… » → « Les colosses de la galaxie, qui
  sont-ils ? ». Le starter conserve « Qui… » (le cas reste un point pédagogique).

### Corrigé

- **Corps du book en serif.** En mode `book`, Quarto ne propage pas
  `typography.base` / `mainfont` au template orange-book : le corps retombait en
  Libertinus serif. La correction de l'exercice 2 force `#set text(font:
  "Inter")` via `include-in-header`. Contournement d'un bug Quarto, pas un défaut
  du `_brand.yml`.
- **Lisibilité Star Jedi.** Cette fonte décorative rend ses MAJUSCULES en glyphes
  « logo » (I→H, O→N, Q→M, U→K). Les corrections appliquent un *show-rule* Typst
  qui passe les majuscules des **titres** en minuscules (rendues en capitales
  propres) → corrige « Introduction » (exercice 1) et « Origines » (book).

### Paquet

- `pkg/NEWS.md` ajouté, `pkg/DESCRIPTION` passé en **1.0.2**, `pkg/inst/`
  resynchronisé depuis `exercises/`.

## [1.0.1] — 2026-06-16

Version **jouée au tutoriel** aux Rencontres R 2026 (Nantes, 16 juin) — état de
`main` le jour J.

- Site Quarto complet : 2 blocs (Quarto + Typst → PDF pro ; projets & book),
  rythme *My turn / Our turn / Your turn* et pépites « Saviez-vous que… ».
- Exercices (starters + corrections) : document Typst (bloc 1) et livre Typst
  (bloc 2), avec charte Star Wars via `_brand.yml`.
- Paquet compagnon `tutoquartotypst` : installation des prérequis, vérification
  de l'environnement (R, Quarto, Typst, paquets) et pose des exercices.
