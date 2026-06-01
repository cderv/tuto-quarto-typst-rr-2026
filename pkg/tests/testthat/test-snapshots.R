# Snapshots des messages cli destinés aux participants (FR). local_reproducible_output()
# fige largeur + symboles ascii pour des snapshots stables multi-plateformes.
# Mise à jour volontaire des messages : testthat::snapshot_review().

test_that("diagnostiquer_rendu() : liste des cas connus (sortie stable)", {
  local_reproducible_output()
  expect_snapshot(diagnostiquer_rendu())
})

test_that("diagnostiquer_rendu() : avertissement de police (bénin)", {
  local_reproducible_output()
  expect_snapshot(diagnostiquer_rendu("Error: unknown font family 'Inter'"))
})

test_that("lister_exercices() : sortie stable", {
  local_reproducible_output()
  expect_snapshot(lister_exercices())
})
