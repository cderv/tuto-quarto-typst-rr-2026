# Installer les exercices du tutoriel

Copie les fichiers de départ (« starters ») des exercices, embarqués
dans le paquet, vers un dossier de travail local. Seuls les `starter/`
sont copiés ; les corrections ne sont pas posées ici (voir
[`ouvrir_correction()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/ouvrir_correction.md)
pour les consulter en ligne,
[`recuperer_correction()`](https://connect.posit.cloud/cderv/content/019df82c-7202-2165-28ea-7f9ca734ad26/package/reference/recuperer_correction.md)
pour les copier en local).

## Utilisation

``` r
installer_exercices(dest = NULL, quels = c("tous", "01", "02"), force = FALSE)
```

## Arguments

- dest:

  Chemin du dossier de destination (créé si besoin). Par défaut `NULL` :
  en session interactive, le dossier est **demandé** (sélecteur RStudio
  si disponible, sinon invite texte ; valeur proposée
  `"exercices-typst"`). Fournir un chemin explicite court-circuite la
  demande (utile en script). En mode non-interactif sans `dest`,
  `"exercices-typst"` (dans le répertoire courant) est utilisé.

- quels:

  Quels exercices installer : `"tous"` (défaut), `"01"` (document Typst)
  ou `"02"` (projet livre).

- force:

  Logique. Passer la confirmation interactive **et** écraser un dossier
  de destination déjà existant et non vide ? Par défaut `FALSE` (en mode
  non-interactif, `force = TRUE` est requis pour confirmer la copie).

## Valeur de retour

Invisiblement, le chemin absolu du dossier de destination, ou `NULL` si
l'installation a été annulée.

## Exemples

``` r
if (FALSE) { # interactive()
installer_exercices()
installer_exercices(quels = "01")
}
```
