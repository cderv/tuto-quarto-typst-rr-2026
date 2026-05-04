# Review technique vague 4 — Quarto/Typst

**Branche** : `claude/post-merge-doc-audit` HEAD `39f9ff5`
**Quarto local** : 1.9.36 (cible 1.9+ OK)
**Date** : 2026-05-04
**Périmètre** : audit anti-régression sur les 3 commits livrés depuis la review vague 3 (`438aafd` FR, `625c03e` participant, `39f9ff5` P2 sweep) + smoke test render racine.

---

## Verdict général

État technique impeccable. `quarto render` racine produit 8/8 fichiers sans warning ni error Pandoc. Le `\` hard-break sur les signatures wrap-up rend bien `<br>` (un fix 1-char qui marche). Les 5 bullets `::: incremental` du wrap-up Slide A sont bien fragmentés (5 `<li class="fragment">`). Le `::: {.callout-note appearance="minimal"}` ajouté en tête de `3-aller-plus-loin/index.qmd` rend correctement (`callout-style-simple no-icon`). Aucun anti-pattern (`orange-book-typst`, `extend: orange-book`, `quarto typst gather`) réintroduit dans aucun des 3 commits. Aucune régression détectée. **0 P0, 0 P1, 0 P2 nouveaux.**

---

## P0 — bug technique bloquant

**Aucun.**

---

## P1 — à corriger avant le 16 juin

**Aucun.**

---

## P2 — nice-to-have / robustesse

**Aucun nouveau.** Les P2.2 / P2.3 / P2.4 vague 3 explicitement non traités (cas de bord assumés) sont documentés dans le brief utilisateur et restent valides — pas de re-flag.

---

## Vérifications effectuées (forces validées)

### 1. Signature wrap-up `\` hard-break — `2-projets/2-projets.qmd:174-175`

`_site/2-projets/2-projets.html` confirme le `<br>` :
```html
<p><strong>Christophe Dervieux</strong> — Posit<br>
<strong>Maëlle Salmon</strong> — rOpenSci / cynkra</p>
```
Les 2 lignes apparaissent bien sur 2 lignes. Pandoc traite `\` en fin de ligne comme `LineBreak` → HTML `<br>`. Pas d'effet de bord visuel attendu (`<br>` n'est pas un `<p>`, donc pas de spacing parasite reveal.js).

### 2. Slide A wrap-up à 5 bullets — `2-projets/2-projets.qmd:142-150`

`_site/2-projets/2-projets.html` confirme 5 `<li class="fragment">` dans `<ul>` (rendu correct de `::: incremental`). Le contenu textuel (le plus long = bullet 5 « Savoir où chercher pour aller plus loin (partials, formats communautaires — couverts en pistes, pas en séance) ») tient largement en une ligne sur 1080p (60 caractères). 5 bullets courts + une `<h2>`, pas de risque de débordement sur 16:9.

### 3. `3-aller-plus-loin/index.qmd:12` — callout-note minimal + H3

```html
<div class="callout callout-style-simple callout-note no-icon">
```
Syntaxe `::: {.callout-note appearance="minimal"}` valide en `format: html`, rendue par Quarto avec `callout-style-simple` + `no-icon`. Les 3 H3 (`### 1 — Blocs raw Typst`, etc.) sortent bien comme `<h3 class="anchored">` sans interférence avec le callout. Pas de conflit.

### 4. `preparatifs.qmd:51` — parenthèse en gras

Rendu HTML :
```html
<p><strong>Résultat attendu</strong> : un fichier <code>test-install.pdf</code> apparaît à côté du <code>.qmd</code>, avec un titre accentué, un tableau de 3 lignes et un graphique. Aucune <strong>erreur</strong> en console (un avertissement sur la police est normal et documenté ci-dessous).</p>
```
Pas de conflit Markdown — la parenthèse n'interrompt pas le `<strong>` ni le flux du `<p>`. Le `<ul>` qui suit (« Si ça échoue ») est bien séparé.

### 5. Notes presenter enrichies — `1-quarto-typst/1-quarto-typst.qmd:148`

Compte des balises `<aside class="notes">` vs `</aside>` :
- `_site/1-quarto-typst/1-quarto-typst.html` : 8 ouvertures / 8 fermetures
- `_site/2-projets/2-projets.html` : 8 ouvertures / 8 fermetures

Aucune fuite de notes presenter dans la slide suivante. Les `::: notes` sont bien clos.

### 6. Render racine — `LANG=C.UTF-8 LC_ALL=C.UTF-8 quarto render`

```
[1/8] 1-quarto-typst/1-quarto-typst.qmd
[2/8] 1-quarto-typst/index.qmd
[3/8] 2-projets/2-projets.qmd
[4/8] 2-projets/index.qmd
[5/8] 3-aller-plus-loin/index.qmd
[6/8] 4-ressources.qmd
[7/8] index.qmd
[8/8] preparatifs.qmd
Output created: _site/index.html
```
8/8 OK. `grep -i -E "(warn|error|fail)"` retourne **rien**. Aucun conflit multi-format introduit.

### 7. Anti-patterns — sweep complet

Recherche `(orange-book-typst|extend: orange-book|quarto typst gather)` sur tous les `.qmd` / `.yml` / `.md` du repo (hors `_site/`, `review-`, `.claude/`) : **AUCUN ANTI-PATTERN TROUVÉ**.

Audit des `format:` declarations (44 occurrences) — toutes valides :
- `format: html` pour pages web (préparatifs, index, 1-/2-/3-/4- index, exo starter)
- `format: typst` pour PDF (test-install, exo correction, blocs YAML pédagogiques)
- `format: clean-revealjs` pour les 2 fichiers de slides
- `format:` (forme longue) dans `_quarto.yml` racine, `4-ressources.qmd` (snippets pédagogiques), `2-projets/index.qmd` (snippet pédagogique), `1-quarto-typst/1-quarto-typst.qmd` (snippets pédagogiques), `exercises/02-projet-book/correction/_quarto.yml`, `exercises/01-document-typst/correction/rapport-starwars.qmd`

### 8. Renders correction (Exo 1 + Exo 2)

**Échec environnement** : `there is no package called 'rmarkdown'` sur `R 4.3.3` du sandbox (knitr 1.51 OK, rmarkdown manquant). Non bloquant per le brief — l'env participant aura `rmarkdown` via `preparatifs.qmd:18` (`pkg <- c("rmarkdown", ...)`). Pas de finding.

---

## Évolution depuis review précédente (vague 3)

**Ce qui s'est amélioré techniquement** :

- **P2.1 vague 3 fixé propre** (`2-projets/2-projets.qmd:174`) : ajout d'un seul `\` en fin de ligne — la solution Pandoc canonique pour LineBreak (préférable à un `<br>` HTML inline qui marcherait aussi mais introduirait du HTML). Confirmé rendu par `_site/2-projets/2-projets.html`.
- **5ᵉ bullet wrap-up Slide A** (`2-projets/2-projets.qmd:146,149`) : enrichissement pédagogique cohérent avec le matériel (`keep-typ: true` couvert au Bloc 1, partials annotés « pas en séance »). Pas de débordement vertical attendu, `::: incremental` toujours valide.
- **`3-aller-plus-loin/index.qmd` reformaté** : suppression des timings sur les H3 + ajout d'un disclaimer pédagogique en `callout-note minimal`. Améliore la lisibilité sans casser la structure de cross-refs.
- **Reformulation `2-projets/index.qmd:28`** (« Reconnaître que `format: typst` + `type: book` active automatiquement l'extension orange-book (Quarto 1.9) ») : claim techniquement exact, cohérent avec `quarto.js:91326-91328`.
- **`4-ressources.qmd:72`** (`Helpers R` → `Fonctions auxiliaires R`) : francisation cosmétique, sans impact technique.

**Ce qui était déjà bon (confirmé persistant)** :

- Toutes les déclarations `format:` propres (héritage vagues 1-3)
- `_brand.yml` syntaxe valide (vague 3, non re-vérifié)
- `font-paths:` placement correct (vague 3, non re-vérifié)
- `::: notes` toujours bien clos (compte balisé 8/8 + 8/8)
- Cross-refs `@fig-…`, `@sec-…`, `@tbl-…` (validées vague 3, render racine OK)
- Aucun conflit multi-format dans `_quarto.yml`
- Smoke render racine 8/8 sans warning ni error

**Conclusion.** Le sweep `39f9ff5` (P2) + les 2 commits de prose (`438aafd` FR, `625c03e` participant) ne réintroduisent **aucune** régression technique. Aucun nouvel anti-pattern, aucune nouvelle ambiguïté YAML, aucune fuite de notes, aucun warning Pandoc. Le matériel est techniquement prêt pour le 16 juin sur le plan Quarto/Typst.
