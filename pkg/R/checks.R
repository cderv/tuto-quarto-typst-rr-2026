# Vérifications unitaires (internes). Chacune affiche un message cli et renvoie
# un logique (TRUE = OK). Orchestrées par verifier_installation().
#
# Lexique cli figé : succès = cli_alert_success (✓), info = cli_alert_info (ℹ),
# avertissement = cli_alert_warning (⚠), erreur = cli_alert_danger (✗).
#
# NB : on copie les constantes `.xxx` dans des variables locales sans point avant
# de les interpoler, car `{.nom}` collisionne avec la syntaxe de balise cli.

# R ------------------------------------------------------------------------------
verifier_r <- function() {
  v <- getRversion()
  seuil <- .seuil_r
  if (v >= seuil) {
    cli::cli_alert_success("R {v} : version compatible (>= {seuil}).")
    return(TRUE)
  }
  cli::cli_alert_danger(c(
    "R {v} trop ancien (>= {seuil} requis). ",
    "Installez un R 4 récent : {.url https://cran.r-project.org}."
  ))
  FALSE
}

# Quarto -------------------------------------------------------------------------
verifier_quarto <- function() {
  url_quarto <- .url_quarto
  qmin <- .quarto_min
  qreco <- .quarto_reco

  chemin <- tryCatch(quarto::quarto_path(), error = function(e) NULL)
  if (is.null(chemin) || !nzchar(chemin) || !file.exists(chemin)) {
    cli::cli_alert_danger(c(
      "Quarto introuvable. Installez-le ({.url {url_quarto}}) ; ",
      "RStudio récent l'inclut déjà."
    ))
    return(FALSE)
  }
  v <- tryCatch(quarto::quarto_version(), error = function(e) NA)
  if (length(v) != 1 || is.na(v)) {
    cli::cli_alert_danger(
      "Quarto détecté mais version illisible. Diagnostic : {.run quarto::quarto_binary_sitrep(debug = TRUE)}."
    )
    return(FALSE)
  }
  if (v < qmin) {
    cli::cli_alert_danger(c(
      "Quarto {v} trop ancien (>= {qmin} requis). ",
      "Mettez à jour : {.url {url_quarto}}."
    ))
    return(FALSE)
  }
  if (v < qreco) {
    cli::cli_alert_warning(c(
      "Quarto {v} : fonctionne pour le tutoriel. ",
      "À l'exercice 2, une petite manipulation (font-paths) vous sera indiquée à l'écran."
    ))
    return(TRUE)
  }
  cli::cli_alert_success("Quarto {v} : version recommandée.")
  TRUE
}

# Paquets R ----------------------------------------------------------------------
verifier_paquets <- function() {
  requis <- .paquets_requis
  presents <- vapply(requis, rlang::is_installed, logical(1))
  manquants <- requis[!presents]
  if (length(manquants) == 0) {
    cli::cli_alert_success(
      "Paquets R : les {length(requis)} prérequis sont installés."
    )
    return(TRUE)
  }
  cli::cli_alert_danger("Paquets R manquants : {.pkg {manquants}}.")
  code <- sprintf(
    "install.packages(c(%s))",
    paste0('"', manquants, '"', collapse = ", ")
  )
  cli::cli_alert_info("Installez-les : {.code {code}}")
  cli::cli_alert_info("Puis relancez {.run tutotypst::verifier_installation()}.")
  FALSE
}

# Rendu de test (chaîne R -> Quarto -> Typst -> gt -> ggplot) ---------------------
# Ne valide PAS la chaîne brand fonts (00-test-install est un format: typst nu).
verifier_rendu <- function(tester_rendu = TRUE) {
  if (!isTRUE(tester_rendu)) {
    cli::cli_alert_info("Rendu de test ignoré ({.code tester_rendu = FALSE}).")
    return(NA)
  }
  if (!rlang::is_installed("quarto")) {
    cli::cli_alert_warning("Paquet {.pkg quarto} absent : rendu de test sauté.")
    return(NA)
  }
  src <- file.path(.dossier_exercices_paquet(), "00-test-install")
  qmd <- file.path(src, "test-install.qmd")
  if (!file.exists(qmd)) {
    cli::cli_alert_warning("Fichier de test introuvable dans le paquet : rendu sauté.")
    return(NA)
  }
  tmp <- tempfile("tutotypst-test-")
  dir.create(tmp)
  on.exit(unlink(tmp, recursive = TRUE), add = TRUE)
  file.copy(qmd, file.path(tmp, "test-install.qmd"), copy.mode = FALSE)

  res <- tryCatch(
    withr::with_dir(tmp, {
      quarto::quarto_render("test-install.qmd", quiet = TRUE)
      TRUE
    }),
    error = function(e) e
  )
  # On vérifie précisément le PDF attendu (pas n'importe quel .pdf intermédiaire).
  if (file.exists(file.path(tmp, "test-install.pdf"))) {
    cli::cli_alert_success(
      "Rendu de test réussi : PDF produit (chaîne R → Quarto → Typst → gt → ggplot OK)."
    )
    return(TRUE)
  }
  cli::cli_alert_danger("Le rendu de test n'a produit aucun PDF.")
  if (inherits(res, "error")) {
    cli::cli_alert_info("Détail : {conditionMessage(res)}")
  }
  cli::cli_alert_info("Pour décoder l'erreur : {.run tutotypst::diagnostiquer_rendu()}.")
  FALSE
}
