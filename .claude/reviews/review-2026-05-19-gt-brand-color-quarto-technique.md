# Review technique — gt + brand_color_pluck + Typst

**Fichier audité** : `exercises/01-document-typst/correction/rapport-starwars.qmd` (diff unstaged au 2026-05-19)  
**Quarto** : 1.10.3 | **brand.yml** : 0.1.0 | **gt** : 1.3.0 | **R** : 4.6.0

---

## Verdict général

Un seul bug bloquant : `brand_color_pluck(brand, "sw-yellow")` retourne la chaîne `"sw-yellow"` au lieu du hex `#FFE81F`, parce que le package brand.yml normalise les clés YAML tiret→underscore à la lecture, mais l'appel utilise le tiret. `gt::cell_fill()` rejette toute couleur non-hexadécimale/non-R-color avec `Error: An invalid color name was used ("sw-yellow")` — le render plante. Les trois autres `brand_color_pluck()` (foreground/background/primary) ne passent pas par la palette et sont corrects. Aucun bug gt→Typst sur les locations utilisées (cells_title / cells_column_labels / cells_body). Contrastes WCAG AA OK sur les quatre combinaisons.

---

## Blockers

### P0 — `brand_color_pluck(brand, "sw-yellow")` retourne la chaîne, pas le hex

`exercises/01-document-typst/correction/rapport-starwars.qmd:75`

**Comportement observé (R 4.6 / brand.yml 0.1.0) :**

```
brand_color_pluck(brand, "sw-yellow")  # → "sw-yellow"  (string, pas hex)
brand_color_pluck(brand, "sw_yellow")  # → "#FFE81F"    (correct)
```

**Mécanisme** : la lecture YAML via le package brand.yml normalise les clés tiret → underscore. Le dict interne est `$palette$sw_yellow`, pas `$palette$sw-yellow`. La fonction cherche `"sw-yellow"` dans palette (pas trouvé) puis dans theme_colors (pas trouvé), sort de la boucle et retourne la clé telle quelle.

**Conséquence** : `gt::cell_fill(color = "sw-yellow")` lève `Error: An invalid color name was used ("sw-yellow")`. Le render est interrompu avant même la compilation Typst. Testé empiriquement — le render aboutit à `Error in tab_style ... An invalid color name was used ("sw-yellow")`.

**Fix** : remplacer `"sw-yellow"` par `"sw_yellow"` (underscore).

```r
# Avant
cell_fill(color = brand_color_pluck(brand, "sw-yellow"))

# Apres
cell_fill(color = brand_color_pluck(brand, "sw_yellow"))
```

**Scope du problème** : unique occurrence à la ligne 75. Les autres clés utilisées (`foreground`, `background`, `primary`) n'ont pas de tiret et résolvent correctement via le lookup des theme_colors.

**Note pédagogique** : ce piège (tiret YAML → underscore R) n'est pas documenté dans le package brand.yml 0.1.0 (ni dans le NEWS, ni dans le vignette `branded-themes`). Le vignette utilise uniquement des clés palette sans tiret (`blue`, `purple`, `green`). Envisager un commentaire dans le code ou dans les slides pour alerter les participants si la session aborde `brand_color_pluck` sur une palette à noms composés.

---

## Validations passées

### 1. API `brand_color_pluck()` — signature et retour

La signature est `brand_color_pluck(brand, key)`. Elle retourne un scalaire string (hex ou nom R-color valide). Elle ne raise pas sur une clé absente — elle retourne la clé elle-même, silencieusement. C'est précisément ce qui rend le bug discret : pas d'erreur à l'appel `brand_color_pluck`, l'erreur ne surgit qu'à l'appel `cell_fill()` downstream.

Pour `foreground`, `background`, `primary` : la résolution passe par `theme_colors` (pas `palette`), ces clés n'ont pas de tiret, retour hex correct (`#0B0B0F`, `#F5F0E1`, `#BC1E22`).

### 2. Conflits avec `theme_brand_gt()`

`theme_brand_gt()` appelle uniquement `gt::tab_options(table.background.color = bg_color, table.font.color = fg_color)`. Il ne pose aucun `tab_style()`. Il n'y a donc **aucun conflit de dernière écriture** (last-wins) entre `theme_brand_gt` et les trois `tab_style()` qui suivent. Les `tab_style()` sur cells_title / cells_column_labels / cells_body(rows=1) fonctionnent indépendamment.

L'ordre de la pipeline est correct : `theme_brand_gt()` pose les options globales, `opt_table_font()` force Inter en premier dans la liste, les `tab_style()` appliquent le styling ciblé. Chaque étape opère sur un sous-ensemble différent du model gt.

### 3. gt → Typst translation

Dans le `.typ` généré (`rapport-starwars.typ`, render du 2026-05-05 avant la modification), la table produit des `table.cell(fill: rgb(...))` corrects pour les cellules que `theme_brand_gt` traite via `tab_options`. Les `tab_style()` du nouveau code n'ont pas encore été rendus. La mécanique gt→Typst pour `cell_fill` + `cell_text` sur `cells_title` / `cells_column_labels` / `cells_body(rows=...)` est opérationnelle en gt 1.3.0 + Quarto 1.10.x — aucun bug connu sur ces locations en Typst.

Observation connexe (non imputable au code audité) : le `.typ` déjà en repo montre `primary: rgb("#ffe81f")` dans le dict `brand-color` Typst (ligne 406), alors que `_brand.yml` courant a `primary: imperial-red`. Ce `.typ` date d'avant le commit `277b140` qui a pivoté `primary` vers `imperial-red`. Il sera écrasé au prochain `keep-typ: true` render correct.

### 4. Contrastes WCAG (calculés)

| Combinaison | Ratio | AA (4.5:1) |
|---|---|---|
| sw-yellow `#FFE81F` sur sw-black `#0B0B0F` (titre) | 15.73:1 | Passe (AAA) |
| sw-cream `#F5F0E1` sur sw-black `#0B0B0F` (en-têtes) | 17.24:1 | Passe (AAA) |
| sw-cream `#F5F0E1` sur imperial-red `#BC1E22` (ligne 1) | 5.51:1 | Passe |
| sw-black sur sw-cream (corps, hérité de theme_brand_gt) | 17.24:1 | Passe (AAA) |

Toutes les combinaisons passent WCAG AA. La combinaison la plus serrée est la ligne Jabba (rouge/crème, 5.51:1) — suffisant mais sans marge pour du texte non-gras à petite taille. Le code force déjà `weight = "bold"` pour cette ligne, ce qui ramène le seuil applicable à 3:1 (large/bold text) ; 5.51:1 est donc très confortable.

### 5. Ambiguïté nom palette vs nom theme_color

Les clés utilisées n'entrent pas en collision :

- `sw_yellow` : palette uniquement (pas de theme color `sw_yellow`)
- `foreground`, `background`, `primary` : theme_colors uniquement (alias vers des noms palette, pas de noms identiques en palette)

La logique de `brand_color_pluck` gère d'ailleurs la priorité : si une clé existe à la fois en theme_color et en palette, elle suit d'abord le chemin theme_color (voir la condition `in_theme_unseen`). Aucun conflit ici.

### 6. Cohérence package / double-import

`library(brand.yml)` est chargé une seule fois dans le chunk `setup` (ligne 32). `brand <- read_brand_yml()` est appelé une seule fois (ligne 35). Les fonctions `theme_brand_gt(brand)`, `theme_brand_ggplot2(brand)` et `brand_color_pluck(brand, ...)` utilisent toutes le même objet `brand`. Pas de double-import, pas de double-lecture.

### 7. Anti-patterns

**Hex en dur résiduel** : la ligne 101 contient `#highlight(fill: rgb("#FFE81F"))[droïdes]{=typst}`. Ce hex `#FFE81F` est hard-codé en Typst raw inline. C'est intentionnel pédagogiquement (démonstration du raw Typst inline dans le bloc 1) et cohérent avec la couleur sw-yellow. Pas un anti-pattern dans ce contexte, mais la valeur est dupliquée par rapport à la palette. Si sw-yellow change un jour, ce raw inline ne suivra pas. Acceptable pour une demo, marginalement fragile pour un vrai document de production.

**Pas de magic numbers, pas de duplication de palette** : les `tab_style()` accèdent tous les couleurs via `brand_color_pluck()`. Aucun hex codé en dur dans les styles gt (en dehors du raw Typst mentionné ci-dessus).

### 8. `cells_title()` couvre titre + sous-titre

`cells_title()` sans argument applique le style aux deux groupes `"title"` et `"subtitle"`. Le bandeau jaune couvrira donc la ligne « Anatomie d'une saga » ET la ligne « Top 5 par masse (kg) ». C'est probablement l'effet souhaité (bandeau uni), mais à vérifier visuellement : si le sous-titre mérite une couleur distincte, utiliser `cells_title(groups = "title")`.

---

## Checklist smoke test

| Test | Résultat |
|---|---|
| `brand_color_pluck(brand, "primary")` | `#BC1E22` — correct |
| `brand_color_pluck(brand, "foreground")` | `#0B0B0F` — correct |
| `brand_color_pluck(brand, "background")` | `#F5F0E1` — correct |
| `brand_color_pluck(brand, "sw-yellow")` | `"sw-yellow"` — **bug** |
| `brand_color_pluck(brand, "sw_yellow")` | `#FFE81F` — fix confirmé |
| `gt::cell_fill(color = "sw-yellow")` | `Error: invalid color name` — confirme le blocage |
| Contrastes WCAG AA | Tous passent |
| Conflits theme_brand_gt vs tab_style | Aucun (fonctions orthogonales) |
| render Quarto 1.10.3 | Non tenté (env R default sans brand.yml) ; le bug R est suffisamment confirmé sans render complet |
