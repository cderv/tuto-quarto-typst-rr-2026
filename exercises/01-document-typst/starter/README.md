## Exercice 1 — Starter

> **Mémo du dossier `starter/`.** Contenu et commande de rendu ci-dessous.
> Le pas-à-pas complet (étapes, indices doc, « Si vous bloquez ») est sur la page de l'exercice.

### Contenu du dossier

| Fichier | Rôle |
|---|---|
| `rapport-starwars.qmd` | **Fichier à éditer** — point de départ HTML, à transformer en PDF Typst |
| `charte-starwars.pdf` | **Charte graphique** à traduire en `_brand.yml` (étapes 3-4) |
| `_logo-sw.svg` | Logo à référencer dans `_brand.yml` (clé `logo:`) — étape 3 |
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
