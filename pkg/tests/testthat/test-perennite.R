test_that("creer_projet_typst() crée un document", {
  d <- withr::local_tempdir()
  p <- creer_projet_typst(file.path(d, "doc"))
  expect_true(file.exists(file.path(p, "rapport.qmd")))
  expect_true(file.exists(file.path(p, "_brand.yml")))
  contenu <- paste(readLines(file.path(p, "rapport.qmd")), collapse = "\n")
  expect_match(contenu, "typst")
  expect_match(contenu, "papersize: a4")
})

test_that("creer_projet_typst() crée un livre", {
  d <- withr::local_tempdir()
  p <- creer_projet_typst(file.path(d, "livre"), type = "livre")
  expect_true(file.exists(file.path(p, "_quarto.yml")))
  expect_true(file.exists(file.path(p, "index.qmd")))
  expect_true(file.exists(file.path(p, "01-chapitre.qmd")))
  expect_match(paste(readLines(file.path(p, "_quarto.yml")), collapse = "\n"), "type: book")
})

test_that("creer_projet_typst(offline = TRUE) embarque Inter en local", {
  d <- withr::local_tempdir()
  p <- creer_projet_typst(file.path(d, "off"), offline = TRUE)
  expect_true(file.exists(file.path(p, "_fonts", "Inter-Regular.ttf")))
  expect_match(paste(readLines(file.path(p, "_brand.yml")), collapse = "\n"), "source: file")
})

test_that("creer_projet_typst() refuse un dossier non vide", {
  d <- withr::local_tempdir()
  dir.create(file.path(d, "plein"))
  writeLines("x", file.path(d, "plein", "f.txt"))
  expect_error(creer_projet_typst(file.path(d, "plein")), "existe d")
})

test_that("basculer_charte() applique une variante et sauvegarde", {
  d <- withr::local_tempdir()
  writeLines("ancienne", file.path(d, "_brand.yml"))
  basculer_charte("jedi", projet = d)
  contenu <- paste(readLines(file.path(d, "_brand.yml"), warn = FALSE), collapse = "\n")
  expect_match(contenu, "r2-blue")
  expect_true(file.exists(file.path(d, "_brand.yml.avant-jedi")))
})

test_that("comparer_chartes() renvoie les couleurs principales nommées", {
  cols <- comparer_chartes()
  expect_setequal(names(cols), c("empire", "jedi", "mando"))
  expect_match(cols[["empire"]], "^#")
})

test_that("ouvrir_correction() renvoie l'URL en ligne", {
  url <- ouvrir_correction("02", je_confirme = TRUE)
  expect_match(url, "02-projet-book/correction$")
})

test_that("recuperer_correction() copie les sources de la correction", {
  dest <- withr::local_tempdir()
  chemin <- recuperer_correction("02", dest = dest, force = TRUE)
  expect_true(dir.exists(chemin))
  expect_match(chemin, "02-projet-book/correction$")
  # sources présentes, pas d'artefact de rendu embarqué
  expect_true(file.exists(file.path(chemin, "_quarto.yml")))
  expect_true(file.exists(file.path(chemin, "index.qmd")))
  expect_length(list.files(chemin, pattern = "\\.(pdf|typ)$", recursive = TRUE), 0)
})

test_that("recuperer_correction() annule sans confirmation en non-interactif", {
  dest <- withr::local_tempdir()
  expect_error(recuperer_correction("01", dest = dest), "annul")
})

test_that("recuperer_correction() refuse d'écraser sans force", {
  dest <- withr::local_tempdir()
  recuperer_correction("01", dest = dest, force = TRUE)
  expect_error(recuperer_correction("01", dest = dest), "existe d")
})

test_that("exporter_diagnostic() affiche le diagnostic et peut l'écrire", {
  d <- withr::local_tempdir()
  f <- file.path(d, "diag.txt")
  lignes <- exporter_diagnostic(f)
  expect_match(paste(lignes, collapse = "\n"), "Diagnostic tutoquartotypst")
  expect_true(file.exists(f)) # écriture optionnelle quand `fichier` est fourni
  expect_match(paste(readLines(f), collapse = "\n"), "Diagnostic tutoquartotypst")
})
