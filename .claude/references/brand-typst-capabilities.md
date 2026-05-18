# brand.yml × Typst — ce qui est possible (et ce qui ne l'est pas)

> Synthèse construite après audit `quarto-dev/quarto-cli` HEAD + deepwiki, déclenchée par le problème de contraste TOC sur Exo 2 (jaune SW `#FFE81F` sur fond crème — illisible).
> Vérifié sur sources locales `~/Documents/DEV_R/quarto-cli`.

## TL;DR

- Quarto émet **toutes** les couleurs sémantiques + palette dans le dict Typst `brand-color` — disponible à n'importe quel template / extension.
- Quarto applique **automatiquement** seulement : `background` → page fill, `foreground` → text fill, `primary` → couleur de liens. **Rien d'autre.**
- L'usage massif de `primary` (titres, TOC, accents) dans `orange-book` est **un choix de l'extension**, pas une obligation Quarto.
- Il **n'y a pas** de mécanisme officiel pour dire « pour ce format, override telle couleur brand » au niveau YAML document (genre `format.typst.brand.color.primary: xxx`).
- Workaround propre disponible : `include-in-header` qui redéfinit `brand-color` ou des show rules après l'injection Quarto.

## 1. Schéma brand.yml — couleurs supportées

Source : `src/resources/schema/definitions.yml` (clé `brand-color-single`).

**Couleurs sémantiques :**

| Clé | Auto-appliquée par Quarto en Typst |
|---|---|
| `foreground` | `#set text(fill: ...)` + `#set table.hline` + `#set line` |
| `background` | `#set page(fill: ...)` |
| `primary` | `#show link: set text(fill: ...)` (uniquement les liens) |
| `secondary` | rien |
| `tertiary` | rien |
| `success` | rien |
| `info` | rien |
| `warning` | rien |
| `danger` | rien |
| `light` | rien |
| `dark` | rien |
| `link` | `#show link: set text(fill: ...)` (override `primary` pour les liens) |

**Plus :** `palette.*` — clés arbitraires (ex. `sw-yellow`, `sw-black`).

**Toutes** ces clés (sémantiques + palette) sont émises dans `brand-color` (cf. `typst-brand-yaml.lua:70-73` qui itère dynamiquement `processedData.color`).

## 2. Structure générée côté Typst

À chaque render Typst, Quarto injecte en `in-header` :

```typst
#let brand-color = (
  primary: rgb("#FFE81F"),
  foreground: rgb("#0B0B0F"),
  background: rgb("#F5F0E1"),
  sw-yellow: rgb("#FFE81F"),
  sw-black:  rgb("#0B0B0F"),
  sw-cream:  rgb("#F5F0E1"),
  // … toutes les clés présentes
)

#let brand-color-background = (
  // version teintée 15/85 (ou 50/50 en dark mode) avec background
  primary: color.mix((brand-color.primary, 15%), (brand-color.background, 85%)),
  // …
)
```

Plus les `#set` auto si les clés sont présentes :

```typst
#set page(fill: brand-color.background)
#set text(fill: brand-color.foreground)
#set table.hline(stroke: (paint: brand-color.foreground))
#set line(stroke: (paint: brand-color.foreground))
#show link: set text(fill: brand-color.primary)
```

## 3. Typographie brand → Typst

Passée via variables pandoc template, **pas** via `brand-color` :

- `brand.typography.base.family` → `font:`
- `brand.typography.base.size` → `fontsize:`
- `brand.typography.headings.family` → `heading-family:`
- `brand.typography.headings.weight` → `heading-weight:`
- `brand.typography.headings.color` → `heading-color:`
- `brand.typography.monospace.family` → `codefont:`

Consommées par `article()` de `typst-template.typ`. Une extension qui définit son propre `typst-show.typ` (comme orange-book) peut les ignorer.

## 4. Comment orange-book consomme brand-color

`_extensions/orange-book/typst-show.typ:19` :

```typst
main-color: brand-color.at("primary", default: blue),
```

C'est l'unique paramètre couleur passé à `book(...)`. Et `book(...)` (dans `lib.typ`) l'utilise pour :

- **Couverture** : `cover-fill-color = main-color.lighten(70%)` (jaune pâle OK)
- **TOC** entries level 1 : `textColor: main-color` (`my-outline.typ:49, 58, 68`) — texte jaune pur ❌
- **Titres chapitre** (level 1/2/3) : `fill: main-color`
- **Liens, citations** : `fill: main-color`
- **Encadrés théorème/exercice** : stroke + titres en `main-color`

→ orange-book conflate « accent visuel » et « couleur de texte » en un seul slot.

## 5. Ce qu'on PEUT faire aujourd'hui

### 5a. Changer `primary` pour une couleur lisible

Le plus simple. On accepte une couleur foncée (noir, navy, ocre foncé) comme `primary`. Couverture devient sobre (lighten 70%).

```yaml
color:
  palette:
    sw-yellow: "#FFE81F"
    sw-black:  "#0B0B0F"
  primary: sw-black
  foreground: sw-black
  background: sw-cream
```

### 5b. ❌ `include-in-header` ne marche PAS

**Testé expérimentalement le 2026-05-12 (Exo 2 correction).** `format.typst.include-in-header: brand-override.typ` est injecté **AVANT** la déclaration `brand-color` du filtre Lua, pas après. Repro : `error: unknown variable: brand-color` à la ligne du `#let brand-color = (..brand-color, …)`.

Ordre constaté dans le `.typ` généré (`exercises/02-projet-book/correction/index.typ`) :
```
line 418-421 : contenu de include-in-header (TROP TÔT)
line 422-429 : #let brand-color = (...) ← injecté par Lua filter ICI
line 438-441 : #set page(fill: ...), #set text, ...
... plus tard ...
typst-show.typ : #show: book.with(main-color: brand-color.at("primary", ...))
```

`include-in-header` reste utile pour injecter des **imports** ou définitions qui ne dépendent pas de `brand-color`, mais ne permet pas d'override de brand-color avant orange-book.

### 5c. ✅ Patcher notre copie de `_extensions/orange-book/typst-show.typ`

Le **seul** chemin d'override fiable sans toucher Quarto core. On a déjà une copie locale (pour marginalia). On peut :

```typst
// _extensions/orange-book/typst-show.typ — ligne 19 actuelle :
//   main-color: brand-color.at("primary", default: blue),
// Remplacée par :
  main-color: brand-color.at("dark", default: black),
  cover-background: brand-color.at("primary", default: blue),
```

Et déclarer dans `_brand.yml` :
```yaml
color:
  palette:
    sw-yellow: "#FFE81F"
    sw-black:  "#0B0B0F"
    sw-cream:  "#F5F0E1"
  primary:    sw-yellow   # devient la couleur de la couverture
  dark:       sw-black    # devient la couleur des textes/TOC/titres
  foreground: sw-black
  background: sw-cream
```

Résultat : cover jaune (`primary`), texte/TOC/titres noirs (`dark`). orange-book accepte `cover-background:` explicite (cf. `lib.typ:311, 573-578`).

Côté pédagogique : on touche au template — donc à montrer hors workshop, ou comme pépite « comment patcher une extension ».

### 5d. Lua filter custom qui injecte APRÈS `typst-brand-yaml.lua`

Une extension peut shipper un filtre Lua qui appelle `quarto.doc.include_text('in-header', '#let brand-color = (..brand-color, primary: rgb("#XXX"))')`. L'ordering est : filtres extension après filtres built-in, donc l'injection vient APRÈS la déclaration brand-color. Fonctionnel mais lourd pour un cas d'usage simple.

### 5e. Fork orange-book upstream → expose `text-color`

Vrai fix mais hors scope du tuto. Subtree dans quarto-cli — fix via PR `quarto-dev/quarto-cli`. Voir issue draft `.claude/issues/quarto-cli-orange-book-text-color.md`.

## 6. Ce qu'on NE peut PAS faire (gaps)

1. **Pas d'override de couleur brand au niveau format** (`format.typst.brand.color.primary: "#XXX"` → non supporté).
2. **Pas de moyen de dire à orange-book** d'utiliser une couleur différente pour texte vs accent — l'extension n'expose qu'un seul `main-color`.
3. **Pas d'awareness contraste** : `primary` jaune sur `background` crème → aucun warning Quarto/Typst.
4. **Pas de mapping configurable** « cette clé brand → ce paramètre de l'extension » (ex. forcer `secondary` pour `main-color`).

## 7. Recommandations pour Exo 2

**Court terme (workshop 16 juin) :**
- Choisir un nouveau `primary` lisible (Chris cherche une palette SW). Option pragmatique : `#B8860B` (darkgoldenrod, jaune SW ombré) ou `#7C5E10` (ocre profond), garde l'esprit SW + contraste OK sur crème.
- `sw-yellow` reste dans `palette` pour usage explicite si besoin (logo, accent ponctuel).

**Issues à filer côté `quarto-dev/quarto-cli` :**

1. **orange-book : exposer `text-color` distinct de `main-color`** (subtree dans `quarto-cli`, fix local). Draft : `.claude/issues/quarto-cli-orange-book-text-color.md`.
2. **(Optionnel)** Feature request Quarto : override de couleurs brand au niveau format. Moins prioritaire — workaround existe via `palette` + extension qui lit la bonne clé.

**Issues existantes pertinentes :**
- [#14092](https://github.com/quarto-dev/quarto-cli/issues/14092) — Callout colours inconsistent HTML vs Typst with brand.yml (catégorie similaire : brand mal mappé en Typst).
- [#11500](https://github.com/quarto-dev/quarto-cli/issues/11500) — line/border color HTML branding.

Aucune issue existante ne couvre **« orange-book ou Typst extension réutilise primary comme couleur de texte sur background, causant des contrastes inacceptables »** → angle neuf et concret à filer.

## Sources

- `src/resources/filters/quarto-post/typst-brand-yaml.lua` (émission brand-color)
- `src/resources/filters/modules/brand/brand.lua` (résolution couleur → rgb())
- `src/resources/schema/definitions.yml` (`brand-color-single`)
- `src/resources/formats/typst/pandoc/quarto/template.typ` (ordre injection)
- `src/resources/formats/typst/pandoc/quarto/typst-show.typ` (typographie brand)
- `src/resources/extension-subtrees/orange-book/_extensions/orange-book/typst-show.typ` (consommation `primary`)
- `src/resources/extension-subtrees/orange-book/typst/packages/preview/orange-book/0.7.1/lib.typ` (usage `main-color`)
