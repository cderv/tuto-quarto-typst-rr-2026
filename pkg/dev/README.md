# pkg/dev/ — fichiers de référence (hors build)

Ce dossier est **exclu du paquet** via `.Rbuildignore` (`^dev$`). Il ne contient
pas de code du paquet, seulement des aides au mainteneur.

## `packages.json`

Contenu à placer **tel quel** à la racine du repo **séparé**
`cderv/cderv.r-universe.dev` (PAS dans ce repo-ci), pour publier `tutoquartotypst` sur
r-universe depuis le sous-dossier `pkg/`.

Étapes : voir `.claude/CLAUDE.md` → « Publication r-universe ».
