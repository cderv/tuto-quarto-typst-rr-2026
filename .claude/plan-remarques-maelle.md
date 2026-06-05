# Plan d'attaque — Remarques Maëlle

Source : https://docs.google.com/document/d/1a97itHue_stpNbtQrLZ3ntl7f9UBl_7uI1QApdEEU6s/edit

---

## ✅ Corrections triviales (rapide, sans réflexion)

- [ ] `preparatifs.qmd` : "Plancher" → "version minimale" (wording)
- [ ] `preparatifs.qmd` : "Dernière version RStudio" → préciser le numéro/date
- [ ] `preparatifs.qmd` : Ajouter version minimale Positron
- [ ] `preparatifs.qmd` : Message "ouvrir RStudio le jour J" → ajouter Positron
- [ ] Le lien d'ouverture des slides dans les 'index.qmd' Lien ouverture plein écran doit ouvrir dans nouvel onglet. Ajouter l'attribut.
- [ ] Slides Bloc 1 : Ajouter indication de pause sur les diapos 
   - Action: Ajouter un slide en fin de Bloc 1 pour annoncer. 
- [ ] Localiser et supprimer le truc répétitif avec lien vers la page courante dans les descriptions d'exercices
   - dans les 'index.qmd' adapter la partie exercice en fonction des nouvelles pages 'boussoles.qmd'
- [ ] Slides Bloc 2 : Slide `_quarto.yml` → ajouter exemple d'arborescence

---

## 🔧 Corrections non triviales (réflexion ou restructuration)

- [ ] `preparatifs.qmd` : Séparer le gros code chunk en 3 chunks distincts, transformer les commentaires en texte réel entre les chunks
- [ ] `preparatifs.qmd` : Réordonner le flow d'installation :
      1. Installer `tutoquartotypst`
      2. Installer Quarto / Tinytex / etc.
      3. Vérifier avec le paquet
      4. Installer autres paquets R via le paquet
- [ ] `preparatifs.qmd` : `installer_exercices()` — préciser la destination des fichiers + demander confirmation avant téléchargement
   - A voir les adaptations à faire au package R lui même. 
- [ ] Slides Bloc 1 : Lors de l'exercice `_brand.yml` couleur unique,
      s'assurer qu'un exemple de `_brand.yml` est visible sur la slide (ou juste avant) sans avoir à revenir en arrière
   - ou voir pour un starter dans les fichiers d'exo ? 
- [ ] Slides Bloc 2 : Slide "Construisons un livre ensemble" —
      - Rappeler explicitement qu'on part du dossier starter
      - Fournir le YAML `_quarto.yml` complet à copier-coller (pas juste les accolades)
      - Montrer comment faire le render d'un dossier book
      - Idem sur la page `2-projets/index.html` (accolades perturbantes)

---

## 🔍 À investiguer

- [ ] **Bug install r-universe** : erreur `package 'tutoquartotypst' is not available`
      - NE PAS ENCORE TRAITER - c'est parceque le dépot est privé.

- [ ] **Bug re-render `_brand.yml`** : doit supprimer le PDF avant re-render après modification du fichier. Vérifier si c'est un bug Quarto connu, ou lié au cache. Workaround à documenter si pas de fix dispo.
- [ ] **Erreur `quarto_render("starter/")` sans `index.qmd`** :
      confirmer que le message d'erreur est bien "No valid input files" et
      décider si on documente le comportement attendu sur la slide Our Turn
      (spécifier `index.qmd` explicitement ou non)

---

## 💬 Décisions à prendre

- [ ] **Étape HTML→Typst sans brand** : Maëlle voudrait un mini-exercice
      "changez html en typst, rendez" *avant* d'introduire `_brand.yml`.
      - On en parle de My turn il me semble. Ajouter une consigne dans l'exercice pour refaire soi même ? Ou autre ? 

- [ ] **Les corrections ne sont pas distribuées** (`installer_exercices`) :
      choix délibéré ? Si oui, le documenter clairement dans les prérequis
      (les participants peuvent les trouver en ligne mais ne les ont pas en local)
   - Normallement c'est accessible dans le package. Donc documenter l'usage de `ouvrir_correction()`

- [ ] **Timing exo 2** : 12 min pour polices + logo jugé insuffisant par Maëlle.
      → Réduire le scope de l'exo 2, ou allonger le temps alloué ?
      → Impact sur le timing global du workshop ?
   - A réétudier
