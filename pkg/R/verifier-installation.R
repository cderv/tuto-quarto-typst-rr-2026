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
  etat <- function(x) if (isTRUE(x)) "v" else if (isTRUE(is.na(x))) "-" else "x"
  cli::cli_bullets(c(
    "{etat(ok_r)} R",
    "{etat(ok_q)} Quarto",
    "{etat(ok_p)} Paquets R",
    "{etat(ok_rendu)} Rendu PDF de test"
  ))

  tout_ok <- isTRUE(ok_r) && isTRUE(ok_q) && isTRUE(ok_p) &&
    (isTRUE(is.na(ok_rendu)) || isTRUE(ok_rendu))

  if (tout_ok) {
    cli::cli_alert_success(
      "Tout est prêt : .qmd -> PDF pro -> livre. Rendez-vous le 16 juin !"
    )
    cli::cli_alert_info("Pensez à avoir RStudio (récent) ouvert.")
    cli::cli_alert_info(
      "Prochaine étape : installez les exercices avec {.run tutotypst::installer_exercices()}."
    )
  } else {
    cli::cli_alert_warning(
      "Quelques points sont à corriger (voir les lignes {.strong x} ci-dessus)."
    )
  }

  invisible(tout_ok)
}
