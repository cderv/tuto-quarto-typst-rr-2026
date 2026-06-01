# diagnostiquer_rendu() : liste des cas connus (sortie stable)

    Code
      diagnostiquer_rendu()
    Message
      
      -- Erreurs de rendu fréquentes --
      
      * Typst introuvable (bloquant) : Quarto < 1.9 (Typst absent). Mettez Quarto à
      jour (>= 1.9).
      * Police inconnue (bénin) : Avertissement de police : normal pour le test (il
      n'utilise pas _brand.yml). Le PDF est produit avec une police de repli. Rien à
      corriger.
      * Fichier _brand.yml introuvable (bloquant) : Vérifiez que _brand.yml est bien
      à côté de votre .qmd.
      * Erreur de syntaxe YAML (bloquant) : Vérifiez l'indentation de l'en-tête ---
      ou de _quarto.yml.
      i Passez le texte de votre erreur (entre guillemets simples) : `diagnostiquer_rendu('...')`.

# diagnostiquer_rendu() : avertissement de police (bénin)

    Code
      diagnostiquer_rendu("Error: unknown font family 'Inter'")
    Message
      v Police inconnue : Avertissement de police : normal pour le test (il n'utilise pas _brand.yml). Le PDF est produit avec une police de repli. Rien à corriger.

# lister_exercices() : sortie stable

    Code
      lister_exercices()
    Message
      
      -- Exercices du tutoriel --
      
      * 00-test-install : Test express : rendre un mini-PDF pour valider la chaîne.
      * 01-document-typst : Votre premier PDF Typst : convertir un rapport en
      `format: typst`.
      * 02-projet-book : Un livre Typst personnalisé avec une charte (`_brand.yml`).
      i Rappel : n'ouvrez pas les dossiers 'correction/' (en ligne) avant le tutoriel.

# exporter_diagnostic() : structure stable (valeurs masquées)

    Code
      exporter_diagnostic()
    Output
      Diagnostic tutotypst <date>
      
      R      : <R>
      OS     : <OS>
      Quarto : <quarto>
        chemin: <path>
      
      Paquets requis :
        - quarto : <version>
        - dplyr : <version>
        - ggplot2 : <version>
        - ggrepel : <version>
        - gt : <version>
        - scales : <version>
        - brand.yml : <version>
        - prismatic : <version>
      
    Message
      i Copiez-collez le texte ci-dessus pour demander de l'aide.

# verifier_installation() : rapport stable (version R masquée)

    Code
      verifier_installation(tester_rendu = FALSE)
    Message
      
      -- Vérification de votre installation ------------------------------------------
      v R <version> : version compatible (>= 4.1.0).
      v Quarto 1.10.4 : version recommandée.
      v Paquets R : les 8 prérequis sont installés.
      i Rendu de test ignoré (`tester_rendu = FALSE`).
      
      -- Bilan --
      
      v R
      v Quarto
      v Paquets R
      ! Rendu PDF de test
      v Tout est prêt : .qmd → PDF pro → livre → à personnaliser. Rendez-vous le 16 juin !
      i Le jour J, pensez à ouvrir RStudio (récent).
      i Prochaine étape : installez les exercices avec `tutotypst::installer_exercices()`.

