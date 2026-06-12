# Lot 2 — aides brand.yml / polices.
# Les éditions de fichiers sont CIBLÉES (insertion/remplacement de lignes), jamais
# un round-trip yaml::write_yaml / yaml12::format_yaml qui détruirait commentaires
# et ordre (vérifié : yaml12 0.1.0 perd les commentaires en round-trip).
# Choix TRANSITOIRE : à migrer vers un parcours structuré yaml12 préservant les
# commentaires quand l'issue posit-dev/r-yaml12#5 (read_yaml(preserve_all=TRUE))
# sera livrée -> https://github.com/posit-dev/r-yaml12/issues/5
# Lecture/écriture en UTF-8 via xfun (robuste quelle que soit la locale).

#' Basculer un exercice en mode hors-ligne (polices Inter locales)
#'
#' Quand le réseau manque, Inter (déclarée `source: google` dans `_brand.yml`)
#' ne peut pas être téléchargée. Cette fonction dépose les fichiers Inter
#' embarqués dans `_fonts/` et bascule l'entrée Inter de `_brand.yml` en
#' `source: file` — **sans toucher** au reste de votre charte (couleurs, etc.).
#' Votre `_brand.yml` est sauvegardé avant modification.
#'
#' @param projet Dossier de l'exercice (contenant `_brand.yml`). Par défaut le
#'   répertoire courant.
#' @param retour Logique. Restaurer le `_brand.yml` d'origine (revenir en
#'   ligne) ? Par défaut `FALSE`.
#'
#' @return Invisiblement, le chemin du `_brand.yml`, ou `NULL` si rien n'a été
#'   modifié.
#' @export
#'
#' @examplesIf interactive()
#' basculer_hors_ligne()
#' basculer_hors_ligne(retour = TRUE)
basculer_hors_ligne <- function(projet = ".", retour = FALSE) {
  projet <- xfun::normalize_path(projet)
  brand <- file.path(projet, "_brand.yml")
  bak <- file.path(projet, "_brand.yml.avant-hors-ligne")

  if (isTRUE(retour)) {
    if (!file.exists(bak)) {
      cli::cli_abort("Aucune sauvegarde {.path _brand.yml.avant-hors-ligne} à restaurer.")
    }
    file.copy(bak, brand, overwrite = TRUE)
    file.remove(bak)
    cli::cli_alert_success("Mode en ligne restauré (votre `_brand.yml` d'origine).")
    return(invisible(brand))
  }

  if (!file.exists(brand)) {
    cli::cli_abort(c(
      "{.path _brand.yml} introuvable dans {.path {projet}}.",
      "i" = "La bascule hors-ligne agit sur la charte {.path _brand.yml}, qui n'apparaît qu'une fois la charte ajoutée à votre rapport (étapes 3-4 de l'exercice 1).",
      "i" = "Relancez cette fonction après cette étape, depuis le dossier qui contient votre {.path _brand.yml}."
    ))
  }

  lignes <- xfun::read_utf8(brand)
  idx <- grep("^\\s*source:\\s*google\\s*$", lignes)

  # Validation SÉMANTIQUE (par parsing) avant toute édition : on n'agit que si la
  # charte a exactement UNE police `source: google` et que c'est Inter. Sinon on
  # guide, sans rien modifier (évite d'éditer la mauvaise police / une forme tordue).
  raw <- tryCatch(.lire_yaml(brand), error = function(e) NULL)
  fonts <- if (!is.null(raw)) raw$typography$fonts %||% list() else list()
  est_google <- vapply(fonts, function(f) identical(f$source, "google"), logical(1))
  familles_google <- vapply(fonts[est_google], function(f) f$family %||% NA_character_, character(1))
  attendu <- !is.null(raw) && length(idx) == 1 &&
    sum(est_google) == 1 && identical(unname(familles_google), "Inter")

  if (!attendu) {
    cli::cli_alert_warning("Structure de `_brand.yml` inattendue pour la bascule automatique.")
    cli::cli_alert_info(
      "Attendu : une seule police `source: google` (Inter). Rien n'a été modifié."
    )
    cli::cli_alert_info("Vous êtes peut-être déjà hors-ligne, ou la charte diffère du modèle.")
    return(invisible(NULL))
  }

  # Déployer les TTF Inter embarqués
  fdir <- file.path(projet, "_fonts")
  dir.create(fdir, showWarnings = FALSE, recursive = TRUE)
  src <- .dossier_offline_paquet()
  for (f in names(.inter_offline)) {
    file.copy(file.path(src, f), file.path(fdir, f), overwrite = TRUE)
  }

  # Sauvegarde puis remplacement ciblé de l'entrée Inter
  file.copy(brand, bak, overwrite = TRUE)
  i <- idx[1]
  indent <- sub("source:.*$", "", lignes[i])
  bloc <- c(
    paste0(indent, "source: file"),
    paste0(indent, "files:"),
    paste0(indent, "  - path: _fonts/Inter-Regular.ttf"),
    paste0(indent, "    weight: 400"),
    paste0(indent, "  - path: _fonts/Inter-SemiBold.ttf"),
    paste0(indent, "    weight: 600"),
    paste0(indent, "  - path: _fonts/Inter-Bold.ttf"),
    paste0(indent, "    weight: 700")
  )
  # Supprime aussi la ligne `weight: [...]` qui suit immédiatement, le cas échéant
  fin <- i
  if (i < length(lignes) && grepl("^\\s*weight:\\s*\\[", lignes[i + 1])) {
    fin <- i + 1
  }
  apres <- if (fin < length(lignes)) lignes[(fin + 1):length(lignes)] else character(0)
  xfun::write_utf8(c(lignes[seq_len(i - 1)], bloc, apres), brand)

  # Filet de sécurité : on relit le résultat. Si l'édition textuelle a cassé le
  # YAML ou n'a pas pris (Inter pas en source: file), on restaure et on guide.
  valide <- tryCatch(
    {
      v <- .lire_yaml(brand)
      fonts <- v$typography$fonts %||% list()
      any(vapply(fonts, function(f) {
        identical(f$family, "Inter") && identical(f$source, "file")
      }, logical(1)))
    },
    error = function(e) FALSE
  )
  if (!valide) {
    file.copy(bak, brand, overwrite = TRUE)
    file.remove(bak)
    cli::cli_alert_danger(
      "Édition automatique impossible sur ce `_brand.yml` : il a été restauré tel quel."
    )
    cli::cli_alert_info(
      "Passez Inter en `source: file` à la main (polices déjà copiées dans {.path _fonts/})."
    )
    return(invisible(NULL))
  }

  cli::cli_alert_success("Mode hors-ligne activé : Inter en local dans {.path _fonts/}.")
  cli::cli_alert_info("Sauvegarde de votre charte : {.path {bak}}")
  cli::cli_alert_info("Revenir en ligne : {.run tutoquartotypst::basculer_hors_ligne(retour = TRUE)}.")
  invisible(brand)
}

#' Appliquer le contournement `font-paths` (livre, Quarto < 1.10.4)
#'
#' Sur Quarto antérieur à 1.10.4, un projet livre avec `_brand.yml` a besoin de
#' l'option `font-paths` dans `_quarto.yml` pour trouver les polices. Cette
#' fonction l'ajoute si nécessaire (et ne fait rien si votre Quarto est assez
#' récent ou si l'option est déjà présente). Le `_quarto.yml` est sauvegardé.
#'
#' @param projet Dossier du projet livre (contenant `_quarto.yml`). Par défaut
#'   le répertoire courant.
#'
#' @return Invisiblement, `TRUE` si le fichier a été modifié, `FALSE` sinon.
#' @export
#'
#' @examplesIf interactive()
#' appliquer_polices_locales()
appliquer_polices_locales <- function(projet = ".") {
  reco <- as.character(.quarto_fix)
  projet <- xfun::normalize_path(projet)

  qversion <- tryCatch(quarto::quarto_version(), error = function(e) NA)
  if (length(qversion) == 1 && !is.na(qversion) && qversion >= .quarto_fix) {
    cli::cli_alert_success(
      "Quarto {qversion} >= {reco} : pas besoin du contournement `font-paths`. Rien à faire."
    )
    return(invisible(FALSE))
  }

  qfile <- file.path(projet, "_quarto.yml")
  if (!file.exists(qfile)) {
    cli::cli_abort(c(
      "{.path _quarto.yml} introuvable dans {.path {projet}}.",
      "i" = "Cette manipulation concerne le projet livre (exercice 2)."
    ))
  }
  lignes <- xfun::read_utf8(qfile)
  if (any(grepl("font-paths", lignes))) {
    cli::cli_alert_info("`font-paths` est déjà présent dans `_quarto.yml`. Rien à faire.")
    return(invisible(FALSE))
  }

  i_typst <- grep("^\\s*typst\\s*:\\s*$", lignes)
  if (length(i_typst) == 0) {
    cli::cli_alert_warning("Bloc `format: typst:` non trouvé : ajout manuel nécessaire.")
    cli::cli_text("Ajoutez ceci dans `_quarto.yml` :")
    cli::cli_code(c(
      "format:", "  typst:", "    font-paths:",
      "      - .quarto/typst/fonts", "      - _fonts"
    ))
    return(invisible(FALSE))
  }

  i <- i_typst[1]
  indent <- sub("typst:.*$", "", lignes[i])
  bloc <- c(
    paste0(indent, "  font-paths:"),
    paste0(indent, "    - .quarto/typst/fonts"),
    paste0(indent, "    - _fonts")
  )
  bak <- paste0(qfile, ".avant-fontpaths")
  file.copy(qfile, bak, overwrite = TRUE)
  xfun::write_utf8(append(lignes, bloc, after = i), qfile)

  # Filet de sécurité : on relit le résultat. Si l'insertion a cassé le YAML ou
  # mal niché `font-paths`, on restaure et on donne les lignes à ajouter à la main.
  valide <- tryCatch(
    !is.null(.lire_yaml(qfile)$format$typst[["font-paths"]]),
    error = function(e) FALSE
  )
  if (!valide) {
    file.copy(bak, qfile, overwrite = TRUE)
    file.remove(bak)
    cli::cli_alert_danger("Édition automatique impossible : `_quarto.yml` a été restauré tel quel.")
    cli::cli_text("Ajoutez ceci à la main sous `format: typst:` :")
    cli::cli_code(c("    font-paths:", "      - .quarto/typst/fonts", "      - _fonts"))
    return(invisible(FALSE))
  }

  cli::cli_alert_success("`font-paths` ajouté à `_quarto.yml` (contournement Quarto < {reco}).")
  cli::cli_alert_info("Sauvegarde : {.path {basename(qfile)}.avant-fontpaths}")
  invisible(TRUE)
}

#' Valider un fichier `_brand.yml`
#'
#' Vérifie qu'un `_brand.yml` est cohérent : schéma valide (via le paquet
#' `brand.yml`), références croisées (couleurs, polices, logo) et existence des
#' fichiers de polices `source: file`.
#'
#' @param chemin Chemin du fichier `_brand.yml`. Par défaut `"_brand.yml"`.
#'
#' @return Invisiblement, `TRUE` si tout est cohérent, `FALSE` sinon.
#' @export
#'
#' @examplesIf interactive()
#' valider_brand()
valider_brand <- function(chemin = "_brand.yml") {
  if (!file.exists(chemin)) {
    cli::cli_abort("Fichier {.path {chemin}} introuvable.")
  }
  chemin <- xfun::normalize_path(chemin, must_work = TRUE)
  base_dir <- dirname(chemin)

  cli::cli_h2("Validation de {.path {basename(chemin)}}")

  schema_ok <- tryCatch(
    {
      brand.yml::read_brand_yml(chemin)
      TRUE
    },
    error = function(e) {
      cli::cli_alert_danger("Schéma invalide : {conditionMessage(e)}")
      FALSE
    }
  )
  raw <- tryCatch(.lire_yaml(chemin), error = function(e) NULL)
  if (is.null(raw)) {
    cli::cli_alert_danger("YAML illisible.")
    return(invisible(FALSE))
  }

  probs <- character(0)
  # Valeur traitée comme une couleur littérale (et non une clé de palette) :
  # hex (#…), fonctions CSS (rgb()/hsl()), ou nom de couleur CSS courant.
  noms_css <- c(
    "black", "white", "red", "green", "blue", "yellow", "orange", "purple",
    "gray", "grey", "cyan", "magenta", "transparent"
  )
  est_couleur <- function(x) {
    is.character(x) && length(x) == 1 &&
      (grepl("^#", x) || grepl("\\(", x) || tolower(x) %in% noms_css)
  }

  # Couleurs : primary/foreground/background -> clé de palette (si bareword)
  palette <- names(raw$color$palette %||% list())
  for (slot in c("primary", "foreground", "background")) {
    v <- raw$color[[slot]]
    if (!is.null(v) && !est_couleur(v) && !(v %in% palette)) {
      probs <- c(probs, sprintf(
        "color.%s = '%s' ne correspond à aucune couleur de la palette.", slot, v
      ))
    }
  }

  # Polices : base/headings -> familles déclarées ; fichiers source:file existent
  fonts <- raw$typography$fonts %||% list()
  familles <- vapply(fonts, function(f) f$family %||% NA_character_, character(1))
  for (slot in c("base", "headings")) {
    v <- raw$typography[[slot]]
    # `base`/`headings` acceptent la forme courte ("Inter") ou la forme
    # étendue (`family:` + `color:`, `weight:`...). On valide la famille.
    fam <- if (is.list(v)) v$family else v
    if (is.character(fam) && length(fam) == 1 && !(fam %in% familles)) {
      probs <- c(probs, sprintf(
        "typography.%s = '%s' n'est pas une famille déclarée.", slot, fam
      ))
    }
  }
  for (f in fonts) {
    if (identical(f$source, "file")) {
      for (entry in f$files %||% list()) {
        p <- if (is.list(entry)) entry$path else entry
        if (is.character(p) && length(p) == 1 && !file.exists(file.path(base_dir, p))) {
          probs <- c(probs, sprintf("police introuvable : %s", p))
        }
      }
    }
  }

  # Logo : medium -> clé d'images (si bareword, pas un chemin)
  m <- raw$logo$medium
  if (is.character(m) && length(m) == 1 && !grepl("[/.]", m)) {
    imgs <- names(raw$logo$images %||% list())
    if (!(m %in% imgs)) {
      probs <- c(probs, sprintf(
        "logo.medium = '%s' ne correspond à aucune image déclarée.", m
      ))
    }
  }

  if (length(probs) == 0 && schema_ok) {
    cli::cli_alert_success("Charte valide : références et fichiers cohérents.")
    return(invisible(TRUE))
  }
  for (p in probs) cli::cli_alert_danger(p)
  if (length(probs) == 0 && !schema_ok) {
    cli::cli_alert_danger("Charte invalide (voir l'erreur de schéma ci-dessus).")
  }
  invisible(FALSE)
}
