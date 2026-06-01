# Tests ciblant les branches non couvertes (mesuré via covr) :
# orchestrateur, rendu réel, branches d'erreur, modes dégradés.

# --- verifier_installation orchestrateur (était à 0 %) --------------------------
test_that("verifier_installation() s'exécute et renvoie un logique", {
  res <- verifier_installation(tester_rendu = FALSE)
  expect_type(res, "logical")
  expect_length(res, 1)
})

test_that("verifier_rendu() produit réellement un PDF", {
  skip_if_no_quarto()
  expect_true(verifier_rendu(tester_rendu = TRUE))
})

# --- verifier_quarto : toutes les branches (via mocking de quarto::) ------------
test_that("verifier_quarto() : Quarto introuvable -> FALSE", {
  local_mocked_bindings(quarto_path = function(...) NULL, .package = "quarto")
  expect_false(verifier_quarto())
})

test_that("verifier_quarto() : version illisible -> FALSE", {
  f <- withr::local_tempfile()
  file.create(f)
  local_mocked_bindings(
    quarto_path = function(...) f,
    quarto_version = function(...) NA,
    .package = "quarto"
  )
  expect_false(verifier_quarto())
})

test_that("verifier_quarto() : trop ancien (< 1.9) -> FALSE", {
  f <- withr::local_tempfile()
  file.create(f)
  local_mocked_bindings(
    quarto_path = function(...) f,
    quarto_version = function(...) numeric_version("1.5.0"),
    .package = "quarto"
  )
  expect_false(verifier_quarto())
})

test_that("verifier_quarto() : version recommandée -> TRUE", {
  f <- withr::local_tempfile()
  file.create(f)
  local_mocked_bindings(
    quarto_path = function(...) f,
    quarto_version = function(...) numeric_version("1.10.4"),
    .package = "quarto"
  )
  expect_true(verifier_quarto())
})

# --- verifier_paquets : branche « paquet manquant » ----------------------------
test_that("verifier_paquets() signale un prérequis manquant", {
  local_mocked_bindings(is_installed = function(...) FALSE, .package = "rlang")
  expect_false(verifier_paquets())
})

# --- par_ou_commencer : branches « installer » et « verifier » ------------------
test_that("par_ou_commencer() oriente vers l'installation des exercices", {
  skip_if_no_quarto()
  d <- file.path(withr::local_tempdir(), "absent")
  expect_identical(par_ou_commencer(d), "installer")
})

test_that("par_ou_commencer() oriente vers la vérification si Quarto manque", {
  local_mocked_bindings(quarto_path = function(...) NULL, .package = "quarto")
  expect_identical(par_ou_commencer(withr::local_tempdir()), "verifier")
})

# --- diagnostiquer_rendu : mode liste + erreur non reconnue ---------------------
test_that("diagnostiquer_rendu() sans argument liste les cas connus", {
  expect_null(diagnostiquer_rendu())
})

test_that("diagnostiquer_rendu() renvoie un vecteur vide pour une erreur inconnue", {
  expect_length(diagnostiquer_rendu("une erreur totalement inédite"), 0)
})

# --- appliquer_polices_locales : mode instruction (pas de bloc typst:) ----------
test_that("appliquer_polices_locales() bascule en mode instruction sans bloc typst", {
  d <- withr::local_tempdir()
  con <- file(file.path(d, "_quarto.yml"), open = "w", encoding = "UTF-8")
  writeLines(c("project:", "  type: book", "format: html"), con)
  close(con)
  expect_false(appliquer_polices_locales(d))
})

# --- valider_brand : YAML illisible ---------------------------------------------
test_that("valider_brand() rejette un YAML illisible", {
  d <- withr::local_tempdir()
  con <- file(file.path(d, "_brand.yml"), open = "w", encoding = "UTF-8")
  writeLines("color: [unclosed", con)
  close(con)
  expect_false(valider_brand(file.path(d, "_brand.yml")))
})

# --- nettoyer_cache : option polices --------------------------------------------
test_that("nettoyer_cache(polices = TRUE) vide le cache de polices", {
  d <- withr::local_tempdir()
  cache <- file.path(d, ".quarto", "typst", "fonts")
  dir.create(cache, recursive = TRUE)
  nettoyer_cache(d, polices = TRUE)
  expect_false(dir.exists(cache))
})

# --- inspecter_typ / polices_typst : erreurs ------------------------------------
test_that("inspecter_typ() échoue proprement sur un fichier absent", {
  expect_error(inspecter_typ(file.path(withr::local_tempdir(), "absent.qmd")), "introuvable")
})

test_that("polices_typst() échoue proprement si Quarto absent", {
  local_mocked_bindings(quarto_path = function(...) NULL, .package = "quarto")
  expect_error(polices_typst(), "introuvable")
})

# --- reinitialiser_exercice : restauration fraîche + refus non-interactif -------
test_that("reinitialiser_exercice() restaure même sans dossier préexistant", {
  d <- withr::local_tempdir()
  chemin <- reinitialiser_exercice("01", dossier = d, force = TRUE)
  expect_true(file.exists(file.path(chemin, "starter", "rapport-starwars.qmd")))
})

test_that("reinitialiser_exercice() refuse d'écraser sans force en non-interactif", {
  d <- withr::local_tempdir()
  installer_exercices(d, quels = "01")
  expect_error(reinitialiser_exercice("01", dossier = d, force = FALSE), "force")
})

# --- verifier_r : branche « R trop ancien » (mock getRversion) ------------------
test_that("verifier_r() échoue pour un R trop ancien", {
  local_mocked_bindings(getRversion = function() numeric_version("4.0.0"), .package = "base")
  expect_false(verifier_r())
})

# --- verifier_rendu : branche « aucun PDF produit » (mock quarto_render) ---------
test_that("verifier_rendu() signale l'absence de PDF", {
  skip_if_no_quarto()
  local_mocked_bindings(quarto_render = function(...) invisible(), .package = "quarto")
  expect_false(verifier_rendu(tester_rendu = TRUE))
})

# --- ouvrir_correction : refus et confirmation interactive ----------------------
test_that("ouvrir_correction() s'annule si l'utilisateur refuse", {
  rlang::local_interactive(TRUE)
  local_mocked_bindings(menu = function(...) 2L, .package = "utils")
  expect_null(ouvrir_correction("01"))
})

test_that("ouvrir_correction() ouvre l'URL une fois confirmée", {
  rlang::local_interactive(TRUE)
  local_mocked_bindings(menu = function(...) 1L, .package = "utils")
  local_mocked_bindings(browseURL = function(...) invisible(), .package = "utils")
  expect_match(ouvrir_correction("01"), "correction$")
})
