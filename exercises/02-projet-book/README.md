# Exercice 2 — De la page au livre

> 5 fichiers `.qmd`, un `_quarto.yml`, et le rapport Bloc 1 devient un livre
> Quarto avec couverture, TOC, numérotation automatique et charte cohérente.

## Prérequis

- Quarto 1.9+ (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- Packages R installés : `dplyr`, `ggplot2`, `ggrepel`, `gt`, `scales`
- Pour le Bonus 4 (optionnel, brand styling avancé) : `brand.yml` + `prismatic` (cf. [`preparatifs.qmd`](../../preparatifs.qmd))
- L'extension `orange-book` (livrée avec Quarto 1.9, pas d'install à faire)

## Mise en place

Partez de [`starter/`](starter/) — voir le [README starter](starter/README.md) pour le quick-ref opérationnel.

## Consigne complète

Sur le site : [Bloc 2 — Projets & book](https://cderv.github.io/tuto-quarto-typst-rr-2026/2-projets/) — étapes, indices doc, modèle `_quarto.yml`, bonus B3/B4 pour aller plus loin, bloc « Si vous bloquez », correction.

## Pas de `_brand.yml` récupéré du Bloc 1 ?

Pas grave. Copiez ces 2 fichiers à la racine de votre projet :

- [`_brand-starter.yml`](_brand-starter.yml) → renommer en `_brand.yml`
- [`_logo-sw.svg`](_logo-sw.svg) → copier sous le même nom dans votre projet

C'est une copie 1:1 de la charte utilisée dans la correction.

## Bonus 3 — Changer de palette Star Wars

Trois variantes de `_brand.yml` clés en main dans [`correction/`](correction/) :

- [`_brand-empire.yml`](correction/_brand-empire.yml) — Empire / Sith, rouge impérial (identique à la charte par défaut)
- [`_brand-jedi.yml`](correction/_brand-jedi.yml) — Jedi / R2-D2, bleu
- [`_brand-mando.yml`](correction/_brand-mando.yml) — Mandalorien, crimson

Pour en activer une sans renommer de fichier, pointez `brand:` vers elle dans `_quarto.yml` :

```yaml
brand: _brand-jedi.yml
```

**Pourquoi pas le jaune Star Wars iconique en `primary` ?** L'extension `orange-book`
réutilise la couleur `primary` à la fois pour l'accent de couverture **et** pour le
texte du corps (titres, table des matières). Un jaune vif (`#FFE81F`) en `primary`
donnerait un texte illisible sur le fond crème. On garde donc `imperial-red` (sombre,
lisible) en `primary` — le jaune reste présent ailleurs (surlignages, tableaux `gt`)
via la clé de palette `sw-yellow`.

## Et après ?

Le dossier [`correction/`](correction/) contient le projet final, charte incluse,
avec les 3 étapes principales ET les 2 bonus appliqués. À comparer avec votre
résultat à la fin de l'exercice.
