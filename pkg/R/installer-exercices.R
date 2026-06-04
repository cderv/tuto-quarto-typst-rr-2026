#' Installer les exercices du tutoriel
#'
#' Copie les fichiers de départ (« starters ») des exercices, embarqués dans le
#' paquet, vers un dossier de travail local. Seuls les `starter/` sont copiés :
#' les corrections restent en ligne sur le site du tutoriel.
#'
#' @param dest Chemin du dossier de destination (créé si besoin). Par défaut
#'   `"exercices-typst"` dans le répertoire de travail courant.
#' @param quels Quels exercices installer : `"tous"` (défaut), `"01"`
#'   (document Typst) ou `"02"` (projet livre).
#' @param force Logique. Écraser un dossier de destination déjà existant et non
#'   vide ? Par défaut `FALSE`.
#'
#' @return Invisiblement, le chemin absolu du dossier de destination.
#' @export
#'
#' @examplesIf interactive()
#' installer_exercices()
#' installer_exercices(quels = "01")
installer_exercices <- function(dest = "exercices-typst",
                                quels = c("tous", "01", "02"),
                                force = FALSE) {
  quels <- match.arg(quels)
  src_root <- .dossier_exercices_paquet()

  exos <- switch(quels,
    "tous" = c("00-test-install", "01-document-typst", "02-projet-book"),
    "01" = "01-document-typst",
    "02" = "02-projet-book"
  )

  dest_abs <- xfun::normalize_path(dest)
  if (dir.exists(dest_abs) && length(list.files(dest_abs)) > 0 && !isTRUE(force)) {
    cli::cli_abort(c(
      "Le dossier {.path {dest_abs}} existe déjà et n'est pas vide.",
      "i" = "Relancez avec {.code force = TRUE}, ou choisissez un autre {.arg dest}."
    ))
  }
  dir.create(dest_abs, recursive = TRUE, showWarnings = FALSE)

  for (exo in exos) {
    .copier_dossier(file.path(src_root, exo), file.path(dest_abs, exo))
  }

  # --- message d'orientation ---------------------------------------------------
  intentions <- .exos
  cli::cli_h2("Exercices installés")
  cli::cli_alert_success("Dossier : {.path {dest_abs}}")
  cli::cli_text("Contenu :")
  cli::cli_ul()
  for (exo in exos) {
    cli::cli_li("{.strong {exo}} : {intentions[[exo]]}")
  }
  cli::cli_end()

  if ("01-document-typst" %in% exos) {
    depart <- file.path(dest_abs, "01-document-typst", "starter", "rapport-starwars.qmd")
    cli::cli_alert_info("Pour démarrer, ouvrez {.path {depart}}.")
  }
  cli::cli_alert_info(
    "Astuce RStudio : double-cliquez le fichier {.path .Rproj} d'un dossier {.path starter/} pour ouvrir l'exercice comme projet (répertoire de travail correct)."
  )
  cli::cli_alert_warning(
    "N'ouvrez pas les dossiers {.path correction/} (en ligne) avant le tutoriel."
  )
  cli::cli_alert_info(
    "Sans réseau le jour J ? {.run tutoquartotypst::basculer_hors_ligne()} passe un exercice en polices locales."
  )
  cli::cli_alert_info(
    "Vous avez cassé un fichier ? {.run tutoquartotypst::reinitialiser_exercice()} le restaure."
  )

  .ouvrir_dossier(dest_abs)
  invisible(dest_abs)
}

#' Réinitialiser un exercice à son état de départ
#'
#' Restaure le `starter/` d'un exercice (depuis la copie embarquée dans le
#' paquet) lorsque vous avez cassé vos fichiers. Votre dossier actuel est
#' **sauvegardé** (jamais supprimé) avant d'être remplacé.
#'
#' @param quel Quel exercice réinitialiser : `"01"` (défaut), `"02"` ou `"00"`
#'   (le test d'installation).
#' @param dossier Dossier où les exercices ont été installés (le `dest` de
#'   [installer_exercices()]). Par défaut `"exercices-typst"`.
#' @param force Logique. Réinitialiser sans confirmation interactive ? Par
#'   défaut `FALSE` (en mode non-interactif, `force = TRUE` est requis).
#'
#' @return Invisiblement, le chemin du dossier réinitialisé, ou `NULL` si
#'   l'opération a été annulée.
#' @export
#'
#' @examplesIf interactive()
#' reinitialiser_exercice("01")
reinitialiser_exercice <- function(quel = c("01", "02", "00"),
                                   dossier = "exercices-typst",
                                   force = FALSE) {
  quel <- match.arg(quel)
  exo <- .exo_dossier(quel)
  src <- file.path(.dossier_exercices_paquet(), exo)
  cible <- file.path(xfun::normalize_path(dossier), exo)

  sauvegarde <- NULL
  if (dir.exists(cible)) {
    confirme <- .confirmer(
      sprintf("Réinitialiser l'exercice %s ? Votre dossier sera d'abord sauvegardé.", exo),
      force = force
    )
    if (!confirme) {
      if (!rlang::is_interactive()) {
        cli::cli_abort(c(
          "Réinitialisation annulée (mode non-interactif).",
          "i" = "Relancez avec {.code force = TRUE} pour confirmer."
        ))
      }
      cli::cli_alert_info("Réinitialisation annulée.")
      return(invisible(NULL))
    }
    horodatage <- format(Sys.time(), "%Y%m%d-%H%M%S")
    sauvegarde <- paste0(cible, "-sauvegarde-", horodatage)
    # Suffixe unique si une sauvegarde du même horodatage existe déjà.
    n <- 1L
    while (file.exists(sauvegarde)) {
      sauvegarde <- paste0(cible, "-sauvegarde-", horodatage, "-", n)
      n <- n + 1L
    }
    file.rename(cible, sauvegarde)
    cli::cli_alert_info("Ancien dossier sauvegardé : {.path {sauvegarde}}")
  }

  dir.create(cible, recursive = TRUE, showWarnings = FALSE)
  .copier_dossier(src, cible)
  cli::cli_alert_success(
    "Exercice {exo} réinitialisé à l'état de départ : {.path {cible}}"
  )
  if (!is.null(sauvegarde)) {
    cli::cli_alert_info("Votre travail précédent reste dans {.path {sauvegarde}}.")
  }
  invisible(cible)
}
