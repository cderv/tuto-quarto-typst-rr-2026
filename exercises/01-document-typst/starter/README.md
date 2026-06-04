## Exercice 1 — Starter

> Mémo rapide. La consigne complète est sur le site :
> [Bloc 1 — PDF avec Typst](https://cderv.github.io/tuto-quarto-typst-rr-2026/1-quarto-typst/).

### Contenu du dossier

| Fichier | Rôle |
|---|---|
| `rapport-starwars.qmd` | **Fichier à éditer** — point de départ HTML, à transformer en PDF Typst |
| `charte-starwars.pdf` | **Charte graphique** à traduire en `_brand.yml` (étapes 3-4) |
| `_fonts/Starjedi.ttf` | Police locale (étape 4) |
| `exercice-01.Rproj` | Projet RStudio — **double-cliquez-le** pour ouvrir l'exercice (répertoire de travail correct) |
| _(pas de `_brand.yml`)_ | **À créer aux étapes 3-4** d'après la charte |

### Rendu

Depuis ce dossier :

```bash
quarto render rapport-starwars.qmd
```

Sortie initiale : `rapport-starwars.html` (format par défaut).
Après ajout de `format: typst` : `rapport-starwars.pdf`.

### Bloqué ?

Cf. le bloc « Si vous bloquez » sur le site (page exo) ou la
[`correction/`](https://github.com/cderv/tuto-quarto-typst-rr-2026/tree/main/exercises/01-document-typst/correction) en dernier recours.
