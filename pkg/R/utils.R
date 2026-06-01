# Helpers internes et constantes partagées --------------------------------------
#
# SOURCE DE VÉRITÉ des seuils : alignés sur `preparatifs.qmd` du site.
# (R 4 récent ; Quarto >= 1.9 plancher, >= 1.10.4 recommandé.)

# Seuils de version
.seuil_r <- numeric_version("4.1.0")
.quarto_min <- numeric_version("1.9")
.quarto_reco <- numeric_version("1.10.4")

# Prérequis « participants » du tutoriel (mêmes 8 paquets que preparatifs.qmd)
.paquets_requis <- c(
  "quarto", "dplyr", "ggplot2", "ggrepel",
  "gt", "scales", "brand.yml", "prismatic"
)

# URLs utiles (messages cli)
.url_quarto <- "https://quarto.org/docs/download/"

# Exercices embarqués + phrase d'intention (orientation, sans dévoiler d'étapes)
.exos <- list(
  "00-test-install" = "Test express : rendre un mini-PDF pour valider la chaîne.",
  "01-document-typst" = "Votre premier PDF Typst : convertir un rapport en `format: typst`.",
  "02-projet-book" = "Un livre Typst personnalisé avec une charte (`_brand.yml`)."
)

# Dossier des exercices embarqués dans le paquet (inst/exercices)
.dossier_exercices_paquet <- function() {
  chemin <- system.file("exercices", package = "tutotypst")
  if (!nzchar(chemin)) {
    cli::cli_abort(
      "Exercices introuvables dans le paquet. Réinstallation nécessaire ?"
    )
  }
  chemin
}

# Nom de dossier d'un exercice à partir d'un code court ("00" / "01" / "02")
.exo_dossier <- function(quel) {
  switch(quel,
    "00" = "00-test-install",
    "01" = "01-document-typst",
    "02" = "02-projet-book",
    cli::cli_abort("Code d'exercice inconnu : {.val {quel}}.")
  )
}

# Copie récursive d'un dossier `from` -> `to` (crée `to`, écrase les fichiers)
.copier_dossier <- function(from, to) {
  fichiers <- list.files(from, recursive = TRUE, all.files = TRUE, no.. = TRUE)
  for (f in fichiers) {
    cible <- file.path(to, f)
    dir.create(dirname(cible), recursive = TRUE, showWarnings = FALSE)
    file.copy(file.path(from, f), cible, overwrite = TRUE, copy.mode = FALSE)
  }
  length(fichiers)
}

# Confirmation interactive. En mode non-interactif : renvoie `force`.
.confirmer <- function(question, force = FALSE) {
  if (isTRUE(force)) {
    return(TRUE)
  }
  if (!rlang::is_interactive()) {
    return(FALSE)
  }
  reponse <- utils::menu(c("Oui", "Non"), title = question)
  identical(reponse, 1L)
}

# Ouvre un dossier dans l'IDE / l'explorateur si possible (best-effort, silencieux)
.ouvrir_dossier <- function(chemin) {
  if (rlang::is_installed("rstudioapi") &&
    rstudioapi::isAvailable() &&
    rstudioapi::hasFun("filesPaneNavigate")) {
    try(rstudioapi::filesPaneNavigate(chemin), silent = TRUE)
    return(invisible(TRUE))
  }
  if (rlang::is_interactive()) {
    try(utils::browseURL(chemin), silent = TRUE)
    return(invisible(TRUE))
  }
  invisible(FALSE)
}
