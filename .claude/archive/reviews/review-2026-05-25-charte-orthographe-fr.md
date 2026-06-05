# Review orthographe & typographie FR — 2026-05-25

**Périmètre** : pages site (`index.qmd`, `preparatifs.qmd`, `4-ressources.qmd`, `3-aller-plus-loin/`, `1-quarto-typst/`, `2-projets/`, `_charte/`) + slides + READMEs et `.qmd` des exercices (starter + correction). Hors périmètre : `README.md` racine, `review.md`, contenus `.claude/`. État courant : HEAD `d024d6c` (branche `claude/tutorial-review-charter-9H98W`).

## Verdict général

Le tutoriel est **prêt à être projeté** côté linguistique. Le sweep terminologique réalisé depuis la review du 14/05 a tenu : vouvoiement uniforme dans le contenu apprenant, accents propres (majuscules `À`, `É` présents partout), pluriels et accords corrects sur les nouvelles slides et boussoles, terminologie cohérente (charte / police / squelette / références croisées / chaîne / extension). Tous les apostrophes sont des `'` ASCII en source — c'est cohérent à 100 % et `lang: fr` + Pandoc `smart` les convertit en `’` à la sortie, donc rien à corriger là-dessus. Reste un petit lot de finitions : une vraie coquille de majuscule, trois anglicismes encore visibles dans des supports apprenant (« brandé », « deep dives », « setup / workaround »), quelques tournures à fluidifier, et une page (`3-aller-plus-loin`) qui accumule les termes anglais entre guillemets droits. Rien de bloquant.

## 🔴 P0 — bloquant

_Aucun._

## 🟠 P1 — à corriger avant le 16 juin

### Coquille majuscule oubliée

- `2-projets/2-projets.qmd:80` — « Démo live, 3 étapes en ~10 min. **à** l'étape 2 le PDF unique… »
  → « Démo live, 3 étapes en ~10 min. **À** l'étape 2 le PDF unique… »
  *(seule vraie coquille trouvée — majuscule manquante en début de phrase)*

### Anglicismes en prose apprenant (résidus du sweep)

- `2-projets/boussole.qmd:3` (subtitle), `:17` ; `2-projets/2-projets.qmd:96` ; `2-projets/index.qmd:47` — « PDF Typst **brandé** » → « PDF Typst **stylé** » ou « PDF Typst **personnalisé** » ou « PDF Typst **aux couleurs de la charte** ». *(« brandé » apparaît 4 fois sur du contenu visible apprenant, là où le reste du tuto dit « stylé » — cf. `1-quarto-typst/boussole.qmd:3` « PDF stylé avec Typst + _brand.yml ».)*

- `exercises/02-projet-book/starter/README.md:28` — « un livre PDF Typst unique, **brandé** » → idem, « **stylé** » ou « **personnalisé** ».

- `2-projets/index.qmd:166` — « **Les Bonus 3 et 4 ci-dessous sont des « deep dives »** » → « **sont des approfondissements** » (ou « des explorations détaillées »). *Le terme entre guillemets attire l'œil et casse le ton FR.*

- `2-projets/index.qmd:188` — « **Étape 1 — Setup.** Dans le chunk `setup-*` de chaque chapitre, ajoutez : » → « **Étape 1 — Mise en place.** Dans le bloc `setup-*`… » *(« Setup » en titre + « chunk » dans la phrase = deux anglicismes côte à côte. Le label `setup-anatomie` lui-même reste, c'est un identifiant.)*

- `preparatifs.qmd:16` — « le **workshop** signalera un **workaround** à appliquer » → « le **tutoriel** signalera un **contournement** à appliquer ». *(Double anglicisme dans la première phrase technique de la page de préparation — c'est la page d'accueil avant le jour J.)*

### Ponctuation et casse

- `_charte/charte-starwars.qmd:28` — sous-titre du PDF de charte distribué : « *Saga Star Wars* — **brand guidelines** pour l'atelier RR 2026 ». → « **charte graphique** pour l'atelier RR 2026 ». *(Le grand titre est déjà « CHARTE GRAPHIQUE » juste au-dessus ; laisser « brand guidelines » en sous-titre est une redondance + une rupture FR/EN sur le premier visuel que l'apprenant reçoit.)*

- `preparatifs.qmd:65` — « Suivi sur [**Github**] » → « Suivi sur [**GitHub**] » *(casse officielle ; le reste du site dit « GitHub »).*

- `2-projets/2-projets.qmd:106` *(note presenter, donc hors périmètre strict — mais à oraliser proprement : « les 3 étapes principales » plutôt que « les 3 core »)*.

## 🟡 P2 — nice-to-have

### Termes anglais entre guillemets dans `3-aller-plus-loin/index.qmd`

Cette page « post-tutoriel » accumule les anglicismes entre guillemets droits :

- `3-aller-plus-loin/index.qmd:16` : `### 1 — Blocs Typst "Raw"` → `### 1 — Blocs Typst « raw »` (guillemets français + minuscule, ou « Blocs Typst bruts »)
- `:21` : `depuis un bloc "raw"` → `depuis un bloc « raw »`
- `:22` : `propriétés CSS utilisables sur "spans" et "divs"` → « sur les *spans* et *divs* » (italique markdown au lieu de guillemets droits)
- `:26` : `### 2 — Template "partials"` → `### 2 — *Template partials*` ou `### 2 — Modèles « partials »`
- `:27` : `contrôler le "layout" du PDF` → « contrôler la **mise en page** du PDF »
- `:30` : `: "layout" du document` → `: mise en page du document`
- `:44` : `⚠️ Les Typst 'books' ne sont pas encore compatibles UA-1` → `⚠️ Les Typst **books** ne sont pas encore compatibles UA-1` *(guillemets simples ASCII `'…'` anormaux en FR ; italique markdown ou guillemets `«…»`)*

→ Le réflexe « guillemets droits autour d'un terme anglais » est très visible sur cette seule page. À uniformiser : italique markdown `*…*` pour les termes anglais conservés, ou traduction.

### Tournures à fluidifier

- `2-projets/index.qmd:41` — « L'Exercice 2 est **autonome vis-à-vis de l'Exercice 1** » → « L'Exercice 2 est **indépendant de l'Exercice 1** » *(« autonome vis-à-vis » est lourd, « indépendant de » plus direct).*

- `preparatifs.qmd:50` — « Si la version de quarto n'est pas celle attendue, **alors utilisez** … » → « Si la version de quarto n'est pas celle attendue, **utilisez** … » *(le « alors » est un calque de « then » ; en FR on enchaîne directement.)*

- `preparatifs.qmd:16` — « le tutoriel signalera un contournement à appliquer **à l'étape de l'exercice 2** » → « **à l'étape concernée de l'exercice 2** » ou « **à un moment de l'exercice 2** » *(formulation actuelle ambiguë : « l'étape de l'exercice » se lit comme « il y a une seule étape »).*

- `4-ressources.qmd:36` — déjà signalé le 14/05, non corrigé : « retour d'expérience **d'une** migration pagedown → Typst **côté** R ». Suggestion identique : « retour d'expérience **sur une** migration pagedown → Typst **en** R ».

- `1-quarto-typst/1-quarto-typst.qmd:97` — « **Erreurs lisibles** — fini les messages LaTeX cryptiques » : « fini » invariable est OK, mais registre plus parlé que le reste de la slide. Alternative : « **adieu les messages LaTeX cryptiques** » ou « **terminés, les messages LaTeX cryptiques** ».

- `preparatifs.qmd:45` — commentaire R `# 1.9.37 mini, 1.10.x prerelease recommandée` → `# 1.9.37 minimum, 1.10.x pre-release recommandée` *(« mini » abréviation/anglicisme).*

### Vérification de cohérence verbale (à confirmer, pas une faute)

Les boussoles utilisent l'infinitif (« Ajouter », « Régler », « Créer »), les slides Your Turn utilisent l'impératif (« Ouvrez », « Ajoutez », « Créez »). Volontaire pour distinguer support de référence vs consigne dictée en live ? Si oui, c'est nickel et cohérent (vérifié sur les deux blocs).

### Guillemets droits sur noms de sections doc

`1-quarto-typst/index.qmd:72-76` et `2-projets/index.qmd:79-83` — sections « Indices doc » avec `"Overview"`, `"Format Options"`, `"Color"`, `"Typography"`, `"Project Metadata"`, `"Project-level brand"`, `"Figures"`, `"Sections"`. Techniquement OK (Pandoc `smart` les transformera en `«…»` à la sortie), mais l'italique markdown (`*Overview*`, `*Format Options*`) serait plus standard pour pointer un nom de section de doc anglophone.

`2-projets/boussole.qmd:32`, `1-quarto-typst/boussole.qmd:29`, `2-projets/index.qmd:90`, `1-quarto-typst/index.qmd:82` — « le **"Vous devriez voir"** de l'étape » : guillemets droits convertis en `«…»` par Pandoc, OK. Optionnel : utiliser directement les guillemets français en source.

## ✅ Forces linguistiques

- **Aucune apostrophe `’` typographique en source** — tout est en `'` ASCII et Pandoc + `lang: fr` (vérifié dans `_quarto.yml:34`) convertit automatiquement à la sortie. Cohérence à 100 % (`grep -rn '’'` retourne zéro). C'est la bonne stratégie de source : auteur tape vite, sortie reste propre.
- **Vouvoiement uniforme** dans le contenu apprenant. Grep `\b(tu|toi|ton|ta|tes)\b` ne ramène qu'une occurrence dans `review.md`, hors périmètre.
- **Majuscules accentuées correctes partout** (`À propos`, `À vous !`, `À la fin de ce bloc`, `À elles deux`, `Élargissons`). Aucun `A` ou `E` non accentué en début de phrase ou de titre.
- **Aucune forme courte « Fig. » / « Tab. »** — la note presenter `2-projets/2-projets.qmd:82` mentionne explicitement « en français Quarto rend "Figure" et "Table" — pas "Fig" / "Tab" ». Cohérent sur slides (`2-projets/2-projets.qmd:57`) et tableau exercice (`2-projets/index.qmd:56`) : « Figure 1.1 / Figure 2.1 / Table 1.1 / Table 2.1 ».
- **Aucun doublon de mot** détecté (`le le`, `la la`, etc.) en prose.
- **Faux amis** : `effectivement` (`exercises/02-projet-book/*/annexe-donnees.qmd:20`) au sens FR « réellement » — correct. Pas de `actuellement` = `currently`, pas de `supporter` = « prendre en charge ».
- **Écriture inclusive cohérente** : point médian sur `prêt·e`, `parti·e`, `participant·e·s` partout. Aucune forme `prêt(e)` ou `prêt.e`.
- **Tirets cadratins `—`** systématiques pour les incises.
- **Terminologie technique** uniforme : « charte » (pour brand), « police » (pour font), « squelette » (pour scaffold, cf. `4-ressources.qmd:143`, `3-aller-plus-loin/index.qmd:39`, `2-projets/2-projets.qmd:119`), « références croisées » (pour cross-refs, cf. `2-projets/2-projets.qmd:84`, `2-projets/index.qmd:35`), « repli » (pour fallback dans `preparatifs.qmd:65`).
- **Star Wars en deux mots avec majuscules** — cohérent (`Star Wars`, `Star Jedi`, jamais « starwars » ou « star wars » en prose).
- **« GitHub »** avec G et H majuscules : cohérent (sauf `preparatifs.qmd:65` `Github`, signalé en P1).
- **Pas d'espacement avant `:`, `;`, `?`, `!`, `»`** ajouté à la main : conforme aux consignes (Pandoc/Typst gère via `lang: fr`).

## 📝 Évolution depuis la review précédente

**Périmètre couvert le 14/05** : seulement la slide « C'est quoi Typst ? » + une ligne de `4-ressources.qmd`. **Périmètre couvert le 25/05** : ~25 fichiers `.qmd`/`.md` (toute la matière apprenant).

- ✅ **Corrigé** depuis le 14/05 : « PDFs » → « PDF », redondance « Embarqué dans Quarto / Rien à installer » résolue (`1-quarto-typst/1-quarto-typst.qmd:95`), « à votre place » remplacé par formulation neutre, « la traduction vers Typst se fait toute seule » → « est automatique » (l. 44). Tous les P1/P2 du 14/05 ont été traités.
- ⏸️ **Pas corrigé depuis le 14/05** : `4-ressources.qmd:36` (« retour d'expérience d'une migration pagedown → Typst côté R »). Toujours un P2.
- 🆕 **Nouveau contenu — qualité linguistique très propre** : la `charte-starwars.qmd`, les deux pages `boussole.qmd`, les READMEs starter/correction des deux exos, la refonte des slides Your Turn, les bonus B3/B4 sont tous propres à de rares exceptions près (listées en P1/P2 ci-dessus). Le seul vrai écart par rapport à la qualité du reste : les 4 occurrences de « brandé » qui se sont glissées dans Bloc 2 + README starter exo 2, et la persistance des `"raw"`/`"layout"`/`"partials"` entre guillemets droits dans `3-aller-plus-loin/index.qmd`.
- 🎯 **La seule vraie coquille ortho de cette livraison** : `2-projets/2-projets.qmd:80` minuscule après point.

---

**Total à corriger pour atteindre la propreté workshop** : ~10 lignes dans 6 fichiers. Tout le reste est au niveau attendu pour un public R francophone professionnel.
