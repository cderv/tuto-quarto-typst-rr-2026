# Setup environnement (Claude Code on the web / sandbox vierge)

Référencé depuis `.claude/CLAUDE.md`. À consulter uniquement pour préparer un
sandbox vierge (R/Quarto absents). En session normale, rien à faire.

Quarto est généralement préinstallé. Pour ajouter `gh` CLI, `rig` et R :

```bash
# 1. gh CLI via apt repo officiel
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  -o /usr/share/keyrings/githubcli-archive-keyring.gpg
chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  > /etc/apt/sources.list.d/github-cli.list
apt update -qq && apt install -y gh

# 2. rig (R Installation Manager) via gh release download
cd /tmp && gh release download --repo r-lib/rig --pattern "r-rig_*_amd64.deb" --clobber
apt install -y ./r-rig_*_amd64.deb

# 3. R release courante via rig
rig add release   # installe R + pak

# 4. Quarto (si manquant) via gh release download
# gh release download --repo quarto-dev/quarto-cli --pattern "quarto-*-linux-amd64.deb" --clobber
# apt install -y ./quarto-*-linux-amd64.deb
```

> Si l'API GitHub est rate-limitée (téléchargement de rig), résoudre le tag de la
> dernière release via la page HTML : `curl -sI https://github.com/r-lib/rig/releases/latest`
> → `Location: …/tag/<vX.Y.Z>` → `…/releases/expanded_assets/<tag>` pour l'URL du `.deb`.

Outils R pour le paquet : `install.packages(c("devtools","roxygen2","rcmdcheck","covr","pkgdown"))`
(binaires P3M sur Ubuntu noble). Pour `just pkg-site` (pkgdown) en sandbox vierge :
`export RSTUDIO_PANDOC=/opt/quarto/bin/tools/x86_64` et `apt install -y libwebpmux3`
(sinon `ragg` ne charge pas).

Tester un rendu Typst end-to-end :
```bash
quarto render exercises/01-document-typst/correction/rapport-starwars.qmd
```
