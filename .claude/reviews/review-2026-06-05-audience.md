# Review — Audit d'audience « qui dit quoi à qui »

- **Date** : 2026-06-05
- **Type** : audience (qui lit quoi : participant·e / animateur)
- **Déclencheur** : remarque CD — « on dit *le workaround à donner en salle* ; c'est vraiment à destination du public ? On a besoin d'auditer ce qui est dit pour qui. »
- **Périmètre** : toutes les surfaces publiées + semi-publiées + privées du site.
- **Statut** : diagnostic à traiter **plus tard** (rien corrigé à ce stade).

## Modèle d'audience (3 niveaux)

| Niveau | Surfaces | Registre attendu |
|---|---|---|
| **Public / participant** | `index.qmd`, `preparatifs.qmd`, `*/index.qmd`, `*/boussole.qmd`, `3-aller-plus-loin/`, `4-ressources.qmd`, READMEs inclus, **corps des slides** | participant (« vous »), aucune régie |
| **Semi-public** | blocs `::: notes` des decks reveal | animateur, **mais atteignable** (touche `s`, source HTML) |
| **Privé animateur** | `_speaker/**` (préfixe `_`, non publié) | animateur 100 % OK |

## Confirmations de contexte (vérifiées)

- **`_speaker/**` non publié** : préfixe `_` → exclu du render ; `_site/_speaker` absent ; aucun lien public. Donc la ligne signalée par CD (`_speaker/demo-bloc1-our-turn.qmd:145`, « Pas de fix Quarto dédié connu… c'est le workaround à donner en salle ») est en **zone privée → OK, pas une fuite**.
- **`::: notes` = semi-public, confirmé matériellement** : chaînes « Fusible à couper » et « CD parle » présentes verbatim dans `_site/2-projets/2-projets.html`. Atteignables via vue présentateur (`s`) ou code source.
- **Corps des pages HTML + corps des slides + READMEs inclus** : propres, aucune fuite de registre animateur.

## Trouvailles — Hautes (toutes dans des `::: notes` semi-publiques)

> Toutes ont déjà leur équivalent dans `_speaker/pilotage.qmd` ou les zooms démo → suppression/déplacement **sans perte**.

| # | Fichier:ligne | Problème | Action recommandée |
|---|---|---|---|
| H1 | `2-projets/2-projets.qmd:239` | « Fusible à couper si le timing serre — sauter au wrap-up » : pilotage exposé | Déplacer vers `_speaker/` (déjà dans `pilotage.qmd:63-69`) |
| H2 | `1-quarto-typst/1-quarto-typst.qmd:334` | « premier fusible à couper si on manque de temps » | Déplacer vers `_speaker/` (doublon `pilotage.qmd`) |
| H3 | `1-quarto-typst/1-quarto-typst.qmd:309` | « Maëlle passe dans les rangs… CD reste au tableau » : mise en scène + noms internes | Déplacer vers `_speaker/` (doublon `demo-bloc1:116-119`, `pilotage.qmd:44`) |
| H4 | `2-projets/2-projets.qmd:217` | « Maëlle passe dans les rangs et repère ceux qui peinent » | Déplacer vers `_speaker/` ; **garder** l'astuce « underscore manquant » côté participant en la reformulant |
| H5 | `2-projets/2-projets.qmd:253` | « **CD parle.** Vous êtes parti·e… » : didascalie de régie collée à du contenu participant | Retirer « CD parle. » → `_speaker/` ; garder le récit de clôture |

## Trouvailles — Moyennes

| # | Fichier:ligne | Problème | Action |
|---|---|---|---|
| M1 | `1-quarto-typst/1-quarto-typst.qmd:344` | « chronogramme de pilotage : reprise à 11h00 » : heure interne + réf. doc privé | Reformuler : garder « ~10 min », retirer l'heure + la mention chronogramme |
| M2 | `1-quarto-typst/1-quarto-typst.qmd:255` | « pointer du doigt vers la slide précédente » : geste scénique | Geste → `_speaker/` ; le reste de la note (justification) est inoffensif |
| M3 | `1-quarto-typst/1-quarto-typst.qmd:247` & `:279` | régie de projection de la charte + vocabulaire de phase | Déplacer vers `_speaker/` (doublon `demo-bloc1:28`) |
| M4 | `1-quarto-typst.qmd:275` & `2-projets.qmd:162` | pointeur explicite vers un **chemin privé** `_speaker/demo-bloc*-our-turn.qmd` exposé dans les notes | Retirer la référence au chemin des notes |

> Note : numéros de ligne relevés avant les éditions du 2026-06-05 (slide Pause, snippet `_brand.yml`, etc.) — **revérifier les lignes** avant correction, le contenu reste le repère fiable.

## Info utile actuellement enfermée en notes (catégorie « à remonter », gravité basse)

- `1-quarto-typst/1-quarto-typst.qmd:249` — méta-cohérence « ce PDF que vous tenez vient d'un `_brand.yml` identique au vôtre » : argument pédagogique fort, à envisager **dans le corps** de la slide « Voici la charte ».
- `1-quarto-typst/1-quarto-typst.qmd:251` — définition « rôles » = « assignments » : pourrait être une glose d'une ligne dans le corps.
- **Aucune info bloquante** n'est piégée en privé : Plan B offline, bug `gt`, workaround `font-paths`, seuils de version Quarto sont tous correctement sur `preparatifs.qmd` / `2-projets/index.qmd`.

## Incohérences de registre (catégorie 4)

- Seul vrai mélange « vous » / régie : `2-projets/2-projets.qmd:253` (déjà H5). Les « on » du corps des slides (« on passe le doc en PDF ») sont le **« on » inclusif Our turn** légitime — pas une correction.

## Priorisation suggérée

1. Traiter H1–H5 (déplacement vers `_speaker/`, contenu déjà dupliqué → sans perte).
2. Nettoyer M1–M4 en une passe sur les deux decks (heures internes, gestes, chemins `_speaker/`).
3. Optionnel : remonter méta-cohérence (l.249) + glose « rôles » (l.251) dans le corps pour l'autonomie post-atelier (matériel CC BY).

## Bilan

Cloisonnement **corps / HTML excellent**. Le travail porte **exclusivement** sur l'hygiène des blocs `::: notes` (semi-publics) qui contiennent du pilotage déjà présent dans `_speaker/`. Décision de fond ouverte : **considère-t-on les `::: notes` comme privées (on les nettoie) ou comme acceptablement semi-publiques (on tolère) ?** — cf. discussion avec CD.
