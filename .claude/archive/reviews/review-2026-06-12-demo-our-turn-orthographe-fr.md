# Review ortho-FR — Démo Our turn Exo 1 (couleurs de la charte)

> Relecture francophone du plan `.claude/plans/2026-06-12-demo-our-turn-couleurs.md`, focus **Q4 du §6** (justesse du wording de remplacement) + cohérence terminologique et typographie FR sur les passages qui vont changer.
> Date : 2026-06-12. Périmètre : `1-quarto-typst/1-quarto-typst.qmd`, `1-quarto-typst/index.qmd`, `1-quarto-typst/boussole.qmd`.
> **Aucune source modifiée**, aucun commit.

## Verdict général

La langue du périmètre est déjà au niveau workshop pro : prose claire, vouvoiement constant (« Ouvrez », « Créez », « Passez »), typographie FR propre (guillemets `«  »`, apostrophes courbes `'`, tirets cadratins). Le wording de remplacement proposé au §4.1 (« le document prend les couleurs de la charte (fond crème, texte sombre) ») est **juste, naturel et correct** — je propose surtout 2-3 variantes affinant la nuance « avant-goût » et la cohérence avec « rôles ». Le vrai point d'attention n'est pas orthographique mais **terminologique** : si la démo bascule sur `background`+`foreground` mais que le snippet/wording garde `primary`, on crée une incohérence interne entre slide, page et boussole. À cadrer avant le 16 juin.

## Réponse à Q4 — la formule de remplacement est-elle juste ?

**Oui.** « le document prend les couleurs de la charte (fond crème, texte sombre) » est :
- **juste techniquement** vis-à-vis de la décision §4.1 (`background` crème + `foreground` sombre) ;
- **naturel** côté débutant : « prend les couleurs de la charte » dit l'effet visible sans jargon ;
- **typographiquement correct** : pas de souci d'accent (« crème » bien accentué), parenthèse explicative bien formée.

Deux réserves de nuance :

1. **« texte sombre » vs « texte noir ».** Le plan parle ailleurs de « texte sombre » (juste, car `#0B0B0F` ≠ noir pur) — bon choix, plus honnête que « noir ». À garder tel quel, ne pas régresser vers « noir ».
2. **« couleurs » au pluriel** alors que la démo ne pose que **deux rôles** (fond + texte). Acceptable (la *charte* a bien plusieurs couleurs, le doc en « prend » une partie), mais on peut être plus précis. Voir variantes.

### Variantes proposées (par ordre de préférence)

- **V1 (recommandée, garde l'idée d'avant-goût) :**
  `→ le document adopte les couleurs de la charte : fond crème, texte sombre`
  *(« adopte » un peu plus actif que « prend » ; deux-points au lieu de la parenthèse = plus fluide à l'oral en démo. Pas d'insécable à forcer, `lang: fr` gère.)*

- **V2 (la plus fidèle au plan, minimale) :**
  `→ le document prend les couleurs de la charte (fond crème, texte sombre)`
  *(le wording du §4.1 tel quel — parfait si on ne veut rien arbitrer).*

- **V3 (insiste sur l'« avant-goût », cohérent avec les notes orateur l.300/310) :**
  `→ un premier aperçu de la charte : fond crème, texte sombre`
  *(évite le mot « couleurs » au pluriel discutable ; « aperçu » fait écho à « avant-goût » du plan §4.1 et à la logique Our turn = minimal).*

À éviter : « le document se colore » (faux/ambigu — on ne colore justement pas tout), et « titres et liens colorés » (le wording actuel, doublement faux d'après §1 du plan).

## Cohérence terminologique sur l'exo

### 🟠 P1 — Risque d'incohérence `primary` vs `background`/`foreground` après le changement

Le terme « charte » et la liste de rôles `primary / foreground / background` sont **déjà parfaitement homogènes** entre les trois fichiers (slide l.272 et l.260, page l.52 et l.62, et la consigne). C'est une force. **Mais** le changement du §4 introduit une tension à surveiller :

- Si la démo Our turn bascule sur `background`+`foreground` (§4.1), il faut mettre à jour **de façon synchrone** :
  - `1-quarto-typst.qmd:283` (« + rôle `primary` … → titres et liens colorés »)
  - `1-quarto-typst.qmd:285-290` (snippet `_brand.yml` qui ne contient que `primary: imperial-red`)
  - `1-quarto-typst.qmd:306-307` (snippet dupliqué dans les notes orateur)
  - `index.qmd:37` (« + `primary` … → titres et liens colorés »)
  - éventuellement la note orateur `1-quarto-typst.qmd:310` (« rôles `foreground` + `background` » côté Your turn — déjà mentionnés là, donc cohérent si la démo les introduit).
- **Piège** : laisser `primary` dans le snippet mais écrire « fond crème, texte sombre » dans le wording = snippet et promesse qui ne correspondent plus. C'est le défaut symétrique du bug actuel. Les deux snippets (l.285-290 et l.303-308) doivent rester **identiques** entre eux et **cohérents** avec le wording.

### 🟡 P2 — Si on ajoute la consigne « ajoutez `primary` pour colorer les liens » (§4.3)

Bon ajout pédagogique, mais attention à la **formulation** pour ne pas re-promettre du faux :
- Variante propre : « → une fois des liens présents dans le texte, ajoutez le rôle `primary` pour les **colorer** ».
- Éviter « colorer les liens » seul si le starter n'a pas encore de lien au moment où la consigne est lue (sinon même piège que §1.2 du plan). Lier explicitement à l'ajout de liens (§4.2).
- Emplacement (boussole vs Our turn, question Q2) : côté langue, la **boussole** est plus avare en mots (étape « Créer `_brand.yml` (couleurs + police Google + logo) », `boussole.qmd:31`). Y glisser `primary` alourdirait peu. Mais si la démo Our turn est l'endroit où l'effet se *voit*, le wording y est plus naturel. Recommandation FR : une seule mention de `primary`+liens, dans Our turn, pour ne pas disperser le terme.

### Cohérence « charte » / « couleurs de la charte »

- « charte » (au sens *brand*) est employé uniformément — aucun résidu d'anglicisme « brand » en prose. ✅
- Le nouveau syntagme « couleurs de la charte » s'insère sans heurt dans ce champ lexical déjà posé (l.292 « la charte complète », l.272 « la charte »). Pas de néologisme concurrent à craindre.

## Typographie & anglicismes sur les passages qui changent

Aucun problème dans les passages cibles. Vérifications :

- **Espaces insécables** (`:` `;` `!` `?`) — rien à forcer, `lang: fr` (Pandoc/Typst) s'en charge ; la parenthèse de la formule de remplacement n'a pas de ponctuation haute à risque. ✅
- **Apostrophes** : courbes partout dans la prose (« l'effet », « d'une », `index.qmd:34`). Le wording de remplacement n'introduit pas d'apostrophe. ✅
- **Guillemets** : `«  »` corrects (`index.qmd:42`, `1-quarto-typst.qmd:270`). ✅
- **Anglicismes** : « rôles » (et non « assignments » en prose, la VO étant explicitement réservée à la note orateur l.272), « charte » (et non « brand »), « avant-goût » (et non « teaser ») — tout est francisé en prose. La formule de remplacement n'en ajoute aucun. ✅
- **« crème »** : bien accentué partout (alt-text l.254 inclus). ✅

## Forces linguistiques

- Vouvoiement strict en prose, tutoiement confiné aux notes orateur (hors périmètre) — `1-quarto-typst.qmd:310` « à vous avec la charte complète » est dans `::: notes`, donc OK.
- Terminologie `primary / foreground / background` listée à l'identique entre slide, page et consigne : modèle de cohérence inter-fichiers.
- Le plan lui-même est rédigé dans un FR soigné (« avant-goût », « réflexe de base », « filet final ») — le wording proposé s'inscrit dans ce registre.

## Récapitulatif

| Priorité | Point |
|---|---|
| 🔴 P0 | — (aucun) |
| 🟠 P1 | Synchroniser snippet `_brand.yml` + wording sur les 4-5 emplacements lors du passage `primary` → `background`/`foreground` (ne pas recréer l'incohérence inverse) |
| 🟡 P2 | Formuler la consigne `primary`+liens en la liant à l'ajout de liens (éviter une promesse vide) ; choisir un seul emplacement pour `primary` |

**Réponse synthétique à Q4 :** la formule est bonne ; adopter **V1** (« le document adopte les couleurs de la charte : fond crème, texte sombre ») ou **V3** si l'on veut éviter le pluriel « couleurs » et renforcer la logique « aperçu/avant-goût ».
