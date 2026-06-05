# Review pédagogue — Refonte Your Turn Exo 1 PoC (2026-05-19)

> Reviewer : workshop-reviewer-pedagogue (sonnet)
> Périmètre : PoC Exo 1 uniquement avant extension Exo 2
> Tag : `ter` (3e review du 2026-05-19, après gt-brand-color)

## Verdict général

Le PoC Exo 1 est solide. Le contrat des 4 surfaces tient, l'escalier autonomie est correctement calibré, et les notes presenter sont les meilleures du deck. **Deux points techniques bloquants avant d'étendre à Exo 2** (lien boussole cassé depuis le slide, et la marche 2 de l'escalier introuvable depuis la boussole projetée). Quelques frictions mineures de wording mais rien qui compromette les 12 minutes à 50/1.

---

## Critique — bloquant avant extension à Exo 2

### B1 — Lien boussole cassé dans les notes presenter

`1-quarto-typst/1-quarto-typst.qmd:236` — les notes disent : "Ouvrir la page boussole `1-quarto-typst/boussole.html`". Problème : Quarto génère `_site/1-quarto-typst/boussole/index.html`, pas `_site/1-quarto-typst/boussole.html`. Si Chris suit les notes au pied de la lettre en salle, il ne trouve pas l'onglet. Vérifier l'URL réelle après `quarto render` et corriger la note.

### B2 — La marche 2 de l'escalier est introuvable depuis la boussole projetée

`1-quarto-typst/boussole.qmd:30` — escalier marche 2 : "Ouvrir le collapse **💡 Indices doc** sous le tableau". La boussole est projetée, le participant regarde l'écran, lit la marche 2, puis cherche "sous le tableau" — mais sur quelle page ? La boussole n'a pas de tableau. Il faut ouvrir la page exo, trouver le callout collapse, le déplier. Ce chemin n'est pas rendu visible depuis la boussole. Solutions possibles : ajouter une indication "(dans la page Exercice 1)" explicite, ou sur la page exo rapprocher visuellement l'escalier du collapse (ils sont déjà l'un sous l'autre, mais le participant doit savoir où naviguer). Sans cette clarification, la marche 2 échoue silencieusement.

---

## Important — à corriger avant le 16 juin

### I1 — "À vous !" sur le site utilise callout-tip au lieu de callout-warning

`1-quarto-typst/index.qmd:44` — le bloc "À vous !" principal est `callout-tip` (vert). La convention du projet (CLAUDE.md) dit "Your turn = callout-warning (jaune)". Certes la convention concerne les slides, pas la page web, mais utiliser le même callout-warning sur la page renforcerait la cohérence chromatique vue/slide. Les participants ont déjà la marque jaune dans leur rétine depuis le slide. Le vert crée une dissonance. Décision à trancher : soit on aligne page web et slide sur warning/jaune, soit on documente que la page web utilise délibérément tip/vert. L'ambigu actuel peut perturber.

### I2 — L'escalier autonomie sur le site (callout-tip appearance="minimal") est visuellement faible

`1-quarto-typst/index.qmd:73-79` — le bloc escalier est un `callout-tip appearance="minimal"`, ce qui supprime la bande colorée et l'icône. Il se fond dans la page. À 50/1, si un participant cherche frénétiquement "si je bloque", ce callout minimal risque d'être ignoré. Un `callout-caution` ou simplement supprimer `appearance="minimal"` pour garder l'icône tip (ampoule) rendrait ce bloc plus détectable visuellement en situation de stress.

### I3 — L'étape 5 est optionnelle en pratique mais pas signalée comme telle

`1-quarto-typst/index.qmd:59` — l'étape 5 (`keep-typ: true`) n'est pas présentée comme bonus, mais elle n'est pas indispensable pour "produire un PDF stylé". En 12 minutes, les participants qui peinent aux étapes 3-4 n'arriveront pas à l'étape 5. Le tableau 5 étapes "attendues de tous" peut créer une pression injustifiée. Le design dit bonus = lignes tableau frère — ici l'étape 5 pourrait passer en ligne bonus ou a minima être marquée "(optionnel)" dans la cellule Action.

### I4 — Faux positif (URL étape 4 identique entre site et mapping)

Note du reviewer signale une divergence URL plan vs site, mais à inspection le site et le mapping pointent sur la même URL `https://posit-dev.github.io/brand-yml/brand/typography.html`. Le plan d'impl initial proposait `/reference/typography/` mais a été patché en Task 1.1 après smoke URL check (404). Faux positif — pas d'action.

### I5 — Le starter README ne mentionne pas l'absence de `_brand.yml`

`exercises/01-document-typst/starter/README.md:1-28` — le quick-ref liste les fichiers présents, mais ne prévient pas que `_brand.yml` n'existe pas encore dans le dossier starter (le participant le crée aux étapes 3-4). Un débutant qui clone et browse le repo peut s'attendre à trouver `_brand.yml` ou être dérouté par son absence. Une ligne "(`_brand.yml` à créer aux étapes 3-4)" dans le tableau Contenu du dossier évite ce faux mystère.

---

## Nice-to-have

### N1 — La boussole n'a pas de lien direct vers la correction (marche 3)

`1-quarto-typst/boussole.qmd:31` — marche 3 de l'escalier : "Ouvrir `exercises/01-document-typst/correction/`". C'est un path filesystem, pas un lien cliquable. Un participant en mode panique va copier ce texte dans son explorateur de fichiers. Sur la boussole, ajouter un lien GitHub vers la correction (déjà présent dans `index.qmd:88`) permettrait un clic direct. Risque bas si wifi OK.

### N2 — "~5 min sur une étape" vs timer de la boussole de 12 min

`1-quarto-typst/index.qmd:74` — le seuil "~5 min" de l'escalier est réaliste mais non visible depuis la boussole. Faible priorité.

### N3 — Pas de lien vers la boussole depuis la page exo

Pour l'usage live, hors scope (le participant suit la séance). Utile post-workshop comme doc.

### N4 — Emoji titre boussole rendu projecteur incertain

`1-quarto-typst/boussole.qmd:2` — emoji 🧭 dans le YAML `title`. Risque faible mais réel si rendering partiel.

---

## Forces pédagogiques confirmées

- **Contrat des 4 surfaces tient.** Aucune surface ne re-narre la pédagogie d'une autre.
- **Tableau 3 colonnes bien calibré.** Cellules "Vous devriez voir" concrètes et vérifiables sans animateur.
- **Indices doc bien dosés.** Max 2 docs par étape respecté. Ancres précises ("section Format Options", "chercher keep-typ").
- **Notes presenter de qualité exceptionnelle.** 4 problèmes fréquents listés correspondent aux frictions réelles. "Cue rapide pour les finissants" = cadeau pour animation 50/1.
- **Pas de countdown dans le slide.** Double-timer désynchronisé évité.
- **Collapse indices replié par défaut.** Charge cognitive différée correctement.
- **Escalier marche 3 lisible offline depuis repo cloné.**

---

## Conclusion go/no-go pour extension à Exo 2

**Conditionnel go.** Les deux points bloquants (B1, B2) peuvent être patchés en 15-30 min avant d'étendre. Ils ne remettent pas en cause le gabarit — uniquement le wording de deux lignes. Une fois patchés, le gabarit est validé et l'extension peut commencer sans risque de propager un design défectueux.

L'item I3 (étape 5 "attendue de tous") mérite une décision avant l'extension aussi : si on la classe en bonus pour Exo 1, il faut décider si le même principe s'applique aux étapes "inspection" d'Exo 2.

Les items I1, I2, I5 sont des améliorations de confort qui ne bloquent pas l'extension mais qui seront plus simples à aligner sur les deux exercices en même temps.
