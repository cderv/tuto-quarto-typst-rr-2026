# Helpers internes et constantes partagées --------------------------------------
#
# SOURCE DE VÉRITÉ des seuils : doivent rester alignés sur `preparatifs.qmd`
# (section « Installation ») du site. Si vous changez un seuil ici, mettez à jour
# `preparatifs.qmd` (et inversement).
#   - R : « Dernier R 4 » côté site ; plancher effectif 4.1 (requis par brand.yml).
#   - Quarto : >= 1.9 plancher, >= 1.10.7 recommandé (dernière pre-release).
#
# `.quarto_fix` est distinct de `.quarto_reco` : c'est la version où le correctif
# des polices `_brand.yml` en mode livre a atterri (quarto-cli#14517, livré en
# v1.10.4). En dessous, le contournement `font-paths` est nécessaire ; au-dessus,
# il est inutile — même si une version plus récente reste recommandée. Ne pas
# aligner cette borne sur `.quarto_reco` : un Quarto 1.10.4–1.10.6 a déjà le fix.

# Seuils de version
.seuil_r <- numeric_version("4.1.0")
.quarto_min <- numeric_version("1.9")
.quarto_reco <- numeric_version("1.10.7")
.quarto_fix <- numeric_version("1.10.4")

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

# Contenu d'un fichier .Rproj (sortie exacte de usethis::use_rstudio() avec ses
# défauts : reformat = TRUE, line_ending = "posix", projet non-paquet). Permet le
# double-clic -> RStudio ouvre le dossier comme projet (wd correct, session
# propre). Inerte pour VS Code.
.contenu_rproj <- function() {
  c(
    "Version: 1.0",
    "",
    "RestoreWorkspace: No",
    "SaveWorkspace: No",
    "AlwaysSaveHistory: Default",
    "",
    "EnableCodeIndexing: Yes",
    "Encoding: UTF-8",
    "",
    "AutoAppendNewline: Yes",
    "StripTrailingWhitespace: Yes",
    "LineEndingConversion: Posix"
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

# Racine d'installation des exercices déduite du répertoire courant `wd`.
# Permet à reinitialiser_exercice() de « retrouver » le bon dossier quel que soit
# l'endroit d'où on la lance, au lieu d'interpréter "exercices-typst" relativement
# au cwd (ce qui crée une arborescence imbriquée). Renvoie le dossier qui CONTIENT
# `<exo>`, ou NULL si on ne sait pas (repli sur le `dossier` par défaut).
#   1) cwd à l'intérieur d'un exercice (.../exercices-typst/<exo>/starter) ->
#      racine = le segment parent de `<exo>` ;
#   2) cwd à la racine d'install (un sous-dossier `<exo>` existe) -> racine = cwd.
.racine_install_exo <- function(exo, wd = getwd()) {
  wd <- xfun::normalize_path(wd)
  segments <- strsplit(wd, "/", fixed = TRUE)[[1]]
  hit <- which(segments == exo)
  if (length(hit) >= 1 && hit[1] > 1) {
    return(paste(segments[seq_len(hit[1] - 1L)], collapse = "/"))
  }
  if (dir.exists(file.path(wd, exo))) {
    return(wd)
  }
  NULL
}

# Copie récursive d'un dossier `from` -> `to` (crée `to`, écrase les fichiers)
# `exclure` : noms de sous-dossiers de premier niveau à NE PAS copier (p. ex.
# "correction" pour ne poser que les `starter/` chez les participants).
.copier_dossier <- function(from, to, exclure = NULL) {
  fichiers <- list.files(from, recursive = TRUE, all.files = TRUE, no.. = TRUE)
  if (length(exclure)) {
    premier <- vapply(
      strsplit(fichiers, "/", fixed = TRUE), `[`, character(1), 1L
    )
    fichiers <- fichiers[!premier %in% exclure]
  }
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

# Choix du dossier de destination des exercices quand l'utilisateur n'en fournit
# pas (`dest = NULL`). Stratégie en cascade :
#   - non-interactif OU `force` : renvoie `defaut` sans rien demander (scripts/CI) ;
#   - RStudio avec `selectDirectory()` : sélecteur graphique (on choisit le dossier
#     PARENT, un sous-dossier `defaut` y est créé) ; annulation -> NULL ;
#   - sinon : invite texte `readline()`, `Entrée` = `defaut`.
.choisir_dossier_dest <- function(defaut = "exercices-typst", force = FALSE) {
  if (isTRUE(force) || !rlang::is_interactive()) {
    return(defaut)
  }
  if (rlang::is_installed("rstudioapi") &&
    rstudioapi::isAvailable() &&
    rstudioapi::hasFun("selectDirectory")) {
    parent <- tryCatch(
      rstudioapi::selectDirectory(
        caption = "Dossier où créer les exercices",
        label = "Installer ici"
      ),
      error = function(e) NULL
    )
    if (is.null(parent) || !nzchar(parent)) {
      return(NULL)
    }
    return(file.path(parent, basename(defaut)))
  }
  reponse <- tryCatch(
    trimws(readline(sprintf("Dossier d'installation des exercices [%s] : ", defaut))),
    error = function(e) ""
  )
  if (nzchar(reponse)) reponse else defaut
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
