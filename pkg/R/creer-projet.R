# Lot 3 — pérennité : réutiliser Quarto + Typst après le tutoriel.

# Charte générique (non Star Wars) à adapter. `offline = TRUE` -> Inter en local.
.brand_generique <- function(offline = FALSE) {
  inter <- if (offline) {
    c(
      "    - family: Inter",
      "      source: file",
      "      files:",
      "        - path: _fonts/Inter-Regular.ttf",
      "          weight: 400",
      "        - path: _fonts/Inter-SemiBold.ttf",
      "          weight: 600",
      "        - path: _fonts/Inter-Bold.ttf",
      "          weight: 700"
    )
  } else {
    c(
      "    - family: Inter",
      "      source: google",
      "      weight: [400, 600]"
    )
  }
  c(
    "# Charte (brand.yml) — adaptez couleurs et polices à votre projet.",
    "# Doc : https://posit-dev.github.io/brand-yml/",
    "color:",
    "  palette:",
    "    principale: \"#2C3E50\"",
    "    accent:     \"#18BC9C\"",
    "  primary:    principale",
    "  foreground: \"#222222\"",
    "  background: \"#FFFFFF\"",
    "",
    "typography:",
    "  fonts:",
    inter,
    "  base: Inter",
    "  headings: Inter"
  )
}

#' Créer un projet Quarto + Typst réutilisable
#'
#' Génère un squelette de projet Typst prêt à l'emploi (hors thème Star Wars),
#' pour réutiliser ce que vous avez appris **après** le tutoriel : un document
#' ou un livre, avec une charte `_brand.yml` à adapter. Sur Quarto < 1.10.4, le
#' contournement `font-paths` est ajouté automatiquement aux projets livre.
#'
#' @param dest Dossier à créer pour le projet.
#' @param type `"document"` (défaut) pour un `.qmd` unique, ou `"livre"` pour un
#'   projet livre multi-chapitres.
#' @param brand Logique. Inclure une charte `_brand.yml` à adapter ? Défaut `TRUE`.
#' @param offline Logique. Inclure les polices Inter en local (`source: file`) ?
#'   Défaut `FALSE`.
#'
#' @return Invisiblement, le chemin absolu du projet créé.
#' @export
#'
#' @examplesIf interactive()
#' creer_projet_typst("mon-rapport")
#' creer_projet_typst("mon-livre", type = "livre")
creer_projet_typst <- function(dest,
                               type = c("document", "livre"),
                               brand = TRUE,
                               offline = FALSE) {
  type <- match.arg(type)
  dest_abs <- normalizePath(dest, winslash = "/", mustWork = FALSE)
  if (dir.exists(dest_abs) && length(list.files(dest_abs)) > 0) {
    cli::cli_abort("Le dossier {.path {dest_abs}} existe déjà et n'est pas vide.")
  }
  dir.create(dest_abs, recursive = TRUE, showWarnings = FALSE)

  ecrire <- function(nom, lignes) xfun::write_utf8(lignes, file.path(dest_abs, nom))

  recent <- {
    v <- tryCatch(quarto::quarto_version(), error = function(e) NA)
    length(v) == 1 && !is.na(v) && v >= .quarto_reco
  }

  if (brand) {
    ecrire("_brand.yml", .brand_generique(offline))
  }
  if (offline) {
    fdir <- file.path(dest_abs, "_fonts")
    dir.create(fdir, showWarnings = FALSE)
    src <- .dossier_offline_paquet()
    for (f in names(.inter_offline)) {
      file.copy(file.path(src, f), file.path(fdir, f), overwrite = TRUE)
    }
  }

  if (type == "document") {
    ecrire("rapport.qmd", c(
      "---",
      "title: \"Mon rapport\"",
      "author: \"Votre nom\"",
      "date: today",
      "format:",
      "  typst:",
      "    papersize: a4",
      "---",
      "",
      "## Introduction",
      "",
      "Votre contenu ici. Modifiez `_brand.yml` pour changer l'identité visuelle.",
      ""
    ))
  } else {
    fontpaths <- if (!recent) {
      c(
        "    # Contournement font-paths (Quarto < 1.10.4) :",
        "    font-paths:",
        "      - .quarto/typst/fonts",
        "      - _fonts"
      )
    } else {
      character(0)
    }
    ecrire("_quarto.yml", c(
      "project:",
      "  type: book",
      "",
      "lang: fr",
      "",
      "book:",
      "  title: \"Mon livre\"",
      "  author: \"Votre nom\"",
      "  chapters:",
      "    - index.qmd",
      "    - 01-chapitre.qmd",
      "",
      "format:",
      "  typst:",
      "    papersize: a4",
      fontpaths
    ))
    ecrire("index.qmd", c(
      "# Préface {.unnumbered}",
      "",
      "Bienvenue dans votre livre Typst. Adaptez `_brand.yml` et les chapitres.",
      ""
    ))
    ecrire("01-chapitre.qmd", c(
      "# Premier chapitre",
      "",
      "Votre contenu ici.",
      ""
    ))
  }

  cli::cli_alert_success("Projet {type} créé : {.path {dest_abs}}")
  cli::cli_alert_info("Rendez-le avec {.code quarto render} dans ce dossier.")
  .ouvrir_dossier(dest_abs)
  invisible(dest_abs)
}

#' Appliquer une variante de charte Star Wars
#'
#' Dépose l'une des chartes thématiques (`empire`, `jedi`, `mando`) comme
#' `_brand.yml` du projet, pour illustrer qu'**un même projet change d'identité
#' en changeant simplement de charte**. À utiliser **après** l'exercice. Votre
#' `_brand.yml` est sauvegardé avant remplacement.
#'
#' @param variante `"empire"` (défaut), `"jedi"` ou `"mando"`.
#' @param projet Dossier du projet. Par défaut le répertoire courant.
#'
#' @return Invisiblement, le chemin du `_brand.yml`.
#' @export
#'
#' @examplesIf interactive()
#' basculer_charte("jedi")
basculer_charte <- function(variante = c("empire", "jedi", "mando"),
                            projet = ".") {
  variante <- match.arg(variante)
  src <- file.path(
    system.file("templates", "brands", package = "tutotypst"),
    paste0("_brand-", variante, ".yml")
  )
  if (!file.exists(src)) {
    cli::cli_abort("Variante {.val {variante}} introuvable dans le paquet.")
  }
  cli::cli_alert_info("Astuce : cette fonction est pensée pour {.strong après} l'exercice 2.")
  projet <- normalizePath(projet, winslash = "/", mustWork = FALSE)
  brand <- file.path(projet, "_brand.yml")
  if (file.exists(brand)) {
    file.copy(brand, paste0(brand, ".avant-", variante), overwrite = TRUE)
    cli::cli_alert_info("Sauvegarde : {.path _brand.yml.avant-{variante}}")
  }
  file.copy(src, brand, overwrite = TRUE)
  cli::cli_alert_success("Charte {.strong {variante}} appliquée. Re-rendez pour voir le changement.")
  invisible(brand)
}

#' Comparer les couleurs des variantes de charte
#'
#' Affiche la couleur principale (`primary`) de chaque variante de charte, avec
#' un aperçu coloré (si votre console le supporte).
#'
#' @return Invisiblement, un vecteur nommé des couleurs principales.
#' @export
#'
#' @examples
#' comparer_chartes()
comparer_chartes <- function() {
  brands_dir <- system.file("templates", "brands", package = "tutotypst")
  variantes <- c("empire", "jedi", "mando")
  couleurs <- vapply(variantes, function(v) {
    raw <- .lire_yaml(file.path(brands_dir, paste0("_brand-", v, ".yml")))
    raw$color$palette[[raw$color$primary]]
  }, character(1))

  cli::cli_h2("Couleurs principales des variantes")
  cli::cli_ul()
  for (v in variantes) {
    cli::cli_li("{.strong {v}} : {couleurs[[v]]}")
  }
  cli::cli_end()
  if (rlang::is_installed("prismatic")) {
    print(prismatic::color(couleurs)) # couleurs est déjà nommé (empire/jedi/mando)
  }
  invisible(couleurs)
}
