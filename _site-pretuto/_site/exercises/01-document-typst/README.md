# Exercice 1 — Un PDF pro avec `format: typst`

**Durée :** 15 minutes &nbsp;·&nbsp; **Bloc 1**

## Objectif

Vous partez d'un rapport `rapport-starwars.qmd` qui sort en HTML. Votre
mission : le transformer en PDF Typst propre, aux couleurs de votre
charte, sans toucher au code R.

## Démarche

À partir du fichier `starter/rapport-starwars.qmd`, faites évoluer le YAML
en quatre étapes incrémentales :

1. **Passer en Typst.** Remplacez `format: html` par `format: typst` et
   rendez le document. Vous avez votre premier PDF.

2. **Régler la mise en page.** Sous `typst:`, ajoutez `papersize`,
   `margin`, `toc: true`, `number-sections: true`, `mainfont: Inter`,
   `linestretch: 1.4`. Re-rendez et observez la différence.

3. **Inspecter le `.typ` intermédiaire.** Activez `keep-typ: true`,
   re-rendez, ouvrez le fichier `.typ` généré à côté du PDF. C'est du
   Typst natif : le tableau `gt` y est bien une vraie `table()`, pas une
   image.

4. **Charte.** Créez un fichier `_brand.yml` à côté du `.qmd` (palette
   couleurs, une ou deux polices Google, et un logo SVG si vous en avez
   un sous la main). Re-rendez : couleurs, typographies et logo sont
   appliqués automatiquement à la mise en page PDF. Pour propager la
   charte aux figures ggplot et tableaux gt, utilisez les helpers du
   package R `brand.yml` (`theme_brand_ggplot2()`, `theme_brand_gt()`).
   La correction (`correction/`) fournit un exemple complet avec un
   logo Star Wars.

## Solution

Le dossier `correction/` contient une version finale possible :

- `correction/rapport-starwars.qmd` — YAML Typst complet + un raw Typst
  inline (`#highlight()`) pour mettre un mot en valeur
- `correction/_brand.yml` — palette Star Wars + Orbitron / Inter + logo
- `correction/_logo-sw.svg` — étoile jaune Star Wars, placée par Quarto
  en filigrane de la première page

Comparez votre version au besoin, mais essayez d'abord par vous-même.
