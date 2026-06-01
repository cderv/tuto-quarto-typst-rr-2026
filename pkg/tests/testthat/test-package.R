test_that("le paquet expose son nom", {
  expect_true(nzchar(utils::packageDescription("tutotypst")$Package))
})

test_that("les exercices sont embarqués dans le paquet", {
  racine <- .dossier_exercices_paquet()
  expect_true(dir.exists(racine))
  expect_true(file.exists(file.path(racine, "00-test-install", "test-install.qmd")))
})
