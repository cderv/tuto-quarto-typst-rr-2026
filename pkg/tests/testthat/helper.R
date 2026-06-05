# Helpers de test (sourcés automatiquement par testthat).

# --- Silence du bruit cli pendant les tests ------------------------------------
# Les fonctions exportées sont volontairement bavardes (messages cli FR à
# destination des participant·es). Ce flot n'apporte rien à la sortie de
# `devtools::test()` et la rend illisible. On route donc les messages NON
# capturés vers nulle part, pour toute la session de test.
#
# Sans effet sur les assertions : `expect_message()` / `expect_snapshot()`
# capturent la condition `message` (cli l'émet comme telle) AVANT impression
# — via le restart `muffleMessage` — donc elles restent pleinement
# fonctionnelles. Les warnings/erreurs ne passent pas par ce canal : ils
# continuent d'être comptés et rapportés par testthat.
local({
  .con_nul <- file(nullfile(), open = "wt")
  sink(.con_nul, type = "message")
  withr::defer(
    {
      sink(type = "message")
      close(.con_nul)
    },
    envir = testthat::teardown_env()
  )
})

# Saute le test si le binaire Quarto n'est pas disponible.
skip_if_no_quarto <- function() {
  testthat::skip_if_not(
    !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL)),
    "Quarto introuvable"
  )
}

# Saute le test si Quarto est assez récent (>= seuil recommandé) : utile pour les
# tests du contournement `font-paths`, sans objet sur Quarto récent.
skip_if_quarto_recent <- function() {
  v <- tryCatch(quarto::quarto_version(), error = function(e) NA)
  testthat::skip_if(
    length(v) == 1 && !is.na(v) && v >= .quarto_reco,
    "Quarto >= seuil recommandé (contournement font-paths inutile)"
  )
}
