# Review wording (registre & naturel FR) — 2026-06-12

Passe registre/naturel par `workshop-reviewer-wording` (propose-only). Cible : français de tous les jours, parlé, pro mais décontracté. Hors périmètre : orthographe/typo (`workshop-reviewer-fr`).

## Synthèse

- **Total : 17 propositions** (hors notes transverses).
- **Répartition** : Lot 1 slides = 5 · Lot 2 pages/boussoles = 6 · Lot 3 exercices = 1 · Lot 4 paquet R = 5.

**Patterns récurrents :**
1. **Nominalisations à reverbaliser** (« la traduction est automatique » → « Quarto traduit tout seul » ; « son réglage fin se fait » → « on le règle finement »).
2. **Incohérence de registre « nécessaire/inutile » vs « pas besoin/rien à faire »** dans le paquet R, pour le *même* message (font-paths) — harmoniser sur le parlé déjà majoritaire.
3. **« effectuer un rendu » → « faire un rendu »** (tic administratif, lot 4 + roxygen).
4. **Passifs raides → voix active** (« vous sera indiquée », « peuvent être ignorés »).
5. **Formule « utile seulement si… » martelée ~4× dans `preparatifs.qmd`** — à varier.

### Verdict global

Matériel déjà bien calibré, globalement naturel — peu de churn possible sans dégrader. Le plus gros gisement est le paquet R (lot 4). Boussoles et notes de slides `::: notes` (non vues des participant·es) laissées telles quelles.

## Lot 1 — Slides

**`1-quarto-typst/1-quarto-typst.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 68 | « la traduction vers Typst est automatique » | « Quarto traduit vers Typst tout seul » | verbe + voix active, plus parlé |
| 120 | « Typst est intégré à Quarto depuis la version 1.5 » | « Typst est livré avec Quarto depuis la 1.5 » | « livré avec » plus concret (préférence légère) |
| 123 | « pas de distribution TeX de 1 Go à gérer » | « …de 1 Go à installer » | « à gérer » vague ; « à installer » colle au bénéfice |

**`2-projets/2-projets.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 48 | « Finie la répétition de YAML dans chaque fichier ! » | « Plus besoin de répéter le YAML dans chaque fichier ! » | nominalisation littéraire → forme verbale parlée |
| 251 | « Savoir où chercher pour aller plus loin » | « Où chercher pour aller plus loin » | ⚠️ les autres puces sont des verbes ; vérifier cohérence avec `1-quarto-typst/index.qmd:28` |

## Lot 2 — Pages web & boussoles

**`index.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 13 | « en utilisant **Typst** pour fabriquer le PDF » | « avec **Typst** pour fabriquer le PDF » | « en utilisant » → « avec » |
| 13 | « Vous découvrirez comment personnaliser vos documents grâce à `_brand.yml` » | « Vous verrez comment personnaliser vos documents avec `_brand.yml` » | « découvrirez…grâce à » un peu pub → plus sobre |

**`preparatifs.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 70-71 | « Les sections ci-dessous deviennent **facultatives** (elles détaillent le même chemin **à la main**). » | « …sont **facultatives** : c'est le même chemin, mais **à la main**. » | « deviennent facultatives » lourd |
| 100 | « utile seulement si vous n'avez pas utilisé le paquet » | « à faire à la main seulement si vous n'avez pas pris le paquet » | varie la formule répétée ~4× (l. 100, 131, 151) |
| 142 | « utilisez `quarto::quarto_binary_sitrep(debug = TRUE)` pour aider à diagnostiquer » | « lancez … pour diagnostiquer » | verbe d'action + coupe la périphrase |

**`4-ressources.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 84 | « …normalisées en `tiret_souligné` au read » | « …normalisées en `tiret_souligné` à la lecture » | ⚠️ « au read » anglicisme évitable ; vérifier renvoi |

**`1-quarto-typst/index.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 67 | « son réglage fin se fait au Bloc 2 » | « on le règle finement au Bloc 2 » | nominalisation passive → voix active |

**`2-projets/index.qmd`**

| ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| 291 | « En cas d'erreur de saisie, `brand_color_pluck()` ne lève pas d'erreur lui-même » | « Si vous vous trompez de clé, … » | « en cas d'erreur de saisie » administratif → direct |

*(Marginal, non compté : `2-projets/index.qmd:173` « anodin mais redondant » un peu littéraire — option « sans risque, juste superflu ».)*

## Lot 3 — Exercices

| fichier:ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| `01-document-typst/README.md`:7 | « …pour l'aide-mémoire opérationnel » | « …pour l'aide-mémoire » | ⚠️ « opérationnel » jargon inutile ; idem `02-projet-book/README.md`:15 — resynchroniser |

Chapitres du livre Star Wars (`correction/*.qmd`, `rapport-starwars.qmd`) = voix narrative délibérée, **hors cible**, non touchés.

## Lot 4 — Messages cli du paquet R

| fichier:ligne | actuel | proposé | pourquoi |
|---|---|---|---|
| `verifier-installation.R` roxygen 4-5 | « …effectue un **rendu de test** » | « …**fait un rendu de test** » | « effectue » → « fait » |
| `verifier-installation.R`:32 | « Rendu de test sauté (Quarto indisponible). » | « …(Quarto absent). » | « absent » plus simple + cohérent avec `checks.R:124` |
| `checks.R`:80 | « …une petite manipulation (font-paths) vous sera indiquée à l'écran. » | « …on vous indiquera une petite manipulation (font-paths) à l'écran. » | passif raide → voix active |
| `typst.R`:45 | « …pas de contournement `font-paths` nécessaire. » | « …pas besoin du contournement `font-paths`. » | « pas besoin de » plus parlé ; harmonise |
| `brand.R`:158-159 | « …le contournement `font-paths` est inutile. Rien à faire. » | « …pas besoin du contournement `font-paths`. Rien à faire. » | « inutile » sec → même registre que « Rien à faire » |
| `diagnostiquer-rendu.R`:90-92 | « …le ou les points bloquants… ; les avertissements bénins peuvent être ignorés. » | « …les points bloquants… ; vous pouvez ignorer les avertissements bénins. » | « le ou les » alourdit ; passif → actif |

*(Option légère, ⚠️ nuance « peut » à préserver : `typst.R`:41-42 « peut être nécessaire » → « peut servir ».)*

Messages déjà excellents (modèles à reprendre, non touchés) : `installer-exercices.R:114`, `correction.R:32/101`, `creer-projet.R:146`, `naviguer.R:28-29`.
