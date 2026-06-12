# Review technique — Plan « Démo Our turn Exo 1 : couleurs » (2026-06-12)

> Reviewer : quarto-technique. Cible : Quarto 1.9+ (plancher projet), vérif empirique sur **Quarto 1.10.11** (sandbox). Aucune source modifiée.
> (Rédigée par l'agent technique, reportée sur disque par l'orchestrateur — l'agent n'avait pas le droit Write.)

Vérifs faites : lecture du template Typst de Quarto (`typst-template.typ`, `typst-show.typ`), inspection du mapping brand, **deux rendus empiriques** d'un doc minimal avec `_brand.yml` (inspection du `.typ` généré), changelog Quarto 1.7→1.9, et `diff` source/`pkg-inst`.

## Verdict général

Le diagnostic technique du plan est **exact et bien étayé**. Le mapping `_brand.yml`→Typst décrit au §2 est confirmé empiriquement, ligne par ligne, par le `.typ` généré. La syntaxe proposée (Q1/Q3) est correcte et **robuste sur le plancher annoncé (1.9+)**. La synchro `pkg/inst/` (Q3) est obligatoire si on touche au starter ou à la correction, avec garde-fou CI. Aucun P0. Deux P1 (wording faux dans deck + page), deux P2.

## Q1/Q3 — Syntaxe `_brand.yml` correcte et robuste sur ≥ 1.9 ? **Oui.**

**Rendu 1 — `background`+`foreground`+`primary`** (`.typ` généré, fidèle) :
```typst
#set page(fill: brand-color.background)         // background
#set text(fill: brand-color.foreground)         // foreground : TOUT le texte
#show link: set text(fill: rgb("#bc1e22"), )    // primary : liens SEULEMENT
article( title: [Test], heading-color: rgb("#0b0b0f"), ... )  // titres = foreground, PAS primary
```

**Rendu 2 — `typography.headings.color: imperial-red`** :
```typst
#show heading: set text(fill: rgb("#bc1e22"), )   // AJOUTÉ : colore les titres de CORPS
article( ..., heading-color: rgb("#bc1e22"), ... ) // + bloc-titre
```
`headings.color` **fonctionne** (titres de corps + bloc-titre). Pas de bug. Détail mécanique : sans `headings.color`, **aucune** règle `#show heading` n'est émise → titres de corps héritent de `foreground`. Le `heading-color` passé à `article()` n'agit que sur le **bloc-titre** (`typst-template.typ`, `#set text(fill: heading-color) if heading-color != black`, dans `if title != none`). D'où « titres de corps noirs en Bloc 1 » tant qu'on ne pose pas `headings.color`.

**Nuance de version (sans risque ici).** `primary`→lien repose sur `#show link: set text(fill:)` du template ; le changelog **1.9** introduit `linkcolor`/`citecolor`/`filecolor` et réaligne le template. Sur 1.9+ tout est garanti ; pré-1.9 (hors périmètre) pourrait différer — à ne pas promettre. Le projet ancre déjà 1.9+. Aucune mention sub-1.9 dans deck/page/boussole.

## Q3 — Synchroniser correction + `pkg/inst/` si ajout de liens : **obligatoire**

`diff` starter source ↔ `pkg/inst/.../starter/rapport-starwars.qmd` → **IDENTIQUE** aujourd'hui. Fichiers à régénérer via `just pkg-sync` :
- starter modifié → `pkg/inst/exercices/01-document-typst/starter/rapport-starwars.qmd`
- correction modifiée → `pkg/inst/exercices/01-document-typst/correction/rapport-starwars.qmd`

`correction/_brand.yml` n'a **pas** besoin de changer (`primary: imperial-red` déjà présent). Seules les **sources `.qmd`** changent. **Garde-fou** : `just pkg-sync-check` (= CI `pkg-inst-sync.yml`) casse si on oublie → modifier dans `exercises/`, puis `just pkg-sync`, committer les deux arbres ensemble.

**Reco** : pour rendre vraie l'étape 3 « Liens colorés en imperial-red » (`index.qmd:62`), ajouter ≥1 lien en prose **dans la correction** (intro ou conclusion). Sinon retirer la promesse.

## 🟠 P1 — Wording faux

- **P1-1 — Deck `1-quarto-typst.qmd:283`** : « une seule couleur + `primary` → titres et liens colorés » + snippets `:285-290` ET doublon notes `:303-308`. Doublement faux (primary ≠ titres ; starter sans lien → inchangé). Appliquer §4, **mettre à jour les DEUX snippets** pour rester synchrones.
- **P1-2 — Page `index.qmd:62`** : « Liens colorés en imperial-red » inexact tant que pas de lien. (a) ajouter lien starter+correction (+`just pkg-sync`) ou (b) retirer. La parenthèse « la couleur `primary` sur les titres arrivera au Bloc 2 » est **techniquement trompeuse** : ce sera `typography.headings.color`, pas `primary`. Reformuler « les titres prendront une couleur d'accent au Bloc 2 ».

## 🟡 P2

- **P2-1 — Page `index.qmd:37`** : même faux wording, aligner sur §4.
- **P2-2 — Boussole `boussole.qmd:29-32`** : neutre, aucun claim faux. Si CD y mentionne `primary`, le formuler factuellement (« `primary` colore les liens »).

## ✅ Choix techniques validés

- `correction/_brand.yml` : syntaxe canonique correcte (palette + rôles, `typography.fonts` liste de dicts `source: file`/`google`, `base`/`headings`, `logo: images:`+`medium:`). `headings: "Star Jedi"` sans `headings.color` → titres en `foreground`, cohérent avec l'arc.
- `correction/rapport-starwars.qmd` YAML Typst : forme longue correcte, `lang: fr` racine, `logo:` sous `format.typst`, `keep-typ`.
- Mapping R↔Typst : `brand_color_pluck(brand, "primary")` et `brand-color.primary` tirent de la même palette. Rien de cassé.
- `primary` n'est **jamais** mappé sur `heading-color` par Quarto.

## Réponses synthétiques §6

1. Titres colorés possible et très visible via `typography.headings.color` (confirmé), mais casse l'arc — décision **pédagogique**, les deux marchent techniquement.
2. `primary` n'a d'effet visible **que** s'il existe un lien. Sans lien ajouté, ne pas l'introduire dans la démo (effet nul = confusion).
3. Synchro : voir Q3 + garde-fou CI.
4. « le document prend les couleurs de la charte (fond crème, texte sombre) » : **techniquement juste** pour `background`+`foreground`. Validé.
5. Levier le plus franc sans rien casser = `foreground` (déjà prévu) ; le « très visible » = `headings.color` (titres rouges), au prix de l'arc.
