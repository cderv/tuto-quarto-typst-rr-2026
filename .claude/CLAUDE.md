# CLAUDE.md - Workshop RR 2026

## Qui suis-je

Christophe Dervieux, ingénieur open-source à Posit (R Markdown, Quarto). Co-animation avec Maëlle Salmon (rOpenSci). Je pilote le programme, Maëlle donne du feedback.

## Le projet

Site Quarto pour un tutoriel de 2h aux Rencontres R 2026 (16 juin, Nantes). Contenu en français. Focus Quarto+Typst (pas Typst standalone).

**Arc :** `.qmd` → PDF pro → livre → personnalisé/pérennisé

**Structure :** 2 blocs avec rythme My turn → Our turn → Your turn + pépites "Saviez-vous que..."

## Build

- `quarto preview` / `quarto render` → `_site/`
- Requiert Quarto 1.9+

## Setup environnement (Claude Code on the web / sandbox vierge)

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

Tester un rendu Typst end-to-end :
```bash
quarto render exercises/01-document-typst/correction/rapport-starwars.qmd
```

## Règles critiques

- Pages web : `format: html` dans le YAML (obligatoire, sinon conflit multi-format)
- Slides : `format: clean-revealjs` (hérite config de `_quarto.yml`)
- Countdown : `{{< countdown 15:00 >}}` (extension Quarto, pas le package R)
- Toujours `author: ""` et `date: ""` sur les pages web (pas les slides)
- Toujours `fig-alt` sur les images

## Conventions slides (My turn / Our turn / Your turn)

- **My turn** : slides normales, pas de callout spécial
- **Our turn** : callout `.callout-tip` avec titre "Faisons ensemble !"
- **Your turn** : callout par défaut avec titre "À vous !" + countdown
- **Pépites** : callout `.callout-note` avec titre "Saviez-vous que..."
- Background couleur : `{background-color="#27ae60"}` pour Our turn, `{background-color="#FDC538"}` pour Your turn

## Références

- Plan de travail → `.claude/PLAN.md`
- Détails techniques, URLs, content patterns → `.claude/references/project-context.md`
- Skill pour créer du contenu → `.claude/skills/workshop-content.md`
- Skill Quarto authoring (Posit) → `.claude/skills/quarto-authoring.md`
- Skill alt text pour figures → `.claude/skills/quarto-alt-text.md`
- Skill brand.yml (Posit) → `.claude/skills/brand-yml.md`

## Reviews

Les rapports de review générés par les agents vont dans `.claude/reviews/`.

Convention de nommage : `.claude/reviews/review-YYYY-MM-DD[-tag]-[type].md`
- `[tag]` optionnel : `bis`, `ter`, `quater`, … pour plusieurs reviews le même jour
- `[type]` : `pedagogue`, `eleve-debutant`, `quarto-technique`, `orthographe-fr`, `content`

Agents disponibles dans `.claude/agents/` : `workshop-reviewer-pedagogue`, `workshop-reviewer-debutant`, `workshop-reviewer-technique`, `workshop-reviewer-fr`.
