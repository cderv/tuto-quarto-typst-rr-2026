# PDF sans frictions : Typst dans vos projets Quarto

> Tutoriel 2 — [Rencontres R 2026](https://rr2026.sciencesconf.org/), 16 juin 2026, Nantes Université

**Instructeurs :** Christophe Dervieux (Posit) & Maëlle Salmon (rOpenSci, cynkra)

**Durée :** 2h (1h30 de contenu effectif + Q&A)

**Prérequis :** Quarto 1.9+, R 4.2+, RStudio / VS Code / Positron

**Arc narratif :** `.qmd` → PDF professionnel → livre → personnalisé / pérennisé

## Programme

| Horaire | Bloc | Qui présente ? | Durée |
|---------|------|:--------------:|:-----:|
| 9h00 | **Bloc 1 — Quarto & PDF avec Typst** | | 40 min |
| | Partie A — `format: typst` vs `format: pdf` | _à décider_ | 10 min |
| | Partie B — Personnaliser avec `_brand.yml` | _à décider_ | 15 min |
| | Exercice 1 | ensemble | 15 min |
| 9h40 | _Pause_ | | 10 min |
| 9h50 | **Bloc 2 — Projets & Typst book** | | 40 min |
| | Partie A — `_quarto.yml` et `type: book` | _à décider_ | 10 min |
| | Partie B — Brand promu, cross-refs, contenu conditionnel | _à décider_ | 15 min |
| | Exercice 2 | ensemble | 15 min |
| 10h30 | _Fin / Questions_ | | |

> Le contenu « Aller plus loin » (raw Typst, template partials, extensions) est conservé comme topic store dans [`3-aller-plus-loin/index.qmd`](3-aller-plus-loin/index.qmd) — référencé sans slot dédié dans le programme.

## Détail des contenus

### Bloc 1 — Quarto & PDF avec Typst (40 min)

**Partie A — De LaTeX à Typst (15 min)**

Le problème avec `format: pdf` (LaTeX) et pourquoi `format: typst` est une alternative sans friction :

- Comparaison PDF/LaTeX vs PDF/Typst : installation, vitesse, lisibilité des erreurs
- Options de base : `papersize`, `margin`, `mainfont`, `toc`, `number-sections`
- Nouvelles options Quarto 1.9 : `linkcolor`, `codefont`, `mathfont`, `linestretch`, `font-paths`
- `keep-typ: true` pour inspecter le fichier `.typ` intermédiaire
- _Demo live :_ pipeline `.qmd` → `.typ` → `.pdf`

> **Question pour Maëlle :** on fait la démo côte à côte (`.qmd` vs `.typ` généré) ou on montre d'abord le résultat PDF puis on remonte au source ?

**Partie B — Personnaliser avec `_brand.yml` (20 min)**

Rappel [RR 2025](https://cderv.github.io/rr2025-quarto-brand-yml/), approfondi pour Typst :

- Structure `_brand.yml` : `meta` / `color` / `typography` / `logo`
- Application automatique sur `format: typst`
- Palette de couleurs nommées, polices Google
- Logo : positionnement (`width`, `location`, `padding`, `alt`)
- `theorem-appearance` : 4 styles (`simple`, `fancy`, `clouds`, `rainbow`)
- Dictionnaires brand dans Typst : `brand-color`, `brand-logo`, `brand-logo-images`
- `brand-mode: dark`
- `quarto use brand user/repo` (Quarto 1.9)

> **Question :** est-ce qu'on montre les 4 `theorem-appearance` en screenshot ou en live ? Les screenshots sont plus fiables en temps limité.

**Exercice 1 (~15 min)**

1. Convertir `rapport-starwars.qmd` de `format: pdf` vers `format: typst`
2. Créer un `_brand.yml` minimal (2-3 couleurs + police Google)
3. `keep-typ: true` et explorer le `.typ` généré

### Bloc 2 — Projets & Typst book (40 min)

**Partie A — Travailler en projet (10 min)**

- `_quarto.yml` comme config centralisée : `format: typst` au niveau projet
- `_brand.yml` au niveau projet → cohérence automatique
- Contenu conditionnel : `.content-visible when-format="typst"` / `.content-hidden when-format="html"`

> **Question :** ajouter un exemple concret de contenu conditionnel ? Par ex. un saut de page en PDF mais pas en HTML ?

**Partie B — Le Typst book (15 min)**

- `type: book` : chapitres, TOC globale, références croisées, numérotation par chapitre
- Quarto 1.9 : orange-book activé automatiquement pour `format: typst` sur un book
- `_brand.yml` + book = livre aux couleurs de l'organisation
- Marginalia : `.column-margin`, `cap-location: margin`, `.aside`
- `typst-gather` pour embarquer les packages Typst et rendre hors-ligne

> **Question :** on montre Marginalia comme format article séparé ou comme fonctionnalité du book ? Ce sont deux choses différentes, il faut être clair.

**Exercice 2 (~15 min)**

1. Créer `_quarto.yml` avec `project: {type: book}` et `format: typst`
2. Organiser en 2-3 chapitres
3. Observer l'effet orange-book
4. (Bonus) Appliquer le `_brand.yml` de l'exercice 1

### Aller plus loin (topic store, hors programme)

Le contenu suivant est documenté dans [`3-aller-plus-loin/index.qmd`](3-aller-plus-loin/index.qmd) comme référence pour les participants curieux — il n'a pas de slot dédié dans le programme.

- **Blocs raw Typst** : `` ```{=typst} `` pour injecter du Typst natif, accès aux variables brand, traduction CSS → Typst
- **Template partials** : `typst-show.typ` (pont Quarto → Typst), `typst-template.typ` (layout), syntaxe Pandoc, variables Quarto 1.9
- **Extensions & partage** : `quarto create extension format:typst`, `quarto add user/repo`, `quarto use brand user/repo`, accessibilité `pdf-standard: ua-1`

## Exercices

Tous les exercices utilisent le dataset **Star Wars** (`dplyr::starwars`, 87 personnages × 14 variables). Complexité progressive :

| Exercice | Fichier | Objectif | Difficulté |
|----------|---------|----------|:----------:|
| 1 | `rapport-starwars.qmd` | PDF/Typst + brand.yml + keep-typ | ★ |
| 2 | Projet book Star Wars | `_quarto.yml`, `type: book`, brand promu, cross-refs, contenu conditionnel | ★★ |

Les exercices (starter et correction) sont sous `exercises/01-document-typst/` et `exercises/02-projet-book/`.

## Points à discuter

- [ ] **Répartition des sections** — qui présente quoi ? Alternance ou blocs complets ?
- [ ] **Démos live vs screenshots** — pour `theorem-appearance`, orange-book ?
- [ ] **Timing** — 40+10+40 = 90 min de contenu, fin à 10h30, marge de 30 min pour Q&A ou débordement. Réaliste ?
- [ ] **Contenu Quarto 1.9** — vérifier que toutes les features citées sont bien stables dans la release finale
- [ ] **Transition RR 2025 → RR 2026** — combien de rappels sur `_brand.yml` ? Les participants ne l'ont pas forcément vu en 2025

## Structure du dépôt

```
_quarto.yml                    # Config projet (website + clean-revealjs)
reveal-style.scss              # Thème slides (Atkinson Hyperlegible, couleurs)
index.qmd                      # Page d'accueil (programme, bios)
preparatifs.qmd                # Instructions d'installation
1-quarto-typst/
  index.qmd                    # Page Bloc 1 (iframe slides + exercices)
  1-quarto-typst.qmd           # Slides Bloc 1 (RevealJS)
2-projets/
  index.qmd                    # Page Bloc 2
  2-projets.qmd                # Slides Bloc 2
3-aller-plus-loin/
  index.qmd                    # Topic store complémentaire (pas dans la navbar)
4-ressources.qmd               # Liens et ressources externes
_extensions/                   # Extensions Quarto installées
  gadenbuie/countdown/         #   Timer pour exercices
  grantmcdermott/clean/        #   clean-revealjs format
  quarto-ext/fontawesome/      #   Icônes Font Awesome
```

## Développement

```bash
# Prévisualiser le site
quarto preview

# Rendre le site complet
quarto render

# Sortie dans _site/
```

Nécessite Quarto 1.9+.

## Contexte

- **Antécédent :** suit la structure du [tutoriel RR 2023](https://github.com/cderv/tuto-quarto-rr-2023) (même format website + slides embarquées)
- **Lien :** prolonge la [présentation `_brand.yml` RR 2025](https://cderv.github.io/rr2025-quarto-brand-yml/)
- **Focus :** angle Quarto+Typst (pas Typst standalone)

## Licence

CC BY 4.0 — Christophe Dervieux & Maëlle Salmon
