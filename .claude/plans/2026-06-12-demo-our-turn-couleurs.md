# Plan — Démo Our turn Exo 1 : la couleur ne « prend » pas (retours Maëlle)

> Statut : **proposition à reviewer** (pédagogue, élève débutant, technique, ortho-FR).
> Origine : tests de Maëlle sur le site déployé, 2026-06-12. Diagnostic + repro par CD/Claude.

## 1. Le problème constaté

Maëlle, en testant l'Exo 1 : « j'ai créé le `_brand.yml`, supprimé le PDF et rendu. **Les liens ne sont pas rouges.** » Et elle confirme que son `.typ` contient bien `brand-color.primary = rgb("#BC1E22")`.

La démo **Our turn** (deck `1-quarto-typst/1-quarto-typst.qmd:283` + page `1-quarto-typst/index.qmd:37`) demande de créer un `_brand.yml` avec **une seule couleur + rôle `primary`**, et promet « → **titres et liens colorés** ». Cette promesse est **doublement fausse sur ce document** :

1. **`primary` ne colore PAS les titres** — il ne colore que les **liens** (et sert d'accent réutilisé par `brand_color_pluck`).
2. **Le starter (et la correction) n'ont AUCUN lien en prose** → `primary` n'a donc rien à colorer.

**Résultat : appliquer le `_brand.yml` minimal ne produit aucun changement visible.** La démo « édite le YAML → regarde le PDF changer » tombe à plat.

## 2. Vérifications techniques (sandbox, Quarto 1.10.11, paquet r-universe)

Repro faite avec rig→R 4.6.0, `tutoquartotypst` depuis r-universe, Quarto 1.10.11. Mapping `_brand.yml` → Typst confirmé empiriquement (rendus PNG à l'appui) :

| Rôle `_brand.yml` | Effet Typst généré | Visible sur le starter ? |
|---|---|---|
| `color.primary` | `#show link: set text(fill: …)` | **Non** (aucun lien dans le doc) |
| `color.foreground` | `#set text(fill: …)` sur **tout le texte** | Oui mais **tout** se colore (cf. capture « tout en rouge » si foreground = rouge) |
| `color.background` | `#set page(fill: …)` | Oui — fond crème (subtil mais réel) |
| `typography.headings.color` | `#show heading: set text(fill: …)` | **Oui — titres seuls colorés, corps inchangé** |

**Réponse à « comment colorer seulement les titres en Typst » (question deepwiki + vérif) :**
`typography.headings.color` est **supporté et fonctionne** (Quarto 1.10.11) — il colore titre + sections sans toucher au corps. **Pas de bug quarto-cli.** Confirmé par rendu : titres rouges, corps noir, sur un doc minimal.

```yaml
# colore UNIQUEMENT les titres
color:
  palette: { imperial-red: "#BC1E22" }
  foreground: "#0B0B0F"      # corps sombre
typography:
  headings:
    color: imperial-red       # titres rouges
```

## 3. La tension avec l'arc Bloc 1 → Bloc 2 (à arbitrer)

La page Exercice (`1-quarto-typst/index.qmd:62`, colonne « Vous devriez voir » de l'étape 3) pose un choix **délibéré** :

> « (Les titres restent en `foreground` noir — la couleur `primary` sur les titres arrivera avec le livre, au **Bloc 2**.) »

Donc : colorer les titres dès le Bloc 1 (via `headings.color`) **contredit cet arc**. Or `headings.color` est justement le levier le plus visible. → **décision à prendre** (cf. §6).

Note : cette même cellule de l'étape 3 promet « **Liens colorés en imperial-red** » alors qu'il n'y a aucun lien → inexact tant qu'on n'ajoute pas de lien au starter (cf. §4).

## 4. Changements décidés par CD

1. **Démo Our turn** = **option 1** : `background` (crème) + `foreground` (noir). Le doc prend un fond crème + texte sombre = avant-goût **visible** et **lisible** de la charte (≠ « tout en rouge », qui n'arrive que si `foreground` = rouge).
   - Remplacer le wording « → titres et liens colorés » par « → **le document prend les couleurs de la charte** (fond crème, texte sombre) ».
   - Toucher **deck** (`1-quarto-typst.qmd:283`, snippets `288-289` / `306-307`) **et** page (`index.qmd:37`).
2. **Ajouter des liens dans le starter** (`exercises/01-document-typst/starter/rapport-starwars.qmd`) — p. ex. lier `dplyr::starwars` (intro, l.21) vers <https://dplyr.tidyverse.org/reference/starwars.html>, éventuellement un lien en conclusion (l.76). Objectif : que `primary` ait un effet **visible** quand il est posé.
   - **Synchroniser** la correction si on veut que la cible montre des liens rouges (sinon l'étape 3 « liens colorés » reste fausse). À répercuter aussi dans `pkg/inst/` via `just pkg-sync`.
3. **Indiquer d'ajouter `primary`** pour colorer ces liens — **emplacement à décider** : dans la **boussole** (`1-quarto-typst/boussole.qmd`, étape 3) ou dans la démo **Our turn**. (CD : « à voir »).

## 5. Ne PAS faire

- **Ne pas remplacer l'exercice** : les 4 étapes (Your turn), la charte complète et la correction restent. La démo Our turn est un **avant-goût minimal**, pas l'exo.
- Garder la **différenciation** nette :

| | `_brand.yml` | Effet visible |
|---|---|---|
| **Starter** | aucun | PDF brut, fond blanc |
| **Démo Our turn** | `background` + `foreground` | fond crème + texte sombre |
| **Correction (post-exo)** | palette + `primary` + polices (Star Jedi/Inter) + logo + tableau colorisé | charte complète |
| **Boussole** | — | les 4 étapes + chrono |

## 6. Questions ouvertes pour les reviewers

1. **Titres colorés dans la démo ?** Sachant que `typography.headings.color` marche : faut-il l'utiliser pour rendre « titres colorés » littéralement vrai et **très visible** — au prix de casser l'arc « titres noirs en Bloc 1, colorés au Bloc 2 » ? Ou garder l'arc et s'en tenir à `background`+`foreground` ?
2. **Où poser `primary` + les liens** : boussole (étape) vs Our turn (démo) vs page Exercice ? Cohérence avec le « réflexe de base » (étape 1 seule d'abord).
3. **Faut-il synchroniser la correction** avec des liens, pour que la cible montre l'effet `primary` (et que l'étape 3 « liens colorés » devienne exacte) ?
4. **Wording** : « le document prend les couleurs de la charte » est-il assez précis / juste, côté débutant et côté FR ?
5. Le `background` crème est **subtil** (#F5F0E1 ≈ blanc cassé) — suffisamment visible en projection ? Sinon, quel levier (titres colorés ? un accent plus franc ?).

## 6 bis. Enrichir l'exercice avec les leviers `typography` (piste CD)

Matrice `typography` brand.yml → **Typst** (deepwiki + vérifié sandbox 1.10.11, rendus PNG) :

| Cible | Sous-propriétés honorées en Typst |
|---|---|
| `base` | `family`, `size`, `weight`, `line-height` |
| `headings` | `family`, `weight`, `style`, `color`, `line-height` |
| `monospace` | `family` (police de code) |
| `monospace-inline` | `weight`, `size`, `color`, `background-color` |
| `monospace-block` | `weight`, `size`, `color`, `background-color`, `line-height` |
| `link` | `weight`, `color`, `decoration` (underline), `background-color` |

L'exo n'exploite aujourd'hui que `base` (Inter) + `headings.family` (Star Jedi). Leviers **inexploités, visibles et sûrs** : `headings.color`, `link.decoration`, `monospace-inline.color`/`background-color`. Tous générés correctement (`#show heading: set text(...)`, `#show link: ... underline()`, `#show raw.where(block:false): ... highlight(...)`) et vérifiés visuellement.

**Question reviewers (Q6) :** jusqu'où enrichir ? Options non exclusives —
- (a) démo Our turn = un levier visible (`headings.color` *ou* `background`+`foreground`) ;
- (b) ajouter une étape/bonus « typographie de la charte » exploitant `link`/`monospace-inline` ;
- (c) ne rien ajouter à l'exo, juste documenter ces leviers en pépite / page Ressources.
Contrainte : rester dans l'enveloppe 12 min de l'exo + l'arc Bloc 1→Bloc 2 (titres colorés réservés au livre).

## 7. Fichiers concernés

- `1-quarto-typst/1-quarto-typst.qmd` (slide Our turn + notes orateur)
- `1-quarto-typst/index.qmd` (section Our turn + étape 3 « Vous devriez voir »)
- `1-quarto-typst/boussole.qmd` (étapes)
- `exercises/01-document-typst/starter/rapport-starwars.qmd` (ajout de liens)
- `exercises/01-document-typst/correction/rapport-starwars.qmd` (+ `pkg/inst/...` via `just pkg-sync`) si on synchronise les liens
