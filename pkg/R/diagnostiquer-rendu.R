# Lexique d'erreurs de rendu fréquentes -> traduction FR + action.
# Réutilise les messages déjà rédigés dans `preparatifs.qmd`.
#   motif   : regex de détection (interne, jamais affiché brut)
#   desc    : description lisible du cas (affichée)
#   gravite : "benin" (PDF quand même produit) ou "bloquant"
#   message : action à mener
.lexique_rendu <- list(
  list(
    motif = "Typst executable not found",
    desc = "Typst introuvable",
    gravite = "bloquant",
    message = "Quarto < 1.9 (Typst absent). Mettez Quarto à jour (>= 1.9)."
  ),
  list(
    motif = "unknown font family",
    desc = "Police inconnue",
    gravite = "benin",
    message = paste(
      "Avertissement de police : normal pour le test (il n'utilise pas _brand.yml).",
      "Le PDF est produit avec une police de repli. Rien à corriger."
    )
  ),
  list(
    motif = "(file not found|could not find file).*(_brand|\\.ya?ml)",
    desc = "Fichier _brand.yml introuvable",
    gravite = "bloquant",
    message = "Vérifiez que _brand.yml est bien à côté de votre .qmd."
  ),
  list(
    motif = "did not find expected|mapping values are not allowed",
    desc = "Erreur de syntaxe YAML",
    gravite = "bloquant",
    message = "Vérifiez l'indentation de l'en-tête --- ou de _quarto.yml."
  )
)

#' Décoder une erreur de rendu Quarto / Typst
#'
#' Traduit en français les messages d'erreur ou d'avertissement les plus
#' fréquents lors du rendu Typst, et indique s'ils sont **bénins** (le PDF est
#' quand même produit) ou **bloquants**, avec l'action à mener.
#'
#' @param texte Le texte de l'erreur (copié depuis la console). Si `NULL`
#'   (défaut), affiche la liste de référence des cas connus.
#'
#' @return Invisiblement, un vecteur des gravités reconnues (`"benin"` /
#'   `"bloquant"`), ou `NULL` si `texte` est `NULL`. Appelée surtout pour son
#'   affichage.
#' @export
#'
#' @examples
#' diagnostiquer_rendu()
#' diagnostiquer_rendu("Error: unknown font family 'Inter'")
diagnostiquer_rendu <- function(texte = NULL) {
  lexique <- .lexique_rendu

  if (is.null(texte)) {
    cli::cli_h2("Erreurs de rendu fréquentes")
    cli::cli_ul()
    for (e in lexique) {
      etiquette <- if (e$gravite == "benin") "bénin" else "bloquant"
      cli::cli_li("{.strong {e$desc}} ({etiquette}) : {e$message}")
    }
    cli::cli_end()
    cli::cli_alert_info(
      "Passez le texte de votre erreur (entre guillemets simples) : {.code diagnostiquer_rendu('...')}."
    )
    return(invisible(NULL))
  }

  texte <- paste(texte, collapse = "\n")
  gravites <- character(0)
  for (e in lexique) {
    if (grepl(e$motif, texte, ignore.case = TRUE, perl = TRUE)) {
      gravites <- c(gravites, e$gravite)
      if (e$gravite == "benin") {
        cli::cli_alert_success("{e$desc} : {e$message}")
      } else {
        cli::cli_alert_danger("{e$desc} : {e$message}")
      }
    }
  }

  if (length(gravites) == 0) {
    cli::cli_alert_warning(
      "Erreur non reconnue. Diagnostic global : {.run tutotypst::verifier_installation()}."
    )
  } else if ("bloquant" %in% gravites) {
    # Si un cas bloquant et un cas bénin coexistent, on lève l'ambiguïté.
    cli::cli_alert_info(
      "Traitez d'abord le ou les points bloquants ci-dessus ; les avertissements bénins peuvent être ignorés."
    )
  }
  invisible(gravites)
}
