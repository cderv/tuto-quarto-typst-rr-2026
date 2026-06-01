#' Lister les exercices du tutoriel
#'
#' Affiche les exercices disponibles avec, pour chacun, son intention. Sert à
#' s'orienter ; ne dévoile pas les étapes de résolution.
#'
#' @return Invisiblement, les codes des exercices (`character`).
#' @export
#'
#' @examples
#' lister_exercices()
lister_exercices <- function() {
  intentions <- .exos
  cli::cli_h2("Exercices du tutoriel")
  cli::cli_ul()
  for (exo in names(intentions)) {
    cli::cli_li("{.strong {exo}} : {intentions[[exo]]}")
  }
  cli::cli_end()
  cli::cli_alert_info(
    "Rappel : n'ouvrez pas les dossiers {.path correction/} (en ligne) avant le tutoriel."
  )
  invisible(names(intentions))
}

#' Par où commencer ?
#'
#' Boussole : détecte l'état de votre préparation (paquets, Quarto, exercices
#' installés) et indique la prochaine action à effectuer. En cas de doute,
#' c'est la fonction à lancer.
#'
#' @param dossier Dossier où chercher les exercices installés. Par défaut
#'   `"exercices-typst"`.
#'
#' @return Invisiblement, un mot-clé de l'étape courante (`character`).
#' @export
#'
#' @examples
#' par_ou_commencer()
par_ou_commencer <- function(dossier = "exercices-typst") {
  cli::cli_h2("Par où commencer ?")

  quarto_ok <- !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL))
  paquets_ok <- all(vapply(.paquets_requis, rlang::is_installed, logical(1)))
  exos_installes <- dir.exists(dossier) &&
    length(list.files(dossier, recursive = TRUE)) > 0

  if (!quarto_ok || !paquets_ok) {
    cli::cli_alert_warning("Votre environnement n'est pas encore complet.")
    cli::cli_alert_info(
      "Lancez {.run tutoquartotypst::verifier_installation()} pour le diagnostic."
    )
    return(invisible("verifier"))
  }

  if (!exos_installes) {
    cli::cli_alert_success("Environnement prêt.")
    cli::cli_alert_info(
      "Prochaine étape : {.run tutoquartotypst::installer_exercices()}."
    )
    return(invisible("installer"))
  }

  cli::cli_alert_success("Tout est en place, exercices installés dans {.path {dossier}}.")
  depart <- file.path(dossier, "01-document-typst", "starter", "rapport-starwars.qmd")
  cli::cli_alert_info("Ouvrez {.path {depart}} pour démarrer.")
  cli::cli_alert_info("Vue d'ensemble : {.run tutoquartotypst::lister_exercices()}.")
  invisible("demarrer")
}
