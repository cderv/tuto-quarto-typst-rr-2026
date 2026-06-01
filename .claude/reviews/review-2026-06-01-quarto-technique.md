# Review technique Quarto+Typst — RR 2026

- **Date** : 2026-06-01 · **Commit** : `0bfc299`
- **Env de test** : sandbox Linux vierge, Quarto **1.9.36** (= plancher stable, *pas* la pre-release v1.10.4+), Typst 0.14.2 bundled, R 4.6.0 (rig), packages installés depuis PPM, réseau OK (Google Fonts fetchées).

## Verdict général

Matériel **techniquement solide et publiable en l'état**. Les 3 rendus PDF critiques (exo 1 correction, exo 2 book correction, test-install) **réussissent end-to-end sur Quarto 1.9.36** — donc sur la version *plancher* la plus exposée au bug font book, grâce au workaround `font-paths` correctement placé dans `correction/_quarto.yml`. Site complet rendu 10/10 (slides `clean-revealjs`, boussoles + countdown, pages web) sans erreur. Syntaxe `format: typst`, `_brand.yml`, `font-paths`, `pdf-standard: ua-1`, `{{< pagebreak >}}`, countdown validée contre le schéma 1.9.36 et les extensions installées ; aucun nom inventé (`orange-book-typst`, `extend:`) nulle part. **Un seul vrai bug** : une date YAML mal formée sur la page d'accueil. Le reste est P2. Les 3 issue drafts sont cohérents avec le code.

## 🔴 P0

*Aucun.* Tous les rendus testés produisent un PDF/HTML valide sans erreur fatale.

## 🟠 P1

**P1-1 — Date d'accueil mal formée → affiche « 6 avril 2027 »**
`index.qmd:6` : `date: "16-06-2026"` (format `DD-MM-YYYY`). Vérifié sur le rendu : `_site/index.html` contient `<p class="date">6 avril 2027</p>`. Quarto ne reconnaît pas `16-06-2026` comme ISO et débordement mois 16 → 2027. C'est la première date visible du site, et elle est fausse. Toutes les autres surfaces utilisent l'ISO correct `2026-06-16` (slides rendent bien « 16 juin 2026 », vérifié). **Fix** : `index.qmd:6` → `date: "2026-06-16"`.

## 🟡 P2

- **P2-1 — `_brand-empire.yml` ≡ `_brand.yml` (correction)** : `diff` IDENTIQUE. Voulu (Empire = palette par défaut, `imperial-red` en `primary`), mais un participant qui fait `brand: _brand-empire.yml` au Bonus 3 ne verra aucun changement → confusion possible. Suggestion : préciser dans le callout Bonus 3 (`2-projets/index.qmd:172`) « Empire = défaut, prenez jedi/mando pour voir l'effet », ou retirer le fichier. Les variantes jedi (`r2-blue`) et mando (`mando-crimson`) diffèrent bien.
- **P2-2 — libellé de lien** `2-projets.qmd:179` : `[Pour aller plus loin](../4-ressources.qmd)` — le texte est aussi le titre de `3-aller-plus-loin/`. Ambiguïté cosmétique ; la sidebar distingue bien les deux.
- **P2-3 — cross-ref starter book en HTML isolé** : `01-anatomie.qmd:43` starter contient `@sec-origines` ; sans `_quarto.yml` (à créer par l'élève) le render produit des HTML isolés où la ref ne résout pas. **Explicitement documenté comme attendu** dans `_speaker/demo-bloc2-our-turn.qmd:169-171`. Aucun fix requis, noté pour traçabilité.

## ✅ Choix techniques validés (vérifiés, pas seulement lus)

- **Rendus PDF end-to-end OK sur 1.9.36** : exo1 correction → `rapport-starwars.pdf` (92 KB, Star Jedi + Inter Google chargés) ; exo2 → `_book/Anatomie-d-une-saga.pdf` (201 KB), **aucun warning `unknown font family: star jedi`** → le workaround `font-paths: [.quarto/typst/fonts, _fonts]` (`correction/_quarto.yml:27`) fonctionne sur le plancher ; seuls warnings = fallbacks Linux attendus. test-install → 58 KB OK. charte → `post-render.R` copie le PDF dans les 2 starters. Site → 10/10, aucune erreur.
- **Statut version Quarto** : plancher 1.9 confirmé fonctionnel (book se rend même sur 1.9.36 via workaround) ; v1.10.4+ recommandée pour s'en passer. Callout dépliable `2-projets/index.qmd:140-156` documente précisément bug + PR #14517 + version de fix + inocuité ≥1.10.4. Cohérent avec `CLAUDE.md` et l'issue draft.
- **`font-paths`** toujours sous `format.typst:` (`correction/_quarto.yml:27`, `_charte/charte-starwars.qmd:9`, modèle `2-projets/index.qmd:150`), jamais sous `book:` ni top-level.
- **`format: typst`** : forme courte sans options, forme longue dès `papersize/margin/font-paths/logo`. Grep antipatterns (`orange-book-typst`/`extend:`/`format: orange-book`) → **vide**.
- **`_brand.yml`** : `color.palette` + `primary/foreground/background` ; `typography.fonts` liste de dicts (`source: google` + `weight:[...]`, `source: file` + `files:`) + `base` + `headings` ; `logo.images.<id>.{path,alt}` + `logo.medium`. Forme `images:`+`medium:` (book) respectée partout.
- **`_brand-starter.yml` = correction `_brand.yml`** : `diff` IDENTIQUE — claim README « copie 1:1 » exact. **`_brand-offline.yml`** : vraie différence (Inter `google`→`file`, 3 TTF), Plan B réseau cohérent, `_fonts/` correspondants présents.
- **`type: book` auto-active orange-book** sur `format: typst` : claim correct. Chapitres book commencent tous par `# H1` **sans** `title:` YAML → pas de chapitre fantôme.
- **Cross-refs** : `@sec-origines` (`{#sec-origines}` `02-origines.qmd:1`) référencé en `01-anatomie`/`conclusion` ; `@fig-`/`@tbl-` via labels chunk. `lang: fr` partout → labels FR, book rendu sans warning de label.
- **`execute:`** `echo/warning/message: false` homogène starter↔correction↔test-install.
- **`.content-visible when-format="typst"`** propre + un seul idiome ; **`{{< pagebreak >}}`** core ; **countdown** ext `gadenbuie` 0.6.0, `start_immediately` géré, rendu vérifié `start-immediately="true"` ; **`pdf-standard: ua-1`** valeur valide dans le schéma 1.9.36, limitation book-UA-1 signalée.
- **Pages web** : toutes `format: html` explicite → pas de conflit multi-format ; internes avec `author:""`+`date:""`. Slides `clean-revealjs` (ext 1.4.1, `mathjax-config.js` présent, SCSS compile). Callouts My/Our/Your turn via variables SASS, pas de background flashy.
- **Code R** : packages `preparatifs.qmd:23` suffisent. `brand_color_pluck(brand,"sw_yellow")` (underscore) correct vs clé `sw-yellow` (normalisation documentée). `opt_table_font("Inter")` workaround gt→Typst documenté+appliqué.
- **Liens GitHub** tous sur `cderv/cderv-tuto-quarto-typst-rr-2026` ; assets images tous résolus ; `fig-alt` présent.
- **Issue drafts** `.claude/issues/` cohérents : font-book (PR #14517/v1.10.4) ↔ commentaire `correction/_quarto.yml` ; orange-book text-color explique le choix `imperial-red` (pas `sw-yellow`) en `primary` ↔ `_charte:61` ; header i18n = bug upstream non bloquant.

## 📝 Évolution

Pas de review `quarto-technique` antérieure pour diff direct. Sur l'historique git : `_brand-starter.yml`+`_logo-sw.svg` désormais à la racine exo, copie 1:1 confirmée ; `prismatic` réintégré (dépendance transitive `brand.yml`) ; workaround `font-paths` sorti du modèle participant et isolé en callout dépliable versionné, gardé en défensif dans la correction — **vérifié fonctionnel sur 1.9.36**.

## Comptage

**0 P0 / 1 P1 / 3 P2.**
