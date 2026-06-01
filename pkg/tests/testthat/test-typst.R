test_that("nettoyer_cache() supprime les artefacts de rendu", {
  d <- withr::local_tempdir()
  dir.create(file.path(d, "_book"))
  dir.create(file.path(d, "rapport_files"))
  writeLines("x", file.path(d, "rapport.typ"))
  writeLines("garder", file.path(d, "rapport.qmd"))
  n <- nettoyer_cache(d)
  expect_gte(n, 3)
  expect_false(dir.exists(file.path(d, "_book")))
  expect_false(file.exists(file.path(d, "rapport.typ")))
  expect_true(file.exists(file.path(d, "rapport.qmd"))) # sources préservées
})

test_that("ouvrir_exercices() exige un dossier existant", {
  expect_error(ouvrir_exercices(file.path(withr::local_tempdir(), "absent")), "introuvable")
  d <- withr::local_tempdir()
  installer_exercices(file.path(d, "exos"), quels = "01")
  expect_identical(
    normalizePath(ouvrir_exercices(file.path(d, "exos")), winslash = "/"),
    normalizePath(file.path(d, "exos"), winslash = "/")
  )
})

test_that("polices_typst() liste des familles", {
  skip_if_not(
    !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL)),
    "Quarto absent"
  )
  familles <- polices_typst()
  expect_type(familles, "character")
  expect_gt(length(familles), 0)
})

test_that("diagnostic_typst() renvoie une liste", {
  skip_if_not(
    !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL)),
    "Quarto absent"
  )
  info <- diagnostic_typst(withr::local_tempdir())
  expect_type(info, "list")
  expect_true("quarto" %in% names(info))
})

test_that("inspecter_typ() produit un .typ", {
  skip_if_not(
    !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL)),
    "Quarto absent"
  )
  d <- withr::local_tempdir()
  qmd <- file.path(d, "test-install.qmd")
  file.copy(
    file.path(.dossier_exercices_paquet(), "00-test-install", "test-install.qmd"),
    qmd
  )
  typ <- inspecter_typ(qmd, ouvrir = FALSE)
  expect_true(!is.null(typ) && file.exists(typ))
})
