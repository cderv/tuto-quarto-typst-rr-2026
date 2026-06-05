# Review pédagogue — Enrichissement style `gt` / `_brand.yml` (Bonus 4) — 2026-06-03

**Périmètre :** UNIQUEMENT l'évolution du style des tableaux `gt` des corrections
(helper `styliser_brand()`, dérivation de teintes via `prismatic::clr_darken`,
`data_color()` dégradé charte, helper `colorer_metrique()` à tunnel `{{ col }}`)
et sa pédagogisation dans le **Bonus 4** de `2-projets/index.qmd`.

Fichiers lus :
- `exercises/01-document-typst/correction/rapport-starwars.qmd` (helper + highlight ligne-1)
- `exercises/02-projet-book/correction/01-anatomie.qmd` (helper, table masses)
- `exercises/02-projet-book/correction/02-origines.qmd` (helper + `data_color()` ×2 + `colorer_metrique()`)
- `2-projets/index.qmd` → Bonus 4 réécrit (lignes 189-278)
- `exercises/02-projet-book/README.md` (prérequis `prismatic`)
- Contexte : review élève `.claude/reviews/review-2026-06-03-eleve-debutant.md`

---

## Question 1 — Est-ce trop compliqué ? → 👍 (avec 1 réserve mineure)

**Verdict : non, ce n'est pas trop compliqué pour son statut (bonus lu/comparé, post-atelier).**
Le helper **réduit** la complexité perçue par rapport au code dupliqué 4×.

### Ce qui est « lu/comparé » (OK si dense)

Le corps des `styliser_brand()` / `colorer_metrique()` n'est jamais tapé en séance.
Le participant le **lit** dans la correction et le **compare** à son résultat. À ce
titre, la densité est acceptable, et même pédagogiquement intéressante : c'est du code
« exemplaire » qu'on emporte chez soi. La présence du helper rend la correction
**plus** lisible qu'avant, pas moins.

### Le helper RÉDUIT la complexité perçue (point fort net)

Avant : 3 `tab_style()` + bloc `tab_options()` répétés à l'identique sur **4 tableaux**
(1 dans exo 1, 3 dans exo 2) = ~30 lignes dupliquées ×4, où l'œil doit diff-er
manuellement pour repérer ce qui change réellement d'un tableau à l'autre (rien, sauf
le highlight métrique). Après : la charte commune est **nommée une fois**
(`styliser_brand`), et au point d'appel il ne reste que **l'intention spécifique** :

- `01-anatomie.qmd:72` + `:75-81` → `styliser_brand()` puis highlight ligne-1 Jabba
- `02-origines.qmd:69+71` / `:130+132` → `styliser_brand()` puis `colorer_metrique(n)`

C'est exactement le bon découpage pédagogique : **« habillage commun » vs « emphase
propre à la donnée »**. Le Bonus 4 verbalise ce contraste explicitement (lignes 234-254,
« Colonne bien répartie → dégradé » vs « Valeur aberrante → highlight ligne 1 »), avec
une justification *data-driven* (Jabba à 1 358 écrase tout dégradé). C'est du très bon
design pédagogique : la technique sert une décision de lecture, elle n'est pas gratuite.

### Les briques avancées sont bien cadrées

- **`prismatic::clr_darken` + `teinte()`** (`rapport-starwars.qmd:40`, etc.) : le commentaire
  « sans hex magique » (slide 203) et « Teintes crème dérivées de la charte » justifient
  *pourquoi* on dérive plutôt que coder en dur. C'est cohérent avec le fil rouge
  « tout vient de `_brand.yml` ». Le `substr(..., 1, 7)` est un détail d'implémentation
  un peu cryptique, mais il vit dans le helper (lu, pas tapé) → acceptable.
- **`data_color()` palette charte** : présenté comme « mini-heatmap », effet visuel
  immédiat et motivant.
- **`colorer_metrique(t, col)` avec `{{ col }}`** (`02-origines.qmd:42-46`) : le tunnel
  `{{ }}` est la seule vraie nouveauté tidyeval. **Réserve mineure** : le Bonus 4
  n'introduit PAS le helper `colorer_metrique` ni le tunnel `{{ col }}` ; il montre
  `data_color(columns = n, ...)` en clair (slide 238-244). Donc un participant qui lit
  le Bonus 4 puis ouvre la correction trouve une **3e abstraction non annoncée**
  (`colorer_metrique(n)`) qui n'apparaît pas dans le support. Léger écart support↔correction.
  → Voir suggestion S1.

### Charge cognitive — RAS bloquant

Comme le Bonus 4 est `collapse="true"`, optionnel, et « à explorer après l'atelier »
(ligne 173-175), il n'ajoute **aucune** charge en séance pour le participant médian.
Les 3 étapes principales (lignes 54-61) restent intactes et ne dépendent pas de tout ça.
Le prérequis `prismatic` est correctement isolé comme « optionnel / brand styling avancé »
(`README.md:10`).

---

## Question 2 — Respecte-t-il encore la logique de l'exercice ? → 👍

**Verdict : oui, l'enrichissement reste à sa place (Bonus 4) sans déborder.**

### Arc narratif `charte → PDF → livre → personnalisé/pérennisé` : renforcé

Cet enrichissement nourrit précisément la **4e branche de l'arc (« personnalisé »)** :
« une seule ligne YAML modifiée fait suivre les lignes 1 des tableaux, les barres du
graphique, les annotations Jabba/Yoda » (lignes 193-194). Le couplage Bonus 3 (swap de
palette) × Bonus 4 (R lit la charte) est *l'apothéose* du fil rouge « `_brand.yml`
pilote le PDF **et** toutes les sorties R ». C'est l'argument le plus fort de tout
l'exo 2 sur la pérennité/cohérence — bien placé en fin de parcours.

### Statut « bonus optionnel » respecté à la lettre

- Callout `## Bonus 4` en `.callout-tip collapse="true"` (ligne 189) — replié par défaut.
- Encadré amont explicite « Bonus 3 et 4 sont des approfondissements — à explorer après
  l'atelier » (lignes 173-175).
- Le tableau des 3 étapes principales (54-61) **ne mentionne pas** ce style ; au contraire,
  l'étape 3 précise désormais « les tableaux `gt` restent bruts à ce stade — leur mise aux
  couleurs de la charte est l'objet du Bonus 4 » (ligne 61). C'est la **continuité directe
  du fix A6** de la review élève : l'attente est correctement déportée vers le bonus, et
  l'enrichissement ne re-contamine PAS l'étape 3. Très propre.

### Rythme My / Our / Your turn : non impacté

Le Bonus 4 n'est pas une nouvelle phase M/O/Y : c'est du matériel d'auto-apprentissage
post-séance, rattaché au « Your turn » de l'exo 2 comme rab pour les rapides / curieux.
Il ne perturbe ni la démo Our turn (lignes 30-37) ni le cœur Your turn. Conforme.

### Cohérence interne correction ↔ support

L'aperçu visuel (`2-gt.png`, ligne 270) avec son `fig-alt` détaillé donne le résultat
attendu sans rendre obligatoire le rendu local — bon filet pour qui compare. Le callout
« Piège silencieux » (lignes 272-276) sur `pal("sw_yellow")` vs `"sw-yellow"` est une
excellente anticipation d'erreur (boucle d'auto-correction autonome) : c'est typiquement
le genre de note qui aide Maëlle à dépanner en salle sans appeler CD.

---

## Suggestions de simplification ciblées

- **S1 (P2, le seul écart réel) — réconcilier `colorer_metrique` support↔correction.**
  La correction `02-origines.qmd` utilise `colorer_metrique(n)` (helper + tunnel `{{ col }}`),
  mais le Bonus 4 (slide 238-244) montre `data_color(columns = n, ...)` en clair, sans
  jamais nommer ce 2e helper. Deux options, au choix :
  - (a) ajouter 3 lignes au Bonus 4 : « pour ne pas répéter `data_color()`, la correction
    le range dans un mini-helper `colorer_metrique(t, col)` — `{{ col }}` permet de passer
    le nom de colonne nu » ; ou
  - (b) inliner `data_color()` dans la correction `02-origines.qmd` (supprimer
    `colorer_metrique`), pour coller exactement au support. Comme `data_color()` n'apparaît
    que 2× et que le tunnel `{{ }}` est la brique la plus avancée du lot, l'option (b)
    **réduirait** la surface conceptuelle de la correction sans rien perdre — à arbitrer
    selon que tu tiens à montrer le tunnel comme « bonus du bonus ».

- **S2 (P2, cosmétique) — un mot sur `teinte()` dans le support.** Le helper `teinte()`
  apparaît dans le bloc setup du Bonus 4 (slide 203-204) avec le commentaire « sans hex
  magique », mais `substr(..., 1, 7)` n'est pas expliqué (il tronque la sortie
  `#RRGGBBAA` de prismatic en `#RRGGBB`). Une demi-phrase éviterait un « pourquoi 7 ? »
  chez le lecteur curieux. Non bloquant — c'est dans le helper, donc lu et non tapé.

Aucune autre simplification nécessaire : la dette de complexité est **bien rangée dans
des helpers nommés**, ce qui est précisément la bonne réponse pédagogique à du code
répétitif.

---

## Synthèse des verdicts

| Question | Verdict |
|---|---|
| 1. Trop compliqué ? | 👍 Non — le helper **réduit** la complexité perçue vs 4× dupliqué ; dense mais lu/comparé, jamais tapé en séance |
| 2. Respecte la logique de l'exercice ? | 👍 Oui — confiné au Bonus 4 optionnel/post-atelier, renforce l'arc « personnalisé », n'empiète pas sur les 3 étapes |

Aucun P0, aucun P1. Deux P2 (S1 = seul écart support↔correction à combler ; S2 cosmétique).

**Note d'évolution :** cet enrichissement prolonge proprement le fix A6 de la review
élève (les tableaux bruts à l'étape 3, le style déporté en Bonus 4) — l'attente
pédagogique reste cohérente, rien n'a régressé de ce côté.
