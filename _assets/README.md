# `_assets/` — sources de la carte Open Graph

Vignette affichée quand on partage un lien du site sur les réseaux
(LinkedIn, Bluesky, Slack…). Sans elle, ces plateformes prennent la
première image de la page — ici le logo CC BY, peu parlant.

Le dossier est préfixé `_` : Quarto l'ignore au render. La PNG publiée
(`og-card.png`, à la racine) est déclarée dans `_quarto.yml`
(`website.image` + `resources`) et copiée dans `_site/`.

Format : **1200×630** (ratio ~1.91:1). Rendu en **2400×1260** (×2 retina).

## Deux sources, même rendu

| Fichier | Outil | Note |
|---|---|---|
| `og-card.html` + `render-card.js` | HTML + Playwright | **source de la PNG publiée** |
| `og-card.typ` | Typst | variante méta-cohérente avec l'atelier |

La police **Atkinson Hyperlegible** (celle du site) est vendorisée dans
`fonts/` (licence OFL) pour un rendu reproductible hors-ligne.

## Régénérer

PNG publiée (version HTML) :

```sh
npx playwright install chromium   # une fois
NODE_PATH=/opt/node22/lib/node_modules node _assets/render-card.js
# -> og-card.png à la racine
```

Variante Typst (sortie ailleurs pour comparer) :

```sh
quarto typst compile --root . --font-path _assets/fonts \
  --ppi 144 _assets/og-card.typ _assets/og-card-typst.png
```

## Après mise à jour de la carte

Republier le site, puis forcer le re-scrape des plateformes qui cachent
l'aperçu : <https://www.linkedin.com/post-inspector/>.
