## Exercice 2 — Starter

> **Mémo du dossier `starter/`.** Contenu et commande de rendu ci-dessous.
> Le pas-à-pas complet (étapes, indices doc, modèle `_quarto.yml`, « Si vous bloquez ») est sur la page de l'exercice.

### Contenu du dossier

| Fichier | Rôle |
|---|---|
| `index.qmd` | Préface du livre (à garder) |
| `01-anatomie.qmd` | Chapitre 1 (à garder) |
| `02-origines.qmd` | Chapitre 2 (à garder) |
| `conclusion.qmd` | Conclusion (à garder) |
| `annexe-donnees.qmd` | Sera basculé en annexe à l'étape 2b |
| `charte-starwars.pdf` | **Charte graphique** Star Wars (référence visuelle pour l'étape 3) |
| `exercice-02.Rproj` | Projet RStudio — **double-cliquez-le** pour ouvrir l'exercice (répertoire de travail correct) |
| _(pas de `_quarto.yml`)_ | **À créer à l'étape 1** |
| _(pas de `_brand.yml`)_ | **À copier à l'étape 3** (ou traduire d'après la charte) |

### Rendu

Depuis ce dossier :

```bash
quarto render
```

Sortie initiale (sans `_quarto.yml`) : 5 fichiers HTML séparés.
Après les 3 étapes : un livre PDF Typst unique, stylé.

### Pas de `_brand.yml` du Bloc 1 ?

Copiez à la racine du projet :

- [`_brand-starter.yml`](https://github.com/cderv/tuto-quarto-typst-rr-2026/blob/main/exercises/02-projet-book/_brand-starter.yml) → renommer en `_brand.yml`
- [`_logo-sw.svg`](https://github.com/cderv/tuto-quarto-typst-rr-2026/blob/main/exercises/02-projet-book/_logo-sw.svg)

### Bloqué ?

Cf. le bloc « Si vous bloquez » sur le site (page exo) ou la
[`correction/`](https://github.com/cderv/tuto-quarto-typst-rr-2026/tree/main/exercises/02-projet-book/correction) en dernier recours.
