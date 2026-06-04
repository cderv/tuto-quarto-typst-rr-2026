# Review élève débutant·e — Bonus 4 « Brander tableaux et graphiques »

**Date** : 2026-06-03
**Branche** : `claude/r-tutorial-feedback-Tsyfd` (PR #14)
**Périmètre** : section Bonus 4 de `2-projets/index.qmd`, corrections `01-anatomie.qmd` / `02-origines.qmd`, `rapport-starwars.qmd` (correction Bloc 1), README Exo 2.
**Posture** : participant·e R+RStudio depuis 2-3 ans, R Markdown occasionnel, jamais touché aux extensions ni `_brand.yml`. J'OUVRE la correction en fin d'exo pour comparer, et j'envisage le Bonus 4.

---

## Verdict général

Le cadrage « bonus optionnel, à explorer après l'atelier » est très bien tenu : je comprends sans ambiguïté que ce n'est PAS attendu de moi, et la correction de base reste lisible si je saute tout le brand styling. Le code, lui, est ambitieux pour mon niveau — il empile 4-5 concepts nouveaux (helper `function(t)`, tunnel `{{ col }}`, dérivation de teintes par `clr_darken`, longue liste `tab_options()`). Pour **comparer** (lire, comprendre la forme du PDF) ça passe grâce aux commentaires. Pour **copier-coller chez moi**, ça marchera tel quel SI `prismatic` et `brand.yml` sont installés — et ils le sont bien dans `preparatifs.qmd`. Pas de bloquant le 16 juin (le bonus est hors séance), mais quelques frictions de compréhension à lisser.

- **Q1 — Est-ce trop compliqué ?** ⚠️ Digeste à lire, dense à reproduire. Quelques concepts non expliqués qui me ralentiront.
- **Q2 — Reste-t-il dans la logique « bonus optionnel » ?** 👍 Oui, sans réserve. Cadrage exemplaire.

---

## Q1 — Trop compliqué ? (⚠️)

### Ce qui me ferait peur / me ralentirait

**1. `substr(as.character(clr_darken(pal(x), f)), 1, 7)` — le helper `teinte()`**
`2-projets/index.qmd:204` et corrections `01-anatomie.qmd:14`, `02-origines.qmd:12`, `rapport-starwars.qmd:40`.
C'est la ligne qui me fait le plus peur. Trois fonctions imbriquées + une magie `1, 7`. Le commentaire dit « dériver des teintes crème de la charte / sans hex magique », ce qui explique le *pourquoi* mais pas le *comment* :
- Pourquoi `as.character()` autour de `clr_darken()` ? (je ne sais pas que `prismatic` renvoie un objet couleur, pas une chaîne)
- Pourquoi `substr(..., 1, 7)` ? (couper le `#RRGGBB` en retirant le canal alpha `#RRGGBBAA` — invisible pour qui ne connaît pas le format hex à 8 chiffres)

En l'état je copie sans comprendre, et si ça casse je ne saurai pas déboguer. **Suggestion** : une phrase « `prismatic` renvoie un code couleur avec canal de transparence (`#RRGGBBAA`) ; `substr(…, 1, 7)` garde les 6 chiffres `#RRGGBB` que `gt` attend ». Une demi-ligne me débloque.

**2. `{{ col }}` — le tunnel rlang** (`02-origines.qmd:43`, mentionné `2-projets/index.qmd:256`)
`colorer_metrique <- function(t, col)` avec `data_color(columns = {{ col }}, ...)`. Le `{{ }}` n'est expliqué NULLE PART dans le bonus. Au point où j'en suis (dplyr « confortable » mais jamais écrit ma propre fonction qui prend un nom de colonne nu), je vais soit :
- ne pas oser réutiliser le helper avec ma propre colonne,
- ou tenter `colorer_metrique(ma_table, "n")` (avec guillemets) → ça **casse silencieusement ou avec une erreur peu parlante**.
La page index ne montre même pas `colorer_metrique`, elle inline le `data_color()` (`2-projets/index.qmd:238-243`) — du coup le `{{ col }}` n'apparaît QUE dans la correction, sans un mot. **Suggestion** : soit un commentaire « `{{ col }}` = on passe un nom de colonne nu, ex. `colorer_metrique(tbl, n)` », soit garder le `data_color()` inline aussi dans la correction pour rester cohérent avec ce que la page m'a montré.

**3. Le helper `styliser_brand <- function(t)`**
La forme `function(t) { t |> ... }` est inhabituelle pour moi : je n'ai quasi jamais écrit de fonction qui prend un objet `gt` et le renvoie pipé. Conceptuellement OK une fois que je vois l'usage en commentaire (`2-projets/index.qmd:231` « `votre_table |> gt() |> ... |> styliser_brand()` »), ce commentaire-usage est **précieux et bien placé**. Mais la longue liste `tab_options()` (15 lignes, `2-projets/index.qmd:221-228`) est intimidante au premier regard. Je ne la lirai pas en détail — et c'est OK, je fais confiance au bloc. Le risque c'est juste l'effet « mur de code » qui peut me décourager d'essayer.

**4. `theme_brand_gt` / `theme_brand_ggplot2` — d'où viennent-elles ?**
Le texte (`2-projets/index.qmd:192`) dit « Couplé à `gt::tab_style()` et `theme_brand_ggplot2()` ». Le `gt::` préfixé suggère que `theme_brand_gt`/`theme_brand_ggplot2` viennent aussi de `gt`, alors qu'elles viennent du package **`brand.yml`**. Petite confusion possible : si je cherche `?theme_brand_gt` après `library(gt)` seul, je ne trouve rien. Mineur, mais un·e débutant·e prend ça au premier degré.

### Le prérequis qui pourrait casser le rendu — vérifié : OK ✅

`brand.yml` ET `prismatic` sont bien dans la liste d'install de `preparatifs.qmd:51` :
```r
pkg <- c("quarto", "dplyr", "ggplot2", "ggrepel", "gt", "scales", "brand.yml", "prismatic")
```
et le README Exo 2 (`README.md:10`) le redit pour le Bonus 4. **Donc si j'ai suivi les préparatifs, rien ne manque.** Bon point : pas de piège « package introuvable » au moment de copier le bonus. Seul angle mort résiduel : si quelqu'un a installé les packages « de base » à la main sans `prismatic` (il est en fin de liste, facile à zapper visuellement), le `library(prismatic)` lèvera une erreur. Mais c'est documenté, je ne le compte pas comme défaut.

### Le piège silencieux est bien signalé ✅

`2-projets/index.qmd:272-276` (callout « Piège silencieux ») : `pal("sw_yellow")` et non `pal("sw-yellow")`, et le fait que `brand_color_pluck()` renvoie la chaîne d'entrée sans erreur → mise en forme qui « disparaît silencieusement ». **C'est exactement le genre de piège qui m'aurait coûté 15 min** ; le voir documenté noir sur blanc me rassure énormément. Très bon.

---

## Q2 — Reste dans la logique « bonus optionnel » ? (👍)

Oui, et c'est le point fort de cette section. Tout me signale que je peux ignorer le Bonus 4 sans culpabiliser :

- `2-projets/index.qmd:173-175` : callout note explicite « **Les Bonus 3 et 4 ci-dessous sont des approfondissements** — à explorer après l'atelier si vous manquez de temps en séance. »
- Le Bonus 4 est dans un `callout-tip collapse="true"` (`:189`) — **replié par défaut**, je ne le vois que si je clique. Je ne tombe pas dessus par accident.
- Le tableau des 3 étapes principales (`:54` « **attendues de tous** ») et les 2 bonus B1/B2 (`:63` « **pour les rapides** ») séparent nettement le socle du reste. Le Bonus 4 est encore au-delà.
- L'étape 3 du tableau principal (`:61`) précise « Les tableaux `gt` restent bruts à ce stade — leur mise aux couleurs de la charte est l'objet du Bonus 4. » → je sais que des tableaux non-colorés à la fin de l'étape 3 sont **le résultat attendu**, pas un échec de ma part. Très rassurant.

### Est-ce qu'un·e débutant·e qui NE fait PAS le bonus comprend la correction de base ?

Point d'attention ⚠️ : **la correction sur disque a TOUJOURS le brand styling appliqué.** Si je termine l'étape 3 (tableaux bruts) puis j'ouvre `correction/01-anatomie.qmd` pour comparer, je tombe sur le `styliser_brand`, `colorer_metrique`, `clr_darken`… c.-à-d. la version « Bonus 4 inclus ». Le README (`README.md:53-55`) le dit honnêtement : « le projet final […] avec les 3 étapes principales ET les 2 bonus appliqués ». Mais :
- Le `setup-anatomie` charge `library(brand.yml)` + `library(prismatic)` (`01-anatomie.qmd:9-10`) **dès la première ligne** de la correction. Un·e débutant·e qui n'a pas fait le bonus et compare « ma version vs la correction » verra un setup nettement plus chargé que le sien, sans avertissement local dans le fichier que « ceci inclut le Bonus 4 ».
- Conséquence concrète : si je copie le `01-anatomie.qmd` de la correction tel quel dans MON projet (réflexe naturel « je prends la correction qui marche ») **sans** avoir installé/chargé `prismatic`, le chunk plante au `library(prismatic)`. Le lien est fait dans le README et les préparatifs, mais pas dans le fichier que je copie.

Ce n'est pas un bloquant (hors séance, bien cadré ailleurs), mais un commentaire d'en-tête dans les `setup-*` des corrections du type « `# brand.yml + prismatic = Bonus 4 (optionnel) — voir preparatifs.qmd` » fermerait la dernière porte de confusion.

---

## 🔴 P0 — bloquant pour le 16 juin
Aucun. Le Bonus 4 est hors séance, replié, et clairement optionnel. Rien ne m'empêche de réussir l'atelier le 16.

## 🟠 P1 — à corriger avant le 16 juin
Aucun strictement bloquant. (Les éléments ci-dessous sont des frictions de compréhension, pas des blocages — voir P2.)

## 🟡 P2 — nice-to-have (pour rendre le bonus copiable sans friction)

1. **Expliquer `substr(…, 1, 7)` / `clr_darken`** — `2-projets/index.qmd:204`. Une demi-phrase sur le canal alpha `#RRGGBBAA` → `#RRGGBB`. Sinon je copie une incantation que je ne peux pas déboguer.
2. **Expliquer ou contextualiser `{{ col }}`** — `02-origines.qmd:43`. Le tunnel rlang n'apparaît que dans la correction, jamais expliqué. Au minimum un commentaire « nom de colonne nu » + exemple d'appel. Sinon `colorer_metrique(tbl, "n")` avec guillemets = mon erreur probable.
3. **Cohérence page ↔ correction sur `colorer_metrique`** — la page index inline `data_color()` (`:238-243`) mais la correction passe par un helper `colorer_metrique` (`02-origines.qmd:42-46`). Montrer le helper aussi dans la page, ou inliner aussi dans la correction.
4. **`theme_brand_gt`/`theme_brand_ggplot2` viennent de `brand.yml`, pas de `gt`** — `2-projets/index.qmd:192` (le `gt::` accolé prête à confusion). Une mention « du package `brand.yml` » lève le doute.
5. **Marqueur « Bonus 4 inclus » dans les `setup-*` des corrections** — `01-anatomie.qmd:9-10`, `02-origines.qmd:8-9`. Un commentaire d'en-tête évite le plantage `library(prismatic)` si je copie le fichier sans avoir le package.

## ✅ Ce qui me rassure (clarté pédagogique)

- **Cadrage optionnel exemplaire** : callout note `:173`, collapse replié `:189`, séparation « attendu de tous » / « pour les rapides » / approfondissement. Je sais exactement où est ma ligne d'arrivée.
- **« tableaux bruts = normal à l'étape 3 »** (`:61`) — m'évite de croire que j'ai raté quelque chose.
- **Piège silencieux `sw_yellow` vs `sw-yellow` documenté** (`:272-276`) — pile le genre de bug qui m'aurait fait perdre 15 min seul·e.
- **Commentaire-usage du helper** (`:231` `votre_table |> gt() |> … |> styliser_brand()`) — me donne le mode d'emploi sans lire les 15 lignes de `tab_options()`.
- **Prérequis `prismatic`/`brand.yml` bien dans `preparatifs.qmd:51`** — pas de package surprise.
- **Commentaires explicatifs partout dans les corrections** (`# Comptages bien répartis → dégradé`, `# Ligne 1 (Jabba) : rouge impérial — l'outlier EST l'histoire`) — je comprends les *choix de design*, pas juste le code. Excellent pour réviser le soir.
- **Image d'aperçu du tableau final** (`:270`) avec alt-text détaillé — je sais à quoi viser sans rendre quoi que ce soit.

---

## Résumé (5-8 lignes)

Le Bonus 4 est, du point de vue débutant·e, **bien cadré mais techniquement dense**. Le caractère optionnel est irréprochable : callout d'avertissement, bloc replié, séparation nette d'avec les étapes 1-3 « attendues de tous », et la mention explicite que des tableaux bruts à l'étape 3 sont le résultat normal. Un·e participant·e qui ignore le bonus s'en sort sans aucune gêne — verdict Q2 : 👍. Côté code (Q1 : ⚠️), il empile des concepts non expliqués qui me ralentiront à la copie : `substr(…,1,7)`/`clr_darken` (magie du canal alpha), le tunnel `{{ col }}` jamais présenté, et la confusion possible sur l'origine de `theme_brand_gt`. Rien ne casse au rendu — `prismatic` et `brand.yml` sont bien dans les préparatifs — donc **aucun P0/P1**. Cinq P2 le rendraient pleinement copiable : expliquer le `substr`/alpha, contextualiser `{{ col }}`, aligner page↔correction sur `colorer_metrique`, sourcer `theme_brand_gt` au package `brand.yml`, et marquer « Bonus 4 inclus » dans les `setup-*` des corrections pour éviter un plantage `library(prismatic)` au copier-coller.
