test_that("installer_exercices() copie les starters", {
  dest <- withr::local_tempdir()
  chemin <- installer_exercices(file.path(dest, "exos"), force = TRUE)
  expect_true(dir.exists(chemin))
  expect_true(file.exists(file.path(
    chemin, "01-document-typst", "starter", "rapport-starwars.qmd"
  )))
  expect_true(file.exists(file.path(chemin, "00-test-install", "test-install.qmd")))
})

test_that("installer_exercices() utilise le dossier par défaut dans le cwd", {
  # withr::local_dir : se place dans un dossier temporaire et restaure le cwd
  # à la fin du test (permet de tester le défaut dest = "exercices-typst").
  withr::local_dir(withr::local_tempdir())
  installer_exercices(quels = "01", force = TRUE)
  expect_true(dir.exists(file.path("exercices-typst", "01-document-typst")))
})

test_that("le starter du livre reste à l'état « avant »", {
  dest <- withr::local_tempdir()
  chemin <- installer_exercices(dest, quels = "02", force = TRUE)
  starter <- file.path(chemin, "02-projet-book", "starter")
  # Pas de _quarto.yml ni _brand*.yml : le participant doit les créer.
  expect_false(file.exists(file.path(starter, "_quarto.yml")))
  expect_length(list.files(starter, pattern = "^_brand.*\\.ya?ml$"), 0)
})

test_that("installer_exercices() refuse d'écraser sans force", {
  dest <- withr::local_tempdir()
  installer_exercices(dest, quels = "01", force = TRUE)
  expect_error(installer_exercices(dest, quels = "01"), "existe d")
})

test_that("installer_exercices() annule sans confirmation en non-interactif", {
  dest <- withr::local_tempdir()
  expect_error(
    installer_exercices(file.path(dest, "exos"), quels = "01"),
    "annul"
  )
})

test_that(".choisir_dossier_dest() renvoie le défaut en non-interactif", {
  expect_identical(.choisir_dossier_dest("exercices-typst", force = FALSE), "exercices-typst")
  expect_identical(.choisir_dossier_dest("autre", force = TRUE), "autre")
})

test_that("installer_exercices() sans dest s'annule en non-interactif sans force", {
  # dest = NULL -> repli sur "exercices-typst" puis confirmation requise.
  withr::local_dir(withr::local_tempdir())
  expect_error(installer_exercices(quels = "01"), "annul")
})

test_that("reinitialiser_exercice() sauvegarde avant de restaurer", {
  dest <- withr::local_tempdir()
  installer_exercices(dest, quels = "01", force = TRUE)
  qmd <- file.path(dest, "01-document-typst", "starter", "rapport-starwars.qmd")
  writeLines("casse", qmd)
  reinitialiser_exercice("01", dossier = dest, force = TRUE)
  # une sauvegarde a été créée
  expect_gt(length(list.files(dest, pattern = "sauvegarde")), 0)
  # le fichier est restauré (n'est plus la version cassée)
  expect_false(identical(readLines(qmd, warn = FALSE), "casse"))
})
