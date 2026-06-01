# Helpers de test (sourcés automatiquement par testthat).

# Saute le test si le binaire Quarto n'est pas disponible.
skip_if_no_quarto <- function() {
  testthat::skip_if_not(
    !is.null(tryCatch(quarto::quarto_path(), error = function(e) NULL)),
    "Quarto introuvable"
  )
}
