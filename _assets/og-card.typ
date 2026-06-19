// Carte Open Graph (1200x630) du site du tutoriel — dessinee en Typst,
// meta-coherent avec l'atelier Quarto+Typst.
//
// Rendu (depuis la racine du depot) :
//   quarto typst compile --root . --font-path _assets/fonts \
//     --ppi 144 _assets/og-card.typ og-card.png
//
// --ppi 144 sur une page de 1200pt x 630pt => PNG 2400x1260 (retina, ratio LinkedIn).

#set page(width: 1200pt, height: 630pt, margin: 0pt, fill: rgb("#FDC538"))
#set text(font: "Atkinson Hyperlegible", fill: rgb("#111111"))
#set par(spacing: 0pt, leading: 0.6em)

#let jaune = rgb("#FDC538")

#align(center + horizon)[
  #box(width: 1120pt, height: 550pt, radius: 28pt, fill: white, clip: true,
    grid(
      columns: (1.35fr, 1fr),
      rows: (550pt,),
      // ---- Colonne gauche : le texte ----
      block(width: 100%, height: 100%,
        inset: (left: 60pt, right: 46pt, top: 54pt, bottom: 46pt),
        [
          #grid(columns: (auto, auto), column-gutter: 12pt, align: horizon,
            circle(radius: 8pt, fill: jaune),
            text(size: 24pt, weight: 700, tracking: 0.6pt)[TUTORIEL · RENCONTRES R 2026],
          )
          #v(28pt)
          #text(size: 70pt, weight: 700)[PDF sans\ frictions]
          #v(14pt)
          #text(size: 35pt, weight: 700, fill: rgb("#444444"))[Typst dans vos projets Quarto]
          #v(36pt)
          #grid(columns: (auto, auto), column-gutter: 14pt, align: horizon,
            box(fill: jaune, radius: 999pt, inset: (x: 22pt, y: 9pt),
              text(size: 24pt, weight: 700)[Quarto]),
            box(fill: black, radius: 999pt, inset: (x: 22pt, y: 9pt),
              text(size: 24pt, weight: 700, fill: white)[Typst]),
          )
          #v(26pt)
          #text(size: 26pt, weight: 700)[Christophe Dervieux & Maëlle Salmon]
          #v(8pt)
          #text(size: 22pt, fill: rgb("#666666"))[cderv.github.io/tuto-quarto-typst-rr-2026]
        ],
      ),
      // ---- Colonne droite : la charte en vignette ----
      box(width: 100%, height: 100%,
        fill: gradient.linear(jaune, rgb("#F0B400"), angle: 45deg),
        align(center + horizon,
          rotate(3deg,
            box(radius: 8pt, clip: true, stroke: 0.5pt + luma(210),
              image("/1-quarto-typst/charte-starwars.png", width: 300pt)),
          ),
        ),
      ),
    ),
  )
]
