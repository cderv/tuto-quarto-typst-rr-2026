# Charte graphique Star Wars — source

Ce dossier contient le source du **PDF de charte graphique** distribué dans les starters des Exercices 1 et 2 pour guider la transcription en `_brand.yml`.

## Fichiers

| Fichier | Rôle |
|---|---|
| `charte-starwars.qmd` | Source Quarto/Typst — une page A4 |
| `_brand.yml` | Charte utilisée par le PDF lui-même (méta-exemple) |
| `_logo-sw.svg` | Logo étoile jaune |
| `_fonts/Starjedi.ttf` | Police titres (locale) |

## Pipeline (manuel)

Après modification :

```bash
cd _charte
quarto render charte-starwars.qmd
cp charte-starwars.pdf ../exercises/01-document-typst/starter/
cp charte-starwars.pdf ../exercises/02-projet-book/starter/
```

Le PDF généré est committé dans les deux `starter/` pour que les participant·e·s l'aient sans avoir à le rendre.

## Choix de design

- Palette, polices, logo : identiques aux corrections des Exos 1 et 2 (`exercises/01-document-typst/correction/_brand.yml`).
- Le PDF est lui-même un document Typst rendu via `_brand.yml` → méta-exemple visuel de ce que les participant·e·s vont produire.
- Le logo est placé automatiquement en haut-gauche par Quarto (effet `logo.medium`) — l'apprenant voit donc *en regardant la charte* ce que produit la déclaration logo de `_brand.yml`.
