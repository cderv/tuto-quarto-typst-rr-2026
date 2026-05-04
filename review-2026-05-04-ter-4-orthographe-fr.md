# Review FR — vague 3 (sweep post-fixes session 2026-05-04)

**Périmètre :** contenu participant à HEAD `9856186` (`main`), focus sur les nouveaux contenus livrés dans la session post-review #2 — `## Test de la chaîne Typst` dans `preparatifs.qmd`, mini-test `exercises/00-test-install/test-install.qmd`, helpers brand dans correction Exo 1, ressource `4-ressources.qmd`, README Exo 1 réécrit, wrap-up Bloc 2 (3 slides), réformulation des sections « À la fin de ce bloc, vous saurez ».

## Verdict général

Sweep matin (Lot A) appliqué proprement : les 11 résidus listés dans la review #2 ont disparu (vérifié par grep `core|outlier|punchline|escape hatch|Brander|Setup|Cross-refs|Pré-requis|sans friction\b`). Le mini-test `test-install.qmd`, les helpers brand commentés en FR dans la correction Exo 1, et les 3 slides wrap-up Bloc 2 sont propres en orthographe et grammaire. La cohérence du vocabulaire métier (« charte », « polices », « références croisées », « titres ») tient sur l'ensemble du matériel participant.

**Reste à corriger** : 4 anglicismes nouveaux ou ratés par le sweep matin, tous concentrés dans `preparatifs.qmd` (section `## Test de la chaîne Typst` nouvellement ajoutée) et `4-ressources.qmd` (section `## _brand.yml — référence complète` toujours non sweepée). Et 1 incohérence d'unité (`MB` vs `Go`). Aucun P0. Le matériel est déjà au-dessus du seuil workshop pro.

## 🔴 P0 — gros problème linguistique

Aucun.

## 🟠 P1 — à corriger avant le 16 juin

### Anglicismes / faux amis nouveaux ou résiduels (en prose visible participant)

- **`4-ressources.qmd:49`** — « `mainfont` — police principale du document (polices Google **supportées**) ». Faux ami. Proposer : « (polices Google **prises en charge** ») ou « (polices Google **disponibles** ») ». _Le sweep matin a corrigé `polices fallback du tableau` mais cette occurrence-ci a été oubliée._

- **`4-ressources.qmd:59`** — « Le fichier `_brand.yml` **supporte** les sections suivantes : ». Même faux ami. Proposer : « **prend en charge** les sections suivantes » ou « **accepte** les sections suivantes ».

- **`preparatifs.qmd:58`** (nouvelle section `## Test de la chaîne Typst`) — phrase concentre 4 anglicismes en une ligne :

  > « Réseau bloqué au **render** → ce test n'utilise pas **Google fonts**, donc un échec ici n'a rien à voir avec le **firewall** (cf. Plan B ci-dessous pour la procédure **offline** du jour du tutoriel). »

  Proposer : « Réseau bloqué **au rendu** → ce test n'utilise pas **les polices Google**, donc un échec ici n'a rien à voir avec le **pare-feu** (cf. Plan B ci-dessous pour la procédure **hors-ligne** du jour du tutoriel). » Note : `offline` apparaît aussi dans le nom de fichier `_brand-offline.yml` (L65, 67) mais c'est un nom de fichier — OK.

- **`preparatifs.qmd:56`** — « ignorez ce **warning** ». Proposer : « ignorez cet **avertissement** ». (`warning` est un mot YAML technique de Quarto par ailleurs, mais ici c'est utilisé comme nom commun en prose.)

### Incohérence typographique d'unité

- **`preparatifs.qmd:69`** — « (~**1.3 MB**) ». Convention FR : virgule décimale + unité francisée. Proposer : « ~**1,3 Mo** ». À cohérencer avec `1-quarto-typst/1-quarto-typst.qmd:58` qui dit déjà « distribution TeX de **1 Go** à gérer ». Le mélange `MB`/`Go` dans le même matériel est gênant.

### Anglicisme dans le starter + correction Exo 2

- **`exercises/02-projet-book/{starter,correction}/annexe-donnees.qmd:19`** — « dans les **chunks** d'analyse ». Anglicisme R Markdown classique. Proposer : « dans les **blocs de code** » ou « dans les **blocs R** ». Cohérence à viser : le reste du matériel parle de « bloc(s) » sans `chunks` (vérifié `grep -rn 'chunk' --include='*.qmd'` — c'est la seule occurrence).

## 🟡 P2 — nice-to-have

- **`4-ressources.qmd:72`** — « **Helpers** R pour propager la charte aux sorties graphiques ». `Helpers` (capitalisé en début de bullet) est un anglicisme. La communauté R francophone l'utilise tel quel, mais la version FR « Fonctions auxiliaires R » ou « Fonctions d'accompagnement R » serait plus rigoureuse. Idem `2-projets/2-projets.qmd:160` (slide visible participant) : « helpers `brand.yml` côté R ». À uniformiser : soit garder « helpers » partout (et l'assumer), soit franciser. Actuellement c'est l'anglicisme partout, donc cohérent — d'où P2 et pas P1.

- **`preparatifs.qmd:69`** — « les **TTFs** locaux ». Pluriel anglais sur acronyme. Proposer : « les **fichiers TTF** locaux » (plus naturel en FR).

- **`2-projets/2-projets.qmd:160`** (slide wrap-up visible participant) — « la page [Pour aller plus loin](../4-ressources.qmd) (**partials**, blocs raw Typst, accessibilité PDF/UA-1, helpers `brand.yml` côté R) ». `partials` reste un terme technique Quarto sans équivalent FR sur les slides. Les notes presenter et `4-ressources.qmd:104` parlent de « **Template partials** » comme titre de section. Cohérent, donc juste à signaler.

- **`preparatifs.qmd:59`** — « Pas bloquant — la chaîne fonctionne ; le contournement … sera vu ». La construction « le contournement (`opt_table_font(font = "Inter")`) sera vu pendant l'Exercice 1 » est correcte mais lourde. Proposition stylistique : « le contournement … sera abordé pendant l'Exercice 1 » (plus actif).

- **`exercises/01-document-typst/correction/rapport-starwars.qmd:67-68`** — commentaire de code : « `opt_table_font` : force Inter en tête de la liste de polices gt → évite l'espacement parasite des chiffres (« 1 7 5 ») sur Windows/macOS ». Bien rédigé. Petite remarque : « force Inter en tête de la liste » est un peu ambigu — on pourrait préciser « force Inter en première position dans la liste de polices gt ». P2.

- **Sections « À la fin de ce bloc, vous saurez »** — vérifiées L24-29 (`1-quarto-typst/index.qmd`) et L24-28 (`2-projets/index.qmd`) : verbes infinitifs corrects (Produire / Régler / Inspecter / Personnaliser ; Centraliser / Assembler / Identifier), accord OK. **RAS**, sauf que la formulation `2-projets/index.qmd:28` « Identifier l'**auto-activation** de l'extension orange-book par Quarto 1.9 sur `format: typst` + `type: book` » est lourde syntaxiquement (« auto-activation … par Quarto 1.9 sur X + Y »). Pas une faute, mais clarté pédagogique perfectible : « Reconnaître que `format: typst` + `type: book` active automatiquement l'extension orange-book (Quarto 1.9) ».

- **`2-projets/2-projets.qmd:154`** (presenter notes — hors périmètre, signalé pour info) — « Les 4 bullets **miroir** les 4 questions posées en intro ». Faute de conjugaison : « miroir » n'est pas un verbe. Devrait être « les 4 bullets **font écho** aux 4 questions » ou « **reprennent en miroir** les 4 questions ». Notes presenter restent en style relâché mais celle-ci est non grammaticale.

## ✅ Forces linguistiques

- **Cohérence terminologique tient sur l'ensemble** : `charte` (vs « brand »), `polices` (vs « fontes »/« fonts »), `références croisées` (vs « cross-refs »), `titres` (vs « headings »), `correction` (vs « fix »), `valeurs aberrantes` (vs « outliers »), `chute` (vs « punchline »), `mise en place` (vs « setup »), `principal·e·s` (vs « core »), `prérequis` (vs « pré-requis »), `sans frictions` (forme stable au pluriel). _Vérifié par grep exhaustif._

- **README Exo 1 (`exercises/01-document-typst/README.md`)** — étape 4 « Charte. » + section « Solution » : prose claire, vouvoiement uniforme, accord du verbe « sont appliqués » ligne 31 correct, syntaxe FR naturelle. Charte/charte employé en cohérence avec le reste.

- **Mini-test `test-install.qmd`** — orthographe impeccable, accents corrects (Échelle, accentué, prêt·e), titres clairs, conclusion participant directe et actionnable.

- **Helpers brand dans correction Exo 1 (lignes 28-29, 65-69, 98-99 de `rapport-starwars.qmd`)** — commentaires de code en FR naturel (« Charge `_brand.yml` … applique la même charte aux figures… ») et techniquement précis. Aucun anglicisme en commentaire.

- **Wrap-up Bloc 2 (slides L142-180)** — orthographe parfaite des titres et bullets, signatures correctes (« Christophe Dervieux — Posit » / « Maëlle Salmon — rOpenSci / cynkra »), structure en 3 temps lisible (« Ce que vous savez faire maintenant » → « Et maintenant ? » → « Merci ! Questions ? »). « Cette semaine », « Pour creuser », « Communauté » sont 3 entrées bien dosées. Les questions stock (notes L179) bien tournées en FR — vouvoiement de relance correct.

- **Inclusive writing** uniforme et discret (`prêt·e`, `parti·e`, `utilisateur·ice`) — appliqué là où ça compte (couverture, conclusion test-install, wrap-up), pas envahissant.

- **Vouvoiement participant uniforme** : aucun tutoiement résiduel hors notes presenter (vérifié par grep).

- **Guillemets français `«… »`** systématiques dans le contenu participant (62 occurrences) — pas un seul `"…"` parasite en prose visible.

## 📝 Évolution depuis review précédente (vague 2)

### Ce qui s'est amélioré
- **P0 lorem ipsum préface book** : éliminé. `02-projet-book/{starter,correction}/index.qmd:3` est désormais une vraie préface FR signifiante.
- **Lot A (11 fixes P1)** : tous appliqués. `core`, `outlier`, `punchline`, `escape hatch`, `Brander`, `Setup`, `Cross-refs`, `Fix:`, `polices fallback du tableau`, `Pré-requis`, `sans friction\b` — tous nettoyés. Vérification par grep exhaustif (cf. annexe).
- **Cohérence FR globale** : la charte terminologique appliquée par `fd2a770` (brand→charte, headings→titres, fontes→polices) tient. Aucune régression introduite par les commits ultérieurs (`d55526a`, `2fdf8fc`, `d3beea3`, `f3760e6`, `52d98e4`, `9856186`).
- **Réformulation `Concepts clés` → `À la fin de ce bloc, vous saurez`** (`9856186`) : verbes infinitifs corrects, accord OK, perspective apprenant cohérente.
- **Nouveau mini-test `test-install.qmd`** : aucun défaut linguistique. Bien intégré.

### Ce qui était déjà bon et reste bon
- Inclusive writing discret et cohérent.
- Guillemets `«…»` systématiques.
- Vouvoiement uniforme côté participant.
- Numérotation Quarto (« Figure 1.1 », « Table 2.1 ») en français long, jamais « Fig. » / « Tab. ».

### Nouveaux résidus (introduits ou ratés)
- **2 occurrences de `support*` ratées par le sweep matin** dans `4-ressources.qmd:49,59` (section `_brand.yml — référence complète`) — la review #2 avait flaggé `polices fallback du tableau` côté README Exo 2 mais pas ces 2 occurrences-ci. À corriger.
- **4 anglicismes dans la nouvelle section `## Test de la chaîne Typst`** de `preparatifs.qmd` (`render`, `Google fonts`, `firewall`, `offline`). Section ajoutée par `52d98e4` — n'a pas été sweepée.
- **1 anglicisme dans `## Plan B`** de `preparatifs.qmd:58` : `offline`. Idem.
- **1 incohérence d'unité** : `MB` vs `Go` (`preparatifs.qmd:69` vs `1-quarto-typst.qmd:58`).
- **1 anglicisme `chunks`** dans `annexe-donnees.qmd` (starter + correction Exo 2) — passé sous le radar de toutes les reviews jusqu'à présent.

---

## Annexe — greps exécutés

```bash
# Vérification Lot A — aucune occurrence en prose participant
grep -rn 'Cross-refs\|punchline\|outlier\|escape hatch\|Brander\|Setup\b\|polices fallback'
# → 0 hit hors review-*.md

# Anglicismes brand/charte/headings/fontes
grep -rn '\bbrand\b\|\bheading\b\|\bfonte\b\|\bcross-ref\|\bbrandé\|\bscaffold'
# → seules occurrences = noms techniques (`_brand.yml`, `brand-color`, `brand-mode:`, etc.) ou notes presenter

# Tutoiement
grep -rEn '\b(tu|toi|ton|ta|tes)\b' --include='*.qmd' --include='*.md'
# → 0 hit en contenu participant

# Fig/Tab abrégés
grep -rEn '\bFig \?[0-9]\|\bTab \?[0-9]\|\bFig\.\|\bTab\.'
# → 0 hit en contenu participant

# Doublons mots
grep -rEn '\b(\w+) \1\b'
# → 0 hit en contenu participant

# Faux amis
grep -rni 'éventuellement\|actuellement\|opportunité\|adresser\|réaliser que\|supporter'
# → 2 hits (4-ressources.qmd:49, :59) — flaggés P1 ci-dessus

# Anglicismes ponctuels
grep -rni '\boffline\b|\bfirewall\b|\brender\b|\bwarning\b'
# → 4 hits dans preparatifs.qmd (section Test de la chaîne Typst + Plan B) — flaggés P1
```
