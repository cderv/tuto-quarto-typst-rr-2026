test_that("verifier_r() valide un R récent", {
  expect_true(verifier_r())
})

test_that("verifier_paquets() détecte que les prérequis sont installés", {
  # Les Imports du paquet incluent tous les prérequis : ils sont donc présents
  # dès que le paquet se charge.
  expect_true(verifier_paquets())
})

test_that("verifier_rendu(FALSE) ne fait aucun rendu", {
  expect_true(is.na(verifier_rendu(tester_rendu = FALSE)))
})

test_that("verifier_quarto() renvoie un logique", {
  skip_if_not(
    !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL)),
    "Quarto absent"
  )
  expect_type(verifier_quarto(), "logical")
})
