# Review ciblée — index vs boussole (charge cognitive / redondance)

Date : 2026-06-05 · Périmètre : `1-quarto-typst/{index,boussole}.qmd`, `2-projets/{index,boussole}.qmd`

## Question
Faut-il supprimer la partie exercice des `index.qmd` au profit d'un simple lien vers la boussole (Option B de Christophe) ?

## Recommandation : Option A (légèrement amendée → C)
Garder l'index comme **référence profonde** + boussole **glanceable**, en dé-dupliquant uniquement l'objectif/étapes courts. Ne PAS faire l'Option B.

## Analyse des deux artefacts
Les deux fichiers ont des **fonctions andragogiques distinctes et non substituables** :

- **Boussole** = support transitoire projeté pendant le chrono (mode focus, charge cognitive minimale, countdown auto-start). Elle délègue déjà explicitement la profondeur à l'index : "Consigne complète", "Indices doc sur la page Exercice", lien correction. C'est un *résumé orientant*, pas une consigne autoportante.
- **Index** = référence persistante consultable au rythme du participant. Contient la **boucle de feedback d'auto-correction** (colonne « Vous devriez voir » — pilier de l'autonomie andragogique : se corriger sans appeler Maëlle), les indices doc gradués, le modèle `_quarto.yml` complet (ex2), les pièges anticipés (PDF verrouillé, bug gt « 1 7 5 », polices < v1.10.4), et les approfondissements B3/B4.

## Pourquoi PAS l'Option B (boussole = source unique)
1. **Perte de la boucle d'auto-correction** : la colonne « Vous devriez voir » disparaîtrait du glanceable (volontairement absente de la boussole pour rester courte). Or c'est elle qui permet à un participant de savoir s'il a réussi l'étape N sans formateur. La supprimer dégrade directement le critère andragogique d'autonomie.
2. **Surcharge de la boussole** : y réinjecter table + modèle YAML + B3/B4 (ex2) détruit la nature « glanceable » → l'écran projeté devient illisible, le countdown noyé.
3. **Référence durable cassée** : l'index est ce que le participant relit après l'atelier (et la page liée par les slides). La boussole `page-layout: custom` sans sidebar est un mauvais point d'ancrage de navigation.
4. **Maëlle perd son point d'appui en salle** : elle dépanne en pointant les pièges/correction de l'index ; une boussole nue ne lui donne plus rien à montrer.

## Option C (A amendée) — recommandée
Conserver l'index profond, mais **resserrer la zone qui double la boussole** :
- Dans l'index, garder l'objectif (une ligne) + le lien boussole, mais **fusionner l'objectif/les étapes courtes dans le tableau** au lieu de les répéter en prose au-dessus. Aujourd'hui ex1 répète l'objectif ligne 46 ET implicitement dans la table ; ex2 idem ligne 50. La redondance réelle est mince et acceptable — c'est surtout l'objectif d'1 ligne qui apparaît 2× (index + boussole), ce qui est OK (renforcement, pas surcharge).
- **Inverser légèrement le sens du renvoi** : l'index pointe vers la boussole « pour le chrono » (déjà fait, lignes 48/52) ; la boussole pointe vers l'index « pour le détail » (déjà fait). Le système de double-renvoi est sain — ne rien casser.

Conclusion : la duplication actuelle est **fonctionnelle, pas accidentelle** (deux modes de lecture pour deux moments). L'écart de contenu entre les deux est déjà le bon. Garder tel quel ; au plus, vérifier que l'objectif d'1 ligne reste identique mot pour mot entre index et boussole (cohérence) — c'est le cas aujourd'hui.

## Risque résiduel
Si CD veut réduire la maintenance (2 endroits à synchroniser), le seul point de dérive est l'**objectif + liste d'étapes**. Solution sans perte : faire de l'objectif/étapes un `{{< include >}}` partagé. Mais gain faible vs risque de complexité — non prioritaire pour le 16 juin.
