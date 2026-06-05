#' Vérifier que votre environnement est prêt pour le tutoriel
#'
#' Contrôle, dans l'ordre, votre version de R, la présence et la version de
#' Quarto, les paquets R prérequis, puis (par défaut) effectue un **rendu de
#' test** d'un mini-document Typst pour valider la chaîne complète
#' R -> Quarto -> Typst -> `gt` -> `ggplot2`. Affiche un bilan et la prochaine
#' étape conseillée.
#'
#' Le rendu de test utilise un fichier `format: typst` volontairement minimal
#' (sans `_brand.yml` ni polices) : il valide la chaîne de compilation, mais
#' pas la chaîne des polices de marque (le vrai point d'attention de
#' l'exercice 2). Il fonctionne hors-ligne.
#'
#' @param tester_rendu Logique. Effectuer le rendu de test Typst ? Activé par
#'   défaut. Mettez `FALSE` pour un contrôle rapide sans rendu.
#'
#' @return Invisiblement, `TRUE` si tout est prêt, `FALSE` sinon.
#' @export
#'
#' @examplesIf interactive()
#' verifier_installation()
#' verifier_installation(tester_rendu = FALSE)
verifier_installation <- function(tester_rendu = TRUE) {
  cli::cli_h1("Vérification de votre installation")

  ok_r <- verifier_r()
  ok_q <- verifier_quarto()
  ok_p <- verifier_paquets()
  ok_rendu <- if (isTRUE(ok_q)) {
    verifier_rendu(tester_rendu)
  } else {
    cli::cli_alert_info("Rendu de test sauté (Quarto indisponible).")
    NA
  }

  cli::cli_h2("Bilan")
  # Les noms du vecteur pilotent le symbole cli : v = succès (✓), x = échec (✗),
  # ! = avertissement / non testé (⚠).
  marque <- function(x) if (isTRUE(x)) "v" else if (isTRUE(is.na(x))) "!" else "x"
  bilan <- c("R", "Quarto", "Paquets R", "Rendu PDF de test")
  names(bilan) <- vapply(list(ok_r, ok_q, ok_p, ok_rendu), marque, character(1))
  cli::cli_bullets(bilan)

  tout_ok <- isTRUE(ok_r) && isTRUE(ok_q) && isTRUE(ok_p) &&
    (isTRUE(is.na(ok_rendu)) || isTRUE(ok_rendu))

  if (tout_ok) {
    cli::cli_alert_success(
      "Tout est prêt : .qmd → PDF pro → livre → à personnaliser. Rendez-vous le 16 juin !"
    )
    cli::cli_alert_info("Le jour J, pensez à ouvrir RStudio ou Positron (récent).")
    cli::cli_alert_info(
      "Prochaine étape : installez les exercices avec {.run tutoquartotypst::installer_exercices()}."
    )
  } else {
    cli::cli_alert_warning(
      "Quelques points sont à corriger (lignes marquées ✗ ci-dessus)."
    )
  }

  invisible(tout_ok)
}
