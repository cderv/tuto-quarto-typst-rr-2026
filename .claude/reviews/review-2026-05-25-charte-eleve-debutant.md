# Review débutant·e — Charte Star Wars dans les starters

**Date :** 2026-05-25
**Profil :** participant·e R/RMarkdown, jamais touché à Quarto en projet ni à Typst, dplyr/ggplot2/gt OK, `_brand.yml` jamais manipulé, lecture FR native
**Périmètre :** parcours chronologique site → préparatifs → Bloc 1 (slide + index + boussole + starter + PDF charte) → Bloc 2 (idem) → 3-aller-plus-loin + 4-ressources
**Commit de référence :** `d024d6c` (branche `claude/tutorial-review-charter-9H98W`)

---

## Verdict général

La nouveauté principale (le PDF de charte graphique en starter) est **une excellente idée pédagogique** : j'ouvre le PDF, je vois exactement la cible visuelle, je comprends ce qu'on attend de moi. Le PDF est lisible, joli, avec les hex codes en clair et même les assignments `primary` / `foreground` / `background` écrits noir sur crème. Les "boussoles" projetées et les gabarits "Your Turn" me semblent clairs.

Mais en jouant le scénario réel, je rencontre **trois pièges silencieux** liés à la charte qui vont coûter du temps à 30 personnes en 12 minutes : (1) la charte écrit les noms de couleurs en `tiret-séparé` mais à l'étape 4 du Bonus, le code R utilise `tiret_souligné` sans avertissement préalable visible quand j'arrive sur ce code ; (2) la charte me montre `primary: imperial-red` etc. mais la syntaxe YAML exacte d'un `_brand.yml` (palette nommée vs. couleurs sémantiques) n'est jamais montrée en exemple complet avant que j'aie à l'écrire moi-même ; (3) la slide "Faisons ensemble!" du Bloc 2 (`2-projets/2-projets.qmd:71-77`) ne mentionne pas la charte, alors que celle du Bloc 1 le fait — incohérence qui me fera douter.

Aucun bloquant absolu. Les deux exos restent faisables. Mais 3-4 frictions ajoutées par la nouveauté valent la peine d'être corrigées avant le 16 juin.

---

## 🔴 Bloquant — rien

Je m'en sors le 16 juin, à condition que l'animateur·ice répare deux ou trois ambiguïtés à l'oral.

---

## 🟠 Gênant — à corriger avant le 16 juin

### G1. Pas d'exemple `_brand.yml` complet avant que je doive en écrire un

**Fichiers :** `1-quarto-typst/1-quarto-typst.qmd:156-185` (slide `_brand.yml`), `_charte/charte-starwars.pdf` (page 1), `exercises/01-document-typst/starter/README.md:13`

La slide "un doc stylé en un fichier" me montre 8 lignes minimalistes :

```yaml
color:
  primary: "#1a5276"
  secondary: "#f39c12"
typography:
  fonts:
    - family: "Noto Sans"
      source: google
  base: "Noto Sans"
```

À l'Exo 1, on me demande de transcrire la charte PDF. La charte affiche :
- 4 couleurs nommées (`imperial-red`, `sw-black`, `sw-cream`, `sw-yellow`)
- 3 **assignments** (`primary: imperial-red`, `foreground: sw-black`, `background: sw-cream`)
- 1 police Google + 1 police locale
- 1 logo

Le mot "assignments" apparaît sur la charte PDF et dans le tableau du site (`1-quarto-typst/index.qmd:51, 59`). Je ne sais pas ce que c'est. La slide démo ne m'a montré que `primary` direct en hex (pas via une palette nommée). Du coup je vais probablement écrire :

```yaml
color:
  primary: "#BC1E22"
  background: "#F5F0E1"
  ...
```

…et perdre 3-5 min à découvrir qu'il faut un `palette:` intermédiaire pour que `imperial-red` soit nommé, ou bien me planter sur l'indentation.

**Action concrète :** soit la slide démo `_brand.yml` montre l'exemple avec `palette:` et `primary: nom-palette`, soit la charte PDF affiche dans un coin un mini-snippet YAML correspondant aux assignments montrés (3-4 lignes suffisent). Sans ça, l'instruction "transcrire la charte" m'envoie dans la doc `brand.yml`, ce qui prend du temps.

### G2. La slide "Faisons ensemble" Bloc 2 ne parle pas de la charte

**Fichier :** `2-projets/2-projets.qmd:71-77`

```
1. Créer `_quarto.yml` avec `project: { type: default }` + `format: typst` → 5 PDF séparés
2. Passer à `type: book` (...)
3. Copier `_brand.yml` (+ `_logo-sw.svg` + `_fonts/`) à la racine → couverture jaune SW, Star Jedi (locale), Inter (Google)
```

L'étape 3 dit "copier". OK, mais copier d'**où** ? Le starter Bloc 2 ne contient PAS de `_brand.yml`. Soit :
- je récupère celui que j'ai créé au Bloc 1 (si j'ai fini),
- soit le fallback `_brand-fallback.yml`,
- soit je transcris la charte fournie dans le starter.

La slide ne mentionne aucun de ces trois chemins. Sur la **page** (`2-projets/index.qmd:58`), c'est plus clair (avec un lien fallback). Mais quand je suis la **démo** Our turn en direct, je ne vois que la slide, et "copier de…" reste opaque.

Comparaison : la slide "À vous!" Bloc 1 (`1-quarto-typst.qmd:229`) dit "📄 **Charte fournie** : `charte-starwars.pdf` dans le starter". La slide équivalente Bloc 2 (`2-projets.qmd:91-103`) **ne mentionne pas la charte**. Pourtant le starter Bloc 2 contient bien `charte-starwars.pdf` (cf. `02-projet-book/starter/README.md:15`).

**Action :** copier la même formulation que Bloc 1 dans la slide "À vous!" du Bloc 2, ou au minimum dans la slide "Faisons ensemble" étape 3 : préciser "copier depuis Bloc 1, OU `_brand-fallback.yml`, OU transcrire la charte".

### G3. Le piège `sw-yellow` → `sw_yellow` est dans le Bonus 4, pas visible quand je transcris la charte

**Fichiers :** `_charte/charte-starwars.pdf` (page 1), `2-projets/index.qmd:243-247`

La charte PDF écrit explicitement `sw-yellow` avec un tiret. Je vais bien sûr l'écrire `sw-yellow` dans mon `_brand.yml` (correct côté YAML — le starter `02-projet-book/_brand-fallback.yml:6` le confirme).

Le piège silencieux n'apparaît **que** si je vais jusqu'au Bonus 4 (`2-projets/index.qmd:243`), qui me dit qu'il faut `brand_color_pluck(brand, "sw_yellow")` côté R (underscore). C'est bien — mais c'est tard.

Si j'arrive au Bonus 4 sans avoir vu ce callout, je vais :
1. Copier-coller le bloc R du Bonus 4 (qui contient déjà `"sw_yellow"`).
2. Voir mon tableau gt sans le bandeau jaune attendu.
3. Conclure que c'est cassé.

Le callout "Piège silencieux à connaître" arrive **dans** le bonus, après le code. Bien. Mais pour quelqu'un qui scanne vite, il est tard. Ce n'est pas bloquant car le Bonus 4 est explicitement "deep dive" mais ça me fera buter si je tente.

**Action mineure :** dans la slide ou dans une note présentateur sur la pépite "Une charte, partout" (Bloc 1, `1-quarto-typst.qmd:248-255`), prononcer une phrase orale du type "côté R, les tirets deviennent des underscores". Ou bien dans le PDF de charte, ajouter en note de bas de page : "Côté R : les noms `tiret-séparé` deviennent `tiret_souligné`."

### G4. "Assignments" — terme non défini, jamais expliqué

**Fichiers :** `_charte/charte-starwars.pdf` (page 1), `1-quarto-typst/index.qmd:51, 59`

Le mot **"Assignments"** apparaît :
- sur la charte PDF (en anglais)
- dans le tableau de l'Exo 1 ("palette + assignments + police Google")

Je n'ai jamais vu ce mot dans le contexte `_brand.yml`. Je devine : c'est le mapping `primary` / `foreground` / `background` → nom-de-palette. Mais c'est de la devinette, et c'est intimidant de voir un mot anglais non traduit dans un support FR.

La charte affiche après les swatches :
```
Assignments  ·  primary: imperial-red  ·  foreground: sw-black  ·  background: sw-cream
```

Sans contexte, ça ressemble à du jargon. Soit on garde "Assignments" et on l'explique en une ligne sur la charte ("→ rôles sémantiques liés à un nom de palette"), soit on traduit en "Rôles" / "Affectations".

**Action :** changer "Assignments" → "Affectations" sur la charte (rendu PDF à régénérer) OU ajouter une phrase d'explication. Idéalement aussi dans le tableau Exo 1.

---

## 🟡 Détail — nice-to-have

### D1. La charte ne dit pas qu'`Inter` doit s'écrire sans guillemets… ou si.

**Fichier :** `_charte/_brand.yml:13-18` vs charte PDF

Sur la charte PDF, on me dit :
- `Star Jedi` (locale)
- `Inter` (Google)

Les deux apparaissent comme des noms de polices. Dans le `_brand-fallback.yml`, `"Star Jedi"` est entre guillemets (car deux mots) mais `Inter` n'a pas de guillemets. Pour un débutant·e YAML, savoir quand mettre des guillemets est non trivial.

Pas bloquant — YAML pardonne les guillemets en trop — mais une note "noms multi-mots → entre guillemets" sur la charte aiderait.

### D2. Le PDF charte est silencieux sur l'absence du yellow dans les assignments

**Fichier :** `_charte/charte-starwars.pdf` (page 1)

La note dit :
> "Note : sw-yellow reste dans la palette (utile pour accents ponctuels) — mais pas en primary (contraste trop faible sur fond crème)."

Bien. Mais en tant que débutant qui découvre la charte, je me demande : pourquoi alors `sw-yellow` apparaît-il dans le code Bonus 4 (`brand_color_pluck(brand, "sw_yellow")`) ? Réponse implicite : parce qu'il sert pour le bandeau titre du tableau, qui est un "accent ponctuel". La note de la charte est correcte rétrospectivement, mais j'ai du mal à voir comment l'utiliser sans aller jusqu'au Bonus 4. Pas grave, c'est un détail.

### D3. Workaround `Espece`/`Planete` invisible côté pédagogique dans Bloc 2

**Fichiers :** `exercises/02-projet-book/starter/01-anatomie.qmd:36-37`, `exercises/02-projet-book/starter/02-origines.qmd:27, 83`, `exercises/01-document-typst/starter/rapport-starwars.qmd:45-46`

Le starter me sert déjà `species = "Espece"` et `homeworld = "Planete"` (sans accent). Le commentaire dans le starter Bloc 1 (`rapport-starwars.qmd:44`) explique : "libellés sans accent : contournement bug gt → Typst sur les en-têtes". Bien.

Mais dans les starters Bloc 2 (`01-anatomie.qmd:36, 37` et `02-origines.qmd:27, 83`), **aucun commentaire** n'explique pourquoi "Espece" et "Planete" sont sans accent. À 10h30, si je le remarque, je pense que c'est une erreur et je corrige — paf, bug `gt`. Pas critique mais facile à ajouter (un commentaire d'une ligne au-dessus de chaque `cols_label()`).

### D4. `scales` listé en prérequis mais on ne charge jamais `library(scales)`

**Fichier :** `exercises/02-projet-book/README.md:9` et starters

Le README liste `scales` dans les packages requis. Dans les starters, on utilise `scales::label_number(...)` avec le namespace explicite. C'est cohérent et propre, mais pour un débutant qui lit "installez scales" puis ne voit jamais `library(scales)` dans le code, j'ai un petit moment de doute ("est-ce qu'il faut que je l'ajoute ?"). Pas bloquant.

### D5. Bloc Typst raw dans le starter Bloc 2 — surprise

**Fichier :** `exercises/02-projet-book/starter/01-anatomie.qmd:42`

Dans le starter Bloc 2, je trouve cette ligne :

```markdown
Mais les vraies stars de la saga sont les `#highlight(fill: rgb("#FFE81F"))[droïdes]`{=typst} :
```

Je n'ai jamais vu cette syntaxe `` `...`{=typst} `` avant. La page "aller plus loin" (`3-aller-plus-loin/index.qmd:16-23`) parle des "Blocs Typst raw" mais en mode "pour après le tutoriel". La pépite slide Bloc 1 (`1-quarto-typst.qmd:251`) en parle aussi rapidement.

Si je tente de rendre le livre sans `format: typst` au début (étape 1 du `_quarto.yml`), comment ce code se comporte-t-il ? Pas de note explicative dans le starter. Si je tente de le supprimer ou de l'éditer parce que je ne comprends pas, je casse silencieusement le rendu. Mineur car je ne suis pas censé toucher ce paragraphe, mais ça surprend.

### D6. `Mon Mothma` comme auteur — drôle mais ambigu

**Fichiers :** `2-projets/index.qmd:109`, `2-projets/2-projets.qmd:40`

Le modèle `_quarto.yml` propose `author: "Mon Mothma"`. C'est un clin d'œil Star Wars. Bien. Mais en lisant rapidement, je peux me dire "ah, c'est un placeholder, je mets le mien" — ce qui est probablement l'intention. Rien ne le dit explicitement. C'est mineur — la slide et la page sont cohérentes. Pas d'action requise, juste pour info.

### D7. Bug `1 7 5` — pas mentionné dans le starter, c'est volontaire mais surprenant

**Fichiers :** `2-projets/index.qmd:155-159`, `2-projets/2-projets.qmd:86`

Le callout "Bug gt à connaître" est sur la page du Bloc 2 et le workaround `opt_table_font(font = "Inter")` y est expliqué. Bien. Mais dans la note presenter ligne 86, l'animateur dit "bug volontairement visible dans le starter". Si je suis Windows ou Mac et que j'ouvre le PDF à l'étape 3 en voyant "1 7 5" partout, je peux paniquer 30 secondes avant de me souvenir du callout. Le callout est plié (`collapse="true"`) — donc invisible par défaut.

Si je suis bloqué·e par "1 7 5", est-ce que l'animateur va le mentionner à l'oral ? Le callout collapse en page sera-t-il assez visible pour qu'on aille le chercher ? Pas un nouveau problème (déjà signalé dans les reviews précédentes), mais ça reste un point d'attention.

---

## ✅ Ce qui me rassure

- **Le PDF de charte est génial.** Je vois exactement ce qu'on attend de moi. Les swatches colorés avec hex code, la mention des fichiers (`_fonts/Starjedi.ttf`, `_logo-sw.svg`), la phrase de clôture "À vous de jouer : transcrivez cette charte en YAML" : c'est limpide. Le fait qu'il soit lui-même rendu via Quarto+Typst (le "méta-exemple" évoqué dans le README `_charte/README.md`) renforce le message "voici ce que vous allez produire".
- **Les README des starters sont courts et bien ciblés.** Le tableau "Contenu du dossier" me dit exactement quoi faire de chaque fichier. La mention `_(pas de _brand.yml)_ — À créer aux étapes 3-4 d'après la charte` est explicite et m'épargne la confusion "il manque quelque chose".
- **Les pages boussole** projetées sont nettes et minimalistes : countdown gros, 5 étapes en verbes seuls, 3 marches d'escalier si je bloque. Exactement ce qu'il faut pour 30 personnes qui regardent le mur.
- **Les "indices doc" sont en collapse** : je ne suis pas spoilé tout de suite, mais je peux les ouvrir si je galère. Bonne friction pédagogique.
- **Le tableau "Étapes" sur la page Exo (Bloc 1 et 2)** est super lisible avec sa colonne "Vous devriez voir" — je sais à chaque étape si j'ai réussi.
- **La continuité Exo 1 → Exo 2.** Le `_brand-fallback.yml` me sauve si je n'ai pas terminé Bloc 1. Pas de panique de "mais j'ai pas fini, je peux pas faire Exo 2".
- **Le PDF charte est dans les deux starters** (Exo 1 + Exo 2). Cohérent.
- **`format: html` partout** sur les pages internes. Le countdown sur les boussoles démarre auto (`start_immediately=true`).
- **`preparatifs.qmd`** mentionne le plan B offline et donne un test d'installation concret (`exercises/00-test-install/test-install.qmd`). Excellent.

---

## 📝 Évolution depuis la review précédente

### Ce qui s'est amélioré

- **Le PDF charte est apparu** depuis la review précédente. C'était un point manquant clé : avant, je devais lire `correction/_brand.yml` pour savoir à quoi ressemble la cible. Maintenant la cible est explicite et visuelle.
- **La page boussole projetée** est nouvelle et résout le problème "où est mon countdown quand je code" — avant, le countdown était sur les slides et défilait quand l'animateur passait à la suite.
- **L'escalier d'autonomie 3 marches** ("relire le 'Vous devriez voir' / ouvrir les indices doc / ouvrir la correction") est explicite et cohérent entre les deux exos.
- **Le starter Bloc 2 a maintenant un `README.md`** comme le Bloc 1, avec le quick-ref. Avant, l'asymétrie entre les deux exos était troublante.
- **Le callout "Piège silencieux"** sur la normalisation tiret → underscore est en place dans le Bonus 4 (ma review précédente le notait déjà comme arrivé).
- **Le callout "Bug `gt`"** sur la page Bloc 2 reste clair, avec le workaround explicite.
- **Les commentaires inline** dans la correction Exo 1 sur `tab_style()` (`# Bandeau titre`, etc.) sont en place — bien.

### Ce qui n'a pas bougé (et reste un petit point)

- L'absence d'un exemple `_brand.yml` complet **avec `palette:` nommée** avant que je doive en écrire un. La slide démo Bloc 1 (`1-quarto-typst.qmd:156-185`) reste un mini-exemple sans palette nommée. Pour transcrire la charte (4 couleurs nommées + 3 assignments), j'ai besoin d'un modèle. Sinon je vais chercher dans la doc.
- La slide "Faisons ensemble" Bloc 2 (`2-projets.qmd:71-77`) ne mentionne pas la charte et c'est asymétrique vs Bloc 1.

### Ce qui était déjà bon (et l'est resté)

- L'arc pédagogique global `.qmd` → PDF → livre → charte personnalisée.
- La qualité du français, la cohérence des termes My turn / Our turn / Your turn.
- Le respect des temps annoncés (12 min Your Turn, ~40 min par bloc).
- La présence d'une route "Plan B offline" dans `preparatifs.qmd`.
- La page Ressources `4-ressources.qmd` est dense mais bien organisée par thèmes.
