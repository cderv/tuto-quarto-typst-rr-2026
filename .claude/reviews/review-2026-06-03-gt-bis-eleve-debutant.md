# Review Bonus 4 (branding gt/ggplot2) — point de vue élève débutant

**Date** : 2026-06-03
**Branche** : `claude/r-tutorial-feedback-Tsyfd` (PR #14)
**Profil** : 2-3 ans de R/RStudio, R Markdown occasionnel, jamais Quarto en projet ni Typst, à l'aise dplyr/ggplot2/gt, jamais touché aux extensions ni `_brand.yml`.
**Scénario joué** : fin d'Exo 2, j'ouvre la correction pour comparer, et je jette un œil au Bonus 4 (que je tenterais éventuellement après l'atelier).

> Note : `review-2026-06-03-gt-eleve-debutant.md` existait déjà. Tag `bis` pour ne pas l'écraser.

---

## Verdict général

Le Bonus 4 est **clairement balisé comme optionnel et « après l'atelier »** (callout-note avant, callout-tip `collapse="true"`, mention « approfondissements » répétée 3x). En tant que débutant qui ne fait QUE comparer la correction de base, je ne suis pas perdu : les étapes 1-3 principales restent simples et le code de base reste lisible **si** je sais que je peux ignorer le helper `styliser_brand`. En revanche, **si je tente vraiment de copier le Bonus 4**, deux ou trois bouts de code me font peur sans être expliqués, et il y a un vrai piège prismatic/version. Rien de bloquant pour le 16 juin (c'est hors-séance), mais quelques frictions à lisser.

---

## Question 1 — Est-ce trop compliqué ? ⚠️

Pas « trop » pour de la lecture comparative, mais plusieurs morceaux dépassent mon niveau de confort si je veux les **copier et comprendre**.

### Ce qui me fait peur / me bloque

1. **`teinte <- function(x, f) substr(as.character(clr_darken(pal(x), f)), 1, 7)`**
   `2-projets/index.qmd:204`, correction `01-anatomie.qmd:14`, `02-origines.qmd:12`, `rapport-starwars.qmd:40`.
   C'est la ligne la plus intimidante du lot. Trois fonctions imbriquées + un `substr(..., 1, 7)` « magique » dont je ne devine pas le rôle. Le commentaire dit « sans hex magique » mais le `1, 7` EST un nombre magique non expliqué : un débutant ne sait pas que `clr_darken()` renvoie un objet `color` dont `as.character()` produit `"#RRGGBBAA"` (8 chiffres) et qu'on coupe l'alpha pour garder `#RRGGBB`. **Si je copie ça et que ça marche, tant mieux ; si ça casse, je suis incapable de débugger.** Une demi-phrase (« on coupe la composante alpha que gt ne sait pas lire ») suffirait.

2. **`{{ col }}` (tunnel rlang) dans `colorer_metrique`**
   `02-origines.qmd:42-46`. Présenté différemment dans `2-projets/index.qmd:238-243` : le support web montre `data_color(columns = n, ...)` **en dur**, pas le helper `colorer_metrique`. Donc en passant du support à la correction pour comparer, je découvre un `{{ col }}` jamais mentionné. Pour un débutant, `{{ }}` est du chinois (curly-curly / tidyeval = concept avancé). **Friction de cohérence support→correction** : le web montre la version inline, la correction la version helper. Ce n'est pas faux, mais je ne fais pas le lien seul, et le helper me paraît plus compliqué que nécessaire.

3. **Le helper `styliser_brand <- function(t) { t |> ... }`**
   `index.qmd:210-229`, identique dans les 3 corrections. Long pipe de ~20 lignes avec `tab_options()` à 9 arguments. En lecture c'est OK (« le gros bloc de style »), mais **copiable seulement en bloc** : si je veux n'en garder qu'un morceau, je ne sais pas lesquels sont essentiels vs cosmétiques. Pas bloquant pour comparer.

4. **Prérequis `prismatic` — le piège le plus concret.**
   `prismatic` EST bien dans `preparatifs.qmd:51` et signalé optionnel dans `README.md:10`. **Mais** : celui qui revient chez lui un mois après, prend la correction et la rend → si `prismatic`/`brand.yml` ne sont pas chargés, **erreur `could not find function "clr_darken"` / `read_brand_yml"` dès le chunk setup**, donc **tout le chapitre échoue à rendre**, pas juste le tableau. Or le Bonus 4 dit « à explorer après l'atelier » : c'est exactement le moment où je risque de ne plus avoir l'environnement complet. Le lien prérequis n'est **que dans le README, pas dans le callout Bonus 4 du support web** lui-même.

### Ce qui va bien malgré la complexité

- `pal <- function(x) brand_color_pluck(brand, x)` est un raccourci compréhensible et bien commenté.
- Le piège `sw_yellow` vs `sw-yellow` (normalisation `_` au read) est **explicitement documenté** (`index.qmd:272-276`). Exactement le genre de typo qui me coûterait 10 min, désamorcé d'avance. 👍
- Les commentaires de la correction (`01-anatomie.qmd:73-74` « l'outlier EST l'histoire ») expliquent le *pourquoi* du choix visuel, pas juste le *comment*. Rassurant.

**Verdict Q1 : ⚠️** — Lisible pour comparer, mais 2 lignes (`teinte`/`substr 1,7` et `{{ col }}`) dépassent le niveau débutant sans explication, et le risque « prismatic absent → chapitre entier casse » est réel pour quelqu'un qui revient après l'atelier.

---

## Question 2 — Reste-t-il dans la logique « bonus optionnel » ? 👍

Oui, c'est la partie la mieux gérée.

### Ce qui marque bien le caractère optionnel

- `index.qmd:173-175` : callout-note **« Les Bonus 3 et 4 ci-dessous sont des approfondissements — à explorer après l'atelier si vous manquez de temps en séance. »** Net.
- Tableau des 3 étapes principales (`index.qmd:54-61`) : **« attendues de tous »**, et la ligne 3 précise *« Les tableaux `gt` restent bruts à ce stade — leur mise aux couleurs de la charte est l'objet du Bonus 4. »* → je comprends que les tableaux non-stylés sont l'état NORMAL attendu, pas un échec de ma part. 👍 Très bon désamorçage.
- README `02-projet-book/README.md:10` : « Pour le Bonus 4 (optionnel, brand styling avancé) ». Le mot **avancé** est honnête et me rassure (« normal que ce soit dur »).
- Bonus 4 dans un callout `collapse="true"` → replié par défaut.

### Le débutant qui NE fait PAS le Bonus comprend-il la correction de base ?

**Demi-réserve.** La correction (`01-anatomie.qmd`, `02-origines.qmd`, `rapport-starwars.qmd`) **applique le Bonus 4 partout, en dur**. Il n'existe pas de version « correction de base sans branding » à comparer. Donc « je fais les étapes 1-3, j'ouvre la correction pour comparer » donne :

- Mon résultat : tableaux `gt` **bruts** (comme annoncé ligne 3 du tableau).
- La correction : tableaux **entièrement brandés** (`styliser_brand`, `colorer_metrique`, `data_color`, `clr_darken`...).

→ Visuellement **ma sortie ne ressemble PAS à la correction**, alors que j'ai « tout bien fait » pour les étapes attendues de tous. Le support prévient (ligne 3 + callout « approfondissements »), donc je ne panique pas *si j'ai lu*. Mais en condition réelle pressée : tableaux rouges/jaunes/crème dans la correction, les miens gris → réflexe « j'ai raté un truc ». Et si je copie naïvement un chapitre de correction comme « modèle de base », j'embarque tout le Bonus 4 sans le vouloir (+ le risque prismatic du Q1).

**Suggestion** (P2) : une phrase dans le callout Correction (`index.qmd:280-284`) du type « ⚠️ La correction intègre déjà le Bonus 4 : ses tableaux sont plus stylés que ce qui est attendu aux étapes 1-3. Vos tableaux bruts sont un résultat correct. »

**Verdict Q2 : 👍** (réserve « pas de correction de base nue » → ⚠️ léger) — Le caractère optionnel est très clairement signalé ; étapes 1-3 simples ; le support dit que les tableaux bruts sont normaux. Seul angle mort : la correction = version « tout branding », d'où un écart visuel qui pourrait inquiéter qui n'a pas lu les avertissements.

---

## 🔴 P0 — bloquant pour le 16 juin

**Aucun.** Le Bonus 4 est hors-séance, optionnel, replié. Rien ne casse le déroulé du jour J.

## 🟠 P1 — à corriger avant le 16 juin

- **Rappel prérequis dans le callout Bonus 4 lui-même.** `index.qmd:190-205` (étape 1) : ajouter « (nécessite `brand.yml` + `prismatic` — cf. preparatifs) ». Aujourd'hui le lien prérequis n'est que dans le README. Quelqu'un qui retente le bonus après l'atelier sans `prismatic` aura `could not find function "clr_darken"` → **le chapitre entier ne rend plus**, message opaque pour un débutant.

## 🟡 P2 — nice-to-have

- **Expliquer le `substr(..., 1, 7)`** (`index.qmd:204` + 3 corrections). Demi-phrase : « on coupe l'alpha `#RRGGBBAA` → `#RRGGBB` que gt attend ».
- **Cohérence support↔correction sur la métrique.** Le web montre `data_color(columns = n, ...)` en dur (`index.qmd:238-243`), la correction le helper `colorer_metrique(n)` avec `{{ col }}` (`02-origines.qmd:42`). Mentionner « la correction en fait un helper réutilisable (tidyeval `{{ }}`) » ou aligner.
- **Avertir que la correction = Bonus 4 inclus** (callout Correction `index.qmd:280-284`).

## ✅ Ce qui me rassure (clarté pédagogique débutant)

- Triple signalisation du caractère optionnel (callout-note + « attendues de tous » + collapse). Pas de pression.
- Ligne 3 du tableau d'étapes : « les tableaux restent bruts à ce stade » → mes tableaux gris sont normaux, dit noir sur blanc.
- Callout « Piège silencieux » `sw_yellow` vs `sw-yellow` (`index.qmd:272-276`) : pile la typo qui me coûterait du temps, désamorcée.
- `prismatic`/`brand.yml` bien dans `preparatifs.qmd:51` et README signalé « optionnel/avancé ».
- Commentaires « pourquoi » dans la correction (outlier vs dégradé).
- Image d'aperçu (`index.qmd:270`) + alt-text décrivent précisément le rendu cible : je sais à quoi le tableau brandé doit ressembler sans le rendre.

---

## Résumé (5-8 lignes)

Le Bonus 4 est **bien rangé comme optionnel et hors-séance** : triple avertissement, callout replié, et le support dit explicitement que mes tableaux bruts (étapes 1-3) sont le résultat normal — donc **rien de bloquant pour le 16 juin** (Q2 : 👍). En lecture comparative je m'en sors. Mais si je tente de copier le code, deux lignes dépassent mon niveau sans explication — le `substr(clr_darken(...), 1, 7)` (alpha coupé « magiquement ») et le `{{ col }}` du helper `colorer_metrique`, ce dernier n'apparaissant même pas dans le support web (friction support↔correction) — d'où Q1 : ⚠️. Le vrai piège concret : `prismatic`/`brand.yml` sont prérequis mais le rappel n'est que dans le README, pas dans le callout Bonus 4 ; qui retente le bonus après l'atelier sans ces packages aura `could not find function "clr_darken"` qui fait échouer **tout le chapitre** (seul P1). Enfin, la correction intègre le Bonus 4 partout : pas de version « base nue » à comparer, d'où un écart visuel mes-tableaux-gris vs correction-colorée qui pourrait inquiéter sans lecture des avertissements (P2). **0 P0, 1 P1, 3 P2.**
