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

# Sorties contenant des valeurs non déterministes (versions, horodatage, chemins)
# -> on les masque via `transform` pour snapshotter quand même la STRUCTURE.

test_that("exporter_diagnostic() : structure stable (valeurs masquées)", {
  local_reproducible_output()
  scrub <- function(x) {
    x <- sub("(Diagnostic tutotypst).*", "\\1 <date>", x)
    x <- sub("(^R +:).*", "\\1 <R>", x)
    x <- sub("(^OS +:).*", "\\1 <OS>", x)
    x <- sub("(^Quarto +:).*", "\\1 <quarto>", x)
    x <- sub("(^ *chemin:).*", "\\1 <path>", x)
    sub("(^ *- \\S+ +:).*", "\\1 <version>", x)
  }
  expect_snapshot(exporter_diagnostic(), transform = scrub)
})

test_that("verifier_installation() : rapport stable (version R masquée)", {
  local_reproducible_output()
  f <- withr::local_tempfile()
  file.create(f)
  local_mocked_bindings(
    quarto_path = function(...) f,
    quarto_version = function(...) numeric_version("1.10.4"),
    .package = "quarto"
  )
  scrub <- function(x) sub("R [0-9][0-9.]* :", "R <version> :", x)
  expect_snapshot(verifier_installation(tester_rendu = FALSE), transform = scrub)
})

