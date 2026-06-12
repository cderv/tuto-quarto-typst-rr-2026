# Review — Démo "Our turn" Exo 1 (couleurs qui ne "prennent" pas)

**Date :** 2026-06-12
**Profil :** participant·e débutant·e (R/RStudio 2-3 ans, R Markdown occasionnel, jamais Quarto en projet, jamais `_brand.yml`, jamais Typst).
**Portée :** plan `.claude/plans/2026-06-12-demo-our-turn-couleurs.md` (§6, questions ouvertes) + démo "Faisons ensemble !" (`1-quarto-typst/1-quarto-typst.qmd:275-311`), section Our turn (`1-quarto-typst/index.qmd:32-39`), étape 3 (`index.qmd:62`), boussole (`boussole.qmd`), starter (`exercises/01-document-typst/starter/rapport-starwars.qmd`).

---

## Verdict général

Le diagnostic du plan est juste et me parle directement : en tant que débutant·e, « j'édite le YAML et rien ne bouge » est exactement le moment où je me dis « j'ai dû me planter » et où je perds 5 minutes à chercher une faute qui n'existe pas. Le choix `background` + `foreground` (option 1) est plus rassurant qu'un effet `primary` invisible, **mais seulement si on me dit explicitement quoi regarder et à quoi je dois m'attendre**. Le wording proposé « le document prend les couleurs de la charte (fond crème, texte sombre) » est compréhensible mais encore un peu trop doux : un fond crème `#F5F0E1` en projection, sur 30 personnes au fond de la salle, je ne suis pas sûr·e de le voir, et donc pas sûr·e d'avoir réussi. Et la consigne `primary` pour les liens m'expose au même piège que Maëlle si les liens sont peu visibles. Globalement : la direction est bonne, il faut juste **rendre le succès indéniable et anticiper mon doute à voix haute**.

---

## Réponses aux questions ouvertes du §6 (mon point de vue)

### Q4 — « le document prend les couleurs de la charte (fond crème, texte sombre) » : clair et rassurant, ou trop vague ?

**Compréhensible, mais le mot « charte » me fait tiquer et le « avant-goût » risque de me décevoir.**

- « la charte » : à ce stade de la démo, je n'ai pas encore manipulé la charte moi-même. Je vois bien le `charte-starwars.pdf` projeté à côté (notes orateur `:300`), mais dans ma tête « la charte » c'est ce gros PDF rouge avec le logo et les titres Star Jedi. Si on me dit « le document prend les couleurs de la charte » et que je vois juste un fond légèrement crème + du texte qui reste noir-ish, je vais me dire « euh, ce n'est pas du tout comme la charte projetée à côté ». **L'écart entre la promesse (« les couleurs de la charte ») et le rendu (deux nuances très subtiles) crée du doute.**
- Suggestion de wording côté débutant : être littéral plutôt qu'évocateur. Quelque chose comme « → **le fond passe en crème et le texte en gris très foncé** (deux réglages de la charte ; le reste — rouge, logo, police Star Jedi — c'est votre exercice juste après) ». On me dit exactement les deux choses qui changent, et on me prévient que le reste viendra, donc je ne crois pas avoir raté le rouge/le logo.
- Le mot « couleurs » au pluriel pour deux réglages dont l'un (`foreground`) est un quasi-noir me semble survendre. « fond crème + texte sombre » dans le détail est bien ; c'est le chapeau « les couleurs de la charte » qui promet plus que ce que je vais voir.

### Q (implicite) — Si on me dit « ajoutez `primary` pour colorer les liens » et que je ne vois pas de différence, vais-je croire avoir raté quelque chose ?

**Oui, très probablement — c'est le risque n°1.** C'est exactement le scénario de Maëlle (`plan:8`), et elle, elle connaît le sujet. Moi, je suis encore moins armé·e pour faire la différence entre « ça n'a pas marché » et « ça a marché mais c'est discret ».

Trois pièges concrets qui vont me faire douter :
1. **Lien peu visible.** Si le lien `primary` (#BC1E22, un rouge sombre) tombe sur un fond crème, et que par-dessus le marché le lien n'est pas souligné, je ne distingue pas un lien rouge d'un texte foncé. Je vais relire mon YAML 3 fois.
2. **Y a-t-il seulement un lien dans le doc ?** Le plan le note bien (`plan:13`) : le starter actuel (`rapport-starwars.qmd`) **n'a aucun lien en prose**. J'ai relu les lignes 21, 50, 76 — texte brut, zéro `[...](...)`. Donc si on ajoute la consigne `primary` **sans** ajouter les liens au starter, c'est garanti : je pose `primary`, **rien ne change**, et je suis convaincu·e d'avoir fait une erreur. → **L'action 2 du plan (ajouter des liens au starter) n'est pas optionnelle si on garde la consigne `primary`. C'est un prérequis.**
3. **Où est le lien dans la page ?** Même avec un lien ajouté, si c'est `dplyr::starwars` au milieu du §Introduction (`:21`), en projection je ne vais pas le repérer tout seul. Il faut me dire « regardez le mot *starwars* dans la première phrase, il est maintenant rouge ».

### Q (implicite) — Qu'est-ce qui me ferait dire « ah, ça marche ! » à l'écran ?

Par ordre de force de signal pour un·e débutant·e en projection :

1. **Un changement de couleur franc sur un élément que je peux pointer du doigt.** Le truc le plus convaincant serait des **titres colorés** (`typography.headings.color`, que le plan confirme fonctionnel, `plan:26-29`) : « Introduction », « Top 5… », « Conclusion » qui passent en rouge d'un coup, c'est gros, c'est immédiat, zéro ambiguïté. *Mais* ça casse l'arc Bloc 1→Bloc 2 (cf. Q1 ci-dessous).
2. **Un avant/après côte à côte.** Si pendant la démo on garde le PDF brut (blanc, texte noir) visible et qu'on affiche le nouveau à côté, même un fond crème subtil devient évident *par comparaison*. Seul, je ne sais pas si le fond a toujours été comme ça.
3. **Qu'on me dise explicitement quoi regarder** AVANT le re-rendu : « regardez le fond blanc ici, et le lien *starwars* ici — au prochain rendu, le fond devient crème et ce lien devient rouge ». Si on annonce la cible avant, le moindre changement est une victoire ; si on rend d'abord et qu'on dit « voilà », je cherche.

Un fond crème **seul** ne me fera pas dire « ah ça marche ! » spontanément — au mieux « ah… ok ? ». Il me faut soit un élément à fort contraste, soit un avant/après, soit un pointage explicite.

### Q1 — Titres colorés dans la démo (au prix de casser l'arc Bloc 1→Bloc 2) ?

Côté débutant, **les titres colorés sont de loin le signal le plus rassurant** — c'est ce qui me ferait dire « ça marche » sans hésiter. Mais je comprends la tension : l'étape 3 (`index.qmd:62`) promet explicitement « *Les titres restent en `foreground` noir — la couleur `primary` sur les titres arrivera avec le livre, au Bloc 2* ». Si la démo Our turn colore les titres et que l'exo me dit « les titres restent noirs », je vais être **perdu·e** : « tout à l'heure les titres étaient rouges dans la démo du formateur, pourquoi les miens doivent rester noirs ? J'ai loupé un réglage ? ». → **Colorer les titres dans la démo SANS réconcilier avec l'étape 3 créerait une nouvelle incohérence visible**, pire que le problème actuel.

Mon arbitrage de débutant·e : si vous voulez le signal fort des titres, il faut l'assumer partout (démo + étape 3 + correction) et abandonner l'arc « titres au Bloc 2 ». Si vous tenez à l'arc, **gardez `background`+`foreground` mais compensez la subtilité par un avant/après projeté et un pointage explicite** (cf. ma réponse à la question précédente). Ce que je déconseille fortement : titres colorés dans la démo + « titres restent noirs » dans mon exo.

### Q2 — Où poser `primary` + les liens : boussole / Our turn / page Exercice ?

Pour moi, peu importe l'emplacement *tant que les trois sont cohérents*. Aujourd'hui ils divergent déjà :
- Our turn deck (`:283`) : « une seule couleur + rôle `primary` → titres et liens colorés »
- Our turn page (`index.qmd:37`) : idem « → titres et liens colorés »
- Boussole (`:31`) : étape 3 = « Créer `_brand.yml` (couleurs + police Google + logo) » — **ne parle ni de `primary`, ni de liens, ni de titres**.

Si la boussole (mon panneau de référence en second écran pendant que je bosse) ne mentionne pas `primary`/liens mais que la page le promet, je ne saurai pas ce que je suis censé·e obtenir. **Recommandation débutant : la démo Our turn n'a pas besoin de me faire poser `primary` moi-même** (c'est l'exo) ; gardez `primary`+liens comme un point que LE FORMATEUR montre, et assurez-vous que l'étape 3 de l'exo (où JE le fais) soit exacte. Le « réflexe de base » (étape 1 seule, `index.qmd:54`) est très bien — ne le noyez pas en me demandant `primary` trop tôt.

### Q3 — Synchroniser la correction avec des liens ?

**Oui, absolument, si l'étape 3 garde « Liens colorés en imperial-red » (`index.qmd:62`).** Sinon, quand je bloque et que j'ouvre la correction (le filet de sécurité prévu, `index.qmd:106`), je vais comparer son PDF au mien, chercher les fameux « liens colorés » promis… et n'en trouver aucun dans la correction non plus. Là je me dis « soit la correction est fausse, soit je n'ai rien compris » — les deux sont anxiogènes. La cohérence starter↔étape 3↔correction est ce qui me permet de **vérifier que j'ai réussi**. Si une seule des trois ment, mon auto-évaluation s'effondre.

### Q5 — Fond crème `#F5F0E1` assez visible en projection ?

**Mon intuition de débutant·e : non, pas seul, pas au fond de la salle.** `#F5F0E1` c'est quasi-blanc ; vidéoprojecteur + lumière de salle + écran de portable à 8 mètres = je ne suis pas sûr·e de percevoir la différence avec du blanc. Et si JE ne perçois pas le changement sur l'écran du formateur, je vais douter que mon propre rendu ait marché. Leviers, par ordre de préférence débutant :
- **Avant/après projeté** (le moins risqué pédagogiquement, ne touche pas l'arc).
- Un accent `primary` posé sur un **vrai lien souligné et bien placé** (visible, et fidèle à ce que je referai).
- Titres colorés (le plus visible, mais coût sur l'arc — cf. Q1).

---

## Ce qui me ferait douter d'avoir réussi (récap des pièges silencieux)

1. 🔴 **Consigne `primary` sur un starter sans liens** (`plan:13`, vérifié sur `rapport-starwars.qmd` : 0 lien). Si la consigne arrive avant l'ajout de liens, « rien ne change » = je crois avoir échoué. **Le plus dangereux.**
2. 🟠 **Promesse « titres et liens colorés »** dans Our turn (`1-quarto-typst.qmd:283`, `index.qmd:37`) alors que le snippet `primary` ne colore PAS les titres (`plan:12`). Je vais fixer les titres en attendant qu'ils rougissent — ils ne le feront jamais. À reformuler en même temps que le wording crème.
3. 🟠 **« les couleurs de la charte »** suggère le rendu riche du PDF projeté à côté, alors que je n'aurai que crème + texte sombre. Écart promesse/livraison → doute. Préférer un wording littéral (« le fond passe en crème, le texte en gris foncé »).
4. 🟠 **Boussole muette sur `primary`/liens/titres** (`boussole.qmd:31`) vs page qui les promet. Mon panneau de référence ne décrit pas l'état cible.
5. 🟠 **Correction non synchronisée** : si l'étape 3 promet des liens rouges absents de la correction, mon filet de sécurité me trahit.
6. 🟡 **`#F5F0E1` trop subtil** en projection : je ne vois pas le changement → je doute. Avant/après ou accent plus franc.
7. 🟡 **Aucun « voici à quoi ça doit ressembler »** pour la démo. L'exo a sa colonne « Vous devriez voir » ; la démo Our turn n'a pas d'équivalent — pour le formateur c'est oral, mais si je révise les slides le soir (PDF), je n'ai aucun repère visuel de ce que la démo produisait.

---

## Ce qui me rassure (déjà bon)

- ✅ Le choix de NE PAS faire `foreground = rouge` (qui colore TOUT le texte) est sage — « tout mon rapport en rouge » m'aurait fait paniquer bien plus.
- ✅ Le callout « PDF inchangé après avoir modifié `_brand.yml` ? » (`index.qmd:87-89`) anticipe déjà très bien le piège du PDF verrouillé (fréquent Windows). Exactement le genre de filet qui m'évite 5 min de débogage. **À garder, et même à rappeler à l'oral pendant la démo.**
- ✅ Le « commencez par l'étape 1 seule » (`index.qmd:54`) et la décision de garder la démo comme « avant-goût minimal » (`plan:62`) respectent mon rythme : je ne suis pas noyé·e.
- ✅ Le contournement du bug `gt`/accents est déjà commenté dans le starter (`rapport-starwars.qmd:44`), donc je ne tomberai pas dessus par surprise.
- ✅ Le tableau « Starter / Démo / Correction / Boussole » du §5 (`plan:65-70`) est exactement la grille mentale dont j'ai besoin pour savoir « qu'est-ce qui produit quoi » — si cette différenciation arrive jusqu'à moi (slide ou oral), je serai au clair.

---

## En une phrase

Le fond crème + texte sombre, c'est rassurant **à condition qu'on me dise exactement quoi regarder et qu'on me prévienne que le rouge/logo/Star Jedi viennent après** ; et la consigne `primary` ne doit JAMAIS arriver sans qu'un vrai lien visible soit présent dans le doc, sinon je passerai la démo (et l'exo) à chercher une faute inexistante.
