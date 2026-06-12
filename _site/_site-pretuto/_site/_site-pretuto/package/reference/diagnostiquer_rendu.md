# Décoder une erreur de rendu Quarto / Typst

Traduit en français les messages d'erreur ou d'avertissement les plus
fréquents lors du rendu Typst, et indique s'ils sont **bénins** (le PDF
est quand même produit) ou **bloquants**, avec l'action à mener.

## Utilisation

``` r
diagnostiquer_rendu(texte = NULL)
```

## Arguments

- texte:

  Le texte de l'erreur (copié depuis la console). Si `NULL` (défaut),
  affiche la liste de référence des cas connus.

## Valeur de retour

Invisiblement, un vecteur des gravités reconnues (`"benin"` /
`"bloquant"`), ou `NULL` si `texte` est `NULL`. Appelée surtout pour son
affichage.

## Exemples

``` r
diagnostiquer_rendu()
#> 
#> ── Erreurs de rendu fréquentes ──
#> 
#> • Typst introuvable (bloquant) : Quarto < 1.9 (Typst absent). Mettez Quarto à
#> jour (>= 1.9).
#> • Police inconnue (bénin) : Avertissement de police : normal pour le test (il
#> n'utilise pas _brand.yml). Le PDF est produit avec une police de repli. Rien à
#> corriger.
#> • Fichier _brand.yml introuvable (bloquant) : Vérifiez que _brand.yml est bien
#> à côté de votre .qmd.
#> • Erreur de syntaxe YAML (bloquant) : Vérifiez l'indentation de l'en-tête ---
#> ou de _quarto.yml.
#> ℹ Passez le texte de votre erreur (entre guillemets simples) : `diagnostiquer_rendu('...')`.
diagnostiquer_rendu("Error: unknown font family 'Inter'")
#> ✔ Police inconnue : Avertissement de police : normal pour le test (il n'utilise pas _brand.yml). Le PDF est produit avec une police de repli. Rien à corriger.
```
