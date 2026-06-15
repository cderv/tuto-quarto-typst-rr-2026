# Review pédagogue — Logique du brand styling (2026-06-15)

Contexte : enquête ciblée sur « comment on stylise avec `_brand.yml` » dans les
deux exercices, suite à l'intuition du formateur que la partie stylisme n'est pas
claire pour les élèves. Review parallèle avec l'élève débutant·e.

**Diagnostic global :** l'intuition est juste, mais le problème n'est **pas** dans
l'exo 2 (où le styling gt/ggplot est proprement balisé « Bonus B4 », tuto complet
et progressif). Le problème est dans l'**exo 1** : sa correction contient ~70 lignes
de styling R qu'aucune étape n'enseigne, et la distinction fondamentale
« auto vs câblé-main » n'est nommée nulle part.

## 1. Écart starter → étapes → correction (exo 1) : ça ne colle pas

Un participant qui suit *exactement* les 4 étapes + B1 arrive au **starter** rendu
en Typst (mise en page brandée automatiquement par `_brand.yml`), avec **tableaux gt
et nuage ggplot bruts/gris**. Il n'arrive **pas** à la correction.

Dans `correction/rapport-starwars.qmd` mais qu'aucune étape ni B1 ne demande :
- Bloc setup augmenté (`:27-70`) : `library(brand.yml)`, `library(prismatic)`,
  `read_brand_yml()`, helpers `pal()`, `teinte()`/`clr_darken()`, et `styliser_brand()`.
- Tableau gt brandé (`:101-112`) : `styliser_brand()` + ligne-1 Jabba rouge impérial.
- ggplot brandé (`:123-153`) : `scale_color_manual()` + `theme_brand_ggplot2()`.
- Highlight Typst inline `#highlight(fill: brand-color.sw-yellow)` (`:115`) — une
  **3e voie** d'accès à la charte (variable Typst `brand-color.*`), jamais expliquée.

La correction de l'exo 1 a déjà absorbé **tout le Bonus B4 de l'exo 2**
(`styliser_brand()` identique mot pour mot), sans aucun marqueur « bonus ».

## 2. Modèle mental « auto vs câblé-main » : jamais nommé

La distinction clé — `_brand.yml` style **automatiquement** la mise en page Typst
(liens, fond, polices, titres), mais gt/ggplot doivent être **câblés à la main en R**
(`theme_brand_gt`, `theme_brand_ggplot2`, `brand_color_pluck`) — n'est énoncée
**nulle part** frontalement. Deux pépites renforcent même l'illusion d'automatisme :
- « Une charte, partout » (`1-quarto-typst.qmd:330`) : « viennent d'une seule
  source », sans dire qu'il y a une ligne R à écrire.
- « Vos tableaux fonctionnent » (`:332`) : « gt traduit automatiquement en Typst »
  — vrai pour la *structure*, brouille avec le *branding des couleurs* (pas auto).

Seul endroit où le mécanisme est déplié = Bonus B4 (`2-projets/index.qmd:204-294`),
sans poser la dichotomie en une phrase. Le « c'est normal » n'est dit qu'en exo 2
(`2-projets/index.qmd:68`), jamais en exo 1.

## 3. Cohérence exo 1 ↔ exo 2 : incohérence réelle

- Exo 2 : styling honnêtement cadré **Bonus B4 optionnel** (`:186-188`), étape 3
  prévient « tableaux gt restent bruts » (`:68`), corrections marquées
  `# --- Bonus B4 (optionnel) appliqué ---` (`correction/01-anatomie.qmd:5`,
  `02-origines.qmd:5`). Exemplaire.
- Exo 1 : le **même** styling, **sans aucun marqueur** bonus.

Risque : élève bloqué étape 3/4 suit le callout 🆘 (`1-quarto-typst/index.qmd:106-112`),
ouvre la correction, tombe sur 40 lignes de `tab_style()`/`clr_darken()` au lieu de
la syntaxe YAML cherchée → surcharge cognitive, anti-scaffolding (le Bloc 1 veut
garder la charge sur Quarto+Typst, pas R), et le « moment waouh » du B4 est spoilé.

## 4. Recommandations

**P1**
- **A. Aligner la correction exo 1 sur l'exo 2** (`correction/rapport-starwars.qmd:29`) :
  minimum, commentaire `# --- HORS ÉTAPES 1-4 : avant-goût du Bonus B4 (Bloc 2) ---`
  + bandeau en tête. Idéal : scinder en version stricte (gt/ggplot bruts) + version
  bonus brandée, le filet 🆘 pointant la première. (Scission touche `justfile`/exos.)
- **B. Nommer la dichotomie une fois, My turn Bloc 1** (slide `_brand.yml`,
  `1-quarto-typst.qmd:178`/`209`).
- **C. Prévenir dans le tableau étape 3/4 exo 1** (`1-quarto-typst/index.qmd:67-68`) :
  « les tableaux gt et le nuage restent gris : `_brand.yml` style la mise en page,
  pas les sorties R — voir Bonus B4 Bloc 2 ».

**P2**
- **D.** Reformuler la pépite « Une charte, partout » (`:330`) pour montrer le geste.
- **E.** Phrase-chapeau en tête du B4 (`2-projets/index.qmd:211`).
- **F.** Note presenter pour Maëlle (notes Bloc 1) : tableaux gris = attendu, ne pas
  envoyer dans la correction exo 1 pour ça.

**Forces :** B4 exo 2 excellent ; corrections exo 2 bien marquées ; charte source de
vérité claire ; indépendance exo1/exo2 bien gérée.

**Comptage : 3 P1, 3 P2, 0 P0.** Corrigeable avant le 16 sans réécrire le code des
corrections — surtout par des phrases de cadrage. Point le plus structurant : P1-A.
