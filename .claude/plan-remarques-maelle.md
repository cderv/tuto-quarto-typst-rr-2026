# Plan d'attaque — Remarques Maëlle

Source : https://docs.google.com/document/d/1a97itHue_stpNbtQrLZ3ntl7f9UBl_7uI1QApdEEU6s/edit

> Statut : traité sur la branche `claude/upbeat-newton-VG1K5` (2026-06-05). Voir notes par item.

---

## ✅ Corrections triviales (rapide, sans réflexion)

- [x] `preparatifs.qmd` : "Plancher" → "version minimale" (wording)
- [x] `preparatifs.qmd` : "Dernière version RStudio" → précisé **RStudio `2026.05`+**
- [x] `preparatifs.qmd` : ajouté **Positron `2026.05`+** (note : Positron embarque Quarto 1.9 ; pour la pre-release reco, installer Quarto à part / régler `quarto.path`)
- [x] Message "ouvrir RStudio le jour J" → **RStudio ou Positron** (exemple `preparatifs.qmd` + code `pkg/R/verifier-installation.R` + snapshot)
- [x] Lien ouverture plein écran des slides → `{target="_blank"}` (les deux `index.qmd`)
- [x] Slides Bloc 1 : **slide « ☕ Pause »** ajoutée en fin de deck (annonce durée + reprise + réutilisation du `_brand.yml`)
- [~] Lien répétitif vers la page courante : **PARTIE FAITE** = lien boussole ajouté dans la section exercice des deux `index.qmd`. **À CONFIRMER** : je n'ai pas identifié avec certitude le « truc répétitif avec lien vers la page courante » à supprimer (aucun self-link littéral trouvé ; les boussoles pointent vers `index.qmd`, pas vers elles-mêmes). → préciser ce qui doit sauter exactement.
- [x] Slides Bloc 2 : slide `_quarto.yml` → **arborescence** ajoutée (colonnes YAML + arbre du projet)

---

## 🔧 Corrections non triviales (réflexion ou restructuration)

- [x] `preparatifs.qmd` : gros chunk éclaté en **3 chunks** (installer / vérifier / installer_exercices) + commentaires transformés en prose
- [x] `preparatifs.qmd` : flow d'installation — **décision : ordre actuel conservé** (Quarto/IDE prérequis d'abord, puis paquet qui tire les paquets R, puis vérif, puis exos). Pas de Tinytex (inutile pour Typst).
- [x] `installer_exercices()` : annonce la **destination** + **demande confirmation** avant copie (`force = TRUE` pour scripts/non-interactif). Tests + `.Rd` + doc préparatifs mis à jour.
- [x] Slides Bloc 1 : exemple `_brand.yml` (couleur unique) **rendu visible** sur la slide « Faisons ensemble » (plus besoin de revenir en arrière)
- [x] Slides Bloc 2 « Construisons un livre ensemble » : part explicitement du `starter/`, **YAML complet à copier-coller** (plus d'accolades inline), **comment rendre** un projet (`quarto render` à la racine / bouton Render). Accolades retirées aussi sur `2-projets/index.qmd`.

---

## 🔍 À investiguer

- [ ] **Bug install r-universe** (`package 'tutoquartotypst' is not available`) — **NON TRAITÉ** (dépôt privé, attendu).
- [x] **Bug re-render `_brand.yml`** : workaround documenté (pas de fix Quarto dédié connu). Cause n°1 = **PDF ouvert dans un lecteur qui verrouille le fichier** (fréquent Windows) → fermer le lecteur / supprimer le `.pdf` ; cause n°2 = cache → supprimer `.pdf` voire `.quarto/`. Documenté côté speaker (`demo-bloc1`) + note participant (`1-quarto-typst/index.qmd`).
- [x] **Erreur `quarto render` sans `_quarto.yml`** : **reproduit sur Quarto 1.9.36** → ce n'est PAS « No valid input files », c'est un **no-op silencieux** (exit 0, rien produit). Conséquence : la démo Bloc 2 faisait `quarto render` *avant* `_quarto.yml` en annonçant « 5 HTML » (faux) → **corrigé** (baseline cible `index.qmd` explicitement + piège documenté). Note participant ajoutée sur `2-projets/index.qmd`.

---

## 💬 Décisions à prendre

- [x] **Étape HTML→Typst sans brand** : **décision = consigne explicite dans l'exo**. Ajout d'un encadré « Commencez par l'étape 1 seule » sur `1-quarto-typst/index.qmd` (basculer `format: typst` et rendre soi-même AVANT `_brand.yml`).
- [x] **Corrections non distribuées** : **décision = documenter `ouvrir_correction()`**. Note ajoutée dans `preparatifs.qmd` (corrections pas copiées en local par choix ; en ligne ou via `tutoquartotypst::ouvrir_correction("01"/"02")`).
- [x] **Timing exo 2** : **décision = allonger à 15 min**. Propagé partout (boussole 2, `2-projets/index.qmd`, slides, demo-bloc2, chronogramme `pilotage.qmd` recalculé : Exo 2 11h17→15 min, buffer final ramené à ~9 min).
