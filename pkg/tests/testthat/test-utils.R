# Helpers d'I/O interactifs : on pilote l'interactivité avec rlang::local_interactive()
# et on mocke rstudioapi / utils pour couvrir les branches SANS effet de bord réel.

test_that(".confirmer() suit la réponse du menu en interactif", {
  rlang::local_interactive(TRUE)
  local_mocked_bindings(menu = function(...) 1L, .package = "utils")
  expect_true(.confirmer("Continuer ?"))
})

test_that(".confirmer() renvoie FALSE si l'utilisateur répond Non", {
  rlang::local_interactive(TRUE)
  local_mocked_bindings(menu = function(...) 2L, .package = "utils")
  expect_false(.confirmer("Continuer ?"))
})

test_that(".ouvrir_fichier() emprunte rstudioapi quand disponible", {
  local_mocked_bindings(
    isAvailable = function(...) TRUE,
    hasFun = function(...) TRUE,
    navigateToFile = function(...) invisible(),
    .package = "rstudioapi"
  )
  expect_true(.ouvrir_fichier(tempfile()))
})

test_that(".ouvrir_fichier() ouvre dans l'éditeur en interactif (hors RStudio)", {
  rlang::local_interactive(TRUE)
  local_mocked_bindings(isAvailable = function(...) FALSE, .package = "rstudioapi")
  local_mocked_bindings(file.edit = function(...) invisible(), .package = "utils")
  expect_true(.ouvrir_fichier(tempfile()))
})

test_that(".ouvrir_fichier() ne fait rien en non-interactif", {
  rlang::local_interactive(FALSE)
  local_mocked_bindings(isAvailable = function(...) FALSE, .package = "rstudioapi")
  expect_false(.ouvrir_fichier(tempfile()))
})

test_that(".ouvrir_dossier() emprunte rstudioapi quand disponible", {
  local_mocked_bindings(
    isAvailable = function(...) TRUE,
    hasFun = function(...) TRUE,
    filesPaneNavigate = function(...) invisible(),
    .package = "rstudioapi"
  )
  expect_true(.ouvrir_dossier(withr::local_tempdir()))
})

test_that(".ouvrir_dossier() utilise browseURL en interactif (hors RStudio)", {
  rlang::local_interactive(TRUE)
  local_mocked_bindings(isAvailable = function(...) FALSE, .package = "rstudioapi")
  local_mocked_bindings(browseURL = function(...) invisible(), .package = "utils")
  expect_true(.ouvrir_dossier(withr::local_tempdir()))
})
