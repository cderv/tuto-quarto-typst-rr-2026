# Review FR — orthographe & typographie (2ᵉ vague, 2026-05-04)

Branche `claude/quarto-book-skeleton-qeDNI` · commit `34e8d0f` · périmètre = contenu participant (pages, slides, exercices), hors `README.md` racine et `.claude/`.

## Verdict général

La qualité linguistique est **globalement au niveau workshop pro**, avec un sweep matin clairement efficace : 0 résidu de tutoiement, 0 doublon de mot, 0 « Fig 1.1 / Tab 1.1 », guillemets françaises «… » utilisées de façon impeccable, accords sujet-verbe et participes passés propres. **Trois familles de findings subsistent** : (1) **2 résidus « Lorem ipsum » oubliés** dans la préface du livre Star Wars (starter ET correction Exo 2) — bug de contenu, pas de pure typo, mais visible ; (2) une **poignée d'anglicismes en prose participant** que le sweep n'a pas attrapés (`escape hatch`, `punchline`, `core`, `Fix`, `fallback`, `layout`, `header/footer`, `Setup`, `Brander`, `polices supportées`) ; (3) des **incohérences mineures** (« Pré-requis » vs « Prérequis », « sans frictions » vs « sans friction », « stylé » vs « stylisé », commentaire d'explication du workaround `Espece`/`Planete` présent uniquement dans Exo 1). Rien de bloquant pour le 16 juin, mais 4-5 corrections P0/P1 valent un coup de propre avant le jour J.

## 🔴 P0 — gros problème linguistique

### 1. Lorem ipsum résiduel dans la préface du livre Star Wars

`exercises/02-projet-book/starter/index.qmd:3` et `exercises/02-projet-book/correction/index.qmd:3`
> « **Lorem ipsum dolor sit amet, consectetur adipiscing elit.** Ce livre explore le dataset `dplyr::starwars`… »

Le placeholder `Lorem ipsum dolor sit amet, consectetur adipiscing elit.` est resté collé devant la vraie phrase. Présent dans **starter ET correction** — donc le participant le verra à l'étape 2 du Bloc 2 (rendu du livre) et la couverture orange-book affichera la préface qui s'ouvre sur du faux latin. À supprimer dans les deux fichiers.

Correction proposée (les deux fichiers) : retirer la phrase Lorem ipsum, conserver « Ce livre explore le dataset… »

## 🟠 P1 — à corriger avant le 16 juin

### 2. Anglicismes purs en prose participant que le sweep matin a manqués

| Fichier:ligne | Original | Correction proposée |
|---|---|---|
| `3-aller-plus-loin/index.qmd:14` | « **L'escape hatch** pour injecter du Typst natif » | « **La porte de sortie** » ou « **L'échappatoire** pour injecter du Typst natif » |
| `exercises/02-projet-book/starter/02-origines.qmd:60`<br>`exercises/02-projet-book/correction/02-origines.qmd:61` | « La **punchline** du chapitre 1 » | « La **chute** du chapitre 1 » ou « **Le clin d'œil final** » |
| `exercises/02-projet-book/starter/index.qmd:7`<br>`exercises/02-projet-book/correction/index.qmd:7` | « (taille, masse, **outliers**) » | « (taille, masse, **valeurs aberrantes**) » |
| `exercises/02-projet-book/starter/01-anatomie.qmd:49`<br>`exercises/02-projet-book/correction/01-anatomie.qmd:50`<br>`exercises/01-document-typst/starter/rapport-starwars.qmd:60`<br>`exercises/01-document-typst/correction/rapport-starwars.qmd:74` | « Jabba en **outlier** » | « Jabba en **valeur aberrante** » ou « **point isolé** » |
| `exercises/01-document-typst/README.md:28` (titre étape 4 prose) | « **Brander.** Créez un fichier `_brand.yml`… » | « **Aux couleurs de votre charte.** Créez un fichier `_brand.yml`… » (cohérent avec le sweep matin qui a remplacé « brandé » → « aux couleurs de votre charte ») |
| `exercises/02-projet-book/README.md:12` (titre H2) | « ## **Setup** » | « ## **Mise en place** » ou « ## **Préparation** » |
| `exercises/02-projet-book/README.md:18`<br>`2-projets/index.qmd:49`<br>`2-projets/2-projets.qmd:96` | « 3 étapes **core** (12 min) » | « 3 étapes **principales** (12 min) » ou « 3 étapes **essentielles** » |
| `4-ressources.qmd:49` | « `mainfont` — police principale du document (polices Google **supportées**) » | « (polices Google **prises en charge**) » — « supporté = pris en charge » est un faux ami classique |

### 3. « Cross-refs » résiduel — sweep manqué

`exercises/02-projet-book/README.md:70` (colonne « Concept » du tableau bonus)
> « **Cross-refs** inter-chapitres avec numérotation automatique. »

Le sweep matin a remplacé « cross-refs » → « références croisées » partout sauf ici. À aligner :
> « **Références croisées** inter-chapitres avec numérotation automatique. »

### 4. « Fix » comme étiquette en prose participant

`exercises/02-projet-book/README.md:62` et `2-projets/index.qmd:106`
> « …les polices fallback du tableau s'appliquent. **Fix** : ajoutez `|> opt_table_font(font = "Inter")`… »

« Fix » comme balise gras est un anglicisme. Proposer **Solution :** ou **Correctif :** ou **Contournement :** (ce dernier traduit fidèlement « workaround »).

### 5. « fallback » en prose participant

`2-projets/index.qmd:106`
> « les polices **fallback** du tableau s'appliquent »

`exercises/02-projet-book/README.md:62`
> « les polices **fallback** du tableau »

Anglicisme nu en prose. Proposer « **polices de repli** » ou « **polices de secours** ». (Le nom de fichier `_brand-fallback.yml` peut rester, c'est un identifiant technique.)

### 6. Cohérence « Pré-requis » vs « Prérequis »

| Fichier | Forme |
|---|---|
| `README.md:9` | « **Prérequis** » (sans tiret) |
| `exercises/02-projet-book/README.md:6` | « ## **Pré-requis** » (avec tiret) |

Le Petit Robert et l'Académie recommandent « **prérequis** » (sans tiret). À harmoniser sur cette forme.

### 7. Cohérence « PDF sans frictions » (pluriel) vs « PDF sans friction » (singulier)

| Fichier:ligne | Forme |
|---|---|
| `README.md:1`, `index.qmd:2`, `1-quarto-typst/1-quarto-typst.qmd:3`, `2-projets/2-projets.qmd:3` | « PDF sans **frictions** » |
| `index.qmd:17`, `README.md:36` | « PDF sans **friction** » |

L'expression idiomatique française est **« sans friction »** (singulier, comme « sans heurt »). Le pluriel est un calque direct de l'anglais « without frictions ». Recommandation : tout aligner sur le singulier.

## 🟡 P2 — nice-to-have

### 8. Cohérence du commentaire d'explication `Espece`/`Planete` (workaround bug gt)

Le sweep matin a documenté que les libellés `cols_label` sans accent sont volontaires (workaround `gt → Typst`). Mais le commentaire d'explication n'apparaît **que** dans deux fichiers Exo 1 :

| Fichier:ligne | Commentaire présent ? |
|---|---|
| `exercises/01-document-typst/starter/rapport-starwars.qmd:47` | ✅ « # libellés sans accent : contournement bug gt → Typst sur les en-têtes » |
| `exercises/01-document-typst/correction/rapport-starwars.qmd:57-63` | ✅ commentaire + `opt_table_font` |
| `exercises/02-projet-book/starter/01-anatomie.qmd:36-37` | ❌ pas de commentaire |
| `exercises/02-projet-book/starter/02-origines.qmd:27` | ❌ pas de commentaire |
| `exercises/02-projet-book/correction/01-anatomie.qmd:36-37` | ❌ pas de commentaire (mais `opt_table_font` ligne 39) |
| `exercises/02-projet-book/correction/02-origines.qmd:27` | ❌ pas de commentaire (mais `opt_table_font` ligne 30) |

Le participant qui ouvre `01-anatomie.qmd` du starter Exo 2 et voit `species = "Espece", homeworld = "Planete"` sans accents va trouver ça louche (cf. review.md:142 du critique pédagogue). Recommandation : ajouter le même commentaire inline dans les 4 fichiers Exo 2 pour cohérence (1 ligne chacun).

### 9. « stylé » vs « stylisé »

| Fichier:ligne | Forme |
|---|---|
| `1-quarto-typst/index.qmd:33` | « PDF Typst **stylé** » |
| `1-quarto-typst/1-quarto-typst.qmd:115` (titre slide) | « un doc **stylé** en un fichier » |
| `2-projets/index.qmd:56`, `exercises/02-projet-book/README.md:25` | « tableaux `gt` re-**stylés** » |
| `2-projets/2-projets.qmd:29` (notes presenter) | « on a **stylé** un document unique » |
| `2-projets/2-projets.qmd:58` | « En-têtes et pieds de page **stylisés** » |
| `3-aller-plus-loin/index.qmd:19` | « Tableaux **stylisés** » |

« Stylisé » est plus standard que « stylé » (qui relève du registre familier/mode). Recommandation : harmoniser sur « stylisé ».

### 10. « layout » / « header » / « footer » non traduits en prose participant

| Fichier:ligne | Original | Suggestion |
|---|---|---|
| `4-ressources.qmd:114` | « le **layout** du document (**header**, **footer**, page de titre, polices, couleurs) » | « la **mise en page** du document (**en-tête**, **pied de page**, page de titre, polices, couleurs) » |
| `3-aller-plus-loin/index.qmd:23` | « contrôler le **layout** du PDF » | « contrôler la **mise en page** du PDF » |
| `3-aller-plus-loin/index.qmd:26` | « **layout** du document (**header**, **footer**, couleurs, logo) » | idem |
| `4-ressources.qmd:41` | « article **layout** avec figures, légendes » | « **mise en page** d'article avec figures, légendes » |
| `2-projets/2-projets.qmd:127` (slide pépite) | « personnaliser **header**, **footer**, page de titre… » | « personnaliser **en-tête**, **pied de page**, page de titre… » |

`4-ressources.qmd:64` — « `location` (header/footer) » : ici c'est entre parenthèses pour expliciter une **valeur YAML autorisée** par `_brand.yml`, donc à laisser tel quel (clés techniques).

### 11. « dataset » — anglicisme largement utilisé

10 occurrences en prose participant : `01-anatomie.qmd:11` (starter+correction Exo 2), `index.qmd:4` (starter+correction Exo 2), `annexe-donnees.qmd:1,3` (starter+correction Exo 2), `rapport-starwars.qmd:21,31` (starter+correction Exo 1), `02-projet-book/correction/index.qmd:4`. Cohérence interne ✅. Anglicisme usuel ❌. Si on traduit, → « **jeu de données** » (terme français standard, cf. INSEE, Académie). Décision à prendre par le pilote — décision de cohésion (tout ou rien).

### 12. Anglicismes en notes presenter (acceptables mais signalés)

Les `::: notes` sont des notes pour l'orateur, donc moins critiques. Pour info :
- `1-quarto-typst/1-quarto-typst.qmd:162` : « **Heads-up bug** », « **Workaround** », « **fix** structurel »
- `1-quarto-typst/1-quarto-typst.qmd:179` : « **workaround** `gt::opt_table_font` »
- `2-projets/2-projets.qmd:64` : « extension **bundlée** dans Quarto 1.9 »
- `2-projets/2-projets.qmd:66` : « 4 **beats** = 4 idées »
- `2-projets/2-projets.qmd:80` : « la charte de Bloc 1 **ressuscite côté book** » (registre ; OK en notes presenter)
- `2-projets/2-projets.qmd:115` : « le **wow** visuel le plus fort »
- `2-projets/2-projets.qmd:137` : « concept le plus avancé du **workshop** »

Mineur. Si on veut un nettoyage symbolique : remplacer « Heads-up » → « **Attention** », « Workaround » → « **Contournement** », « bundlée » → « **livrée/intégrée** ».

### 13. « pas d'install à faire » → « pas d'installation à faire »

`exercises/02-projet-book/README.md:10`
> « L'extension `orange-book` (livrée avec Quarto 1.9, **pas d'install à faire**) »

Abréviation familière. Mineur, à formaliser : « pas d'**installation** à faire ».

### 14. « saga "centrée humaine" » — formulation maladroite

`exercises/02-projet-book/starter/02-origines.qmd:58`<br>`exercises/02-projet-book/correction/02-origines.qmd:59`
> « Les humains dominent — saga « centrée humaine » comme on dit dans la critique. »

L'expression « centrée humaine » n'existe pas en français — la formule attendue est « **centrée sur l'humain** » ou « **anthropocentrée** ». La voix du critique est imitée mais elle sonne fausse. Suggestion :
> « Les humains dominent — saga « **centrée sur l'humain** » comme on dit dans la critique. »

### 15. « Suffit souvent de toucher » — sujet manquant

`2-projets/2-projets.qmd:127` (slide pépite, prose participant)
> « Vous pouvez le remplacer pour personnaliser header, footer, page de titre… **Suffit souvent de toucher** `typst-show.typ` seul. »

La phrase elliptique sans « Il » sonne brusque sur une slide. Recommandation : « **Il suffit souvent de toucher** `typst-show.typ` seul. »

### 16. « Re-rendez » avec tiret

`exercises/01-document-typst/README.md:21,24,29` : « **Re-rendez** et observez la différence. »

La forme française correcte serait « **rerendez** » (sans tiret, comme « réécrire »), ou plus naturellement « **rendez à nouveau** ». Le tiret est un calque anglais (« re-render »). Mineur.

### 17. Cohérence des modes — slide vs page web pour la même consigne

Les slides utilisent l'**impératif** vouvoiement ; les pages web `index.qmd` du même Bloc utilisent l'**infinitif** :

| Slide (impératif) | Page web (infinitif) |
|---|---|
| `1-quarto-typst.qmd:170-173` : « Ouvrez… Personnalisez… Créez… Activez… » | `1-quarto-typst/index.qmd:47-50` : « Ouvrir… Personnaliser… Créer… Activer… » |
| `2-projets/2-projets.qmd:74-76` : « Créer… Passer… Copier… » (« Faisons ensemble ! ») | `2-projets/index.qmd:34-36` : « Créer… Passer… Copier… » |

C'est un choix défendable (slide = consigne directe au public, page web = description macro), mais à harmoniser consciemment. Si l'objectif est un vouvoiement uniforme côté participant, la page web devrait aussi être à l'impératif.

## ✅ Forces linguistiques

- **Vouvoiement uniforme** confirmé : `grep -E '\b(tu|toi|ton|ta|tes)\b'` → 0 hit dans les sources participant. Les notes presenter et les fichiers `.claude/` sont exclus du périmètre.
- **Aucun doublon de mot** : `grep -E '\b(\w+) \1\b'` → 0 hit.
- **Aucun « Fig 1.1 » / « Tab 2.1 »** : `grep -E 'Fig [0-9]|Tab [0-9]'` → 0 hit. Toutes les références respectent les formes longues « Figure 1.1 / Table 2.1 » imposées par `_language-fr.yml`.
- **Guillemets français «… »** utilisés impeccablement partout. Aucun mélange `"…"` ASCII en prose (les guillemets ASCII restent uniquement dans les valeurs YAML `title:`, les arguments R `cols_label`, etc., où c'est syntaxiquement requis).
- **Apostrophes droites `'`** en prose : volontairement uniformes (Pandoc les convertit en `’` au rendu via `lang: fr`). Aucune incohérence entre `'` et `’`.
- **Faux amis classiques absents** : `grep -E 'eventuellement|actuellement|opportunité|complèter|definir|verifier|controler|developper|implementer|solutionner'` → 0 hit. Seul résidu = « supportées » dans `4-ressources.qmd:49` (cf. P1.2).
- **Tournures anglo-saxonnes absentes** : pas de « il est important que… », pas de « adressez la situation ».
- **Accents et accords** : 0 résidu de « echelle » / « planete » en prose (tous les `Espece`/`Planete` sont strictement dans des `cols_label` du workaround gt). Les accords sujet-verbe et participes passés (« Comme l'a montré la Figure 1.1 ») sont corrects.
- **« open source »** sans capitales et sans tiret : appliqué uniformément (`index.qmd:42`).
- **Convention « Faisons ensemble ! » / « À vous ! »** : appliquée 100 % cohéremment dans les slides Bloc 1 et Bloc 2.
- **Termes techniques non traduits cohérents** : « callout » (classe Quarto), « starter / correction » (noms de dossiers), « template partials » (concept Quarto), « My turn / Our turn / Your turn » (convention pédagogique). Choix défendable et appliqué uniformément.

## 📝 Évolution depuis la review du matin

### Ce qui s'est nettement amélioré

- **Sweep `brand → charte`** : aucun résidu trouvé en prose participant. Les occurrences `brand` restantes sont toutes des références à `_brand.yml`/`brand-color.primary`/`quarto use brand`/package R `brand.yml` — toutes légitimement techniques.
- **Sweep `headings → titres`, `fontes → polices`, `scaffolder → squelette`** : aucun résidu. ✅
- **Sweep `Open-Source → open source`** : aucun résidu. ✅
- **Sweep `Fig X / Tab X → Figure X / Table X`** : aucun résidu, formes longues partout (cohérent avec le rendu Quarto FR via `_language-fr.yml`). ✅
- **Sweep tutoiement** : grep complet `\b(tu|toi|ton|ta|tes)\b` → 0 hit en prose participant. ✅
- **« 4 fichier » → « 4 fichiers »** : la coquille a disparu. ✅
- **« echelle » / « planete »** : tous les résidus restants sont strictement dans les `cols_label` (workaround gt) — comme attendu. ✅

### Ce qui était déjà bon ce matin et qui le reste

- Guillemets françaises «… »
- Vouvoiement
- Convention « Faisons ensemble ! » / « À vous ! »
- Pas de calques tournures anglo-saxonnes
- Accords sujet-verbe et participes passés

### Ce qui n'a pas été couvert par le sweep et reste à traiter

1. **Lorem ipsum résiduel × 2** (P0) — c'est le seul gros item.
2. **Anglicismes purs en prose participant** que le sweep n'avait pas listés : `escape hatch`, `punchline`, `outlier(s)`, `Brander`, `Setup`, `core`, `Fix`, `fallback`, `layout`, `header/footer`, `polices supportées` (P1).
3. **Cross-refs résiduel × 1** (P1) — un endroit oublié dans la table bonus de `02-projet-book/README.md`.
4. **Cohérences mineures** : « Pré-requis » vs « Prérequis », « sans frictions » vs « sans friction », « stylé » vs « stylisé », commentaire workaround `gt` présent en Exo 1 mais pas en Exo 2 (P1/P2).

---

**Bilan chiffré P0/P1 :** ~12 corrections concrètes sur ~30 lignes touchées dans 7-8 fichiers. Effort estimé : 30-40 minutes de polish ciblé. Effort P2 supplémentaire si on veut traiter l'incohérence `dataset` ou « stylé/stylisé » : +30 minutes (mais discutable, ces choix sont défendables tels quels).
