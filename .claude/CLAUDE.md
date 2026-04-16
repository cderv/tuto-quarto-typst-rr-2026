# CLAUDE.md - Workshop RR 2026

## Qui suis-je

Christophe Dervieux, ingénieur open-source à Posit (R Markdown, Quarto). Co-animation avec Maëlle Salmon (rOpenSci). Je pilote le programme, Maëlle donne du feedback.

## Le projet

Site Quarto pour un tutoriel de 2h aux Rencontres R 2026 (16 juin, Nantes). Contenu en français. Focus Quarto+Typst (pas Typst standalone).

**Arc :** `.qmd` → PDF pro → livre → personnalisé/pérennisé

## Build

- `quarto preview` / `quarto render` → `_site/`
- Requiert Quarto 1.9+

## Règles critiques

- Pages web : `format: html` dans le YAML (obligatoire, sinon conflit multi-format)
- Slides : `format: clean-revealjs` (hérite config de `_quarto.yml`)
- Countdown : `{{< countdown 05:00 >}}` (extension Quarto, pas le package R)
- Toujours `author: ""` et `date: ""` sur les pages web (pas les slides)
- Toujours `fig-alt` sur les images

## Références

- Détails techniques, URLs, content patterns → `.claude/references/project-context.md`
- Skill pour créer du contenu → `.claude/skills/workshop-content.md`
- Skill Quarto authoring (Posit) → `.claude/skills/quarto-authoring.md`
- Skill alt text pour figures → `.claude/skills/quarto-alt-text.md`
- Skill brand.yml (Posit) → `.claude/skills/brand-yml.md`
