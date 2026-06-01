# Helpers de test (sourcés automatiquement par testthat).

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
