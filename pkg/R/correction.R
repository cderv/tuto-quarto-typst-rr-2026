# Lot 3 — accès aux corrections (après l'effort) et export de diagnostic.

.url_repo <- "https://github.com/cderv/cderv-tuto-quarto-typst-rr-2026"

#' Ouvrir la correction d'un exercice (en ligne)
#'
#' Ouvre, **en ligne** sur GitHub, le dossier `correction/` d'un exercice. Les
#' corrections ne sont volontairement pas installées en local : elles sont plus
#' utiles **après** avoir cherché par vous-même. Une confirmation est demandée.
#'
#' @param quel `"01"` (défaut) ou `"02"`.
#' @param je_confirme Logique. Passer la confirmation (utile en script). Défaut
#'   `FALSE`.
#'
#' @return Invisiblement, l'URL de la correction, ou `NULL` si annulé.
#' @export
#'
#' @examplesIf interactive()
#' ouvrir_correction("01")
ouvrir_correction <- function(quel = c("01", "02"), je_confirme = FALSE) {
  quel <- match.arg(quel)
  exo <- .exo_dossier(quel)
  url <- sprintf("%s/tree/main/exercises/%s/correction", .url_repo, exo)

  ok <- isTRUE(je_confirme) || .confirmer(
    "Ouvrir la correction en ligne ? (elle est plus utile une fois que vous avez essayé)"
  )
  if (!ok) {
    cli::cli_alert_info("Annulé — réessayez l'exercice d'abord, la correction n'ira nulle part.")
    return(invisible(NULL))
  }
  cli::cli_alert_info("Correction en ligne : {.url {url}}")
  if (rlang::is_interactive()) {
    try(utils::browseURL(url), silent = TRUE)
  }
  invisible(url)
}

#' Exporter un diagnostic d'installation dans un fichier
#'
#' Affiche un résumé de votre environnement (R, Quarto, paquets) dans la console,
#' à copier-coller si vous demandez de l'aide. Peut aussi l'écrire dans un fichier.
#'
#' @param fichier Chemin d'un fichier où écrire **aussi** le diagnostic. Par
#'   défaut `NULL` : affichage console uniquement (rien à ouvrir).
#'
#' @return Invisiblement, les lignes du diagnostic.
#' @export
#'
#' @examples
#' exporter_diagnostic()
exporter_diagnostic <- function(fichier = NULL) {
  qpath <- tryCatch(quarto::quarto_path(), error = function(e) NA_character_)
  qver <- tryCatch(as.character(quarto::quarto_version()), error = function(e) NA_character_)
  presents <- vapply(.paquets_requis, function(p) {
    if (rlang::is_installed(p)) as.character(utils::packageVersion(p)) else "ABSENT"
  }, character(1))

  os <- tryCatch(utils::osVersion, error = function(e) NULL)
  if (is.null(os)) os <- Sys.info()[["sysname"]]

  lignes <- c(
    paste("Diagnostic tutoquartotypst —", format(Sys.time())),
    "",
    paste("R      :", R.version.string),
    paste("OS     :", os),
    paste("Quarto :", qver),
    paste("  chemin:", qpath),
    "",
    "Paquets requis :",
    paste0("  - ", names(presents), " : ", presents)
  )
  # Affichage console : copier-coller direct, sans ouvrir de fichier.
  cat(lignes, sep = "\n")
  cat("\n")
  if (!is.null(fichier)) {
    xfun::write_utf8(lignes, fichier)
    cli::cli_alert_success("Diagnostic aussi écrit : {.path {xfun::normalize_path(fichier)}}")
  }
  cli::cli_alert_info("Copiez-collez le texte ci-dessus pour demander de l'aide.")
  invisible(lignes)
}
