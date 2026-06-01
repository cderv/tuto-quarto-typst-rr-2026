test_that("lister_exercices() renvoie les trois exercices", {
  codes <- lister_exercices()
  expect_setequal(
    codes,
    c("00-test-install", "01-document-typst", "02-projet-book")
  )
})

test_that("par_ou_commencer() détecte les exercices installés", {
  dest <- withr::local_tempdir()
  installer_exercices(dest, quels = "01")
  # Quarto + paquets présents dans cet environnement -> étape « démarrer ».
  skip_if_no_quarto()
  expect_identical(par_ou_commencer(dest), "demarrer")
})

test_that("diagnostiquer_rendu() classe l'avertissement de police comme bénin", {
  expect_identical(
    diagnostiquer_rendu("Error: unknown font family 'Inter'"),
    "benin"
  )
})

test_that("diagnostiquer_rendu() repère un Typst absent comme bloquant", {
  expect_identical(
    diagnostiquer_rendu("Typst executable not found"),
    "bloquant"
  )
})

test_that("diagnostiquer_rendu() repère un _brand.yml introuvable", {
  expect_identical(
    diagnostiquer_rendu("Error: file not found: _brand.yml"),
    "bloquant"
  )
})

test_that("diagnostiquer_rendu() repère une erreur de syntaxe YAML", {
  expect_identical(
    diagnostiquer_rendu("yaml parse error: did not find expected key"),
    "bloquant"
  )
})
