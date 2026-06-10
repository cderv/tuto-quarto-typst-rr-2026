# Vérifier que votre environnement est prêt pour le tutoriel

Contrôle, dans l'ordre, votre version de R, la présence et la version de
Quarto, les paquets R prérequis, puis (par défaut) effectue un **rendu
de test** d'un mini-document Typst pour valider la chaîne complète R -\>
Quarto -\> Typst -\> `gt` -\> `ggplot2`. Affiche un bilan et la
prochaine étape conseillée.

## Utilisation

``` r
verifier_installation(tester_rendu = TRUE)
```

## Arguments

- tester_rendu:

  Logique. Effectuer le rendu de test Typst ? Activé par défaut. Mettez
  `FALSE` pour un contrôle rapide sans rendu.

## Valeur de retour

Invisiblement, `TRUE` si tout est prêt, `FALSE` sinon.

## Détails

Le rendu de test utilise un fichier `format: typst` volontairement
minimal (sans `_brand.yml` ni polices) : il valide la chaîne de
compilation, mais pas la chaîne des polices de marque (le vrai point
d'attention de l'exercice 2). Il fonctionne hors-ligne.

## Exemples

``` r
if (FALSE) { # interactive()
verifier_installation()
verifier_installation(tester_rendu = FALSE)
}
```
