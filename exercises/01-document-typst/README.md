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
   re-rendez, ouvrez le fichier `.typ` généré à côté du PDF. Vous y
   retrouverez les équivalents Typst des éléments Markdown (`=`,
   `#strong[...]`, `#link(...)[...]`) vus en slide, plus des fonctions
   Typst dédiées comme `#table()` pour le tableau `gt` — qui est ici
   une vraie table, pas une image.

4. **Charte.** Créez un fichier `_brand.yml` à côté du `.qmd` (palette
   couleurs, une ou deux polices Google, et un logo SVG si vous en avez
   un sous la main). Re-rendez : couleurs, typographies et logo sont
   appliqués automatiquement à la mise en page PDF. Pour propager la
   charte aux figures ggplot et tableaux gt, utilisez les helpers du
   package R `brand.yml` (`theme_brand_ggplot2()`, `theme_brand_gt()`).

5. **Police locale sur le titre.** Le dossier `starter/_fonts/` contient
   un fichier `StarJedi-DGRW.ttf` (police décorative fan-made, licence
   freeware). Référencez-le dans `_brand.yml` via `source: file` et
   appliquez-le uniquement au titre du rapport (`typography.title`).
   Re-rendez : « Anatomie d'une saga » s'affiche en lettres Star Jedi,
   le reste du document garde Inter (corps) et Orbitron (titres de
   section).

La correction (`correction/`) fournit un exemple complet avec un logo
Star Wars et une police locale Star Jedi sur le titre.

## Solution

Le dossier `correction/` contient une version finale possible :

- `correction/rapport-starwars.qmd` — YAML Typst complet (incl. `logo:`
  sous `format.typst` pour redimensionner et placer le logo) + un raw
  Typst inline (`#highlight()`) pour mettre un mot en valeur
- `correction/_brand.yml` — palette Star Wars + Inter (Google) +
  Orbitron (Google) + Star Jedi (locale, sur le titre uniquement) + logo
- `correction/_brand-offline.yml` — variante 100 % offline (toutes les
  polices en `source: file`), Plan B en cas de réseau capricieux
- `correction/_fonts/` — TTFs statiques Inter, Orbitron, Star Jedi
- `correction/_logo-sw.svg` — étoile jaune Star Wars, placée par Quarto
  en filigrane haut-gauche de chaque page

Comparez votre version au besoin, mais essayez d'abord par vous-même.
