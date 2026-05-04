# Review FR — vague 4 (sweep post-fixes vague 3, HEAD `39f9ff5`)

**Périmètre :** contenu participant à HEAD `39f9ff5` (`claude/post-merge-doc-audit`), focus sur les modifications introduites par les commits `438aafd` (6 P1 anglicismes/faux amis), `625c03e` (3 P1 promesses débutant) et `39f9ff5` (sweep ciblé 6 P2 vague 3). Vérification également des résidus déjà connus.

## Verdict général

Les 6 P1 de la vague 3 sont **résolus proprement**, sans régression : `support*` (2 hits → « prises en charge » / « prend en charge »), `warning` (→ « avertissement »), `render`/`Google fonts`/`firewall`/`offline` (→ « rendu »/« polices Google »/« pare-feu »/« hors-ligne »), `1.3 MB` + `TTFs` (→ « 1,3 Mo » + « fichiers TTF »), `chunks` (→ « blocs de code R »). Les nouvelles modifications participantes (callout-note `3-aller-plus-loin`, reformulation `index.qmd:19`, reformulation `2-projets/index.qmd:28`, slide wrap-up à 5 bullets, README Exo 1 étape 4 réécrite, README Exo 2 « 5 HTML séparés ») sont linguistiquement saines. **Une nouvelle incohérence** est apparue : la francisation de `4-ressources.qmd:72` (« Helpers » → « Fonctions auxiliaires R ») a cassé la cohérence avec deux occurrences participant-visibles restées en anglais (`exercises/01-document-typst/README.md:32` et slide `2-projets/2-projets.qmd:161`). **Une formulation de slide nouvellement introduite** (« couverts en pistes ») est syntaxiquement maladroite. Aucun P0. Un P1 de cohérence, deux P2 stylistiques.

## 🔴 P0 — gros problème linguistique

Aucun.

## 🟠 P1 — à corriger avant le 16 juin

### Cohérence cassée par le fix vague 3 sur `helpers`

Le commit `39f9ff5` a francisé `4-ressources.qmd:72` (« Helpers R » → « Fonctions auxiliaires R »), mais a laissé deux autres occurrences en anglais dans du contenu **visible participant** :

- **`exercises/01-document-typst/README.md:32`** — « utilisez les **helpers** du package R `brand.yml` (`theme_brand_ggplot2()`, `theme_brand_gt()`) ». README participant, étape 4 de l'exercice. Anglicisme isolé alors que la page Ressources est francisée.

- **`2-projets/2-projets.qmd:161`** (slide wrap-up « Et maintenant ? », visible participant) — « la page [Pour aller plus loin](../4-ressources.qmd) (partials, blocs raw Typst, accessibilité PDF/UA-1, **helpers** `brand.yml` côté R) ». Slide qui pointe explicitement vers `4-ressources.qmd` — incohérence sémantique : le pointeur dit « helpers » mais la cible dit « Fonctions auxiliaires R ».

  Proposition : harmoniser les 3 occurrences. Soit revenir à « helpers » partout (cohérent avec la culture R francophone qui adopte l'anglicisme), soit propager « Fonctions auxiliaires R » dans Exo 1 README L32 et slide L161 (rigueur FR). La vague 3 P2 avait explicitement noté « cohérent partout — d'où P2 et pas P1 » ; en cassant la cohérence, le fix vague 3 monte mécaniquement le sujet en P1.

  Note : les notes presenter (`1-quarto-typst.qmd:146,148` et `2-projets/2-projets.qmd:167`) restent en style relâché (« helpers » accepté en notes). Le périmètre ne concerne que README Exo 1 L32 et slide L161.

## 🟡 P2 — nice-to-have

### Formulation maladroite introduite par le fix vague 3

- **`2-projets/2-projets.qmd:149`** (slide wrap-up « Ce que vous savez faire maintenant ») — bullet 5 : « Savoir où chercher pour aller plus loin (partials, formats communautaires — **couverts en pistes, pas en séance**) ». La construction « couverts en pistes » est syntaxiquement maladroite (« en pistes » sans article, « couverts » comme participe associé sans clarté). Comparer avec la formulation parallèle dans `3-aller-plus-loin/index.qmd:13` qui est correcte (« pas couverts en séance »). Proposition : « (partials, formats communautaires — **présentés comme pistes, pas traités en séance**) » ou « (partials, formats communautaires — **pistes post-tutoriel, pas traitées en séance**) ».

### Style nominal informel sur slides

- **`exercises/02-projet-book/README.md:15`** et **`exercises/02-projet-book/starter/README.md:4`** — « `quarto render` produit **5 HTML séparés** (format par défaut de Quarto…) ». Le pluriel d'acronyme nu sans nom commun (« 5 HTML ») est informel à l'écrit FR. Plus naturel : « **5 fichiers HTML** séparés ». Pas bloquant, fréquent dans la documentation tech FR, mais le starter README a déjà la formulation « **5 fichiers `.qmd`** » deux lignes plus haut — l'asymétrie est visible.

- **`2-projets/2-projets.qmd:148`** (slide wrap-up bullet 4) — « Assembler plusieurs `.qmd` en livre avec `type: book` (**orange-book auto**) ». L'abréviation « auto » sans verbe est très télégraphique pour une slide finale. Comparer avec le bullet équivalent `2-projets/index.qmd:35` qui dit « orange-book s'active automatiquement » (forme complète). Sur slide on accepte la concision, mais cohérence à viser. P2 stylistique.

### Résidus connus vague 3 toujours présents (acceptés)

- **`2-projets/2-projets.qmd:161`** — « partials » (slide visible). Terme technique Quarto sans équivalent FR, accepté par la vague 3 P2. RAS.

- **`exercises/01-document-typst/correction/rapport-starwars.qmd:67-68`** — commentaire « force Inter en tête de la liste de polices gt ». Vague 3 P2 ambiguïté mineure, RAS.

## ✅ Forces linguistiques

- **Tous les 6 P1 vague 3 sont effectivement résolus** sans régression :
  - `4-ressources.qmd:49` « polices Google **prises en charge** » ✓
  - `4-ressources.qmd:59` « `_brand.yml` **prend en charge** » ✓
  - `preparatifs.qmd:56` « ignorez cet **avertissement** » ✓
  - `preparatifs.qmd:58` « Réseau bloqué au **rendu** … pas **les polices Google** … **pare-feu** … procédure **hors-ligne** » ✓ (4 anglicismes éliminés en une ligne)
  - `preparatifs.qmd:69` « ~**1,3 Mo** » + « **fichiers TTF** locaux » ✓ (cohérence d'unité avec `1-quarto-typst.qmd:58` « 1 Go » établie)
  - `02-projet-book/{starter,correction}/annexe-donnees.qmd:19` « dans les **blocs de code R** » ✓

- **Reformulation `2-projets/index.qmd:28`** (P2 vague 3) : « Reconnaître que `format: typst` + `type: book` active automatiquement l'extension orange-book (Quarto 1.9) ». Verbe direct, structure SVO claire, accord du verbe (3ᵉ pers. sing. avec sujet-configuration) correct. Bien plus lisible que la version « auto-activation … par Quarto 1.9 sur X + Y ».

- **Reformulation `index.qmd:19`** : « Comment passer d'un document isolé à un projet Quarto multi-chapitres avec `type: book` ? ». Plus concrète et actionnable que les deux questions précédentes. Bonne réduction 4 → 3 questions cohérente avec le wrap-up à 3 puces.

- **Reformulation `preparatifs.qmd:51`** : « Aucune **erreur** en console (un avertissement sur la police est normal et documenté ci-dessous) ». Désambigue proprement « erreur » vs « avertissement », accord « est normal et documenté » correct (sujet « un avertissement » masc. sing.).

- **Callout-note `3-aller-plus-loin/index.qmd:12-14`** introduit : « Ces sujets sont des **pistes pour aller plus loin après le tutoriel**, pas couverts en séance. Le programme officiel tient en 2 blocs (cf. [page d'accueil](../index.qmd)). Cette page sert de point d'entrée pour les autodidactes. » Orthographe parfaite, accord « pas couverts » (sujets masc. plur.) correct, formulation honnête du périmètre. Et la suppression des temps « (5 min) / (12 min) / (8 min) » dans les sous-titres H3 est cohérente avec le repositionnement.

- **Notes presenter Bloc 1 enrichies (`1-quarto-typst/1-quarto-typst.qmd:148`)** : « Maëlle peut prendre la main 30 sec ici sur les helpers R `theme_brand_*()` (signature naturelle de son passage Bloc 1, le matériel correction Exo 1 + Ressources existe déjà — c'est le moment opportun pour donner à Maëlle un temps de parole avant le Q&A final). » Notes presenter, donc style relâché accepté. Aucune faute d'orthographe ou de conjugaison. « moment opportun » employé au sens FR correct (= approprié, favorable), pas anglicisme.

- **Slide wrap-up à 5 bullets `2-projets/2-projets.qmd:142-156`** : verbes infinitifs cohérents (Produire / Inspecter / Personnaliser / Assembler / Savoir), accord OK. Les notes presenter (« Les 5 bullets font écho aux 3 questions … ») corrigent proprement le « miroir »/verbe non-grammatical de la vague 3.

- **Signature wrap-up `2-projets/2-projets.qmd:174-175`** : ajout d'un retour à la ligne forcé `\` après « Christophe Dervieux — Posit » → rendu en deux lignes distinctes. OK typographiquement.

- **README Exo 1 étape 4 réécrite (`exercises/01-document-typst/README.md:28-35`)** : « Créez un fichier `_brand.yml` à côté du `.qmd` (palette couleurs, une ou deux polices Google, et un logo SVG si vous en avez un sous la main). Re-rendez : couleurs, typographies et logo sont appliqués automatiquement à la mise en page PDF. … La correction (`correction/`) fournit un exemple complet avec un logo Star Wars. » Accord « sont appliqués » correct (mixed fem./masc. → masc. plur.), tournure plus accueillante (« si vous en avez un sous la main »), promesse honnête.

- **README Exo 2 mise en place (`exercises/02-projet-book/README.md:14-17` + `starter/README.md:3-5`)** : promesse rectifiée (« 5 HTML séparés (format par défaut de Quarto) … La première étape ajoute `_quarto.yml` avec `format: typst` pour basculer en PDF. ») — fidèle au comportement réel de Quarto (format par défaut HTML, pas PDF). Cohérence des 2 emplacements.

- **Vouvoiement uniforme** vérifié par grep `\b(tu|toi|ton|ta|tes)\b` sur tout le contenu participant : 0 hit hors `.claude/` et review-*.md. Préservé.

- **Aucun doublon de mot** détecté (`\b([[:alpha:]]{2,}) \1\b`).

- **Aucun « Fig. » / « Tab. » / abrégés** détectés.

- **Aucun faux ami résiduel** : `éventuellement / actuellement / opportunité / adresser / réaliser que / introduire` → 0 hit. La nouvelle occurrence « moment opportun » (`1-quarto-typst.qmd:148`) emploie « opportun » au sens FR correct (pas anglicisme).

- **Aucun support* résiduel** vérifié par grep — la chasse vague 3 a tout neutralisé.

## 📝 Évolution depuis review précédente (vague 3)

### Ce qui s'est amélioré
- **6/6 P1 vague 3 résolus** par `438aafd`. Vérification grep exhaustive — pas de régression introduite.
- **3/6 P2 vague 3 résolus** par `39f9ff5` :
  - `4-ressources.qmd:72` Helpers → Fonctions auxiliaires R (mais **crée un P1 de cohérence ailleurs**, cf. supra).
  - `2-projets/index.qmd:28` lourdeur « auto-activation … » → reformulation SVO directe ✓.
  - `2-projets/2-projets.qmd:154` notes presenter « miroir » non-grammatical → « font écho » ✓.
- **Wrap-up Bloc 2** étoffé à 5 bullets cohérents avec annonces honnêtes (5ᵉ bullet repositionné comme piste post-tutoriel).
- **Promesses débutant** rectifiées sur page d'accueil (`index.qmd:17-19` réduit à 3 questions ciblées) et README Exo 2 (« 5 HTML séparés » au lieu de « 5 PDF orphelins » — fidèle au format par défaut Quarto).
- **Plan B / Test chaîne `preparatifs.qmd`** désormais 100 % FR (4 anglicismes éliminés, unité Mo/Go cohérente).

### Ce qui était déjà bon et reste bon
- Charte terminologique : `charte`, `polices`, `références croisées`, `titres`, `correction`, `mise en place`, `prérequis`.
- Inclusive writing discret (`prêt·e`, `parti·e`, `utilisateur·ice`).
- Guillemets FR `«… »` systématiques.
- Vouvoiement uniforme côté participant.
- Numérotation FR longue (« Figure 1.1 », « Table 2.1 »).

### Nouveaux résidus introduits par vague 4
- **1 P1 de cohérence** : la francisation isolée de `Helpers` dans `4-ressources.qmd:72` casse la consistance avec `exercises/01-document-typst/README.md:32` et slide `2-projets/2-projets.qmd:161` (toujours en « helpers » côté participant). À harmoniser.
- **1 P2 de formulation slide** : « couverts en pistes » (`2-projets/2-projets.qmd:149`) — construction maladroite introduite par le fix wrap-up à 5 bullets.
- **1 P2 de style nominal** : « 5 HTML séparés » sans nom commun — pré-existant côté `2-projets/index.qmd` mais propagé aux 2 README Exo 2 par `625c03e`.

---

## Annexe — greps exécutés (HEAD `39f9ff5`)

```bash
# 1. Vérification 6 P1 vague 3 — toutes les chaînes attendues sont absentes
grep -rni '\bsupporte\|supportée\|supportées\|supportés\b' --include='*.qmd' --include='*.md'
# → 0 hit hors review-*.md
grep -rni '\brender\b\|\bwarning\b\|\bfirewall\b\|\boffline\b\|\bgoogle fonts\b\|\bchunks\?\b' \
  --include='*.qmd' --include='*.md'
# → 0 hit en prose participant (les hits = callout YAML keys, shell `quarto render`,
#   noms de fichiers `_brand-offline.yml`, valeur `warning: false` dans YAML execute,
#   réoccurrences dans review.md hors périmètre)

# 2. Tutoiement / doublons / Fig.Tab. / faux amis
grep -rEn '\b(tu|toi|ton|ta|tes)\b' --include='*.qmd' --include='*.md' …  # → 0 hit
grep -rEn '\b([[:alpha:]]{2,}) \1\b'                                       # → 0 hit
grep -rEn '\bFig \?[0-9]|\bTab \?[0-9]|\bFig\.|\bTab\.'                    # → 0 hit
grep -rEn 'éventuellement|actuellement|opportunité|adresser|réaliser que'  # → 0 hit

# 3. Cohérence helpers / Fonctions auxiliaires R
grep -rn '\bhelpers\?\b\|\bHelpers\?\b' --include='*.qmd' --include='*.md'
# → 4 hits :
#   - exercises/01-document-typst/README.md:32  (visible participant) — incohérent
#   - 2-projets/2-projets.qmd:161               (slide visible)        — incohérent
#   - 1-quarto-typst.qmd:146,148                (presenter notes)      — accepté
#   - 2-projets/2-projets.qmd:167               (presenter notes)      — accepté

# 4. Unités Mo / Go / MB
grep -rEn 'Mo\b|Go\b|MB\b|MiB\b' --include='*.qmd' --include='*.md'
# → 2 hits cohérents : preparatifs.qmd:69 « 1,3 Mo » + 1-quarto-typst.qmd:58 « 1 Go »

# 5. Construction « couverts en pistes » nouvelle
grep -rEn '\bcouverts en\b|\bcouvert en\b|\ben pistes\b' --include='*.qmd' --include='*.md'
# → 2 hits :
#   - 3-aller-plus-loin/index.qmd:13   « pas couverts en séance »      ✓ correct
#   - 2-projets/2-projets.qmd:149      « couverts en pistes, pas en séance » ✗ maladroit
```
