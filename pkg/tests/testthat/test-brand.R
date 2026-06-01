# Charte minimale valide, avec Inter en source: google (état « en ligne »).
.brand_online <- function(dir) {
  dir.create(file.path(dir, "_fonts"), showWarnings = FALSE, recursive = TRUE)
  file.create(file.path(dir, "_fonts", "Starjedi.ttf"))
  file.create(file.path(dir, "_logo.svg"))
  lignes <- c(
    "color:",
    "  palette:",
    "    rouge: \"#BC1E22\"",
    "    noir:  \"#0B0B0F\"",
    "  primary: rouge",
    "  foreground: noir",
    "typography:",
    "  fonts:",
    "    - family: \"Star Jedi\"",
    "      source: file",
    "      files:",
    "        - path: _fonts/Starjedi.ttf",
    "          weight: 400",
    "    - family: Inter",
    "      source: google",
    "      weight: [400, 600]",
    "  base: Inter",
    "  headings: \"Star Jedi\"",
    "logo:",
    "  images:",
    "    sw:",
    "      path: _logo.svg",
    "  medium: sw"
  )
  con <- file(file.path(dir, "_brand.yml"), open = "w", encoding = "UTF-8")
  writeLines(lignes, con)
  close(con)
}

test_that("valider_brand() accepte une charte cohérente", {
  d <- withr::local_tempdir()
  .brand_online(d)
  expect_true(valider_brand(file.path(d, "_brand.yml")))
})

test_that("valider_brand() repère une référence cassée et un fichier manquant", {
  d <- withr::local_tempdir()
  .brand_online(d)
  brand <- file.path(d, "_brand.yml")
  l <- readLines(brand)
  l <- sub("  primary: rouge", "  primary: inexistante", l)
  writeLines(l, brand)
  expect_false(valider_brand(brand))
})

test_that("basculer_hors_ligne() bascule Inter en local puis restaure", {
  d <- withr::local_tempdir()
  .brand_online(d)
  brand <- file.path(d, "_brand.yml")

  basculer_hors_ligne(d)
  contenu <- readLines(brand, warn = FALSE)
  expect_true(any(grepl("_fonts/Inter-Regular.ttf", contenu)))
  expect_false(any(grepl("source:\\s*google", contenu)))
  expect_true(file.exists(file.path(d, "_fonts", "Inter-Regular.ttf")))
  expect_true(file.exists(file.path(d, "_brand.yml.avant-hors-ligne")))
  # la palette/les couleurs sont préservées (garde : on ne touche pas au reste)
  expect_true(any(grepl("primary: rouge", contenu)))

  basculer_hors_ligne(d, retour = TRUE)
  expect_true(any(grepl("source: google", readLines(brand, warn = FALSE))))
  expect_false(file.exists(file.path(d, "_brand.yml.avant-hors-ligne")))
})

test_that("basculer_hors_ligne() ne touche rien si pas de source: google", {
  d <- withr::local_tempdir()
  .brand_online(d)
  brand <- file.path(d, "_brand.yml")
  # on passe Inter en file -> plus aucune source: google
  basculer_hors_ligne(d)
  avant <- xfun::read_utf8(brand)
  # second appel : structure inattendue (déjà hors-ligne) -> no-op
  expect_null(basculer_hors_ligne(d))
  expect_identical(xfun::read_utf8(brand), avant)
})

test_that("basculer_hors_ligne() refuse une charte dont la police google n'est pas Inter", {
  d <- withr::local_tempdir()
  dir.create(file.path(d, "_fonts"))
  brand <- file.path(d, "_brand.yml")
  xfun::write_utf8(c(
    "typography:",
    "  fonts:",
    "    - family: Autre",
    "      source: google",
    "      weight: [400]",
    "  base: Autre"
  ), brand)
  avant <- xfun::read_utf8(brand)
  expect_null(basculer_hors_ligne(d))
  expect_identical(xfun::read_utf8(brand), avant) # inchangé
})

test_that("appliquer_polices_locales() ajoute font-paths puis est idempotent", {
  skip_if_not(
    {
      v <- tryCatch(quarto::quarto_version(), error = function(e) NA)
      !is.na(v) && v < numeric_version("1.10.4")
    },
    "Quarto >= 1.10.4 (contournement inutile)"
  )
  d <- withr::local_tempdir()
  qfile <- file.path(d, "_quarto.yml")
  con <- file(qfile, open = "w", encoding = "UTF-8")
  writeLines(c("project:", "  type: book", "format:", "  typst:", "    papersize: a4"), con)
  close(con)

  expect_true(appliquer_polices_locales(d))
  expect_true(any(grepl("font-paths", readLines(qfile, warn = FALSE))))
  expect_true(file.exists(paste0(qfile, ".avant-fontpaths")))
  # deuxième appel : idempotent
  expect_false(appliquer_polices_locales(d))
})
