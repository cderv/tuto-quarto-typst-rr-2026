# Lot 2 — santé de la chaîne Typst & confort.

#' Diagnostic détaillé de la chaîne Quarto / Typst
#'
#' Agrège les informations utiles au dépannage : chemin et version de Quarto,
#' version de Typst embarqué, présence du cache de polices, et verdict sur le
#' besoin du contournement `font-paths` (Quarto < 1.10.4).
#'
#' @param projet Dossier de projet où chercher le cache de polices
#'   `.quarto/typst/fonts`. Par défaut le répertoire courant.
#'
#' @return Invisiblement, une liste des informations collectées.
#' @export
#'
#' @examplesIf interactive()
#' diagnostic_typst()
diagnostic_typst <- function(projet = ".") {
  cli::cli_h2("Diagnostic Quarto / Typst")
  qpath <- tryCatch(quarto::quarto_path(), error = function(e) NULL)
  if (is.null(qpath) || !nzchar(qpath)) {
    cli::cli_alert_danger("Quarto introuvable.")
    return(invisible(list(quarto = NA)))
  }
  qversion <- tryCatch(quarto::quarto_version(), error = function(e) NA)
  tversion <- tryCatch(
    sub("^.*?([0-9]+\\.[0-9]+\\.[0-9]+).*$", "\\1",
      paste(system2(qpath, c("typst", "--version"), stdout = TRUE, stderr = TRUE),
        collapse = " ")),
    error = function(e) NA_character_
  )
  reco <- as.character(.quarto_reco)
  cache <- file.path(normalizePath(projet, mustWork = FALSE), ".quarto", "typst", "fonts")
  cache_ok <- dir.exists(cache)
  besoin_fontpaths <- !is.na(qversion) && qversion < .quarto_reco
  etat_cache <- if (cache_ok) "présent" else "absent"

  cli::cli_alert_info("Quarto : {qversion} ({.path {qpath}})")
  cli::cli_alert_info("Typst (embarqué) : {tversion}")
  cli::cli_alert_info("Cache de polices (.quarto/typst/fonts) : {etat_cache}")
  if (besoin_fontpaths) {
    cli::cli_alert_warning(
      "Quarto < {reco} : le contournement `font-paths` peut être nécessaire pour le livre (exercice 2)."
    )
  } else {
    cli::cli_alert_success("Quarto >= {reco} : pas de contournement `font-paths` nécessaire.")
  }
  invisible(list(
    quarto = qversion, typst = tversion, cache_polices = cache_ok,
    besoin_fontpaths = besoin_fontpaths
  ))
}

#' Lister les polices vues par Typst
#'
#' Appelle `quarto typst fonts` pour lister les familles de polices visibles par
#' Typst, et vérifie la présence d'Inter et de Star Jedi.
#'
#' @param projet Dossier de projet. Si fourni, son sous-dossier `_fonts/` est
#'   ajouté au chemin de recherche (`--font-path`).
#'
#' @details
#' Une police déclarée `source: google` dans `_brand.yml` (Inter par défaut)
#' n'apparaît **pas** ici tant qu'un premier rendu ne l'a pas téléchargée dans le
#' cache. Seules les polices `source: file` (et système) sont visibles d'emblée.
#'
#' @return Invisiblement, le vecteur des familles de polices.
#' @export
#'
#' @examplesIf interactive()
#' polices_typst()
polices_typst <- function(projet = NULL) {
  qpath <- tryCatch(quarto::quarto_path(), error = function(e) NULL)
  if (is.null(qpath) || !nzchar(qpath)) {
    cli::cli_abort("Quarto introuvable.")
  }
  args <- c("typst", "fonts")
  if (!is.null(projet)) {
    fdir <- file.path(normalizePath(projet, mustWork = FALSE), "_fonts")
    if (dir.exists(fdir)) args <- c(args, "--font-path", fdir)
  }
  familles <- tryCatch(
    system2(qpath, args, stdout = TRUE, stderr = TRUE),
    error = function(e) character(0)
  )
  familles <- unique(familles[nzchar(familles)])

  cli::cli_h2("Polices visibles par Typst ({length(familles)})")
  a_inter <- any(grepl("^Inter$", familles))
  a_starjedi <- any(grepl("Star ?Jedi", familles, ignore.case = TRUE))
  if (a_inter) {
    cli::cli_alert_success("Inter : disponible.")
  } else {
    cli::cli_alert_warning(
      "Inter : non vue. Normal si `source: google` et aucun rendu effectué (sinon : mode hors-ligne)."
    )
  }
  if (a_starjedi) {
    cli::cli_alert_success("Star Jedi : disponible.")
  } else {
    cli::cli_alert_warning("Star Jedi : non vue (vérifiez `_fonts/Starjedi.ttf`).")
  }
  invisible(familles)
}

#' Inspecter le code Typst intermédiaire d'un document
#'
#' Rend un `.qmd` `format: typst` en conservant le `.typ` intermédiaire
#' (`keep-typ`), pour comprendre la couche Typst générée par Quarto. Pensé pour
#' un **document** simple (l'exercice 1) ; pour un livre, le comportement est
#' moins prévisible.
#'
#' @param qmd Chemin du fichier `.qmd` à rendre.
#' @param ouvrir Logique. Ouvrir le `.typ` produit dans l'éditeur ? Par défaut
#'   `TRUE`.
#'
#' @return Invisiblement, le chemin du `.typ` produit, ou `NULL` en cas d'échec.
#' @export
#'
#' @examplesIf interactive()
#' inspecter_typ("rapport-starwars.qmd")
inspecter_typ <- function(qmd, ouvrir = TRUE) {
  if (!file.exists(qmd)) {
    cli::cli_abort("Fichier {.path {qmd}} introuvable.")
  }
  qmd <- normalizePath(qmd, winslash = "/", mustWork = TRUE)
  dossier <- dirname(qmd)
  base <- tools::file_path_sans_ext(basename(qmd))

  res <- tryCatch(
    withr::with_dir(dossier, {
      quarto::quarto_render(basename(qmd), quarto_args = c("-M", "keep-typ:true"), quiet = TRUE)
      TRUE
    }),
    error = function(e) e
  )
  typ <- file.path(dossier, paste0(base, ".typ"))
  if (!file.exists(typ)) {
    cli::cli_alert_danger("Aucun fichier .typ généré.")
    if (inherits(res, "error")) cli::cli_alert_info("Détail : {conditionMessage(res)}")
    return(invisible(NULL))
  }
  cli::cli_alert_success("Code Typst intermédiaire : {.path {typ}}")
  cli::cli_alert_info("C'est le .typ que Quarto transmet à Typst.")
  if (isTRUE(ouvrir)) .ouvrir_fichier(typ)
  invisible(typ)
}

#' Nettoyer les artefacts de rendu d'un projet
#'
#' Supprime les artefacts de rendu (`_book/`, `*_files/`, `*.typ`) pour repartir
#' d'un état propre. Ne touche jamais à vos sources ni à `_fonts/`.
#'
#' @param projet Dossier de projet à nettoyer. Par défaut le répertoire courant.
#' @param polices Logique. Vider aussi le cache de polices
#'   `.quarto/typst/fonts` (force le re-téléchargement des polices Google au
#'   prochain rendu) ? Par défaut `FALSE`.
#'
#' @return Invisiblement, le nombre d'éléments supprimés.
#' @export
#'
#' @examplesIf interactive()
#' nettoyer_cache()
nettoyer_cache <- function(projet = ".", polices = FALSE) {
  projet <- normalizePath(projet, winslash = "/", mustWork = FALSE)
  cibles <- character(0)
  bk <- file.path(projet, "_book")
  if (dir.exists(bk)) cibles <- c(cibles, bk)
  dirs <- list.dirs(projet, recursive = TRUE)
  cibles <- c(cibles, dirs[grepl("_files$", dirs)])
  cibles <- c(cibles, list.files(projet, pattern = "\\.typ$", recursive = TRUE, full.names = TRUE))

  n <- 0L
  for (cible in unique(cibles)) {
    if (file.exists(cible)) {
      unlink(cible, recursive = TRUE)
      n <- n + 1L
    }
  }
  if (isTRUE(polices)) {
    cache <- file.path(projet, ".quarto", "typst", "fonts")
    if (dir.exists(cache)) {
      unlink(cache, recursive = TRUE)
      n <- n + 1L
      cli::cli_alert_info(
        "Cache de polices vidé (les polices Google seront re-téléchargées au prochain rendu)."
      )
    }
  }
  cli::cli_alert_success("Nettoyage : {n} élément{?s} supprimé{?s}.")
  invisible(n)
}

#' Retrouver et ouvrir le dossier des exercices installés
#'
#' Filet de sécurité quand on a perdu le message de [installer_exercices()] :
#' ré-affiche le chemin absolu et ouvre le dossier.
#'
#' @param dossier Dossier où les exercices ont été installés. Par défaut
#'   `"exercices-typst"`.
#'
#' @return Invisiblement, le chemin absolu du dossier.
#' @export
#'
#' @examplesIf interactive()
#' ouvrir_exercices()
ouvrir_exercices <- function(dossier = "exercices-typst") {
  chemin <- normalizePath(dossier, winslash = "/", mustWork = FALSE)
  if (!dir.exists(chemin)) {
    cli::cli_abort(c(
      "Dossier {.path {chemin}} introuvable.",
      "i" = "Installez d'abord les exercices : {.run tutotypst::installer_exercices()}."
    ))
  }
  cli::cli_alert_info("Vos exercices : {.path {chemin}}")
  .ouvrir_dossier(chemin)
  invisible(chemin)
}
