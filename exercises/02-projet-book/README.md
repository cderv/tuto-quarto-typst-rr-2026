# Exercice 2 — De la page au livre

> 5 fichiers `.qmd`, un `_quarto.yml`, et le rapport Bloc 1 devient un livre
> Quarto avec couverture, TOC, numérotation automatique et charte cohérente.

## Prérequis

- Quarto 1.9+ (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- Packages R installés : `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales`
- Pour le Bonus 4 (optionnel, brand styling avancé) : `brand.yml` (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- L'extension `orange-book` (livrée avec Quarto 1.9, pas d'install à faire)

## Mise en place

Partez de [`starter/`](starter/) — voir le [README starter](starter/README.md) pour le quick-ref opérationnel.

## Consigne complète

Sur le site : [Bloc 2 — Projets & book](https://cderv.github.io/cderv-tuto-quarto-typst-rr-2026/2-projets/) — étapes, indices doc, modèle `_quarto.yml`, deep dives B3/B4, escalier d'autonomie, correction.

## Pas de `_brand.yml` récupéré du Bloc 1 ?

Pas grave. Copiez ces 2 fichiers à la racine de votre projet :

- [`_brand-fallback.yml`](_brand-fallback.yml) → renommer en `_brand.yml`
- [`correction/_logo-sw.svg`](correction/_logo-sw.svg) → copier sous le même nom

C'est une copie 1:1 de la charte utilisée dans la correction.

## Et après ?

Le dossier [`correction/`](correction/) contient le projet final, charte incluse,
avec les 3 étapes principales ET les 2 bonus appliqués. À comparer avec votre
résultat à la fin de l'exercice.
