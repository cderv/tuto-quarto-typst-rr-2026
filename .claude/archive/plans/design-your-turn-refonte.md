# Design — Refonte Your Turn pour autonomie 50/1

> **Statut :** validé en brainstorming 2026-05-19.
> **Origine :** échange Chris ↔ Claude 2026-05-19. Reprend et étend `design-indices-your-turn.md` (brouillon précédent, désormais superseded).
> **Contraintes critiques :** 1 animateur seul pour ~50 participants, 2h total, public francophone Rencontres R 2026, salle Nantes (wifi incertain).
> **Goal :** rendre l'animateur dispensable les 5 premières minutes de chaque Your Turn pour permettre l'aide ciblée sur les 5 dernières.

## Objectif

Refondre les Your Turn (et leur contexte autour : starter, correction, slide, page web) pour qu'un participant bloqué ait un chemin **lisible et gradué** vers le déblocage, sans solliciter l'animateur. Le tutoriel doit "tourner sans guide" pendant les 12 minutes d'exercice.

## Diagnostic (état pré-refonte)

- **Asymétrie Exo 1 ↔ Exo 2.** Exo 1 = liste plate `1-2-3-4-5` sans checkpoint visuel. Exo 2 = tableau structuré `# | Action | Vous devriez voir` + niveaux explicites (obligatoire / bonus / deep dive). Sortie Exo 1 = frustration cumulée juste avant la pause.
- **Pas d'exit strategy graduée.** Aujourd'hui : étape OK ou correction monolithique. Rien entre. Participant bloqué 10 min sans s'autoriser à ouvrir la correction = scénario réaliste à 50/1.
- **Source de vérité dupliquée.** Starter Exo 2 `README.md` redécrit les étapes + `index.qmd` du site les redécrit. Drift garanti d'ici le 16 juin. Exo 1 starter n'a même pas de README.
- **Pas de "mode d'emploi" au démarrage du Your Turn.** Tu annonces "à vous, 12 min" → 50 personnes ouvrent 3 onglets en panique. Manque le repère visuel projeté qui dit "où chercher si bloqué".
- **Deep dives B3/B4 sans critère d'entrée.** Participant a fini l'étape 3 → où aller ? Pas de signal "tu es prêt pour B4".

## Décisions

### 1. Contrat des 4 surfaces

Chaque surface a un rôle strict, pas de chevauchement.

| Surface | Rôle | Contenu |
|---|---|---|
| **Site (page exo `index.qmd`)** | Source unique consigne + pédagogie | Objectif, niveaux (obligatoire / bonus / deep dive), tableau étapes 3 colonnes, collapse "Indices doc", callouts pièges, lien correction. Inclut le starter `README.md` via `{{< include >}}` pour le quick-ref opérationnel. |
| **Slide "À vous !" du deck** | Ancre temporelle dans la présentation | Titre + URL page boussole + lien retour deck. Minimaliste, lisible fond de salle. |
| **Page boussole** (1 par bloc, projetée) | Surface de projection pendant les 12 min | Countdown gros + objectif 1 phrase + étapes condensées (verbes seuls) + escalier autonomie 3 marches + URL page exo (+ QR éventuel). |
| **Starter `README.md`** | Quick-ref opérationnel, includable site | Inventaire fichiers, fichier à éditer, commande render, sortie attendue. Self-contained Github browse. |
| **Correction `README.md`** | Filet, ultra-minimal | 3 lignes : "Solution de l'exo X. Énoncé : [URL site]. Render : `quarto render`." |

**Rationale single-source via include :** `{{< include >}}` shortcode Quarto (confirmé via context7, doc Quarto canonique `https://quarto.org/docs/authoring/includes.html`) supporte `.md` et `.qmd`, paths relatifs au fichier qui inclut, références internes résolues côté document inclueur. Le starter `README.md` reste browsable sur Github (contraint pédagogique : on parle de cloner le repo dans les préparatifs) **et** sert de bloc inclus dans `index.qmd`. Pas de duplication, pas de drift.

### 2. Gabarit unifié d'une étape (Exo 1 et Exo 2)

Forme **(b)** du design précédent — bloc indices en collapse séparé, pas inline dans le tableau.

```markdown
**Étapes principales (X min) — attendues de tous**

| # | Action | Vous devriez voir |
|---|--------|-------------------|
| 1 | ... | ... |
| 2 | ... | ... |

**+ N bonus**

| # | Action | Vous devriez voir |
|---|--------|-------------------|
| B1 | ... | ... |

::: {.callout-tip collapse="true"}
## 💡 Indices doc
- Étape 1 : [doc primaire](url) — section X.Y
- Étape 2 : [doc primaire](url)
- Bonus B1 : [doc](url)
:::

::: {.callout-tip collapse="true"}
## Deep dive — [titre]
[Narratif libre, code, captures]
:::
```

**Trois colonnes max** (pas 4 avec colonne indice inline) : le tableau reste scannable, indices restent accessibles à la demande sans charge cognitive permanente.

**Bonus rapides** = lignes du même tableau (ou tableau frère immédiatement sous). **Deep dives** = callout collapse narratif libre (B4 brand R = ~50 lignes de R explicatives, n'entre pas dans une cellule).

### 3. Escalier autonomie (3 marches)

Affiché sur la page boussole projetée pendant les 12 min :

1. **Relire l'objectif + résultat attendu** (en haut de la page exo).
2. **Ouvrir le collapse "💡 Indices doc"** sous le tableau d'étapes — 1 à 3 liens doc par étape.
3. **Ouvrir `exercises/XX/correction/`** (filet final).

**Animateur = pas signalé** sur l'escalier. Geste "lever la main" reste implicite. À 50/1, signaler l'animateur comme marche = saturation garantie.

**"Demander au voisin" = pas signalé** non plus. Les participants le feront naturellement, mais l'ériger en marche officielle transforme la salle en bourdonnement ingérable à 50.

### 4. Page boussole — gabarit

```
┌─────────────────────────────────────────────────┐
│  À vous ! — Exercice X                          │ ← titre gros
│                                                 │
│         ⏱  12:00 (countdown via shortcode)      │ ← visible fond de salle
│                                                 │
│  🎯 Objectif : [1 phrase]                        │
│                                                 │
│  📋 Étapes :                                     │
│   1. [verbe + COD court]                        │
│   2. ...                                        │
│   3. ...                                        │
│                                                 │
│  🆘 Si vous bloquez :                            │
│   1. Relire l'objectif + résultat attendu       │
│   2. Ouvrir les indices doc sous le tableau     │
│   3. Ouvrir exercises/XX/correction/            │
│                                                 │
│  📖 Consigne complète : [URL page exo]           │
└─────────────────────────────────────────────────┘
```

**Fichiers :** `1-quarto-typst/boussole.qmd` et `2-projets/boussole.qmd`. Une page par bloc, chacune autonome avec son propre `format: html` et `{{< countdown 12:00 >}}` qui démarre au chargement de la page.

**Flux live :** slide "À vous !" affiche l'URL → tu cliques pour ouvrir la page boussole dans un onglet → tu projettes l'onglet pendant les 12 min → countdown reset propre à chaque your turn.

**"Étapes condensées" sur la boussole** = verbes seuls (`Créer _quarto.yml`, `Passer à book`, `Copier _brand.yml`). Risque drift mineur si on garde au verbe court. Pas la consigne complète, qui reste exclusivement côté `index.qmd`.

### 5. Inventaire doc → étapes

Reprendre et compléter le mapping ébauché dans `design-indices-your-turn.md` (table lignes 51-67) :

- `format: typst`, options Typst, `_brand.yml`, `brand-color` Typst, `keep-typ`, `type: book`, cross-refs, pagebreak conditionnel, `brand.yml` R helpers, `brand_color_pluck`, gt API, ggplot2 scales, Typst highlight — chaque concept a sa doc primaire et parfois secondaire identifiée.

**Règle :** **max 2-3 docs par étape** pour éviter la surcharge (participant qui ouvre 8 onglets = noyé).

### 6. Audit liens cassés

Tâche pré-J16 dédiée : `curl -sI` sur chaque URL doc du mapping, marquer celles qui répondent ≠ 2xx pour patch. Doit être inscrit dans le PLAN.md "restes pour CD avant le 16 juin".

## Hors scope (volontaire)

- **Captures d'écran "résultat attendu"** par étape pivot. Maintenance trop lourde d'ici le 16 juin. La colonne textuelle "Vous devriez voir" reste suffisante pour l'instant. Réserver pour itération post-2026.
- **Sous-correction par étape** (correction granulaire dans `correction/etape-1.qmd`, `correction/etape-2.qmd`, etc.). La correction monolithique + escalier autonomie suffisent ; éclatement = explosion de fichiers à maintenir.
- **Page "Exercices" centralisée** avec progression visuelle entre les blocs. Trop ambitieux pour 2h.
- **Slack/chat live de salle pour Q&R asynchrone.** Hors scope outillage. Si tu veux l'envisager, c'est une décision séparée.

## Risques résiduels

- **Wifi Nantes incertain.** Site est source unique → dépendance web pour les 12 min des Your Turn. Mitigation : `preparatifs.qmd` doit insister sur `git clone` en amont ; le starter `README.md` cloné contient le quick-ref opérationnel, donc le strict minimum pour avancer existe offline. La page boussole projetée reste accessible côté animateur (toi).
- **Liens doc en anglais.** Doc Quarto/Posit majoritairement anglophone. Public Rencontres R généralement à l'aise, mais à mentionner explicitement en intro du workshop pour ne pas piéger un débutant.
- **Drift README ↔ site sur le quick-ref.** Éliminé par `{{< include >}}`, à condition de **ne pas re-dupliquer** le quick-ref dans `index.qmd`. Discipline d'écriture : `index.qmd` contient la pédagogie + un seul include du README starter.
- **Charge timing du format "indices doc".** Chercher dans la doc prend plus de temps que copier la correction. Si tu vois plusieurs participants bloqués à 8 min sur 12, mention live : "ok, on regarde la correction ensemble" — l'escalier ne doit pas devenir une prison.
- **Page boussole = nouvelle surface à maintenir.** 2 fichiers `boussole.qmd` + 2 slides "À vous !" à synchroniser quand les étapes changent (verbes condensés). Discipline : tout changement d'étape majeur déclenche la mise à jour des 4 endroits (index, boussole, slide, README starter si pertinent).

## Ordre d'implémentation suggéré

1. **PoC Exo 1.** Restructurer `1-quarto-typst/index.qmd` au nouveau gabarit (tableau 3 cols + indices collapse). Créer `exercises/01-document-typst/starter/README.md`. Créer `1-quarto-typst/boussole.qmd`. Adapter la slide "À vous !" dans `1-quarto-typst.qmd`. Ajouter `exercises/01-document-typst/correction/README.md` (3 lignes).
2. **Review pédagogue + débutant** sur Exo 1 PoC.
3. **Étendre à Exo 2.** Adapter `2-projets/index.qmd` (déjà partiellement structuré : surtout ajout collapse indices doc, alignement libellés). Refactorer `exercises/02-projet-book/starter/README.md` au format quick-ref includable (aujourd'hui il duplique les étapes — supprimer). Créer `2-projets/boussole.qmd`. Adapter la slide "À vous !" dans `2-projets.qmd`. Ajouter `exercises/02-projet-book/correction/README.md` (3 lignes).
4. **Mapping doc complet** : étendre le tableau étape → doc à toutes les étapes finalisées des deux exos.
5. **Audit liens** : script qui curl chaque URL doc, rapport des cassés.
6. **Test à blanc** : chronométrer le your turn sur un cobaye (Maëlle ou autre), valider que le format "indices" tient le timing.

## Décisions de surface (à propager dans les supports)

- `format: html` sur les `boussole.qmd` (cohérent avec règles `.claude/CLAUDE.md`)
- `author: ""` + `date: ""` sur les `boussole.qmd` pour override valeurs projet `_quarto.yml`
- Countdown shortcode = `{{< countdown 12:00 >}}` (extension Quarto, pas le package R)
- Lien retour deck depuis boussole = lien Quarto standard, pas iframe
- Style boussole minimaliste : pas de TOC, pas de sidebar (à régler dans le YAML page ou via SASS si besoin)

## Pointeurs vers contexte existant

- Your Turn Bloc 1 : `1-quarto-typst/1-quarto-typst.qmd` (slide "À vous !") + `1-quarto-typst/index.qmd:42` (callout exercice)
- Your Turn Bloc 2 : `2-projets/2-projets.qmd` (slide) + `2-projets/index.qmd:38` (callout exercice, tableau étapes ligne 49)
- Bonus 4 actuel : `2-projets/index.qmd:152`
- Starter Exo 1 : `exercises/01-document-typst/starter/` (pas de README aujourd'hui)
- Starter Exo 2 : `exercises/02-projet-book/starter/README.md` (à refactorer)
- Corrections : `exercises/01-document-typst/correction/` et `exercises/02-projet-book/correction/`
- Page Ressources : `4-ressources.qmd` (cible pour mentionner les bibliographies upstream en complément)
- Brouillon précédent : `.claude/design-indices-your-turn.md` (à marquer superseded)

## Décisions tranchées en brainstorming 2026-05-19

| Question | Décision |
|---|---|
| Source unique consigne | Site (`index.qmd`) — README starter inclus via `{{< include >}}` |
| Rôle slide "À vous !" | Boussole minimaliste (titre + URL page boussole) |
| Surface projection live | Page web dédiée par bloc (`boussole.qmd`) |
| Contenu page boussole | Countdown + objectif + étapes condensées + escalier autonomie |
| README starter | Quick-ref opérationnel includable site |
| README correction | 3 lignes minimal |
| Escalier autonomie | 3 marches : relire / indices doc / correction (pas voisin, pas animateur signalés) |
| Gabarit étape | Tableau 3 cols + collapse "Indices doc" en pied |
| Bonus vs deep dive | Bonus = lignes du tableau ; deep dive = callout collapse narratif libre |
| Captures d'écran checkpoints | Hors scope itération 1 |
