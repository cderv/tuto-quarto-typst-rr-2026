# Lot 3 — accès aux corrections (après l'effort) et export de diagnostic.

.url_repo <- "https://github.com/cderv/tuto-quarto-typst-rr-2026"

#' Ouvrir la correction d'un exercice (en ligne)
#'
#' Ouvre, **en ligne** sur GitHub, le dossier `correction/` d'un exercice. Les
#' corrections ne sont volontairement pas posées par [installer_exercices()] :
#' elles sont plus utiles **après** avoir cherché par vous-même. Une confirmation
#' est demandée. Pour en obtenir une **copie locale à retravailler**, voir
#' [recuperer_correction()].
#'
#' @param quel `"01"` (défaut) ou `"02"`.
#' @param je_confirme Logique. Passer la confirmation (utile en script). Défaut
#'   `FALSE`.
#'
#' @return Invisiblement, l'URL de la correction, ou `NULL` si annulé.
#' @seealso [recuperer_correction()] pour copier la correction en local.
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

#' Récupérer la correction d'un exercice en local
#'
#' Copie les **sources** de la correction d'un exercice (embarquées dans le
#' paquet) vers un dossier de travail local, pour la **retravailler** après coup.
#' Comme [ouvrir_correction()], une confirmation est demandée : une correction
#' est plus utile une fois que vous avez cherché par vous-même.
#'
#' Par défaut, la correction est posée à côté du `starter/` correspondant (dans
#' `exercices-typst/<exercice>/correction/`), ce qui reproduit l'arborescence du
#' dépôt. Aucun artefact de rendu n'est embarqué : pour obtenir le PDF / livre,
#' rendez la correction avec `quarto render`.
#'
#' @param quel `"01"` (défaut) ou `"02"`.
#' @param dest Dossier de travail où poser la correction (créé si besoin). Par
#'   défaut `"exercices-typst"` — la correction atterrit alors dans
#'   `exercices-typst/<exercice>/correction/`, à côté du `starter/`.
#' @param force Logique. Passer la confirmation **et** écraser une correction
#'   déjà copiée et non vide ? Par défaut `FALSE` (en mode non-interactif,
#'   `force = TRUE` est requis pour confirmer la copie).
#'
#' @return Invisiblement, le chemin du dossier de correction copié, ou `NULL` si
#'   annulé.
#' @export
#'
#' @examplesIf interactive()
#' recuperer_correction("01")
recuperer_correction <- function(quel = c("01", "02"),
                                 dest = "exercices-typst",
                                 force = FALSE) {
  quel <- match.arg(quel)
  exo <- .exo_dossier(quel)
  src <- file.path(.dossier_exercices_paquet(), exo, "correction")
  if (!dir.exists(src)) {
    cli::cli_abort(c(
      "Correction introuvable dans le paquet pour l'exercice {.val {quel}}.",
      "i" = "Réinstallation du paquet nécessaire ?"
    ))
  }

  cible <- file.path(xfun::normalize_path(dest), exo, "correction")
  if (dir.exists(cible) && length(list.files(cible)) > 0 && !isTRUE(force)) {
    cli::cli_abort(c(
      "Le dossier {.path {cible}} existe déjà et n'est pas vide.",
      "i" = "Relancez avec {.code force = TRUE}, ou choisissez un autre {.arg dest}."
    ))
  }

  cli::cli_alert_info("Destination de la correction : {.path {cible}}")
  ok <- .confirmer(
    "Copier la correction en local ? (elle est plus utile une fois que vous avez essayé l'exercice)",
    force = force
  )
  if (!ok) {
    if (!rlang::is_interactive()) {
      cli::cli_abort(c(
        "Copie annulée (mode non-interactif).",
        "i" = "Relancez avec {.code force = TRUE} pour confirmer, ou changez {.arg dest}."
      ))
    }
    cli::cli_alert_info("Annulé — réessayez l'exercice d'abord, la correction n'ira nulle part.")
    return(invisible(NULL))
  }

  dir.create(cible, recursive = TRUE, showWarnings = FALSE)
  n <- .copier_dossier(src, cible)
  cli::cli_alert_success(
    "Correction de l'exercice {quel} copiée : {.path {cible}} ({n} fichier{?s})."
  )
  cli::cli_alert_info(
    "Pour la retravailler : ouvrez les fichiers, modifiez, puis rendez avec {.code quarto render}."
  )
  .ouvrir_dossier(cible)
  invisible(cible)
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
