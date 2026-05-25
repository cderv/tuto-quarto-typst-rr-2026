# Charte graphique Star Wars — source

Ce dossier contient le source du **PDF de charte graphique** distribué dans les starters des Exercices 1 et 2 pour guider la transcription en `_brand.yml`.

## Fichiers

| Fichier | Rôle |
|---|---|
| `charte-starwars.qmd` | Source Quarto/Typst — une page A4 |
| `_brand.yml` | Charte utilisée par le PDF lui-même (méta-exemple) |
| `_logo-sw.svg` | Logo étoile jaune |
| `_fonts/Starjedi.ttf` | Police titres (locale) |

## Pipeline

Après modification :

```bash
cd _charte
quarto render
```

Le script `_post-render.R` (déclaré dans `_quarto.yml` via `post-render`) copie automatiquement le PDF rendu vers les deux `starter/`. Le PDF est committé dans les deux dossiers pour que les participant·e·s l'aient sans avoir à le rendre.

## Choix de design

- Palette, polices, logo : identiques aux corrections des Exos 1 et 2 (`exercises/01-document-typst/correction/_brand.yml`).
- Le PDF est lui-même un document Typst rendu via `_brand.yml` → méta-exemple visuel de ce que les participant·e·s vont produire.
- Le logo est placé automatiquement en haut-gauche par Quarto (effet `logo.medium`) — l'apprenant voit donc *en regardant la charte* ce que produit la déclaration logo de `_brand.yml`.
