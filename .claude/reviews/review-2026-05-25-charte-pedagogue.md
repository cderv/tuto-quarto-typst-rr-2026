# Review pédagogique — Charte Star Wars + refonte Your Turn

**Date :** 2026-05-25
**Commit base :** `d024d6c` (branche `claude/tutorial-review-charter-9H98W`)
**Review précédente :** `.claude/reviews/review-2026-05-19-gt-brand-color-pedagogue.md`

## Verdict général

La charte Star Wars est une **excellente trouvaille pédagogique** : elle transforme « inventez une charte » en « transcrivez cette charte », ce qui élimine la divergence des rendus et recentre la charge cognitive sur le bon objet (le YAML, pas le design). Le PDF imprimable est lisible, méta-cohérent (lui-même rendu via `_brand.yml`) et joue son rôle de spec professionnelle. Le gabarit Your Turn 3-cols + boussole projetée + countdown migré améliore franchement l'autonomie : un apprenant bloqué dispose de 3 filets bien hiérarchisés (objectif/voir → indices doc → correction). Restent quelques frictions concrètes — pas bloquantes pour le 16 juin — qui touchent la cohérence des listes d'étapes entre slides/page-exo/boussole, et la **visibilité scénique** de la charte (jamais projetée explicitement avant l'exo).

---

## 🔴 P0 — bloquant pour le 16 juin

Aucun.

---

## 🟠 P1 — à corriger avant le 16 juin

### P1-1. Désynchro nombre d'étapes Exo 1 : page-exo (4) vs boussole (5) vs slide Our turn (6)

- `1-quarto-typst/index.qmd:53` annonce **« 4 étapes principales (12 min) — attendues de tous »** + B1 bonus (`keep-typ`).
- `1-quarto-typst/boussole.qmd:21-25` liste **5 étapes** sans distinction core/bonus — l'étape 5 est `keep-typ`, qui sur la page-exo est explicitement marquée Bonus.
- `1-quarto-typst/1-quarto-typst.qmd:206-211` liste **6 étapes** pour le Our turn (cumule core + options + keep-typ).

Risque : l'apprenant qui regarde la boussole projetée pendant le compte à rebours croit qu'il a 5 choses à faire en 12 min alors qu'il en a 4 + 1 bonus. Stress + contradiction avec la page de référence. **Fix** : aligner la boussole sur la structure 4-core + B1 (séparateur visuel ou pastille « Bonus » pour l'item `keep-typ`).

### P1-2. La charte n'est jamais projetée dans les slides — alors qu'elle est l'artefact central de l'Exo 1

Cherché — aucune slide n'inclut visuellement la charte (`![…](charte-starwars.pdf|png)` absent) et aucune note presenter n'instruit « projetez la charte au tableau ».

- La slide `_brand.yml` (`1-quarto-typst/1-quarto-typst.qmd:156-198`) montre un exemple **générique** (`#1a5276` / `#f39c12` / Noto Sans), sans rapport visuel avec la charte SW que l'apprenant va transcrire.
- Le Our turn (`1-quarto-typst/1-quarto-typst.qmd:209` étape 4) dit « suivez la charte Star Wars (`charte-starwars.pdf` du starter) » — sans demander d'ouvrir/projeter le PDF.
- Le Your turn (`1-quarto-typst/1-quarto-typst.qmd:222-234`) la mentionne dans le callout, pas dans les notes presenter.

Risque : pendant la démo Our turn, CD code un `_brand.yml` que les apprenants doivent suivre — mais ils n'ont aucune image partagée à l'écran de la cible. Le PDF est dans leur starter, mais alterner IDE / lecteur PDF = friction. **Fix** : note presenter ajoutée sur la slide Our turn (`1-quarto-typst/1-quarto-typst.qmd:214-220`) : *« Ouvrir `charte-starwars.pdf` côté projecteur avant d'écrire le YAML — l'apprenant voit la cible et la transcription en parallèle. »* Optionnel mais fort : slide « Voici la charte » (PNG du PDF) intercalée entre la slide `_brand.yml` (ligne 156) et le Our turn (ligne 201).

### P1-3. Discrepance de durée annoncée dans le README parent

- `exercises/01-document-typst/README.md:3` : **« Durée : 15 minutes »**
- Partout ailleurs (slide, boussole, page-exo) : **12 minutes**

L'apprenant qui zappe le site et lit directement le README sur GitHub a une attente différente. **Fix** : harmoniser à 12 min (ou expliciter « 12 min en séance + 3 min bonus = 15 min »).

### P1-4. Notes co-animation toujours quasi-absentes (gap pré-existant, mais aggravé par l'addition de la charte)

Sur les 2 slides (491 lignes cumulées), **une seule mention explicite** de qui parle : `2-projets/2-projets.qmd:144` « **CD parle.** » sur le wrap-up. Tout le reste suppose que CD pilote en solo. Avec l'addition de la charte (nouvel artefact à projeter, à commenter), Maëlle a un rôle naturel : par ex. « MS projette et commente la charte pendant que CD code le YAML ». **Fix** : 3-4 indications « CD/MS » bien placées dans les notes presenter — au minimum : démo `_brand.yml` Bloc 1, démo book Bloc 2, transition Exo 1 → pause, ouverture pépite Bloc 2.

---

## 🟡 P2 — nice-to-have

### P2-1. Renforcer la promesse de « méta-exemple » de la charte

`_charte/README.md:30-31` explique très bien la magie (« le logo est placé automatiquement par Quarto via `logo.medium` — l'apprenant voit dès la lecture de la charte ce que produit la déclaration logo »). Côté apprenant, le pied de la charte (`_charte/charte-starwars.qmd:115`) le mentionne déjà discrètement. Pour transformer ça en « aha moment », ajouter dans la note presenter de la slide `_brand.yml` (`1-quarto-typst/1-quarto-typst.qmd:191-198`) : *« Ouvrir la charte, montrer le logo en haut-gauche, dire : "ce PDF que vous tenez est lui-même un rendu Typst+brand.yml — vous allez en faire un cousin." »*

### P2-2. Statut de `keep-typ: true` à clarifier (Bloc 1)

Aujourd'hui : étape 5 boussole (core), bonus B1 page-exo, étape 6 démo Our turn. Trois statuts différents. Décider : soit « passage obligé démontré + à refaire en autonomie » (alors aligner la page-exo en step 5 core), soit bonus (alors isoler visuellement dans la boussole).

### P2-3. La boussole Exo 1 ne mentionne pas la charte

`1-quarto-typst/boussole.qmd:15-25` rappelle l'objectif mais l'apprenant qui consulte la boussole pendant 12 min n'a aucun mot-clé « charte ». Ajouter une ligne sous le 🎯 : « 📄 Charte fournie : `charte-starwars.pdf` dans le starter » (mirror de `1-quarto-typst/1-quarto-typst.qmd:229`). 3 mots.

### P2-4. Asymétrie Exo 1 / Exo 2 sur le rôle de la charte — à expliciter

Exo 1 : la charte est **la source à transcrire**. Exo 2 : la charte devient **un fallback visuel** si pas de `_brand.yml` du Bloc 1. Asymétrie pédagogiquement correcte mais pas explicitée. L'étape 3 d'Exo 2 (`2-projets/index.qmd:58`) propose trois options confuses (réutiliser brand Bloc 1, copier `_brand-fallback.yml`, retranscrire). Reformuler en 2 temps : (a) « si vous avez fini Bloc 1, copiez votre `_brand.yml` » (b) « sinon : `_brand-fallback.yml` à renommer ». La charte PDF reste référence visuelle, pas 3e option opérationnelle.

### P2-5. Le PDF charte ne mentionne pas son propre rôle pédagogique

Pied du PDF (`_charte/charte-starwars.qmd:115`) : « À vous de jouer : transcrivez cette charte en YAML, puis rendez votre rapport. » Mais aucune indication qu'il sert aussi en Exo 2. À 15 min du début, un apprenant qui rouvre la charte au Bloc 2 ne sait pas si c'est la même ou une autre. Mention « Utilisée en Bloc 1 et Bloc 2 » rendrait l'artefact lisible bout-à-bout.

### P2-6. Placement du bullet `brand_color_pluck` dans la pépite Bloc 1

`1-quarto-typst/1-quarto-typst.qmd:253` ajoute bien le bullet « Une charte, partout » avec `brand_color_pluck(brand, "ma_couleur")` — action #1 de la review précédente bien intégrée. Mais il est en 3e position d'une liste de 4. Si la pépite tourne en « 3 min max » et qu'on coupe par le bas, ce bullet (probablement le plus inspirant pour clore l'exo 1) a peu de chances d'être verbalisé. Le placer en position 1 ou 2 renforcerait la mémoire.

---

## ✅ Forces pédagogiques confirmées

### Le PDF charte est un vrai pas en avant

- **Format pro lisible** (vérifié par lecture du PDF) : palette/typographie/logo en 3 sections nommées avec hex + alt + filename. Style sobre, rouge impérial + cream — métier-crédible.
- **Méta-cohérence** : `_charte/_brand.yml` ≡ `exercises/01-document-typst/correction/_brand.yml` (byte-identique). Le logo et Star Jedi visibles sur le PDF *sont* le résultat des déclarations que l'apprenant va écrire — démonstration sans mots.
- **Charge cognitive recentrée** : palette nommée + assignments explicites (`primary: imperial-red`, `foreground: sw-black`, `background: sw-cream`) → plus de décision design, juste de la transcription.
- **Pépite implicite intelligente** : la note sous la palette (« `sw-yellow` reste utile pour accents mais pas en `primary` — contraste trop faible sur fond crème ») enseigne l'accessibilité sans le dire.

### Le gabarit Your Turn unifié fonctionne

- **3 niveaux de filet** clairement hiérarchisés (`1-quarto-typst/index.qmd:79-85` et `2-projets/index.qmd:87-93`) : objectif/voir → indices doc → correction. Boucle de feedback autonomie réelle.
- **Boussole projetée + countdown auto-start** vérifié : `start_immediately=true` — pas de bouton à cliquer côté formateur.
- **Quick-ref starter README** inclus dans la page-exo via `{{< include >}}` (`1-quarto-typst/index.qmd:89`, `2-projets/index.qmd:97`) — single source of truth GitHub ↔ site.
- **Indices doc en collapse** (`1-quarto-typst/index.qmd:69-77`) : invisible par défaut, chaque indice = section précise dans la doc Quarto. Vrai scaffolding.

### Cohérence des boussoles

Structure identique (🎯 / 📋 / 🆘 / 📖) + countdown 12:00. L'apprenant qui voit la boussole Exo 1 sait lire la boussole Exo 2. Bémol P1-1 sur la liste d'étapes Exo 1.

### L'arc `.qmd → PDF pro → livre → personnalisé/pérennisé` tient bout-à-bout

- `.qmd → PDF` : `1-quarto-typst/1-quarto-typst.qmd:83` (`format: typst`) + Exo 1 étape 1.
- PDF pro : `1-quarto-typst/1-quarto-typst.qmd:156` (`_brand.yml`) + charte fournie + Exo 1 étapes 3-4.
- Livre : `2-projets/2-projets.qmd:32` (`type: book`) + Exo 2.
- Personnalisé/pérennisé : pépites Bloc 2 + page 3-aller-plus-loin + ressources.
- **Wrap-up explicite** (`2-projets/2-projets.qmd:133-141`) — 5 capacités qui font écho aux 3 questions de l'accueil (`index.qmd:17-19`). Boucle bouclée.

### `_charte/` correctement exclu du site

Vérifié par `quarto render` : 10 fichiers rendus, `_charte/charte-starwars.qmd` non rendu (convention underscore Quarto). Pas de page orpheline.

---

## 📝 Évolution depuis la review précédente (2026-05-19)

### Recommandations précédentes — état

| Action | État |
|---|---|
| **#1 (prioritaire)** Ajouter `brand_color_pluck` à la pépite Bloc 1 | ✅ Fait — `1-quarto-typst/1-quarto-typst.qmd:253` bullet « Une charte, partout » avec exemple. Léger P2-6 sur le placement. |
| **#2 (secondaire)** Mettre à jour `4-ressources.qmd` | ✅ Fait — `4-ressources.qmd:74` mentionne `brand_color_pluck()` + note sur la normalisation `tiret-séparé` → `tiret_souligné`. |
| **#3 (optionnel)** Cue dans note presenter Your turn Exo 1 | ✅ Fait — `1-quarto-typst/1-quarto-typst.qmd:243` ajoute le cue explicite vers les `tab_style()`. |

Les 3 actions sont implémentées. L'easter egg `brand_color_pluck` n'en est plus un.

### Ce qui s'est nettement amélioré

1. **L'objet pédagogique de l'Exo 1 est devenu concret et reproductible.** Avant : « choisissez un primary/secondary ». Après : « voici la charte, transcrivez ». Changement structurel positif majeur.
2. **Le scaffolding Your Turn est nettement plus solide.** Gabarit 3-cols + boussole projetée + quick-ref inclus = 3 lignes de vie indépendantes. Autonomie réelle, pas formelle.
3. **L'arc narratif est plus visible.** Wrap-up « Ce que vous savez faire » + « Et maintenant ? » + accueil font écho aux questions initiales.
4. **Pépite Bloc 1 répare l'easter-egg `brand_color_pluck`** — exposé à tous, plus seulement à ceux qui ouvrent la correction.

### Ce qui était déjà bon et reste bon

- Cycle My/Our/Your respecté dans les deux blocs.
- Quatre pépites « Saviez-vous que… » bien dosées (~2-3 min, marquées comme fusibles).
- Page Préparatifs solide avec Plan B offline.
- Notes presenter détaillées pour anticiper les erreurs courantes (espacement chiffres gt, Star Jedi, underscore manquant).

### Ce qui aurait pu se dégrader — et n'a pas

- **Risque charge cognitive avec la charte** : non confirmé. La charte *réduit* la charge en supprimant la décision de design. Seul surcoût : lecture (~30 s) du PDF avant l'exo, gérable.
- **Risque dispersion avec 3 artefacts à manipuler** (slide démo + boussole + IDE) : géré par séparation des rôles (slide = concepts, boussole = checklist, IDE = action). Pas de saturation visuelle.
- **Risque sur cohérence Exo 1 ↔ Exo 2** : OK structurellement (mêmes gabarits, mêmes filets). Seul P2-4 (asymétrie du rôle charte) à clarifier verbalement.

### Nouveaux risques apparus avec la refonte

- **P1-1** (désynchro 4/5/6 étapes Exo 1) — induit par la refonte (avant : une source ; maintenant : trois supports doivent rester en sync).
- **P1-2** (charte jamais projetée) — induit par l'addition de la charte (artefact externe nouveau, sans note d'orchestration scénique).
- **P1-3** (durée 15 vs 12 min) — induit par la refonte des étapes (probablement un oubli en passant de 15 → 12 dans le README parent).

Tous trois sont P1, faciles à corriger en quelques minutes d'édition. Aucun n'est bloquant.
