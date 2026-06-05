test_that("verifier_r() valide un R récent", {
  expect_true(suppressMessages(verifier_r()))
})

test_that("verifier_paquets() détecte que les prérequis sont installés", {
  # Les Imports du paquet incluent tous les prérequis : ils sont donc présents
  # dès que le paquet se charge.
  expect_true(suppressMessages(verifier_paquets()))
})

test_that("verifier_rendu(FALSE) ne fait aucun rendu", {
  expect_true(is.na(suppressMessages(verifier_rendu(tester_rendu = FALSE))))
})

test_that("verifier_quarto() renvoie un logique", {
  skip_if_no_quarto()
  expect_type(suppressMessages(verifier_quarto()), "logical")
})
