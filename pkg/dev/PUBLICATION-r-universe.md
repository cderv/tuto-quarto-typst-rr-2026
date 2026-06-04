# Publier `tutoquartotypst` sur r-universe — guide pas-à-pas

Objectif : rendre `install.packages("tutoquartotypst", repos = c("https://cderv.r-universe.dev", ...))`
fonctionnel pour les participants. Le paquet vit dans le sous-dossier `pkg/` de ce
repo ; r-universe le build via le champ `subdir`.

Durée : ~10 min de setup, puis ~15-30 min d'attente du premier build.

---

## 1. Créer le repo de registre `cderv.r-universe.dev`

Sur le compte GitHub **`cderv`**, créer un nouveau repo **public** nommé exactement :

```
cderv.r-universe.dev
```

(le nom du repo = `<votre-univers>.r-universe.dev`).

À la racine de ce repo, ajouter un fichier **`packages.json`** dont le contenu est
déjà prêt ici : [`pkg/dev/packages.json`](packages.json). Copier-coller :

```json
[
  {
    "package": "tutoquartotypst",
    "url": "https://github.com/cderv/tuto-quarto-typst-rr-2026",
    "subdir": "pkg"
  }
]
```

Commit + push sur la branche par défaut.

> En CLI :
> ```bash
> gh repo create cderv/cderv.r-universe.dev --public --clone
> cd cderv.r-universe.dev
> cp /chemin/vers/pkg/dev/packages.json .
> git add packages.json && git commit -m "Add tutoquartotypst" && git push
> ```

## 2. Installer l'app GitHub r-universe

Aller sur <https://github.com/apps/r-universe> → **Install** → choisir le compte
`cderv` → autoriser l'accès (au minimum au repo `cderv.r-universe.dev` ; l'accès
au repo source `cderv-tuto-quarto-typst-rr-2026` est public donc pas requis, mais
l'autoriser ne gêne pas).

C'est l'app qui déclenche les builds quand `packages.json` change ou quand le repo
source est mis à jour.

## 3. Attendre et vérifier le build

- Tableau de bord : <https://cderv.r-universe.dev/builds>
- Page du paquet : <https://cderv.r-universe.dev/tutoquartotypst>

Le premier build prend quelques dizaines de minutes (compilation des binaires
Linux/Windows/macOS). r-universe installe automatiquement les dépendances
(`Imports`) — rien à déclarer de plus.

⚠ Attendu : la **NOTE** « Namespaces in Imports not imported from » (les paquets du
tutoriel tirés mais non appelés par le code) et le **WARNING** non-ASCII (accents
français) apparaîtront dans le check r-universe. **C'est volontaire** (cf.
`.claude/CLAUDE.md`) — le paquet n'est pas destiné au CRAN. Seul un statut « build
failed » serait à corriger.

## 4. Tester l'installation

Sur une machine (ou un conteneur) avec R, sans le paquet installé :

```r
install.packages(
  "tutoquartotypst",
  repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org")
)
tutoquartotypst::verifier_installation()
```

C'est la commande exacte déjà présente dans `preparatifs.qmd`.

## 5. Mises à jour ultérieures

- **Nouveau code du paquet** : push sur `main` de
  `cderv-tuto-quarto-typst-rr-2026` → r-universe rebuild automatiquement (l'app
  surveille le repo source).
- **Forcer un rebuild** : sur <https://cderv.r-universe.dev/builds>, bouton de
  re-trigger, ou un commit vide sur `cderv.r-universe.dev`.
- **Retirer le paquet** : éditer `packages.json` (retirer l'entrée) et push.

## 6. (Optionnel) Lien doc / pkgdown

Le site pkgdown est publié par le site Quarto du tutoriel sous `/package`
(via `just pkg-site` + `resources: package/**`), **indépendamment** de r-universe.
r-universe génère aussi sa propre page paquet (étape 3) ; les deux coexistent.

---

### Aide-mémoire des fichiers concernés (dans ce repo)

| Fichier | Rôle |
|---|---|
| `pkg/dev/packages.json` | contenu à copier dans le repo de registre |
| `pkg/DESCRIPTION` (`subdir` implicite) | `url`/`BugReports` du paquet |
| `preparatifs.qmd` | commande d'install montrée aux participants |
| `.claude/CLAUDE.md` § « Publication r-universe » | rappel synthétique |
