# Helpers internes et constantes partagées --------------------------------------
#
# SOURCE DE VÉRITÉ des seuils : doivent rester alignés sur `preparatifs.qmd`
# (section « Installation ») du site. Si vous changez un seuil ici, mettez à jour
# `preparatifs.qmd` (et inversement).
#   - R : « Dernier R 4 » côté site ; plancher effectif 4.1 (requis par brand.yml).
#   - Quarto : >= 1.9 plancher, >= 1.10.4 recommandé (pre-release).

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

# Lecture YAML « fidèle » centralisée :
#  - YAML 1.2 : yes/no/on/off restent des CHAÎNES (évite le « Norway problem »
#    de YAML 1.1 ; true/false restent logiques).
#  - eval.expr = FALSE : un tag `!expr` n'exécute jamais de code R.
#  - UTF-8 quelle que soit la locale.
# Côté ÉCRITURE, le pendant serait `yaml::verbatim_logical()` (force as.yaml à
# émettre true/false plutôt que yes/no) — inutile ici : la charte générée par
# .brand_generique() ne contient aucune valeur logique.
.handlers_yaml_fidele <- list(
  `bool#yes` = function(x) if (identical(x, "true")) TRUE else x,
  `bool#no` = function(x) if (identical(x, "false")) FALSE else x
)
.lire_yaml <- function(chemin) {
  yaml::read_yaml(
    chemin,
    fileEncoding = "UTF-8",
    eval.expr = FALSE,
    handlers = .handlers_yaml_fidele
  )
}

# Polices Inter embarquées (mode hors-ligne) : fichier -> graisse
.inter_offline <- c(
  "Inter-Regular.ttf" = 400,
  "Inter-SemiBold.ttf" = 600,
  "Inter-Bold.ttf" = 700
)

# Dossier des exercices embarqués dans le paquet (inst/exercices)
.dossier_exercices_paquet <- function() {
  chemin <- system.file("exercices", package = "tutoquartotypst")
  if (!nzchar(chemin)) {
    cli::cli_abort(
      "Exercices introuvables dans le paquet. Réinstallation nécessaire ?"
    )
  }
  chemin
}

# Contenu d'un fichier .Rproj minimal (mêmes options que usethis::use_rstudio()).
# Permet le double-clic -> RStudio ouvre le dossier comme projet (wd correct,
# session isolée). Inerte pour VS Code.
.contenu_rproj <- function() {
  c(
    "Version: 1.0",
    "",
    "RestoreWorkspace: Default",
    "SaveWorkspace: Default",
    "AlwaysSaveHistory: Default",
    "",
    "EnableCodeIndexing: Yes",
    "UseSpacesForTab: Yes",
    "NumSpacesForTab: 2",
    "Encoding: UTF-8",
    "",
    "RnwWeave: Sweave",
    "LaTeX: pdfLaTeX"
  )
}

# Dossier des polices hors-ligne embarquées (inst/offline/_fonts)
.dossier_offline_paquet <- function() {
  system.file("offline", "_fonts", package = "tutoquartotypst")
}

# Ouvre un fichier dans l'IDE / l'éditeur si possible (best-effort, silencieux)
.ouvrir_fichier <- function(chemin) {
  if (rlang::is_installed("rstudioapi") &&
    rstudioapi::isAvailable() &&
    rstudioapi::hasFun("navigateToFile")) {
    try(rstudioapi::navigateToFile(chemin), silent = TRUE)
    return(invisible(TRUE))
  }
  if (rlang::is_interactive()) {
    try(utils::file.edit(chemin), silent = TRUE)
    return(invisible(TRUE))
  }
  invisible(FALSE)
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
