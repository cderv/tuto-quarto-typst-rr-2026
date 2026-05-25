# Review 2026-05-25 — Cohérence d'ensemble & parcours utilisateur

Branche : `claude/tutorial-review-charter-9H98W` — HEAD `d024d6c`.

## 1. TL;DR

L'ajout de `_charte/charte-starwars.pdf` est un **vrai pivot pédagogique** : il transforme un exercice de YAML-copy/paste en exercice de **lecture-charte-puis-transcription**, et le PDF de charte est lui-même une **démo méta** ("ce doc est un PDF Typst rendu via `_brand.yml`") qui colle exactement à la promesse "PDF pro en quelques minutes". Cohérence entre `_charte/_brand.yml`, `01-document-typst/correction/_brand.yml` et `02-projet-book/_brand-fallback.yml` : **byte-for-byte identiques** — c'est verrouillé (vérifié `diff`). Les drifts résiduels sont mineurs (timing 12 vs 15 min, mention "palette Empire" obsolète, boussole exo2 qui ne reflète pas 2a/2b). Risques 16 juin : Quarto < 1.10.4 (workaround documenté), réseau (Plan B asymétrique exo1 vs exo2), persona "retardataire" non adressé. Profile `pretuto` minimal et propre.

**Verdict global : prêt à 90 %.** Le squelette est solide, l'arc narratif tient, l'expérience apprenant·e bien pensée (3 niveaux d'autonomie : boussole / indices doc / correction). Les 5 corrections du §6 amènent à 95 %.

## 2. Cohérence narrative

**Verdict : l'arc `.qmd → PDF pro → livre → personnalisé/pérennisé` tient debout, la charte le renforce.**

- **Bloc 1 = `.qmd → PDF pro → personnalisé`** : `rapport-starwars.qmd` (HTML) → `format: typst` → `_brand.yml` transcrit depuis charte → PDF brandé. Le PDF de charte ajoute une couche méta : l'apprenant·e voit en regardant la charte ce que produit `logo.medium`, `typography.headings: Star Jedi`, `primary: imperial-red`. **Auto-référentiel et didactique**, pas gadget.
- **Bloc 2 = `personnalisé → livre → pérennisé`** : le même `_brand.yml` est réutilisé à la racine d'un projet `type: book`. La continuité est explicitement scénarisée (`2-projets/2-projets.qmd:80` — « la charte de Bloc 1 ressuscite côté book »).
- **Promesse vs livraison** : `index.qmd:17-19` pose 3 questions (LaTeX/Typst, `_brand.yml`, projet multi-chapitres). Les 3 sont effectivement répondues — `2-projets/2-projets.qmd:136-141` (« Ce que vous savez faire maintenant »). Solide.
- **Sous-utilisation** : le PDF de charte fait office de **livrable visuel de référence** mentionné dans `1-quarto-typst/index.qmd:51` et `2-projets/index.qmd:58`, mais pas exploité comme **outil de débogage visuel** (comparer son PDF rendu au PDF charte cible).
- **"Pérennisé" peu servi** : l'arc claudemd promet "pérennisé" mais le matériel n'a pas de section explicite "rendre durable". Le Bloc 3 (`3-aller-plus-loin/`) couvre partials/extensions mais c'est marqué "hors séance". Trou mineur si on prend la promesse au pied de la lettre.

## 3. Drifts entre supports

| # | Localisation A | Localisation B | Drift |
|---|---|---|---|
| D1 | `exercises/01-document-typst/README.md:3` — « Durée : **15 minutes** » | `1-quarto-typst/1-quarto-typst.qmd:231`, `1-quarto-typst/index.qmd:53`, `1-quarto-typst/boussole.qmd:12` — **12 minutes** partout | README parent annonce 15, tout le reste 12. Aligner sur 12 (cf. countdown). |
| D2 | `exercises/01-document-typst/README.md:16` — « la **palette Empire** » | `_charte/_brand.yml`, `01-document-typst/correction/_brand.yml` : palette s'appelle `imperial-red`. L'alias `_brand-empire.yml` n'existe **que** pour exo 2 (`02-projet-book/correction/_brand-empire.yml`) | L'exo 1 n'a pas de variantes empire/jedi/mando. Le README parent évoque un "Empire" qui n'est pas labellisé tel quel. Renommer en "palette Star Wars" ou "palette impériale (rouge/noir/crème)". |
| D3 | `1-quarto-typst/index.qmd:53` — « 4 étapes principales » (`keep-typ` en bonus B1) | `1-quarto-typst/boussole.qmd:21-25` — **5 étapes** numérotées (étape 5 = `keep-typ`) | La boussole numérote `keep-typ` comme étape principale, la page exo en bonus séparé. Apprenant·e qui suit la boussole pense que `keep-typ` est obligatoire. |
| D4 | `1-quarto-typst/1-quarto-typst.qmd:206-212` (slide "Faisons ensemble") — **6 étapes** dont étape 6 = `keep-typ` | `1-quarto-typst/index.qmd:34-40` (page exo, "Our turn — démo live") — **5 étapes** | Possiblement volontaire mais clarifier : les 6 lignes slide 201-212 = items démo CD montre, ou consigne participant ? |
| D5 | `2-projets/index.qmd:56` — étape 2a annonce que `annexe-donnees` apparaît comme dernier chapitre numéroté | `2-projets/boussole.qmd:21-23` ne mentionne pas l'étape 2b (basculement annexe) | Boussole compresse 3 étapes alors que page exo distingue 2a/2b. Le découpage 2a/2b est essentiel pour comprendre chapitre/annexe. |
| D6 | `preparatifs.qmd:23` packages : `"quarto", "dplyr", "ggplot2", "ggrepel", "gt", "brand.yml", "prismatic"` | `exercises/02-projet-book/README.md:9` : `dplyr, ggplot2, ggrepel, gt, scales` | `scales` dans README, pas dans préparatifs. `prismatic` dans préparatifs, **0 hit** dans le repo. Aligner. |
| D7 | `2-projets/2-projets.qmd:74-77` (slide "Faisons ensemble") — **3 étapes** | `2-projets/index.qmd:55-58` — **4 étapes** (2a/2b séparées) | Slide simpler que page. OK si volontaire — slide = démo CD (3 étapes), page = exo (4 étapes pédagogiques). Acceptable. |
| D8 | `_charte/charte-starwars.qmd:14` (logo `width: 0.6in`, `padding: 0.4in`) | `2-projets/index.qmd:123-128`, `02-projet-book/correction/_quarto.yml:33-37` — mêmes valeurs | **Cohérent.** Config logo dans 3 endroits avec commentaire "sinon chevauche les titres" répété. Bonne DRY-violation pédagogique. |
| D9 | `2-projets/index.qmd:99-133` — modèle `_quarto.yml` complet inclut `logo:` custom | `2-projets/boussole.qmd:21-23` — étape 3 "Copier `_brand.yml` + logo + `_fonts/`" sans mention bloc `logo:` custom | Apprenant·e qui suit la boussole peut copier-coller et obtenir un logo qui chevauche les titres en page 2+. |
| D10 | `_charte/README.md:18-23` — pipeline manuel `cp charte-starwars.pdf` vers les 2 starters | Pas de script d'automatisation | Drift PDF future si modification de la charte sans `cp` manuel. |
| D11 | `1-quarto-typst/1-quarto-typst.qmd:233` mentionne `charte-starwars.pdf` dans le starter | `index.qmd` (page d'accueil) **ne mentionne pas** la nouveauté charte | Promesse "charte fournie" révélée tardivement (slide Your Turn). |
| D12 | `_charte/charte-starwars.pdf` visualisée : logo étoile jaune haut-gauche, titre rouge "CHARTE GRAPHIQUE", 4 swatches palette, 2 cellules typo, logo, footer méta | Aucun support web ne montre une **capture visuelle** (juste un lien vers le PDF) | L'apprenant·e qui parcourt le site avant le 16 juin ne sait pas à quoi ressemble la charte cible. Cf. `2-projets/index.qmd:241` qui inclut un PNG d'aperçu pour le tableau gt — même pattern manquant ici. |

## 4. Parcours utilisateur

### a) Débutant·e perdu·e pendant Your Turn (12 min, anxiété)

**Verdict : très bien outillé, peut-être trop.**

- **Rampe à 3 niveaux** bien pensée : (1) page exo tableau étape/résultat + indices doc collapse + escalier d'autonomie ; (2) boussole projetée à côté avec countdown + résumé étapes ; (3) correction GitHub.
- **Force** : la boussole est self-contained pour les 30 dernières secondes (relecture étape, countdown visible). Indices doc cliquables par étape (`1-quarto-typst/index.qmd:71-77`) = exactement ce qu'il faut.
- **Faiblesse 1** (D5/D9) : boussole exo 2 ne reflète pas 2a/2b ni le `logo:` custom. Débutant qui s'arrête à la boussole rate un détail frustrant.
- **Faiblesse 2** : les indices doc renvoient à des pages externes Quarto/brand-yml. Pendant 12 min, ouvrir une page Quarto et chercher un mot-clé = 3-4 min perdues. Idéalement, les indices devraient citer la **propriété YAML exacte attendue**, pas juste pointer la doc.
- **Faiblesse 3** : la charte est un PDF. L'apprenant·e doit l'ouvrir dans un viewer parallèle pour transcrire. Pas de version texte (CSV de couleurs ?) ni capture intégrée à la page exo.

### b) Retardataire (arrive à 9h45)

**Verdict : pas explicitement adressé. Trou.**

- Aucune mention dans `index.qmd` ou `preparatifs.qmd` de "comment rejoindre en cours".
- Le `_quarto-pretuto.yml` ne couvre qu'accueil + préparatifs. Personne en retard sans préparation n'a pas de point d'entrée "voici les 3 fichiers à télécharger maintenant".
- **Mitigation existante** : `2-projets/index.qmd:40-42` indique "Bloc 2 autonome vis-à-vis du Bloc 1". Bien. Mais pas d'équivalent inverse pour Bloc 1.
- **Reco** : section "Vous arrivez en cours ?" à l'accueil.

### c) Autodidacte après le 16 juin (consulte le site en juillet)

**Verdict : tient debout, quelques béquilles présentielles à neutraliser.**

- **Force** : `3-aller-plus-loin/index.qmd` annonce "pistes pour aller plus loin après le tutoriel, pas couvert en séance". Ton autodidacte-friendly posé.
- **Force** : `4-ressources.qmd` dense, bien structuré (doc officielle, blog posts, packages R, formats Typst).
- **Faiblesse** : boussoles avec `start_immediately=true` (`1-quarto-typst/boussole.qmd:12`, `2-projets/boussole.qmd:12`) sont étranges en consultation post : un visiteur voit un compte-à-rebours démarrer pour rien.
- **Faiblesse** : `::: notes` revealjs invisibles en HTML. Contenu pédagogique riche (workaround `opt_table_font`, choix Boba Fonts, Plan B offline) inaccessible aux autodidactes. Trade-off voulu.
- **Faiblesse** : les slides référencent "page boussole projetée à côté" — n'a pas de sens hors-contexte. Reformulation conditionnelle possible.
- **Force** : READMEs starter (`exercises/01-document-typst/starter/README.md:5`) pointent vers le site comme source unique. Bonne pratique single-source-of-truth.

### d) Pretuto (reçoit le lien avant le 16 juin)

**Verdict : minimaliste et lisible — propre.**

- `_quarto-pretuto.yml` ne rend que `index.qmd` + `preparatifs.qmd`. Bonne décision : pas de spoiler des slides.
- **Force** : `preparatifs.qmd` exemplaire — installation, packages, test end-to-end avec `test-install.qmd`, Plan B offline détaillé, troubleshooting.
- **Faiblesse** : `index.qmd:13-19` ("À propos") écrit comme page d'accueil de tutoriel actif. Pour pretuto, un encart "Vous êtes inscrit·e — préparez-vous via [Préparatifs]" en haut serait plus directif.
- **Faiblesse** : pas de checklist visuelle ("✓ R, ✓ Quarto 1.9+, ✓ packages, ✓ test-install rendu"). Tout est en prose.
- **Force** : `preparatifs.qmd:67-74` (Plan B sans réseau) prévient catastrophe wifi.
- **Asymétrie Plan B** : Plan B offline existe pour exo 1 (`_brand-offline.yml` avec Inter en local) **mais PAS pour exo 2**. Le starter exo 2 a `_fonts/` avec juste Starjedi ; `_brand-fallback.yml` réfère `source: google` pour Inter. En cas de réseau down pendant exo 2, l'apprenant·e devra copier Inter à la main depuis exo1/correction. Ni `preparatifs.qmd` ni README exo 2 ne l'explicitent. **Trou opérationnel.**

## 5. Risques globaux 16 juin

| Pri | Risque | Mitigation existante | Reste à faire |
|---|---|---|---|
| **P0** | **Quarto < 1.10.4 chez beaucoup de participants** : bug brand fonts en mode book (titres en serif au lieu de Star Jedi) | Workaround `font-paths` documenté `2-projets/index.qmd:138-153` + correction `_quarto.yml:27-29` | OK techniquement, mais ouvrir un collapse et appliquer le workaround = 3-5 min sur 12. Solution préventive : pré-vérifier en début de Our turn ("levez la main si `quarto --version` < 1.10.4"). |
| **P0** | **Réseau salle conférence flaky** : Inter (Google Fonts) ne charge pas | Plan B exo 1 : `_brand-offline.yml` + `_fonts/Inter-*.ttf`. **Pas de Plan B exo 2.** | Préparer `02-projet-book/_brand-offline.yml` + Inter dans `02-projet-book/_fonts/` *avant* le 16 juin. Mentionner dans `preparatifs.qmd`. |
| **P1** | **Bug `gt → Typst` espacement chiffres** Windows/macOS | Documenté slide notes (`1-quarto-typst.qmd:217`, `2-projets.qmd:86`), workaround `opt_table_font("Inter")` dans correction | OK. Mentionner brièvement, pas en panique. |
| **P1** | **Timing 12 min réaliste ?** Exo 1 = transcrire ~25 lignes de YAML depuis un PDF en 12 min (sans copy-paste si le PDF n'a pas de text-layer copiable) | Boussole + indices doc + escalier | **Test-run interne nécessaire**. Pour débutant·e c'est tendu. Reco : autoriser explicitement à copier le YAML depuis le PDF, ou fournir un squelette `_brand.yml` à compléter. |
| **P1** | **Dépendance `brand.yml` (package R)** dans corrections | `preparatifs.qmd:23` l'inclut, README exo 2 le marque optionnel pour Bonus 4 | Correction exo 1 (`rapport-starwars.qmd:32`) l'utilise sans préciser que c'est optionnel pour le starter. Clarifier. |
| **P2** | **Boussole en mode countdown autonome** : si rafraîchissement de la page, countdown redémarre à 12:00 | Aucune | Pas critique, frustrant. localStorage possible. |
| **P2** | **PDF charte ouvert en parallèle** : viewer PDF lent → friction | Aucune | Vérifier que la page exo 1 propose `<iframe>` ou lien direct embed pour éviter l'aller-retour. |
| **P2** | **Charte distribuée 2× (starter exo1 + starter exo2) — drift de version** | Pipeline manuel `cp` documenté `_charte/README.md:18-23` | Soit `scripts/sync-charte.sh`, soit hook git. |
| **P2** | **Slide "Faisons ensemble" exo 1 (D4)** : 6 étapes risque de perdre des gens en démo | Notes speaker | À tester : peut-être réduire à 4 grandes étapes visuelles. |

## 6. Recommandations prioritaires

1. **Aligner timing 12 min partout** (D1). Fichier : `exercises/01-document-typst/README.md:3`. 5 min de boulot, vrai impact sur l'anxiété participant·e (lire "15" puis voir 12:00 = stress inutile).
2. **Ajouter un Plan B offline pour exo 2** (P0/réseau). Créer `exercises/02-projet-book/_brand-offline.yml` + copier `Inter-*.ttf` dans `exercises/02-projet-book/_fonts/`. Mentionner dans `preparatifs.qmd:67-74` que le Plan B couvre les 2 exos.
3. **Section "Vous arrivez en cours ?" à l'accueil** (`index.qmd`). 5-6 lignes : lien starter zip, lien boussole en cours, mention "Bloc 2 autonome". Sert aussi retardataires et autodidactes.
4. **Boussole exo 2 doit refléter étapes 2a/2b et mentionner le bloc `logo:` custom** (D5, D9). Sinon livre avec logo qui chevauche les titres en page 2+. Ajouter 1-2 lignes dans `2-projets/boussole.qmd:21-23`.
5. **Aperçu visuel de la charte sur la page exo 1** (D12). `<iframe>` qui embed `charte-starwars.pdf` directement dans `1-quarto-typst/index.qmd`, ou capture PNG miniature. La charte est le support central de l'exo, mérite d'être visible sans téléchargement, surtout pour la persona pretuto.

### Bonus si temps

- Script `scripts/sync-charte.sh` pour automatiser le `cp` (D10).
- Renommer "palette Empire" en `01-document-typst/README.md:16` (D2).
- Checklist visuelle en tête de `preparatifs.qmd`.
- Retirer `prismatic` de `preparatifs.qmd:23` (0 hit) ; ajouter `scales`.

## Annexe — Ce que j'ai vérifié

- Parcours complet dans l'ordre : `index.qmd` → `preparatifs.qmd` → `1-quarto-typst/{1-quarto-typst.qmd, index.qmd, boussole.qmd}` → READMEs starter+correction exo1 → `2-projets/{2-projets.qmd, index.qmd, boussole.qmd}` → READMEs starter+correction exo2 → `3-aller-plus-loin/index.qmd` → `4-ressources.qmd`.
- Charte : `_charte/charte-starwars.qmd` + PDF rendu (visualisé) + `_brand.yml` + `_logo-sw.svg` + `_fonts/Starjedi.ttf` + `README.md`.
- Profils : `_quarto.yml`, `_quarto-tuto.yml`, `_quarto-pretuto.yml`.
- **Diffs verrou charte** : `_charte/_brand.yml` ≡ `01-document-typst/correction/_brand.yml` ≡ `02-projet-book/_brand-fallback.yml` (byte-for-byte, vérifié par `diff`).
- Corrections exo 1 et 2 (toutes les `.qmd`).
- Cohérence packages R, timings, références croisées slides ↔ pages ↔ boussoles.
- Variantes brand exo 2 : empire, jedi, mando.

## Annexe — Ce que je n'ai PAS regardé (laissé aux autres agents)

- Qualité du français, typo, accents (agent `workshop-reviewer-fr`).
- Correctness technique Quarto/Typst code (agent `workshop-reviewer-technique`).
- Posture pédagogique micro-niveau (agent `workshop-reviewer-pedagogue`).
- Vécu débutant·e détaillé (agent `workshop-reviewer-debutant`).
- Build effectif (pas lancé `quarto render` ; trust git state).
