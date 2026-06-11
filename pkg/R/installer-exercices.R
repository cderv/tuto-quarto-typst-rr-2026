#' Installer les exercices du tutoriel
#'
#' Copie les fichiers de départ (« starters ») des exercices, embarqués dans le
#' paquet, vers un dossier de travail local. Seuls les `starter/` sont copiés ;
#' les corrections ne sont pas posées ici (voir [ouvrir_correction()] pour les
#' consulter en ligne, [recuperer_correction()] pour les copier en local).
#'
#' @param dest Chemin du dossier de destination (créé si besoin). Par défaut
#'   `NULL` : en session interactive, le dossier est **demandé** (sélecteur
#'   RStudio si disponible, sinon invite texte ; valeur proposée
#'   `"exercices-typst"`). Fournir un chemin explicite court-circuite la demande
#'   (utile en script). En mode non-interactif sans `dest`, `"exercices-typst"`
#'   (dans le répertoire courant) est utilisé.
#' @param quels Quels exercices installer : `"tous"` (défaut), `"01"`
#'   (document Typst) ou `"02"` (projet livre).
#' @param force Logique. Passer la confirmation interactive **et** écraser un
#'   dossier de destination déjà existant et non vide ? Par défaut `FALSE` (en
#'   mode non-interactif, `force = TRUE` est requis pour confirmer la copie).
#'
#' @return Invisiblement, le chemin absolu du dossier de destination, ou `NULL`
#'   si l'installation a été annulée.
#' @export
#'
#' @examplesIf interactive()
#' installer_exercices()
#' installer_exercices(quels = "01")
installer_exercices <- function(dest = NULL,
                                quels = c("tous", "01", "02"),
                                force = FALSE) {
  quels <- match.arg(quels)
  src_root <- .dossier_exercices_paquet()

  exos <- switch(quels,
    "tous" = c("00-test-install", "01-document-typst", "02-projet-book"),
    "01" = "01-document-typst",
    "02" = "02-projet-book"
  )

  # Destination : si non fournie, on la demande (sélecteur RStudio / invite
  # texte) ; le choix interactif vaut confirmation. En non-interactif/`force`,
  # repli silencieux sur "exercices-typst".
  choisi_interactivement <- FALSE
  if (is.null(dest)) {
    dest <- .choisir_dossier_dest("exercices-typst", force = force)
    if (is.null(dest)) {
      cli::cli_alert_info("Installation annulée (aucun dossier choisi).")
      return(invisible(NULL))
    }
    choisi_interactivement <- !isTRUE(force) && rlang::is_interactive()
  }

  dest_abs <- xfun::normalize_path(dest)
  if (dir.exists(dest_abs) && length(list.files(dest_abs)) > 0 && !isTRUE(force)) {
    cli::cli_abort(c(
      "Le dossier {.path {dest_abs}} existe déjà et n'est pas vide.",
      "i" = "Relancez avec {.code force = TRUE}, ou choisissez un autre {.arg dest}."
    ))
  }

  # Annonce de la destination + confirmation avant écriture — sauf si
  # l'utilisateur vient déjà de choisir le dossier (le choix fait office d'accord).
  cli::cli_alert_info("Destination des exercices : {.path {dest_abs}}")
  if (!choisi_interactivement &&
    !.confirmer("Copier les exercices dans ce dossier ?", force = force)) {
    if (!rlang::is_interactive()) {
      cli::cli_abort(c(
        "Installation annulée (mode non-interactif).",
        "i" = "Relancez avec {.code force = TRUE} pour confirmer, ou changez {.arg dest}."
      ))
    }
    cli::cli_alert_info("Installation annulée. Indiquez un autre {.arg dest} si besoin.")
    return(invisible(NULL))
  }

  dir.create(dest_abs, recursive = TRUE, showWarnings = FALSE)

  for (exo in exos) {
    # `exclure = "correction"` : on ne pose que les `starter/` (les corrections
    # se consultent en ligne via ouvrir_correction(), ou se copient à la
    # demande via recuperer_correction()).
    .copier_dossier(
      file.path(src_root, exo), file.path(dest_abs, exo),
      exclure = "correction"
    )
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
  # L'avertissement n'a de sens que si une `correction/` est réellement posée en
  # local : `installer_exercices()` n'en pose jamais (copie `exclure = "correction"`),
  # donc le message ne s'affiche pas ici. Il reste utile si une correction a été
  # récupérée via recuperer_correction() avant une réinstallation.
  if (any(dir.exists(file.path(dest_abs, exos, "correction")))) {
    cli::cli_alert_warning(
      "N'ouvrez pas les dossiers {.path correction/} avant le tutoriel (mieux vaut chercher d'abord !)."
    )
  }
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
#'   [installer_exercices()]). Par défaut `"exercices-typst"` : dans ce cas, la
#'   fonction **retrouve automatiquement** le bon dossier à partir du répertoire
#'   courant — lancée depuis l'intérieur d'un exercice (p. ex. son `starter/`)
#'   ou depuis la racine d'installation, elle réinitialise le bon dossier sans
#'   créer d'arborescence imbriquée. Fournir un chemin explicite court-circuite
#'   cette détection.
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

  # Sans `dossier` explicite, on déduit la racine d'installation du répertoire
  # courant : lancée depuis le `starter/` (ce que conseille installer_exercices)
  # ou depuis la racine, la fonction vise alors le bon dossier au lieu de résoudre
  # "exercices-typst" relativement au cwd (qui imbriquerait .../starter/exercices-typst/...).
  racine <- if (missing(dossier)) .racine_install_exo(exo) else NULL
  cible <- file.path(xfun::normalize_path(racine %||% dossier), exo)
  cible_norm <- xfun::normalize_path(cible, must_work = FALSE)

  # Sommes-nous DANS le dossier qu'on va remplacer ? Si oui, il faut en sortir
  # avant le renommage de sauvegarde (sinon échec sous Windows : dossier verrouillé ;
  # cwd orphelin sous Unix). On y replacera l'utilisateur (dans `starter/`) à la fin.
  wd <- xfun::normalize_path(getwd())
  dans_cible <- identical(wd, cible_norm) ||
    startsWith(paste0(wd, "/"), paste0(cible_norm, "/"))

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
    if (dans_cible) {
      # On DOIT quitter le dossier avant de le renommer (Windows : dossier
      # verrouillé ; Unix : cwd orphelin). On ne touche au wd QUE dans ce cas
      # (lancement depuis l'intérieur du dossier visé), et `on.exit` GARANTIT de
      # reposer ensuite l'utilisateur dans un dossier valide + message — même si
      # une erreur survient pendant la copie (pas de cwd orphelin laissé derrière).
      parent <- dirname(cible_norm)
      setwd(parent)
      on.exit({
        retour <- file.path(cible, "starter")
        if (!dir.exists(retour)) retour <- if (dir.exists(cible)) cible else parent
        setwd(retour)
        cli::cli_alert_info("Répertoire de travail replacé dans {.path {retour}}.")
      }, add = TRUE)
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
  # Comme installer_exercices() : on restaure le `starter/`, pas la `correction/`.
  .copier_dossier(src, cible, exclure = "correction")
  cli::cli_alert_success(
    "Exercice {exo} réinitialisé à l'état de départ : {.path {cible}}"
  )
  if (!is.null(sauvegarde)) {
    cli::cli_alert_info("Votre travail précédent reste dans {.path {sauvegarde}}.")
  }
  # Le retour du wd dans le starter restauré est géré par on.exit() ci-dessus
  # (garanti même en cas d'erreur), uniquement quand on était DANS le dossier visé.
  invisible(cible)
}
