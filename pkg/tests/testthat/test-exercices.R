test_that("installer_exercices() copie les starters", {
  dest <- withr::local_tempdir()
  chemin <- suppressMessages(installer_exercices(file.path(dest, "exos"), force = TRUE))
  expect_true(dir.exists(chemin))
  expect_true(file.exists(file.path(
    chemin, "01-document-typst", "starter", "rapport-starwars.qmd"
  )))
  expect_true(file.exists(file.path(chemin, "00-test-install", "test-install.qmd")))
})

test_that("installer_exercices() ne pose JAMAIS les corrections", {
  # Les corrections se consultent en ligne (ouvrir_correction) ou se copient à
  # la demande (recuperer_correction) — installer_exercices ne doit poser que
  # les starters. Garde-fou contre une régression de la copie récursive.
  dest <- withr::local_tempdir()
  chemin <- suppressMessages(installer_exercices(dest, force = TRUE))
  for (exo in c("01-document-typst", "02-projet-book")) {
    expect_false(
      dir.exists(file.path(chemin, exo, "correction")),
      info = exo
    )
  }
  expect_length(list.files(chemin, pattern = "correction", recursive = TRUE), 0)
})

test_that("installer_exercices() utilise le dossier par défaut dans le cwd", {
  # withr::local_dir : se place dans un dossier temporaire et restaure le cwd
  # à la fin du test (permet de tester le défaut dest = "exercices-typst").
  withr::local_dir(withr::local_tempdir())
  suppressMessages(installer_exercices(quels = "01", force = TRUE))
  expect_true(dir.exists(file.path("exercices-typst", "01-document-typst")))
})

test_that("le starter du livre reste à l'état « avant »", {
  dest <- withr::local_tempdir()
  chemin <- suppressMessages(installer_exercices(dest, quels = "02", force = TRUE))
  starter <- file.path(chemin, "02-projet-book", "starter")
  # Pas de _quarto.yml ni _brand*.yml : le participant doit les créer.
  expect_false(file.exists(file.path(starter, "_quarto.yml")))
  expect_length(list.files(starter, pattern = "^_brand.*\\.ya?ml$"), 0)
})

test_that("installer_exercices() refuse d'écraser sans force", {
  dest <- withr::local_tempdir()
  suppressMessages(installer_exercices(dest, quels = "01", force = TRUE))
  expect_error(installer_exercices(dest, quels = "01"), "existe d")
})

test_that("installer_exercices() annule sans confirmation en non-interactif", {
  dest <- withr::local_tempdir()
  expect_error(
    suppressMessages(installer_exercices(file.path(dest, "exos"), quels = "01")),
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
  expect_error(suppressMessages(installer_exercices(quels = "01")), "annul")
})

test_that("reinitialiser_exercice() sauvegarde avant de restaurer", {
  dest <- withr::local_tempdir()
  suppressMessages(installer_exercices(dest, quels = "01", force = TRUE))
  qmd <- file.path(dest, "01-document-typst", "starter", "rapport-starwars.qmd")
  writeLines("casse", qmd)
  suppressMessages(reinitialiser_exercice("01", dossier = dest, force = TRUE))
  # une sauvegarde a été créée
  expect_gt(length(list.files(dest, pattern = "sauvegarde")), 0)
  # le fichier est restauré (n'est plus la version cassée)
  expect_false(identical(readLines(qmd, warn = FALSE), "casse"))
  # la réinitialisation ne ramène pas non plus la correction
  expect_false(dir.exists(file.path(dest, "01-document-typst", "correction")))
})

test_that("installer_exercices() n'avertit sur correction/ que si elle est présente", {
  # Pas de correction posée -> pas d'avertissement trompeur (le défaut).
  dest <- withr::local_tempdir()
  out <- cli::cli_fmt(installer_exercices(file.path(dest, "exos"), quels = "01", force = TRUE))
  expect_false(any(grepl("correction", out)))

  # Une correction présente en local (p. ex. via recuperer_correction()) ->
  # l'avertissement réapparaît à la réinstallation.
  chemin <- file.path(dest, "exos")
  dir.create(file.path(chemin, "01-document-typst", "correction"), recursive = TRUE)
  out2 <- cli::cli_fmt(installer_exercices(chemin, quels = "01", force = TRUE))
  expect_true(any(grepl("N'ouvrez pas les dossiers", out2)))
})

test_that("basculer_hors_ligne() guide quand _brand.yml n'existe pas encore", {
  # Le starter de l'exo 1 n'a pas de _brand.yml (ajouté aux étapes 3-4) : le
  # message doit l'expliquer plutôt que de suggérer un mauvais répertoire.
  dest <- withr::local_tempdir()
  starter <- file.path(dest, "01-document-typst", "starter")
  suppressMessages(installer_exercices(dest, quels = "01", force = TRUE))
  expect_false(file.exists(file.path(starter, "_brand.yml")))
  expect_error(basculer_hors_ligne(starter), "charte|étapes 3-4")
})

test_that(".racine_install_exo() retrouve la racine d'installation", {
  # On part d'un vrai tempdir (chemin absolu valide sur tous les OS) plutôt que
  # d'un littéral POSIX "/home/u/..." : sous Windows ce dernier, sans lettre de
  # lecteur, est traité comme relatif au disque courant et normalize_path() lui
  # préfixe "D:/" -> le test cassait sur le builder Windows r-universe.
  racine <- withr::local_tempdir()
  starter <- file.path(racine, "01-document-typst", "starter")
  dir.create(starter, recursive = TRUE)
  # cwd à l'intérieur d'un exercice -> racine = le dossier qui contient <exo>
  expect_identical(
    .racine_install_exo("01-document-typst", wd = starter),
    xfun::normalize_path(racine)
  )
  # cwd sans rapport avec un exercice installé -> NULL (repli sur le défaut)
  expect_null(.racine_install_exo("01-document-typst", wd = withr::local_tempdir()))
})

test_that("reinitialiser_exercice() lancée depuis le starter n'imbrique rien", {
  # Reproduit le piège : lancée depuis .../<exo>/starter avec le `dossier` par
  # défaut, elle visait jadis .../starter/exercices-typst/... (imbriqué).
  dest <- withr::local_tempdir()
  suppressMessages(installer_exercices(dest, quels = "01", force = TRUE))
  starter <- file.path(dest, "01-document-typst", "starter")
  writeLines("casse", file.path(starter, "rapport-starwars.qmd"))
  withr::with_dir(starter, {
    suppressMessages(reinitialiser_exercice(force = TRUE))
  })
  # Aucune arborescence imbriquée sous le starter
  expect_false(dir.exists(file.path(starter, "exercices-typst")))
  # Le fichier a bien été restauré au bon endroit
  expect_false(identical(
    readLines(file.path(starter, "rapport-starwars.qmd"), warn = FALSE), "casse"
  ))
  # Une sauvegarde du dossier d'exercice a été créée à la racine d'install
  expect_gt(length(list.files(dest, pattern = "sauvegarde")), 0)
})

test_that("installer_exercices() pose les assets racine de l'exo 2 (fallback sans Bloc 1)", {
  # `_brand-starter.yml` (+ `_logo-sw.svg`, `_brand-offline.yml`) vivent à la
  # racine de l'exo : nécessaires à l'étape 3 / au fallback sans Bloc 1 / au plan B
  # hors-ligne. Ils doivent être POSÉS par le paquet, pas seulement disponibles
  # sur GitHub. Garde-fou contre une régression du sync (cf. data-raw/sync-exercices.R).
  dest <- withr::local_tempdir()
  chemin <- suppressMessages(installer_exercices(dest, quels = "02", force = TRUE))
  exo <- file.path(chemin, "02-projet-book")
  expect_true(file.exists(file.path(exo, "_brand-starter.yml")))
  expect_true(file.exists(file.path(exo, "_logo-sw.svg")))
  expect_true(file.exists(file.path(exo, "_brand-offline.yml")))
  # ... mais toujours pas la correction.
  expect_false(dir.exists(file.path(exo, "correction")))
})
