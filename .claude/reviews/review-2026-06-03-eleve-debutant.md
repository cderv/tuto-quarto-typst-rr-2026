# Review « élève qui suit le tutoriel » — 2026-06-03

**Méthode :** parcours complet du tutoriel dans le rôle d'un·e participant·e, depuis
l'installation jusqu'aux deux exercices. Environnement : conteneur Linux (Ubuntu
24.04), R **4.6.0** installé via les builds Posit r-builds (rig visé — voir limites
ci-dessous), **Quarto 1.9.36** (sous le `1.10.4+` recommandé, donc cas « plancher »).

Chaque rendu a été vérifié visuellement (PDF → PNG). Les constats sont classés
**(A) défauts/incohérences du support** (les utiles), puis **(B) artefacts de
l'environnement de test** (à ne PAS corriger côté tuto, signalés pour transparence),
puis **(C) ce qui marche bien**.

---

## (A) Défauts & incohérences du support

### A1. ⚪️ `tutoquartotypst` pas encore sur r-universe — **état attendu, pas un défaut**
> **Mise à jour 2026-06-03 (CD) :** la publication r-universe est **volontairement la
> dernière étape**, prévue **quand le dépôt deviendra public**. Ce n'est donc **pas un
> bug** et il n'y a **rien à corriger** pour l'instant. Constat conservé ici pour mémoire
> (penser à publier avant de diffuser la page `pretuto`).

Constat brut du parcours : `preparatifs.qmd` propose comme premier geste

```r
install.packages("tutoquartotypst",
  repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org"))
```

→ aujourd'hui **`package 'tutoquartotypst' is not available`** (l'org `cderv.r-universe.dev`
existe et sert `pandoc`, mais le paquet n'y est pas encore — dépôt privé). Le repli manuel
documenté juste en dessous fonctionne (j'ai installé tous les prérequis par ce chemin, et
le paquet en local via `R CMD INSTALL pkg/`).

**Rappel pré-diffusion :** publier sur r-universe (cf. `pkg/dev/PUBLICATION-r-universe.md`)
**avant** de partager la page `pretuto` publiquement.

*Note connexe :* une fois publié, sur **Linux** la commande compile depuis les sources
(r-universe ne fournit pas de binaires Linux, et `cloud.r-project.org` non plus). Les
participant·e·s Windows/macOS (RStudio) auront des binaires ; les participant·e·s Linux
subiront une longue compilation de `dplyr`/`ggplot2`/`gt`. À garder en tête pour le
support.

### A2. 🔴 Exo 2, étape 2a : en suivant le modèle, `annexe-donnees` **disparaît**
Le « Vous devriez voir » de l'étape **2a** annonce :
> « `annexe-donnees` apparaît comme **dernier chapitre numéroté**. »

Mais le **modèle `_quarto.yml` fourni** (page Bloc 2) ne liste `annexe-donnees` que sous
`appendices:`, avec la consigne : « *pour 2a seul, omettez le bloc `appendices:`* ».
En suivant le modèle à la lettre pour 2a, `annexe-donnees` n'est **ni dans `chapters:`
ni dans `appendices:`** → il **n'apparaît pas du tout** dans le PDF (vérifié : absent du
texte et de la TOC). Contradiction directe avec l'attendu de l'étape.

**Action :** soit ajouter `annexe-donnees.qmd` en fin de `chapters:` pour l'état 2a
(puis le déplacer vers `appendices:` en 2b), soit corriger le « Vous devriez voir » de
2a (p. ex. « les 4 chapitres + la couverture ; `annexe-donnees` deviendra l'annexe A à
l'étape 2b »).

### A3. 🟠 Le modèle `_quarto.yml` du site omet `lang: fr` → labels en anglais dans un livre FR
La **correction** a `lang: fr` (→ « Chapitre », « Table des matières »). Mais le
**modèle `_quarto.yml` du site** et les étapes 2a/2b/3 **ne mentionnent jamais
`lang: fr`**. Résultat en suivant les instructions (reproduit) :
- référence croisée `@sec-origines` → « *on y revient au **Chapter 2*** » (anglais) ;
- sommaire → « **Table of Contents** ».

Le bonus B1 illustre la cross-ref avec « Figure 1.1 » (identique FR/EN), ce qui **masque
le problème**. Un·e participant·e qui compare son livre à la correction verra une
différence inexpliquée.

**✅ Corrigé (fix #2, 2026-06-03)** : `lang: fr` ajouté au modèle `_quarto.yml` du site
+ à l'exo 1 (correction + étape 2). Vérifié : TOC → « Table des matières », réf croisée
inline → « Chapitre 2 », annexe → « Annexes ». Sortie de l'étudiant·e désormais **à parité
avec la correction**.

> **Limite résiduelle (hors périmètre, amont) :** le **titre de chapitre** reste
> « **Chapter N. …** » (ex. « Chapter 2. Origines »). C'est l'extension **orange-book** qui
> code `supplement-chapter: "Chapter"` en dur et ne le dérive pas de `lang` ; le pont
> Quarto→orange-book (`typst-show.typ`) transmet `lang` mais **pas** `supplement-chapter`.
> **La correction officielle a le même comportement** (elle a déjà `lang: fr` et affiche
> tout de même « Chapter 1/2 »). Ce n'est donc pas régressé par le fix — ce serait un
> correctif **upstream** (orange-book / Quarto) ou un override raw Typst, non traité ici.

### A4. 🟠 Exo 1, étape 3 : « Couleurs palette visibles (**titres**, liens) » — faux pour un doc simple
Dans un document `format: typst` **simple**, `primary: imperial-red` ne colore **pas**
les titres. Vérifié sur ma transcription **et** sur la correction officielle : les titres
de section sont **noirs** (couleur `foreground`). Le seul rouge visible vient du style
**manuel** du tableau (ligne Jabba). Le « Vous devriez voir » laisse attendre des titres
colorés par la palette, ce qui n'arrive pas.

Nuance importante : en **mode book** (exo 2, orange-book), `primary` colore bien l'accent
des titres et la couverture — d'où une confusion possible entre les deux exos.

**✅ Corrigé (fix #3, 2026-06-03)** : « Vous devriez voir » de l'étape 3 reformulé —
« liens colorés en imperial-red, fond crème, Inter en corps, logo en haut-gauche ; les
titres restent en `foreground` noir, la couleur `primary` sur les titres arrive avec le
livre au Bloc 2 ».

### A5. 🟠 Exo 1 : « TABLE OF CONTENTS » en anglais (pas de `lang: fr`)
Ni le starter, ni la **correction** de l'exo 1, ni les instructions ne posent `lang: fr`.
Le `toc: true` produit donc « **TABLE OF CONTENTS** » dans un rapport entièrement en
français (vérifié sur la correction). Même famille de problème que A3.

**✅ Corrigé (fix #2, 2026-06-03)** : `lang: fr` ajouté à la correction exo 1 et suggéré à
l'étape 2. Vérifié : « Table des matières » au rendu.

### A6. 🟠 Exo 2, étape 3 : « tableaux `gt` re-stylés » — n'arrive PAS en copiant `_brand.yml`
Le « Vous devriez voir » de l'étape 3 promet « *tableaux `gt` re-stylés* ». Or copier
`_brand.yml` **ne re-style pas** les tableaux `gt` : `gt` ne lit pas la charte. Vérifié
au rendu : après l'étape 3, les tableaux restent **bruts** (pas de bandeau jaune, pas de
ligne Jabba rouge) et gardent l'espacement « 1 7 5 ». Le re-style est l'objet du
**Bonus 4** (`theme_brand_gt()` / `theme_brand_ggplot2()`), explicitement « approfondissement
après l'atelier ».

**✅ Corrigé (fix #4, 2026-06-03)** : « tableaux `gt` re-stylés » retiré de l'attendu de
l'étape 3, remplacé par « les tableaux `gt` restent bruts à ce stade — leur mise aux
couleurs de la charte est l'objet du Bonus 4 ».

### A7. 🟡 Exo 2, étape 3 : « Couverture **jaune** Star Wars » — la bande est en fait rouge/rose
La bande de couverture orange-book utilise `primary` = **imperial-red** → elle est
**rouge/rose**, pas jaune. Seul le **logo étoile** est jaune. Le README (Bonus 3)
explique précisément ce choix (le jaune en `primary` serait illisible). Le « Vous devriez
voir » de l'étape 3 (« Couverture **jaune** ») contredit donc le design réel.

**✅ Corrigé (fix #4, 2026-06-03)** : même cellule que A6 — « Couverture **jaune** » →
« Couverture aux couleurs Star Wars (bande imperial-red + logo étoile jaune) ».

### A8. 🟡 Exo 2, étape 2a : le modèle contient déjà `logo: path: sw-star` alors que `_brand.yml` arrive à l'étape 3
À l'étape 2a, le modèle `_quarto.yml` référence `logo: path: sw-star`, mais l'image
`sw-star` n'est définie que par `_brand.yml` (copié à l'étape 3). Bonne nouvelle : **aucune
erreur** (Quarto ignore silencieusement le logo absent). Mais le logo annoncé n'apparaît
pas avant l'étape 3, ce qui peut dérouter qui scrute le résultat.

**✅ Corrigé (fix #5, 2026-06-03)** : commentaire ajouté dans le bloc `logo:` du modèle —
« `sw-star` est défini par `_brand.yml` (étape 3) ; avant, ce bloc est sans effet (logo
absent, aucune erreur) ».

### A9. 🟡 Préparatifs : « un avertissement sur la police est normal » → en réalité ~6-10 avertissements
Le test d'installation produit une **avalanche** de `unknown font family:` (sans-serif,
segoe ui, apple color emoji, roboto, helvetica…), pas « un » avertissement. Un·e
débutant·e peut s'alarmer de ce mur de warnings alors que le PDF est correct.

**✅ Corrigé (fix #6, 2026-06-03)** : prép reformulée au pluriel (« plusieurs
avertissements normaux — tant que vous voyez `Output created`, c'est bon »).

**Recherche issue + workaround (demande CD)** : deux issues quarto-cli distinctes,
**toutes deux ouvertes** au 2026-06 :
- **[quarto-cli#12556](https://github.com/quarto-dev/quarto-cli/issues/12556)** — *la
  verbosité du warning* `unknown font family` lui-même. Typst (≥ 0.12) alerte pour chaque
  police absente d'un stack CSS, là où le navigateur les ignore en silence. **Aucun
  workaround de suppression côté config** ; piste mainteneur : filtrer les polices
  indisponibles lors de la traduction CSS→Typst. → warnings **cosmétiques, à ignorer**.
- **[quarto-cli#11683](https://github.com/quarto-dev/quarto-cli/issues/11683)** — le *bug
  de rendu* « 1 7 5 » (changement de police sur chaînes alphanumériques dans `gt`).
  **Workaround = `gt::opt_table_font(font = "Inter")`** (déjà appliqué dans les corrections
  et documenté au Bonus 4).

Le lien de la prép pointait vers #11683 (le bug de rendu) pour parler du *warning* → corrigé
vers #12556 (le bon ticket), avec mention de #11683 pour le « 1 7 5 ». **Pas de workaround
disponible pour faire taire les warnings** ; seul le bug de rendu a un remède.

---

## (B) Artefacts de l'environnement de test (NE PAS corriger côté tuto)

Signalés pour transparence — un poste participant·e standard (RStudio macOS/Windows, locale
UTF-8, polices système) ne les rencontrera pas, ou de façon atténuée.

- **B1. `rig` bloqué par le proxy TLS du bac à sable.** `rig add release` →
  `invalid peer certificate: UnknownIssuer` : la passerelle d'egress ré-signe le TLS avec
  un CA que rig (rustls, racines embarquées) ne connaît pas, alors que `curl` (CA système)
  l'accepte. Contourné en installant le **même** build que rig (`.deb` Posit r-builds,
  `cdn.posit.co/r/ubuntu-2404/...`). → limite d'infra, pas du tutoriel.
- **B2. Locale C/POSIX du conteneur** (`LANG` non défini) → `brand.yml::read_brand_yml()`
  (appelé dans la correction exo 1 et le Bonus 4) plante sur l'accent « É » de
  `alt: "Étoile jaune Star Wars"` (`yaml::yaml.load`, *unexpected end of stream*). Réglé
  via `LANG=C.UTF-8`. Un poste RStudio est en UTF-8 → non concerné. *(Piste éventuelle si
  on veut blinder : `verifier_installation()` pourrait avertir si la locale n'est pas
  UTF-8, car le symptôme est cryptique.)*
- **B3. Polices système absentes** (pas d'Arial, etc.) → espacement « 1 7 5 » dans les
  tableaux `gt` non brandés, et « `<U+00C9>chelle log` » (É manquant) dans le **titre du
  graphique** du test d'install. Le tuto documente déjà le remède (`opt_table_font("Inter")`)
  en correction et Bonus 4.

---

## (C) Ce qui fonctionne très bien

- **Pipeline exo 1** : `format: html` → `typst`, options (`papersize`, `toc`, `keep-typ`),
  puis `_brand.yml` transcrit de la charte → PDF crème, **titres Star Jedi**, **corps Inter
  (téléchargé via Google)**, **logo** en haut-gauche. Les 4 étapes produisent un beau
  résultat.
- **Charte `charte-starwars.pdf`** : excellente, auto-documentée (palette + hex +
  affectations + usages YAML). Transcription sans ambiguïté.
- **Exo 2 / orange-book** : PDF unique, couverture, **numérotation 1.1 / 2.1 / 2.2**,
  **annexe A** (étape 2b), cross-refs : tout fonctionne. Le warning `?@sec-origines` à
  l'étape 1 est bien celui annoncé.
- **Contournement `font-paths`** : bug **reproduit** sur Quarto 1.9.36
  (`unknown font family: star jedi` en mode book → titres serif), et le contournement
  documenté **le corrige** (warning disparu, Star Jedi appliqué). Callout juste et utile.
- **Paquet compagnon** : `verifier_installation()` est remarquable — détecte R/Quarto/
  paquets, **fait un vrai rendu de test**, et signale spécifiquement « *Quarto 1.9.36 :
  à l'exercice 2, une petite manipulation (font-paths) vous sera indiquée* ».
  `installer_exercices()` n'installe que les `starter/` (pas les corrections), avec des
  messages `cli` soignés. Très bon outil — d'où l'importance de A1 (le publier).

---

## Priorités suggérées
1. **A2** (annexe-donnees qui disparaît à l'étape 2a) et **A3** (`lang: fr` manquant dans
   le modèle `_quarto.yml`) — incohérences instructions ↔ correction, visibles en séance.
2. **A4 / A6 / A7** — « Vous devriez voir » qui sur-promettent (titres colorés, tableaux
   re-stylés, couverture jaune) ; risquent de faire douter les participant·e·s.
3. **A5 / A8 / A9** — finitions FR/confort.
4. **A1** — *aucune action immédiate* : publication r-universe volontairement reportée à
   l'ouverture publique du dépôt. Simple rappel : le faire **avant** de diffuser `pretuto`.
