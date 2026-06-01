# Régénère pkg/inst/exercices/ depuis la SOURCE DE VÉRITÉ : exercises/ (racine du repo).
#
# IMPORTANT — renommage assumé : `exercises/` (repo, anglais) -> `inst/exercices/`
# (paquet, français). `system.file("exercices", package = "tutotypst")` doit matcher
# le dossier généré ici. Ne « corrigez » pas l'un sans l'autre.
#
# On ne copie QUE les `starter/` (état « avant » des exercices) + le test d'install.
# Les corrections restent en ligne sur le site (cf. .claude/CLAUDE.md). On exclut tout
# artefact de rendu (.quarto/, *_files/, *.typ, *.pdf rendus) — SAUF charte-starwars.pdf
# (référence visuelle versionnée).
#
# Lancer depuis la racine du repo :  Rscript pkg/data-raw/sync-exercices.R
# ou via :                           just pkg-sync

# --- localiser la racine du repo (dossier contenant exercises/ ET pkg/) -----------
find_repo_root <- function(start = getwd()) {
  dir <- normalizePath(start, winslash = "/", mustWork = TRUE)
  repeat {
    if (dir.exists(file.path(dir, "exercises")) && dir.exists(file.path(dir, "pkg"))) {
      return(dir)
    }
    parent <- dirname(dir)
    if (identical(parent, dir)) {
      stop("Racine du repo introuvable (dossiers 'exercises/' et 'pkg/' attendus).")
    }
    dir <- parent
  }
}

root    <- find_repo_root()
src     <- file.path(root, "exercises")
dest    <- file.path(root, "pkg", "inst", "exercices")

# Artefacts de rendu à ne jamais embarquer dans inst/.
is_artifact <- function(paths) {
  grepl("(^|/)\\.quarto(/|$)", paths) |
    grepl("(^|/)_book(/|$)", paths) |
    grepl("_files(/|$)", paths) |
    grepl("\\.typ$", paths) |
    grepl("(^|/)\\.DS_Store$", paths) |
    grepl("(^|/)\\.gitignore$", paths) |
    # tout PDF rendu, sauf la charte de référence (versionnée)
    (grepl("\\.pdf$", paths) & !grepl("charte-starwars\\.pdf$", paths))
}

copy_tree <- function(from, to) {
  files <- list.files(from, recursive = TRUE, all.files = TRUE, no.. = TRUE)
  files <- files[!is_artifact(files)]
  for (f in files) {
    target <- file.path(to, f)
    dir.create(dirname(target), recursive = TRUE, showWarnings = FALSE)
    file.copy(file.path(from, f), target, overwrite = TRUE, copy.mode = FALSE)
  }
  length(files)
}

# --- repartir propre --------------------------------------------------------------
if (dir.exists(dest)) unlink(dest, recursive = TRUE)
dir.create(dest, recursive = TRUE, showWarnings = FALSE)

# --- 00 : test d'installation (fichier nu) ----------------------------------------
dir.create(file.path(dest, "00-test-install"), showWarnings = FALSE)
invisible(file.copy(
  file.path(src, "00-test-install", "test-install.qmd"),
  file.path(dest, "00-test-install", "test-install.qmd"),
  overwrite = TRUE, copy.mode = FALSE
))

# --- 01 et 02 : uniquement les starter/ -------------------------------------------
exos <- c("01-document-typst", "02-projet-book")
total <- 1L
for (exo in exos) {
  from <- file.path(src, exo, "starter")
  to   <- file.path(dest, exo, "starter")
  n <- copy_tree(from, to)
  total <- total + n
  message(sprintf("  %s/starter : %d fichiers", exo, n))
}

message(sprintf("\nSync exercices : %d fichiers dans %s", total,
                sub(paste0(root, "/"), "", dest, fixed = TRUE)))

# --- assets du paquet (lot 2/3) : variantes de charte + polices Inter ----------
# Maintenus alignés sur exercises/ (garde-fou CI). Voir .github/workflows.
brands_dest <- file.path(root, "pkg", "inst", "templates", "brands")
dir.create(brands_dest, recursive = TRUE, showWarnings = FALSE)
for (v in c("empire", "jedi", "mando")) {
  invisible(file.copy(
    file.path(src, "02-projet-book", "correction", paste0("_brand-", v, ".yml")),
    file.path(brands_dest, paste0("_brand-", v, ".yml")),
    overwrite = TRUE, copy.mode = FALSE
  ))
}
offline_dest <- file.path(root, "pkg", "inst", "offline", "_fonts")
dir.create(offline_dest, recursive = TRUE, showWarnings = FALSE)
for (f in c("Inter-Regular.ttf", "Inter-SemiBold.ttf", "Inter-Bold.ttf")) {
  invisible(file.copy(
    file.path(src, "01-document-typst", "correction", "_fonts", f),
    file.path(offline_dest, f),
    overwrite = TRUE, copy.mode = FALSE
  ))
}
message("Sync assets paquet : 3 variantes de charte + 3 polices Inter.")
