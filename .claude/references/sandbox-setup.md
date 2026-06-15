# Setup environnement (Claude Code on the web / sandbox vierge)

Référencé depuis `.claude/CLAUDE.md`. À consulter uniquement pour préparer un
sandbox vierge (R/Quarto absents ou incomplets). En session normale, rien à faire.

> **Le conteneur est éphémère** : tout ce setup (paquets, `~/.Rprofile`,
> locale) disparaît avec le conteneur. À rejouer sur un nouveau sandbox.

## 0. Deux pièges du sandbox à corriger d'abord (sinon R casse)

Ces deux points ne sont **pas** dans l'image par défaut et bloquent
l'installation de paquets R + la lecture des fichiers accentués :

```bash
# a) Locale : l'image démarre en C/POSIX → la lecture des .yml/.qmd UTF-8
#    accentués casse (erreur "invalid input"/scanner YAML sur _brand-*.yml).
printf '\nexport LANG=C.UTF-8\nexport LC_ALL=C.UTF-8\n' >> ~/.bashrc
printf '\nexport LANG=C.UTF-8\nexport LC_ALL=C.UTF-8\n' >> ~/.profile
printf 'LANG=C.UTF-8\nLC_ALL=C.UTF-8\n' > /etc/environment
export LANG=C.UTF-8 LC_ALL=C.UTF-8   # pour le shell courant

# b) Proxy à CA auto-signée : le curl de base R ne trouve aucun paquet
#    ("SSL: self signed certificate in certificate chain"). Le bundle système
#    /etc/ssl/certs/ca-certificates.crt contient bien la CA du proxy (le curl
#    CLI vérifie OK) ; il faut le pointer à R + activer les binaires P3M noble.
update-ca-certificates   # merge les CA de /usr/local/share/ca-certificates/
cat > ~/.Rprofile <<'RPROF'
local({
  ca <- "/etc/ssl/certs/ca-certificates.crt"
  if (file.exists(ca)) Sys.setenv(CURL_CA_BUNDLE = ca, SSL_CERT_FILE = ca)
  options(
    repos = c(P3M = "https://packagemanager.posit.co/cran/__linux__/noble/latest"),
    # User-Agent qui déclenche le service de binaires P3M pour Ubuntu noble
    HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
      paste(getRversion(), R.version$platform, R.version$arch, R.version$os)),
    Ncpus = max(1L, parallel::detectCores())
  )
})
RPROF
```

> ⚠️ **pak ne fonctionne pas** dans ce sandbox : son libcurl embarqué ignore le
> `CURL_CA_BUNDLE` et refuse la CA du proxy. Le `curl` de base R, lui, l'honore.
> Donc : utiliser `install.packages()` / `devtools::install()` / `load_all()`,
> **pas** `pak::pak(...)`. (Le build et les tests n'utilisent pas pak.)

## 1. Outils système : gh, rig, R, just

```bash
# gh CLI via apt repo officiel
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  -o /usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  > /etc/apt/sources.list.d/github-cli.list
apt update -qq && apt install -y gh
# NB : gh n'est PAS authentifié ici (GitHub passe par MCP). `gh release download`
# échoue (401) → utiliser le fallback "atom/HTML" ci-dessous pour récupérer un .deb.

# rig (R Installation Manager) — fallback sans gh auth :
cd /tmp
tag=$(curl -sI https://github.com/r-lib/rig/releases/latest | tr -d '\r' \
  | awk -F'tag/' 'tolower($1)~/^location:/{gsub(/[[:space:]]/,"",$2);print $2}')
asset=$(curl -s "https://github.com/r-lib/rig/releases/expanded_assets/$tag" \
  | grep -oE "/r-lib/rig/releases/download/[^\"]*r-rig_[^\"]*_amd64\.deb" | head -1)
curl -fsSL -o /tmp/r-rig_amd64.deb "https://github.com$asset"
apt install -y /tmp/r-rig_amd64.deb

# R release courante via rig (installe R + pak)
rig add release

# just : la version apt (noble = 1.21) est TROP VIEILLE pour le justfile
# (attribut [group(...)] requiert just >= 1.27). Installer le binaire GitHub :
cd /tmp
tag=$(curl -sI https://github.com/casey/just/releases/latest | tr -d '\r' \
  | awk -F'tag/' 'tolower($1)~/^location:/{gsub(/[[:space:]]/,"",$2);print $2}')
asset=$(curl -s "https://github.com/casey/just/releases/expanded_assets/$tag" \
  | grep -oE "/casey/just/releases/download/[^\"]*x86_64-unknown-linux-musl\.tar\.gz" | head -1)
curl -fsSL "https://github.com$asset" -o just.tar.gz
tar -xzf just.tar.gz -C /usr/local/bin just
```

## 2. Quarto pre-release (≥ 1.10.7 recommandé)

Quarto peut être préinstallé en version trop ancienne (ex. 1.9.x). Le doc projet
recommande la pre-release la plus récente (fix polices book depuis 1.10.4). La
1re entrée de l'atom feed = la version la plus récente (souvent une pre-release) :

```bash
cd /tmp
tag=$(curl -s https://github.com/quarto-dev/quarto-cli/releases.atom \
  | grep -oE 'releases/tag/v[0-9.]+' | sed 's#releases/tag/##' | head -1)
curl -fsSL -o "quarto-${tag#v}.deb" \
  "https://github.com/quarto-dev/quarto-cli/releases/download/$tag/quarto-${tag#v}-linux-amd64.deb"
apt install -y "/tmp/quarto-${tag#v}.deb"   # ~147 Mo
quarto --version && quarto typst --version
```

## 3. Outils R pour le paquet (binaires P3M, rapides)

```bash
# Dev tooling
Rscript -e 'install.packages(c("devtools","roxygen2","rcmdcheck","covr","pkgdown","testthat"))'
# Dépendances du paquet local (Imports + Suggests)
Rscript -e 'pkgs <- c("brand.yml","cli","dplyr","ggplot2","ggrepel","gt","prismatic","quarto","rlang","scales","withr","xfun","yaml","rstudioapi"); install.packages(pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly=TRUE)])'
```

Pour `just pkg-site` (pkgdown) en sandbox vierge : `export RSTUDIO_PANDOC=/opt/quarto/bin/tools/x86_64`
et `apt install -y libwebpmux3` (sinon `ragg` ne charge pas).

## 4. Vérifications end-to-end

```bash
# Tests du paquet (NOT_CRAN=true pour activer les snapshots)
NOT_CRAN=true Rscript -e 'devtools::load_all("pkg", quiet=TRUE); testthat::test_dir("pkg/tests/testthat", reporter="summary")'

# Rendu Typst (warnings "unknown font family" = polices Inter/Segoe absentes, non bloquant)
quarto render exercises/01-document-typst/correction/rapport-starwars.qmd

# Chaîne build / sync
just pkg-sync-check   # doit afficher "[OK] pkg/inst est synchronise"
```
